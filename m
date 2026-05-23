Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B63931E840
	for <dwarves@vger.kernel.org>; Sat, 23 May 2026 16:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779555516; cv=none; b=Gsv+PEJ+r8a1qQUjWV8xzg4o7bE9QTRI1BCzq23V4p8t7+T4K34gGmFbgeyu0vbBKpTcSgX9WLG7ygJx0s8l+XXoYn45x/De6oCccdMQ+704WuZQixe/3NosoZEwgwRp5ykLdQJqs4QMJ24mHORZAQUc7NAsWjHNB+jUGGlVPvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779555516; c=relaxed/simple;
	bh=vquQzjwYD4k2yvjwWLFtCXlDq9evqcqzxDDUzSblsrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WZC2JIXCoTiuZgKjGydY7n2ioAaCUrdU6CYewjcmGuVCPismalF0AMsT10hvOgkjshLTF1oWPljMI9+XQXYJSfK0ehwXyrBHGV9bz/S6sFJ0LJOvvRUOc3hJG4c3bzNps6PyC3FPhS24BsP/3vDLvL8vnRLM8hWNVSX+XMdl1pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 8F6CBEE908DA0; Sat, 23 May 2026 09:58:32 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH dwarves v5 11/11] tests: Add a few clang true signature tests
Date: Sat, 23 May 2026 09:58:32 -0700
Message-ID: <20260523165832.1233886-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260523165712.1225231-1-yonghong.song@linux.dev>
References: <20260523165712.1225231-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Three tests are added.

Test 1: VERBOSE=3D1 ./clang_parm_optimized.sh
  BTF:   BTF: int foo(int a, int c);
  DWARF: DWARF: int foo(int a, int b, int c);
where parameber 'b' is unused.

Test 2: VERBOSE=3D1 ./clang_parm_optimized_stack.sh
  BTF:   BTF: int foo(int a, int i);
  DWARF: DWARF: int foo(int a, int b, int c, int d, int e, int f, int g, =
int h, int i);
where parameters 'b' to 'h' are unused.

Test 3: VERBOSE=3D1 ./clang_parm_aggregate.sh
  BTF (x86_64):  long foo(long a__f1, struct t b, int i);
  BTF (aarch64): long foo(struct t a, struct t b, int i);
  DWARF:         long foo(struct t a, struct t b, int i);
where the 'struct t' definition is 'struct t { long f1; long f2; };', and
a.f2 is not used in the function for x86_64 arch.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tests/clang_parm_aggregate.sh       | 85 +++++++++++++++++++++++++++++
 tests/clang_parm_optimized.sh       | 63 +++++++++++++++++++++
 tests/clang_parm_optimized_stack.sh | 63 +++++++++++++++++++++
 3 files changed, 211 insertions(+)
 create mode 100755 tests/clang_parm_aggregate.sh
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

