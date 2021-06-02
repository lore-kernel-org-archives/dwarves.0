Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650ADC47083
	for <linux-dwarves@archiver.kernel.org>; Wed,  2 Jun 2021 05:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4735B610E5
	for <linux-dwarves@archiver.kernel.org>; Wed,  2 Jun 2021 05:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhFBF6x (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 2 Jun 2021 01:58:53 -0400
Received: from foss.arm.com ([217.140.110.172]:35178 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229779AbhFBF6x (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Wed, 2 Jun 2021 01:58:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8461D1042;
        Tue,  1 Jun 2021 22:57:10 -0700 (PDT)
Received: from a077198.arm.com (unknown [10.163.82.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8C213F774;
        Tue,  1 Jun 2021 22:57:08 -0700 (PDT)
From:   Deepak Kumar Mishra <deepakkumar.mishra@arm.com>
To:     dwarves@vger.kernel.org
Cc:     acme@kernel.org, qais.yousef@arm.com,
        Deepak Kumar Mishra <deepakkumar.mishra@arm.com>
Subject: [PATCH 2/2] README: add documentation for -DBUILD_SHARED_LIBS
Date:   Wed,  2 Jun 2021 11:26:24 +0530
Message-Id: <6307fc26935026e9c9a765ae2f0f50226c891d34.1622612388.git.deepakkumar.mishra@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1622612388.git.deepakkumar.mishra@arm.com>
References: <cover.1622612388.git.deepakkumar.mishra@arm.com>
In-Reply-To: <cover.1622612388.git.deepakkumar.mishra@arm.com>
References: <cover.1622612388.git.deepakkumar.mishra@arm.com>
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

added a section in README to give details about use of -DBUILD_SHARED_LIBS
cmake option and existing documentation reformatted to accomodate this.

Signed-off-by: Deepak Kumar Mishra <deepakkumar.mishra@arm.com>
---
 README | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/README b/README
index 576cd42..40ca984 100644
--- a/README
+++ b/README
@@ -6,8 +6,17 @@ Build instructions:
 4. cmake -D__LIB=lib ..
 5. make install
 
-Default is to install to /usr/local, use -DCMAKE_INSTALL_PREFIX=
-when invoking cmake to specify another install location.
+cmake Options:
+  -DBUILD_SHARED_LIBS
+    By default STATIC libraries are created and applications are linked to it.
+    use -DBUILD_SHARED_LIBS=ON while invoking cmake to create SHARED libraries
+    and link applications to it.
+
+    Ex. cmake -D__LIB=lib -DBUILD_SHARED_LIBS=ON ..
+
+  -DCMAKE_INSTALL_PREFIX
+    Default is to install to /usr/local, use -DCMAKE_INSTALL_PREFIX=
+    when invoking cmake to specify another install location.
 
 Known to work scenarios:
 
-- 
2.17.1

