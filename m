Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C4AC48BE8
	for <linux-dwarves@archiver.kernel.org>; Sun, 13 Jun 2021 13:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 687A461153
	for <linux-dwarves@archiver.kernel.org>; Sun, 13 Jun 2021 13:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbhFMNts (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Sun, 13 Jun 2021 09:49:48 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:42809 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbhFMNts (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Sun, 13 Jun 2021 09:49:48 -0400
Received: by mail-wr1-f45.google.com with SMTP id c5so11375920wrq.9
        for <dwarves@vger.kernel.org>; Sun, 13 Jun 2021 06:47:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SsV6m+6Fn86C7TWz5DK2bUOOI3kv6Z2newO7qAn0PiQ=;
        b=CjHzHsas+XAR69oOthtC/MV7LxGmbAUQoFJrVtz+PcYVNw1aElVPXitlxtpsopyCeA
         0763Epbhne1Re/0pnUchHmf0n6wcWdYkpfG7RHf4cb4yAprd8/vNB9zwPiu23e8T6QPF
         2UbDTsou7Z0XsbN0+Cn+ORI7bDGHOSUHTCY8OOzwEFjibqT6R/qr66gHgIu3DDknX5/R
         VIg1zQ33mGdwgJ/qCaluxD4cXugY5Js9xEHpieFQtN3B3Zs+BDM8BKXbg0WjqZG7AxXT
         yKfErNSpoXIj/nNaU992GtxiqdyFT8DfizQJknclN7kK+8JF49AZqwmUDOztZTplQ3VJ
         OXyQ==
X-Gm-Message-State: AOAM532G++RPKsLY/LUbPDwnM8vauXrcZdtBkN63EnQK9n56yfk9yJqg
        fPt5UwOc4j40z7Uc1nk4GZld9n8kN2PmdQ==
X-Google-Smtp-Source: ABdhPJxk5OsEVoYjgmJ3KRR4unn4lUWnOzF/UvkzzjCZwVSdPsQzLwzDhnPtJzddBwjpwxHWX2ZLcQ==
X-Received: by 2002:a5d:46c4:: with SMTP id g4mr14572655wrs.308.1623592066409;
        Sun, 13 Jun 2021 06:47:46 -0700 (PDT)
Received: from localhost ([2a01:4b00:f41a:3600:df86:cebc:8870:2184])
        by smtp.gmail.com with ESMTPSA id n13sm15302391wrg.75.2021.06.13.06.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 06:47:45 -0700 (PDT)
From:   Luca Boccassi <bluca@debian.org>
To:     dwarves@vger.kernel.org
Cc:     arnaldo.melo@gmail.com
Subject: [PATCH dwarves 2/2] libbpf: bump dependency to >= 0.4.0
Date:   Sun, 13 Jun 2021 14:47:06 +0100
Message-Id: <20210613134706.26933-2-bluca@debian.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210613134706.26933-1-bluca@debian.org>
References: <20210613134706.26933-1-bluca@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Required for the new API btf__add_float()

Signed-off-by: Luca Boccassi <bluca@debian.org>
---
 CMakeLists.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 0f967d1..a8c0af8 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -6,7 +6,7 @@ option(LIBBPF_EMBEDDED "Use the embedded version of libbpf instead of searching
 if (NOT LIBBPF_EMBEDDED)
 	find_package(PkgConfig REQUIRED)
 	if(PKGCONFIG_FOUND)
-		pkg_check_modules(LIBBPF REQUIRED libbpf>=0.3.0)
+		pkg_check_modules(LIBBPF REQUIRED libbpf>=0.4.0)
 	endif()
 endif()
 
-- 
2.30.2

