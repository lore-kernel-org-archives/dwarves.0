Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F88536A377
	for <dwarves@vger.kernel.org>; Fri, 21 Aug 2026 21:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787348136; cv=none; b=XLXSnDgiylo7qMN0zYer7UVxAKrXj2MnXX/gz9z/cOcKajP3sBUpFRiaCjCHIEU1y4QDWiO8eL/Nyo6krLOh6AS39m8ZkGWSrnD9J9aWa3Jdje4/L85E8F4StTQttUl7YW+fjguFLrhxDNd61ajKyK7mafwbn97vgRuD43cMWmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787348136; c=relaxed/simple;
	bh=GnQL4hl49OJnu0G88V06xA3eUVEAnQVGDMDApwCpV2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Glzq72jqlWOFsDuGpmlytW5JvRssZDxj+qE54Sg40nS7Mtnz8H5bxHQuw9dT3crE6opuXGkbdNqAQnjaqzckbYETRy5ne/v+P2le9x8T44TkluBV26uFhIiZtNGsFoQmse1/iTGWET0wIdknxV4/KftjA4OEX5a54wsZfhq/4v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQxEfgeZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQxEfgeZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4D21F00A3A;
	Fri, 21 Aug 2026 21:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787348134;
	bh=qFTzWncBBTi+PIzfT/FqkgudSp45g8EDwoFj8QtuiIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eQxEfgeZ4DoDD/i5CP06Od/YIE0tGanLAYzwkRXwuXnm5WrVi7aavfULwJHcvPUj7
	 n8Zp1g/lLS4qMBzUXHn22Q86lK6HumsnQW4l7Cnq5rkxQ1llYmPQeDyG2Gy56VHZUh
	 W20Y0fywEWjllh+iMH/JBQzaStKzg9gNQuzlUBofL2xjNfxHnQXfzNw8uYI3jTSY18
	 t7m7zOw82ldl15IRU14s7pIMKXofRyRQp0peQA+KQ1C59X8VoNwIFMMVuCHGsInmV5
	 yIYeu8S9A8f3K8TAd67bHfCw6KRLR8kt/Asgc7HgiOMRi4ywXxb99qF+xL+4XGWb8b
	 eGCLOamF5ha+A==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v2 6/9] tests: Add inter-CU type reference comparison test
Date: Fri, 21 Aug 2026 18:35:05 -0300
Message-ID: <20260821213510.22423-7-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260821213510.22423-1-acme@kernel.org>
References: <20260821213510.22423-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When the perf binary includes Rust CUs, some DWARF types reference types
in other CUs via DW_FORM_ref_addr. The parallel loading path processes
each CU independently, so cross-CU references fail during
cu__recode_dwarf_types() and the types become unresolved (void).

The force_cu_merging feature worked around this by serializing loading
into a mega-CU, but disables parallel DIE processing. This test
compares both outputs to validate that cross-CU references are
correctly resolved without needing force_cu_merging.

Before the cus__merging_cu() fix earlier in this series, 314 cross-CU
references failed, producing 70
lines of output difference across 12 diff hunks:

  $ pahole -F dwarf ~/bin/perf 2>/dev/null > parallel.txt
  $ pahole --features=force_cu_merging -F dwarf ~/bin/perf 2>/dev/null > merged.txt
  $ diff parallel.txt merged.txt | grep '^[<>]' | wc -l
  70
  $ diff -u parallel.txt merged.txt | head -20
  --- parallel.txt
  +++ merged.txt
  @@ -10821,7 +10821,11 @@
   	usize                      __0 __attribute__((__aligned__(8)));
   	struct ThreadInfo          __1 __attribute__((__aligned__(8)));

  +	/* XXX last struct has 8 bytes of padding, 1 hole */
  +
   	/* size: 48, cachelines: 1, members: 2 */
  +	/* member types with holes: 1, total: 1 */
  +	/* paddings: 1, sum paddings: 8 */
   	/* forced alignments: 2 */
   	/* last cacheline: 48 bytes */
   } __attribute__((__aligned__(8)));

An earlier commit in this series fixed the detection of DW_FORM_ref_addr
in cus__merging_cu(), making this test pass.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tests/inter_cu_refs.sh | 50 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100755 tests/inter_cu_refs.sh

diff --git a/tests/inter_cu_refs.sh b/tests/inter_cu_refs.sh
new file mode 100755
index 0000000000000000..0df0ce13cd948f1f
--- /dev/null
+++ b/tests/inter_cu_refs.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright © 2026 Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+#
+# Compare default CU loading with explicit force_cu_merging for binaries
+# with inter-CU type references (e.g. Rust CUs in perf).
+#
+# When cus__merging_cu() correctly detects DW_FORM_ref_addr usage, it
+# automatically falls back to the merged CU path.  This test verifies
+# that the automatic detection produces the same output as explicitly
+# forcing CU merging.
+
+. "$(dirname "$0")/test_lib.sh"
+
+outdir=$(make_tmpdir)
+trap cleanup EXIT
+
+title_log "Compare parallel vs merged CU loading for inter-CU type references."
+
+perf=$(which perf 2>/dev/null)
+if [ -z "$perf" ] ; then
+	info_log "skip: No 'perf' binary available"
+	test_skip
+fi
+
+if ! pahole --features=force_cu_merging -F dwarf -C perf_event_header "$perf" 2>/dev/null | grep -q "^struct perf_event_header {" ; then
+	info_log "skip: $perf doesn't have 'struct perf_event_header' type info"
+	test_skip
+fi
+
+parallel_out=$outdir/parallel.txt
+merged_out=$outdir/merged.txt
+
+if ! pahole -F dwarf "$perf" > "$parallel_out" 2>/dev/null ; then
+	error_log "FAIL: pahole failed processing $perf (parallel mode)"
+	test_fail
+fi
+
+if ! pahole --features=force_cu_merging -F dwarf "$perf" > "$merged_out" 2>/dev/null ; then
+	error_log "FAIL: pahole failed processing $perf (merged mode)"
+	test_fail
+fi
+
+if diff -u "$parallel_out" "$merged_out" > /dev/null 2>&1 ; then
+	test_pass
+else
+	nr_diff=$(diff "$parallel_out" "$merged_out" | grep '^[<>]' | wc -l)
+	error_log "FAIL: $nr_diff lines differ between parallel and merged CU loading"
+	test_fail
+fi
-- 
2.55.0

