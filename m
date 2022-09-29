Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A6DC32771
	for <linux-dwarves@archiver.kernel.org>; Thu, 29 Sep 2022 00:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbiI2A5T (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 28 Sep 2022 20:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiI2A5T (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 28 Sep 2022 20:57:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AD91EAD3
        for <dwarves@vger.kernel.org>; Wed, 28 Sep 2022 17:57:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 442D1B822C2
        for <dwarves@vger.kernel.org>; Thu, 29 Sep 2022 00:57:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF89C433D6;
        Thu, 29 Sep 2022 00:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664413032;
        bh=EKqNNwkHBXnkdGpK5lXsLuMsPdjV7CiZCn5fuD6s1s4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eG/7WnAGTHKlNT381REDxe+vW/hlxu6YQwYwJnEiDNdW/Y1qI2HT2NDrzEED906OF
         GpGCJRksqUU6u7RVs4ZM71XQaY2UpoFWwDZTVYsnWv6U3xhV6UrnOSRrCK9XrDyJRV
         OPVvHgCOEy/DumyNhPABgj5GiGnwTF4WJuBzNCUN6Rkg2NVYUOYiQ1JNCzwiXkMBiI
         3Fnd4LkDG9GF2D37+V3J5kg3N7CCDLvh/hjEQlRpyTMsmbHfTe9liPUNP82i1Zzr+E
         c2j0KRu+TRbA2wBWcyVkIYY9BmThSGrWpEd37Z+/MhsZz5Dgy7CbAut/amt1zvwT+5
         cvWQOsU/dOzYQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3550F405F0; Wed, 28 Sep 2022 21:57:10 -0300 (-03)
Date:   Wed, 28 Sep 2022 21:57:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     dwarves@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: die__process_unit: DW_TAG_label (0xa) @ <0x7b> not handled!
Message-ID: <YzTtZpzT+qFfvEeJ@kernel.org>
References: <YzNHYoI4EZOQdCQ0@dev-arch.thelio-3990X>
 <CAKwvOd=ES+v0X6_ydB5+MNWdPw8dNAUD0Biq=BKB6KqPqNp+Ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOd=ES+v0X6_ydB5+MNWdPw8dNAUD0Biq=BKB6KqPqNp+Ng@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Wed, Sep 28, 2022 at 02:35:48PM -0700, Nick Desaulniers escreveu:
> On Tue, Sep 27, 2022 at 11:56 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > Hi Arnaldo,
> >
> > When building a kernel with LLVM and CONFIG_DEBUG_INFO_BTF after commit
> > 32ef9e5054ec ("Makefile.debug: re-enable debug info for .S files") in
> > the kernel, I see the following spew of warnings, which appear to come
> > from pahole:
> >
> > $ clang --version
> > clang version 15.0.0 (Fedora 15.0.0-3.fc38)
> > Target: x86_64-redhat-linux-gnu
> > Thread model: posix
> > InstalledDir: /usr/bin
> >
> > $ pahole --version
> > v1.24
> >
> > $ make -skj"$(nproc)" ARCH=x86_64 LLVM=1 defconfig
> >
> > $ scripts/config \
> >     -d DEBUG_INFO_NONE \
> >     -e BPF_SYSCALL \
> >     -e DEBUG_INFO_BTF \
> >     -e DEBUG_INFO_DWARF5
> >
> > $ make -skj"$(nproc)" ARCH=x86_64 LLVM=1 olddefconfig all
> > ...
> > die__process_unit: DW_TAG_label (0xa) @ <0x7b> not handled!
> > die__process_unit: tag not supported 0xa (label)!
> > die__process_unit: DW_TAG_label (0xa) @ <0x97> not handled!
> > die__process_unit: DW_TAG_label (0xa) @ <0xbd> not handled!
> > die__process_unit: DW_TAG_label (0xa) @ <0xed> not handled!
> > die__process_unit: DW_TAG_label (0xa) @ <0x109> not handled!
> > die__process_unit: DW_TAG_label (0xa) @ <0x12a> not handled!
> > die__process_unit: DW_TAG_label (0xa) @ <0x146> not handled!
> > die__process_unit: DW_TAG_label (0xa) @ <0x16f> not handled!
> 
> Running llvm-dwarfdump on vmlinux, I see:
> 
> ```
> $ make -skj"$(nproc)" ARCH=x86_64 LLVM=1 olddefconfig all
> die__process_unit: DW_TAG_label (0xa) @ <0xbf> not handled!
> die__process_unit: tag not supported 0xa (label)!
> ...
> $ llvm-dwarfdump vmlinux | less
> ...
> 0x000000bf:   DW_TAG_label
>                 DW_AT_name      ("startup_64")
>                 DW_AT_decl_file
> ("/android0/kernel-all/arch/x86/kernel/head_64.S")
>                 DW_AT_decl_line (868)
>                 DW_AT_low_pc    (0xffffffff81000000)
> 
> 0x000000db:   DW_TAG_label
>                 DW_AT_name      ("secondary_startup_64")
>                 DW_AT_decl_file
> ("/android0/kernel-all/arch/x86/kernel/head_64.S")
>                 DW_AT_decl_line (921)
>                 DW_AT_low_pc    (0xffffffff81000060)
> ...
> ```
> 
> So these seem to be labels in assembler sources.  The DW_TAGs look the
> same to be for labels from C sources.

Interesting, I think its just a matter of ignoring those when they
appear on the DW_TAG_compile_unit then
 
> > ...
> >
> > Is this a problem with LLVM or pahole? I do not see this when building
> > with GCC + GNU as but that could just be a red herring. I assume that
> > there could be something missing for processing debug info from
> > assembly, perhaps?
> 
> That's what I suspect.
> 
> > If there is any further information I can provide or
> > anything I can test, I am more than happy to do so.
> >
> > Cheers,
> > Nathan
> 
> I swear I used to be able to build pahole from sources...just moved to
> a new machine and something seems off...
> $ sudo apt install libdwarf-dev libdw-dev
> $ git clone git://git.kernel.org/pub/scm/devel/pahole/pahole.git
> $ mkdir pahole/build
> $ cd !$
> $ cmake -D__LIB=lib ..
> $ make
> ...
> [ 63%] Linking C executable codiff
> /usr/bin/ld: libdwarves.so.1.0.0: undefined reference to `dwfl_module_getelf'
> /usr/bin/ld: libdwarves.so.1.0.0: undefined reference to `dwfl_report_end'

Strange, can you try without that -D__LIB=lib?

here, fedora:37, in a toolbox:

⬢[acme@toolbox pahole]$ cd /tmp
⬢[acme@toolbox tmp]$ git clone git://git.kernel.org/pub/scm/devel/pahole/pahole.git
Cloning into 'pahole'...
remote: Enumerating objects: 24, done.
remote: Counting objects: 100% (24/24), done.
remote: Compressing objects: 100% (24/24), done.
remote: Total 8346 (delta 8), reused 0 (delta 0), pack-reused 8322
Receiving objects: 100% (8346/8346), 2.14 MiB | 1.68 MiB/s, done.
Resolving deltas: 100% (6008/6008), done.
⬢[acme@toolbox tmp]$ cd pahole/
⬢[acme@toolbox pahole]$ mkdir build
⬢[acme@toolbox pahole]$ cd build
⬢[acme@toolbox build]$ cmake ..
-- The C compiler identification is GNU 12.2.1
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Check for working C compiler: /usr/lib64/ccache/cc - skipped
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
Submodule 'lib/bpf' (https://github.com/libbpf/libbpf) registered for path 'lib/bpf'
Cloning into '/tmp/pahole/lib/bpf'...
Submodule path 'lib/bpf': checked out '645500dd7d2d6b5bb76e4c0375d597d4f0c4814e'
-- Submodule update - done
-- Performing Test HAVE_REALLOCARRAY_SUPPORT
-- Performing Test HAVE_REALLOCARRAY_SUPPORT - Success
-- Configuring done
-- Generating done
-- Build files have been written to: /tmp/pahole/build
⬢[acme@toolbox build]$ cd ..
⬢[acme@toolbox pahole]$ make -C build
make: Entering directory '/tmp/pahole/build'
make[1]: Entering directory '/tmp/pahole/build'
make[2]: Entering directory '/tmp/pahole/build'
make[2]: Leaving directory '/tmp/pahole/build'
make[2]: Entering directory '/tmp/pahole/build'
[  1%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/bpf.c.o
[  3%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/bpf_prog_linfo.c.o
[  5%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/btf.c.o
[  7%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/btf_dump.c.o
[  9%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/gen_loader.c.o
[ 10%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/hashmap.c.o
[ 12%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/libbpf.c.o
[ 14%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/libbpf_errno.c.o
[ 16%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/libbpf_probes.c.o
[ 18%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/linker.c.o
[ 20%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/netlink.c.o
[ 21%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/nlattr.c.o
[ 23%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/relo_core.c.o
[ 25%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/ringbuf.c.o
[ 27%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/str_error.c.o
[ 29%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/strset.c.o
[ 30%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/usdt.c.o
[ 32%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/xsk.c.o
make[2]: Leaving directory '/tmp/pahole/build'
[ 32%] Built target bpf
make[2]: Entering directory '/tmp/pahole/build'
make[2]: Leaving directory '/tmp/pahole/build'
make[2]: Entering directory '/tmp/pahole/build'
[ 34%] Building C object CMakeFiles/dwarves.dir/dwarves.c.o
[ 36%] Building C object CMakeFiles/dwarves.dir/dwarves_fprintf.c.o
[ 38%] Building C object CMakeFiles/dwarves.dir/gobuffer.c.o
[ 40%] Building C object CMakeFiles/dwarves.dir/ctf_loader.c.o
[ 41%] Building C object CMakeFiles/dwarves.dir/libctf.c.o
[ 43%] Building C object CMakeFiles/dwarves.dir/btf_encoder.c.o
[ 45%] Building C object CMakeFiles/dwarves.dir/btf_loader.c.o
[ 47%] Building C object CMakeFiles/dwarves.dir/dwarf_loader.c.o
[ 49%] Building C object CMakeFiles/dwarves.dir/dutil.c.o
[ 50%] Building C object CMakeFiles/dwarves.dir/elf_symtab.c.o
[ 52%] Building C object CMakeFiles/dwarves.dir/rbtree.c.o
[ 54%] Linking C shared library libdwarves.so
make[2]: Leaving directory '/tmp/pahole/build'
[ 54%] Built target dwarves
make[2]: Entering directory '/tmp/pahole/build'
make[2]: Leaving directory '/tmp/pahole/build'
make[2]: Entering directory '/tmp/pahole/build'
[ 56%] Building C object CMakeFiles/dwarves_emit.dir/dwarves_emit.c.o
[ 58%] Linking C shared library libdwarves_emit.so
make[2]: Leaving directory '/tmp/pahole/build'
[ 58%] Built target dwarves_emit
make[2]: Entering directory '/tmp/pahole/build'
make[2]: Leaving directory '/tmp/pahole/build'
make[2]: Entering directory '/tmp/pahole/build'
[ 60%] Building C object CMakeFiles/dwarves_reorganize.dir/dwarves_reorganize.c.o
[ 61%] Linking C shared library libdwarves_reorganize.so
make[2]: Leaving directory '/tmp/pahole/build'
[ 61%] Built target dwarves_reorganize
make[2]: Entering directory '/tmp/pahole/build'
make[2]: Leaving directory '/tmp/pahole/build'
make[2]: Entering directory '/tmp/pahole/build'
[ 63%] Building C object CMakeFiles/codiff.dir/codiff.c.o
[ 65%] Linking C executable codiff
make[2]: Leaving directory '/tmp/pahole/build'
[ 65%] Built target codiff
make[2]: Entering directory '/tmp/pahole/build'
make[2]: Leaving directory '/tmp/pahole/build'
make[2]: Entering directory '/tmp/pahole/build'
[ 67%] Building C object CMakeFiles/ctracer.dir/ctracer.c.o
[ 69%] Linking C executable ctracer
make[2]: Leaving directory '/tmp/pahole/build'
[ 69%] Built target ctracer
make[2]: Entering directory '/tmp/pahole/build'
make[2]: Leaving directory '/tmp/pahole/build'
make[2]: Entering directory '/tmp/pahole/build'
[ 70%] Building C object CMakeFiles/dtagnames.dir/dtagnames.c.o
[ 72%] Linking C executable dtagnames
make[2]: Leaving directory '/tmp/pahole/build'
[ 72%] Built target dtagnames
make[2]: Entering directory '/tmp/pahole/build'
make[2]: Leaving directory '/tmp/pahole/build'
make[2]: Entering directory '/tmp/pahole/build'
[ 74%] Building C object CMakeFiles/pahole.dir/pahole.c.o
[ 76%] Linking C executable pahole
make[2]: Leaving directory '/tmp/pahole/build'
[ 76%] Built target pahole
make[2]: Entering directory '/tmp/pahole/build'
make[2]: Leaving directory '/tmp/pahole/build'
make[2]: Entering directory '/tmp/pahole/build'
[ 78%] Building C object CMakeFiles/pdwtags.dir/pdwtags.c.o
[ 80%] Linking C executable pdwtags
make[2]: Leaving directory '/tmp/pahole/build'
[ 80%] Built target pdwtags
make[2]: Entering directory '/tmp/pahole/build'
make[2]: Leaving directory '/tmp/pahole/build'
make[2]: Entering directory '/tmp/pahole/build'
[ 81%] Building C object CMakeFiles/pglobal.dir/pglobal.c.o
[ 83%] Linking C executable pglobal
make[2]: Leaving directory '/tmp/pahole/build'
[ 83%] Built target pglobal
make[2]: Entering directory '/tmp/pahole/build'
make[2]: Leaving directory '/tmp/pahole/build'
make[2]: Entering directory '/tmp/pahole/build'
[ 85%] Building C object CMakeFiles/pfunct.dir/pfunct.c.o
[ 87%] Linking C executable pfunct
make[2]: Leaving directory '/tmp/pahole/build'
[ 87%] Built target pfunct
make[2]: Entering directory '/tmp/pahole/build'
make[2]: Leaving directory '/tmp/pahole/build'
make[2]: Entering directory '/tmp/pahole/build'
[ 89%] Building C object CMakeFiles/prefcnt.dir/prefcnt.c.o
[ 90%] Linking C executable prefcnt
make[2]: Leaving directory '/tmp/pahole/build'
[ 90%] Built target prefcnt
make[2]: Entering directory '/tmp/pahole/build'
make[2]: Leaving directory '/tmp/pahole/build'
make[2]: Entering directory '/tmp/pahole/build'
[ 92%] Building C object CMakeFiles/scncopy.dir/scncopy.c.o
[ 94%] Building C object CMakeFiles/scncopy.dir/elfcreator.c.o
[ 96%] Linking C executable scncopy
make[2]: Leaving directory '/tmp/pahole/build'
[ 96%] Built target scncopy
make[2]: Entering directory '/tmp/pahole/build'
make[2]: Leaving directory '/tmp/pahole/build'
make[2]: Entering directory '/tmp/pahole/build'
[ 98%] Building C object CMakeFiles/syscse.dir/syscse.c.o
[100%] Linking C executable syscse
make[2]: Leaving directory '/tmp/pahole/build'
[100%] Built target syscse
make[1]: Leaving directory '/tmp/pahole/build'
make: Leaving directory '/tmp/pahole/build'
⬢[acme@toolbox pahole]$ rpm -qa | grep elfutils
elfutils-debugsource-0.186-1.fc34.x86_64
elfutils-debuginfo-0.186-1.fc34.x86_64
elfutils-libs-debuginfo-0.186-1.fc34.x86_64
elfutils-libelf-0.187-4.fc36.x86_64
elfutils-libelf-devel-0.187-4.fc36.x86_64
elfutils-default-yama-scope-0.187-4.fc36.noarch
elfutils-debuginfod-client-0.187-4.fc36.x86_64
elfutils-libs-0.187-4.fc36.x86_64
elfutils-0.187-4.fc36.x86_64
elfutils-debuginfod-client-devel-0.187-4.fc36.x86_64
elfutils-devel-0.187-4.fc36.x86_64
⬢[acme@toolbox pahole]$
