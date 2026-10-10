Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9478282F0A
	for <dwarves@vger.kernel.org>; Sat, 10 Oct 2026 00:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791593556; cv=none; b=D3tk9spFom59bI+8Y/Qqn0cv19p9YHHXP5d1w6Yh02Mb6epf3Q6gajsx9LortCCzE6ItSN2/grpNQniQO63oYhAX9ZfXhXNH9IIAW8y7mjb4OgXiYTG4lW1ui4fzSYCqKfW0CjfyNiaDCcOnHEBz9tPw6BsrnY22j4C2KYIeqJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791593556; c=relaxed/simple;
	bh=Jsp6LgbTK4cfWWmLeUTZqtKixJIB0Y9Ie/1lUZvCJv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WZMzYbQQsIIFhZDV8dDl12GO1RG9GlRXV4gEX/V+rpN7gLxzoKvVIt6AV/FODnBbbb9lpetwj9JGDEBgGf0haRrvnQeJi5ONcUbi+FE/aHR7hrL1SPjYnnNkpBtTmjlQnIIDDv3JqauHpsEC6kjVFtNe2FBayDhpYAIri9tUWzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alanderk.com; spf=pass smtp.mailfrom=alanderk.com; dkim=pass (2048-bit key) header.d=alanderk.com header.i=@alanderk.com header.b=q+WFkCR9; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alanderk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alanderk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alanderk.com header.i=@alanderk.com header.b="q+WFkCR9"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e8246b13cbso2245955ad.2
        for <dwarves@vger.kernel.org>; Fri, 09 Oct 2026 17:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=alanderk.com; s=googol; t=1791593554; x=1792198354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=azgHsYvqsrDkaxXDY0hb9Qx2rxZr9Q0YSKH5ea/vOcw=;
        b=q+WFkCR9Q0N3SfJ53hzM7L+p3nfAcMOQPyfhfsk60XS60HzxgTOS6MHnPOTSvSA4T+
         ot3wHcMyQ9PQdDhu4y7jnoGGObzqmL6UNeFvPA48n8Gvh0Lk71usvpqdJAy5foOsBkV2
         c4occv7lwExxyM5fAgmLK9JA0RIKzZujwhGBOBRSv/f33k+hRHoZdjBS0p/Re7Cljgc4
         Go38huxnrFMtBu93hJAENaxQvORRbBfjEK3qekPwYNAglfgEw/FsEgZ2ifYmeA9u8Ues
         KAlj8yI1xLWnf6esUmLlFnEgdqHgW/a6dcF217DbuCa+6JqUadL41hmd35OjWOUiZcmV
         vNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791593554; x=1792198354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=azgHsYvqsrDkaxXDY0hb9Qx2rxZr9Q0YSKH5ea/vOcw=;
        b=15Q4wc6raeSBwWrz/K6/Xod1XQBriBQSSdYfylXjvIIJ7BmAZbO5LYTMK5w7rWjyTg
         O9OHXO9CCBGswxwqe2oE6EAfDELX65TmuDUW8CmRycOm8MGDCVinPkn4TwdpT9/HavFk
         nXEXi4vE51y2B6Jv7Zq9qQ2I0ljY+H0aofOF3SGCBKC8FamqxHFjLExfG1hOQVW5R01V
         CF5YBOeU9UMCR0Qv1vrKV+CCtudYS4hJSy6hyvBQ9fChW08SPxIzGTNlra+sK1l2UboI
         +TwgziE4OnTXUJVO5mjb9Vt4o+x5VdPfi+qWqxUPrzxH7+P9y+Ml0qxXUKpB01DTqXlN
         HmXQ==
X-Gm-Message-State: AFq9FYLoRUsLiNKTHw4W+9BofVSihS+sq69D6aXKkG0IV/xywTTxrYMK
	/qR7pNhbmbIzzpDkj3wYRSrQJHqDu3uG+Q4JcH1+UAe7and3iib52iaiae6df2SbfFY=
X-Gm-Gg: AYBFou08tyYGeK4jp3JTOBHAOq5QQLbixrFj9UolonelVQ+MGBMlf9c8JlKALUH3OWN
	09XPVJXVAvKc0d7fL/gZFFxWVQ5dhV3hiZqovoiEeKOfTlUxAEnGakVleEXv9srK8DXZb7d5F9j
	BUjzwOliTawXjODNhti4IVUKoiCzHg+ZYLy1nf+CkU3eV+evjZVNGq+d80J480wJWaSS+hVxiUC
	SLPxi38eqkhRkOf+ryj9JqkoFVU0UZkZfmg4Dg+u95zIFBk9s++TKElig0PA5Z0CWIYLmuVPW1E
	RNCNU1+WAsUKR0Z5jiUO/8NjI9+AIr3kfXGLHugeoUroOD1PA0uFZ3q2lbh7alDfcupZFp3by4Q
	31zFq3+xjmzUktAgW1uJdiNCicc5yYf1naN/CoQG4SdF6ucPCzqe2urEctcFqXK+dqxELZ8DPn3
	g+ibKRHoLUtyiYkMi4KE2rNWY5DgISQbxCZMQtQcslUY9kBML25CZH5Z36YT/ArT4klS7SWEh8N
	b5eYheoa809zICGjBwi8sVLEu95XT61RQ==
X-Received: by 2002:a17:90a:e7ca:b0:3a4:f75d:d194 with SMTP id 98e67ed59e1d1-3ab3a8ce801mr3278439a91.36.1791593554040;
        Fri, 09 Oct 2026 17:52:34 -0700 (PDT)
Received: from macmini4.tapir-palermo.ts.net ([138.199.43.94])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab50ce9d98sm4078226a91.9.2026.10.09.17.52.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 09 Oct 2026 17:52:33 -0700 (PDT)
From: Alan Derk <linux@alanderk.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>
Cc: dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH dwarves v2 1/2] dwarf_loader: Take the merged CU language from a CU that is kept
Date: Sat, 10 Oct 2026 00:52:26 +0000
Message-ID: <20261010005227.976-2-linux@alanderk.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261010005227.976-1-linux@alanderk.com>
References: <20261010005227.976-1-linux@alanderk.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the CUs of an object are merged, as for clang LTO objects, the
merged CU takes the language of the first CU. Since commit
b98565e7b17ec24d ("dwarf_loader: Honour --lang_exclude when merging LTO
built CUs") the DIEs of excluded CUs are skipped while merging, but
pahole_stealer() then applies the same filter to the merged CU. If the
first CU is in an excluded language, the whole merged CU is dropped,
including the CUs that were kept, and with -J pahole writes no BTF and
still exits 0.

Kernel modules mixing Rust and C hit this in clang LTO builds with
CONFIG_DEBUG_INFO_BTF_MODULES: kbuild passes --lang_exclude=rust, and
the Rust CU comes first in the linked module even when the Rust object
is listed last, as the C objects are bitcode compiled at link time.
scripts/gen-btf.sh then fails, here for a Rust sample module:

  FAILED: load BTF from samples/rust/rust_minimal.ko.BTF.1: No such file or directory

This is what is left of the problem behind kernel commit 5daa0c35a1f0
("rust: Disallow BTF generation with Rust + LTO"), which keeps RUST off
when LTO and BTF are both on. With pahole 1.32 a ThinLTO vmlinux with
Rust built in gets clean BTF, but its Rust modules fail as above, so
that restriction can't be relaxed yet. Distributions with LTO kernels,
such as CachyOS's default kernel, keep BTF for sched_ext and BPF tools
and go without Rust; out-of-tree modules that build their own Rust
objects there hit this today.

Take the merged CU's language from the first CU the filter keeps, and
its producer too, as producer_clang also steers how the merged DIEs are
processed. Run the filter before checking for DIEs, as the unmerged
path does, so that a first CU without DIEs, such as an assembler CU,
still counts and the output without --lang_exclude does not change. If
every CU is filtered out, the merged CU keeps the first CU's language
and is dropped as before.

Before, with a C++ object linked before a C one:

  $ pahole -V --btf_features=force_cu_merging --lang_exclude=c++14 merged.o
  Filtering CU first.cpp written in c++14.
  Filtering CU  written in c++14.

After:

  $ pahole -V --btf_features=force_cu_merging --lang_exclude=c++14 merged.o
  Filtering CU first.cpp written in c++14.
  struct c_only {
  	int                        b;                    /*     0     4 */
  ...

Add tests/lang_exclude_merged_cu.sh for this.

Tested with clang 21 builds of 7.2.9 with RUST enabled: x86_64 with
ThinLTO (DWARF 4 and 5), full LTO and distributed ThinLTO, and arm64
and riscv64 with ThinLTO. The Rust sample modules get BTF and load with
MODULE_ALLOW_BTF_MISMATCH=n, and the BTF of vmlinux and of the C
modules does not change.

Fixes: b98565e7b17ec24d ("dwarf_loader: Honour --lang_exclude when merging LTO built CUs")
Assisted-by: LLM
Signed-off-by: Alan Derk <linux@alanderk.com>
---
Part of the dwarf_loader.c diff is re-indentation; git show -w is easier
to read.

 dwarf_loader.c                  | 34 +++++++++++------
 tests/lang_exclude_merged_cu.sh | 67 +++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+), 12 deletions(-)
 create mode 100755 tests/lang_exclude_merged_cu.sh

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 01049e9..fbed36e 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -5329,6 +5329,7 @@ static int cus__merge_and_process_cu(struct cus *cus, struct conf_load *conf,
 	struct dwarf_cu *dcu = NULL;
 	Dwarf_Off off = 0, noff;
 	struct cu *cu = NULL;
+	bool kept_cu = false;
 	size_t cuhl;
 
 	while (dwarf_nextcu(dw, off, &noff, &cuhl, NULL, &pointer_size,
@@ -5441,23 +5442,32 @@ static int cus__merge_and_process_cu(struct cus *cus, struct conf_load *conf,
 			cus__add(cus, cu);
 		}
 
-		Dwarf_Die child;
-		if (dwarf_child(cu_die, &child) == 0) {
-			bool filtered = false;
+		bool filtered = false;
 
-			if (conf->early_cu_filter) {
-				struct cu unmerged_cu = {
-					.name	  = attr_string(cu_die, DW_AT_name, conf),
-					.language = attr_numeric(cu_die, DW_AT_language),
-				};
+		if (conf->early_cu_filter) {
+			struct cu unmerged_cu = {
+				.name	  = attr_string(cu_die, DW_AT_name, conf),
+				.language = attr_numeric(cu_die, DW_AT_language),
+			};
 
-				filtered = conf->early_cu_filter(&unmerged_cu) == NULL;
-			}
+			filtered = conf->early_cu_filter(&unmerged_cu) == NULL;
+		}
 
-			if (!filtered && die__process_unit(&child, cu, conf, 0) != 0)
-				goto out_abort;
+		/*
+		 * pahole filters the merged CU by language again, so it must
+		 * not keep the language of a CU filtered out here.
+		 */
+		if (!filtered && !kept_cu) {
+			cu->language = attr_numeric(cu_die, DW_AT_language);
+			cu->producer_clang = attr_producer_clang(cu_die);
+			kept_cu = true;
 		}
 
+		Dwarf_Die child;
+		if (!filtered && dwarf_child(cu_die, &child) == 0 &&
+		    die__process_unit(&child, cu, conf, 0) != 0)
+			goto out_abort;
+
 		off = noff;
 	}
 
diff --git a/tests/lang_exclude_merged_cu.sh b/tests/lang_exclude_merged_cu.sh
new file mode 100755
index 0000000..507c6ac
--- /dev/null
+++ b/tests/lang_exclude_merged_cu.sh
@@ -0,0 +1,67 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Test --lang_exclude when CUs are merged, as for LTO objects: excluding the
+# language of the first CU must not drop the CUs that follow it.
+
+. "$(dirname "$0")/test_lib.sh"
+outdir=$(make_tmpdir)
+
+trap cleanup EXIT
+
+title_log "Language filtering of merged CUs."
+
+CC=${CC:-gcc}
+CXX=${CXX:-g++}
+LD=${LD:-ld}
+for tool in "$CC" "$CXX" "$LD"; do
+	if ! command -v "${tool%% *}" > /dev/null 2>&1; then
+		info_log "skip: $tool not available"
+		test_skip
+	fi
+done
+
+cat > "$outdir/first.cpp" << 'EOF'
+struct cpp_only {
+	int	a;
+};
+
+struct cpp_only cpp_var;
+EOF
+
+cat > "$outdir/second.c" << 'EOF'
+struct c_only {
+	int	b;
+};
+
+struct c_only c_var;
+EOF
+
+obj="$outdir/merged.o"
+
+if ! $CXX -g -c -o "$outdir/first.o" "$outdir/first.cpp" 2>/dev/null ||
+   ! $CC -g -c -o "$outdir/second.o" "$outdir/second.c" 2>/dev/null ||
+   ! $LD -r -o "$obj" "$outdir/first.o" "$outdir/second.o" 2>/dev/null; then
+	error_log "FAIL: compilation failed"
+	test_fail
+fi
+
+output=$(pahole --btf_features=force_cu_merging -F dwarf "$obj" 2>/dev/null)
+if ! echo "$output" | grep -q "struct cpp_only" ||
+   ! echo "$output" | grep -q "struct c_only"; then
+	error_log "FAIL: merged CU lacks types without --lang_exclude"
+	test_fail
+fi
+
+output=$(pahole --btf_features=force_cu_merging -F dwarf \
+	--lang_exclude=c++,c++03,c++11,c++14 "$obj" 2>/dev/null)
+if echo "$output" | grep -q "struct cpp_only"; then
+	error_log "FAIL: --lang_exclude=c++ kept the C++ CU"
+	test_fail
+fi
+if ! echo "$output" | grep -q "struct c_only"; then
+	error_log "FAIL: --lang_exclude=c++ dropped the C CU merged after it"
+	test_fail
+fi
+
+test_pass
-- 
2.55.0

