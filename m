Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33303D7D83
	for <dwarves@vger.kernel.org>; Mon,  9 Mar 2026 15:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773070394; cv=none; b=aW97dTDTeWNRpszBvolGBySAvoTDrYYv993+md5YGGQDJcpBALSR5xGxyPkKz7X8cAmsomcEl+t6sV+y+iPZJ5YRgMa2SwpMrdR4SOm0DDwhpO2bf+9LLwQb0X8TrV5zk+eoKeVqcRooAOld2vyV9/6UkgRUr8FfoaQiaNyfGQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773070394; c=relaxed/simple;
	bh=SjqU1PCjJxWDURIZKigdDFtT346ulOxagGcQxxkHQSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qm3T6L6OwznI1bYiR+j8y0VU0d5hAEy8LrLGmgnP4oa8rTJNgFBjmRByh811R/0kF9zMHFdZfCabZhfr4h0ii84Yufeg5MbgV4iqU58VI5NGj2dVY64mhvSbxxBqGkwVrM+nSRdW6iIbPg5RppIkWPukMwU1DW19am8VAoVUHmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id D100E24944435; Mon,  9 Mar 2026 08:33:01 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH dwarves v2 9/9] tests: Add a few clang true signature tests
Date: Mon,  9 Mar 2026 08:33:01 -0700
Message-ID: <20260309153301.1922035-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260309153215.1917033-1-yonghong.song@linux.dev>
References: <20260309153215.1917033-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Three tests are added.

Test 1: clang_parm_optimized.sh
  BTF:   char * foo(struct t * a, struct t * d);
  DWARF: char * foo(struct t * a, int b, struct t * d);
where parameber 'b' is unused.

Test 2: clang_parm_optimized_stack.sh
  BTF:   char * foo(struct t * a, struct t * d);
  DWARF: char * foo(struct t * a, int b1, int b2, int b3, int b4, int b5,=
 int b6, struct t * d);
where parameters 'b1' to 'b6' are unused.

Test 3: clang_parm_aggregate.sh
  BTF:   long foo(long a__f1, struct t b, int i);
  DWARF: long foo(struct t a, struct t b, int i);
where the 'struct t' definition is 'struct t { long f1; long f2; };', and
a.f2 is not used in the function.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tests/true_signatures/clang_parm_aggregate.sh | 83 ++++++++++++++++
 tests/true_signatures/clang_parm_optimized.sh | 95 +++++++++++++++++++
 .../clang_parm_optimized_stack.sh             | 95 +++++++++++++++++++
 .../gcc_true_signatures.sh                    |  0
 4 files changed, 273 insertions(+)
 create mode 100755 tests/true_signatures/clang_parm_aggregate.sh
 create mode 100755 tests/true_signatures/clang_parm_optimized.sh
 create mode 100755 tests/true_signatures/clang_parm_optimized_stack.sh
 rename tests/{ =3D> true_signatures}/gcc_true_signatures.sh (100%)

diff --git a/tests/true_signatures/clang_parm_aggregate.sh b/tests/true_s=
ignatures/clang_parm_aggregate.sh
new file mode 100755
index 0000000..6d92701
--- /dev/null
+++ b/tests/true_signatures/clang_parm_aggregate.sh
@@ -0,0 +1,83 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+
+outdir=3D
+
+fail()
+{
+	# Do not remove test dir; might be useful for analysis
+	trap - EXIT
+	if [[ -d "$outdir" ]]; then
+		echo "Test data is in $outdir"
+	fi
+	exit 1
+}
+
+cleanup()
+{
+	rm ${outdir}/*
+	rmdir $outdir
+}
+
+outdir=3D$(mktemp -d /tmp/clang_true.sh.XXXXXX)
+
+trap cleanup EXIT
+
+echo -n "Validation of BTF encoding of true_signatures: "
+
+clang_true=3D"${outdir}/clang_true"
+CC=3D$(which clang 2>/dev/null)
+
+if [[ -z "$CC" ]]; then
+	echo "skip: clang not available"
+	exit 2
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
+	echo "Could not compile ${clang_true}.c" >& 2
+	exit 1
+fi
+LLVM_OBJCOPY=3Dobjcopy pahole -J --btf_features=3D+true_signature $clang=
_true
+if [[ $? -ne 0 ]]; then
+	echo "Could not encode BTF for $clang_true"
+	exit 1
+fi
+
+btf_optimized=3D$(pfunct --all --format_path=3Dbtf $clang_true |grep "fo=
o")
+if [[ -z "$btf_optimized" ]]; then
+	echo "skip: no optimizations applied."
+	exit 2
+fi
+
+btf_cmp=3D$btf_optimized
+dwarf=3D$(pfunct --all $clang_true |grep "foo")
+
+test -n "$VERBOSE" && printf "\nBTF: $btf_optimized  DWARF: $dwarf \n"
+
+if [[ "$btf_cmp" =3D=3D "$dwarf" ]]; then
+	echo "BTF and DWARF signatures should be different and they are not: BT=
F: $btf_optimized ; DWARF $dwarf"
+	exit 1
+else
+        echo ""
+        echo "  BTF:   $btf_optimized"
+        echo "  DWARF: $dwarf"
+fi
+echo "Ok"
+exit 0
diff --git a/tests/true_signatures/clang_parm_optimized.sh b/tests/true_s=
ignatures/clang_parm_optimized.sh
new file mode 100755
index 0000000..3022e2b
--- /dev/null
+++ b/tests/true_signatures/clang_parm_optimized.sh
@@ -0,0 +1,95 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+
+outdir=3D
+
+fail()
+{
+	# Do not remove test dir; might be useful for analysis
+	trap - EXIT
+	if [[ -d "$outdir" ]]; then
+		echo "Test data is in $outdir"
+	fi
+	exit 1
+}
+
+cleanup()
+{
+	rm ${outdir}/*
+	rmdir $outdir
+}
+
+outdir=3D$(mktemp -d /tmp/clang_true.sh.XXXXXX)
+
+trap cleanup EXIT
+
+echo -n "Validation of BTF encoding of true_signatures: "
+
+clang_true=3D"${outdir}/clang_true"
+CC=3D$(which clang 2>/dev/null)
+
+if [[ -z "$CC" ]]; then
+	echo "skip: clang not available"
+	exit 2
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
+	echo "Could not compile ${clang_true}.c" >& 2
+	exit 1
+fi
+LLVM_OBJCOPY=3Dobjcopy pahole -J --btf_features=3D+true_signature $clang=
_true
+if [[ $? -ne 0 ]]; then
+	echo "Could not encode BTF for $clang_true"
+	exit 1
+fi
+
+btf_optimized=3D$(pfunct --all --format_path=3Dbtf $clang_true |grep "fo=
o")
+if [[ -z "$btf_optimized" ]]; then
+	echo "skip: no optimizations applied."
+	exit 2
+fi
+
+btf_cmp=3D$btf_optimized
+dwarf=3D$(pfunct --all $clang_true |grep "foo")
+
+test -n "$VERBOSE" && printf "\nBTF: $btf_optimized  DWARF: $dwarf \n"
+
+if [[ "$btf_cmp" =3D=3D "$dwarf" ]]; then
+	echo "BTF and DWARF signatures should be different and they are not: BT=
F: $btf_optimized ; DWARF $dwarf"
+	exit 1
+else
+        echo ""
+        echo "  BTF:   $btf_optimized"
+        echo "  DWARF: $dwarf"
+fi
+echo "Ok"
+exit 0
diff --git a/tests/true_signatures/clang_parm_optimized_stack.sh b/tests/=
true_signatures/clang_parm_optimized_stack.sh
new file mode 100755
index 0000000..1abb96d
--- /dev/null
+++ b/tests/true_signatures/clang_parm_optimized_stack.sh
@@ -0,0 +1,95 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+
+outdir=3D
+
+fail()
+{
+	# Do not remove test dir; might be useful for analysis
+	trap - EXIT
+	if [[ -d "$outdir" ]]; then
+		echo "Test data is in $outdir"
+	fi
+	exit 1
+}
+
+cleanup()
+{
+	rm ${outdir}/*
+	rmdir $outdir
+}
+
+outdir=3D$(mktemp -d /tmp/clang_true.sh.XXXXXX)
+
+trap cleanup EXIT
+
+echo -n "Validation of BTF encoding of true_signatures: "
+
+clang_true=3D"${outdir}/clang_true"
+CC=3D$(which clang 2>/dev/null)
+
+if [[ -z "$CC" ]]; then
+	echo "skip: clang not available"
+	exit 2
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
+	echo "Could not compile ${clang_true}.c" >& 2
+	exit 1
+fi
+LLVM_OBJCOPY=3Dobjcopy pahole -J --btf_features=3D+true_signature $clang=
_true
+if [[ $? -ne 0 ]]; then
+	echo "Could not encode BTF for $clang_true"
+	exit 1
+fi
+
+btf_optimized=3D$(pfunct --all --format_path=3Dbtf $clang_true |grep "fo=
o")
+if [[ -z "$btf_optimized" ]]; then
+	echo "skip: no optimizations applied."
+	exit 2
+fi
+
+btf_cmp=3D$btf_optimized
+dwarf=3D$(pfunct --all $clang_true |grep "foo")
+
+test -n "$VERBOSE" && printf "\nBTF: $btf_optimized  DWARF: $dwarf \n"
+
+if [[ "$btf_cmp" =3D=3D "$dwarf" ]]; then
+	echo "BTF and DWARF signatures should be different and they are not: BT=
F: $btf_optimized ; DWARF $dwarf"
+	exit 1
+else
+        echo ""
+        echo "  BTF:   $btf_optimized"
+        echo "  DWARF: $dwarf"
+fi
+echo "Ok"
+exit 0
diff --git a/tests/gcc_true_signatures.sh b/tests/true_signatures/gcc_tru=
e_signatures.sh
similarity index 100%
rename from tests/gcc_true_signatures.sh
rename to tests/true_signatures/gcc_true_signatures.sh
--=20
2.47.3

