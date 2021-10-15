Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD32FC433EF
	for <linux-dwarves@archiver.kernel.org>; Fri, 15 Oct 2021 14:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CCA76120A
	for <linux-dwarves@archiver.kernel.org>; Fri, 15 Oct 2021 14:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbhJOOlp (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 15 Oct 2021 10:41:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232124AbhJOOlo (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Fri, 15 Oct 2021 10:41:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C01D761073;
        Fri, 15 Oct 2021 14:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634308778;
        bh=dks2uTEsIqCxWqY4qZ92mdwtPbIW7p6UZ9vnERiACfg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f7a2d4IUgtt1+3CO/kGfYht1iRAPQndT01G1BuUFhK8CfSWioGKJY3vtUnI6LQ3H1
         F/BGN1iCZt7VoM0za2Iw6QKPYLqYkTlAMPmj99FidAV1yLu7/mA/l6gEh++CHn6fKf
         52vp6MuBhuVWxQI3oCXsxxCCHIAoK8Ghw59dKI8X3u6jw6SIymhv0Oh1Tf76X3Xr7S
         yfsUwvEvDPrYMZwjB+n//I2ZmzyPoj7eP3KYniRvgOIJumXpaSvEHqj2vgzCl3jI7N
         zx9slKIafWR3BPwgIKs0+TDEPDaAwHr6uHxCDCNRJc5F1OhyGl/JTsNuJcp5y1hqJv
         piqwU9dpeADzg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0146C410A1; Fri, 15 Oct 2021 11:39:34 -0300 (-03)
Date:   Fri, 15 Oct 2021 11:39:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Douglas RAILLARD <douglas.raillard@arm.com>
Cc:     acme@redhat.com, dwarves@vger.kernel.org
Subject: Re: [PATCH] CMakeLists.txt: Add STATIC_LINK option
Message-ID: <YWmSpjBrLUFF87Tj@kernel.org>
References: <20211015101008.486302-1-douglas.raillard@arm.com>
 <YWl/sfJLWEHGdJwV@kernel.org>
 <YWmAo8Xv5YZBlL41@kernel.org>
 <YWmOOP0/fF2BEd/s@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YWmOOP0/fF2BEd/s@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Fri, Oct 15, 2021 at 11:20:40AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Oct 15, 2021 at 10:22:43AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Fri, Oct 15, 2021 at 10:18:41AM -0300, Arnaldo Carvalho de Melo escreveu:
> > CMake Error at cmake/modules/FindDWARF.cmake:103 (message):
> >   Could NOT find some ELF and DWARF libraries, please install the missing
> >   packages
> > Call Stack (most recent call first):
> >   CMakeLists.txt:64 (find_package)
> > 
> > 
> > -- Configuring incomplete, errors occurred!
> > See also "/var/home/acme/git/pahole/build/CMakeFiles/CMakeOutput.log".
> > ⬢[acme@toolbox build]$
> > 
> > Which means I don't have those static library files, will try installing
> > them.
> 
> I'm trying with the latest fedora that comes with static libraries,
> fedora:32, and there I noticed that we need to look for libzstd as well,
> I added it manually to:
> 
> target_link_libraries(dwarves ${DWARF_LIBRARIES} ${ZLIB_LIBRARIES} ${LIBBPF_LIBRARIES} ${ARGP_LIBRARY} ${OBSTACK_LIBRARY} ${BZ2_LIBRARY} ${LZMA_LIBRARY} -lzstd)
> 
> [root@cc85f3a7b96f dwarves-1.22]# rpm -qa | grep -- -static
> zlib-static-1.2.11-21.fc32.x86_64
> glibc-static-2.31-6.fc32.x86_64
> elfutils-devel-static-0.183-1.fc32.x86_64
> xz-static-5.2.5-1.fc32.x86_64
> libxcrypt-static-4.4.20-2.fc32.x86_64
> libzstd-static-1.4.9-1.fc32.x86_64
> elfutils-libelf-devel-static-0.183-1.fc32.x86_64
> bzip2-static-1.0.8-2.fc32.x86_64
> [root@cc85f3a7b96f dwarves-1.22]# cat /etc/fedora-release
> Fedora release 32 (Thirty Two)
> [root@cc85f3a7b96f dwarves-1.22]#
> 
> now I'm at:
> 
> /usr/bin/ld: /usr/lib/gcc/x86_64-redhat-linux/10/../../../../lib64/libdw.a(debuginfod-client.o): in function `__libdwfl_debuginfod_init':
> (.text.startup[.text.startup.group]+0x1b): undefined reference to `dlopen'
> /usr/bin/ld: (.text.startup[.text.startup.group]+0x36): undefined reference to `dlsym'
> /usr/bin/ld: (.text.startup[.text.startup.group]+0x4f): undefined reference to `dlsym'
> /usr/bin/ld: (.text.startup[.text.startup.group]+0x68): undefined reference to `dlsym'
> /usr/bin/ld: (.text.startup[.text.startup.group]+0x81): undefined reference to `dlsym'
> /usr/bin/ld: (.text.startup[.text.startup.group]+0xe0): undefined reference to `dlclose'
> 
> that needs some more magic that I already forgot :-\
> 
> But now out to lunch.

Before that:

[root@cc85f3a7b96f dwarves-1.22]# file build/pahole
build/pahole: ELF 64-bit LSB executable, x86-64, version 1 (GNU/Linux), statically linked, BuildID[sha1]=c972bee0f67994e0c161ac3cf8bcc8b7f609d6ee, for GNU/Linux 3.2.0, with debug_info, not stripped, too many notes (256)
[root@cc85f3a7b96f dwarves-1.22]#

This after applying the patch below after yours, but then:

[root@cc85f3a7b96f dwarves-1.22]#  build/pahole  build/pahole
Segmentation fault (core dumped)
[root@cc85f3a7b96f dwarves-1.22]#

That doesn't happen with a non-static build:

[root@cc85f3a7b96f dwarves-1.22]# build/pahole list_head
struct list_head {
	struct list_head *         next;                 /*     0     8 */
	struct list_head *         prev;                 /*     8     8 */

	/* size: 16, cachelines: 1, members: 2 */
	/* last cacheline: 16 bytes */
};
[root@cc85f3a7b96f dwarves-1.22]# ldd build/pahole
	linux-vdso.so.1 (0x00007fff08654000)
	libdwarves_reorganize.so.1 => /root/dwarves-1.22/build/libdwarves_reorganize.so.1 (0x00007f8af5b45000)
	libdwarves.so.1 => /root/dwarves-1.22/build/libdwarves.so.1 (0x00007f8af5aad000)
	libdw.so.1 => /lib64/libdw.so.1 (0x00007f8af5a07000)
	libelf.so.1 => /lib64/libelf.so.1 (0x00007f8af59ec000)
	libz.so.1 => /lib64/libz.so.1 (0x00007f8af59d2000)
	libbz2.so.1 => /lib64/libbz2.so.1 (0x00007f8af59bf000)
	liblzma.so.5 => /lib64/liblzma.so.5 (0x00007f8af5993000)
	libzstd.so.1 => /lib64/libzstd.so.1 (0x00007f8af58b5000)
	libdl.so.2 => /lib64/libdl.so.2 (0x00007f8af58ae000)
	libpthread.so.0 => /lib64/libpthread.so.0 (0x00007f8af588c000)
	libc.so.6 => /lib64/libc.so.6 (0x00007f8af56c2000)
	/lib64/ld-linux-x86-64.so.2 (0x00007f8af5b4d000)
[root@cc85f3a7b96f dwarves-1.22]#

- Arnaldo

diff --git a/CMakeLists.txt b/CMakeLists.txt
index ba467bf4dcff3106..73d8919056281f94 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -127,7 +127,7 @@ endif()
 add_library(dwarves ${dwarves_LIB_SRCS})
 set_target_properties(dwarves PROPERTIES VERSION 1.0.0 SOVERSION 1)
 set_target_properties(dwarves PROPERTIES INTERFACE_LINK_LIBRARIES "")
-target_link_libraries(dwarves ${DWARF_LIBRARIES} ${ZLIB_LIBRARIES} ${LIBBPF_LIBRARIES} ${ARGP_LIBRARY} ${OBSTACK_LIBRARY} ${BZ2_LIBRARY} ${LZMA_LIBRARY})
+target_link_libraries(dwarves ${DWARF_LIBRARIES} ${ZLIB_LIBRARIES} ${LIBBPF_LIBRARIES} ${ARGP_LIBRARY} ${OBSTACK_LIBRARY} ${BZ2_LIBRARY} ${LZMA_LIBRARY} ${ZSTD_LIBRARY} ${DL_LIBRARY})
 
 set(dwarves_emit_LIB_SRCS dwarves_emit.c)
 add_library(dwarves_emit ${dwarves_emit_LIB_SRCS})
diff --git a/cmake/modules/FindDWARF.cmake b/cmake/modules/FindDWARF.cmake
index 1b4ac499ea07e267..8fa5cc47cea86486 100644
--- a/cmake/modules/FindDWARF.cmake
+++ b/cmake/modules/FindDWARF.cmake
@@ -47,6 +47,16 @@ find_library(LZMA_LIBRARY
 	PATHS /usr/lib /usr/local/lib /usr/lib64 /usr/local/lib64 ~/usr/local/lib ~/usr/local/lib64
 )
 
+find_library(ZSTD_LIBRARY
+	NAMES zstd
+	PATHS /usr/lib /usr/local/lib /usr/lib64 /usr/local/lib64 ~/usr/local/lib ~/usr/local/lib64
+)
+
+find_library(DL_LIBRARY
+	NAMES dl
+	PATHS /lib /lib64 /usr/lib /usr/local/lib /usr/lib64 /usr/local/lib64 ~/usr/local/lib ~/usr/local/lib64
+)
+
 if (DWARF_INCLUDE_DIR AND LIBDW_INCLUDE_DIR AND DWARF_LIBRARY AND ELF_LIBRARY)
 	set(DWARF_FOUND TRUE)
 	set(DWARF_LIBRARIES ${DWARF_LIBRARY} ${ELF_LIBRARY})
