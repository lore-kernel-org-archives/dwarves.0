Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5FC4F649D
	for <dwarves@vger.kernel.org>; Fri, 25 Sep 2026 21:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790372198; cv=none; b=AzaWBvgACjnE3vrE+lNNFxi+GwgtsnLfTxpY1IqUk4bok+QMS6ta7qKlWl4A1Ql50X1Eap+ZlrFrNp1i5iYkPqpPmOTBNkn1sb1iuPAuYehwAEAHk0hSRywa8y83dVEtgEYa+wes0RO+mDJWNzQUEXGPKIXGkAfQoX0/K52YWh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790372198; c=relaxed/simple;
	bh=SCHOqjMPnEQpw5YUJPao6DKOVM3KDmOkhVE0UgSRiyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gM2+SQYXq9bCYyOdNd0EUsx5tmFNdTTWG0RRhup6nd61WDgygbHDpRvkCD6IE8e/4hEeQ40x87GCflOI5jqCvCi51HPw04QMGJV6cNxaIBPiZHRo7tZGbToUA0JK1fQPInEe66uV5hPJs/TQtEuLwN1oH7knJjJnxlKhAbC6/Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id B92212D343D56B; Fri, 25 Sep 2026 14:36:24 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH dwarves 2/2] tests: Add test for parameters described by entry values
Date: Fri, 25 Sep 2026 14:36:24 -0700
Message-ID: <20260925213624.2188373-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925213619.2187751-1-yonghong.song@linux.dev>
References: <20260925213619.2187751-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Cover the case where clang leaves the entry PC out of a parameter's
location list because the parameter is moved into a callee-saved register
during the prologue.  f_lazy() reproduces the shape found in the kernel:
@lazy arrives in RSI, the first location list entry starts past the
function entry and names the callee-saved register, and only the
DW_OP_entry_value entries name RSI.

Without the entry value being preferred, @lazy looks like it is in an
unexpected register and f_lazy() is dropped from BTF altogether.

The test results on x86_64:
  $ VERBOSE=3D1 ./clang_parm_entry_value.sh
  Validation of BTF encoding of parameters described by entry values.
     BTF: bool f_lazy(struct task * p, bool lazy, const struct aux  * aux=
);
  Test ./clang_parm_entry_value.sh passed

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tests/clang_parm_entry_value.sh | 84 +++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100755 tests/clang_parm_entry_value.sh

diff --git a/tests/clang_parm_entry_value.sh b/tests/clang_parm_entry_val=
ue.sh
new file mode 100755
index 0000000..9fe81a7
--- /dev/null
+++ b/tests/clang_parm_entry_value.sh
@@ -0,0 +1,84 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+
+source "$(dirname "$0")/test_lib.sh"
+
+outdir=3D$(make_tmpdir)
+
+# Comment this out to save test data.
+trap cleanup EXIT
+
+title_log "Validation of BTF encoding of parameters described by entry v=
alues."
+
+entry_value=3D"${outdir}/entry_value"
+CC=3D$(which clang 2>/dev/null)
+
+if [[ -z "$CC" ]]; then
+	info_log "skip: clang not available"
+	test_skip
+fi
+
+arch=3D$(uname -m)
+if [[ "$arch" !=3D "x86_64" ]]; then
+	info_log "skip: test is x86_64 only, running on $arch"
+	test_skip
+fi
+
+# clang can leave the entry PC out of a parameter's location list when t=
he
+# parameter is moved into a callee-saved register during the prologue.  =
The
+# first location list entry then names that callee-saved register rather=
 than
+# the ABI argument register, and only the DW_OP_entry_value entries tell=
 which
+# argument register the parameter really arrived in.  pahole has to use =
the
+# entry value, otherwise the parameter looks like it is in an unexpected
+# register and the whole function is dropped from BTF.
+cat > ${entry_value}.c << EOF
+typedef _Bool bool;
+struct sched;
+struct aux;
+struct task { long a; bool lazy; };
+
+extern struct sched *get_sched(const struct aux *aux);
+extern void rcu_lock(void);
+extern void rcu_unlock(void);
+extern int on_sched(struct sched *s, struct task *p);
+
+__attribute__((noinline)) bool f_lazy(struct task *p, bool lazy, const s=
truct aux *aux)
+{
+	struct sched *sch;
+
+	rcu_lock();
+	sch =3D get_sched(aux);
+	if (__builtin_expect(!(sch && on_sched(sch, p)), 0)) {
+		rcu_unlock();
+		return 0;
+	}
+	__atomic_store_n(&p->lazy, lazy, __ATOMIC_RELAXED);
+	rcu_unlock();
+	return 1;
+}
+
+bool (*keep[])() =3D { (bool(*)())f_lazy };
+EOF
+
+${CC} -g -O2 -c -o ${entry_value}.o ${entry_value}.c 2>/dev/null
+if [[ $? -ne 0 ]]; then
+	info_log "skip: clang could not compile ${entry_value}.c"
+	test_skip
+fi
+
+LLVM_OBJCOPY=3Dobjcopy pahole -J --btf_features=3Dconsistent_func ${entr=
y_value}.o
+if [[ $? -ne 0 ]]; then
+	error_log "Could not encode BTF for ${entry_value}.o"
+	test_fail
+fi
+
+encoded=3D$(pfunct --all --format_path=3Dbtf ${entry_value}.o | grep " f=
_lazy(")
+if [[ -n "$VERBOSE" ]]; then
+	printf "   BTF: %s\n" "$encoded"
+fi
+if [[ -z "$encoded" ]]; then
+	error_log "f_lazy() is missing from BTF"
+	test_fail
+fi
+
+test_pass
--=20
2.53.0-Meta

