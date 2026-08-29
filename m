Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56CC390CA3;
	Sat, 29 Aug 2026 20:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788034912; cv=none; b=CkaX55Ue1tVa5s+VgxAxjB7v2b45KybnTpyKF3AuUHGHsmos8oAYaneYzfpW/rXaam/E0PV79RbCC0X6/Sn1rEzF0W4lVwRKNL/H/WUwwAh5ZDLzMoKsTScphmG7pGivZSXpTDIM7MbWaRsvKu1Zkl8fjPCfyX8wwY6OyCZBlEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788034912; c=relaxed/simple;
	bh=rkoZjvop/emEA4LfG/tTBdGXD21kY42SZpghFHHwisI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gw9BgiTXWzt8AIBcWPQrYVx10weRBWImFacsurl8YGUfycAN2MbCtrA0L0/lWivphdc29ThERLwRhMXoPYDwqj8EaiHiWL+iob+3LG7DpHcRz16MG04wq7XyOCY7vKvDXeN1vUX8Wsxtlz5mkWt49eMecLWKYx3O8pRuSLIzNH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRFEUW9Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRFEUW9Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2FF61F000E9;
	Sat, 29 Aug 2026 20:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788034910;
	bh=PnNUBF5uYiLqma+TmxXDwjLjGntaYni2Lprx86VGtsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NRFEUW9ZmzJAgxzwglurRr5AgMDK8NlLnySC7t4EeRAjS3gQIrC252XE3Ak/YN1+b
	 GXoVeDTeC4hQZEtx70/TcbS0OnubKKbkcUExiVuWc1gae0RliZz3hQUdauLjv+7Dbn
	 FnIXLlPcHmv1blkrVj0/hk6pmdf+WbbkT4Ufw0/9daCWr5MDHGPJVzf2BE/f+gqJ7j
	 FE1juhRtUSybqWJi8H7uOI/rQ3werAmr0z5NNIz0tNjQQtC5AXZikOdxSQjmC5BFB7
	 McB0kRfOSz0LiVg9lxyCBMjL0jEYkHKLkd9DkP2lqb3U0IuK7ydsBqHyZeFmaiALNC
	 BEizZuIyTDH5A==
Date: Sat, 29 Aug 2026 17:21:47 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>,
	bpf@vger.kernel.org, Yonghong Song <yonghong.song@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: RFT: coverage analysis and lots more regression tests in the 'next'
 branch. Was: Re: [PATCH v2 0/9] pahole: Support cross-CU type references and
 dwz alternate debug files
Message-ID: <apM_W9ld8Bj3q5Vk@x2>
References: <20260821213510.22423-1-acme@kernel.org>
 <ao442rldWrCNG3zC@x2>
 <d85a69a5-b08a-4ec8-b09c-4e45b7c1f712@oracle.com>
 <ao7lqxytDiHmVmkk@x2>
 <0e1c3820-c16b-4266-bde4-655b760b3db4@oracle.com>
 <apISzIQ-gjPB8Xqw@x2>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <apISzIQ-gjPB8Xqw@x2>

On Fri, Aug 28, 2026 at 07:59:24PM -0300, Arnaldo Carvalho de Melo wrote:
> I'm now in the process of cherry picking non-Rust related patches,
> things that don't touch the .c files in the tree, just adding coverage
> analysis, tons of tests and scripts for helping us do bisection tests,
> etc.
=20
> I just pushed out the first batch to the next branch, I invite people to
> try it and report results, it should help us to catch problems sooner by
> testing most of the paths in the codebase, which is super important
> these days where we are having (or will have) tons of patches being
> submitted.

Got all of the coverage analysis and new regression tests on the next
branch, and run the 'build-and-test.sh' script on my set of containers,
where all the test ran on:

toolsbuilder@five:~$ cat dm.log/summary
Subject: tools build test for http://192.168.86.5/pahole/dwarves-1.31.tar.x=
z build-and-test-cmd.sh

   1    78.93 almalinux:8                   : Ok   gcc (GCC) 8.5.0 20210514=
 (Red Hat 8.5.0-28) , clang version 21.1.8 ( 21.1.8-1.module_el8.10.0+4172+=
b6b13d75) flex 2.6.1
   2   158.15 almalinux:9                   : Ok   gcc (GCC) 11.5.0 2024071=
9 (Red Hat 11.5.0-14) , clang version 21.1.8 (AlmaLinux OS Foundation 21.1.=
8-2.el9) flex 2.6.4
   3    36.95 almalinux:9-i386              : Ok   gcc (GCC) 11.5.0 2024071=
9 (Red Hat 11.5.0-14) , clang version 21.1.8 (AlmaLinux OS Foundation 21.1.=
8-2.el9) flex 2.6.4
   4   167.45 almalinux:10                  : Ok   gcc (GCC) 14.3.1 2025102=
2 (Red Hat 14.3.1-4) , clang version 21.1.8 (AlmaLinux OS Foundation 21.1.8=
-1.el10.alma.1) flex 2.6.4
   5   293.08 alpine:3.22                   : Ok   gcc (Alpine 14.2.0) 14.2=
=2E0 , Alpine clang version 20.1.8 flex 2.6.4
   6   289.06 alpine:3.23                   : Ok   gcc (Alpine 15.2.0) 15.2=
=2E0 , Alpine clang version 21.1.2 flex 2.6.4
   7   255.51 alpine:3.24                   : Ok   gcc (Alpine 15.2.0) 15.2=
=2E0 , Alpine clang version 22.1.3 flex 2.6.4
   8   262.55 alpine:edge                   : Ok   gcc (Alpine 15.2.0) 15.2=
=2E0 , Alpine clang version 22.1.8 flex 2.6.4
   9   152.16 amazonlinux:2023              : Ok   gcc (GCC) 11.5.0 2024071=
9 (Red Hat 11.5.0-5) , clang version 15.0.7 (AWS 15.0.7-3.amzn2023.0.4) fle=
x 2.6.4
  10   152.38 amazonlinux:devel             : Ok   gcc (GCC) 11.3.1 2022112=
1 (Red Hat 11.3.1-4) , clang version 15.0.6 (Amazon Linux 15.0.6-3.amzn2023=
=2E0.2) flex 2.6.4
  11   171.22 archlinux:base                : Ok   gcc (GCC) 16.2.1 2026081=
0 , clang version 22.1.8 flex 2.6.4
  12   160.21 centos:stream                 : Ok   gcc (GCC) 14.4.1 2026072=
4 (Red Hat 14.4.1-2) , clang version 22.1.8 (CentOS 22.1.8-1.el10) flex 2.6=
=2E4
  13    77.34 debian:11                     : Ok   gcc (Debian 10.2.1-6) 10=
=2E2.1 20210110 , Debian clang version 13.0.1-6~deb11u1 flex 2.6.4
  14   154.23 debian:12                     : Ok   gcc (Debian 12.2.0-14+de=
b12u1) 12.2.0 , Debian clang version 14.0.6 flex 2.6.4
  15   157.32 debian:13                     : Ok   gcc (Debian 14.2.0-19) 1=
4.2.0 , Debian clang version 19.1.7 (3+b1) flex 2.6.4
  16   156.96 debian:experimental           : Ok   gcc (Debian 16.1.0-3) 16=
=2E1.0 , Debian clang version 21.1.8 (10) flex 2.6.4
  17   157.12 fedora:40                     : Ok   gcc (GCC) 14.2.1 2024091=
2 (Red Hat 14.2.1-3) , clang version 18.1.8 (Fedora 18.1.8-2.fc40) flex 2.6=
=2E4
  18   158.62 fedora:41                     : Ok   gcc (GCC) 14.3.1 2025102=
2 (Red Hat 14.3.1-4) , clang version 19.1.7 (Fedora 19.1.7-5.fc41) flex 2.6=
=2E4
  19   161.74 fedora:42                     : Ok   gcc (GCC) 15.2.1 2026012=
3 (Red Hat 15.2.1-7) , clang version 20.1.8 (Fedora 20.1.8-4.fc42) flex 2.6=
=2E4
  20   160.37 fedora:43                     : Ok   gcc (GCC) 15.3.1 2026072=
2 (Red Hat 15.3.1-1) , clang version 21.1.8 (Fedora 21.1.8-6.fc43) flex 2.6=
=2E4
  21   239.67 fedora:44                     : Ok   gcc (GCC) 16.2.1 2026081=
9 (Red Hat 16.2.1-2) , clang version 22.1.8 (Fedora 22.1.8-4.fc44) flex 2.6=
=2E4
  22   238.08 fedora:45                     : Ok   gcc (GCC) 16.2.1 2026081=
9 (Red Hat 16.2.1-2) , clang version 22.1.8 (Fedora 22.1.8-20.fc45) flex 2.=
6.4
  23   170.21 fedora:rawhide                : Ok   gcc (GCC) 16.1.1 2026070=
3 (Red Hat 16.1.1-4) , clang version 22.1.8 (Fedora 22.1.8-20.fc45) flex 2.=
6.4
  24    89.22 gentoo:stage3                 : Ok   gcc (Gentoo 15.3.0 p8) 1=
5.3.0  flex 2.6.4
  25   166.60 manjaro:base                  : Ok   gcc (GCC) 16.1.1 2026062=
5 , clang version 22.1.6 flex 2.6.4
  26   172.84 opensuse:16.0                 : Ok   gcc (SUSE Linux) 15.3.0 =
, clang version 19.1.7 flex 2.6.4
  27   166.50 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 15.3.0 =
, clang version 22.1.8 flex 2.6.4
  28    80.73 oraclelinux:8                 : Ok   gcc (GCC) 8.5.0 20210514=
 (Red Hat 8.5.0-28.0.1) , clang version 21.1.8 ( 21.1.8-1.module+el8.10.0+9=
0887+a5269809) flex 2.6.1
  29   162.06 oraclelinux:9                 : Ok   gcc (GCC) 11.5.0 2024071=
9 (Red Hat 11.5.0-14.0.1) , clang version 21.1.8 ( 21.1.8-2.el9) flex 2.6.4
  30   164.88 oraclelinux:10                : Ok   gcc (GCC) 14.3.1 2025102=
2 (Red Hat 14.3.1-4.0.1) , clang version 21.1.8 (Oracle America 21.1.8-1.el=
10) flex 2.6.4
  31    82.10 rockylinux:8                  : Ok   gcc (GCC) 8.5.0 20210514=
 (Red Hat 8.5.0-28) , clang version 21.1.8 (RESF 21.1.8-1.module+el8.10.0+4=
0180+8e26bdb3) flex 2.6.1
  32   162.01 rockylinux:9                  : Ok   gcc (GCC) 11.5.0 2024071=
9 (Red Hat 11.5.0-14) , clang version 21.1.8 (RESF 21.1.8-2.el9) flex 2.6.4
  33   166.23 rockylinux:10                 : Ok   gcc (GCC) 14.3.1 2025102=
2 (Red Hat 14.3.1-4) , clang version 21.1.8 (RESF 21.1.8-1.el10) flex 2.6.4
  34   169.75 ubuntu:22.04                  : Ok   gcc (Ubuntu 11.4.0-1ubun=
tu1~22.04.3) 11.4.0 , Ubuntu clang version 14.0.0-1ubuntu1.1 flex 2.6.4
  35   162.24 ubuntu:24.04                  : Ok   gcc (Ubuntu 13.3.0-6ubun=
tu2~24.04.1) 13.3.0 , Ubuntu clang version 18.1.3 (1ubuntu1) flex 2.6.4
  36   162.16 ubuntu:25.04                  : Ok   gcc (Ubuntu 14.2.0-19ubu=
ntu2) 14.2.0 , Ubuntu clang version 20.1.2 (0ubuntu1) flex 2.6.4
  37   161.96 ubuntu:25.10                  : Ok   gcc (Ubuntu 15.2.0-4ubun=
tu4) 15.2.0 , Ubuntu clang version 20.1.8 (0ubuntu4) flex 2.6.4
  38   163.52 ubuntu:26.04                  : Ok   gcc (Ubuntu 15.2.0-16ubu=
ntu1) 15.2.0 , Ubuntu clang version 21.1.8 (6ubuntu1) flex 2.6.4
BUILD_TARBALL_HEAD=3Deeb6956261d2fbe71715f0633a68fdc840b5f5ce
39 6242.1
toolsbuilder@five:~$

For instance:

toolsbuilder@five:~$ cat dm.log/fedora\:rawhide=20
fedora:rawhide
Downloading http://192.168.86.5/pahole/dwarves-1.31.tar.xz...
  % Total    % Received % Xferd  Average Speed  Time    Time    Time   Curr=
ent
                                 Dload  Upload  Total   Spent   Left   Speed
100  2.34M 100  2.34M   0      0 530.8M      0                             =
 0
dwarves-1.31/config.h.cmake
dwarves-1.31/btfdiff
<SNIP>
dwarves-1.31/tests/typedef_chain.sh
dwarves-1.31/tests/.test-times.seed
dwarves-1.31/HEAD
BUILD_TARBALL_HEAD=3Deeb6956261d2fbe71715f0633a68fdc840b5f5ce
Using built-in specs.
COLLECT_GCC=3Dgcc
COLLECT_LTO_WRAPPER=3D/usr/libexec/gcc/x86_64-redhat-linux/16/lto-wrapper
OFFLOAD_TARGET_NAMES=3Dnvptx-none:amdgcn-amdhsa
OFFLOAD_TARGET_DEFAULT=3D1
Target: x86_64-redhat-linux
Configured with: ../configure --enable-bootstrap --enable-languages=3Dc,c++=
,fortran,objc,obj-c++,ada,go,d,m2,cobol,algol68,lto --prefix=3D/usr --mandi=
r=3D/usr/share/man --infodir=3D/usr/share/info --with-bugurl=3Dhttps://bugz=
illa.redhat.com/ --enable-shared --enable-threads=3Dposix --enable-checking=
=3Drelease --enable-multilib --with-system-zlib --enable-__cxa_atexit --dis=
able-libunwind-exceptions --enable-gnu-unique-object --enable-linker-build-=
id --with-gcc-major-version-only --enable-libstdcxx-backtrace --with-libstd=
cxx-zoneinfo=3D/usr/share/zoneinfo --with-linker-hash-style=3Dgnu --enable-=
plugin --enable-initfini-array --with-isl=3D/builddir/build/BUILD/gcc-16.1.=
1-build/gcc-16.1.1-20260703/obj-x86_64-redhat-linux/isl-install --enable-of=
fload-targets=3Dnvptx-none,amdgcn-amdhsa --enable-offload-defaulted --witho=
ut-cuda-driver --enable-gnu-indirect-function --enable-cet --with-tune=3Dge=
neric --with-tls=3Dgnu2 --with-arch_32=3Di686 --build=3Dx86_64-redhat-linux=
 --with-build-config=3Dbootstrap-lto --enable-link-serialization=3D1 --disa=
ble-libssp
Thread model: posix
Supported LTO compression algorithms: zlib zstd
gcc version 16.1.1 20260703 (Red Hat 16.1.1-4) (GCC)=20
-- The C compiler identification is GNU 16.1.1
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Check for working C compiler: /usr/bin/cc - skipped
-- Detecting C compile features
-- Detecting C compile features - done
-- Setting BUILD_SHARED_LIBS =3D ON
-- Checking availability of DWARF and ELF development libraries
-- Looking for dwfl_module_build_id in elf
-- Looking for dwfl_module_build_id in elf - found
-- Found dwarf.h header: /usr/include
-- Found elfutils/libdw.h header: /usr/include
-- Found libdw library: /usr/lib64/libdw.so
-- Found libelf library: /usr/lib64/libelf.so
-- Checking availability of DWARF and ELF development libraries - done
-- Found ZLIB: /usr/lib64/libz.so (found version "1.3.1")
-- Checking availability of argp library
-- Assuming argp is in libc
-- Checking availability of argp library - done
-- Checking availability of obstack library
-- Assuming obstack is in libc
-- Checking availability of obstack library - done
-- Version: v1.31-tarball-g416753b4ba90 (from HEAD file)
-- Performing Test HAVE_REALLOCARRAY_SUPPORT
-- Performing Test HAVE_REALLOCARRAY_SUPPORT - Success
-- Configuring done (0.6s)
-- Generating done (0.0s)
-- Build files have been written to: /git/dwarves-1.31/build
make: Entering directory '/git/dwarves-1.31/build'
[  1%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/btf.c.o
[  3%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/features.c.o
[  5%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/bpf.c.o
[  8%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/btf_relocate.c.o
[  8%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/btf_dump.c.o
[ 10%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/hashmap.c.o
[ 13%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/bpf_prog_linfo.c.o
[ 13%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/libbpf.c.o
[ 15%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/libbpf_probes.c.o
[ 18%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/libbpf_utils.c.o
[ 20%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/linker.c.o
[ 20%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/btf_iter.c.o
[ 22%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/elf.c.o
[ 24%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/gen_loader.c.o
[ 25%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/netlink.c.o
[ 27%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/nlattr.c.o
[ 29%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/ringbuf.c.o
[ 31%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/relo_core.c.o
[ 32%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/usdt.c.o
[ 36%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/strset.c.o
[ 36%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/zip.c.o
[ 36%] Built target bpf
[ 39%] Building C object CMakeFiles/dwarves.dir/dwarves.c.o
[ 39%] Building C object CMakeFiles/dwarves.dir/dwarves_fprintf.c.o
[ 43%] Building C object CMakeFiles/dwarves.dir/rbtree.c.o
[ 43%] Building C object CMakeFiles/dwarves.dir/libctf.c.o
[ 46%] Building C object CMakeFiles/dwarves.dir/ctf_loader.c.o
[ 48%] Building C object CMakeFiles/dwarves.dir/gobuffer.c.o
[ 51%] Building C object CMakeFiles/dwarves.dir/btf_loader.c.o
[ 51%] Building C object CMakeFiles/dwarves.dir/elf_symtab.c.o
[ 48%] Building C object CMakeFiles/dwarves.dir/btf_encoder.c.o
[ 53%] Building C object CMakeFiles/dwarves.dir/dwarf_loader.c.o
[ 55%] Building C object CMakeFiles/dwarves.dir/dutil.c.o
[ 56%] Linking C shared library libdwarves.so
[ 56%] Built target dwarves
[ 60%] Building C object CMakeFiles/syscse.dir/syscse.c.o
[ 62%] Building C object CMakeFiles/dtagnames.dir/dtagnames.c.o
[ 65%] Building C object CMakeFiles/prefcnt.dir/prefcnt.c.o
[ 65%] Building C object CMakeFiles/dwarves_emit.dir/dwarves_emit.c.o
[ 72%] Building C object CMakeFiles/scncopy.dir/scncopy.c.o
[ 68%] Building C object CMakeFiles/pglobal.dir/pglobal.c.o
[ 62%] Building C object CMakeFiles/pdwtags.dir/pdwtags.c.o
[ 72%] Building C object CMakeFiles/dwarves_reorganize.dir/dwarves_reorgani=
ze.c.o
[ 68%] Building C object CMakeFiles/codiff.dir/codiff.c.o
[ 74%] Building C object CMakeFiles/scncopy.dir/elfcreator.c.o
[ 75%] Linking C executable dtagnames
[ 79%] Linking C executable pdwtags
[ 81%] Linking C executable syscse
[ 81%] Linking C executable prefcnt
[ 82%] Linking C executable pglobal
[ 84%] Linking C executable scncopy
[ 86%] Linking C shared library libdwarves_reorganize.so
[ 86%] Built target dtagnames
[ 86%] Built target pdwtags
[ 86%] Built target pglobal
[ 86%] Built target prefcnt
[ 86%] Built target syscse
[ 87%] Linking C shared library libdwarves_emit.so
[ 87%] Built target scncopy
[ 87%] Built target dwarves_reorganize
[ 87%] Built target dwarves_emit
[ 89%] Linking C executable codiff
[ 91%] Building C object CMakeFiles/pahole.dir/pahole.c.o
[ 93%] Building C object CMakeFiles/ctracer.dir/ctracer.c.o
[ 94%] Building C object CMakeFiles/pfunct.dir/pfunct.c.o
[ 94%] Built target codiff
[ 98%] Linking C executable ctracer
[ 98%] Linking C executable pfunct
[ 98%] Built target pfunct
[ 98%] Built target ctracer
[100%] Linking C executable pahole
[100%] Built target pahole
make: Leaving directory '/git/dwarves-1.31/build'
Testing pahole version:
  v1.31-tarball-g416753b4ba90

Verbose mode enabled - showing diagnostic information:
  Architecture: x86_64
  CPUs: 32
  Memory: 62.7 GB
  Swap: 8.0 GB
  Parallelism: unlimited (all tests run in parallel)
    Tip: On low-memory systems, use -j to limit parallelism (e.g., -j 4 or =
-j 1)
  Test artifacts: /tmp/pahole-tests/
  Compiler: gcc (GCC) 16.1.1 20260703 (Red Hat 16.1.1-4)
  libc: ldd (GNU libc) 2.44
  bpftool: bpftool v7.7.0
  VMLINUX: /tmp/vmlinux
  PERF_BIN: not set
  PERF_SRC_DIR: not set

  1: dwarves_emit.c: _Atomic type compile emission.                     : Ok
  2: _Atomic type display and --skip_emitting_atomic_typedefs.          : Ok
  3: Auxiliary tools: pglobal, prefcnt, dtagnames.                      : Ok
  4: Bitfield layout and data member filtering.                         : Ok
  5: dwarf_loader coverage: bitfields, templates, enums, inlines.       : Ok
  6: Bitfield typedef recoding (tag__recode_dwarf_bitfield).            : Ok
  7: BTF arena type tag encoding for kfuncs.                            : Ok
  8: BTF multi-dimensional array encoding and round-trip.               : Ok
  9: BTF bitfield encoding and loading round-trip.                      : Ok
 10: BTF VAR and DATASEC encoding for global variables.                 : Ok
 11: BTF deduplication of array types across CUs.                       : Ok
 12: Distilled base BTF generation.                                     : Ok
 13: BTF encoding options.                                              : Ok
 14: BTF encoder coverage.                                              : Ok
 15: Validation of BTF encoding of functions.                           : Ok
 16: BTF_KIND_FWD encoding and loading round-trip.                      : Ok
 17: BTF encoding with invalid symbol names.                            : Ok
 18: Split BTF encoding (vmlinux base + kernel module).                 : S=
kip (no loaded module with debuginfod-available debuginfo found)
 19: Check BTF type tag order.                                          : Ok
 20: BTF FLOAT and ENUM64 type encoding.                                : Ok
 21: BTF encoder verbose logging coverage.                              : Ok
 23: BTF encoding into ELF via pahole -J (btf_encoder__write_elf).      : Ok
 24: BTF true_signature: clang optimized aggregate parameters (2 structs: Ok
 25: BTF true_signature: clang optimized aggregate parameters (2 structs: Ok
 26: BTF true_signature: clang optimized with large union parameter     : Ok
 27: BTF true_signature: clang optimized parameters (scalar)            : Ok
 28: BTF true_signature: clang optimized with stack parameters (9 params: Ok
 29: BTF true_signature: clang optimized with stack parameters (non-stat: Ok
 30: Class name list from file.                                         : Ok
 31: CLI display and filtering options.                                 : Ok
 32: codiff struct comparison.                                          : Ok
 33: codiff coverage: terse, functions, verbose, multi-CU.              : Ok
 34: codiff member change coverage.                                     : Ok
 35: codiff multi-CU: __cus__find_cu_by_name coverage.                  : Ok
 36: Compilable output and type filtering.                              : Ok
 37: Type containment and pointer search.                               : Ok
 38: C++ namespace and using-declaration display.                       : Ok
 39: C++ variadic template parameter pack handling.                     : Ok
 40: Class name filtering.                                              : Ok
 41: Default BTF on a system without BTF.                               : Ok
 42: Display format options.                                            : Ok
 43: dwarf_loader.c edge cases: bitfield recode, inlining, call sites.  : Ok
 44: dwarves.c core API coverage.                                       : Ok
 45: DWZ alternate debug file type resolution.                          : Ok
 46: Atomic typedef emission.                                           : Ok
 47: Legacy atomic_ base type emission via --compile (hand-crafted DWARF: Ok
 48: dwarves_emit.c / dwarves_reorganize.c coverage.                    : Ok
 49: Enumerator search.                                                 : Ok
 50: Expand pointers option.                                            : Ok
 51: Type expansion and anonymous struct options.                       : Ok
 52: Flexible arrays accounting.                                        : Ok
 53: Validation of GCC optimized parameters in default BTF.             : Ok
 54: Validation of BTF encoding of true_signatures.                     : S=
kip (no optimizations applied.)
 56: Multi-file loading (cus__load_files).                              : Ok
 57: Version output.                                                    : Ok
 58: Header, range and seek_bytes prettify paths.                       : Ok
 59: pahole.c scattered option paths.                                   : Ok
 60: pdwtags DWARF tag display.                                         : Ok
 61: Check that pfunct can print btf_decl_tags read from BTF.           : Ok
 62: pfunct coverage: symtab, class, expand_types, compile.             : Ok
 63: pfunct function statistics.                                        : Ok
 64: pglobal basic: variables, functions, static exclusion.             : Ok
 65: prefcnt.c: reference counting coverage.                            : Ok
 68: Cacheline boundary display with large structs.                     : Ok
 70: Sizes and holes display.                                           : Ok
 71: Small files coverage: elf_symtab, gobuffer, dutil, pglobal.        : Ok
 72: Sort output and separator.                                         : Ok
 73: Typedef chain display.                                             : Ok
 55: Compare parallel vs merged CU loading for inter-CU type references.: O=
k   =20
 66: Pretty printing of files using DWARF type information.             : O=
k   =20
 67: Prototype expression parsing and prettify.                         : Ok
 69: Parallel reproducible DWARF Loading/Serial BTF encoding.           : O=
k   =20
 22: BTF encoding on vmlinux.                                           : O=
k   =20
Saved timing data to .test-times (73 tests)

+ '[' ']'
+ set +o xtrace
clang version 22.1.8 (Fedora 22.1.8-20.fc45)
Target: x86_64-redhat-linux-gnu
Thread model: posix
InstalledDir: /usr/bin
Configuration file: /etc/clang/x86_64-redhat-linux-gnu-clang.cfg
System configuration file directory: /etc/clang/
Found candidate GCC installation: /usr/bin/../lib/gcc/x86_64-redhat-linux/16
Selected GCC installation: /usr/bin/../lib/gcc/x86_64-redhat-linux/16
Candidate multilib: .;@m64
Candidate multilib: 32;@m32
Selected multilib: .;@m64
mkdir: cannot create directory 'build': File exists
-- Setting BUILD_SHARED_LIBS =3D ON
-- Checking availability of DWARF and ELF development libraries
-- Checking availability of DWARF and ELF development libraries - done
-- Checking availability of argp library
-- Assuming argp is in libc
-- Checking availability of argp library - done
-- Checking availability of obstack library
-- Assuming obstack is in libc
-- Checking availability of obstack library - done
-- Version: v1.31-tarball-g416753b4ba90 (from HEAD file)
-- Configuring done (0.1s)
-- Generating done (0.0s)
-- Build files have been written to: /git/dwarves-1.31/build
make: Entering directory '/git/dwarves-1.31/build'
[ 36%] Built target bpf
[ 56%] Built target dwarves
[ 65%] Built target dwarves_reorganize
[ 67%] Built target dwarves_emit
[ 67%] Built target dtagnames
[ 70%] Built target codiff
[ 74%] Built target pdwtags
[ 77%] Built target pglobal
[ 82%] Built target scncopy
[ 86%] Built target syscse
[ 89%] Built target prefcnt
[ 93%] Built target ctracer
[ 96%] Built target pfunct
[100%] Built target pahole
make: Leaving directory '/git/dwarves-1.31/build'
Testing pahole version:
  v1.31-tarball-g416753b4ba90

Verbose mode enabled - showing diagnostic information:
  Architecture: x86_64
  CPUs: 32
  Memory: 62.7 GB
  Swap: 8.0 GB
  Parallelism: unlimited (all tests run in parallel)
    Tip: On low-memory systems, use -j to limit parallelism (e.g., -j 4 or =
-j 1)
  Test artifacts: /tmp/pahole-tests/
  Compiler: clang version 22.1.8 (Fedora 22.1.8-20.fc45)
  libc: ldd (GNU libc) 2.44
  bpftool: bpftool v7.7.0
  VMLINUX: /tmp/vmlinux
  PERF_BIN: not set
  PERF_SRC_DIR: not set

  1: dwarves_emit.c: _Atomic type compile emission.                     : Ok
  2: _Atomic type display and --skip_emitting_atomic_typedefs.          : Ok
  3: Auxiliary tools: pglobal, prefcnt, dtagnames.                      : Ok
  4: Bitfield layout and data member filtering.                         : Ok
  5: dwarf_loader coverage: bitfields, templates, enums, inlines.       : Ok
  6: Bitfield typedef recoding (tag__recode_dwarf_bitfield).            : Ok
  7: BTF arena type tag encoding for kfuncs.                            : Ok
  8: BTF multi-dimensional array encoding and round-trip.               : Ok
  9: BTF bitfield encoding and loading round-trip.                      : Ok
 10: BTF VAR and DATASEC encoding for global variables.                 : Ok
 11: BTF deduplication of array types across CUs.                       : Ok
 12: Distilled base BTF generation.                                     : Ok
 13: BTF encoding options.                                              : Ok
 14: BTF encoder coverage.                                              : Ok
 15: Validation of BTF encoding of functions.                           : Ok
 16: BTF_KIND_FWD encoding and loading round-trip.                      : Ok
 17: BTF encoding with invalid symbol names.                            : Ok
 18: Split BTF encoding (vmlinux base + kernel module).                 : S=
kip (no loaded module with debuginfod-available debuginfo found)
 19: Check BTF type tag order.                                          : Ok
 20: BTF FLOAT and ENUM64 type encoding.                                : Ok
 21: BTF encoder verbose logging coverage.                              : Ok
 22: BTF encoding into ELF via pahole -J (btf_encoder__write_elf).      : Ok
 23: BTF true_signature: clang optimized aggregate parameters (2 structs: Ok
 24: BTF true_signature: clang optimized aggregate parameters (2 structs: Ok
 25: BTF true_signature: clang optimized with large union parameter     : Ok
 26: BTF true_signature: clang optimized parameters (scalar)            : Ok
 27: BTF true_signature: clang optimized with stack parameters (9 params: Ok
 28: BTF true_signature: clang optimized with stack parameters (non-stat: Ok
 29: Class name list from file.                                         : Ok
 30: CLI display and filtering options.                                 : Ok
 31: codiff struct comparison.                                          : Ok
 32: codiff coverage: terse, functions, verbose, multi-CU.              : Ok
 33: codiff member change coverage.                                     : Ok
 34: codiff multi-CU: __cus__find_cu_by_name coverage.                  : Ok
 35: Compilable output and type filtering.                              : Ok
 36: Type containment and pointer search.                               : Ok
 37: C++ namespace and using-declaration display.                       : Ok
 38: C++ variadic template parameter pack handling.                     : Ok
 39: Class name filtering.                                              : Ok
 40: Default BTF on a system without BTF.                               : Ok
 41: Display format options.                                            : Ok
 42: dwarf_loader.c edge cases: bitfield recode, inlining, call sites.  : Ok
 43: dwarves.c core API coverage.                                       : Ok
 44: DWZ alternate debug file type resolution.                          : Ok
 45: Atomic typedef emission.                                           : Ok
 46: Legacy atomic_ base type emission via --compile (hand-crafted DWARF: Ok
 47: dwarves_emit.c / dwarves_reorganize.c coverage.                    : Ok
 48: Enumerator search.                                                 : Ok
 49: Expand pointers option.                                            : Ok
 50: Type expansion and anonymous struct options.                       : Ok
 51: Flexible arrays accounting.                                        : Ok
 52: Validation of GCC optimized parameters in default BTF.             : Ok
 53: Validation of BTF encoding of true_signatures.                     : S=
kip (no optimizations applied.)
 54: Multi-file loading (cus__load_files).                              : Ok
 55: Version output.                                                    : Ok
 56: Header, range and seek_bytes prettify paths.                       : Ok
 57: pahole.c scattered option paths.                                   : Ok
 58: pdwtags DWARF tag display.                                         : Ok
 59: Check that pfunct can print btf_decl_tags read from BTF.           : Ok
 60: pfunct coverage: symtab, class, expand_types, compile.             : Ok
 61: pfunct function statistics.                                        : Ok
 62: pglobal basic: variables, functions, static exclusion.             : Ok
 63: prefcnt.c: reference counting coverage.                            : Ok
 64: Cacheline boundary display with large structs.                     : Ok
 65: Sizes and holes display.                                           : Ok
 66: Small files coverage: elf_symtab, gobuffer, dutil, pglobal.        : Ok
 67: Sort output and separator.                                         : Ok
 68: Typedef chain display.                                             : Ok
 70: Compare parallel vs merged CU loading for inter-CU type references.: Ok
 71: Pretty printing of files using DWARF type information.             : Ok
 72: Prototype expression parsing and prettify.                         : Ok
 73: Parallel reproducible DWARF Loading/Serial BTF encoding.           : O=
k   =20
 69: BTF encoding on vmlinux.                                           : O=
k   =20
Saved timing data to .test-times (73 tests)

toolsbuilder@five:~$=20


