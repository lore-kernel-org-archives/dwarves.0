Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3215239EF1C
	for <dwarves@vger.kernel.org>; Fri, 21 Aug 2026 21:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787348122; cv=none; b=BMtYXjaJv1CklEIxO8//8iCmIfdsZEpVLVx9iCSJdtqQwbIuMI3J3ykmEMpKeT72VHOinD8tgkbmfRSfYzsp+w4paga3W1YMoiUUCSrjb+xSc6h4rCiPEe/d4KtFSxu/5+UEFKlcRZVZpAwQr5yv2T66gYPlJ45HYaYtknbpjfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787348122; c=relaxed/simple;
	bh=KfAGxlXJJF9wQz8jF0SYCVcrk5hW7xb58NDDYMzVezU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G+y0tv2zIic8mIXlLQUcU9AE7IAnZFJvXtOWf/WrGuxqpBVDLlM5B5asl2fnGiMCK4qkZwEta2nK7XGR52f9p8n5dp1/J91J/B5Begye84+SWK0GZNrngQXe+phIH5h/akFsgZIWHOfJgEKTGN55ZJVWheOk4sjcxzsc97QLX4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxkHHWfj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxkHHWfj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F481F00A3F;
	Fri, 21 Aug 2026 21:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787348120;
	bh=W/ZYoe2EeUyEZy7nPpyeUcbt8h2gSaCbTS7vTJyNbsg=;
	h=From:To:Cc:Subject:Date;
	b=QxkHHWfjcRz820b55J4EXoTXNb8FnwPYxGsW/XbMmyaYqV1a4KifLMrsegFDlVEWv
	 kfKxQqFVfu7Halc2G1T98Xhe1hl0+TMfuJTIekYb9HVvbMpCve2Mif8MUqb3RSjgxf
	 uK7ogXxCe5z1k/mI8LeqwmEq0PQ2AdKTp1XHaSfKtus/cjRxGLjfrzhKdWY/5YH3tJ
	 6a7sCiUh1a80eYNanjVAcZh3R5iOEZnBugqi9zKwXxtJwp0GI6V9jlmpzfbcR2G6mV
	 exPKTJQuy5KoxfpT/fpoDV5NnyzXQ/cAoH8nAybga9yoKi48d3/HacKekiuu9ViinF
	 EGILxoVkFAIEA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v2 0/9] pahole: Support cross-CU type references and dwz alternate debug files
Date: Fri, 21 Aug 2026 18:34:59 -0300
Message-ID: <20260821213510.22423-1-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Add support for cross-CU type references and dwz alternate debug
files so pahole can process binaries (e.g. a perf binary with rust
objects, or Firefox) that use DW_FORM_ref_addr inter-CU references or
dwz-compressed .dwz alternate debug files.

Cross-CU type references:

  Force-merge CUs that contain inter-CU references (DW_FORM_ref_addr)
  so type lookups resolve correctly.  Handle same-file partial units
  where types are shared across CUs via DW_TAG_imported_unit.  Fix
  cus__merging_cu failing to detect DW_FORM_ref_addr when
  DW_FORM_implicit_const causes dwarf_getabbrevattr() to fail.

dwz alternate debug file support:

  Handle DW_FORM_GNU_ref_alt references to dwz-compressed alternate
  debug files (.dwz).  Pre-processes all alternate partial units with
  separate hash tables and dedup tracking.

  Before (Firefox): 1774 "has no entry in cu" errors
  After:             processes cleanly with 0 errors

Also add an inter-CU type reference comparison test and
scripts/vmlinux_comparison.py for DWARF/BTF analysis across kernel
configs.

What changed from v1:

  v1 (12 patches) also carried the Rust enum discriminant support
  (DW_TAG_variant_part population, BTF union-member encoding and
  DW_FORM_block discriminant handling, plus tests/block_endian.sh).
  That work is being submitted as a separate series based on this one,
  so v2 drops those 3 patches and the block_endian.sh test.  The
  remaining 9 patches are the cross-CU reference and dwz alternate
  debug file support, now self-contained (tests/dwz_alt_file.sh and
  tests/inter_cu_refs.sh are included).

Best regards,

- Arnaldo

Assisted-by: opencode:hy3-free

Arnaldo Carvalho de Melo (9):
  dwarf_loader: Initial support for DW_TAG_variant_part
  dwarf_loader: Initial support for DW_TAG_subprogram in
    DW_TAG_enumeration
  dwarf_loader: Allow forcing the merge of CUs for solving inter CU tag
    references
  dwarf_loader: Support DW_TAG_imported_unit for same-file partial units
  dwarf_loader: Fix cus__merging_cu failing to detect DW_FORM_ref_addr
  tests: Add inter-CU type reference comparison test
  dwarf_loader: Add cu parameter to tag__set_spec() and
    dwarf_tag__set_attr_type()
  dwarf_loader: Support DW_FORM_GNU_ref_alt references to dwz alternate
    debug files
  scripts: Add vmlinux_comparison.py for DWARF/BTF analysis

 btf_encoder.c                 |  22 +-
 ctf_encoder.c                 |  26 +-
 dwarf_loader.c                | 829 ++++++++++++++++++++++++++++++----
 dwarves.c                     |  44 +-
 dwarves.h                     |  20 +-
 dwarves_emit.c                |  10 +-
 dwarves_fprintf.c             |  54 ++-
 man-pages/pahole.1            |  19 +-
 pahole.c                      |  28 +-
 scripts/vmlinux_comparison.py | 612 +++++++++++++++++++++++++
 tests/dwz_alt_file.sh         | 204 +++++++++
 tests/inter_cu_refs.sh        |  50 ++
 tests/prettify_perf.data.sh   |   4 +-
 13 files changed, 1801 insertions(+), 121 deletions(-)
 create mode 100755 scripts/vmlinux_comparison.py
 create mode 100755 tests/dwz_alt_file.sh
 create mode 100755 tests/inter_cu_refs.sh

-- 
2.55.0

