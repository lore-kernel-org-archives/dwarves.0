Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DB1C433EF
	for <linux-dwarves@archiver.kernel.org>; Fri, 15 Oct 2021 13:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6277560C49
	for <linux-dwarves@archiver.kernel.org>; Fri, 15 Oct 2021 13:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236181AbhJONUu (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 15 Oct 2021 09:20:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:40304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234701AbhJONUu (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Fri, 15 Oct 2021 09:20:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94EE561151;
        Fri, 15 Oct 2021 13:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634303924;
        bh=v+ib5m7GL+R0KpCj0s3iAQUvroy/WUABVSWZwa/NRdM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q6OBq25qg0JJqbxzpmYH8Fu2aoGg4OSCMM/WUCI1xMw07SVlgPksxGDxj68LFcxQi
         GcPqmrVJ64shMYNMF41k2bPUocROYeQOm0QjoquxxCrYWY+FVLIgFh7KCiN5Vmc9p3
         jE+jqEclRyIcz8FOudmDEr2BJhfjpUMzNkx9cj/VMZCK1AfaPhdAi0b04RpYRGLuzE
         kArI3EAYro66FpzvaYdJgNERr9htEzmSBPyQ/RtWHgUxqrurbpRxvKTXRe2CmcYURG
         xkOSl7IXUKBImXYTqTGgSHyXQ5uD2gsdJFXNRDbrIgxv/XaxcI1Yxlg1zxJ3cUmjsd
         4JUqvoyD0vUDw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 29D70410A1; Fri, 15 Oct 2021 10:18:41 -0300 (-03)
Date:   Fri, 15 Oct 2021 10:18:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Douglas RAILLARD <douglas.raillard@arm.com>
Cc:     acme@redhat.com, dwarves@vger.kernel.org
Subject: Re: [PATCH] CMakeLists.txt: Add STATIC_LINK option
Message-ID: <YWl/sfJLWEHGdJwV@kernel.org>
References: <20211015101008.486302-1-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211015101008.486302-1-douglas.raillard@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Fri, Oct 15, 2021 at 11:10:08AM +0100, Douglas RAILLARD escreveu:
> From: Douglas Raillard <douglas.raillard@arm.com>
> 
> Add a user-defined STATIC_LINK option that can be used to build a fully
> static binary for the executables:
> 
>     cmake .. -DSTATIC_LINK=ON
> 
> This has been tested on Alpine Linux v3.14.

Cool, in addition to:

⬢[acme@toolbox pahole]$ cmake -D__LIB=lib -DBUILD_SHARED_LIBS=OFF ..
<SNIP>
⬢[acme@toolbox pahole]$ ls -la build
total 11428
drwxr-xr-x. 1 acme acme     342 Oct 15 10:15 .
drwxrwxr-x. 1 acme acme    3228 Oct 15 10:15 ..
-rw-r--r--. 1 acme acme   14858 Oct 15 10:15 CMakeCache.txt
drwxr-xr-x. 1 acme acme     598 Oct 15 10:15 CMakeFiles
-rw-r--r--. 1 acme acme   20280 Oct 15 10:15 cmake_install.cmake
-rwxr-xr-x. 1 acme acme 1027016 Oct 15 10:15 codiff
-rwxr-xr-x. 1 acme acme 1067304 Oct 15 10:15 ctracer
-rwxr-xr-x. 1 acme acme  999648 Oct 15 10:15 dtagnames
-rw-r--r--. 1 acme acme 2112500 Oct 15 10:15 libdwarves.a
-rw-r--r--. 1 acme acme   40086 Oct 15 10:15 libdwarves_emit.a
-rw-r--r--. 1 acme acme   40558 Oct 15 10:15 libdwarves_reorganize.a
-rw-r--r--. 1 acme acme   45792 Oct 15 10:15 Makefile
-rwxr-xr-x. 1 acme acme 1160712 Oct 15 10:15 pahole
-rwxr-xr-x. 1 acme acme 1009408 Oct 15 10:15 pdwtags
-rwxr-xr-x. 1 acme acme 1044160 Oct 15 10:15 pfunct
-rwxr-xr-x. 1 acme acme 1011488 Oct 15 10:15 pglobal
-rwxr-xr-x. 1 acme acme 1008784 Oct 15 10:15 prefcnt
-rwxr-xr-x. 1 acme acme   62096 Oct 15 10:15 scncopy
-rwxr-xr-x. 1 acme acme 1008392 Oct 15 10:15 syscse
⬢[acme@toolbox pahole]$ ldd build/pahole
	linux-vdso.so.1 (0x00007ffc3fd48000)
	libdw.so.1 => /lib64/libdw.so.1 (0x00007f7c9592b000)
	libelf.so.1 => /lib64/libelf.so.1 (0x00007f7c95910000)
	libz.so.1 => /lib64/libz.so.1 (0x00007f7c958f6000)
	libpthread.so.0 => /lib64/libpthread.so.0 (0x00007f7c958d5000)
	libc.so.6 => /lib64/libc.so.6 (0x00007f7c95706000)
	libdl.so.2 => /lib64/libdl.so.2 (0x00007f7c956ff000)
	libzstd.so.1 => /lib64/libzstd.so.1 (0x00007f7c95607000)
	liblzma.so.5 => /lib64/liblzma.so.5 (0x00007f7c955db000)
	libbz2.so.1 => /lib64/libbz2.so.1 (0x00007f7c955c8000)
	/lib64/ld-linux-x86-64.so.2 (0x00007f7c959ce000)
⬢[acme@toolbox pahole]$

That is just for libdwarves. Humm, with your patch I'm getting this
warning:

⬢[acme@toolbox pahole]$ rm -rf build
⬢[acme@toolbox pahole]$ mkdir build
⬢[acme@toolbox pahole]$ cd build
⬢[acme@toolbox build]$ cmake -DSTATIC_LINK=ON ..
-- The C compiler identification is GNU 11.2.1
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Check for working C compiler: /usr/bin/cc - skipped
-- Detecting C compile features
-- Detecting C compile features - done
-- Setting BUILD_SHARED_LIBS = ON
-- Checking availability of DWARF and ELF development libraries
-- Looking for dwfl_module_build_id in elf
-- Looking for dwfl_module_build_id in elf - found
-- Found dwarf.h header: /usr/include
-- Found elfutils/libdw.h header: /usr/include
-- Found libdw library: /usr/lib64/libdw.so
-- Found libelf library: /usr/lib64/libelf.so
-- Checking availability of DWARF and ELF development libraries - done
-- Found ZLIB: /usr/lib64/libz.so (found version "1.2.11")
-- Checking availability of argp library
-- Assuming argp is in libc
-- Checking availability of argp library - done
-- Checking availability of obstack library
-- Assuming obstack is in libc
-- Checking availability of obstack library - done
-- Submodule update
-- Submodule update - done
-- Performing Test HAVE_REALLOCARRAY_SUPPORT
-- Performing Test HAVE_REALLOCARRAY_SUPPORT - Success
-- Configuring done
-- Generating done
CMake Warning:
  Manually-specified variables were not used by the project:

    STATIC_LINK


-- Build files have been written to: /var/home/acme/git/pahole/build
⬢[acme@toolbox build]$

And when I build I don't get a static binary, can you check? I'm doing a
bit of investigation now.

- Arnaldo

 
> Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
> ---
>  CMakeLists.txt                | 21 +++++++++++++++------
>  README                        |  3 +++
>  cmake/modules/FindDWARF.cmake | 10 ++++++++++
>  3 files changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/CMakeLists.txt b/CMakeLists.txt
> index 2ab66e4..ba467bf 100644
> --- a/CMakeLists.txt
> +++ b/CMakeLists.txt
> @@ -34,6 +34,15 @@ macro(_set_fancy _var _value _comment)
>  	endif (NOT DEFINED ${_var})
>  endmacro(_set_fancy)
>  
> +option(BUILD_SHARED_LIBS "Build internal libraries as shared libraries" ON)
> +option(STATIC_LINK "Create statically linked executables" OFF)
> +if (STATIC_LINK)
> +  string(APPEND CMAKE_C_FLAGS " -static")
> +  string(APPEND CMAKE_EXE_LINKER_FLAGS " -static")
> +  set(CMAKE_FIND_LIBRARY_SUFFIXES .a)
> +  set(BUILD_SHARED_LIBS OFF)
> +endif()
> +
>  # where to look first for cmake modules,
>  # before ${CMAKE_ROOT}/Modules/ is checked
>  set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake/modules")
> @@ -48,11 +57,6 @@ set(CMAKE_C_FLAGS_DEBUG "-Wall -Werror -ggdb -O0")
>  set(CMAKE_C_FLAGS_RELEASE "-Wall -O2")
>  SET(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -pthread")
>  
> -if (NOT DEFINED BUILD_SHARED_LIBS)
> -	set (BUILD_SHARED_LIBS ON)
> -	message(STATUS "Setting BUILD_SHARED_LIBS = ${BUILD_SHARED_LIBS}")
> -endif (NOT DEFINED BUILD_SHARED_LIBS)
> -
>  # Just for grepping, DWARVES_VERSION isn't used anywhere anymore
>  # add_definitions(-D_GNU_SOURCE -DDWARVES_VERSION="v1.22")
>  add_definitions(-D_GNU_SOURCE -DDWARVES_MAJOR_VERSION=1)
> @@ -123,7 +127,7 @@ endif()
>  add_library(dwarves ${dwarves_LIB_SRCS})
>  set_target_properties(dwarves PROPERTIES VERSION 1.0.0 SOVERSION 1)
>  set_target_properties(dwarves PROPERTIES INTERFACE_LINK_LIBRARIES "")
> -target_link_libraries(dwarves ${DWARF_LIBRARIES} ${ZLIB_LIBRARIES} ${LIBBPF_LIBRARIES} ${ARGP_LIBRARY} ${OBSTACK_LIBRARY})
> +target_link_libraries(dwarves ${DWARF_LIBRARIES} ${ZLIB_LIBRARIES} ${LIBBPF_LIBRARIES} ${ARGP_LIBRARY} ${OBSTACK_LIBRARY} ${BZ2_LIBRARY} ${LZMA_LIBRARY})
>  
>  set(dwarves_emit_LIB_SRCS dwarves_emit.c)
>  add_library(dwarves_emit ${dwarves_emit_LIB_SRCS})
> @@ -193,3 +197,8 @@ endif()
>  install(PROGRAMS btfdiff fullcircle DESTINATION ${CMAKE_INSTALL_PREFIX}/bin)
>  install(FILES lib/Makefile lib/ctracer_relay.c lib/ctracer_relay.h lib/linux.blacklist.cu
>  	DESTINATION ${CMAKE_INSTALL_PREFIX}/share/dwarves/runtime)
> +
> +# Avoid having a trailing -Wl,-Bdynamic that will make some linkers think we
> +# need to link against a DSO for the libc.
> +get_property(TARGETS DIRECTORY PROPERTY BUILDSYSTEM_TARGETS)
> +set_target_properties(${TARGETS} PROPERTIES LINK_SEARCH_END_STATIC ${STATIC_LINK})
> diff --git a/README b/README
> index c9f1737..5798458 100644
> --- a/README
> +++ b/README
> @@ -18,6 +18,9 @@ cmake Options:
>      Default is to install to /usr/local, use -DCMAKE_INSTALL_PREFIX=
>      when invoking cmake to specify another install location.
>  
> +  -DSTATIC_LINK
> +    Build a statically linked binary. Default is OFF.
> +
>  Known to work scenarios:
>  
>  Mandriva Cooker:
> diff --git a/cmake/modules/FindDWARF.cmake b/cmake/modules/FindDWARF.cmake
> index 027d06e..1b4ac49 100644
> --- a/cmake/modules/FindDWARF.cmake
> +++ b/cmake/modules/FindDWARF.cmake
> @@ -37,6 +37,16 @@ find_library(ELF_LIBRARY
>  	PATHS /usr/lib /usr/local/lib /usr/lib64 /usr/local/lib64 ~/usr/local/lib ~/usr/local/lib64
>  )
>  
> +find_library(BZ2_LIBRARY
> +	NAMES bz2
> +	PATHS /usr/lib /usr/local/lib /usr/lib64 /usr/local/lib64 ~/usr/local/lib ~/usr/local/lib64
> +)
> +
> +find_library(LZMA_LIBRARY
> +	NAMES lzma
> +	PATHS /usr/lib /usr/local/lib /usr/lib64 /usr/local/lib64 ~/usr/local/lib ~/usr/local/lib64
> +)
> +
>  if (DWARF_INCLUDE_DIR AND LIBDW_INCLUDE_DIR AND DWARF_LIBRARY AND ELF_LIBRARY)
>  	set(DWARF_FOUND TRUE)
>  	set(DWARF_LIBRARIES ${DWARF_LIBRARY} ${ELF_LIBRARY})
> -- 
> 2.25.1

-- 

- Arnaldo
