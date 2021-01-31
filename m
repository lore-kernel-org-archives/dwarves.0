Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2497C433E0
	for <linux-dwarves@archiver.kernel.org>; Sun, 31 Jan 2021 00:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D08564DD8
	for <linux-dwarves@archiver.kernel.org>; Sun, 31 Jan 2021 00:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbhAaA3o (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Sat, 30 Jan 2021 19:29:44 -0500
Received: from wildebeest.demon.nl ([212.238.236.112]:43230 "EHLO
        gnu.wildebeest.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbhAaA3n (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Sat, 30 Jan 2021 19:29:43 -0500
Received: from librem (deer0x15.wildebeest.org [172.31.17.151])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by gnu.wildebeest.org (Postfix) with ESMTPSA id 980F230010D9;
        Sun, 31 Jan 2021 01:29:01 +0100 (CET)
Received: by librem (Postfix, from userid 1000)
        id 7FA16C1004; Sun, 31 Jan 2021 01:27:53 +0100 (CET)
From:   Mark Wielaard <mark@klomp.org>
To:     dwarves@vger.kernel.org
Cc:     Mark Wielaard <mark@klomp.org>
Subject: [PATCH] Handle DWARF5 DW_TAG_call_site like DW_TAG_GNU_call_site
Date:   Sun, 31 Jan 2021 01:27:31 +0100
Message-Id: <20210131002731.60086-1-mark@klomp.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

DW_TAG_call_site and DW_TAG_call_site_parameter are the standardized
DWARF5 versions of DW_TAG_GNU_call_site and DW_TAG_GNU call_site_parameter.
Handle them the same way (which is by ignoring them).

https://bugzilla.redhat.com/show_bug.cgi?id=1922698
---
 dwarf_loader.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index ac22c1b..3bdf570 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -41,6 +41,11 @@ struct strings *strings;
 #define DW_TAG_GNU_call_site_parameter 0x410a
 #endif
 
+#ifndef DW_TAG_call_site
+#define DW_TAG_call_site 0x48
+#define DW_TAG_call_site_parameter 0x49
+#endif
+
 #define hashtags__fn(key) hash_64(key, HASHTAGS__BITS)
 
 bool no_bitfield_type_recode = true;
@@ -1595,6 +1600,8 @@ static int die__process_function(Dwarf_Die *die, struct ftype *ftype,
 		uint32_t id;
 
 		switch (dwarf_tag(die)) {
+		case DW_TAG_call_site:
+		case DW_TAG_call_site_parameter:
 		case DW_TAG_GNU_call_site:
 		case DW_TAG_GNU_call_site_parameter:
 			/*
-- 
2.20.1

