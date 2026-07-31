Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC2E30E828;
	Fri, 31 Jul 2026 19:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785526270; cv=none; b=HKVm5LkRWBbVFF2kDNRIQNMnNCYA7yphu/lB807ZGyHCWdXHVa3cRWyJUcHW8QPEEaMjWc1MGiIHynmFILFwRg2fz1sAJ2NWskAbMwZ35JfOslVVwMQ5nGNvkKOn2y3vRFrUaR9zzXC+lhdO2DDXzAp/VluK8cumndPel0oRWVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785526270; c=relaxed/simple;
	bh=Dc7jPJAk64RxNM/7y+bu/S155812HcJ3njKa5UlP0Pg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RJPGr5raiKVnD97njcoB+EAV8SgdcETls7ROhogQoTQ/g9JycpgNCnRyFODRbEKWcqJQtLZRp6e9C/nlOEuH79WxdLt23y/VNtM7MFWZ7qhr1RLfbUXuak8kRl0stInxksCeZe28OGiGCa9eZfz0QDiBTlmQ74FxDoDF3CiBAS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F54A4otb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F54A4otb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7070A1F00ACA;
	Fri, 31 Jul 2026 19:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785526268;
	bh=hOWWK484LjgnipuNokg+evFEZ4SCjh/DsjNI6Uzrl/k=;
	h=From:To:Cc:Subject:Date;
	b=F54A4otb/m/U+KO4fBucJwty06n5jBCbEjHXgcDAnVLsq6tPcXvBb9ELro4JuaU1n
	 4ftAv2HMOb5hNzxoPEelAntaGnpOXYIJVhz/QAyKEW/oamQBH/feaxSAnggb/dnVZW
	 eWKaVYhkYEIO1LqermMIZV3uC1uol/DqGllrH1McM2nGmkSED8abyjyAy/4Qop/WMI
	 PE7WihRzF3TPWXaSOr+GjOW6zB1bogkH1uW5xsuEFD/qFuWgoB2zTc9EpFFhu2DK9k
	 JqzDtxX7JbcEkGEOl3zA/7rFj+yNF+5rTyvwpsDjqiIQos1OcWwEbq0MoXH93ApXC1
	 eDgtziNGBA7hg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Mark Wieelard <mjw@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCHES 00/12] pahole: Support more rust tags and references to dwz alternate debug files
Date: Fri, 31 Jul 2026 16:30:48 -0300
Message-ID: <20260731193102.110693-1-acme@kernel.org>
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

Add support for Rust discriminated unions (enums with explicit
discriminants).

Rust enums like Option<u32> and Result<i32,u8> are represented in DWARF
as DW_TAG_variant_part containing DW_TAG_variant children with
discriminant values. These patches:

  - Load DW_TAG_variant_part containers with discriminant tracking
  - Populate DW_TAG_variant children with discriminant values
  - Handle DW_FORM_block encoding for discriminant values
  - Handle DW_TAG_subprogram inside DW_TAG_enumeration (Rust methods)
  - Encode variant parts as BTF_KIND_UNION members

Before: Rust Option<u32> showed as empty struct (0 members)

After:  Shows None and Some variants with correct layout

  === pahole --expand_types output ===
  struct Option<u32> {
      struct None {
      } __attribute__((__aligned__(4)));
      struct Some {
          /* XXX 4 bytes hole, try to pack */
          u32  __0 __attribute__((__aligned__(4)));  /*  4  4 */
      } __attribute__((__aligned__(4)));
  } __attribute__((__aligned__(4)));

BTF has no discriminated-union kind, so variant parts are tentatively
encoded as BTF_KIND_UNION with overlapping members at offset 0. Further
discussion is needed to see if we can keep that.

DW_FORM_block byte order fix: uses CU-recorded endianness instead of
assuming little-endian when decoding DW_AT_const_value and
DW_AT_default_value. Fixes cross-endian DWARF processing (e.g.  reading
big-endian s390x debug info on x86).

Also add support for cross-CU type references and dwz alternate debug
files.

This is needed to improve the support for, among other things, Rust, as
noticed in the pretty printing or a perf binary that has rust objects
linked, built by clang/llvm that use cross-CU references.

DW_TAG_imported_unit support:

  Handle same-file partial units where types are shared across CUs
  via DW_TAG_imported_unit. Force-merge CUs that contain inter-CU
  references (DW_FORM_ref_addr) so type lookups resolve correctly.

  Fix cus__merging_cu failing to detect DW_FORM_ref_addr when
  DW_FORM_implicit_const causes dwarf_getabbrevattr() to fail.

dwz alternate debug file support:

  Handle DW_FORM_GNU_ref_alt references to dwz-compressed alternate
  debug files (.dwz). Pre-processes all alternate partial units with
  separate hash tables and dedup tracking.

  Before (Firefox): 1774 "has no entry in cu" errors
  After:  processes cleanly with 0 errors

  Firefox uses dwz compression which moves common types into a
  separate .dwz file and replaces duplicates with DW_FORM_GNU_ref_alt
  references. pahole now pre-loads the alternate file's partial units,
  resolves all cross-file references, and processes Firefox DWARF
  cleanly.

Includes inter-CU type reference comparison test and
vmlinux_comparison.py for DWARF/BTF analysis across kernel configs.

Known limitations:
  - Pruning of unreferenced alt PUs is conservatively over-approximated
  - Merged-CU path is single-threaded by design

This makes pahole to be able to support more of the CONFIG_DEBUG_ DWARF
options, including DWARF5 and compression, see the latest patch in the
series for more details about how this table is produced:

  ┌───────────────────────────┬─────────┬─────┬───────────────────────────────────┬─────────┬───────┬──────────┬────────┬──────────┬─────────┐
  │ File                      │  Size   │ Ver │ Producer                          │  DWARF  │  BTF  │ DW-Hash  │ DW-Out │ BTF-Hash │ BTF-Out │
  ├───────────────────────────┼─────────┼─────┼───────────────────────────────────┼─────────┼───────┼──────────┼────────┼──────────┼─────────┤
  │ vmlinux.dwarf4            │ 835.7MB │   4 │ GNU C11 16.1.1 -gdwarf-4          │ 599.2MB │ 7.3MB │ 86e1b611 │  7.6MB │ 52123c24 │   7.4MB │
  │ vmlinux.dwarf5            │ 736.3MB │   5 │ GNU C11 16.1.1 -gdwarf-5          │ 499.7MB │ 7.3MB │ 86e1b611 │  7.6MB │ 52123c24 │   7.4MB │
  │ vmlinux.dwarf5.zlib       │ 497.8MB │   5 │ GNU C11 16.1.1 -gdwarf-5 -gz=zlib │ 261.2MB │ 7.3MB │ 86e1b611 │  7.6MB │ 52123c24 │   7.4MB │
  │ vmlinux.dwarf5.zstd       │ 454.7MB │   5 │ GNU C11 16.1.1 -gdwarf-5 -gz=zstd │ 218.1MB │ 7.3MB │ 86e1b611 │  7.6MB │ 52123c24 │   7.4MB │
  │ vmlinux.toolchain_default │ 736.3MB │   5 │ GNU C11 16.1.1                    │ 499.7MB │ 7.3MB │ 86e1b611 │  7.6MB │ 52123c24 │   7.4MB │
  └───────────────────────────┴─────────┴─────┴───────────────────────────────────┴─────────┴───────┴──────────┴────────┴──────────┴─────────┘

Split DWARF support (skeleton CUs) will be supported in upcoming work,
so as to cover all the possibilities the kernel build system offers
for generating DWARF.

- Arnaldo

Arnaldo Carvalho de Melo (12):
  dwarf_loader: Initial support for DW_TAG_variant_part
  dwarf_loader: Initial support for DW_TAG_subprogram in DW_TAG_enumeration
  dwarf_loader: Populate DW_TAG_variant children in DW_TAG_variant_part
  btf_encoder: Encode variant parts as union members in BTF
  dwarf_loader: Handle DW_FORM_block in attr_numeric for Rust discriminant values
  dwarf_loader: Allow forcing the merge of CUs for solving inter CU tag references
  dwarf_loader: Support DW_TAG_imported_unit for same-file partial units
  dwarf_loader: Fix cus__merging_cu failing to detect DW_FORM_ref_addr
  dwarf_loader: Add cu parameter to tag__set_spec() and dwarf_tag__set_attr_type()
  dwarf_loader: Support DW_FORM_GNU_ref_alt references to dwz alternate debug files
  tests: Add inter-CU type reference comparison test
  scripts: Add vmlinux_comparison.py for DWARF/BTF analysis

 btf_encoder.c                 |  66 ++-
 ctf_encoder.c                 |  34 +-
 dwarf_loader.c                | 873 ++++++++++++++++++++++++++++++----
 dwarves.c                     |  77 ++-
 dwarves.h                     |  63 ++-
 dwarves_emit.c                |  10 +-
 dwarves_fprintf.c             |  54 ++-
 man-pages/pahole.1            |  18 +-
 pahole.c                      |  20 +-
 scripts/vmlinux_comparison.py | 367 ++++++++++++++
 tests/block_endian.sh         | 146 ++++++
 tests/dwz_alt_file.sh         | 204 ++++++++
 tests/inter_cu_refs.sh        |  50 ++
 tests/prettify_perf.data.sh   |   4 +-
 14 files changed, 1854 insertions(+), 132 deletions(-)
 create mode 100755 scripts/vmlinux_comparison.py
 create mode 100755 tests/block_endian.sh
 create mode 100755 tests/dwz_alt_file.sh
 create mode 100755 tests/inter_cu_refs.sh

-- 
2.55.0

