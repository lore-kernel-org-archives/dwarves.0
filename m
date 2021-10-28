Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8871AC433EF
	for <linux-dwarves@archiver.kernel.org>; Thu, 28 Oct 2021 12:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E71A61037
	for <linux-dwarves@archiver.kernel.org>; Thu, 28 Oct 2021 12:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhJ1MaA (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 28 Oct 2021 08:30:00 -0400
Received: from foss.arm.com ([217.140.110.172]:54332 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230370AbhJ1M36 (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Thu, 28 Oct 2021 08:29:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DCCB106F;
        Thu, 28 Oct 2021 05:27:31 -0700 (PDT)
Received: from e126130.arm.com (unknown [10.57.46.169])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9119D3F5A1;
        Thu, 28 Oct 2021 05:27:30 -0700 (PDT)
From:   Douglas RAILLARD <douglas.raillard@arm.com>
To:     acme@redhat.com
Cc:     dwarves@vger.kernel.org, douglas.raillard@arm.com
Subject: [PATCH v3 5/6] btf_loader.c: Propagate struct conf_load
Date:   Thu, 28 Oct 2021 13:27:09 +0100
Message-Id: <20211028122710.881181-6-douglas.raillard@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211028122710.881181-1-douglas.raillard@arm.com>
References: <20211028122710.881181-1-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

From: Douglas Raillard <douglas.raillard@arm.com>

Give access to struct conf_load in class__infer_alignment.

Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
---
 btf_loader.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/btf_loader.c b/btf_loader.c
index 2885252..e500eae 100644
--- a/btf_loader.c
+++ b/btf_loader.c
@@ -471,7 +471,8 @@ static int btf__load_sections(struct btf *btf, struct cu *cu)
 	return btf__load_types(btf, cu);
 }
 
-static uint32_t class__infer_alignment(uint32_t byte_offset,
+static uint32_t class__infer_alignment(const struct conf_load *conf,
+				       uint32_t byte_offset,
 				       uint32_t natural_alignment,
 				       uint32_t smallest_offset)
 {
@@ -497,7 +498,7 @@ static uint32_t class__infer_alignment(uint32_t byte_offset,
 	return alignment;
 }
 
-static int class__fixup_btf_bitfields(struct tag *tag, struct cu *cu)
+static int class__fixup_btf_bitfields(const struct conf_load *conf, struct tag *tag, struct cu *cu)
 {
 	struct class_member *pos;
 	struct type *tag_type = tag__type(tag);
@@ -536,27 +537,29 @@ static int class__fixup_btf_bitfields(struct tag *tag, struct cu *cu)
 			}
 		}
 
-		pos->alignment = class__infer_alignment(pos->byte_offset,
+		pos->alignment = class__infer_alignment(conf,
+							pos->byte_offset,
 							tag__natural_alignment(type, cu),
 							smallest_offset);
 		smallest_offset = pos->byte_offset + pos->byte_size;
 	}
 
-	tag_type->alignment = class__infer_alignment(tag_type->size,
+	tag_type->alignment = class__infer_alignment(conf,
+						     tag_type->size,
 						     tag__natural_alignment(tag, cu),
 						     smallest_offset);
 
 	return 0;
 }
 
-static int cu__fixup_btf_bitfields(struct cu *cu)
+static int cu__fixup_btf_bitfields(const struct conf_load *conf, struct cu *cu)
 {
 	int err = 0;
 	struct tag *pos;
 
 	list_for_each_entry(pos, &cu->tags, node)
 		if (tag__is_struct(pos) || tag__is_union(pos)) {
-			err = class__fixup_btf_bitfields(pos, cu);
+			err = class__fixup_btf_bitfields(conf, pos, cu);
 			if (err)
 				break;
 		}
@@ -606,7 +609,7 @@ static int cus__load_btf(struct cus *cus, struct conf_load *conf, const char *fi
 	if (err != 0)
 		goto out_free;
 
-	err = cu__fixup_btf_bitfields(cu);
+	err = cu__fixup_btf_bitfields(conf, cu);
 	/*
 	 * The app stole this cu, possibly deleting it,
 	 * so forget about it
-- 
2.25.1

