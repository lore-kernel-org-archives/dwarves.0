Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9E734C98C
	for <dwarves@vger.kernel.org>; Mon, 22 Jun 2026 20:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782159888; cv=none; b=ncGMQUTnwGOw833V7QYOaXBmRaSBsOt1i4WpwFD3Y9g7MJnOYYNx41ongRghOuDTVlOoyjq1hMRSvo/Q+b9f3wPXXK8Wll8OuWCnYL2ZiqF0FL7RJ4Sx8cX4MFKADqWc3pUZF3scvv8xLVTADnrBB//Yqkmexro0+1aGRkoXrXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782159888; c=relaxed/simple;
	bh=jA1vItOpnRFUfjN1tD7KkmZ2bPPzWh/zNNL2zBwP1Ks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lLo1J3xNGihXMublAKQY6fpKHCuibSucYDuYO3g9H6j0silTvoZVAFLhBj8bMQ7wn0Z0Eridj6J5CUQrqdnvkkLqWQkauhrpo3ab1a2DCogMDR+6M4dTu6AEP3sgYdQuObRY1FO6gwsJoBUlhW6/C0O8EeGomf5zjsei3VfZkqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9zSyqQN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9zSyqQN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC60C1F000E9;
	Mon, 22 Jun 2026 20:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782159887;
	bh=vYU0wsatrqSfPpjX9Y+ipd9WQb+X4K6Dq+rPD05HkVw=;
	h=From:To:Cc:Subject:Date;
	b=C9zSyqQNWmgwku9JMeEvKLUcfje4YylZgKs8xy82cK75z8VOPGFRAFt1+k5DovLQB
	 msEOuj0asNsZs1/vDWUClK9HnNTDlSl8natGV8fktwO+6caNRh/FoCc0DEqDGI3Y9j
	 Gjud6VC9Ij2fX3MEsICnH3mNMA2U5IQoa3K1cGTXjLF4W8mYwsHGVi/QSVI6fLPr8b
	 KGpXK3C8fhQHKzAJlNr/V/nZT2dCCzJXpsVPidJMGaLYCJJ973isvil9M+SMwuJhFc
	 IAO30kpbx/04oX8jNOAMWPig0xAn9lWsTDEylbQBSJC8NHJ83/pYz2jdFaIyFbKjUY
	 2BLJR9kjIjPdg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCHES v3 0/7] Initial support for some Rust tags, DW_TAG_imported_unit
Date: Mon, 22 Jun 2026 17:24:23 -0300
Message-ID: <20260622202441.14799-1-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

        Here is a series with some initial support for some Rust DWARF
tags and support for DW_TAG_imported_unit in the same file, which makes
pahole support lots more modern userspace DWARF files, including DWARF
for Rust object files.

        This makes one of the regression tests to pass again as perf now
has some rust source files and thus Rust CUs in a perf binary built with
DWARF, which is used to test pahole's pretty printing features, where it
uses the DWARF in a perf binary to decode perf.data records.

        The --features=force_cu_merging, now is not strictly needed, but
remains as it may be useful at some point.

	There is more work to be done to support references to a
separate file, that should come next.

- Arnaldo

Arnaldo Carvalho de Melo (16):
  dwarf_loader: Initial support for DW_TAG_variant_part
  dwarf_loader: Allow forcing the merge of CUs for solving inter CU tag references
  dwarf_loader: Initial support for DW_TAG_subprogram in DW_TAG_enumeration
  encoders: Fix diagnostic messages for unexpected tags in enumerations
  dwarves_fprintf: Accumulate function__fprintf return value in enumeration printing
  dwarves: Use tag__delete for enumeration children
  btf_encoder: Fix types__match parameter comparison in BTF_KIND_FUNC_PROTO
  encoders: Handle DW_TAG_subprogram in enumerations during BTF/CTF encoding
  dwarf_loader: Populate DW_TAG_variant children in DW_TAG_variant_part
  btf_encoder: Encode variant parts as union members in BTF
  dwarf_loader: Handle DW_FORM_block in attr_numeric for Rust discriminant values
  dwarf_loader: Support DW_TAG_imported_unit for same-file partial units
  dwarf_loader: Fix cus__merging_cu failing to detect DW_FORM_ref_addr
  tests: Add inter-CU type reference comparison test
  tests: Guard cleanup() against empty outdir to prevent rm /*
  tests: Source test_lib.sh via dirname so tests run from any directory

 btf_encoder.c                 |  68 ++++++--
 ctf_encoder.c                 |  23 ++-
 dwarf_loader.c                | 311 ++++++++++++++++++++++++++++++----
 dwarves.c                     |  77 ++++++++-
 dwarves.h                     |  43 ++++-
 dwarves_emit.c                |  10 +-
 dwarves_fprintf.c             |  54 ++++--
 man-pages/pahole.1            |  17 +-
 pahole.c                      |  20 ++-
 tests/btf_functions.sh        |   2 +-
 tests/btf_type_tag_order.sh   |   2 +-
 tests/default_vmlinux_btf.sh  |   2 +-
 tests/flexible_arrays.sh      |   2 +-
 tests/gcc_true_signatures.sh  |   2 +-
 tests/inter_cu_refs.sh        |  50 ++++++
 tests/pfunct-btf-decl-tags.sh |   2 +-
 tests/prettify_perf.data.sh   |   6 +-
 tests/reproducible_build.sh   |   2 +-
 tests/test_lib.sh             |   6 +-
 19 files changed, 604 insertions(+), 95 deletions(-)
 create mode 100755 tests/inter_cu_refs.sh

-- 
2.54.0

