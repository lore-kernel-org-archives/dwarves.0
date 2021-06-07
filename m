Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,LONGWORDS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2636C47082
	for <linux-dwarves@archiver.kernel.org>; Mon,  7 Jun 2021 19:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6AD4610E7
	for <linux-dwarves@archiver.kernel.org>; Mon,  7 Jun 2021 19:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbhFGTXL (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 7 Jun 2021 15:23:11 -0400
Received: from foss.arm.com ([217.140.110.172]:40864 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230381AbhFGTXK (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Mon, 7 Jun 2021 15:23:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD112143D;
        Mon,  7 Jun 2021 12:21:18 -0700 (PDT)
Received: from a077198.arm.com (unknown [10.163.84.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 298903F73D;
        Mon,  7 Jun 2021 12:21:16 -0700 (PDT)
From:   Deepak Kumar Mishra <deepakkumar.mishra@arm.com>
To:     dwarves@vger.kernel.org, acme@kernel.org
Cc:     qais.yousef@arm.com,
        Deepak Kumar Mishra <deepakkumar.mishra@arm.com>
Subject: [PATCH v2 1/2] CMakeLists.txt: enable SHARED and STATIC lib creation
Date:   Tue,  8 Jun 2021 00:50:13 +0530
Message-Id: <70cb7cb534af9850dc5fe3c4b9f4366ce7dc6316.1623091959.git.deepakkumar.mishra@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1623091959.git.deepakkumar.mishra@arm.com>
References: <cover.1623091959.git.deepakkumar.mishra@arm.com>
In-Reply-To: <cover.1623091959.git.deepakkumar.mishra@arm.com>
References: <cover.1623091959.git.deepakkumar.mishra@arm.com>
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

CMakeLists.txt does not allow creation of static library and link applications
accordingly.

Creation of SHARED and STATIC should be allowed using -DBUILD_SHARED_LIBS
If -DBUILD_SHARED_LIBS option is not supplied, CMakeLists.txt sets it to ON.

Ex:
cmake -D__LIB=lib -DBUILD_SHARED_LIBS=OFF ..
cmake -D__LIB=lib -DBUILD_SHARED_LIBS=ON ..

Signed-off-by: Deepak Kumar Mishra <deepakkumar.mishra@arm.com>
---
 CMakeLists.txt | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 5aada20..94f771d 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -32,6 +32,11 @@ endif (NOT CMAKE_BUILD_TYPE)
 set(CMAKE_C_FLAGS_DEBUG "-Wall -Werror -ggdb -O0")
 set(CMAKE_C_FLAGS_RELEASE "-Wall -O2")
 
+if (NOT DEFINED BUILD_SHARED_LIBS)
+	set (BUILD_SHARED_LIBS ON)
+	message(STATUS "Setting BUILD_SHARED_LIBS = ${BUILD_SHARED_LIBS}")
+endif (NOT DEFINED BUILD_SHARED_LIBS)
+
 # Just for grepping, DWARVES_VERSION isn't used anywhere anymore
 # add_definitions(-D_GNU_SOURCE -DDWARVES_VERSION="v1.21")
 add_definitions(-D_GNU_SOURCE -DDWARVES_MAJOR_VERSION=1)
@@ -91,7 +96,7 @@ target_include_directories(bpf PRIVATE
 set(dwarves_LIB_SRCS dwarves.c dwarves_fprintf.c gobuffer.c strings.c
 		     ctf_encoder.c ctf_loader.c libctf.c btf_encoder.c btf_loader.c libbtf.c
 		     dwarf_loader.c dutil.c elf_symtab.c rbtree.c)
-add_library(dwarves SHARED ${dwarves_LIB_SRCS} $<TARGET_OBJECTS:bpf>)
+add_library(dwarves ${dwarves_LIB_SRCS} $<TARGET_OBJECTS:bpf>)
 set_target_properties(dwarves PROPERTIES VERSION 1.0.0 SOVERSION 1)
 set_target_properties(dwarves PROPERTIES INTERFACE_LINK_LIBRARIES "")
 target_include_directories(dwarves PRIVATE
@@ -99,12 +104,12 @@ target_include_directories(dwarves PRIVATE
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
 
@@ -151,8 +156,8 @@ target_link_libraries(syscse dwarves)
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

