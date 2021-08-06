Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDBEC4338F
	for <linux-dwarves@archiver.kernel.org>; Fri,  6 Aug 2021 18:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BED161167
	for <linux-dwarves@archiver.kernel.org>; Fri,  6 Aug 2021 18:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243327AbhHFSpX (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 6 Aug 2021 14:45:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:44368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231889AbhHFSpX (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Fri, 6 Aug 2021 14:45:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8934161131;
        Fri,  6 Aug 2021 18:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628275506;
        bh=+CA6uNC2do24SIRLqKkt4ZgZRZaLRssUMYsmQEo2zus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lv/1ZpVJNJx7uFfKNw4ld5nNPsBl4+nfLWtoXEW+/3c/EUH0x3RO7VDmVLA+/C+sw
         sqz5MA7YF+gBR2PGel02VIOfsbiYEgRj4NNE12J5nIjdFZnwGMPoXjV+vT/wdrVGjR
         MofyoqPAjImleYf8qWBY22S/b1EHOcfjKxXE8as+ysUl2zVZvp7FGbXNkoO7koGUvQ
         C4v5RPv0SIdj0gsHOrDgTgqN963ZdyQcoamhBSFnC5hWWvF5ggMnx39exDOhTFielq
         uOE7MKren8ftBfoSFvFN2C3CAYnJYWbO5yinyCAaBXqF8jWfKdWAKa+Cixh3R1jv9M
         wGR6Wr3HzqZRg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EB4FE403F2; Fri,  6 Aug 2021 15:45:03 -0300 (-03)
Date:   Fri, 6 Aug 2021 15:45:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        dwarves@vger.kernel.org
Subject: Re: [PATCH] pahole: correct libbpf git url
Message-ID: <YQ2DL8SVk3OxDAaL@kernel.org>
References: <1628244763-1113-1-git-send-email-joseph.qi@linux.alibaba.com>
 <YQ2Chd/j62NCY2NX@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YQ2Chd/j62NCY2NX@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Fri, Aug 06, 2021 at 03:42:13PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Aug 06, 2021 at 06:12:43PM +0800, Joseph Qi escreveu:
> > Otherwise it will encounter the following error:
> > fatal: unable to access 'https://github.com/libbpf/libbpf/': Encountered end of file
> > fatal: clone of 'https://github.com/libbpf/libbpf' into submodule path '/home/workspace/pahole/lib/bpf' failed
> > 
> > Also update README to add step 'make'.
> 
> You forgot to add Andrii, the author of the patch you're fixing, to the
> CC list, please do it next time.

Also here it works without your patch:

⬢[acme@toolbox git]$ git clone pahole bla
Cloning into 'bla'...
done.
⬢[acme@toolbox git]$ cd bla
⬢[acme@toolbox bla]$ mkdir build
⬢[acme@toolbox bla]$ cd build
⬢[acme@toolbox build]$ cmake ..
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
-- Submodule update
Submodule 'lib/bpf' (https://github.com/libbpf/libbpf) registered for path 'lib/bpf'
Cloning into '/var/home/acme/git/bla/lib/bpf'...
Submodule path 'lib/bpf': checked out '986962fade5dfa89c2890f3854eb040d2a64ab38'
-- Submodule update - done
-- Performing Test HAVE_REALLOCARRAY_SUPPORT
-- Performing Test HAVE_REALLOCARRAY_SUPPORT - Success
-- Configuring done
-- Generating done
-- Build files have been written to: /var/home/acme/git/bla/build
⬢[acme@toolbox build]$ cd ..
⬢[acme@toolbox bla]$ make -j26 -C build
make: Entering directory '/var/home/acme/git/bla/build'
make[1]: Entering directory '/var/home/acme/git/bla/build'
make[2]: Entering directory '/var/home/acme/git/bla/build'
make[2]: Leaving directory '/var/home/acme/git/bla/build'
make[2]: Entering directory '/var/home/acme/git/bla/build'
[  2%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/bpf_prog_linfo.c.o
[  6%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/bpf.c.o
[  6%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/btf.c.o
[  8%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/hashmap.c.o
[ 10%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/btf_dump.c.o
[ 12%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/libbpf.c.o
[ 14%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/libbpf_errno.c.o
[ 16%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/nlattr.c.o
[ 18%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/libbpf_probes.c.o
[ 20%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/netlink.c.o
[ 22%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/ringbuf.c.o
[ 24%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/xsk.c.o
[ 26%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/str_error.c.o
make[2]: Leaving directory '/var/home/acme/git/bla/build'
[ 26%] Built target bpf
make[2]: Entering directory '/var/home/acme/git/bla/build'
make[2]: Leaving directory '/var/home/acme/git/bla/build'
make[2]: Entering directory '/var/home/acme/git/bla/build'
[ 28%] Building C object CMakeFiles/dwarves.dir/dwarves.c.o
[ 30%] Building C object CMakeFiles/dwarves.dir/dwarves_fprintf.c.o
[ 32%] Building C object CMakeFiles/dwarves.dir/gobuffer.c.o
[ 34%] Building C object CMakeFiles/dwarves.dir/libctf.c.o
[ 36%] Building C object CMakeFiles/dwarves.dir/ctf_loader.c.o
[ 38%] Building C object CMakeFiles/dwarves.dir/dutil.c.o
[ 40%] Building C object CMakeFiles/dwarves.dir/btf_encoder.c.o
[ 44%] Building C object CMakeFiles/dwarves.dir/rbtree.c.o
[ 44%] Building C object CMakeFiles/dwarves.dir/btf_loader.c.o
[ 46%] Building C object CMakeFiles/dwarves.dir/elf_symtab.c.o
[ 48%] Building C object CMakeFiles/dwarves.dir/dwarf_loader.c.o
[ 50%] Linking C shared library libdwarves.so
make[2]: Leaving directory '/var/home/acme/git/bla/build'
[ 50%] Built target dwarves
make[2]: Entering directory '/var/home/acme/git/bla/build'
make[2]: Entering directory '/var/home/acme/git/bla/build'
make[2]: Entering directory '/var/home/acme/git/bla/build'
make[2]: Entering directory '/var/home/acme/git/bla/build'
make[2]: Entering directory '/var/home/acme/git/bla/build'
make[2]: Entering directory '/var/home/acme/git/bla/build'
make[2]: Entering directory '/var/home/acme/git/bla/build'
make[2]: Entering directory '/var/home/acme/git/bla/build'
make[2]: Entering directory '/var/home/acme/git/bla/build'
make[2]: Leaving directory '/var/home/acme/git/bla/build'
make[2]: Leaving directory '/var/home/acme/git/bla/build'
make[2]: Leaving directory '/var/home/acme/git/bla/build'
make[2]: Leaving directory '/var/home/acme/git/bla/build'
make[2]: Leaving directory '/var/home/acme/git/bla/build'
make[2]: Leaving directory '/var/home/acme/git/bla/build'
make[2]: Leaving directory '/var/home/acme/git/bla/build'
make[2]: Leaving directory '/var/home/acme/git/bla/build'
make[2]: Leaving directory '/var/home/acme/git/bla/build'
make[2]: Entering directory '/var/home/acme/git/bla/build'
make[2]: Entering directory '/var/home/acme/git/bla/build'
make[2]: Entering directory '/var/home/acme/git/bla/build'
make[2]: Entering directory '/var/home/acme/git/bla/build'
make[2]: Entering directory '/var/home/acme/git/bla/build'
make[2]: Entering directory '/var/home/acme/git/bla/build'
make[2]: Entering directory '/var/home/acme/git/bla/build'
make[2]: Entering directory '/var/home/acme/git/bla/build'
make[2]: Entering directory '/var/home/acme/git/bla/build'
[ 52%] Building C object CMakeFiles/syscse.dir/syscse.c.o
[ 58%] Building C object CMakeFiles/scncopy.dir/elfcreator.c.o
[ 58%] Building C object CMakeFiles/scncopy.dir/scncopy.c.o
[ 58%] Building C object CMakeFiles/dwarves_emit.dir/dwarves_emit.c.o
[ 62%] Building C object CMakeFiles/dwarves_reorganize.dir/dwarves_reorganize.c.o
[ 62%] Building C object CMakeFiles/dtagnames.dir/dtagnames.c.o
[ 64%] Building C object CMakeFiles/codiff.dir/codiff.c.o
[ 70%] Building C object CMakeFiles/pdwtags.dir/pdwtags.c.o
[ 70%] Building C object CMakeFiles/prefcnt.dir/prefcnt.c.o
[ 70%] Building C object CMakeFiles/pglobal.dir/pglobal.c.o
[ 72%] Linking C executable dtagnames
[ 76%] Linking C executable prefcnt
[ 76%] Linking C executable syscse
[ 78%] Linking C executable pglobal
[ 80%] Linking C shared library libdwarves_reorganize.so
[ 82%] Linking C executable pdwtags
[ 84%] Linking C executable scncopy
make[2]: Leaving directory '/var/home/acme/git/bla/build'
[ 86%] Linking C shared library libdwarves_emit.so
make[2]: Leaving directory '/var/home/acme/git/bla/build'
make[2]: Leaving directory '/var/home/acme/git/bla/build'
[ 86%] Built target dtagnames
[ 86%] Built target prefcnt
[ 86%] Built target syscse
make[2]: Leaving directory '/var/home/acme/git/bla/build'
make[2]: Leaving directory '/var/home/acme/git/bla/build'
make[2]: Leaving directory '/var/home/acme/git/bla/build'
make[2]: Leaving directory '/var/home/acme/git/bla/build'
[ 88%] Linking C executable codiff
[ 88%] Built target pglobal
[ 88%] Built target scncopy
[ 88%] Built target pdwtags
[ 88%] Built target dwarves_reorganize
make[2]: Entering directory '/var/home/acme/git/bla/build'
make[2]: Leaving directory '/var/home/acme/git/bla/build'
make[2]: Leaving directory '/var/home/acme/git/bla/build'
make[2]: Entering directory '/var/home/acme/git/bla/build'
[ 88%] Built target dwarves_emit
make[2]: Entering directory '/var/home/acme/git/bla/build'
make[2]: Entering directory '/var/home/acme/git/bla/build'
make[2]: Leaving directory '/var/home/acme/git/bla/build'
[ 90%] Building C object CMakeFiles/pahole.dir/pahole.c.o
make[2]: Leaving directory '/var/home/acme/git/bla/build'
make[2]: Leaving directory '/var/home/acme/git/bla/build'
[ 90%] Built target codiff
make[2]: Entering directory '/var/home/acme/git/bla/build'
make[2]: Entering directory '/var/home/acme/git/bla/build'
[ 92%] Building C object CMakeFiles/pfunct.dir/pfunct.c.o
[ 94%] Building C object CMakeFiles/ctracer.dir/ctracer.c.o
[ 96%] Linking C executable pfunct
[ 98%] Linking C executable ctracer
make[2]: Leaving directory '/var/home/acme/git/bla/build'
[ 98%] Built target pfunct
make[2]: Leaving directory '/var/home/acme/git/bla/build'
[ 98%] Built target ctracer
[100%] Linking C executable pahole
make[2]: Leaving directory '/var/home/acme/git/bla/build'
[100%] Built target pahole
make[1]: Leaving directory '/var/home/acme/git/bla/build'
make: Leaving directory '/var/home/acme/git/bla/build'
⬢[acme@toolbox bla]$
