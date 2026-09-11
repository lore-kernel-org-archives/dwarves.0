Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7888D49E133
	for <dwarves@vger.kernel.org>; Fri, 11 Sep 2026 04:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789099815; cv=none; b=anSmJWB9MHxHDvpQLUAlPzpXdNsuVPFQqMfM+TBNtBVnFPsSwbUDBkK+6K6+uBLSQjWP1wSG8cljZdTHD2ptQfm3gAM/p49ZmW4S2aQKEG4R5jcG7zRv0WYtB9Kz6TrPvFs/uDgDUMeS/OrXS5+DpRE8tXZpFleg8JM5tNBkZuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789099815; c=relaxed/simple;
	bh=97a7RdYdiN707NQHEf1vAgoKhgDkIk+l/W4WLUeCG/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WauEHfAQu12656mKztL+jIE/arz5xx8M3xZ9Wcl1U0IMV+PPLBq7w7T7Yvr2rbuQvLxn3Abv8Yfju3kUcRRnkJ/85odj8HJJ7x789ZEnRz8EgShRip+hrctglf2f+ZxpYYxEH5hDv6apz3sIkCjIIcPFIZkl+cs0OtGKXD1OIOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id CB83A29FDA2C50; Thu, 10 Sep 2026 21:10:00 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH dwarves 2/2] tests: tests: Add test for 16-byte aligned arguments on arm64
Date: Thu, 10 Sep 2026 21:10:00 -0700
Message-ID: <20260911041000.340219-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911040955.339939-1-yonghong.song@linux.dev>
References: <20260911040955.339939-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Cover the arm64 even-register rule for 16-byte aligned arguments:
f_even() and f_stack() where the rule does not bite, f_odd() and
f_odd_tail() where it leaves a register hole, and f_box() where the
alignment comes from a struct member rather than from the parameter
type itself.

The test results on arm64:
  $ VERBOSE=3D1 ./clang_parm_align16.sh
  Validation of BTF encoding of over-aligned arguments.
     BTF: u64 f_even(u64 a, u64 b, __int128 v);
     BTF: u64 f_odd(u64 a, __int128 v, u64 b);
     BTF: u64 f_odd_tail(u64 a, __int128 v, u64 b, u64 c, u64 d);
     BTF: u64 f_stack(u64 a, u64 b, u64 c, u64 d, u64 e, u64 f, u64 g, __=
int128 v);
     BTF: u64 f_box(u64 a, struct box s, u64 b);
  Test ./clang_parm_align16.sh passed

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tests/clang_parm_align16.sh | 77 +++++++++++++++++++++++++++++++++++++
 tests/test_lib.sh           |  3 +-
 2 files changed, 78 insertions(+), 2 deletions(-)
 create mode 100755 tests/clang_parm_align16.sh

diff --git a/tests/clang_parm_align16.sh b/tests/clang_parm_align16.sh
new file mode 100755
index 0000000..484aeb6
--- /dev/null
+++ b/tests/clang_parm_align16.sh
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
+title_log "Validation of BTF encoding of over-aligned arguments."
+
+align16=3D"${outdir}/align16"
+CC=3D$(which clang 2>/dev/null)
+
+if [[ -z "$CC" ]]; then
+	info_log "skip: clang not available"
+	test_skip
+fi
+
+arch=3D$(uname -m)
+if [[ "$arch" !=3D "aarch64" ]]; then
+	info_log "skip: test is arm64 only, running on $arch"
+	test_skip
+fi
+
+# arm64 makes an argument whose alignment is 16 start on an even-numbere=
d
+# argument register, so f_odd() passes a in x0, v in x2:x3 -- leaving x1=
 as a
+# hole -- and b in x4.  pahole has to account for that hole, otherwise e=
very
+# parameter after v looks like it is in an unexpected register and the w=
hole
+# function is dropped from BTF.
+cat > ${align16}.c << EOF
+typedef unsigned long long u64;
+struct box { __int128 v; };
+
+__attribute__((noinline)) u64 f_even(u64 a, u64 b, __int128 v)
+{ return a + b + (u64)v; }
+
+__attribute__((noinline)) u64 f_odd(u64 a, __int128 v, u64 b)
+{ return a + b + (u64)v; }
+
+__attribute__((noinline)) u64 f_odd_tail(u64 a, __int128 v, u64 b, u64 c=
, u64 d)
+{ return a + b + c + d + (u64)v; }
+
+__attribute__((noinline)) u64 f_stack(u64 a, u64 b, u64 c, u64 d, u64 e,=
 u64 f,
+				      u64 g, __int128 v)
+{ return a + b + c + d + e + f + g + (u64)v; }
+
+__attribute__((noinline)) u64 f_box(u64 a, struct box s, u64 b)
+{ return a + b + (u64)s.v; }
+
+u64 (*keep[])() =3D { (u64(*)())f_even, (u64(*)())f_odd, (u64(*)())f_odd=
_tail,
+		    (u64(*)())f_stack, (u64(*)())f_box };
+EOF
+
+${CC} -g -O2 -c -o ${align16}.o ${align16}.c 2>/dev/null
+if [[ $? -ne 0 ]]; then
+	info_log "skip: clang could not compile ${align16}.c"
+	test_skip
+fi
+
+LLVM_OBJCOPY=3Dobjcopy pahole -J --btf_features=3Dconsistent_func ${alig=
n16}.o
+if [[ $? -ne 0 ]]; then
+	error_log "Could not encode BTF for ${align16}.o"
+	test_fail
+fi
+
+for fn in f_even f_odd f_odd_tail f_stack f_box; do
+	encoded=3D$(pfunct --all --format_path=3Dbtf ${align16}.o | grep " ${fn=
}(")
+	verbose_log "BTF: $encoded"
+	if [[ -z "$encoded" ]]; then
+		error_log "${fn}() is missing from BTF"
+		test_fail
+	fi
+done
+
+test_pass
diff --git a/tests/test_lib.sh b/tests/test_lib.sh
index e2a7218..e2d0b0c 100755
--- a/tests/test_lib.sh
+++ b/tests/test_lib.sh
@@ -661,8 +661,7 @@ check_bpftool_btf_support()
 cleanup()
 {
 	if [ -n "$outdir" ] && [ -d "$outdir" ]; then
-		rm ${outdir}/*
-		rmdir $outdir
+		rm -rf "$outdir"
 	fi
 	return 0
 }
--=20
2.53.0-Meta

