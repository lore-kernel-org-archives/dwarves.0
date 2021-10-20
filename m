Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1EFC433EF
	for <linux-dwarves@archiver.kernel.org>; Wed, 20 Oct 2021 12:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A44F860F56
	for <linux-dwarves@archiver.kernel.org>; Wed, 20 Oct 2021 12:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhJTMvp (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 20 Oct 2021 08:51:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:58958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229702AbhJTMvp (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Wed, 20 Oct 2021 08:51:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7EBB60F56;
        Wed, 20 Oct 2021 12:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634734171;
        bh=+cZN/KmXmfPE29HZMMvW4uhrMoXj11709VlF0cOHHwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EqaYVE1V0djJ4MVwkyXfhKMmU+g0LbUuZeb+gjYO/ltSRPAPxTAx7SwRdocghXgFB
         UnuzaqZ2D4gozQ5PspQuR4Te2aml1S0dFOFmdhzP63dCiGYUqIt1EwUzCdxGtZ2Gke
         FIU+ldXT/NLLDg96WiU8sDeePvnIQJINl793hOaKNYxG+HasvyqfgKUZaC2g8aMd3Q
         JLrxGUS1QzrMh6G+BbH3Xye9itr6DUr/Nzdsfl22tdUKBfnyQNrawrIXYZEQAzqxs7
         ocmpmMMk1KFVnufnqLCv8+HmhsventsNcgP68pth3wLRCKawL+U+DQF/weSd9STkpq
         yf9wi5uWan9bA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5F48D410A1; Wed, 20 Oct 2021 09:49:27 -0300 (-03)
Date:   Wed, 20 Oct 2021 09:49:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Douglas Raillard <douglas.raillard@arm.com>
Cc:     acme@redhat.com, dwarves@vger.kernel.org
Subject: Re: [PATCH] CMakeLists.txt: Add STATIC_LINK option
Message-ID: <YXAQV7xwDU0qFr0Q@kernel.org>
References: <20211015101008.486302-1-douglas.raillard@arm.com>
 <YWl/sfJLWEHGdJwV@kernel.org>
 <YWmAo8Xv5YZBlL41@kernel.org>
 <YWmOOP0/fF2BEd/s@kernel.org>
 <7718fdaa-a8ec-c86d-e5e6-149db8659529@arm.com>
 <YW7jRGV9Ny1KFEtO@kernel.org>
 <ececd809-672a-c922-0e24-745c8eaf2e43@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ececd809-672a-c922-0e24-745c8eaf2e43@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Tue, Oct 19, 2021 at 06:29:41PM +0100, Douglas Raillard escreveu:
> On 10/19/21 4:24 PM, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Oct 18, 2021 at 10:57:43AM +0100, Douglas Raillard escreveu:
> > > On 10/15/21 3:20 PM, Arnaldo Carvalho de Melo wrote:
> > > > Em Fri, Oct 15, 2021 at 10:22:43AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > > Em Fri, Oct 15, 2021 at 10:18:41AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > > CMake Error at cmake/modules/FindDWARF.cmake:103 (message):
> > > > >     Could NOT find some ELF and DWARF libraries, please install the missing
> > > > >     packages
> > > > > Call Stack (most recent call first):
> > > > >     CMakeLists.txt:64 (find_package)
> > > > > 
> > > > > 
> > > > > -- Configuring incomplete, errors occurred!
> > > > > See also "/var/home/acme/git/pahole/build/CMakeFiles/CMakeOutput.log".
> > > > > ⬢[acme@toolbox build]$
> > > > > 
> > > > > Which means I don't have those static library files, will try installing
> > > > > them.
> > > > 
> > > > I'm trying with the latest fedora that comes with static libraries,
> > > > fedora:32, and there I noticed that we need to look for libzstd as well,
> > > > I added it manually to:
> > > > 
> > > > target_link_libraries(dwarves ${DWARF_LIBRARIES} ${ZLIB_LIBRARIES} ${LIBBPF_LIBRARIES} ${ARGP_LIBRARY} ${OBSTACK_LIBRARY} ${BZ2_LIBRARY} ${LZMA_LIBRARY} -lzstd)
> > > > 
> > > > [root@cc85f3a7b96f dwarves-1.22]# rpm -qa | grep -- -static
> > > > zlib-static-1.2.11-21.fc32.x86_64
> > > > glibc-static-2.31-6.fc32.x86_64
> > > > elfutils-devel-static-0.183-1.fc32.x86_64
> > > > xz-static-5.2.5-1.fc32.x86_64
> > > > libxcrypt-static-4.4.20-2.fc32.x86_64
> > > > libzstd-static-1.4.9-1.fc32.x86_64
> > > > elfutils-libelf-devel-static-0.183-1.fc32.x86_64
> > > > bzip2-static-1.0.8-2.fc32.x86_64
> > > > [root@cc85f3a7b96f dwarves-1.22]# cat /etc/fedora-release
> > > > Fedora release 32 (Thirty Two)
> > > > [root@cc85f3a7b96f dwarves-1.22]#
> > > > 
> > > > now I'm at:
> > > > 
> > > > /usr/bin/ld: /usr/lib/gcc/x86_64-redhat-linux/10/../../../../lib64/libdw.a(debuginfod-client.o): in function `__libdwfl_debuginfod_init':
> > > > (.text.startup[.text.startup.group]+0x1b): undefined reference to `dlopen'
> > > > /usr/bin/ld: (.text.startup[.text.startup.group]+0x36): undefined reference to `dlsym'
> > > > /usr/bin/ld: (.text.startup[.text.startup.group]+0x4f): undefined reference to `dlsym'
> > > > /usr/bin/ld: (.text.startup[.text.startup.group]+0x68): undefined reference to `dlsym'
> > > > /usr/bin/ld: (.text.startup[.text.startup.group]+0x81): undefined reference to `dlsym'
> > > > /usr/bin/ld: (.text.startup[.text.startup.group]+0xe0): undefined reference to `dlclose'
> > > > 
> > > > that needs some more magic that I already forgot :-\
> > > 
> > > When trying on Ubuntu it also appeared that find_library() for libebl
> > > was also needed, but not on Alpine Linux so I did not include it, as it
> > > does not seem necessary on Alpine. I'm not sure how we want to go about
> > > these:
> > > 1) Take the union of all the dependencies that seem to be necessary and
> > > deal gracefully in CMakeLists.txt with failure to find a lib. This will
> > > result in linker error if a lib is actually necessary and not found.
> > > 2) Select a blessed distro for static building and only maintain that
> > > 3) Find some cmake builtin "magic" so that the user can point at
> > > existing lib that seem to not be detected on their distro. I'm quite
> > > rusty in cmake so maybe there is a better way than sprinkling
> > > find_library() everywhere.
> > > 
> > > So far I opted for approach 2) with Alpine, as building on e.g. Ubuntu
> > > will not work in any case, because glibc does not support static linking
> > > (it kind of does until it does not anymore). Alpine uses the musl libc
> > > which supports static linking.
> > > 
> > > As for the dlopen/dlsym/dlclose issue I'm not sure. Maybe these symbols
> > > are just not present in static glibc ? The binary I produced on Alpine
> > > did not seem to segfault [1]. If you want to give it a go, this scripts
> > > set it up in ~20s:
> > > https://github.com/alpinelinux/alpine-chroot-install
> > > 
> > > Packages: bash gcc git make cmake musl-dev zlib-static bzip2-static
> > > libelf-static libbpf-dev musl-obstack-dev argp-standalone linux-headers
> > 
> > I'll try with this later, thing is, I want to build on the CI for pahole
> > that Andrii put in place in the libbpf repo, so we need to check how to
> > build this static build.
> 
> I tried to make it work on Ubuntu and came up with that. It is quite stinky
> and does not result in a fully static build, but it's probably as close we can
> get to it using glibc, and it does not segfault:

I'll test it, the first time I tried the BZ2 (and others maybe) lib
became a new requirement for building pahole even whe not requesting a
static link, which is undesirable, I'll check this time around.

- Arnaldo
 
> > > > ldd pahole
>         linux-vdso.so.1 (0x00007ffd9b7e2000)
>         libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007f049a55e000)
>         libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007f049a53b000)
>         libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f049a349000)
>         /lib/ld64.so.1 => /lib64/ld-linux-x86-64.so.2 (0x00007f049a584000)
> 
> 
> Subject: [PATCH] CMakeLists.txt: Allow pseudo-static build on Ubuntu
> 
> Allow STATIC_LINK=ON on Ubuntu by:
> 
>     * providing libebl
>     * avoiding a trailing -Wl,-Bstatic that makes the resulting binary
>       segfault
>     * dynamically link to libdl. Static linking to that lib would impose
>       that the same glibc version used for linking is present on the
>       runtime system, which is not very safe and would mislead into
>       thinking the binary is safe to use everywhere.
> 
> Apart from that, all the other libraries are statically linked to the
> executable.
> 
> Note: the user might need a symlink /lib/ld64.so.1 => /lib64/ld-linux-x86-64.so.2
> The ld option --dynamic-linker=file is supposed to allow fixing that,
> but it's unfortunately ignored when used with -static.
> ---
>  CMakeLists.txt                | 18 ++++++++++++++++--
>  cmake/modules/FindDWARF.cmake |  8 ++++++++
>  2 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/CMakeLists.txt b/CMakeLists.txt
> index ba467bf..adb6d74 100644
> --- a/CMakeLists.txt
> +++ b/CMakeLists.txt
> @@ -2,6 +2,11 @@ project(pahole C)
>  cmake_minimum_required(VERSION 2.8.12)
>  cmake_policy(SET CMP0005 NEW)
> +execute_process(COMMAND lsb_release -si
> +  OUTPUT_VARIABLE LINUX_DISTRO
> +  OUTPUT_STRIP_TRAILING_WHITESPACE
> +)
> +
>  option(LIBBPF_EMBEDDED "Use the embedded version of libbpf instead of searching it via pkg-config" ON)
>  if (NOT LIBBPF_EMBEDDED)
>  	find_package(PkgConfig REQUIRED)
> @@ -127,7 +132,12 @@ endif()
>  add_library(dwarves ${dwarves_LIB_SRCS})
>  set_target_properties(dwarves PROPERTIES VERSION 1.0.0 SOVERSION 1)
>  set_target_properties(dwarves PROPERTIES INTERFACE_LINK_LIBRARIES "")
> -target_link_libraries(dwarves ${DWARF_LIBRARIES} ${ZLIB_LIBRARIES} ${LIBBPF_LIBRARIES} ${ARGP_LIBRARY} ${OBSTACK_LIBRARY} ${BZ2_LIBRARY} ${LZMA_LIBRARY})
> +target_link_libraries(dwarves ${DWARF_LIBRARIES} ${ZLIB_LIBRARIES} ${LIBBPF_LIBRARIES} ${ARGP_LIBRARY} ${OBSTACK_LIBRARY} ${BZ2_LIBRARY} ${LZMA_LIBRARY} ${EBL_LIBRARY})
> +# On non-musl systems, we need to link to libdl in order to get
> +# dlopen/dlclose/dlsym, as required by libdwfl and libebl
> +if (LINUX_DISTRO STREQUAL "Ubuntu")
> +  target_link_libraries(dwarves dl)
> +endif()
>  set(dwarves_emit_LIB_SRCS dwarves_emit.c)
>  add_library(dwarves_emit ${dwarves_emit_LIB_SRCS})
> @@ -201,4 +211,8 @@ install(FILES lib/Makefile lib/ctracer_relay.c lib/ctracer_relay.h lib/linux.bla
>  # Avoid having a trailing -Wl,-Bdynamic that will make some linkers think we
>  # need to link against a DSO for the libc.
>  get_property(TARGETS DIRECTORY PROPERTY BUILDSYSTEM_TARGETS)
> -set_target_properties(${TARGETS} PROPERTIES LINK_SEARCH_END_STATIC ${STATIC_LINK})
> +# If we use a trailing -Wl,-Bstatic on ubuntu, the binary will segfault for some
> +# reasons ...
> +if (NOT LINUX_DISTRO STREQUAL "Ubuntu")
> +  set_target_properties(${TARGETS} PROPERTIES LINK_SEARCH_END_STATIC ${STATIC_LINK})
> +endif()
> diff --git a/cmake/modules/FindDWARF.cmake b/cmake/modules/FindDWARF.cmake
> index 1b4ac49..cd1f265 100644
> --- a/cmake/modules/FindDWARF.cmake
> +++ b/cmake/modules/FindDWARF.cmake
> @@ -27,6 +27,14 @@ find_path(LIBDW_INCLUDE_DIR elfutils/libdw.h
>  	~/usr/local/include
>  )
> +# This does not seem to be necessary on Alpine Linux
> +if (LINUX_DISTRO STREQUAL "Ubuntu")
> +  find_library(EBL_LIBRARY
> +    NAMES ebl
> +    PATHS /usr/lib /usr/local/lib /usr/lib64 /usr/local/lib64 ~/usr/local/lib ~/usr/local/lib64
> +  )
> +endif()
> +
>  find_library(DWARF_LIBRARY
>  	NAMES dw dwarf
>  	PATHS /usr/lib /usr/local/lib /usr/lib64 /usr/local/lib64 ~/usr/local/lib ~/usr/local/lib64
> -- 
> 2.25.1
> 

-- 

- Arnaldo
