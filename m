Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FE9C47094
	for <linux-dwarves@archiver.kernel.org>; Mon,  7 Jun 2021 19:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ACB661009
	for <linux-dwarves@archiver.kernel.org>; Mon,  7 Jun 2021 19:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhFGTXS (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 7 Jun 2021 15:23:18 -0400
Received: from foss.arm.com ([217.140.110.172]:40874 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230414AbhFGTXR (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Mon, 7 Jun 2021 15:23:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13B0A1476;
        Mon,  7 Jun 2021 12:21:21 -0700 (PDT)
Received: from a077198.arm.com (unknown [10.163.84.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 66B3B3F73D;
        Mon,  7 Jun 2021 12:21:19 -0700 (PDT)
From:   Deepak Kumar Mishra <deepakkumar.mishra@arm.com>
To:     dwarves@vger.kernel.org, acme@kernel.org
Cc:     qais.yousef@arm.com,
        Deepak Kumar Mishra <deepakkumar.mishra@arm.com>
Subject: [PATCH v2 2/2] README: add documentation for -DBUILD_SHARED_LIBS
Date:   Tue,  8 Jun 2021 00:50:14 +0530
Message-Id: <fc62257e950fdbc93bbda8b1203971c0f37234d5.1623091959.git.deepakkumar.mishra@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1623091959.git.deepakkumar.mishra@arm.com>
References: <cover.1623091959.git.deepakkumar.mishra@arm.com>
In-Reply-To: <cover.1623091959.git.deepakkumar.mishra@arm.com>
References: <cover.1623091959.git.deepakkumar.mishra@arm.com>
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

added a section in README to give details about use of -DBUILD_SHARED_LIBS
cmake option and existing documentation reformatted to accommodate this.

Signed-off-by: Deepak Kumar Mishra <deepakkumar.mishra@arm.com>
---
 README | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/README b/README
index 576cd42..c9f1737 100644
--- a/README
+++ b/README
@@ -6,8 +6,17 @@ Build instructions:
 4. cmake -D__LIB=lib ..
 5. make install
 
-Default is to install to /usr/local, use -DCMAKE_INSTALL_PREFIX=
-when invoking cmake to specify another install location.
+cmake Options:
+  -DBUILD_SHARED_LIBS
+    By default SHARED libraries are created and applications are linked to it.
+    Use -DBUILD_SHARED_LIBS=OFF while invoking cmake to create STATIC libraries
+    and link applications to it.
+
+    Ex. cmake -D__LIB=lib -DBUILD_SHARED_LIBS=OFF ..
+
+  -DCMAKE_INSTALL_PREFIX
+    Default is to install to /usr/local, use -DCMAKE_INSTALL_PREFIX=
+    when invoking cmake to specify another install location.
 
 Known to work scenarios:
 
-- 
2.17.1

