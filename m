Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B46AC433F5
	for <linux-dwarves@archiver.kernel.org>; Mon, 20 Sep 2021 16:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E139860F38
	for <linux-dwarves@archiver.kernel.org>; Mon, 20 Sep 2021 16:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236921AbhITQqZ (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 20 Sep 2021 12:46:25 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:42613 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbhITQqX (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 20 Sep 2021 12:46:23 -0400
Received: by mail-ed1-f46.google.com with SMTP id t6so63476432edi.9
        for <dwarves@vger.kernel.org>; Mon, 20 Sep 2021 09:44:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UwDfYcZ3+EURuzCNvdzNMEXoalFrPT9gojFvHDJ4oSE=;
        b=6oTeku4/S5x8WdzrJz7y2eFnCic6IaSxxe8xpS4v4MWRy46dIU4V+GOIPsFwqcA+eO
         S1C8rmzeKnZFLhaXIIoTk/GbaWxCFJr9agXMqjPLfhO2oxT+Fpjq6MgCLyYmf37MHEyp
         ZNoGQfXRcESpQAQK4vSIdZ88cSPu7yG6Yc5/34lug6Oj+aUUKCeEo5ei2q7SfcnxHIv6
         NDTn4/QS5j3R953hrluzeuiMiAR/50b2EtOciZJG+28DMbyAxyW3N1GrFZ+xqoJRVwpf
         1hCNTy4F4tw2LyoHjLXZSjB7cR6tJP+jGtX66kCGDm963b2wigQT47sfzww8HxGJpXw9
         8Mjw==
X-Gm-Message-State: AOAM532frNmjynR0Q2mM5n1r8189zb+qUDIzG1N+K6+UCeQqtN+rdjvu
        NLtUOJyL5/4mXweVkiZ7EQX/NvR2YvrQqg==
X-Google-Smtp-Source: ABdhPJzjZbhlOzxN3UPuGBKJq0Z58iYssf91id3oVFefkVtjLkB1VRuMkAgZEtnQLjw2n7X179iIeg==
X-Received: by 2002:a17:906:144e:: with SMTP id q14mr28739275ejc.19.1632156295614;
        Mon, 20 Sep 2021 09:44:55 -0700 (PDT)
Received: from msft-t490s.teknoraver.net (net-2-34-36-22.cust.vodafonedsl.it. [2.34.36.22])
        by smtp.gmail.com with ESMTPSA id m17sm6424023ejn.108.2021.09.20.09.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 09:44:55 -0700 (PDT)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     dwarves@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH] CMakeList.txt: don't download libbpf source when system library is used
Date:   Mon, 20 Sep 2021 18:44:52 +0200
Message-Id: <20210920164452.44529-1-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

The build system always download the libbpf submodule, regardless if
we're using the embedded or the system version.
Download the libbpf source only if we're using the embedded one.

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 CMakeLists.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 8523bce..2ab66e4 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -65,7 +65,7 @@ find_package(Python3 QUIET)
 
 # make sure git submodule(s) are checked out
 find_package(Git QUIET)
-if(GIT_FOUND AND EXISTS "${PROJECT_SOURCE_DIR}/.git")
+if(LIBBPF_EMBEDDED AND GIT_FOUND AND EXISTS "${PROJECT_SOURCE_DIR}/.git")
 	# Update submodules as needed
 	option(GIT_SUBMODULE "Check submodules during build" ON)
 	if(GIT_SUBMODULE)
-- 
2.31.1

