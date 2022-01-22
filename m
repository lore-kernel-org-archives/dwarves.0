Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B725C433EF
	for <linux-dwarves@archiver.kernel.org>; Sat, 22 Jan 2022 17:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbiAVRvH (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Sat, 22 Jan 2022 12:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbiAVRvH (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Sat, 22 Jan 2022 12:51:07 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B74C06173B
        for <dwarves@vger.kernel.org>; Sat, 22 Jan 2022 09:51:07 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id c24so46204350edy.4
        for <dwarves@vger.kernel.org>; Sat, 22 Jan 2022 09:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=sT26m9PNaIgKkPdZ9APEnzg44Nv3Xq70RbUd0BLiL9E=;
        b=AgTFPCQACwvWhh+eKZ9pAJmB7BzlOBT0sZqbPmTv5mWPSyInxbX1atgx+ZQfR1Jzf/
         Dle0hebIn9KuvXBaSLY6UAgAAUAotXoAUtp/5nXoLj38bwLFGHHIW4SuP66iBET3RlRa
         mq3+N6VYq9O1ldTL57US0C9bJ1WqHQULO88E8MAkXN938ou0nAd4pWSW1H39b4RPVwPT
         edUqnVK61ssVvRMIX8s+JYGvmeR/9IdCWY58/E5B/zpSxiOVa0dNek1OO40unriRWeKR
         mveuMNDreCIFOEUAHOOpIWvbM9sNx821UFfQIGffrP1s5R3+rjOSPcTBVb6nseTdmXPz
         z63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:subject:message-id
         :mime-version:content-disposition;
        bh=sT26m9PNaIgKkPdZ9APEnzg44Nv3Xq70RbUd0BLiL9E=;
        b=HcwoKycqPg87M7k/+y8XEJxKPpzCsEiKBJUvp5IlfFVQalW/gvyp1tPtsSwPUyt/fH
         VrCwJmzXj0JW4bb+/6z+FBXfEA7YgDwksOZAP4f3fd0KsXOd4ItaNoflLlLFpQImnLsd
         ir+EwUzyfYPJNt+JmgXHjuazXAK5nO0cYEjnjiIiOkrqa+30g88ojDm5E8EUPbvarBPD
         BQ06322d51z0lyiKDJ2sFeadG/in1vrsvPzIo8wMrirrNdWMii1xEr8OcUCc6MLk6fxx
         Qyhlx/J79yKgsWVG+HUhJgRhqX8tqvAhe6FZ3d+RfAM5pTuuGkfVX7/IQvbyGz6FszSd
         5WHw==
X-Gm-Message-State: AOAM532eLcUxJscyKKWazEiiMpaayn4x5opKrHFIQolGCcFx8R5tPX12
        W/7XnXL/sTwZCUFnWXfV82rujK+wVy7DK9ovsx0=
X-Google-Smtp-Source: ABdhPJxU4WUPpfk4R24rax7X+c3nEegIfjAjdDd5wbGgDmRynrkOE06R5JoP7ha8JDFTCPJ6/I3wKw==
X-Received: by 2002:a05:6402:5203:: with SMTP id s3mr8981112edd.27.1642873864959;
        Sat, 22 Jan 2022 09:51:04 -0800 (PST)
Received: from m4.home (tor-exit-33.for-privacy.net. [2a0b:f4c2:2::33])
        by smtp.gmail.com with ESMTPSA id gr24sm3032674ejb.185.2022.01.22.09.51.04
        for <dwarves@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 09:51:04 -0800 (PST)
Sender: Domenico Andreoli <domenico.andreoli.it@gmail.com>
Received: from cavok by m4.home with local (Exim 4.94.2)
        (envelope-from <cavok@m4>)
        id 1nBKXV-0006eJ-W2
        for dwarves@vger.kernel.org; Sat, 22 Jan 2022 18:51:02 +0100
Date:   Sat, 22 Jan 2022 18:51:01 +0100
From:   Domenico Andreoli <domenico.andreoli@linux.com>
To:     dwarves@vger.kernel.org
Subject: [RFC][PATCH] Make BPF support optional
Message-ID: <YexEBX+gVlXAAbTm@m4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Non-linux systems also can make good use of these tools. This patch
adds option LIBBPF_ENABLED (default: on) so to opt-out BPF when needed.

Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
---
 CMakeLists.txt |   61 +++++++++++++++++++++++++++++++++------------------------
 dwarves.c      |    2 ++
 pahole.c       |   34 ++++++++++++++++++++++++++------
 3 files changed, 65 insertions(+), 32 deletions(-)

Index: b/CMakeLists.txt
===================================================================
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -2,23 +2,30 @@ project(pahole C)
 cmake_minimum_required(VERSION 2.8.12)
 cmake_policy(SET CMP0005 NEW)
 
-option(LIBBPF_EMBEDDED "Use the embedded version of libbpf instead of searching it via pkg-config" ON)
-if (NOT LIBBPF_EMBEDDED)
-	find_package(PkgConfig REQUIRED)
-	if(PKGCONFIG_FOUND)
-		pkg_check_modules(LIBBPF REQUIRED libbpf>=0.4.0)
+option(LIBBPF_ENABLED "Enable BPF support" ON)
+if(LIBBPF_ENABLED)
+	option(LIBBPF_EMBEDDED "Use the embedded version of libbpf instead of searching it via pkg-config" ON)
+	if(NOT LIBBPF_EMBEDDED)
+		find_package(PkgConfig REQUIRED)
+		if(PKGCONFIG_FOUND)
+			pkg_check_modules(LIBBPF REQUIRED libbpf>=0.4.0)
+		endif()
 	endif()
+else()
+	message(STATUS "Disabled BPF support")
 endif()
 
 INCLUDE_DIRECTORIES(${CMAKE_CURRENT_BINARY_DIR}
 		    ${CMAKE_CURRENT_SOURCE_DIR})
-if(NOT LIBBPF_FOUND)
-	# Allows to use 'system' style #include with both embedded and system libbpf
-	INCLUDE_DIRECTORIES(${CMAKE_CURRENT_SOURCE_DIR}/lib/include)
-	INCLUDE_DIRECTORIES(${CMAKE_CURRENT_SOURCE_DIR}/lib/bpf/include/uapi)
-else()
-	INCLUDE_DIRECTORIES(${LIBBPF_INCLUDE_DIRS})
-	LINK_DIRECTORIES(${LIBBPF_LIBRARY_DIRS})
+if(LIBBPF_ENABLED)
+	if(LIBBPF_FOUND)
+		INCLUDE_DIRECTORIES(${LIBBPF_INCLUDE_DIRS})
+		LINK_DIRECTORIES(${LIBBPF_LIBRARY_DIRS})
+	else()
+		# Allows to use 'system' style #include with both embedded and system libbpf
+		INCLUDE_DIRECTORIES(${CMAKE_CURRENT_SOURCE_DIR}/lib/include)
+		INCLUDE_DIRECTORIES(${CMAKE_CURRENT_SOURCE_DIR}/lib/bpf/include/uapi)
+	endif()
 endif()
 
 # Try to parse this later, Helio just showed me a KDE4 example to support
@@ -79,7 +86,7 @@ if(GIT_FOUND AND EXISTS "${PROJECT_SOURC
 		endif()
 	endif()
 endif()
-if(NOT LIBBPF_FOUND AND NOT EXISTS "${PROJECT_SOURCE_DIR}/lib/bpf/src/btf.h")
+if(LIBBPF_ENABLED AND NOT LIBBPF_FOUND AND NOT EXISTS "${PROJECT_SOURCE_DIR}/lib/bpf/src/btf.h")
 	message(FATAL_ERROR "The submodules were not downloaded! GIT_SUBMODULE was turned off or failed. Please update submodules and try again.")
 endif()
 
@@ -104,21 +111,23 @@ endif()
 
 set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64")
 
-if (NOT LIBBPF_FOUND)
-	file(GLOB libbpf_sources "lib/bpf/src/*.c")
-	add_library(bpf OBJECT ${libbpf_sources})
-	set_property(TARGET bpf PROPERTY POSITION_INDEPENDENT_CODE 1)
-	target_include_directories(bpf PRIVATE
-				   ${CMAKE_CURRENT_SOURCE_DIR}/lib/bpf/include
-				   ${CMAKE_CURRENT_SOURCE_DIR}/lib/bpf/include/uapi)
-endif()
+set(dwarves_LIB_SRCS dwarves.c dwarves_fprintf.c gobuffer.c ctf_loader.c libctf.c
+                     dwarf_loader.c dutil.c elf_symtab.c rbtree.c)
 
-set(dwarves_LIB_SRCS dwarves.c dwarves_fprintf.c gobuffer.c
-		     ctf_loader.c libctf.c btf_encoder.c btf_loader.c
-		     dwarf_loader.c dutil.c elf_symtab.c rbtree.c)
-if (NOT LIBBPF_FOUND)
-	list(APPEND dwarves_LIB_SRCS $<TARGET_OBJECTS:bpf>)
+if(LIBBPF_ENABLED)
+	set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DHAVE_BPF")
+	list(APPEND dwarves_LIB_SRCS btf_encoder.c btf_loader.c)
+	if(NOT LIBBPF_FOUND)
+		file(GLOB libbpf_sources "lib/bpf/src/*.c")
+		add_library(bpf OBJECT ${libbpf_sources})
+		set_property(TARGET bpf PROPERTY POSITION_INDEPENDENT_CODE 1)
+		target_include_directories(bpf PRIVATE
+					   ${CMAKE_CURRENT_SOURCE_DIR}/lib/bpf/include
+					   ${CMAKE_CURRENT_SOURCE_DIR}/lib/bpf/include/uapi)
+		list(APPEND dwarves_LIB_SRCS $<TARGET_OBJECTS:bpf>)
+	endif()
 endif()
+
 add_library(dwarves ${dwarves_LIB_SRCS})
 set_target_properties(dwarves PROPERTIES VERSION 1.0.0 SOVERSION 1)
 set_target_properties(dwarves PROPERTIES INTERFACE_LINK_LIBRARIES "")
Index: b/pahole.c
===================================================================
--- a/pahole.c
+++ b/pahole.c
@@ -19,26 +19,32 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+
+#ifdef HAVE_BPF
 #include <bpf/btf.h>
 #include "bpf/libbpf.h"
+#include "btf_encoder.h"
+#endif
 
 #include "dwarves_reorganize.h"
 #include "dwarves.h"
 #include "dutil.h"
 //#include "ctf_encoder.h" FIXME: disabled, probably its better to move to Oracle's libctf
-#include "btf_encoder.h"
 
+static bool btf_encode;
+static bool ctf_encode;
+#ifdef HAVE_BPF
 static struct btf_encoder *btf_encoder;
 static char *detached_btf_filename;
-static bool btf_encode;
 static bool btf_gen_floats;
-static bool ctf_encode;
-static bool sort_output;
-static bool need_resort;
-static bool first_obj_only;
 static bool skip_encoding_btf_vars;
 static bool btf_encode_force;
 static const char *base_btf_file;
+#endif
+
+static bool sort_output;
+static bool need_resort;
+static bool first_obj_only;
 
 static const char *prettify_input_filename;
 static FILE *prettify_input;
@@ -1533,6 +1539,7 @@ static error_t pahole__options_parser(in
 		  fputs("pahole: Multithreading requires elfutils >= 0.178. Continuing with a single thread...\n", stderr);
 #endif
 							break;
+#ifdef HAVE_BPF
 	case ARGP_btf_encode_detached:
 		  detached_btf_filename = arg; // fallthru
 	case 'J': btf_encode = 1;
@@ -1544,6 +1551,7 @@ static error_t pahole__options_parser(in
 		  conf_load.ignore_labels	     = true;
 		  conf_load.use_obstack		     = true;
 		  no_bitfield_type_recode = true;	break;
+#endif
 	case 'l': conf.show_first_biggest_size_base_type_member = 1;	break;
 	case 'M': conf.show_only_data_members = 1;	break;
 	case 'm': stats_formatter = nr_methods_formatter; break;
@@ -1617,21 +1625,25 @@ static error_t pahole__options_parser(in
 		conf.range = arg;			break;
 	case ARGP_header_type:
 		conf.header_type = arg;			break;
+#ifdef HAVE_BPF
 	case ARGP_skip_encoding_btf_vars:
 		skip_encoding_btf_vars = true;		break;
 	case ARGP_btf_encode_force:
 		btf_encode_force = true;		break;
 	case ARGP_btf_base:
 		base_btf_file = arg;			break;
+#endif
 	case ARGP_kabi_prefix:
 		conf_load.kabi_prefix = arg;
 		conf_load.kabi_prefix_len = strlen(arg); break;
 	case ARGP_numeric_version:
 		print_numeric_version = true;		break;
+#ifdef HAVE_BPF
 	case ARGP_btf_gen_floats:
 		btf_gen_floats = true;			break;
 	case ARGP_btf_gen_all:
 		btf_gen_floats = true;			break;
+#endif
 	case ARGP_with_flexible_array:
 		show_with_flexible_array = true;	break;
 	case ARGP_prettify_input_filename:
@@ -2792,6 +2804,7 @@ static enum load_steal_kind pahole_steal
 		cu__fprintf_ptr_table_stats_csv(cu, stderr);
 	}
 
+#ifdef HAVE_BTF
 	if (btf_encode) {
 		static pthread_mutex_t btf_lock = PTHREAD_MUTEX_INITIALIZER;
 
@@ -2820,6 +2833,7 @@ out_btf:
 		pthread_mutex_unlock(&btf_lock);
 		return ret;
 	}
+#endif
 #if 0
 	if (ctf_encode) {
 		cu__encode_ctf(cu, global_verbose);
@@ -3153,6 +3167,7 @@ int main(int argc, char *argv[])
 		}
 	}
 
+#ifdef HAVE_BPF
 	if (base_btf_file) {
 		conf_load.base_btf = btf__parse(base_btf_file, NULL);
 		if (libbpf_get_error(conf_load.base_btf)) {
@@ -3165,6 +3180,7 @@ int main(int argc, char *argv[])
 			conf_load.format_path = "btf";
 		}
 	}
+#endif
 
 	struct cus *cus = cus__new();
 	if (cus == NULL) {
@@ -3187,6 +3203,7 @@ try_sole_arg_as_class_names:
 	if (class_name && populate_class_names())
 		goto out_dwarves_exit;
 
+#ifdef HAVE_BPF
 	if (base_btf_file == NULL) {
 		const char *filename = argv[remaining];
 
@@ -3202,6 +3219,7 @@ try_sole_arg_as_class_names:
 			}
 		}
 	}
+#endif
 
 	err = cus__load_files(cus, &conf_load, argv + remaining);
 	if (err != 0) {
@@ -3261,6 +3279,7 @@ try_sole_arg_as_class_names:
 	type_instance__delete(header);
 	header = NULL;
 
+#ifdef HAVE_BTF
 	if (btf_encode) {
 		err = btf_encoder__encode(btf_encoder);
 		if (err) {
@@ -3268,6 +3287,7 @@ try_sole_arg_as_class_names:
 			goto out_cus_delete;
 		}
 	}
+#endif
 out_ok:
 	if (stats_formatter != NULL)
 		print_stats();
@@ -3277,9 +3297,11 @@ out_cus_delete:
 #ifdef DEBUG_CHECK_LEAKS
 	cus__delete(cus);
 	structures__delete();
+#ifdef HAVE_BTF
 	btf__free(conf_load.base_btf);
 	conf_load.base_btf = NULL;
 #endif
+#endif
 out_dwarves_exit:
 	if (prettify_input && prettify_input != stdin) {
 		fclose(prettify_input);
Index: b/dwarves.c
===================================================================
--- a/dwarves.c
+++ b/dwarves.c
@@ -1979,8 +1979,10 @@ extern struct debug_fmt_ops dwarf__ops,
 
 static struct debug_fmt_ops *debug_fmt_table[] = {
 	&dwarf__ops,
+#ifdef HAVE_BPF
 	&btf__ops,
 	&ctf__ops,
+#endif
 	NULL,
 };
 
-- 
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05
