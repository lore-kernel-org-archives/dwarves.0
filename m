Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72674C48BDF
	for <linux-dwarves@archiver.kernel.org>; Sun, 13 Jun 2021 13:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3702161264
	for <linux-dwarves@archiver.kernel.org>; Sun, 13 Jun 2021 13:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbhFMNXu (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Sun, 13 Jun 2021 09:23:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231286AbhFMNXu (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Sun, 13 Jun 2021 09:23:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C7EDF610A0;
        Sun, 13 Jun 2021 13:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623590509;
        bh=4ZH8twUBSUeKMFVKM337qHZMAke818Pyb9+nsOQfE+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SgCIUZRMAD9sLOjIR+JAtAGis5TM3cpnKL3Qo3tgt5yKevQ80muAez4pAADeLuVeD
         gkeQWtygfN7nQbE9DNRbzXmqAuD/f2rMdAjVqkh6biUYf3iIM7rPs9S/6DCmO4mCkI
         Y2kzP6oXrndcHPHNi0gtc/10cK2Jxj6RVRff+bPQmoIdMccaRIB5u9JcWGdJcXeFQ4
         fbImJ/7Xmm5WMa9xPFJxCP9giu0vPb6FUUZC/FIvuAR5ENtIy7VpZrX5nkUlMPwGe9
         Pe/Q0hUxfoC38y5J23bCmeGX+a/RhLDEDfYVUTsb2skDxlJFDYq6gUI/Tq8X9Dzsdk
         PmgXsTtiD5QDQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0A12A40B1A; Sun, 13 Jun 2021 10:21:46 -0300 (-03)
Date:   Sun, 13 Jun 2021 10:21:45 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Luca Boccassi <bluca@debian.org>
Cc:     dwarves@vger.kernel.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH dwarves] Add missing lib/include/bpf -> ../bpf/src symlink
Message-ID: <YMYGaUAjXmMm9lIO@kernel.org>
References: <20210611230126.57713-1-bluca@debian.org>
 <CAEf4BzYTSd1PvreyK8gsdL6=XPPqELQpz7DYAc-B=cH7L0QDKQ@mail.gmail.com>
 <YMYEmD7d00sj6UEx@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YMYEmD7d00sj6UEx@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org


So, while testing this I noticed that if I _don't_ have
libbpf-devel/libbpf installed and ask for it _not_ to use the embedded
libbpf, it will build just file, using the embedded libbpf, shouldn't it
flatly fail in this case instead of just making this note:

-- Checking for module 'libbpf>=0.3.0'
--   Package 'libbpf', required by 'virtual:world', not found

?

- Arnaldo

⬢[acme@toolbox pahole]$ sudo rpm -e libbpf-devel
⬢[acme@toolbox pahole]$ sudo rpm -e libbpf
⬢[acme@toolbox pahole]$ rm -rf build ; mkdir build ; cd build ; cmake -D__LIB=lib -DCMAKE_BUILD_TYPE=Release -DLIBBPF_EMBEDDED=Off .. ; cd ..
-- The C compiler identification is GNU 11.1.1
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Check for working C compiler: /usr/bin/cc - skipped
-- Detecting C compile features
-- Detecting C compile features - done
-- Found PkgConfig: /usr/bin/pkg-config (found version "1.7.3")
-- Checking for module 'libbpf>=0.3.0'
--   Package 'libbpf', required by 'virtual:world', not found
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
-- Submodule update - done
-- Performing Test HAVE_REALLOCARRAY_SUPPORT
-- Performing Test HAVE_REALLOCARRAY_SUPPORT - Success
-- Configuring done
-- Generating done
-- Build files have been written to: /var/home/acme/git/pahole/build
⬢[acme@toolbox pahole]$ make -C build
make: Entering directory '/var/home/acme/git/pahole/build'
make[1]: Entering directory '/var/home/acme/git/pahole/build'
make[2]: Entering directory '/var/home/acme/git/pahole/build'
Scanning dependencies of target bpf
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
make[2]: Entering directory '/var/home/acme/git/pahole/build'
[  1%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/bpf.c.o
[  3%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/bpf_prog_linfo.c.o
[  5%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/btf.c.o
[  7%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/btf_dump.c.o
[  9%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/hashmap.c.o
[ 11%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/libbpf.c.o
[ 13%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/libbpf_errno.c.o
[ 15%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/libbpf_probes.c.o
[ 17%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/netlink.c.o
[ 19%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/nlattr.c.o
[ 21%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/ringbuf.c.o
[ 23%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/str_error.c.o
[ 25%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/xsk.c.o
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
[ 25%] Built target bpf
make[2]: Entering directory '/var/home/acme/git/pahole/build'
Scanning dependencies of target dwarves
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
make[2]: Entering directory '/var/home/acme/git/pahole/build'
[ 26%] Building C object CMakeFiles/dwarves.dir/dwarves.c.o
[ 28%] Building C object CMakeFiles/dwarves.dir/dwarves_fprintf.c.o
[ 30%] Building C object CMakeFiles/dwarves.dir/gobuffer.c.o
[ 32%] Building C object CMakeFiles/dwarves.dir/strings.c.o
[ 34%] Building C object CMakeFiles/dwarves.dir/ctf_encoder.c.o
[ 36%] Building C object CMakeFiles/dwarves.dir/ctf_loader.c.o
[ 38%] Building C object CMakeFiles/dwarves.dir/libctf.c.o
[ 40%] Building C object CMakeFiles/dwarves.dir/btf_encoder.c.o
[ 42%] Building C object CMakeFiles/dwarves.dir/btf_loader.c.o
[ 44%] Building C object CMakeFiles/dwarves.dir/dwarf_loader.c.o
[ 46%] Building C object CMakeFiles/dwarves.dir/dutil.c.o
[ 48%] Building C object CMakeFiles/dwarves.dir/elf_symtab.c.o
[ 50%] Building C object CMakeFiles/dwarves.dir/rbtree.c.o
[ 51%] Linking C shared library libdwarves.so
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
[ 51%] Built target dwarves
make[2]: Entering directory '/var/home/acme/git/pahole/build'
Scanning dependencies of target syscse
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
make[2]: Entering directory '/var/home/acme/git/pahole/build'
[ 53%] Building C object CMakeFiles/syscse.dir/syscse.c.o
[ 55%] Linking C executable syscse
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
[ 55%] Built target syscse
make[2]: Entering directory '/var/home/acme/git/pahole/build'
Scanning dependencies of target codiff
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
make[2]: Entering directory '/var/home/acme/git/pahole/build'
[ 57%] Building C object CMakeFiles/codiff.dir/codiff.c.o
[ 59%] Linking C executable codiff
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
[ 59%] Built target codiff
make[2]: Entering directory '/var/home/acme/git/pahole/build'
Scanning dependencies of target dtagnames
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
make[2]: Entering directory '/var/home/acme/git/pahole/build'
[ 61%] Building C object CMakeFiles/dtagnames.dir/dtagnames.c.o
[ 63%] Linking C executable dtagnames
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
[ 63%] Built target dtagnames
make[2]: Entering directory '/var/home/acme/git/pahole/build'
Scanning dependencies of target scncopy
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
make[2]: Entering directory '/var/home/acme/git/pahole/build'
[ 65%] Building C object CMakeFiles/scncopy.dir/scncopy.c.o
[ 67%] Building C object CMakeFiles/scncopy.dir/elfcreator.c.o
[ 69%] Linking C executable scncopy
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
[ 69%] Built target scncopy
make[2]: Entering directory '/var/home/acme/git/pahole/build'
Scanning dependencies of target dwarves_emit
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
make[2]: Entering directory '/var/home/acme/git/pahole/build'
[ 71%] Building C object CMakeFiles/dwarves_emit.dir/dwarves_emit.c.o
[ 73%] Linking C shared library libdwarves_emit.so
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
[ 73%] Built target dwarves_emit
make[2]: Entering directory '/var/home/acme/git/pahole/build'
Scanning dependencies of target dwarves_reorganize
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
make[2]: Entering directory '/var/home/acme/git/pahole/build'
[ 75%] Building C object CMakeFiles/dwarves_reorganize.dir/dwarves_reorganize.c.o
[ 76%] Linking C shared library libdwarves_reorganize.so
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
[ 76%] Built target dwarves_reorganize
make[2]: Entering directory '/var/home/acme/git/pahole/build'
Scanning dependencies of target ctracer
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
make[2]: Entering directory '/var/home/acme/git/pahole/build'
[ 78%] Building C object CMakeFiles/ctracer.dir/ctracer.c.o
[ 80%] Linking C executable ctracer
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
[ 80%] Built target ctracer
make[2]: Entering directory '/var/home/acme/git/pahole/build'
Scanning dependencies of target pdwtags
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
make[2]: Entering directory '/var/home/acme/git/pahole/build'
[ 82%] Building C object CMakeFiles/pdwtags.dir/pdwtags.c.o
[ 84%] Linking C executable pdwtags
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
[ 84%] Built target pdwtags
make[2]: Entering directory '/var/home/acme/git/pahole/build'
Scanning dependencies of target pahole
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
make[2]: Entering directory '/var/home/acme/git/pahole/build'
[ 86%] Building C object CMakeFiles/pahole.dir/pahole.c.o
[ 88%] Linking C executable pahole
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
[ 88%] Built target pahole
make[2]: Entering directory '/var/home/acme/git/pahole/build'
Scanning dependencies of target pfunct
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
make[2]: Entering directory '/var/home/acme/git/pahole/build'
[ 90%] Building C object CMakeFiles/pfunct.dir/pfunct.c.o
[ 92%] Linking C executable pfunct
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
[ 92%] Built target pfunct
make[2]: Entering directory '/var/home/acme/git/pahole/build'
Scanning dependencies of target pglobal
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
make[2]: Entering directory '/var/home/acme/git/pahole/build'
[ 94%] Building C object CMakeFiles/pglobal.dir/pglobal.c.o
[ 96%] Linking C executable pglobal
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
[ 96%] Built target pglobal
make[2]: Entering directory '/var/home/acme/git/pahole/build'
Scanning dependencies of target prefcnt
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
make[2]: Entering directory '/var/home/acme/git/pahole/build'
[ 98%] Building C object CMakeFiles/prefcnt.dir/prefcnt.c.o
[100%] Linking C executable prefcnt
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
[100%] Built target prefcnt
make[1]: Leaving directory '/var/home/acme/git/pahole/build'
make: Leaving directory '/var/home/acme/git/pahole/build'
⬢[acme@toolbox pahole]$
