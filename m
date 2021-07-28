Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD869C4320A
	for <linux-dwarves@archiver.kernel.org>; Wed, 28 Jul 2021 17:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9946E60C3F
	for <linux-dwarves@archiver.kernel.org>; Wed, 28 Jul 2021 17:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhG1RzN (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 28 Jul 2021 13:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhG1RzN (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 28 Jul 2021 13:55:13 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAD7C061757
        for <dwarves@vger.kernel.org>; Wed, 28 Jul 2021 10:55:11 -0700 (PDT)
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=t-8ch.de; s=mail;
        t=1627494909; bh=aje6J9U9lWbZhRPFCqOkZ4q64++i6JpbCHkLrrZ5SKE=;
        h=From:To:Cc:Subject:Date:From;
        b=KZJ160Ij3F/UHgT9DLrZ5kyuFr4BRHcJCGvR2YpxSG/PPHvERFoJBWwGaVIrFSuns
         CuatchIhpfu/7glYch4699/Q8lt8zEXvYKfi4pRy5VEBTkal8SBcnSRWe0KSqoeLgr
         keWDK9Ov//BJ/uyu/mYDbuvSOeKu0iV5iZH4dreU=
To:     dwarves@vger.kernel.org
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Subject: [PATCH] dwarves: Initialize cu->priv explicitly
Date:   Wed, 28 Jul 2021 19:54:59 +0200
Message-Id: <20210728175459.143265-1-thomas@t-8ch.de>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Otherweise ->priv may contain garbage data.
This triggers a bug where the BTF loader thinks that the private data
has been set and wants to free it, crashing the program.

The bug is not reproducible with all binaries. A test file is
/usr/lib/libevdev.so.2.3.0 from
https://archive.archlinux.org/packages/l/libevdev/libevdev-1.11.0-1-x86_64.pkg.tar.zst

Stacktrace:
 Program terminated with signal SIGSEGV, Segmentation fault.
 #0  0x00007f0c4cacfc49 in btf__free (btf=0x20) at lib/bpf/src/btf.c:729
 729		if (btf->fd >= 0)
 #1  0x00007f0c4cac2d20 in btf__cu_delete (cu=0x555d89203670) at btf_loader.c:536
 #2  0x00007f0c4caaca44 in cu__delete (cu=0x555d89203670) at dwarves.c:630
 #3  0x00007f0c4cac2f4d in cus__load_btf (cus=0x555d89203140, conf=0x555d8863f360 <conf_load>,
     filename=0x7fff8fb8327e "/usr/lib/libevdev.so.2.3.0") at btf_loader.c:595
 #4  0x00007f0c4caafc18 in cus__load_file (cus=0x555d89203140, conf=0x555d8863f360 <conf_load>,
     filename=0x7fff8fb8327e "/usr/lib/libevdev.so.2.3.0") at dwarves.c:1993
 #5  0x00007f0c4cab0988 in cus__load_files (cus=0x555d89203140, conf=0x555d8863f360 <conf_load>,
     filenames=0x7fff8fb815f0) at dwarves.c:2352
 #6  0x0000555d88638d6d in main (argc=2, argv=0x7fff8fb815e8) at pahole.c:2842

Fixes: 7fb31d787d3deec191527ca010c74888f4acd765 btf_loader: Stop using libbtf.h and the btf_elf class
Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
---
 dwarves.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/dwarves.c b/dwarves.c
index 34f581d..ed0037d 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -576,6 +576,8 @@ struct cu *cu__new(const char *name, uint8_t addr_size,
 		if (cu->filename == NULL)
 			goto out_free_name;
 
+		cu->priv = NULL;
+
 		ptr_table__init(&cu->tags_table);
 		ptr_table__init(&cu->types_table);
 		ptr_table__init(&cu->functions_table);

base-commit: 3ec54ee72ff7c5b169252972f69007b54e2f9211
-- 
2.32.0

