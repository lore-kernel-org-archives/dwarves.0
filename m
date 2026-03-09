Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6403D7D70
	for <dwarves@vger.kernel.org>; Mon,  9 Mar 2026 15:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773070388; cv=none; b=A9KW2xeOGkhFPW2z4Lsp8F/XSNeqwXlH7ydnaxmhA+0x7UC1y8DbxeiXVgrohgWNn9DPYgZm84lJwrtrJiG6ytFrvWzUDx2WUuysbmKQTFkrE0Uo7FWYX09Z8icKsJMrSMXSO3xuDBOJ7QgCtcmc7lpIKaqG+va8bzBHuh7AwxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773070388; c=relaxed/simple;
	bh=/NYyKJ/znz5iVqzlhQX+dO5u/cdCKi+gBsXSRCjo+uY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nU1IG2SuVVb9khvoRvrzHE/28fUNFigaXdkLb8PRMggMoospqodYRp+F1u8PoxoeKCr6wqiAnQQmcsGN2kcpHCJs3TfAb3x5apRuOu6CMK7ALJEeaLA/hK0kRWI+GUG795CBNrk65pYGJcO7o1Qj837WdWKQs6cttSI7Ki+Z/6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id AE65B24944411; Mon,  9 Mar 2026 08:32:56 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH dwarves v2 8/9] btf_encoder: Handle optimized parameter properly
Date: Mon,  9 Mar 2026 08:32:56 -0700
Message-ID: <20260309153256.1921729-1-yonghong.song@linux.dev>
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

Ensure to skip optimized parameter so btf can generate
proper true signatures.

In the first patch of the patch set, with DW_CC_nocall filtering, 875 fun=
ctions
have signature changed. With a series of improvement, eventually only 17 =
functions
remain and unfortunately these functions cannot be converted to true sign=
atures
due to locations. For example,

0x0242f1f7:   DW_TAG_subprogram
                DW_AT_name      ("memblock_find_in_range")
                DW_AT_calling_convention        (DW_CC_nocall)
                DW_AT_type      (0x0242decc "phys_addr_t")
                ...

0x0242f22e:     DW_TAG_formal_parameter
                  DW_AT_location        (indexed (0x14a) loclist =3D 0x00=
5595bc:
                     [0xffffffff87a000f9, 0xffffffff87a00178): DW_OP_reg5=
 RDI
                     [0xffffffff87a00178, 0xffffffff87a001be): DW_OP_reg1=
4 R14
                     [0xffffffff87a001be, 0xffffffff87a001c7): DW_OP_entr=
y_value(DW_OP_reg5 RDI), DW_OP_stack_value
                     [0xffffffff87a001c7, 0xffffffff87a00214): DW_OP_reg1=
4 R14)
                  DW_AT_name    ("start")
                  DW_AT_type    (0x0242decc "phys_addr_t")
                  ...

0x0242f239:     DW_TAG_formal_parameter
                  DW_AT_location        (indexed (0x14b) loclist =3D 0x00=
5595e6:
                     [0xffffffff87a000f9, 0xffffffff87a00175): DW_OP_reg4=
 RSI
                     [0xffffffff87a00175, 0xffffffff87a001b8): DW_OP_reg3=
 RBX
                     [0xffffffff87a001b8, 0xffffffff87a001c7): DW_OP_entr=
y_value(DW_OP_reg4 RSI), DW_OP_stack_value
                     [0xffffffff87a001c7, 0xffffffff87a00214): DW_OP_reg3=
 RBX)
                  DW_AT_name    ("end")
                  DW_AT_type    (0x0242decc "phys_addr_t")
                  ...

0x0242f245:     DW_TAG_formal_parameter
                  DW_AT_location        (indexed (0x14c) loclist =3D 0x00=
559610:
                     [0xffffffff87a001e3, 0xffffffff87a001ef): DW_OP_breg=
4 RSI+0)
                  DW_AT_name    ("size")
                  DW_AT_type    (0x0242decc "phys_addr_t")
                  ...

0x0242f250:     DW_TAG_formal_parameter
                  DW_AT_const_value     (4096)
                  DW_AT_name    ("align")
                  DW_AT_type    (0x0242decc "phys_addr_t")
                  ...

The third parameter 'size' is not from RDX. Hence, true signature is not =
possible for this function.

I also did some experiments on arm64. The number of signature-changed fun=
citons
is 863 and finally there are 79 functions cannot be converted to true sig=
natures.
Through dwarf comparison of x86_64 vs. arm64, llvm arm64 backend looks li=
ke having
more relaxation to compute parameter values for those signature-changed f=
unctions.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 btf_encoder.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index aa7cd1c..0cd4124 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1257,15 +1257,21 @@ static int32_t btf_encoder__save_func(struct btf_=
encoder *encoder, struct functi
 	struct btf *btf =3D encoder->btf;
 	struct llvm_annotation *annot;
 	struct parameter *param;
-	uint8_t param_idx =3D 0;
+	uint8_t param_idx =3D 0, skip_idx =3D 0;
 	int str_off, err =3D 0;
=20
 	if (!state)
 		return -ENOMEM;
=20
+	if (encoder->cu->producer_clang) {
+		ftype__for_each_parameter(ftype, param) {
+			if (param->optimized) skip_idx++;
+		}
+	}
+
 	state->addr =3D function__addr(fn);
 	state->elf =3D func;
-	state->nr_parms =3D ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
+	state->nr_parms =3D ftype->nr_parms - skip_idx + (ftype->unspec_parms ?=
 1 : 0);
 	state->ret_type_id =3D ftype->tag.type =3D=3D 0 ? 0 : encoder->type_id_=
off + ftype->tag.type;
 	if (state->nr_parms > 0) {
 		state->parms =3D zalloc(state->nr_parms * sizeof(*state->parms));
@@ -1303,6 +1309,9 @@ static int32_t btf_encoder__save_func(struct btf_en=
coder *encoder, struct functi
 			state->nr_parms--;
 			continue;
 		}
+		if (encoder->cu->producer_clang && param->optimized)
+			continue;
+
 		name =3D parameter__name(param) ?: "";
 		str_off =3D btf__add_str(btf, name);
 		if (str_off < 0) {
--=20
2.47.3

