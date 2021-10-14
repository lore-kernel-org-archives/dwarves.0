Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244F7C433EF
	for <linux-dwarves@archiver.kernel.org>; Thu, 14 Oct 2021 11:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C66F610CB
	for <linux-dwarves@archiver.kernel.org>; Thu, 14 Oct 2021 11:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbhJNLvO (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 14 Oct 2021 07:51:14 -0400
Received: from foss.arm.com ([217.140.110.172]:53768 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231295AbhJNLvN (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Thu, 14 Oct 2021 07:51:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE2A91480;
        Thu, 14 Oct 2021 04:49:01 -0700 (PDT)
Received: from e126130.arm.com (unknown [10.57.25.230])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 098EF3F70D;
        Thu, 14 Oct 2021 04:49:00 -0700 (PDT)
From:   Douglas RAILLARD <douglas.raillard@arm.com>
To:     acme@redhat.com
Cc:     dwarves@vger.kernel.org, douglas.raillard@arm.com
Subject: [PATCH 2/2] btf_loader.c: Infer alignment info
Date:   Thu, 14 Oct 2021 12:48:50 +0100
Message-Id: <20211014114850.310575-2-douglas.raillard@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211014114850.310575-1-douglas.raillard@arm.com>
References: <20211014114850.310575-1-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

From: Douglas Raillard <douglas.raillard@arm.com>

BTF does not carry alignment information, but it carries the offset in
structs. This allows inferring the original alignment, yielding a C
header dump that is not identical to the original C code, but is
guaranteed to lead to the same memory layout.

This allows using the output of pahole in another program to poke at
memory, with the assurance that we will not read garbage.

Note: Since the alignment is inferred from the offset, it sometimes
happens that the offset was already correctly aligned, which means the
inferred alignment will be smaller than in the original source. This
does not impact the ability to read existing structs, but it could
impact creating such struct if other client code expects higher
alignment than the one exposed in the generated header.

Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
---
 btf_loader.c | 66 ++++++++++++++++++++++++++++++++++++++++------------
 dwarves.c    |  2 +-
 dwarves.h    |  2 ++
 3 files changed, 54 insertions(+), 16 deletions(-)

diff --git a/btf_loader.c b/btf_loader.c
index 3e5a945..54353d7 100644
--- a/btf_loader.c
+++ b/btf_loader.c
@@ -471,10 +471,37 @@ static int btf__load_sections(struct btf *btf, struct cu *cu)
 	return btf__load_types(btf, cu);
 }
 
+static uint32_t class__infer_alignment(uint32_t byte_offset,
+				       uint32_t natural_alignment,
+				       uint32_t smallest_offset)
+{
+	uint32_t alignment = 0;
+	uint32_t offset_delta = byte_offset - smallest_offset;
+
+	if (offset_delta) {
+		if (byte_offset % 2 == 0) {
+			/* Find the power of 2 immediately higher than
+			 * offset_delta
+			 */
+			alignment = 1 << (8 * sizeof(offset_delta) -
+					      __builtin_clz(offset_delta));
+		} else {
+			alignment = 0;
+		}
+	}
+
+	/* Natural alignment, nothing to do */
+	if (alignment <= natural_alignment || alignment == 1)
+		alignment = 0;
+
+	return alignment;
+}
+
 static int class__fixup_btf_bitfields(struct tag *tag, struct cu *cu)
 {
 	struct class_member *pos;
 	struct type *tag_type = tag__type(tag);
+	uint32_t smallest_offset = 0;
 
 	type__for_each_data_member(tag_type, pos) {
 		struct tag *type = tag__strip_typedefs_and_modifiers(&pos->tag, cu);
@@ -486,31 +513,39 @@ static int class__fixup_btf_bitfields(struct tag *tag, struct cu *cu)
 		pos->byte_size = tag__size(type, cu);
 		pos->bit_size = pos->byte_size * 8;
 
-		/* bitfield fixup is needed for enums and base types only */
-		if (type->tag != DW_TAG_base_type && type->tag != DW_TAG_enumeration_type)
-			continue;
-
 		/* if BTF data is incorrect and has size == 0, skip field,
 		 * instead of crashing */
 		if (pos->byte_size == 0) {
 			continue;
 		}
 
-		if (pos->bitfield_size) {
-			/* bitfields seem to be always aligned, no matter the packing */
-			pos->byte_offset = pos->bit_offset / pos->bit_size * pos->bit_size / 8;
-			pos->bitfield_offset = pos->bit_offset - pos->byte_offset * 8;
-			/* re-adjust bitfield offset if it is negative */
-			if (pos->bitfield_offset < 0) {
-				pos->bitfield_offset += pos->bit_size;
-				pos->byte_offset -= pos->byte_size;
-				pos->bit_offset = pos->byte_offset * 8 + pos->bitfield_offset;
+		/* bitfield fixup is needed for enums and base types only */
+		if (type->tag == DW_TAG_base_type || type->tag == DW_TAG_enumeration_type) {
+			if (pos->bitfield_size) {
+				/* bitfields seem to be always aligned, no matter the packing */
+				pos->byte_offset = pos->bit_offset / pos->bit_size * pos->bit_size / 8;
+				pos->bitfield_offset = pos->bit_offset - pos->byte_offset * 8;
+				/* re-adjust bitfield offset if it is negative */
+				if (pos->bitfield_offset < 0) {
+					pos->bitfield_offset += pos->bit_size;
+					pos->byte_offset -= pos->byte_size;
+					pos->bit_offset = pos->byte_offset * 8 + pos->bitfield_offset;
+				}
+			} else {
+				pos->byte_offset = pos->bit_offset / 8;
 			}
-		} else {
-			pos->byte_offset = pos->bit_offset / 8;
 		}
+
+		pos->alignment = class__infer_alignment(pos->byte_offset,
+							tag__natural_alignment(type, cu),
+							smallest_offset);
+		smallest_offset = pos->byte_offset + pos->byte_size;
 	}
 
+	tag_type->alignment = class__infer_alignment(tag_type->size,
+						     tag__natural_alignment(tag, cu),
+						     smallest_offset);
+
 	return 0;
 }
 
@@ -519,6 +554,7 @@ static int cu__fixup_btf_bitfields(struct cu *cu)
 	int err = 0;
 	struct tag *pos;
 
+
 	list_for_each_entry(pos, &cu->tags, node)
 		if (tag__is_struct(pos) || tag__is_union(pos)) {
 			err = class__fixup_btf_bitfields(pos, cu);
diff --git a/dwarves.c b/dwarves.c
index b6f2489..bb8af5b 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -1515,7 +1515,7 @@ void class__find_holes(struct class *class)
 
 static size_t type__natural_alignment(struct type *type, const struct cu *cu);
 
-static size_t tag__natural_alignment(struct tag *tag, const struct cu *cu)
+size_t tag__natural_alignment(struct tag *tag, const struct cu *cu)
 {
 	size_t natural_alignment = 1;
 
diff --git a/dwarves.h b/dwarves.h
index 30d33fa..c2fea0a 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -1002,6 +1002,8 @@ struct type {
 
 void __type__init(struct type *type);
 
+size_t tag__natural_alignment(struct tag *tag, const struct cu *cu);
+
 static inline struct class *type__class(const struct type *type)
 {
 	return (struct class *)type;
-- 
2.25.1

