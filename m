Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775FD2DAFCC
	for <dwarves@vger.kernel.org>; Fri, 16 Jan 2026 02:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768528944; cv=none; b=HzdOozX4irlniH7TYYG2ne1Eua8wHC1CrFVLjvL7uTIOfsnEWPZcS5hteNqBR04CqYGx66J9I2ouYEHnL4x6aFVO2124HyQDXDTjjsdgdzi2PedJMa6ZZuzOYO3Qvnat0YJsDoGDtcSev4qzeq5Q9GwcflSuKwk+y3Q7Fddd9yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768528944; c=relaxed/simple;
	bh=Wc3XvXywJzwVYP+XZC6pwVX3H0F1qYYV+ilcHJlGSis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dBu+Wy1dXpRMbjgnfjM6hLdf2MuEO/OvM+EIT575RTjoQITel+HcAEqUkC5/ILzIm99QRQWNkpxSm1PnNhb2BOiLi7C6VKV9p+Xm0n26BAJ5zhXdoX/YVCppWzqMGUTWMV/Gg8yEw9SzhyNK6zFMv2PySuWvIS9Wl2cVnck7E80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 774D918F574C2; Thu, 15 Jan 2026 18:02:06 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next v2] bpf_encoder: Fix a verbose output issue
Date: Thu, 15 Jan 2026 18:02:06 -0800
Message-ID: <20260116020206.2154622-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For the following test.c:
  $ cat test.c
  unsigned tar(int a);
  __attribute__((noinline)) static int foo(int a, int b)
  {
    return tar(a) + tar(a + 1);
  }
  __attribute__((noinline)) int bar(int a)
  {
    foo(a, 1);
    return 0;
  }
The llvm compilation:
  $ clang -O2 -g -c test.c
And then
  $ pahole -JV test.o
  btf_encoder__new: 'test.o' doesn't have '.data..percpu' sectio  n
  File test.o:
  [1] INT unsigned int size=3D4 nr_bits=3D32 encoding=3D(none)
  [2] INT int size=3D4 nr_bits=3D32 encoding=3DSIGNED
  search cu 'test.c' for percpu global variables.
  [3] FUNC_PROTO (anon) return=3D2 args=3D(2 a, [4] FUNC bar type_id=3D3
  [5] FUNC_PROTO (anon) return=3D2 args=3D(2 a, 2 b, [6] FUNC foo type_id=
=3D5

The above confused format is due to btf_encoder__add_func_proto_for_state=
().
The "is_last =3D param_idx =3D=3D nr_params" is always false since param_=
idx
starts from 0. The below change fixed the issue:
  is_last =3D param_idx =3D=3D (nr_params - 1)

With the fix, 'pahole -JV test.o' will produce the following:
  ...
  [3] FUNC_PROTO (anon) return=3D2 args=3D(2 a)
  [4] FUNC bar type_id=3D3
  [5] FUNC_PROTO (anon) return=3D2 args=3D(2 a, 2 b)
  [6] FUNC foo type_id=3D5
  ...

In addition, in btf_encoder__add_func_proto_for_ftype(), we have
  ++param_idx;
  if (ftype->unspec_parms) { ... }
This is correct but it is misleading since '++param_idx' is only needed
inside the above 'if' condition. So put '++param_idx' inside the
'if' condition to make code cleaner.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 btf_encoder.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index b37ee7f..ec6933e 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -865,10 +865,11 @@ static int32_t btf_encoder__add_func_proto_for_ftyp=
e(struct btf_encoder *encoder
 			return -1;
 	}
=20
-	++param_idx;
-	if (ftype->unspec_parms)
+	if (ftype->unspec_parms) {
+		++param_idx;
 		if (btf_encoder__add_func_param(encoder, NULL, 0, param_idx =3D=3D nr_=
params))
 			return -1;
+	}
=20
 	return id;
 }
@@ -895,7 +896,7 @@ static int32_t btf_encoder__add_func_proto_for_state(=
struct btf_encoder *encoder
 	for (param_idx =3D 0; param_idx < nr_params; param_idx++) {
 		p =3D &state->parms[param_idx];
 		name =3D btf__name_by_offset(btf, p->name_off);
-		is_last =3D param_idx =3D=3D nr_params;
+		is_last =3D param_idx =3D=3D (nr_params - 1);
=20
 		/* adding BTF data may result in a move of the
 		 * name string memory, so make a temporary copy.
--=20
2.47.3

