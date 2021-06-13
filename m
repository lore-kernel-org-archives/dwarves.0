Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3C3C48BDF
	for <linux-dwarves@archiver.kernel.org>; Sun, 13 Jun 2021 13:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 557C16108E
	for <linux-dwarves@archiver.kernel.org>; Sun, 13 Jun 2021 13:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbhFMNQE (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Sun, 13 Jun 2021 09:16:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231286AbhFMNQE (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Sun, 13 Jun 2021 09:16:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5F44601FE;
        Sun, 13 Jun 2021 13:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623590043;
        bh=PrLfwku8nNtTuCNOlUCW0Pz9hBjGAYPeUEslnkc4img=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IUgr5tOxP5IM/toWd0SXGgFpMYCrVnnQjJFqbZE+34v/zKwrNyeErk9B2Ab68q+UO
         BeDMSWIf7vb2RyVi5p/EwFQNtvecclhS+JyqTPRE1Ya0FAm9jRBN/N2hRspJyq7Jj0
         6RfpmX5pgi+Xsk0rl8dMu5PEtj+8qdt/hN0DrlyIyu6N6EeWDsvaOSB/uexsh5x/nR
         fLarXZGVV7JeZrFAmiprHPCO2DBLK1Ut22IYpTcQVXXGFLhJ0FipV4xfLb1MDkYrno
         QXi6W422xPpv1y0fRD6I+S0c2eBs5i1RkVXVZnOnWcXjhcdsgKdsxPIgs0gkuG9o2X
         WBOHcWfqGTOqA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2CB4C40B1A; Sun, 13 Jun 2021 10:14:00 -0300 (-03)
Date:   Sun, 13 Jun 2021 10:14:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Luca Boccassi <bluca@debian.org>, dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH dwarves] Add missing lib/include/bpf -> ../bpf/src symlink
Message-ID: <YMYEmD7d00sj6UEx@kernel.org>
References: <20210611230126.57713-1-bluca@debian.org>
 <CAEf4BzYTSd1PvreyK8gsdL6=XPPqELQpz7DYAc-B=cH7L0QDKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYTSd1PvreyK8gsdL6=XPPqELQpz7DYAc-B=cH7L0QDKQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Fri, Jun 11, 2021 at 04:42:24PM -0700, Andrii Nakryiko escreveu:
> On Fri, Jun 11, 2021 at 4:03 PM Luca Boccassi <bluca@debian.org> wrote:
> >
> > The original "libbpf: allow to use packaged version" had a symlink
> > as suggested during review:
> >
> > https://www.spinics.net/lists/dwarves/msg00738.html
> >
> > git show 82749180b23d3c9c060108bc290ae26507fc324e -- lib/include
> > commit 82749180b23d3c9c060108bc290ae26507fc324e
> > Author: Luca Boccassi <bluca@debian.org>
> > Date:   Mon Jan 4 22:16:22 2021 +0000
> >
> >     libbpf: allow to use packaged version
> >
> >     Add a new CMake option, LIBBPF_EMBEDDED, to switch between the
> >     embedded version and the system version (searched via pkg-config)
> >     of libbpf. Set the embedded version as the default.
> >
> >     Signed-off-by: Luca Boccassi <bluca@debian.org>
> >     Cc: dwarves@vger.kernel.org
> >     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> >
> > diff --git a/lib/include/bpf b/lib/include/bpf
> > new file mode 120000
> > index 0000000..4c41b71
> > --- /dev/null
> > +++ b/lib/include/bpf
> > @@ -0,0 +1 @@
> > +../bpf/src
> > \ No newline at end of file
> >
> > This patch was reverted, and then re-added manually.
> > But the re-add dropped the symlink, which causes the system bpf/btf.h
> > to be picked up instead of the local one. Re-add it.
> >
> > Signed-off-by: Luca Boccassi <bluca@debian.org>
> > ---
> 
> This fixes the issue for me in my local setup:
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

That is really interesting, as it breaks the build for me on a freshly
cloned pahole tree where I added the symlink by hand before running
cmake, see below, trying to figure this out...

⬢[acme@toolbox pahole]$ git show
commit 576f43abe5b4bd94b894614d7204af5e3469e15b (HEAD -> master)
Author: Luca Boccassi <bluca@debian.org>
Date:   Sun Jun 13 10:07:39 2021 -0300

    libbpf: Fixup patch to allow to use packaged version

    The original "libbpf: allow to use packaged version" had a symlink as
    suggested during review, that got mistakenly dropped by Arnaldo when
    applying the patch by hand to fixup conflicts, add it back.

    Committer notes:

    This caused mixups with libbpf-devel files that ended up breaking the
    build as reported by Andrii.

    Reported-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
    Tested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
    Signed-off-by: Luca Boccassi <bluca@debian.org>
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/lib/include/bpf b/lib/include/bpf
new file mode 120000
index 0000000000000000..b76dda3adf57d87d
--- /dev/null
+++ b/lib/include/bpf
@@ -0,0 +1 @@
+../src/bpf
\ No newline at end of file
⬢[acme@toolbox pahole]$

⬢[acme@toolbox pahole]$ ls -la lib/bpf
total 0
drwxr-xr-x. 1 acme acme   0 Jun 13 10:04 .
drwxr-xr-x. 1 acme acme 132 Jun 13 10:06 ..
⬢[acme@toolbox pahole]$ rm -rf build ; mkdir build ; cd build ; cmake -DCMAKE_BUILD_TYPE=Release -DLIBBPF_EMBEDDED=Off .. ; cd ..
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
Submodule 'lib/bpf' (https://github.com/libbpf/libbpf) registered for path 'lib/bpf'
Cloning into '/var/home/acme/git/pahole/lib/bpf'...
Submodule path 'lib/bpf': checked out '986962fade5dfa89c2890f3854eb040d2a64ab38'
-- Submodule update - done
-- Performing Test HAVE_REALLOCARRAY_SUPPORT
-- Performing Test HAVE_REALLOCARRAY_SUPPORT - Success
-- Configuring done
-- Generating done
-- Build files have been written to: /var/home/acme/git/pahole/build
⬢[acme@toolbox pahole]$ ls -la lib/bpf
total 68
drwxr-xr-x. 1 acme acme   280 Jun 13 10:11 .
drwxr-xr-x. 1 acme acme   132 Jun 13 10:06 ..
-rw-r--r--. 1 acme acme    41 Jun 13 10:11 BPF-CHECKPOINT-COMMIT
-rw-r--r--. 1 acme acme    41 Jun 13 10:11 CHECKPOINT-COMMIT
-rw-r--r--. 1 acme acme    35 Jun 13 10:11 .git
drwxr-xr-x. 1 acme acme    24 Jun 13 10:11 include
-rw-r--r--. 1 acme acme   471 Jun 13 10:11 .lgtm.yml
-rw-r--r--. 1 acme acme    25 Jun 13 10:11 LICENSE
-rw-r--r--. 1 acme acme  1641 Jun 13 10:11 LICENSE.BSD-2-Clause
-rw-r--r--. 1 acme acme 27413 Jun 13 10:11 LICENSE.LGPL-2.1
-rw-r--r--. 1 acme acme  6568 Jun 13 10:11 README.md
drwxr-xr-x. 1 acme acme    50 Jun 13 10:11 scripts
drwxr-xr-x. 1 acme acme   692 Jun 13 10:11 src
drwxr-xr-x. 1 acme acme    28 Jun 13 10:11 travis-ci
-rw-r--r--. 1 acme acme  5555 Jun 13 10:11 .travis.yml
⬢[acme@toolbox pahole]$ ls -la lib/include/bpf
lrwxrwxrwx. 1 acme acme 10 Jun 13 10:07 lib/include/bpf -> ../src/bpf
⬢[acme@toolbox pahole]$ m
make: Entering directory '/var/home/acme/git/pahole/build'
make[1]: Entering directory '/var/home/acme/git/pahole/build'
make[2]: Entering directory '/var/home/acme/git/pahole/build'
Scanning dependencies of target bpf
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
make[2]: Entering directory '/var/home/acme/git/pahole/build'
[  1%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/bpf_prog_linfo.c.o
[  3%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/bpf.c.o
[  7%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/btf_dump.c.o
[  7%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/btf.c.o
[ 11%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/libbpf.c.o
[ 11%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/hashmap.c.o
[ 13%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/libbpf_probes.c.o
[ 15%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/libbpf_errno.c.o
[ 17%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/netlink.c.o
[ 19%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/nlattr.c.o
[ 23%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/ringbuf.c.o
[ 23%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/str_error.c.o
[ 25%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/xsk.c.o
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
[ 25%] Built target bpf
make[2]: Entering directory '/var/home/acme/git/pahole/build'
Scanning dependencies of target dwarves
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
make[2]: Entering directory '/var/home/acme/git/pahole/build'
[ 36%] Building C object CMakeFiles/dwarves.dir/ctf_encoder.c.o
[ 36%] Building C object CMakeFiles/dwarves.dir/strings.c.o
[ 36%] Building C object CMakeFiles/dwarves.dir/libctf.c.o
[ 36%] Building C object CMakeFiles/dwarves.dir/gobuffer.c.o
[ 36%] Building C object CMakeFiles/dwarves.dir/dwarves.c.o
[ 36%] Building C object CMakeFiles/dwarves.dir/dwarves_fprintf.c.o
[ 38%] Building C object CMakeFiles/dwarves.dir/ctf_loader.c.o
[ 40%] Building C object CMakeFiles/dwarves.dir/dwarf_loader.c.o
[ 42%] Building C object CMakeFiles/dwarves.dir/btf_loader.c.o
[ 44%] Building C object CMakeFiles/dwarves.dir/btf_encoder.c.o
[ 46%] Building C object CMakeFiles/dwarves.dir/elf_symtab.c.o
[ 48%] Building C object CMakeFiles/dwarves.dir/dutil.c.o
[ 50%] Building C object CMakeFiles/dwarves.dir/rbtree.c.o
In file included from /var/home/acme/git/pahole/strings.c:7:
/var/home/acme/git/pahole/pahole_strings.h:9:10: fatal error: bpf/btf.h: No such file or directory
    9 | #include <bpf/btf.h>
      |          ^~~~~~~~~~~
compilation terminated.
make[2]: *** [CMakeFiles/dwarves.dir/build.make:121: CMakeFiles/dwarves.dir/strings.c.o] Error 1
make[2]: *** Waiting for unfinished jobs....
In file included from /var/home/acme/git/pahole/dwarves.h:20,
                 from /var/home/acme/git/pahole/btf_encoder.c:12:
/var/home/acme/git/pahole/pahole_strings.h:9:10: fatal error: bpf/btf.h: No such file or directory
    9 | #include <bpf/btf.h>
      |          ^~~~~~~~~~~
compilation terminated.
make[2]: *** [CMakeFiles/dwarves.dir/build.make:173: CMakeFiles/dwarves.dir/btf_encoder.c.o] Error 1
In file included from /var/home/acme/git/pahole/dwarves.h:20,
                 from /var/home/acme/git/pahole/ctf_encoder.c:8:
/var/home/acme/git/pahole/pahole_strings.h:9:10: fatal error: bpf/btf.h: No such file or directory
    9 | #include <bpf/btf.h>
      |          ^~~~~~~~~~~
compilation terminated.
make[2]: *** [CMakeFiles/dwarves.dir/build.make:134: CMakeFiles/dwarves.dir/ctf_encoder.c.o] Error 1
In file included from /var/home/acme/git/pahole/libctf.c:22:
/var/home/acme/git/pahole/pahole_strings.h:9:10: fatal error: bpf/btf.h: No such file or directory
    9 | #include <bpf/btf.h>
      |          ^~~~~~~~~~~
compilation terminated.
/var/home/acme/git/pahole/btf_loader.c:24:10: fatal error: bpf/libbpf.h: No such file or directory
   24 | #include <bpf/libbpf.h>
      |          ^~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [CMakeFiles/dwarves.dir/build.make:160: CMakeFiles/dwarves.dir/libctf.c.o] Error 1
make[2]: *** [CMakeFiles/dwarves.dir/build.make:186: CMakeFiles/dwarves.dir/btf_loader.c.o] Error 1
In file included from /var/home/acme/git/pahole/dwarves.h:20,
                 from /var/home/acme/git/pahole/dwarves_fprintf.c:19:
/var/home/acme/git/pahole/pahole_strings.h:9:10: fatal error: bpf/btf.h: No such file or directory
    9 | #include <bpf/btf.h>
      |          ^~~~~~~~~~~
compilation terminated.
In file included from /var/home/acme/git/pahole/dwarves.h:20,
                 from /var/home/acme/git/pahole/dwarf_loader.c:23:
/var/home/acme/git/pahole/pahole_strings.h:9:10: fatal error: bpf/btf.h: No such file or directory
    9 | #include <bpf/btf.h>
      |          ^~~~~~~~~~~
compilation terminated.
make[2]: *** [CMakeFiles/dwarves.dir/build.make:95: CMakeFiles/dwarves.dir/dwarves_fprintf.c.o] Error 1
make[2]: *** [CMakeFiles/dwarves.dir/build.make:199: CMakeFiles/dwarves.dir/dwarf_loader.c.o] Error 1
In file included from /var/home/acme/git/pahole/dwarves.h:20,
                 from /var/home/acme/git/pahole/ctf_loader.c:25:
/var/home/acme/git/pahole/pahole_strings.h:9:10: fatal error: bpf/btf.h: No such file or directory
    9 | #include <bpf/btf.h>
      |          ^~~~~~~~~~~
compilation terminated.
make[2]: *** [CMakeFiles/dwarves.dir/build.make:147: CMakeFiles/dwarves.dir/ctf_loader.c.o] Error 1
In file included from /var/home/acme/git/pahole/dwarves.h:20,
                 from /var/home/acme/git/pahole/dwarves.c:28:
/var/home/acme/git/pahole/pahole_strings.h:9:10: fatal error: bpf/btf.h: No such file or directory
    9 | #include <bpf/btf.h>
      |          ^~~~~~~~~~~
compilation terminated.
make[2]: *** [CMakeFiles/dwarves.dir/build.make:82: CMakeFiles/dwarves.dir/dwarves.c.o] Error 1
make[2]: Leaving directory '/var/home/acme/git/pahole/build'
make[1]: *** [CMakeFiles/Makefile2:283: CMakeFiles/dwarves.dir/all] Error 2
make[1]: Leaving directory '/var/home/acme/git/pahole/build'
make: *** [Makefile:149: all] Error 2
make: Leaving directory '/var/home/acme/git/pahole/build'
⬢[acme@toolbox pahole]$


