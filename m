Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE9BC433FE
	for <linux-dwarves@archiver.kernel.org>; Thu, 28 Oct 2021 12:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9910E610C8
	for <linux-dwarves@archiver.kernel.org>; Thu, 28 Oct 2021 12:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhJ1MaA (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 28 Oct 2021 08:30:00 -0400
Received: from foss.arm.com ([217.140.110.172]:54338 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230382AbhJ1M37 (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Thu, 28 Oct 2021 08:29:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B93311063;
        Thu, 28 Oct 2021 05:27:32 -0700 (PDT)
Received: from e126130.arm.com (unknown [10.57.46.169])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EE3D53F5A1;
        Thu, 28 Oct 2021 05:27:31 -0700 (PDT)
From:   Douglas RAILLARD <douglas.raillard@arm.com>
To:     acme@redhat.com
Cc:     dwarves@vger.kernel.org, douglas.raillard@arm.com
Subject: [PATCH v3 6/6] btf_loader.c: Use cacheline size to infer alignment
Date:   Thu, 28 Oct 2021 13:27:10 +0100
Message-Id: <20211028122710.881181-7-douglas.raillard@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211028122710.881181-1-douglas.raillard@arm.com>
References: <20211028122710.881181-1-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

From: Douglas Raillard <douglas.raillard@arm.com>

When the alignment is larger than natural, it is very likely that the
source code was using the cacheline size. Therefore, use the cacheline
size when it would only result in increasing the alignment.

Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
---
 btf_loader.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/btf_loader.c b/btf_loader.c
index e500eae..7a5b16f 100644
--- a/btf_loader.c
+++ b/btf_loader.c
@@ -476,6 +476,7 @@ static uint32_t class__infer_alignment(const struct conf_load *conf,
 				       uint32_t natural_alignment,
 				       uint32_t smallest_offset)
 {
+	uint16_t cacheline_size = conf->conf_fprintf->cacheline_size;
 	uint32_t alignment = 0;
 	uint32_t offset_delta = byte_offset - smallest_offset;
 
@@ -494,6 +495,15 @@ static uint32_t class__infer_alignment(const struct conf_load *conf,
 	/* Natural alignment, nothing to do */
 	if (alignment <= natural_alignment || alignment == 1)
 		alignment = 0;
+	/* If the offset is compatible with being aligned on the cacheline size
+	 * and this would only result in increasing the alignment, use the
+	 * cacheline size as it is safe and quite likely to be what was in the
+	 * source.
+	 */
+	else if (alignment < cacheline_size &&
+		 cacheline_size % alignment == 0 &&
+		 byte_offset % cacheline_size == 0)
+		alignment = cacheline_size;
 
 	return alignment;
 }
-- 
2.25.1

