Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAE7C43217
	for <linux-dwarves@archiver.kernel.org>; Wed, 13 Jan 2021 11:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFF58233F9
	for <linux-dwarves@archiver.kernel.org>; Wed, 13 Jan 2021 11:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbhAMLSN (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 13 Jan 2021 06:18:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:43202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726862AbhAMLSM (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Wed, 13 Jan 2021 06:18:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A5D723358;
        Wed, 13 Jan 2021 11:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610536651;
        bh=+mVQryQ+KKiajXozl7lDQWa8OugeeqlHnpRJXkTgFSw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lNbUXS1GZqRzo5wQNMXdAEGcZh4S0qQVJSMduPfUagPmdUaHHJ90rbq2Vvc7TRiT7
         fowFACLzVFz29lR3j2AgMMs3as/5/TJgmlD8T1JoTqU2qwrv2om416WZ7vsgvMk290
         1x/8Mx1RVjLy7zDb1WQkIho0zaPjk2Y5BRpRPDxjETfF4drdEQfTnidGNznk1pfkVu
         VY2x/nbxA42LFPMfguY0I/qGYZMl1cVU1nH6FHpAzgzj7VqKrJIOcg/Lsp2hObB3T0
         vDV594A5QwfUn+JPfkE7L0QU+rm1/cjHgmfYVWarmqIjxKwKvaBfDpMAQlE0blLQtU
         uckCMNX8JavJg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 07BF5411E9; Wed, 13 Jan 2021 08:18:03 -0300 (-03)
Date:   Wed, 13 Jan 2021 08:18:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Luca Boccassi <bluca@debian.org>
Cc:     dwarves@vger.kernel.org
Subject: Re: [PATCH dwarves v3] libbpf: allow to use packaged version
Message-ID: <20210113111803.GC3816@kernel.org>
References: <20210103213201.829827-1-bluca@debian.org>
 <20210104221622.256663-1-bluca@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104221622.256663-1-bluca@debian.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Mon, Jan 04, 2021 at 10:16:22PM +0000, Luca Boccassi escreveu:
> Add a new CMake option, LIBBPF_EMBEDDED, to switch between the
> embedded version and the system version (searched via pkg-config)
> of libbpf. Set the embedded version as the default.

I'm coming back from vacation, will try to check this soon.

Thanks,

- Arnaldo
 
> Signed-off-by: Luca Boccassi <bluca@debian.org>
> ---
> v2: switched default to use embedded version
> v3: add lib/include/bpf -> lib/bpf/src symlink to allow using 'system'
>     style #include everywhere, rather than #ifdefs.
>     Thanks Andrii for the suggestion!
> 
>  CMakeLists.txt   | 43 ++++++++++++++++++++++++++++++-------------
>  btf_encoder.c    |  4 ++--
>  btf_loader.c     |  2 +-
>  lib/include/bpf  |  1 +
>  libbtf.c         |  7 +++----
>  libbtf.h         |  2 +-
>  pahole.c         |  2 +-
>  pahole_strings.h |  2 +-
>  strings.c        |  2 +-
>  9 files changed, 41 insertions(+), 24 deletions(-)
>  create mode 120000 lib/include/bpf
> 
> diff --git a/CMakeLists.txt b/CMakeLists.txt
> index 857487a..eefdebe 100644
> --- a/CMakeLists.txt
> +++ b/CMakeLists.txt
> @@ -2,9 +2,24 @@ project(pahole C)
>  cmake_minimum_required(VERSION 2.8.8)
>  cmake_policy(SET CMP0005 NEW)
>  
> +option(LIBBPF_EMBEDDED "Use the embedded version of libbpf instead of searching it via pkg-config" ON)
> +if (NOT LIBBPF_EMBEDDED)
> +	find_package(PkgConfig)
> +	if(PKGCONFIG_FOUND)
> +		pkg_check_modules(LIBBPF libbpf>=0.3.0)
> +	endif()
> +endif()
> +
>  INCLUDE_DIRECTORIES(${CMAKE_CURRENT_BINARY_DIR}
> -		    ${CMAKE_CURRENT_SOURCE_DIR}
> -		    ${CMAKE_CURRENT_SOURCE_DIR}/lib/bpf/include/uapi)
> +		    ${CMAKE_CURRENT_SOURCE_DIR})
> +if(NOT LIBBPF_FOUND)
> +	# Allows to use 'system' style #include with both embedded and system libbpf
> +	INCLUDE_DIRECTORIES(${CMAKE_CURRENT_SOURCE_DIR}/lib/include)
> +	INCLUDE_DIRECTORIES(${CMAKE_CURRENT_SOURCE_DIR}/lib/bpf/include/uapi)
> +else()
> +	INCLUDE_DIRECTORIES(${LIBBPF_INCLUDE_DIRS})
> +	LINK_DIRECTORIES(${LIBBPF_LIBRARY_DIRS})
> +endif()
>  
>  # Try to parse this later, Helio just showed me a KDE4 example to support
>  # x86-64 builds.
> @@ -56,7 +71,7 @@ if(GIT_FOUND AND EXISTS "${PROJECT_SOURCE_DIR}/.git")
>  		endif()
>  	endif()
>  endif()
> -if(NOT EXISTS "${PROJECT_SOURCE_DIR}/lib/bpf/src/btf.h")
> +if(NOT LIBBPF_FOUND AND NOT EXISTS "${PROJECT_SOURCE_DIR}/lib/bpf/src/btf.h")
>  	message(FATAL_ERROR "The submodules were not downloaded! GIT_SUBMODULE was turned off or failed. Please update submodules and try again.")
>  endif()
>  
> @@ -81,22 +96,24 @@ endif()
>  
>  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64")
>  
> -file(GLOB libbpf_sources "lib/bpf/src/*.c")
> -add_library(bpf OBJECT ${libbpf_sources})
> -set_property(TARGET bpf PROPERTY POSITION_INDEPENDENT_CODE 1)
> -target_include_directories(bpf PRIVATE
> -			   ${CMAKE_CURRENT_SOURCE_DIR}/lib/bpf/include
> -			   ${CMAKE_CURRENT_SOURCE_DIR}/lib/bpf/include/uapi)
> +if (NOT LIBBPF_FOUND)
> +	file(GLOB libbpf_sources "lib/bpf/src/*.c")
> +	add_library(bpf OBJECT ${libbpf_sources})
> +	set_property(TARGET bpf PROPERTY POSITION_INDEPENDENT_CODE 1)
> +	target_include_directories(bpf PRIVATE
> +				   ${CMAKE_CURRENT_SOURCE_DIR}/lib/bpf/include)
> +endif()
>  
>  set(dwarves_LIB_SRCS dwarves.c dwarves_fprintf.c gobuffer strings
>  		     ctf_encoder.c ctf_loader.c libctf.c btf_encoder.c btf_loader.c libbtf.c
>  		     dwarf_loader.c dutil.c elf_symtab.c rbtree.c)
> -add_library(dwarves SHARED ${dwarves_LIB_SRCS} $<TARGET_OBJECTS:bpf>)
> +if (NOT LIBBPF_FOUND)
> +	list(APPEND dwarves_LIB_SRCS $<TARGET_OBJECTS:bpf>)
> +endif()
> +add_library(dwarves SHARED ${dwarves_LIB_SRCS})
>  set_target_properties(dwarves PROPERTIES VERSION 1.0.0 SOVERSION 1)
>  set_target_properties(dwarves PROPERTIES INTERFACE_LINK_LIBRARIES "")
> -target_include_directories(dwarves PRIVATE
> -			   ${CMAKE_CURRENT_SOURCE_DIR}/lib/bpf/include/uapi)
> -target_link_libraries(dwarves ${DWARF_LIBRARIES} ${ZLIB_LIBRARIES})
> +target_link_libraries(dwarves ${DWARF_LIBRARIES} ${ZLIB_LIBRARIES} ${LIBBPF_LIBRARIES})
>  
>  set(dwarves_emit_LIB_SRCS dwarves_emit.c)
>  add_library(dwarves_emit SHARED ${dwarves_emit_LIB_SRCS})
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 3339730..76e7d43 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -11,12 +11,12 @@
>  
>  #include "dwarves.h"
>  #include "libbtf.h"
> -#include "lib/bpf/include/uapi/linux/btf.h"
> -#include "lib/bpf/src/libbpf.h"
>  #include "hash.h"
>  #include "elf_symtab.h"
>  #include "btf_encoder.h"
>  
> +#include <linux/btf.h>
> +#include <bpf/libbpf.h>
>  #include <ctype.h> /* for isalpha() and isalnum() */
>  #include <stdlib.h> /* for qsort() and bsearch() */
>  #include <inttypes.h>
> diff --git a/btf_loader.c b/btf_loader.c
> index ec286f4..fa85d06 100644
> --- a/btf_loader.c
> +++ b/btf_loader.c
> @@ -20,12 +20,12 @@
>  #include <string.h>
>  #include <limits.h>
>  #include <libgen.h>
> +#include <linux/btf.h>
>  #include <zlib.h>
>  
>  #include <gelf.h>
>  
>  #include "libbtf.h"
> -#include "lib/bpf/include/uapi/linux/btf.h"
>  #include "dutil.h"
>  #include "dwarves.h"
>  
> diff --git a/lib/include/bpf b/lib/include/bpf
> new file mode 120000
> index 0000000..4c41b71
> --- /dev/null
> +++ b/lib/include/bpf
> @@ -0,0 +1 @@
> +../bpf/src
> \ No newline at end of file
> diff --git a/libbtf.c b/libbtf.c
> index 16e1d45..3cc2ac5 100644
> --- a/libbtf.c
> +++ b/libbtf.c
> @@ -16,12 +16,11 @@
>  #include <sys/stat.h>
>  #include <unistd.h>
>  #include <stdarg.h>
> +#include <linux/btf.h>
> +#include <bpf/btf.h>
> +#include <bpf/libbpf.h>
>  
>  #include "libbtf.h"
> -#include "lib/bpf/include/uapi/linux/btf.h"
> -#include "lib/bpf/include/linux/err.h"
> -#include "lib/bpf/src/btf.h"
> -#include "lib/bpf/src/libbpf.h"
>  #include "dutil.h"
>  #include "gobuffer.h"
>  #include "dwarves.h"
> diff --git a/libbtf.h b/libbtf.h
> index 191f586..0b99767 100644
> --- a/libbtf.h
> +++ b/libbtf.h
> @@ -11,7 +11,7 @@
>  
>  #include <stdbool.h>
>  #include <stdint.h>
> -#include "lib/bpf/src/btf.h"
> +#include <bpf/btf.h>
>  
>  struct btf_elf {
>  	void		  *priv;
> diff --git a/pahole.c b/pahole.c
> index 4a34ba5..68dd166 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -16,6 +16,7 @@
>  #include <stdlib.h>
>  #include <string.h>
>  #include <unistd.h>
> +#include <bpf/libbpf.h>
>  
>  #include "dwarves_reorganize.h"
>  #include "dwarves.h"
> @@ -23,7 +24,6 @@
>  #include "ctf_encoder.h"
>  #include "btf_encoder.h"
>  #include "libbtf.h"
> -#include "lib/bpf/src/libbpf.h"
>  
>  static bool btf_encode;
>  static bool ctf_encode;
> diff --git a/pahole_strings.h b/pahole_strings.h
> index 522fbf2..657701b 100644
> --- a/pahole_strings.h
> +++ b/pahole_strings.h
> @@ -6,7 +6,7 @@
>    Copyright (C) 2008 Arnaldo Carvalho de Melo <acme@redhat.com>
>  */
>  
> -#include "lib/bpf/src/btf.h"
> +#include <bpf/btf.h>
>  
>  typedef unsigned int strings_t;
>  
> diff --git a/strings.c b/strings.c
> index d37f49d..8244c49 100644
> --- a/strings.c
> +++ b/strings.c
> @@ -13,9 +13,9 @@
>  #include <stdio.h>
>  #include <string.h>
>  #include <zlib.h>
> +#include <bpf/libbpf.h>
>  
>  #include "dutil.h"
> -#include "lib/bpf/src/libbpf.h"
>  
>  struct strings *strings__new(void)
>  {
> -- 
> 2.29.2
> 

-- 

- Arnaldo
