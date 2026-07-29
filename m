Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A877463B69;
	Wed, 29 Jul 2026 19:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352060; cv=none; b=hzuLnbSDLMrt0r+ijrNUmwptgR5NjWgSsrWjiumZUlxrn0FopbCj1cXZFEE8z6DVR5fnnXypF+zO4mi14cwWmfcxk7Xrc17bJ2eS290HdOtUHC0bVVlyfPqOVZU5zIHtXE5UykUea5lJ4uIyMaZv4UAEmAWYf3ctrsTsmCgx8D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352060; c=relaxed/simple;
	bh=nZeI7ZSVJMWW3Xv/pftBEi0wdcYlHA9Zw3RsPeD4jvE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jIfCTfnQwgBPpqEGKHNZTSc2vHYrco0aGvK4DXbkNJ3q0gjfHdeimzKzNmGGzLeuIHZjRVLSAHDsNHHy7ZbyW+uyeVddjk0DRZZI2BQ22mkX7i6wgfItn3rCrLgcciyIyde7Uo6PtzLqx9TEysIdQUd1t7jF3mpbnb7rWWrky7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMVN1F2M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMVN1F2M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E5C1F00A3E;
	Wed, 29 Jul 2026 19:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785352058;
	bh=kSCMik0STBUgSquTWt6u7pBAyLi78sXxAQwYVXMv5e8=;
	h=From:To:Cc:Subject:Date;
	b=EMVN1F2MwbnkHCtseK/toA5c5lT1nMGlM3fB5DDRYTIJjdjVzykd1/8iyHeOfOPTg
	 10r8rKnZ70R5T82ntEjscA0V2QkZ8jFJecg/RudPF5l65caMlCmf1y60nF+BbPJH+9
	 hZCTU1Qxd1hjkRgMBRRO1wSLt0bFIP3u15p5plFq4VJR6MyFy6fZZ0zWBi4Lp7tk52
	 ZdwBl+5RpkK34FXcYulIzzXVEfNMTs2Jta8xc9Ju/ryWVSp5HPlbimms4P93oAgr/f
	 lIRzU5IBM0Opf6yhC0ePQnSZ0NCxpRy4KQp+GWyselcJR+AIVhujbUa7bvnMBu7jOw
	 3NXlH2Nh7fx4w==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCHES 00/31] pahole: Bug fixes and small improvements
Date: Wed, 29 Jul 2026 16:07:00 -0300
Message-ID: <20260729190733.72876-1-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

	Here are 31 patches fixing pre-existing bugs found via coverage
analysis, AI-assisted review (sashiko), and manual testing. No new
features.

Critical kernel build path fix:
  Multi-dimensional arrays (e.g. int[2][3]) were incorrectly collapsed
  into flat arrays (int[6]) in BTF encoding. The encoder wrote only
  the total element count; the loader read only the first dimension.
  Both now preserve the full dimension chain using chained
  BTF_KIND_ARRAY nodes, matching bpftool and kernel verifier format.

  Before: pahole -F btf showed int a[3][4] as int a[12]
  After:  int a[2][3][4] encodes as three chained BTF_KIND_ARRAY nodes
          and round-trips correctly

Bug fixes found via coverage analysis:
  - Fix interior pointer free and missing NULL check in btf_encoder
  - Fix missing list head initialization in type__clone_members
  - Fix instance memory leak on 14 early returns in
    prototype__stdio_fprintf_value
  - Fix error path resource leaks in ctf_loader and libctf
  - Fix early cleanup crashes in btf_encoder__new/delete
  - Fix dangling stack pointer: allocate type_dcu via dwarf_cu__new
  - Fix annotation failure leaks in variable and typedef creation
  - Fix --errno typo that decrements instead of negating
  - Fix heap buffer overflow in languages__parse realloc
  - Fix parse_btf_features("all") being a silent no-op
  - Fix --fixup_silly_bitfields condition check
  - Fix data race in tag__init() decl_file string cache
  - Fix variable shadowing in __cus__find_struct_by_name
  - Fix phantom holes when class__find_holes ran before byte sizes
    were cached (eliminates 36 false "BRAIN FART ALERT" on Firefox)
  - Add elf_strptr NULL checks and fix kfunc bounds in btf_encoder
  - Use btf_encoder__tag_type() for all type ID computations

Other improvements:
  - Fix -Wsign-compare warnings across the codebase
  - cmake: Update minimum required version from 3.5 to 3.10
  - Skip inline expansions during BTF encoding (performance)
  - Use fseek for seekable files in --prettify and --seek_bytes
  - Guard pipe_seek() against negative offsets
  - Fall back to GNU objcopy when llvm-objcopy is not available
  - Add exec_objcopy() shell-injection-safe helper
  - Skip libdw__lock when elfutils >= 0.194 is built thread-safe
  - Replace stale FIXME/XXX comments with explanations
  - Remove 11 dead functions found via coverage analysis
  - Mark file-local functions as static

There are several other series that will result in way more coverage
and regression tests and will add support for more rust DWARF tags,
DWARF partial units that will allow us to build the kernel with most
of the CONFIG_DEBUG_ DWARF options (DWARF5, etc), only split DWARF
(skeletons) is left for after these series are applied.

The end result for tests/tests is this, that runs in parallel and mimics
the 'perf test' output:

⬢ [acme@toolbx pahole]$ ./build-and-test-cmd.sh
<SNIP>
Testing pahole version:
  v1.31-215-gcd4504f549af6fe7

Verbose mode enabled - showing diagnostic information:
  Architecture: x86_64
  CPUs: 32
  Memory: 60.4 GB
  Swap: 8.0 GB
  Parallelism: unlimited (all tests run in parallel)
    Tip: On low-memory systems, use -j to limit parallelism (e.g., -j 4 or -j 1)
  Test artifacts: /tmp/pahole-tests/
  Compiler: gcc (GCC) 16.1.1 20260515 (Red Hat 16.1.1-2)
  libc: ldd (GNU libc) 2.43
  bpftool: bpftool v7.6.0
  VMLINUX: not set
  PERF_BIN: not set
  PERF_SRC_DIR: not set

  1: dwarves_emit.c: _Atomic type compile emission.                     : Ok
  2: _Atomic type display and --skip_emitting_atomic_typedefs.          : Ok
  3: Auxiliary tools: pglobal, prefcnt, dtagnames.                      : Ok
  4: Bitfield layout and data member filtering.                         : Ok
  5: dwarf_loader coverage: bitfields, templates, enums, inlines.       : Ok
  6: Bitfield typedef recoding (tag__recode_dwarf_bitfield).            : Ok
  7: DW_FORM_block byte order conversion.                               : Skip
  8: BTF arena type tag encoding for kfuncs.                            : Ok
  9: BTF multi-dimensional array encoding and round-trip.               : Ok
 10: BTF bitfield encoding and loading round-trip.                      : Ok
 11: BTF VAR and DATASEC encoding for global variables.                 : Ok
 12: BTF deduplication of array types across CUs.                       : Ok
 13: Distilled base BTF generation.                                     : Skip
 14: BTF encoding options.                                              : Ok
 15: BTF encoder coverage.                                              : Ok
 16: BTF encoder comprehensive feature coverage.                        : Ok
 17: BTF_KIND_FWD encoding and loading round-trip.                      : Ok
 18: BTF encoding with invalid symbol names.                            : Ok
 21: BTF FLOAT and ENUM64 type encoding.                                : Ok
 22: Check BTF type tag order.                                          : Ok
 23: BTF encoder verbose logging coverage.                              : Ok
 24: BTF encoding into ELF via pahole -J (btf_encoder__write_elf).      : Ok
 25: BTF true_signature: clang optimized aggregate parameters (2 structs: Ok
 26: BTF true_signature: clang optimized aggregate parameters (2 structs: Ok
 27: BTF true_signature: clang optimized with large union parameter     : Ok
 28: BTF true_signature: clang optimized parameters (scalar)            : Ok
 29: BTF true_signature: clang optimized with stack parameters (9 params: Ok
 30: BTF true_signature: clang optimized with stack parameters (non-stat: Ok
 31: Class name list from file.                                         : Ok
 32: CLI display and filtering options.                                 : Ok
 33: codiff struct comparison.                                          : Ok
 34: codiff coverage: terse, functions, verbose, multi-CU.              : Ok
 35: codiff member change coverage.                                     : Ok
 36: codiff multi-CU: __cus__find_cu_by_name coverage.                  : Ok
 37: codiff --terse (-t) type change reporting.                         : Ok
 38: Compile emission pipeline.                                         : Ok
 39: Compilable output and type filtering.                              : Ok
 40: Recursive container search and verbose counts.                     : Ok
 41: Type containment and pointer search.                               : Ok
 42: C++ advanced DWARF tag coverage.                                   : Ok
 43: C++ cleanup: delete_tags coverage for lexblock, parameter packs.   : Ok
 44: C++ inheritance and namespace printing.                            : Ok
 45: C++ value parameter pack and shadow definition disambiguation.     : Ok
 46: C++ namespace and using-declaration display.                       : Ok
 47: C++ variadic template parameter pack handling.                     : Ok
 48: C++ template pretty printing round-trip.                           : Ok
 49: C++ template template parameter pretty printing round-trip.        : Ok
 51: Class name filtering.                                              : Ok
 52: Default BTF on a system without BTF.                               : Ok
 53: Display format options.                                            : Ok
 54: dwarf_loader.c edge cases: bitfield recode, inlining, call sites.  : Ok
 55: dwarves.c core API coverage.                                       : Ok
 56: DWZ alternate debug file type resolution.                          : Ok
 57: Legacy atomic_ base type emission via --compile (hand-crafted DWARF: Ok
 58: Atomic typedef emission.                                           : Ok
 59: dwarves_emit.c / dwarves_reorganize.c coverage.                    : Ok
 60: DW_TAG_atomic_type member handling via --compile.                  : Ok
 61: Type emission (--compile) and atomic typedefs.                     : Ok
 62: Enumerator search.                                                 : Ok
 63: Expand pointers option.                                            : Ok
 64: Type expansion and anonymous struct options.                       : Ok
 65: Flexible arrays accounting.                                        : Ok
 66: dwarves_fprintf.c coverage: fn-ptr members, labels, C++ types.     : Ok
 67: Validation of GCC optimized parameters in default BTF.             : Ok
 68: Validation of BTF encoding of true_signatures.                     : Skip (no optimizations applied.)
 69: Compare parallel vs merged CU loading for inter-CU type references.: Ok
 70: Multi-file loading (cus__load_files).                              : Ok
 71: Version output.                                                    : Ok
 72: Struct packing and reorganization.                                 : Ok
 73: pahole coverage: sort, word_size unions, prettify bitfields.       : Ok
 74: Format coverage: count, skip, structs, hex, contains, first_obj_onl: Ok
 75: Header, range and seek_bytes prettify paths.                       : Ok
 76: pahole.c scattered option paths.                                   : Ok
 77: pdwtags DWARF tag display.                                         : Ok
 78: Check that pfunct can print btf_decl_tags read from BTF.           : Ok
 79: pfunct --class and --expand_types.                                 : Ok
 80: pfunct coverage: symtab, class, expand_types, compile.             : Ok
 81: pfunct function statistics.                                        : Ok
 82: pglobal basic: variables, functions, static exclusion.             : Ok
 83: prefcnt.c: reference counting coverage.                            : Ok
 84: prettify_bitfield                                                  : Ok
 85: Pretty printing of files using DWARF type information.             : Ok
 86: Prototype expression parsing and prettify.                         : Ok
 87: Cacheline boundary display with large structs.                     : Ok
 88: Sizes and holes display.                                           : Ok
 89: Small files coverage: elf_symtab, gobuffer, dutil, pglobal.        : Ok
 90: Sort with multi-CU deduplication.                                  : Ok
 91: Sort output and separator.                                         : Ok
 92: Statistics and filtering options.                                  : Ok
 93: Typedef chain display.                                             : Ok
 94: Word size LP resizing.                                             : Ok
 95: Union word_size resize and packable hex.                           : Ok
 96: Validation of BTF encoding of functions.                           : Ok
 50: ctracer: struct method tracing generation.                         : Ok
 20: Split BTF encoding (vmlinux base + kernel module).                 : Ok
 19: BTF encoding with kernel vmlinux.                                  : Ok
 98: Parallel reproducible DWARF Loading/Serial BTF encoding.           : Ok
 97: BTF encoding on vmlinux.                                           : Ok
Saved timing data to .test-times (98 tests)

⬢ [acme@toolbx pahole]$

Cheers,

- Arnaldo

 CMakeLists.txt       |    2 +-
 btf_encoder.c        |  550 +++++++++++++------
 btf_loader.c         |   60 ++-
 btfdiff              |    1 -
 codiff.c             |    8 +-
 ctracer.c            |    2 +-
 ctf_encoder.c        |    2 +-
 ctf_loader.c         |   16 +-
 dutil.c              |   46 ++
 dutil.h              |    1 +
 dwarf_loader.c       |  122 ++--
 dwarves.c            |   95 +---
 dwarves.h            |   21 +-
 dwarves_emit.c       |    2 +-
 dwarves_fprintf.c    |   74 +--
 gobuffer.c           |   49 --
 gobuffer.h           |    5 -
 libctf.c             |   14 +-
 pahole.c             |   63 ++-
 pfunct.c             |   14 +-
 tests/btf_arrays.sh  |  158 ++++++
 21 files changed, 864 insertions(+), 441 deletions(-)

Arnaldo Carvalho de Melo (31):
  cmake: Update minimum required version from 3.5 to 3.10
  Fix -Wsign-compare warnings across the codebase
  btf_encoder: Fix interior pointer free and missing NULL check
  dwarves: Fix missing list head initialization in type__clone_members
  pahole: Fix instance memory leak on early returns in prototype__stdio_fprintf_value
  ctf_loader, libctf: Fix error path resource leaks
  dwarves: Don't search for holes before member byte sizes are cached
  dwarf_loader: Allocate type_dcu via dwarf_cu__new to fix dangling stack pointer
  dwarf_loader: Fix annotation failure leaks in variable and typedef creation
  btf_encoder: Use btf_encoder__tag_type() for all type ID computations
  pahole: Fix --errno typo that decrements instead of negating
  dwarves: Fix heap buffer overflow in languages__parse realloc
  btf_encoder: Fix early cleanup crashes in btf_encoder__new/delete
  btf_encoder, libctf: Add elf_strptr NULL checks and fix kfunc bounds
  dwarf_loader: Fix --fixup_silly_bitfields condition check
  dwarf_loader: Skip libdw__lock when elfutils is built thread-safe
  dwarf_loader: Fix data race in tag__init() decl_file string cache
  pahole: Fix parse_btf_features("all") being a silent no-op
  dwarves: Fix variable shadowing in __cus__find_struct_by_name()
  dutil: Add exec_objcopy() shell-injection-safe helper
  btf_encoder: Fall back to objcopy when llvm-objcopy is not available
  dwarf_loader, btf_loader: Replace stale FIXME/XXX comments with explanations
  pahole: Skip inline expansions during BTF encoding
  pahole: Use fseek for seekable files in --prettify and --seek_bytes
  pahole: Guard pipe_seek() against negative offsets
  gobuffer: Remove 5 dead functions found via coverage analysis
  dwarves: Remove 6 dead functions found via coverage analysis
  pfunct, dwarves_fprintf: Mark file-local functions as static
  btf_encoder: Fix multi-dimensional array encoding
  btf_loader: Fix multi-dimensional array loading
  btfdiff: Remove --flat_arrays now that pahole encodes multi dim arrays
    in  BTF

 CMakeLists.txt       |   2 +-
 btf_encoder.c        | 406 +++++++++++++++++++++++++++++++++++--------
 btf_loader.c         |  53 ++++--
 btfdiff              |   1 -
 codiff.c             |   3 +
 ctf_loader.c         |   8 +-
 ctracer.c            |   1 +
 dutil.c              |  72 ++++++++
 dutil.h              |   3 +
 dwarf_loader.c       | 157 ++++++++++-------
 dwarves.c            | 111 ++----------
 dwarves.h            |  13 --
 dwarves_fprintf.c    |   5 +-
 dwarves_reorganize.c |   6 +-
 gobuffer.c           |  74 --------
 gobuffer.h           |   8 -
 libctf.c             |  10 +-
 pahole.c             | 177 +++++++++++++------
 pfunct.c             |   4 +-
 tests/btf_arrays.sh  | 158 +++++++++++++++++
 20 files changed, 861 insertions(+), 411 deletions(-)
 create mode 100755 tests/btf_arrays.sh

-- 
2.55.0

