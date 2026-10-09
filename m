Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED08481641
	for <dwarves@vger.kernel.org>; Fri,  9 Oct 2026 20:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791576641; cv=none; b=k/8Mms6wh+nKwvTAKZ/yDac9WbsLpyp+BMMmvSnbjTy4WxItX3NFfJvnCs7EJrUh+UWVVtmzTlROKLl7HoA0VEVP9FEtR3RXt0vAjA2WO+SSvjtAGzDTchpGgCLZGDKJhGcjuTf+ieE8oTQHLRK1oHzjko1DBLHrUqpwBe4y3t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791576641; c=relaxed/simple;
	bh=6uwUDgUGBBegNNw8gBHz6CI975iD/iZ8aoY/QjONSyw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oY/1t+yidwAxESUTCbhNScpguMnhYoOBjZdzNu5h3R5UjI7ClhNrbTwKCNSI5uSDYle7qEPlypEsuV19YNgW3woeWt45aiwmH8w+LFmwkc+sM+8BnkrQ1fZu+gLAjmqffhSunc6oRpiibGwFOVfYWxMgLDXwDYIwSyJNs3EqDm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alanderk.com; spf=pass smtp.mailfrom=alanderk.com; dkim=pass (2048-bit key) header.d=alanderk.com header.i=@alanderk.com header.b=rNxZqfA8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alanderk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alanderk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alanderk.com header.i=@alanderk.com header.b="rNxZqfA8"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a16af2a232so1762825e9.1
        for <dwarves@vger.kernel.org>; Fri, 09 Oct 2026 13:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=alanderk.com; s=googol; t=1791576638; x=1792181438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EJ+o+4jIxwTH4R8juVBWrHTXbo8gUGBaH8eDaOzMlw0=;
        b=rNxZqfA81EEg4Gxy5IQxSzbbRfKrRQXu3QhgfJwNtm9vC8KHcwxUz9XHxh6J9Vilmp
         i/giZgW05avEKe6q1X+imoohYI5gj+lIXMW0TPjnoluMXqMl8KpZBZ8IS3NuG6EuAozT
         C++sb/Mi9R5FEMZJda07Vi6C1gMF7HyJICpKLFYJywxmANUhd/hA/Kr3Ra2Pz5QNODIa
         jXnntJ09Gx8+iHyhBbx/ZjDBbHo+0J7AyCutp0XYx8IfCkPF/Tp7RTY9RZMkdfYB52vw
         zrNsIaUmduwFWICwVjJc+mbb1GmO5d95C2NY7hs93hD/8dzu9Rb7yukOXUHwCDt75Uzm
         Zd+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791576638; x=1792181438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EJ+o+4jIxwTH4R8juVBWrHTXbo8gUGBaH8eDaOzMlw0=;
        b=kOl9XaEr4Tx8de+KrJyT0YZYXpVD/q4n+t66jF5srzY/PunRvXd/F3c8toVo8E6QUE
         xRLud9QBXVBHtFG1jaIXXb7b9eg9ACynkEHm6OC5hos2fAts+YaoZVDTbxVpFPT4xEhH
         egMuXa3cfJQFfF/hI+omLFVGURPw1brvhTttyguCgsRFYjbxPurvYOL+ExH7VprNEtS/
         Iha0dc7zSwC4Equc3oeEVx/ZqGyn+6mb7v2IVrLxk239eJuHF2Hn02q9t/rqyijS5Kg9
         fbPmwItiHg/FNT9DMslG5j2KE0QKPsrdqKCqEZFGw04+HgsynkyqP3+4cKXsyWF4t6xi
         TskQ==
X-Gm-Message-State: AFuF++m8KJS69s3//pENmae+ep+zACVasUEA0Mwg1AvwziDxDsQkK0bZ
	y7min+h1a97fVr0DRcax8rAcHFSMQkuDlIpFKwhNm28cU8P7n4c9hOBahVxMVGp+bmw=
X-Gm-Gg: AYBFou1TPrCrx7JjNCrY+NqB8DL5XhTc9Bf9W6fyEhCWu+SjWO7a9YvTbh61OF/7vTy
	dvyBZU94LhlkCQoGQ8YJKlBhog5V7qKstXv1xrqXCRS+YXP9m4NU5iqVkSXeDQvPiH/0ufbaiqm
	vcXOFjDGgaKxnS/F8BeF3QvpmctLOcO7oPGhIdRylyYw81twBxXFQDwIoO/PlkR8dWyrJTpUc9R
	LIbH14t9HYtCwE4ZO1r8kMjn5H++BQFGcS4kp9SN76dpHexR5oMa6/lvSyq0pnZm0ZhksJK8bDq
	5gA86KrAc9pv0DGaZTbyZfC2Hrt9aGyqONTh5VG51/39fi22V+kTqd3xYctJBSTPl6WLc7f/5N6
	pmFzNX1XC9FYA+UCwSmvJ0+c29y/GDbVrScCRkO8MPbj+av34nMquWBUSjidpIMlZCaVBcE1ziW
	2SXpOLmXmV7osSO1tdR9UTBlvfAANlpfPMYC0ZCgmJFMNgrTRitG/3BnfxVsYbWIPUPvyDuHZ0z
	ZJQwnFxwc6zIAswGZuLo1VCxH6fsKVF0A==
X-Received: by 2002:a05:600c:4e01:b0:49f:ce78:3567 with SMTP id 5b1f17b1804b1-4a18e4afc3amr55785525e9.24.1791576637412;
        Fri, 09 Oct 2026 13:10:37 -0700 (PDT)
Received: from macmini4.tapir-palermo.ts.net ([138.199.43.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18be8c5e7sm110980415e9.4.2026.10.09.13.10.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 09 Oct 2026 13:10:37 -0700 (PDT)
From: Alan Derk <linux@alanderk.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>
Cc: dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH dwarves] dwarf_loader: Take the merged CU language from a CU that is kept
Date: Fri,  9 Oct 2026 20:10:32 +0000
Message-ID: <20261009201032.40105-1-linux@alanderk.com>
X-Mailer: git-send-email 2.55.0
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
As far as I know this is the last thing keeping RUST off when LTO and
BTF are both on. Once it is in a pahole release, I'd like to propose
relaxing the kernel's dependency to something like:

  depends on !DEBUG_INFO_BTF || (PAHOLE_HAS_LANG_EXCLUDE && (!LTO || PAHOLE_VERSION >= 133))

assuming the fix lands in 1.33. The tests above ran with "&& !LTO"
dropped from that line, hence the Cc to rust-for-linux.

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

base-commit: 1e342ac44979748bcf5bb37f84ea055e7f4d7184
-- 
2.55.0

