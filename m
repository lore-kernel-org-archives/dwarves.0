Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3A832E6BD
	for <dwarves@vger.kernel.org>; Fri, 20 Mar 2026 19:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774033820; cv=none; b=OVJTpcI0hY02eBSqa6Cxnph+UHtMjWusRJRrVx4HjDZcuSMI1csV5VFOXhllGDdl+U+Y6dwj1Eh/tPz8YsXBo/GTMWobitLywJewLnln6mXUsWPRCokbv3HCmtnm+oGoif2asAr0ewLbzCjoBg7sOPVt7ktr241Metd7ZVWqKBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774033820; c=relaxed/simple;
	bh=6PUSx3EUuEWtxpJFwmqqR+KPtW/iuN2npkRmf+SHj0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p34TdCF9JfJVKUD0pKd6ZPDVBVwZw/WFEpmA0IA2KWSpFl+g33Xhccd6iypaqrtXfLBK8t5vg0gVCTfr6GvvCXqfXCUGWbDs4xdsM2BkW1Gy5SvKNoiAuNcHy9mBL7FkxYixH4AXMXv+ztRQkZWL98jwMLBN+z7Hnrk18PyfG98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id EFF0F2A7EAE37; Fri, 20 Mar 2026 12:10:03 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH dwarves v3 9/9] tests: Add a few clang true signature tests
Date: Fri, 20 Mar 2026 12:10:03 -0700
Message-ID: <20260320191003.1975752-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260320190917.1970524-1-yonghong.song@linux.dev>
References: <20260320190917.1970524-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Three tests are added.

Test 1: VERBOSE=3D1 ./clang_parm_optimized.sh
  BTF:   char * foo(struct t * a, struct t * d);
  DWARF: char * foo(struct t * a, int b, struct t * d);
where parameber 'b' is unused.

Test 2: VERBOSE=3D1 ./clang_parm_optimized_stack.sh
  BTF:   char * foo(struct t * a, struct t * d);
  DWARF: char * foo(struct t * a, int b1, int b2, int b3, int b4, int b5,=
 int b6, struct t * d);
where parameters 'b1' to 'b6' are unused.

Test 3: VERBOSE=3D1 ./clang_parm_aggregate.sh
  BTF:   long foo(long a__f1, struct t b, int i);
  DWARF: long foo(struct t a, struct t b, int i);
where the 'struct t' definition is 'struct t { long f1; long f2; };', and
a.f2 is not used in the function.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tests/clang_parm_aggregate.sh       | 63 +++++++++++++++++++++++
 tests/clang_parm_optimized.sh       | 77 +++++++++++++++++++++++++++++
 tests/clang_parm_optimized_stack.sh | 77 +++++++++++++++++++++++++++++
 3 files changed, 217 insertions(+)
 create mode 100755 tests/clang_parm_aggregate.sh
 create mode 100755 tests/clang_parm_optimized.sh
 create mode 100755 tests/clang_parm_optimized_stack.sh

diff --git a/tests/clang_parm_aggregate.sh b/tests/clang_parm_aggregate.s=
h
new file mode 100755
index 0000000..bf47c8c
--- /dev/null
+++ b/tests/clang_parm_aggregate.sh
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
+if [[ "$btf_cmp" =3D=3D "$dwarf" ]]; then
+	error_log "BTF and DWARF signatures should be different and they are no=
t: BTF: $btf_optimized ; DWARF $dwarf"
+	test_fail
+fi
+test_pass
diff --git a/tests/clang_parm_optimized.sh b/tests/clang_parm_optimized.s=
h
new file mode 100755
index 0000000..379e6d5
--- /dev/null
+++ b/tests/clang_parm_optimized.sh
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
+cat > ${clang_true}.c << EOF
+struct t { int a; };
+__attribute__((noinline)) char *tar(struct t *a, struct t *d)
+{
+	if (a->a =3D=3D d->a)
+		return (char *)10;
+	else
+		return (char *)0;
+}
+
+__attribute__((noinline)) static char * foo(struct t *a, int b, struct t=
 *d)
+{
+	return tar(a, d);
+}
+
+__attribute__((noinline)) char *bar(struct t *a, struct t *d)
+{
+	return foo(a, 1, d);
+}
+
+struct t p1, p2;
+int main()
+{
+	return !!bar(&p1, &p2);
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
index 0000000..8638af7
--- /dev/null
+++ b/tests/clang_parm_optimized_stack.sh
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
+cat > ${clang_true}.c << EOF
+struct t { int a; };
+__attribute__((noinline)) char *tar(struct t *a, struct t *d)
+{
+        if (a->a =3D=3D d->a)
+                return (char *)10;
+        else
+                return (char *)0;
+}
+
+__attribute__((noinline)) static char * foo(struct t *a, int b1, int b2,=
 int b3, int b4, int b5, int b6, struct t *d)
+{
+        return tar(a, d);
+}
+
+__attribute__((noinline)) char *bar(struct t *a, struct t *d)
+{
+        return foo(a, 1, 2, 3, 4, 5, 6, d);
+}
+
+struct t p1, p2;
+int main()
+{
+        return !!bar(&p1, &p2);
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
2.52.0

