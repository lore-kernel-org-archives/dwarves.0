Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,LONGWORDS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562ACC4708F
	for <linux-dwarves@archiver.kernel.org>; Wed,  2 Jun 2021 05:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ED9261360
	for <linux-dwarves@archiver.kernel.org>; Wed,  2 Jun 2021 05:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhFBF6v (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 2 Jun 2021 01:58:51 -0400
Received: from foss.arm.com ([217.140.110.172]:35168 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229779AbhFBF6u (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Wed, 2 Jun 2021 01:58:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 704956D;
        Tue,  1 Jun 2021 22:57:08 -0700 (PDT)
Received: from a077198.arm.com (unknown [10.163.82.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E00243F774;
        Tue,  1 Jun 2021 22:57:06 -0700 (PDT)
From:   Deepak Kumar Mishra <deepakkumar.mishra@arm.com>
To:     dwarves@vger.kernel.org
Cc:     acme@kernel.org, qais.yousef@arm.com,
        Deepak Kumar Mishra <deepakkumar.mishra@arm.com>
Subject: [PATCH 1/2] CMakeLists.txt: enable SHARED and STATIC lib creation
Date:   Wed,  2 Jun 2021 11:26:23 +0530
Message-Id: <09e4d499edd390ce76fceaa4087b760b1b302001.1622612388.git.deepakkumar.mishra@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1622612388.git.deepakkumar.mishra@arm.com>
References: <cover.1622612388.git.deepakkumar.mishra@arm.com>
In-Reply-To: <cover.1622612388.git.deepakkumar.mishra@arm.com>
References: <cover.1622612388.git.deepakkumar.mishra@arm.com>
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

CMakeLists.txt does not allow creation of static library and link applications
accordingly.

Creation of SHARED and STATIC should be allowed using -DBUILD_SHARED_LIBS

Ex:
cmake -D__LIB=lib -DBUILD_SHARED_LIBS=OFF ..
cmake -D__LIB=lib -DBUILD_SHARED_LIBS=ON ..

Signed-off-by: Deepak Kumar Mishra <deepakkumar.mishra@arm.com>
---
 CMakeLists.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 5aada20..bc9be63 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -91,7 +91,7 @@ target_include_directories(bpf PRIVATE
 set(dwarves_LIB_SRCS dwarves.c dwarves_fprintf.c gobuffer.c strings.c
 		     ctf_encoder.c ctf_loader.c libctf.c btf_encoder.c btf_loader.c libbtf.c
 		     dwarf_loader.c dutil.c elf_symtab.c rbtree.c)
-add_library(dwarves SHARED ${dwarves_LIB_SRCS} $<TARGET_OBJECTS:bpf>)
+add_library(dwarves ${dwarves_LIB_SRCS} $<TARGET_OBJECTS:bpf>)
 set_target_properties(dwarves PROPERTIES VERSION 1.0.0 SOVERSION 1)
 set_target_properties(dwarves PROPERTIES INTERFACE_LINK_LIBRARIES "")
 target_include_directories(dwarves PRIVATE
@@ -99,12 +99,12 @@ target_include_directories(dwarves PRIVATE
 target_link_libraries(dwarves ${DWARF_LIBRARIES} ${ZLIB_LIBRARIES})
 
 set(dwarves_emit_LIB_SRCS dwarves_emit.c)
-add_library(dwarves_emit SHARED ${dwarves_emit_LIB_SRCS})
+add_library(dwarves_emit ${dwarves_emit_LIB_SRCS})
 set_target_properties(dwarves_emit PROPERTIES VERSION 1.0.0 SOVERSION 1)
 target_link_libraries(dwarves_emit dwarves)
 
 set(dwarves_reorganize_LIB_SRCS dwarves_reorganize.c)
-add_library(dwarves_reorganize SHARED ${dwarves_reorganize_LIB_SRCS})
+add_library(dwarves_reorganize ${dwarves_reorganize_LIB_SRCS})
 set_target_properties(dwarves_reorganize PROPERTIES VERSION 1.0.0 SOVERSION 1)
 target_link_libraries(dwarves_reorganize dwarves)
 
@@ -151,8 +151,8 @@ target_link_libraries(syscse dwarves)
 install(TARGETS codiff ctracer dtagnames pahole pdwtags
 		pfunct pglobal prefcnt scncopy syscse RUNTIME DESTINATION
 		${CMAKE_INSTALL_PREFIX}/bin)
-install(TARGETS dwarves LIBRARY DESTINATION ${LIB_INSTALL_DIR})
-install(TARGETS dwarves dwarves_emit dwarves_reorganize LIBRARY DESTINATION ${LIB_INSTALL_DIR})
+install(TARGETS dwarves LIBRARY DESTINATION ${LIB_INSTALL_DIR} ARCHIVE DESTINATION ${LIB_INSTALL_DIR})
+install(TARGETS dwarves dwarves_emit dwarves_reorganize LIBRARY DESTINATION ${LIB_INSTALL_DIR} ARCHIVE DESTINATION ${LIB_INSTALL_DIR})
 install(FILES dwarves.h dwarves_emit.h dwarves_reorganize.h
 	      dutil.h gobuffer.h list.h rbtree.h pahole_strings.h
 	      btf_encoder.h config.h ctf_encoder.h ctf.h
-- 
2.17.1

