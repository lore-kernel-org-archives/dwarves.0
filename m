Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98787C4338F
	for <linux-dwarves@archiver.kernel.org>; Fri,  6 Aug 2021 10:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A9D660FE7
	for <linux-dwarves@archiver.kernel.org>; Fri,  6 Aug 2021 10:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244798AbhHFKNT (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 6 Aug 2021 06:13:19 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:36795 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245016AbhHFKNA (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Fri, 6 Aug 2021 06:13:00 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Ui8-qUO_1628244763;
Received: from localhost(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0Ui8-qUO_1628244763)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 06 Aug 2021 18:12:43 +0800
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
To:     acme@redhat.com
Cc:     dwarves@vger.kernel.org
Subject: [PATCH] pahole: correct libbpf git url
Date:   Fri,  6 Aug 2021 18:12:43 +0800
Message-Id: <1628244763-1113-1-git-send-email-joseph.qi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Otherwise it will encounter the following error:
fatal: unable to access 'https://github.com/libbpf/libbpf/': Encountered end of file
fatal: clone of 'https://github.com/libbpf/libbpf' into submodule path '/home/workspace/pahole/lib/bpf' failed

Also update README to add step 'make'.

Fixes: 21507cd3e97b ("pahole: add libbpf as submodule under lib/bpf")
Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
 .gitmodules | 2 +-
 README      | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/.gitmodules b/.gitmodules
index 6be99dc..8be5eb6 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -1,3 +1,3 @@
 [submodule "lib/bpf"]
 	path = lib/bpf
-	url = https://github.com/libbpf/libbpf
+	url = https://github.com/libbpf/libbpf.git
diff --git a/README b/README
index c9f1737..07f5876 100644
--- a/README
+++ b/README
@@ -4,7 +4,8 @@ Build instructions:
 2. mkdir build
 3. cd build
 4. cmake -D__LIB=lib ..
-5. make install
+5. make
+6. make install
 
 cmake Options:
   -DBUILD_SHARED_LIBS
-- 
1.8.3.1

