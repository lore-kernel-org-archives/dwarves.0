Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215B3C433E0
	for <linux-dwarves@archiver.kernel.org>; Sun,  3 Jan 2021 21:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5E1420784
	for <linux-dwarves@archiver.kernel.org>; Sun,  3 Jan 2021 21:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbhACVct (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Sun, 3 Jan 2021 16:32:49 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:54047 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbhACVct (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Sun, 3 Jan 2021 16:32:49 -0500
Received: by mail-wm1-f51.google.com with SMTP id k10so16150018wmi.3
        for <dwarves@vger.kernel.org>; Sun, 03 Jan 2021 13:32:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nrhAGWuW98XlrStxiAx8jDhaVsnLE0K/f58du7zDuIs=;
        b=oIVaFjwi7uDA0FHXEQARDee8doErn+PC90jmn0WTA5NevaBeAb3xLPprwjipoFxFCn
         zEvJ62CH8fXbZqOws+i7SP2c7Sm9NTeMamBumzV9yWg6THG6hqeNOn25z20I68TR8eif
         E0JoensY0IHf+2G2OcrraM+6/mSyJOX+17YZmZjapk344MzAb0Tw04EIp1VW2U+FoVql
         OW6Eb3341dsA9FUovygYavcyJ0xjmQ5EHcrS+6jfyK36A5FIiFODOX5Sl0Y688Rt8uUI
         PDnOocMGT9STfPigVBpc425PV4RP8IEbhtVmQp5Qp6374Gz0D9AhchvQRos/krGbFSl1
         it3w==
X-Gm-Message-State: AOAM532wxc7KGxM10BlSfuM8jVlphd4MNfBzo0Nx0Z//Vznw8X3QhKlv
        QIy0IL+d2ZM00xKyti0NJD0yNelXG9KDej1m
X-Google-Smtp-Source: ABdhPJyr5DOHET2JKROP4/0T5mbFWP9spEpS1U0VyeQjt9E8ju+tKOJ6b2FcibI8BGqmkb6HRplIuQ==
X-Received: by 2002:a7b:cb09:: with SMTP id u9mr24676821wmj.61.1609709526430;
        Sun, 03 Jan 2021 13:32:06 -0800 (PST)
Received: from localhost ([2a01:4b00:f419:6f00:e2db:6a88:4676:d01b])
        by smtp.gmail.com with ESMTPSA id c7sm98421250wro.16.2021.01.03.13.32.05
        for <dwarves@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 13:32:05 -0800 (PST)
From:   Luca Boccassi <bluca@debian.org>
To:     dwarves@vger.kernel.org
Subject: [PATCH dwarves v2] libbpf: allow to use packaged version
Date:   Sun,  3 Jan 2021 21:32:01 +0000
Message-Id: <20210103213201.829827-1-bluca@debian.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210102182201.122619-1-bluca@debian.org>
References: <20210102182201.122619-1-bluca@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Add a new CMake option, LIBBPF_EMBEDDED, to switch between the
embedded version and the system version (searched via pkg-config)
of libbpf. Set the system version as the default.

Signed-off-by: Luca Boccassi <bluca@debian.org>
---
v2: switched default to use embedded version

 CMakeLists.txt   | 49 +++++++++++++++++++++++++++++++++++-------------
 btf_encoder.c    |  5 +++++
 btf_loader.c     |  4 ++++
 libbtf.c         |  6 ++++++
 libbtf.h         |  4 ++++
 pahole.c         |  4 ++++
 pahole_strings.h |  4 ++++
 strings.c        |  4 ++++
 8 files changed, 67 insertions(+), 13 deletions(-)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 857487a..188f334 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -2,9 +2,23 @@ project(pahole C)
 cmake_minimum_required(VERSION 2.8.8)
 cmake_policy(SET CMP0005 NEW)
 
+option(LIBBPF_EMBEDDED "Use the embedded version of libbpf instead of searching it via pkg-config" ON)
+if (NOT LIBBPF_EMBEDDED)
+	find_package(PkgConfig)
+	if(PKGCONFIG_FOUND)
+		pkg_check_modules(LIBBPF libbpf>=0.3.0)
+	endif()
+endif()
+
 INCLUDE_DIRECTORIES(${CMAKE_CURRENT_BINARY_DIR}
-		    ${CMAKE_CURRENT_SOURCE_DIR}
-		    ${CMAKE_CURRENT_SOURCE_DIR}/lib/bpf/include/uapi)
+		    ${CMAKE_CURRENT_SOURCE_DIR})
+if(NOT LIBBPF_FOUND)
+	INCLUDE_DIRECTORIES(${CMAKE_CURRENT_SOURCE_DIR}/lib/bpf/include/uapi)
+else()
+	INCLUDE_DIRECTORIES(${LIBBPF_INCLUDE_DIRS})
+	LINK_DIRECTORIES(${LIBBPF_LIBRARY_DIRS})
+	ADD_DEFINITIONS(-DLIBBPF_FOUND)
+endif()
 
 # Try to parse this later, Helio just showed me a KDE4 example to support
 # x86-64 builds.
@@ -56,7 +70,7 @@ if(GIT_FOUND AND EXISTS "${PROJECT_SOURCE_DIR}/.git")
 		endif()
 	endif()
 endif()
-if(NOT EXISTS "${PROJECT_SOURCE_DIR}/lib/bpf/src/btf.h")
+if(NOT LIBBPF_FOUND AND NOT EXISTS "${PROJECT_SOURCE_DIR}/lib/bpf/src/btf.h")
 	message(FATAL_ERROR "The submodules were not downloaded! GIT_SUBMODULE was turned off or failed. Please update submodules and try again.")
 endif()
 
@@ -81,22 +95,31 @@ endif()
 
 set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64")
 
-file(GLOB libbpf_sources "lib/bpf/src/*.c")
-add_library(bpf OBJECT ${libbpf_sources})
-set_property(TARGET bpf PROPERTY POSITION_INDEPENDENT_CODE 1)
-target_include_directories(bpf PRIVATE
-			   ${CMAKE_CURRENT_SOURCE_DIR}/lib/bpf/include
-			   ${CMAKE_CURRENT_SOURCE_DIR}/lib/bpf/include/uapi)
+if (NOT LIBBPF_FOUND)
+	file(GLOB libbpf_sources "lib/bpf/src/*.c")
+	add_library(bpf OBJECT ${libbpf_sources})
+	set_property(TARGET bpf PROPERTY POSITION_INDEPENDENT_CODE 1)
+	target_include_directories(bpf PRIVATE
+				   ${CMAKE_CURRENT_SOURCE_DIR}/lib/bpf/include
+				   ${CMAKE_CURRENT_SOURCE_DIR}/lib/bpf/include/uapi)
+endif()
 
 set(dwarves_LIB_SRCS dwarves.c dwarves_fprintf.c gobuffer strings
 		     ctf_encoder.c ctf_loader.c libctf.c btf_encoder.c btf_loader.c libbtf.c
 		     dwarf_loader.c dutil.c elf_symtab.c rbtree.c)
-add_library(dwarves SHARED ${dwarves_LIB_SRCS} $<TARGET_OBJECTS:bpf>)
+if (NOT LIBBPF_FOUND)
+	list(APPEND dwarves_LIB_SRCS $<TARGET_OBJECTS:bpf>)
+endif()
+add_library(dwarves SHARED ${dwarves_LIB_SRCS})
 set_target_properties(dwarves PROPERTIES VERSION 1.0.0 SOVERSION 1)
 set_target_properties(dwarves PROPERTIES INTERFACE_LINK_LIBRARIES "")
-target_include_directories(dwarves PRIVATE
-			   ${CMAKE_CURRENT_SOURCE_DIR}/lib/bpf/include/uapi)
-target_link_libraries(dwarves ${DWARF_LIBRARIES} ${ZLIB_LIBRARIES})
+if (NOT LIBBPF_FOUND)
+	target_include_directories(dwarves PRIVATE
+				   ${CMAKE_CURRENT_SOURCE_DIR}/lib/bpf/include/uapi)
+else()
+	target_include_directories(dwarves PRIVATE ${LIBBPF_INCLUDE_DIRS})
+endif()
+target_link_libraries(dwarves ${DWARF_LIBRARIES} ${ZLIB_LIBRARIES} ${LIBBPF_LIBRARIES})
 
 set(dwarves_emit_LIB_SRCS dwarves_emit.c)
 add_library(dwarves_emit SHARED ${dwarves_emit_LIB_SRCS})
diff --git a/btf_encoder.c b/btf_encoder.c
index 3339730..c13dc7e 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -11,8 +11,13 @@
 
 #include "dwarves.h"
 #include "libbtf.h"
+#ifdef LIBBPF_FOUND
+#include <linux/btf.h>
+#include <bpf/libbpf.h>
+#else
 #include "lib/bpf/include/uapi/linux/btf.h"
 #include "lib/bpf/src/libbpf.h"
+#endif
 #include "hash.h"
 #include "elf_symtab.h"
 #include "btf_encoder.h"
diff --git a/btf_loader.c b/btf_loader.c
index ec286f4..744abc6 100644
--- a/btf_loader.c
+++ b/btf_loader.c
@@ -25,7 +25,11 @@
 #include <gelf.h>
 
 #include "libbtf.h"
+#ifdef LIBBPF_FOUND
+#include <linux/btf.h>
+#else
 #include "lib/bpf/include/uapi/linux/btf.h"
+#endif
 #include "dutil.h"
 #include "dwarves.h"
 
diff --git a/libbtf.c b/libbtf.c
index 16e1d45..840d2a1 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -18,10 +18,16 @@
 #include <stdarg.h>
 
 #include "libbtf.h"
+#ifdef LIBBPF_FOUND
+#include <linux/btf.h>
+#include <bpf/btf.h>
+#include <bpf/libbpf.h>
+#else
 #include "lib/bpf/include/uapi/linux/btf.h"
 #include "lib/bpf/include/linux/err.h"
 #include "lib/bpf/src/btf.h"
 #include "lib/bpf/src/libbpf.h"
+#endif
 #include "dutil.h"
 #include "gobuffer.h"
 #include "dwarves.h"
diff --git a/libbtf.h b/libbtf.h
index 191f586..c01764e 100644
--- a/libbtf.h
+++ b/libbtf.h
@@ -11,7 +11,11 @@
 
 #include <stdbool.h>
 #include <stdint.h>
+#ifdef LIBBPF_FOUND
+#include <bpf/btf.h>
+#else
 #include "lib/bpf/src/btf.h"
+#endif
 
 struct btf_elf {
 	void		  *priv;
diff --git a/pahole.c b/pahole.c
index 4a34ba5..cfcf829 100644
--- a/pahole.c
+++ b/pahole.c
@@ -23,7 +23,11 @@
 #include "ctf_encoder.h"
 #include "btf_encoder.h"
 #include "libbtf.h"
+#ifdef LIBBPF_FOUND
+#include <bpf/libbpf.h>
+#else
 #include "lib/bpf/src/libbpf.h"
+#endif
 
 static bool btf_encode;
 static bool ctf_encode;
diff --git a/pahole_strings.h b/pahole_strings.h
index 522fbf2..8fc0648 100644
--- a/pahole_strings.h
+++ b/pahole_strings.h
@@ -6,7 +6,11 @@
   Copyright (C) 2008 Arnaldo Carvalho de Melo <acme@redhat.com>
 */
 
+#ifdef LIBBPF_FOUND
+#include <bpf/btf.h>
+#else
 #include "lib/bpf/src/btf.h"
+#endif
 
 typedef unsigned int strings_t;
 
diff --git a/strings.c b/strings.c
index d37f49d..507aaa1 100644
--- a/strings.c
+++ b/strings.c
@@ -15,7 +15,11 @@
 #include <zlib.h>
 
 #include "dutil.h"
+#ifdef LIBBPF_FOUND
+#include <bpf/libbpf.h>
+#else
 #include "lib/bpf/src/libbpf.h"
+#endif
 
 struct strings *strings__new(void)
 {
-- 
2.29.2

