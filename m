Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330A3C48BDF
	for <linux-dwarves@archiver.kernel.org>; Sun, 13 Jun 2021 13:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0249261264
	for <linux-dwarves@archiver.kernel.org>; Sun, 13 Jun 2021 13:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbhFMNtr (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Sun, 13 Jun 2021 09:49:47 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:35437 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbhFMNtr (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Sun, 13 Jun 2021 09:49:47 -0400
Received: by mail-wr1-f46.google.com with SMTP id m18so11399055wrv.2
        for <dwarves@vger.kernel.org>; Sun, 13 Jun 2021 06:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bXFfYOWQ+6D9JqWIQ8R8mfrkktqwSHmj06DtMEpkk9k=;
        b=jnavBdd+dTfa9MubwmhtFGrFB4aZjyO2SjDuEKf+GoFkGAjKmCRNuHkXLXwfCI+6Z7
         WKAJ/tbEZvR2Rqs+j5dLFcDUENH6XOaumjIUflOsuIqd2BB/QReMzRjZ1eT6wtKjjKKs
         IPsO5Y//GPZ+bunqYsmJjZFkDy5Wy3FxfP9dIz9e/oeDy9kzRMjDUnhgr4Spv4/3O1b/
         SyXqknH8MSRxsgUgtTRMLgiDkmXW52tEMBbyHs1PPrDN/Q3haSP9G4T0RN1Guf+2jhya
         A7tah0nsm1y02IH7wjPMc63RQZkvag+S3dtSe+ouySRFJtJWCt8wqFbv8VZ5VYBq4xOa
         FcVQ==
X-Gm-Message-State: AOAM530IfhUozT4L1MQnprw8u9XhksXRKBLIPZDbb6aJPFuckWlz7O8S
        5lvpdVp4R7GJbY9OJY1efl6xJ9oGXghnVQ==
X-Google-Smtp-Source: ABdhPJxXlPaP0yln2FZIsOGUjNT8vrJ5+mcCDKZqaQATdzstdWnTOkKojc/em7OiE20hbXSOsQXloQ==
X-Received: by 2002:a5d:44d2:: with SMTP id z18mr13933567wrr.358.1623592064783;
        Sun, 13 Jun 2021 06:47:44 -0700 (PDT)
Received: from localhost ([2a01:4b00:f41a:3600:df86:cebc:8870:2184])
        by smtp.gmail.com with ESMTPSA id y8sm19590080wmi.45.2021.06.13.06.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 06:47:43 -0700 (PDT)
From:   Luca Boccassi <bluca@debian.org>
To:     dwarves@vger.kernel.org
Cc:     arnaldo.melo@gmail.com
Subject: [PATCH dwarves 1/2] libbpf: if LIBBPF_EMBEDDED=OFF and libbpf-dev/pkgconfig is not available, fail the build
Date:   Sun, 13 Jun 2021 14:47:05 +0100
Message-Id: <20210613134706.26933-1-bluca@debian.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

If using the system library was explicitly requested, ensure it is present
and fail the build if it is not, rather than falling back to the
embedded version (same for pkg-config).

Signed-off-by: Luca Boccassi <bluca@debian.org>
---
 CMakeLists.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 669ea59..0f967d1 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -4,9 +4,9 @@ cmake_policy(SET CMP0005 NEW)
 
 option(LIBBPF_EMBEDDED "Use the embedded version of libbpf instead of searching it via pkg-config" ON)
 if (NOT LIBBPF_EMBEDDED)
-	find_package(PkgConfig)
+	find_package(PkgConfig REQUIRED)
 	if(PKGCONFIG_FOUND)
-		pkg_check_modules(LIBBPF libbpf>=0.3.0)
+		pkg_check_modules(LIBBPF REQUIRED libbpf>=0.3.0)
 	endif()
 endif()
 
-- 
2.30.2

