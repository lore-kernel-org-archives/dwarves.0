Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4852C48BCF
	for <linux-dwarves@archiver.kernel.org>; Wed,  9 Jun 2021 16:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9410F613BF
	for <linux-dwarves@archiver.kernel.org>; Wed,  9 Jun 2021 16:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbhFIQ1m (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 9 Jun 2021 12:27:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229472AbhFIQ1j (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Wed, 9 Jun 2021 12:27:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C8E660FE5;
        Wed,  9 Jun 2021 16:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623255944;
        bh=kfNU3DdDSW+Z4rdycGXanPaoBkJakD1Wisz9LYWAlbA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hk7tlRqNpKgDXN7RZoRQlqXWYHrQ+cznbVsiZpESDW2YqtU87CJXmSm6qO33mv5zB
         5ClqFtLB4tIz2puStKtv1kACu5o225I0q2LBmL4kT8DC+HlcgXHYcIxSwri7OSD/Pq
         LgIUc4p5t45L9ibkhlAwvOr/Ko6kudMG6roVHZHDHnno5jmGJnAu1UjSxUBNvf1IpI
         8B7O7faCuPcIe/W5UmEZ9x3nA3iV0hs61dVnXQiFkQHcoPILXmr4I+mWJXnrSGCs2B
         kKuHmbL8u48gcr1r6ziGDesKvxmyohO2QoDchPv8IOk9DeYhClnfR9MZuwVhuxuzY3
         1+QmyBZdlRU1w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 69D7C40B1A; Wed,  9 Jun 2021 13:25:41 -0300 (-03)
Date:   Wed, 9 Jun 2021 13:25:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Luca Boccassi <bluca@debian.org>
Cc:     dwarves@vger.kernel.org
Subject: Re: [PATCH dwarves v3] libbpf: allow to use packaged version
Message-ID: <YMDrhaRvsmuBRTL9@kernel.org>
References: <20210103213201.829827-1-bluca@debian.org>
 <20210104221622.256663-1-bluca@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210104221622.256663-1-bluca@debian.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Mon, Jan 04, 2021 at 10:16:22PM +0000, Luca Boccassi escreveu:
> Add a new CMake option, LIBBPF_EMBEDDED, to switch between the
> embedded version and the system version (searched via pkg-config)
> of libbpf. Set the embedded version as the default.
> 
> Signed-off-by: Luca Boccassi <bluca@debian.org>
> ---
> v2: switched default to use embedded version
> v3: add lib/include/bpf -> lib/bpf/src symlink to allow using 'system'
>     style #include everywhere, rather than #ifdefs.
>     Thanks Andrii for the suggestion!

I've updated it as I did a lot of refactorings, and here is why its
better to have it default to using the embedded libbpf:

⬢[acme@toolbox pahole]$ rpm -q libbpf-devel
libbpf-devel-0.3.0-2.fc34.x86_64
⬢[acme@toolbox pahole]$ cat /etc/redhat-release
Fedora release 34 (Thirty Four)
⬢[acme@toolbox pahole]$

⬢[acme@toolbox pahole]$ rm -rf build ; mkdir build ; cd build ; cmake -DCMAKE_BUILD_TYPE=Release -DLIBBPF_EMBEDDED=Off .. ; cd ..
-- The C compiler identification is GNU 11.1.1
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Check for working C compiler: /usr/bin/cc - skipped
-- Detecting C compile features
-- Detecting C compile features - done
-- Found PkgConfig: /usr/bin/pkg-config (found version "1.7.3") 
-- Checking for module 'libbpf>=0.3.0'
--   Found libbpf, version 0.3.0
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
⬢[acme@toolbox pahole]$ m
make: Entering directory '/var/home/acme/git/pahole/build'
make[1]: Entering directory '/var/home/acme/git/pahole/build'
make[2]: Entering directory '/var/home/acme/git/pahole/build'
Scanning dependencies of target dwarves
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
make[2]: Entering directory '/var/home/acme/git/pahole/build'
[  5%] Building C object CMakeFiles/dwarves.dir/dwarves.c.o
[  5%] Building C object CMakeFiles/dwarves.dir/dwarves_fprintf.c.o
[ 10%] Building C object CMakeFiles/dwarves.dir/gobuffer.c.o
[ 10%] Building C object CMakeFiles/dwarves.dir/ctf_encoder.c.o
[ 12%] Building C object CMakeFiles/dwarves.dir/ctf_loader.c.o
[ 15%] Building C object CMakeFiles/dwarves.dir/libctf.c.o
[ 17%] Building C object CMakeFiles/dwarves.dir/dutil.c.o
[ 20%] Building C object CMakeFiles/dwarves.dir/btf_encoder.c.o
[ 25%] Building C object CMakeFiles/dwarves.dir/strings.c.o
[ 25%] Building C object CMakeFiles/dwarves.dir/btf_loader.c.o
[ 28%] Building C object CMakeFiles/dwarves.dir/dwarf_loader.c.o
[ 33%] Building C object CMakeFiles/dwarves.dir/rbtree.c.o
[ 33%] Building C object CMakeFiles/dwarves.dir/elf_symtab.c.o
/var/home/acme/git/pahole/btf_encoder.c:84:10: error: ‘BTF_KIND_FLOAT’ undeclared here (not in a function); did you mean ‘BTF_KIND_INT’?
   84 |         [BTF_KIND_FLOAT]        = "FLOAT",
      |          ^~~~~~~~~~~~~~
      |          BTF_KIND_INT
/var/home/acme/git/pahole/btf_encoder.c:84:10: error: array index in initializer not of integer type
/var/home/acme/git/pahole/btf_encoder.c:84:10: note: (near initialization for ‘btf_kind_str’)
/var/home/acme/git/pahole/btf_encoder.c:84:35: warning: excess elements in array initializer
   84 |         [BTF_KIND_FLOAT]        = "FLOAT",
      |                                   ^~~~~~~
/var/home/acme/git/pahole/btf_encoder.c:84:35: note: (near initialization for ‘btf_kind_str’)
/var/home/acme/git/pahole/btf_loader.c: In function ‘btf__load_types’:
/var/home/acme/git/pahole/btf_loader.c:455:22: error: ‘BTF_KIND_FLOAT’ undeclared (first use in this function); did you mean ‘BTF_KIND_INT’?
  455 |                 case BTF_KIND_FLOAT:
      |                      ^~~~~~~~~~~~~~
      |                      BTF_KIND_INT
/var/home/acme/git/pahole/btf_loader.c:455:22: note: each undeclared identifier is reported only once for each function it appears in
/var/home/acme/git/pahole/btf_encoder.c: In function ‘btf_encoder__add_float’:
/var/home/acme/git/pahole/btf_encoder.c:224:22: warning: implicit declaration of function ‘btf__add_float’; did you mean ‘btf__add_var’? [-Wimplicit-function-declaration]
  224 |         int32_t id = btf__add_float(encoder->btf, name, BITS_ROUNDUP_BYTES(bt->bit_size));
      |                      ^~~~~~~~~~~~~~
      |                      btf__add_var
make[2]: *** [CMakeFiles/dwarves.dir/build.make:186: CMakeFiles/dwarves.dir/btf_loader.c.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[2]: *** [CMakeFiles/dwarves.dir/build.make:173: CMakeFiles/dwarves.dir/btf_encoder.c.o] Error 1
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
make[1]: *** [CMakeFiles/Makefile2:173: CMakeFiles/dwarves.dir/all] Error 2
make[1]: Leaving directory '/var/home/acme/git/pahole/build'
make: *** [Makefile:149: all] Error 2
make: Leaving directory '/var/home/acme/git/pahole/build'
⬢[acme@toolbox pahole]$ 



With it off, the default, it works, so I'm applying this patch, will soon
appear in the tmp.master branch and then move to master.

⬢[acme@toolbox pahole]$ rm -rf build ; mkdir build ; cd build ; cmake -DCMAKE_BUILD_TYPE=Release .. ; cd ..
-- The C compiler identification is GNU 11.1.1
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Check for working C compiler: /usr/bin/cc - skipped
-- Detecting C compile features
-- Detecting C compile features - done
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
⬢[acme@toolbox pahole]$ m
make: Entering directory '/var/home/acme/git/pahole/build'
make[1]: Entering directory '/var/home/acme/git/pahole/build'
make[2]: Entering directory '/var/home/acme/git/pahole/build'
Scanning dependencies of target bpf
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
make[2]: Entering directory '/var/home/acme/git/pahole/build'
[  3%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/bpf.c.o
[  3%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/btf.c.o
[  5%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/bpf_prog_linfo.c.o
[  7%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/btf_dump.c.o
[  9%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/hashmap.c.o
[ 11%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/libbpf.c.o
[ 13%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/libbpf_errno.c.o
[ 15%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/ringbuf.c.o
[ 17%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/libbpf_probes.c.o
[ 19%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/netlink.c.o
[ 21%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/nlattr.c.o
[ 23%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/str_error.c.o
[ 25%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/xsk.c.o
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
[ 25%] Built target bpf
make[2]: Entering directory '/var/home/acme/git/pahole/build'
Scanning dependencies of target dwarves
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
make[2]: Entering directory '/var/home/acme/git/pahole/build'
[ 28%] Building C object CMakeFiles/dwarves.dir/dwarves.c.o
[ 28%] Building C object CMakeFiles/dwarves.dir/dwarves_fprintf.c.o
[ 30%] Building C object CMakeFiles/dwarves.dir/gobuffer.c.o
[ 32%] Building C object CMakeFiles/dwarves.dir/strings.c.o
[ 34%] Building C object CMakeFiles/dwarves.dir/ctf_encoder.c.o
[ 36%] Building C object CMakeFiles/dwarves.dir/libctf.c.o
[ 38%] Building C object CMakeFiles/dwarves.dir/dutil.c.o
[ 42%] Building C object CMakeFiles/dwarves.dir/btf_encoder.c.o
[ 42%] Building C object CMakeFiles/dwarves.dir/btf_loader.c.o
[ 44%] Building C object CMakeFiles/dwarves.dir/ctf_loader.c.o
[ 48%] Building C object CMakeFiles/dwarves.dir/elf_symtab.c.o
[ 48%] Building C object CMakeFiles/dwarves.dir/rbtree.c.o
[ 50%] Building C object CMakeFiles/dwarves.dir/dwarf_loader.c.o
[ 51%] Linking C shared library libdwarves.so
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
[ 51%] Built target dwarves
make[2]: Entering directory '/var/home/acme/git/pahole/build'
make[2]: Entering directory '/var/home/acme/git/pahole/build'
make[2]: Entering directory '/var/home/acme/git/pahole/build'
make[2]: Entering directory '/var/home/acme/git/pahole/build'
make[2]: Entering directory '/var/home/acme/git/pahole/build'
make[2]: Entering directory '/var/home/acme/git/pahole/build'
make[2]: Entering directory '/var/home/acme/git/pahole/build'
make[2]: Entering directory '/var/home/acme/git/pahole/build'
make[2]: Entering directory '/var/home/acme/git/pahole/build'
Scanning dependencies of target codiff
Scanning dependencies of target syscse
Scanning dependencies of target dtagnames
Scanning dependencies of target scncopy
Scanning dependencies of target dwarves_reorganize
Scanning dependencies of target dwarves_emit
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
Scanning dependencies of target prefcnt
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
Scanning dependencies of target pdwtags
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
Scanning dependencies of target pglobal
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
make[2]: Entering directory '/var/home/acme/git/pahole/build'
make[2]: Entering directory '/var/home/acme/git/pahole/build'
make[2]: Entering directory '/var/home/acme/git/pahole/build'
make[2]: Entering directory '/var/home/acme/git/pahole/build'
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
make[2]: Entering directory '/var/home/acme/git/pahole/build'
make[2]: Entering directory '/var/home/acme/git/pahole/build'
make[2]: Entering directory '/var/home/acme/git/pahole/build'
make[2]: Entering directory '/var/home/acme/git/pahole/build'
make[2]: Entering directory '/var/home/acme/git/pahole/build'
[ 55%] Building C object CMakeFiles/codiff.dir/codiff.c.o
[ 55%] Building C object CMakeFiles/dtagnames.dir/dtagnames.c.o
[ 57%] Building C object CMakeFiles/dwarves_emit.dir/dwarves_emit.c.o
[ 61%] Building C object CMakeFiles/scncopy.dir/elfcreator.c.o
[ 63%] Building C object CMakeFiles/prefcnt.dir/prefcnt.c.o
[ 63%] Building C object CMakeFiles/dwarves_reorganize.dir/dwarves_reorganize.c.o
[ 65%] Building C object CMakeFiles/pdwtags.dir/pdwtags.c.o
[ 69%] Building C object CMakeFiles/syscse.dir/syscse.c.o
[ 69%] Building C object CMakeFiles/pglobal.dir/pglobal.c.o
[ 71%] Building C object CMakeFiles/scncopy.dir/scncopy.c.o
[ 73%] Linking C executable dtagnames
[ 75%] Linking C executable prefcnt
[ 76%] Linking C executable syscse
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
[ 80%] Linking C executable pdwtags
[ 80%] Linking C executable pglobal
[ 82%] Linking C executable scncopy
[ 82%] Built target dtagnames
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
[ 82%] Built target prefcnt
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
[ 82%] Built target syscse
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
[ 84%] Linking C shared library libdwarves_reorganize.so
[ 86%] Linking C shared library libdwarves_emit.so
[ 86%] Built target pglobal
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
[ 86%] Built target pdwtags
[ 86%] Built target scncopy
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
[ 86%] Built target dwarves_reorganize
[ 86%] Built target dwarves_emit
make[2]: Entering directory '/var/home/acme/git/pahole/build'
make[2]: Entering directory '/var/home/acme/git/pahole/build'
make[2]: Entering directory '/var/home/acme/git/pahole/build'
Scanning dependencies of target pahole
Scanning dependencies of target ctracer
Scanning dependencies of target pfunct
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
make[2]: Entering directory '/var/home/acme/git/pahole/build'
make[2]: Entering directory '/var/home/acme/git/pahole/build'
make[2]: Entering directory '/var/home/acme/git/pahole/build'
[ 88%] Building C object CMakeFiles/pahole.dir/pahole.c.o
[ 90%] Building C object CMakeFiles/ctracer.dir/ctracer.c.o
[ 92%] Building C object CMakeFiles/pfunct.dir/pfunct.c.o
[ 94%] Linking C executable codiff
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
[ 94%] Built target codiff
[ 96%] Linking C executable pfunct
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
[ 98%] Linking C executable ctracer
[ 98%] Built target pfunct
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
[ 98%] Built target ctracer
[100%] Linking C executable pahole
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
[100%] Built target pahole
make[1]: Leaving directory '/var/home/acme/git/pahole/build'
make: Leaving directory '/var/home/acme/git/pahole/build'
⬢[acme@toolbox pahole]$
