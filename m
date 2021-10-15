Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CACEC433F5
	for <linux-dwarves@archiver.kernel.org>; Fri, 15 Oct 2021 10:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0258060F44
	for <linux-dwarves@archiver.kernel.org>; Fri, 15 Oct 2021 10:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237791AbhJOKMV (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 15 Oct 2021 06:12:21 -0400
Received: from foss.arm.com ([217.140.110.172]:39272 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237713AbhJOKMQ (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Fri, 15 Oct 2021 06:12:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36E75147A;
        Fri, 15 Oct 2021 03:10:09 -0700 (PDT)
Received: from e126130.cambridge.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7DF1F3F70D;
        Fri, 15 Oct 2021 03:10:08 -0700 (PDT)
From:   Douglas RAILLARD <douglas.raillard@arm.com>
To:     acme@redhat.com
Cc:     dwarves@vger.kernel.org, douglas.raillard@arm.com
Subject: [PATCH] CMakeLists.txt: Add STATIC_LINK option
Date:   Fri, 15 Oct 2021 11:10:08 +0100
Message-Id: <20211015101008.486302-1-douglas.raillard@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

From: Douglas Raillard <douglas.raillard@arm.com>

Add a user-defined STATIC_LINK option that can be used to build a fully
static binary for the executables:

    cmake .. -DSTATIC_LINK=ON

This has been tested on Alpine Linux v3.14.

Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
---
 CMakeLists.txt                | 21 +++++++++++++++------
 README                        |  3 +++
 cmake/modules/FindDWARF.cmake | 10 ++++++++++
 3 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 2ab66e4..ba467bf 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -34,6 +34,15 @@ macro(_set_fancy _var _value _comment)
 	endif (NOT DEFINED ${_var})
 endmacro(_set_fancy)
 
+option(BUILD_SHARED_LIBS "Build internal libraries as shared libraries" ON)
+option(STATIC_LINK "Create statically linked executables" OFF)
+if (STATIC_LINK)
+  string(APPEND CMAKE_C_FLAGS " -static")
+  string(APPEND CMAKE_EXE_LINKER_FLAGS " -static")
+  set(CMAKE_FIND_LIBRARY_SUFFIXES .a)
+  set(BUILD_SHARED_LIBS OFF)
+endif()
+
 # where to look first for cmake modules,
 # before ${CMAKE_ROOT}/Modules/ is checked
 set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake/modules")
@@ -48,11 +57,6 @@ set(CMAKE_C_FLAGS_DEBUG "-Wall -Werror -ggdb -O0")
 set(CMAKE_C_FLAGS_RELEASE "-Wall -O2")
 SET(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -pthread")
 
-if (NOT DEFINED BUILD_SHARED_LIBS)
-	set (BUILD_SHARED_LIBS ON)
-	message(STATUS "Setting BUILD_SHARED_LIBS = ${BUILD_SHARED_LIBS}")
-endif (NOT DEFINED BUILD_SHARED_LIBS)
-
 # Just for grepping, DWARVES_VERSION isn't used anywhere anymore
 # add_definitions(-D_GNU_SOURCE -DDWARVES_VERSION="v1.22")
 add_definitions(-D_GNU_SOURCE -DDWARVES_MAJOR_VERSION=1)
@@ -123,7 +127,7 @@ endif()
 add_library(dwarves ${dwarves_LIB_SRCS})
 set_target_properties(dwarves PROPERTIES VERSION 1.0.0 SOVERSION 1)
 set_target_properties(dwarves PROPERTIES INTERFACE_LINK_LIBRARIES "")
-target_link_libraries(dwarves ${DWARF_LIBRARIES} ${ZLIB_LIBRARIES} ${LIBBPF_LIBRARIES} ${ARGP_LIBRARY} ${OBSTACK_LIBRARY})
+target_link_libraries(dwarves ${DWARF_LIBRARIES} ${ZLIB_LIBRARIES} ${LIBBPF_LIBRARIES} ${ARGP_LIBRARY} ${OBSTACK_LIBRARY} ${BZ2_LIBRARY} ${LZMA_LIBRARY})
 
 set(dwarves_emit_LIB_SRCS dwarves_emit.c)
 add_library(dwarves_emit ${dwarves_emit_LIB_SRCS})
@@ -193,3 +197,8 @@ endif()
 install(PROGRAMS btfdiff fullcircle DESTINATION ${CMAKE_INSTALL_PREFIX}/bin)
 install(FILES lib/Makefile lib/ctracer_relay.c lib/ctracer_relay.h lib/linux.blacklist.cu
 	DESTINATION ${CMAKE_INSTALL_PREFIX}/share/dwarves/runtime)
+
+# Avoid having a trailing -Wl,-Bdynamic that will make some linkers think we
+# need to link against a DSO for the libc.
+get_property(TARGETS DIRECTORY PROPERTY BUILDSYSTEM_TARGETS)
+set_target_properties(${TARGETS} PROPERTIES LINK_SEARCH_END_STATIC ${STATIC_LINK})
diff --git a/README b/README
index c9f1737..5798458 100644
--- a/README
+++ b/README
@@ -18,6 +18,9 @@ cmake Options:
     Default is to install to /usr/local, use -DCMAKE_INSTALL_PREFIX=
     when invoking cmake to specify another install location.
 
+  -DSTATIC_LINK
+    Build a statically linked binary. Default is OFF.
+
 Known to work scenarios:
 
 Mandriva Cooker:
diff --git a/cmake/modules/FindDWARF.cmake b/cmake/modules/FindDWARF.cmake
index 027d06e..1b4ac49 100644
--- a/cmake/modules/FindDWARF.cmake
+++ b/cmake/modules/FindDWARF.cmake
@@ -37,6 +37,16 @@ find_library(ELF_LIBRARY
 	PATHS /usr/lib /usr/local/lib /usr/lib64 /usr/local/lib64 ~/usr/local/lib ~/usr/local/lib64
 )
 
+find_library(BZ2_LIBRARY
+	NAMES bz2
+	PATHS /usr/lib /usr/local/lib /usr/lib64 /usr/local/lib64 ~/usr/local/lib ~/usr/local/lib64
+)
+
+find_library(LZMA_LIBRARY
+	NAMES lzma
+	PATHS /usr/lib /usr/local/lib /usr/lib64 /usr/local/lib64 ~/usr/local/lib ~/usr/local/lib64
+)
+
 if (DWARF_INCLUDE_DIR AND LIBDW_INCLUDE_DIR AND DWARF_LIBRARY AND ELF_LIBRARY)
 	set(DWARF_FOUND TRUE)
 	set(DWARF_LIBRARIES ${DWARF_LIBRARY} ${ELF_LIBRARY})
-- 
2.25.1

