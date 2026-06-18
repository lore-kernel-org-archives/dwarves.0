Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361DA296BCB
	for <dwarves@vger.kernel.org>; Thu, 18 Jun 2026 01:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781745281; cv=none; b=h2RTDqJjzW0D2sZUpSNG4cs3Aa8GaHXNVmAsV+j8MCTm1ADXB2AMHJjkBCTxZeOvaXWawMbZ/hPRQMnsMFc7eFlVyPwJMSLreDG1x2amiTNzXIfbUOm6+c7VLKW+do4Y8YlwsO2N8AdcHel7sDQoVhoaejae6XPnqcw+xxwowik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781745281; c=relaxed/simple;
	bh=uzILa6c9C02nWl4oNNWYgRXzSgGcSc3Dx5hdh/KM4Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHyum31N+lss8JZD6RQ6CfmgBzVBzgDdInXekYcwauLhROLjo20u3pBgTU8N0xwiE3UGPKFq78RsZMkRFbmodrG2YePv9Rue/fWluZzmy8ETiZFnijqgIogr+htDZjUsLMkIWxi5qkDb9nWzS0A2z/S7VOK0kv077EFyNGdRG2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id F0516176E413ED; Wed, 17 Jun 2026 18:14:25 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH dwarves v6 5/5] tests: add BTF true_signature encoding tests
Date: Wed, 17 Jun 2026 18:14:25 -0700
Message-ID: <20260618011425.641459-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618011358.632394-1-yonghong.song@linux.dev>
References: <20260618011358.632394-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add four tests exercising true_signature BTF encoding for clang-built,
signature-changed (DW_CC_nocall) functions:

 - clang_parm_optimized: an unused scalar parameter is dropped from the
   true signature.
 - clang_parm_optimized_stack: with more arguments than argument register=
s,
   optimized-out parameters (including stack-passed ones) are dropped.
 - clang_parm_aggregate: a two-register aggregate that is only partially
   used is rewritten to its single used member, while a fully-used
   aggregate is preserved.
 - clang_parm_memory: a large aggregate classified MEMORY and passed on t=
he
   stack is kept while an unused parameter is dropped.  A union is used s=
o
   the struct-parameter exception in cu__resolve_func_ret_types_optimized=
()
   does not mask a wrong unexpected_reg.

Each test compares the BTF signature against the DWARF signature.  Since
clang only emits DW_CC_nocall on some architectures, the tests assert the
signatures differ on x86_64 and skip (or, on arm64, expect them equal)
elsewhere. The following is an example to dump BTF vs. Dwarf:

  $ VERBOSE=3D1 ./clang_parm_memory.sh
  Validation of BTF encoding of true_signatures.
     BTF: long foo(union big u, int x); DWARF: long foo(union big u, int =
dead, int x);
  Test ./clang_parm_memory.sh passed

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tests/clang_parm_aggregate.sh       | 85 +++++++++++++++++++++++++++++
 tests/clang_parm_memory.sh          | 77 ++++++++++++++++++++++++++
 tests/clang_parm_optimized.sh       | 63 +++++++++++++++++++++
 tests/clang_parm_optimized_stack.sh | 63 +++++++++++++++++++++
 4 files changed, 288 insertions(+)
 create mode 100755 tests/clang_parm_aggregate.sh
 create mode 100755 tests/clang_parm_memory.sh
 create mode 100755 tests/clang_parm_optimized.sh
 create mode 100755 tests/clang_parm_optimized_stack.sh

diff --git a/tests/clang_parm_aggregate.sh b/tests/clang_parm_aggregate.s=
h
new file mode 100755
index 0000000..9502f8b
--- /dev/null
+++ b/tests/clang_parm_aggregate.sh
@@ -0,0 +1,85 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+
+source test_lib.sh
+
+outdir=3D$(make_tmpdir)
+
+# Comment this out to save test data.
+trap cleanup EXIT
+
+title_log "Validation of BTF encoding of true_signatures."
+
+clang_true=3D"${outdir}/clang_true"
+CC=3D$(which clang 2>/dev/null)
+
+if [[ -z "$CC" ]]; then
+	info_log "skip: clang not available"
+	test_skip
+fi
+
+cat > ${clang_true}.c << EOF
+struct t { long f1; long f2; };
+__attribute__((noinline)) static long foo(struct t a, struct t b, int i)
+{
+        return a.f1 + b.f1 + b.f2 + i;
+}
+
+struct t p1, p2;
+int i;
+int main()
+{
+        return (int)foo(p1, p2, i);
+}
+EOF
+
+CFLAGS=3D"$CFLAGS -g -O2"
+${CC} ${CFLAGS} -o $clang_true ${clang_true}.c
+if [[ $? -ne 0 ]]; then
+	error_log "Could not compile ${clang_true}.c"
+	test_fail
+fi
+LLVM_OBJCOPY=3Dobjcopy pahole -J --btf_features=3D+true_signature $clang=
_true
+if [[ $? -ne 0 ]]; then
+	error_log "Could not encode BTF for $clang_true"
+	test_fail
+fi
+
+btf_optimized=3D$(pfunct --all --format_path=3Dbtf $clang_true |grep "fo=
o")
+if [[ -z "$btf_optimized" ]]; then
+	info_log "skip: no optimizations applied."
+	test_skip
+fi
+
+btf_cmp=3D$btf_optimized
+dwarf=3D$(pfunct --all $clang_true |grep "foo")
+
+verbose_log "BTF: $btf_optimized  DWARF: $dwarf"
+
+arch=3D$(uname -m)
+
+if [[ "$arch" =3D=3D "x86_64" ]]; then
+	# On x86_64, clang emits DW_CC_nocall for optimized functions,
+	# so pahole should detect the optimization and produce a
+	# different BTF signature.
+	if [[ "$btf_cmp" =3D=3D "$dwarf" ]]; then
+		error_log "BTF and DWARF signatures should be different and they are n=
ot: BTF: $btf_optimized ; DWARF $dwarf"
+		test_fail
+	fi
+elif [[ "$arch" =3D=3D "aarch64" ]]; then
+	# On arm64, clang does not emit DW_CC_nocall, so pahole cannot
+	# detect the optimization. BTF and DWARF signatures are expected
+	# to be the same.
+	if [[ "$btf_cmp" !=3D "$dwarf" ]]; then
+		error_log "On arm64, BTF and DWARF signatures should be the same but t=
hey are not: BTF: $btf_optimized ; DWARF $dwarf"
+		test_fail
+	fi
+else
+	# On other architectures, skip if we cannot determine the
+	# expected behavior.
+	if [[ "$btf_cmp" =3D=3D "$dwarf" ]]; then
+		info_log "skip: no optimization detected on $arch"
+		test_skip
+	fi
+fi
+test_pass
diff --git a/tests/clang_parm_memory.sh b/tests/clang_parm_memory.sh
new file mode 100755
index 0000000..d0d798d
--- /dev/null
+++ b/tests/clang_parm_memory.sh
@@ -0,0 +1,77 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+
+source test_lib.sh
+
+outdir=3D$(make_tmpdir)
+
+# Comment this out to save test data.
+trap cleanup EXIT
+
+title_log "Validation of BTF encoding of true_signatures."
+
+clang_true=3D"${outdir}/clang_true"
+CC=3D$(which clang 2>/dev/null)
+
+if [[ -z "$CC" ]]; then
+	info_log "skip: clang not available"
+	test_skip
+fi
+
+# the expected true signature: long foo(union big u, int x).
+cat > ${clang_true}.c << EOF
+union big { long a; char buf[24]; };
+__attribute__((noinline)) static long foo(union big u, int dead, int x)
+{
+        return u.a + x;
+}
+
+union big g;
+int dead, x;
+int main()
+{
+        return (int)foo(g, dead, x);
+}
+EOF
+
+CFLAGS=3D"$CFLAGS -g -O2"
+${CC} ${CFLAGS} -o $clang_true ${clang_true}.c
+if [[ $? -ne 0 ]]; then
+	error_log "Could not compile ${clang_true}.c"
+	test_fail
+fi
+LLVM_OBJCOPY=3Dobjcopy pahole -J --btf_features=3D+true_signature $clang=
_true
+if [[ $? -ne 0 ]]; then
+	error_log "Could not encode BTF for $clang_true"
+	test_fail
+fi
+
+btf_optimized=3D$(pfunct --all --format_path=3Dbtf $clang_true |grep "fo=
o")
+dwarf=3D$(pfunct --all $clang_true |grep "foo")
+
+verbose_log "BTF: $btf_optimized  DWARF: $dwarf"
+
+arch=3D$(uname -m)
+
+if [[ "$arch" =3D=3D "x86_64" ]]; then
+	# On x86_64, clang emits DW_CC_nocall for optimized functions.  The
+	# stack-passed aggregate must remain present and 'dead' must be
+	# dropped, so a true signature must be produced and it must differ
+	# from the DWARF signature.
+	if [[ -z "$btf_optimized" ]]; then
+		error_log "BTF for foo missing; the stack-passed aggregate was likely =
rejected"
+		test_fail
+	fi
+	if [[ "$btf_optimized" =3D=3D "$dwarf" ]]; then
+		error_log "BTF and DWARF signatures should be different and they are n=
ot: BTF: $btf_optimized ; DWARF $dwarf"
+		test_fail
+	fi
+else
+	# On other architectures clang may not emit DW_CC_nocall, so we
+	# cannot assert the optimization was detected.
+	if [[ -z "$btf_optimized" ]]; then
+		info_log "skip: no optimization detected on $arch"
+		test_skip
+	fi
+fi
+test_pass
diff --git a/tests/clang_parm_optimized.sh b/tests/clang_parm_optimized.s=
h
new file mode 100755
index 0000000..81d50af
--- /dev/null
+++ b/tests/clang_parm_optimized.sh
@@ -0,0 +1,63 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+
+source test_lib.sh
+
+outdir=3D$(make_tmpdir)
+
+# Comment this out to save test data.
+trap cleanup EXIT
+
+title_log "Validation of BTF encoding of true_signatures."
+
+clang_true=3D"${outdir}/clang_true"
+CC=3D$(which clang 2>/dev/null)
+
+if [[ -z "$CC" ]]; then
+	info_log "skip: clang not available"
+	test_skip
+fi
+
+cat > ${clang_true}.c << EOF
+__attribute__((noinline)) static int foo(int a, int b, int c)
+{
+	return a * c - a - c;
+}
+
+int a, b, c;
+int main()
+{
+	return foo(a, b, c);
+}
+EOF
+
+CFLAGS=3D"$CFLAGS -g -O2"
+${CC} ${CFLAGS} -o $clang_true ${clang_true}.c
+if [[ $? -ne 0 ]]; then
+	error_log "Could not compile ${clang_true}.c"
+	test_fail
+fi
+LLVM_OBJCOPY=3Dobjcopy pahole -J --btf_features=3D+true_signature $clang=
_true
+if [[ $? -ne 0 ]]; then
+	error_log "Could not encode BTF for $clang_true"
+	test_fail
+fi
+
+btf_optimized=3D$(pfunct --all --format_path=3Dbtf $clang_true |grep "fo=
o")
+if [[ -z "$btf_optimized" ]]; then
+	info_log "skip: no optimizations applied."
+	test_skip
+fi
+
+btf_cmp=3D$btf_optimized
+dwarf=3D$(pfunct --all $clang_true |grep "foo")
+
+if [[ -n "$VERBOSE" ]]; then
+	printf "   BTF: %s  DWARF: %s\n" "$btf_optimized" "$dwarf"
+fi
+
+if [[ "$btf_cmp" =3D=3D "$dwarf" ]]; then
+	error_log "BTF and DWARF signatures should be different and they are no=
t: BTF: $btf_optimized ; DWARF $dwarf"
+	test_fail
+fi
+test_pass
diff --git a/tests/clang_parm_optimized_stack.sh b/tests/clang_parm_optim=
ized_stack.sh
new file mode 100755
index 0000000..afdc355
--- /dev/null
+++ b/tests/clang_parm_optimized_stack.sh
@@ -0,0 +1,63 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+
+source test_lib.sh
+
+outdir=3D$(make_tmpdir)
+
+# Comment this out to save test data.
+trap cleanup EXIT
+
+title_log "Validation of BTF encoding of true_signatures."
+
+clang_true=3D"${outdir}/clang_true"
+CC=3D$(which clang 2>/dev/null)
+
+if [[ -z "$CC" ]]; then
+	info_log "skip: clang not available"
+	test_skip
+fi
+
+cat > ${clang_true}.c << EOF
+__attribute__((noinline)) static int foo(int a, int b, int c, int d, int=
 e, int f, int g, int h, int i)
+{
+        return a * i - a - i;
+}
+
+int a, b, c, d, e, f, g, h, i;
+int main()
+{
+        return foo(a, b, c, d, e, f, g, h, i);
+}
+EOF
+
+CFLAGS=3D"$CFLAGS -g -O2"
+${CC} ${CFLAGS} -o $clang_true ${clang_true}.c
+if [[ $? -ne 0 ]]; then
+	error_log "Could not compile ${clang_true}.c"
+	test_fail
+fi
+LLVM_OBJCOPY=3Dobjcopy pahole -J --btf_features=3D+true_signature $clang=
_true
+if [[ $? -ne 0 ]]; then
+	error_log "Could not encode BTF for $clang_true"
+	test_fail
+fi
+
+btf_optimized=3D$(pfunct --all --format_path=3Dbtf $clang_true |grep "fo=
o")
+if [[ -z "$btf_optimized" ]]; then
+	info_log "skip: no optimizations applied."
+	test_skip
+fi
+
+btf_cmp=3D$btf_optimized
+dwarf=3D$(pfunct --all $clang_true |grep "foo")
+
+if [[ -n "$VERBOSE" ]]; then
+	printf "   BTF: %s  DWARF: %s\n" "$btf_optimized" "$dwarf"
+fi
+
+if [[ "$btf_cmp" =3D=3D "$dwarf" ]]; then
+	error_log "BTF and DWARF signatures should be different and they are no=
t: BTF: $btf_optimized ; DWARF $dwarf"
+	test_fail
+fi
+test_pass
--=20
2.53.0-Meta

