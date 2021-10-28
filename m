Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61DFC433F5
	for <linux-dwarves@archiver.kernel.org>; Thu, 28 Oct 2021 12:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEB0660FC0
	for <linux-dwarves@archiver.kernel.org>; Thu, 28 Oct 2021 12:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhJ1M3z (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 28 Oct 2021 08:29:55 -0400
Received: from foss.arm.com ([217.140.110.172]:54314 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230368AbhJ1M3y (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Thu, 28 Oct 2021 08:29:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE9111063;
        Thu, 28 Oct 2021 05:27:27 -0700 (PDT)
Received: from e126130.arm.com (unknown [10.57.46.169])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DDA0E3F5A1;
        Thu, 28 Oct 2021 05:27:26 -0700 (PDT)
From:   Douglas RAILLARD <douglas.raillard@arm.com>
To:     acme@redhat.com
Cc:     dwarves@vger.kernel.org, douglas.raillard@arm.com
Subject: [PATCH v3 2/6] btf_loader.c: Refactor class__fixup_btf_bitfields
Date:   Thu, 28 Oct 2021 13:27:06 +0100
Message-Id: <20211028122710.881181-3-douglas.raillard@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211028122710.881181-1-douglas.raillard@arm.com>
References: <20211028122710.881181-1-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

From: Douglas Raillard <douglas.raillard@arm.com>

Refactor class__fixup_btf_bitfields to remove a "continue" statement, to
prepare the ground for alignment fixup that is relevant for some types
matching:

    type->tag != DW_TAG_base_type && type->tag != DW_TAG_enumeration_type

Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
---
 btf_loader.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/btf_loader.c b/btf_loader.c
index 3e5a945..9c2daee 100644
--- a/btf_loader.c
+++ b/btf_loader.c
@@ -486,28 +486,27 @@ static int class__fixup_btf_bitfields(struct tag *tag, struct cu *cu)
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
 	}
 
-- 
2.25.1

