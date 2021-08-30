Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787AAC432BE
	for <linux-dwarves@archiver.kernel.org>; Mon, 30 Aug 2021 15:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 608BD60E77
	for <linux-dwarves@archiver.kernel.org>; Mon, 30 Aug 2021 15:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237494AbhH3PFq (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 30 Aug 2021 11:05:46 -0400
Received: from mail-ej1-f46.google.com ([209.85.218.46]:35589 "EHLO
        mail-ej1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237123AbhH3PFq (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 30 Aug 2021 11:05:46 -0400
Received: by mail-ej1-f46.google.com with SMTP id i21so31876263ejd.2
        for <dwarves@vger.kernel.org>; Mon, 30 Aug 2021 08:04:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j5tg2tKRpDEdfJgFkkyauTvUpjlNJ4uv32M5UIbgRZ8=;
        b=AJbFURfHTJKZcVa57e53a1jjcjptsakLNZ1WIGVaQnVVPPYzuOoSxGVbNX7M1TOBQP
         /M4jlsVG32NMBcQfxtDg5Jw+D94AUZ0o9uBbLTw+VlToCYEmm26BBN+EWv2J01X7uPVv
         P9tSaxvnmSubyHn8IU39kbQGRlUEbr/yPjx2noznxc9ru8W6z5Z1oW1wYK+T4TylvRAH
         fvxnGjpTlSLjMTXWePWg+iQRIRxe6lwkPuxgqPT4X08/JhXuY7AfPTJdLoC28prQ8E/q
         T+J9gsHenN/xDg3kCVtj4ajiFKfv7MhBkwrcI6BXmACjx1XsfYggaLpSER9x5vOW+5v2
         65BA==
X-Gm-Message-State: AOAM531WA6/4nlwN5m8UU1D6vKGdwAlSVRxV/3Nktm/L20A+kZm4f9ik
        GiUb99LoGb3rnFyoTOICKCETKziUbzlmdg==
X-Google-Smtp-Source: ABdhPJwskSvUxnweuLIEdH7GEZ64dSsmdGcCEU5BWN8wFVWlCQaVOASRUA10HfW8/uQyUI9hUA7rgg==
X-Received: by 2002:a17:906:840d:: with SMTP id n13mr8337260ejx.53.1630335891665;
        Mon, 30 Aug 2021 08:04:51 -0700 (PDT)
Received: from msft-t490s.fritz.box (host-79-49-3-218.retail.telecomitalia.it. [79.49.3.218])
        by smtp.gmail.com with ESMTPSA id kw10sm6836461ejc.111.2021.08.30.08.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 08:04:51 -0700 (PDT)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     dwarves@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH] CMakeList.txt: make python optional
Date:   Mon, 30 Aug 2021 17:04:40 +0200
Message-Id: <20210830150440.1525773-1-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

ostra-cg, which requires python, is installed in the destination dir.
Make it optional for embedded distributions which doesn't have the
python interpreter available.

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 CMakeLists.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 4140574..8523bce 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -61,6 +61,7 @@ find_package(DWARF REQUIRED)
 find_package(ZLIB REQUIRED)
 find_package(argp REQUIRED)
 find_package(obstack REQUIRED)
+find_package(Python3 QUIET)
 
 # make sure git submodule(s) are checked out
 find_package(Git QUIET)
@@ -185,8 +186,10 @@ install(FILES dwarves.h dwarves_emit.h dwarves_reorganize.h
 	      elfcreator.h elf_symtab.h hash.h libctf.h
 	DESTINATION ${CMAKE_INSTALL_PREFIX}/include/dwarves/)
 install(FILES man-pages/pahole.1 DESTINATION ${CMAKE_INSTALL_PREFIX}/share/man/man1/)
-install(PROGRAMS ostra/ostra-cg DESTINATION ${CMAKE_INSTALL_PREFIX}/bin)
+if(Python3_FOUND)
+	install(PROGRAMS ostra/ostra-cg DESTINATION ${CMAKE_INSTALL_PREFIX}/bin)
+	install(FILES ostra/python/ostra.py DESTINATION ${CMAKE_INSTALL_PREFIX}/share/dwarves/runtime/python)
+endif()
 install(PROGRAMS btfdiff fullcircle DESTINATION ${CMAKE_INSTALL_PREFIX}/bin)
-install(FILES ostra/python/ostra.py DESTINATION ${CMAKE_INSTALL_PREFIX}/share/dwarves/runtime/python)
 install(FILES lib/Makefile lib/ctracer_relay.c lib/ctracer_relay.h lib/linux.blacklist.cu
 	DESTINATION ${CMAKE_INSTALL_PREFIX}/share/dwarves/runtime)
-- 
2.31.1

