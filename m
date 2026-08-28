Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B771DF748;
	Fri, 28 Aug 2026 22:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787957970; cv=none; b=lMd4HOxwCRUmMaclUsGCWYwgPBPkgDUT7Gq3ufvocCC8rMV49lLU2pXKgBi+kly0HHTgnTa3J1bR7lkXFA8/3HEmQytmQHNuV/Pc83B3XjNTm9yDtin6yijc/sS3fRIozZZ4PuQZdJP7uj1uIhhb45cj7UFKtWVI6d7kb5PjvXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787957970; c=relaxed/simple;
	bh=v15MYwRmxQb1In+0ob/sHTAJS5ap5ZhslpKQhwQSEzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iH0PJysHZis4A/elhOgaaw24AnhQW0D87NogtZj38uNtzLZnOO8N0HklRJuPD+o9BlQo9q3Sl3XszvtyDDuac1WVbc/L5TmUQCVie7NuGjuVg8jBMfZ6WYzluXZmrvuLM42/8FMcYAw3wC+bpKvvE+Gs4ht0nUOrcPotEYfbLvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vmho4pLG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vmho4pLG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7714C1F000E9;
	Fri, 28 Aug 2026 22:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787957968;
	bh=jp1qo2qs2Nmj1S6rZghhHS4sGcXF3jNlFkVN9iDAokQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vmho4pLGcKZhqTzSAi7lAk7/Ofp0Z7seX5Bd/rn41DdX/zun3YoZ+ENLb4lRStHcE
	 cvkYIyp6EmKbJmMeKEL9YObBZpEsfvjSRq+ET8cz6nqtOkJVpcmEToCDTbTf9ZFCca
	 3J37DMr7oCBje60DtGeRgFeB34a0WUvOx5vAhLY7aCABsfmUjFpLjpJf1jZTE7NRJ3
	 Hl9NUJ+lsadeJ5mJ87257PBmBQwj8l+ido36S4HFCkgSrIzY0AWfeM5hzrJD7pZDgo
	 odLusoqvXrHzztszkMD0r1agIPn/6VnSeVXlgggbc+O0kFVMacyL0uMGhc9xCtdTn2
	 57EstOLL0Rm/g==
Date: Fri, 28 Aug 2026 19:59:24 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>,
	bpf@vger.kernel.org, Yonghong Song <yonghong.song@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v2 0/9] pahole: Support cross-CU type references and dwz
 alternate debug files
Message-ID: <apISzIQ-gjPB8Xqw@x2>
References: <20260821213510.22423-1-acme@kernel.org>
 <ao442rldWrCNG3zC@x2>
 <d85a69a5-b08a-4ec8-b09c-4e45b7c1f712@oracle.com>
 <ao7lqxytDiHmVmkk@x2>
 <0e1c3820-c16b-4266-bde4-655b760b3db4@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e1c3820-c16b-4266-bde4-655b760b3db4@oracle.com>

On Fri, Aug 28, 2026 at 03:05:02PM +0100, Alan Maguire wrote:
> On 26/08/2026 14:10, Arnaldo Carvalho de Melo wrote:
> > On Wed, Aug 26, 2026 at 12:43:09PM +0100, Alan Maguire wrote:
> >> I tried a few other approaches where we handle inter-cu references, but all seemed
> >> like they were a bit too complex or involved multiple traversals of the CU set and
> >> were too expensive time-wise.

> >> I can land these if you'd prefer, whatever works. Thanks!

> > Please do it, I think its better so that we try to have multiple people
> > involved in landing features that touch the code code like in this case.

> > I'll then land the testing infra that doesn't touch the code code and is
> > less risky.
 
> series applied, thanks!

Thanks a lot!

I'm now in the process of cherry picking non-Rust related patches,
things that don't touch the .c files in the tree, just adding coverage
analysis, tons of tests and scripts for helping us do bisection tests,
etc.

I just pushed out the first batch to the next branch, I invite people to
try it and report results, it should help us to catch problems sooner by
testing most of the paths in the codebase, which is super important
these days where we are having (or will have) tons of patches being
submitted.

Tests 10-15 are different, just have the same description, this is a
preexisting problem that I think I have a fix but didn't cherry pick it
yet, there are lots more tests to cherry pick before I turn my attention
back to the rust work:

⬢ [acme@toolbx pahole]$ rm -rf build
⬢ [acme@toolbx pahole]$ ./build-and-test-cmd.sh
-- The C compiler identification is GNU 16.2.1
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
-- Found ZLIB: /usr/lib64/libz.so (found version "1.3.1")
-- Checking availability of argp library
-- Assuming argp is in libc
-- Checking availability of argp library - done
-- Checking availability of obstack library
-- Assuming obstack is in libc
-- Checking availability of obstack library - done
-- Submodule update
-- Submodule update - done
-- Version: v1.31-124-g2cb95a21681fa42e
-- Performing Test HAVE_REALLOCARRAY_SUPPORT
-- Performing Test HAVE_REALLOCARRAY_SUPPORT - Success
-- Configuring done (0.6s)
-- Generating done (0.0s)
-- Build files have been written to: /home/acme/git/pahole/build
make: Entering directory '/home/acme/git/pahole/build'
[  1%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/bpf.c.o
[  3%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/btf.c.o
[  5%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/btf_iter.c.o
[  6%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/elf.c.o
[ 12%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/features.c.o
[ 12%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/bpf_prog_linfo.c.o
[ 12%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/btf_dump.c.o
[ 13%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/gen_loader.c.o
[ 15%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/hashmap.c.o
[ 17%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/linker.c.o
[ 18%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/btf_relocate.c.o
[ 20%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/netlink.c.o
[ 24%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/nlattr.c.o
[ 25%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/libbpf_utils.c.o
[ 25%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/libbpf.c.o
[ 27%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/libbpf_probes.c.o
[ 31%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/ringbuf.c.o
[ 31%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/zip.c.o
[ 32%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/relo_core.c.o
[ 34%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/strset.c.o
[ 36%] Building C object CMakeFiles/bpf.dir/lib/bpf/src/usdt.c.o
[ 36%] Built target bpf
[ 39%] Building C object CMakeFiles/dwarves.dir/libctf.c.o
[ 39%] Building C object CMakeFiles/dwarves.dir/dwarves_fprintf.c.o
[ 43%] Building C object CMakeFiles/dwarves.dir/ctf_loader.c.o
[ 43%] Building C object CMakeFiles/dwarves.dir/gobuffer.c.o
[ 46%] Building C object CMakeFiles/dwarves.dir/dutil.c.o
[ 46%] Building C object CMakeFiles/dwarves.dir/btf_loader.c.o
[ 48%] Building C object CMakeFiles/dwarves.dir/rbtree.c.o
[ 50%] Building C object CMakeFiles/dwarves.dir/dwarves.c.o
[ 51%] Building C object CMakeFiles/dwarves.dir/elf_symtab.c.o
[ 53%] Building C object CMakeFiles/dwarves.dir/dwarf_loader.c.o
[ 55%] Building C object CMakeFiles/dwarves.dir/btf_encoder.c.o
[ 56%] Linking C shared library libdwarves.so
[ 56%] Built target dwarves
[ 58%] Building C object CMakeFiles/dwarves_emit.dir/dwarves_emit.c.o
[ 60%] Building C object CMakeFiles/dwarves_reorganize.dir/dwarves_reorganize.c.o
[ 62%] Building C object CMakeFiles/prefcnt.dir/prefcnt.c.o
[ 63%] Building C object CMakeFiles/scncopy.dir/scncopy.c.o
[ 65%] Building C object CMakeFiles/scncopy.dir/elfcreator.c.o
[ 68%] Building C object CMakeFiles/codiff.dir/codiff.c.o
[ 68%] Building C object CMakeFiles/pglobal.dir/pglobal.c.o
[ 70%] Building C object CMakeFiles/pdwtags.dir/pdwtags.c.o
[ 72%] Building C object CMakeFiles/dtagnames.dir/dtagnames.c.o
[ 74%] Building C object CMakeFiles/syscse.dir/syscse.c.o
[ 75%] Linking C executable dtagnames
[ 77%] Linking C executable prefcnt
[ 79%] Linking C executable syscse
[ 81%] Linking C executable pdwtags
[ 82%] Linking C executable pglobal
[ 82%] Built target dtagnames
[ 84%] Linking C executable scncopy
[ 84%] Built target prefcnt
[ 84%] Built target syscse
[ 86%] Linking C shared library libdwarves_reorganize.so
[ 86%] Built target pdwtags
[ 86%] Built target pglobal
[ 87%] Linking C shared library libdwarves_emit.so
[ 87%] Built target scncopy
[ 87%] Built target dwarves_reorganize
[ 87%] Built target dwarves_emit
[ 89%] Linking C executable codiff
[ 91%] Building C object CMakeFiles/ctracer.dir/ctracer.c.o
[ 93%] Building C object CMakeFiles/pahole.dir/pahole.c.o
[ 94%] Building C object CMakeFiles/pfunct.dir/pfunct.c.o
[ 94%] Built target codiff
[ 96%] Linking C executable pfunct
[ 98%] Linking C executable ctracer
[ 98%] Built target pfunct
[ 98%] Built target ctracer
[100%] Linking C executable pahole
[100%] Built target pahole
make: Leaving directory '/home/acme/git/pahole/build'
Testing pahole version:
  v1.31-124-g2cb95a21681fa42e

Verbose mode enabled - showing diagnostic information:
  Architecture: x86_64
  CPUs: 32
  Memory: 62.7 GB
  Swap: 8.0 GB
  Parallelism: unlimited (all tests run in parallel)
    Tip: On low-memory systems, use -j to limit parallelism (e.g., -j 4 or -j 1)
  Test artifacts: /tmp/pahole-tests/
  Compiler: gcc (GCC) 16.2.1 20260819 (Red Hat 16.2.1-2)
  libc: ldd (GNU libc) 2.43
  bpftool: bpftool v7.6.0
  VMLINUX: not set
  PERF_BIN: not set
  PERF_SRC_DIR: not set

  1: Bitfield layout and data member filtering.                         : Ok
  2: BTF arena type tag encoding for kfuncs.                            : Ok
  3: BTF multi-dimensional array encoding and round-trip.               : Ok
  4: BTF bitfield encoding and loading round-trip.                      : Ok
  5: BTF VAR and DATASEC encoding for global variables.                 : Ok
  6: BTF_KIND_FWD encoding and loading round-trip.                      : Ok
  8: BTF FLOAT and ENUM64 type encoding.                                : Ok
  9: Check BTF type tag order.                                          : Ok
 10: Validation of BTF encoding of true_signatures.                     : Ok
 11: Validation of BTF encoding of true_signatures.                     : Ok
 12: Validation of BTF encoding of true_signatures.                     : Ok
 13: Validation of BTF encoding of true_signatures.                     : Ok
 14: Validation of BTF encoding of true_signatures.                     : Ok
 15: Validation of BTF encoding of true_signatures.                     : Ok
 16: Class name list from file.                                         : Ok
 17: codiff struct comparison.                                          : Ok
 18: Compilable output and type filtering.                              : Ok
 19: Type containment and pointer search.                               : Ok
 20: Class name filtering.                                              : Ok
 21: Default BTF on a system without BTF.                               : Ok
 22: Display format options.                                            : Ok
 23: DWZ alternate debug file type resolution.                          : Ok
 24: Atomic typedef emission.                                           : Ok
 25: Enumerator search.                                                 : Ok
 26: Expand pointers option.                                            : Ok
 27: Type expansion and anonymous struct options.                       : Ok
 29: Validation of GCC optimized parameters in default BTF.             : Ok
 30: Validation of BTF encoding of true_signatures.                     : Skip (no optimizations applied.)
 31: Compare parallel vs merged CU loading for inter-CU type references.: Ok
 32: Version output.                                                    : Ok
 33: pdwtags DWARF tag display.                                         : Ok
 34: Check that pfunct can print btf_decl_tags read from BTF.           : Ok
 35: pfunct function statistics.                                        : Ok
 37: Sizes and holes display.                                           : Ok
 38: Sort output and separator.                                         : Ok
 39: Validation of BTF encoding of functions.                           : Ok
 36: Pretty printing of files using DWARF type information.             : Ok
 28: Flexible arrays accounting.                                        : Ok
  7: Split BTF encoding (vmlinux base + kernel module).                 : Ok
 40: Parallel reproducible DWARF Loading/Serial BTF encoding.           : Ok
Saved timing data to .test-times (40 tests)

⬢ [acme@toolbx pahole]$

Cheers,

- Arnaldo
