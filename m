Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD18364EA9
	for <dwarves@vger.kernel.org>; Thu,  5 Mar 2026 22:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772751347; cv=none; b=i/ddfkvQj8st3qGleTQJdKBuQdMuW766sjZwRljiCMwvqKVsqXzn3MDmig26OziCN9iAHN651zeLlSk3PXpdioZm6zO+jNrzS223zZyx/vWwqBZGTX24KwVEjKdJHDG9GGSvdJyTR7SxgVpxbECrlqY52rae4o6uVWWmYWRllQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772751347; c=relaxed/simple;
	bh=IjFsW7AdU+Tl6SOIJmkItRKzouu0hO10JONVs7xxr24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pb8kNti73yqQZJQ6Y2LYLOFAy3Xz+owjVLW+7JONwW39BRVR8WMh0C7TWuCCIvTb+ZccEkcQC4ldyzxpU151mOcNUVNmpQ1Kf5/2ZhEul32LVmRc4D+R7j70ZXQBCvXET1kJGb3TUDTILFu9D5ZnneKnfaruzjuvjaWFh5kw6ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id DCC1322AAAB1E; Thu,  5 Mar 2026 14:55:36 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH dwarves 8/9] btf_encoder: Handle optimized parameter properly
Date: Thu,  5 Mar 2026 14:55:36 -0800
Message-ID: <20260305225536.1156659-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260305225455.1151066-1-yonghong.song@linux.dev>
References: <20260305225455.1151066-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Ensure to skip optimized parameter so btf can generate
proper true signatures.

In the first patch of the patch set, with DW_CC_nocall filtering, 379 fun=
ctions
have signature changed but not checked properly. With a series of improve=
ment,
eventually only 17 functions remain and unfortunately these functions can=
not
be converted to true signatures due to locations. For example,

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

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 btf_encoder.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index aa7cd1c..738a4cc 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1257,15 +1257,19 @@ static int32_t btf_encoder__save_func(struct btf_=
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
+	ftype__for_each_parameter(ftype, param) {
+		if (param->optimized) skip_idx++;
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
@@ -1303,6 +1307,9 @@ static int32_t btf_encoder__save_func(struct btf_en=
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

