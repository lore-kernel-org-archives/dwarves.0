Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF28F34D4F9
	for <dwarves@vger.kernel.org>; Mon, 22 Jun 2026 20:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782159921; cv=none; b=Axn4UPhNEJmCCQHJ9s5klUfQbGUGxsb1+SGM0oEwEJFvU6VOHmip/rqBYSPsVWl/JWEG3RWdNJGUJXBWrGMW7VUb0sO5OVfqLBIKDQ1FAwUpZ2euQn04dY1kDRiT3njCvg+maMeu0PI6iTYfcU5MLLgJrfuDReWqYTLJQ64niVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782159921; c=relaxed/simple;
	bh=YcGuWCIkQwYygIr8VX51cTUe0NmuFtohGlTfpu76TQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rbzykx/z3BPFXPqg8y4frKCI7awI0B57MW66v6gh9d0wquFzd1POSQUxZ9TtQnz8WvqelX8yy9yfXCm/NIJ+P9BnNNTJJXbKFzlGGKxEkmy6jBwISo4Hi+tU5Af2qgb0/C/YTTN6i9bhiZ744pTJBTwZ9AkdpOsPuDmuDQPm8nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8wloIKj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8wloIKj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9E41F000E9;
	Mon, 22 Jun 2026 20:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782159920;
	bh=DWd9wJT9tg0bhnZK6NAynJi5KNBjhSw2Tzfr0Abb59c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D8wloIKjn1vUGcuPcMaFCwLLdPG/upyRjo92K2+6ysTmKzwxJskkP3lVi243H+d4a
	 YZzfrw0SqdFCuAjoLXhwEoNRLKKWQP7+e4BOHb7IfRPtBqUjMmdauIv5e8lEop+OOn
	 yGTkIoHwUMSmR9VzSvmoNAxKTPfDhxdueCxxQUrXulf+wc+IqBDMD/eurIAAjtoj7K
	 ZsBSKX1qg97p2JEOCB8+WlNkcd2iy4FYdN+UgwPm4ZyOIdnwMMB/kQm155czn9W4CH
	 Kt91eN959ozzu7gIaAt11+U3CNetkJcAWvYqbnHQPhBJ9Slln/zZZKA6njFKiyWqtX
	 sAzcBiO6IXemQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 14/16] tests: Add inter-CU type reference comparison test
Date: Mon, 22 Jun 2026 17:24:37 -0300
Message-ID: <20260622202441.14799-15-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622202441.14799-1-acme@kernel.org>
References: <20260622202441.14799-1-acme@kernel.org>
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

Before the preceding fix, 314 cross-CU references failed, producing 70
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

The preceding commit fixed the detection of DW_FORM_ref_addr in
cus__merging_cu(), making this test pass.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tests/inter_cu_refs.sh | 50 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100755 tests/inter_cu_refs.sh

diff --git a/tests/inter_cu_refs.sh b/tests/inter_cu_refs.sh
new file mode 100755
index 0000000000000000..6827bf83931eb3ed
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
+. ./test_lib.sh
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
2.54.0

