Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBF13D9057
	for <dwarves@vger.kernel.org>; Mon,  9 Mar 2026 15:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773070380; cv=none; b=ECPJrOslNehorPW8xBV1mJdFJwuF3qVksUbz9KJoBqISYBLASe4QGxyAHPrpc/j5Tza6DogNvm3gLIvupgJ8EFElMRJbL4ua71EeofhqbLUUOnqUTYgbM/Y06ZbP1gW9vEuOlHlQ9ClKmaC3JR1DHWQv9tB3lkHF9iDv0Lco8n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773070380; c=relaxed/simple;
	bh=DMWHyWBHb4gROFJOSBlO1kGYa1pWv9GbezvLVa5Hjq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5B+k5x4IBzeIR4wUczNb+tQWkEI3Epk4ioLPMmt1x1LTMhPBdvQqWFOVnmpbTJQ5BKR/jqhd9inKg4T2Pr9ydyGz8nrBKSft6MAcDI22OGJCkiR8x027fYfEIaEmgrdJnI/Fb+trqCQScXQM07T4Seqse0DKhCY4btsuNn4m5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 6C4C0249443C3; Mon,  9 Mar 2026 08:32:46 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH dwarves v2 6/9] dwarf_loader: Detect optimized parameters with locations having constant values
Date: Mon,  9 Mar 2026 08:32:46 -0700
Message-ID: <20260309153246.1920523-1-yonghong.song@linux.dev>
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

The following is an example:

0x00899a78:   DW_TAG_subprogram
                DW_AT_low_pc    (0xffffffff879be480)
                DW_AT_high_pc   (0xffffffff879beac4)
                DW_AT_frame_base        (DW_OP_reg7 RSP)
                DW_AT_call_all_calls    (true)
                DW_AT_name      ("split_mem_range")
                DW_AT_decl_file ("/home/yhs/work/bpf-next/arch/x86/mm/ini=
t.c")
                DW_AT_decl_line (401)
                DW_AT_prototyped        (true)
                DW_AT_calling_convention        (DW_CC_nocall)
                DW_AT_type      (0x008861cb "int")

0x00899a8c:     DW_TAG_formal_parameter
                  DW_AT_location        (indexed (0x3e) loclist =3D 0x000=
b2195:
                     [0xffffffff879be485, 0xffffffff879be49a): DW_OP_reg5=
 RDI
                     [0xffffffff879be49a, 0xffffffff879beac4): DW_OP_breg=
7 RSP+0)
                  DW_AT_name    ("mr")
                  DW_AT_decl_file       ("/home/yhs/work/bpf-next/arch/x8=
6/mm/init.c")
                  DW_AT_decl_line       (401)
                  DW_AT_type    (0x00899c88 "map_range *")

0x00899a98:     DW_TAG_formal_parameter
                  DW_AT_location        (indexed (0x41) loclist =3D 0x000=
b21d4:
                     [0xffffffff879be480, 0xffffffff879be554): DW_OP_cons=
ts +0, DW_OP_stack_value
                     [0xffffffff879be554, 0xffffffff879be56d): DW_OP_cons=
ts +1, DW_OP_stack_value
                     [0xffffffff879be56d, 0xffffffff879be572): DW_OP_reg2=
 RCX
                     [0xffffffff879be572, 0xffffffff879be638): DW_OP_breg=
7 RSP+8
                     [0xffffffff879be638, 0xffffffff879be63d): DW_OP_reg0=
 RAX
                     [0xffffffff879be63d, 0xffffffff879be6ef): DW_OP_breg=
7 RSP+8
                     [0xffffffff879be6ef, 0xffffffff879be6f5): DW_OP_reg1=
4 R14
                     [0xffffffff879be6f5, 0xffffffff879be6fd): DW_OP_breg=
7 RSP+8
                     [0xffffffff879be6fd, 0xffffffff879be879): DW_OP_reg1=
4 R14
                     [0xffffffff879be879, 0xffffffff879be931): DW_OP_reg1=
2 R12
                     [0xffffffff879be955, 0xffffffff879be961): DW_OP_reg1=
4 R14
                     [0xffffffff879be961, 0xffffffff879be966): DW_OP_reg1=
2 R12
                     [0xffffffff879be966, 0xffffffff879be976): DW_OP_reg1=
4 R14
                     [0xffffffff879be976, 0xffffffff879be9df): DW_OP_reg1=
2 R12
                     [0xffffffff879be9df, 0xffffffff879be9e5): DW_OP_reg1=
4 R14
                     [0xffffffff879be9fc, 0xffffffff879bea24): DW_OP_cons=
ts +0, DW_OP_stack_value
                     [0xffffffff879bea24, 0xffffffff879bea74): DW_OP_breg=
7 RSP+8
                     [0xffffffff879bea74, 0xffffffff879beac4): DW_OP_reg1=
4 R14)
                  DW_AT_name    ("nr_range")
                  DW_AT_decl_file       ("/home/yhs/work/bpf-next/arch/x8=
6/mm/init.c")
                  DW_AT_decl_line       (401)
                  DW_AT_type    (0x008861cb "int")

0x00899aa4:     DW_TAG_formal_parameter
                  DW_AT_location        (indexed (0x3f) loclist =3D 0x000=
b21a7:
                     [0xffffffff879be485, 0xffffffff879be4a4): DW_OP_reg4=
 RSI
                     [0xffffffff879be4a4, 0xffffffff879be4e6): DW_OP_reg1=
2 R12
                     [0xffffffff879be4e6, 0xffffffff879beac4): DW_OP_entr=
y_value(DW_OP_reg4 RSI), DW_OP_stack_value)
                  DW_AT_name    ("start")
                  DW_AT_decl_file       ("/home/yhs/work/bpf-next/arch/x8=
6/mm/init.c")
                  DW_AT_decl_line       (402)
                  DW_AT_type    (0x008861cf "unsigned long")

0x00899ab0:     DW_TAG_formal_parameter
                  DW_AT_location        (indexed (0x40) loclist =3D 0x000=
b21c2:
                     [0xffffffff879be485, 0xffffffff879be4a9): DW_OP_reg1=
 RDX
                     [0xffffffff879be4a9, 0xffffffff879beac4): DW_OP_breg=
7 RSP+32)
                  DW_AT_name    ("end")
                  DW_AT_decl_file       ("/home/yhs/work/bpf-next/arch/x8=
6/mm/init.c")
                  DW_AT_decl_line       (403)
                  DW_AT_type    (0x008861cf "unsigned long")

The parameter 'nr_range' is a constant and won't consume any ABI register=
.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 dwarf_loader.c | 46 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 2237e20..aa1f967 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1197,6 +1197,21 @@ struct func_info {
=20
 #define	PARM_DEFAULT_FAIL	-1
 #define	PARM_FAIL_CLANG		-2
+#define	PARM_OPTIMIZED_CLANG	-3
+#define	PARM_CONTINUE		-4
+
+static int parameter__multi_exprs(Dwarf_Op *expr, int loc_num) {
+	switch (expr[0].atom) {
+	case DW_OP_lit0 ... DW_OP_lit31:
+	case DW_OP_constu:
+	case DW_OP_consts:
+		if (loc_num !=3D 0)
+			break;
+		return PARM_OPTIMIZED_CLANG;
+	}
+
+	return PARM_CONTINUE;
+}
=20
 /* For DW_AT_location 'attr':
  * - if first location is DW_OP_regXX with expected number, return the r=
egister;
@@ -1229,8 +1244,17 @@ static int parameter__reg(Dwarf_Attribute *attr, i=
nt expected_reg, struct cu *cu
 		if (exprlen =3D=3D 2 && expr[exprlen - 1].atom =3D=3D DW_OP_stack_valu=
e)
 			exprlen--;
=20
-		if (exprlen !=3D 1)
-			continue;
+		if (exprlen !=3D 1) {
+			if (!cu->producer_clang || !conf->true_signature)
+				continue;
+
+			int res;
+			res =3D parameter__multi_exprs(expr, loc_num);
+			if (res =3D=3D PARM_CONTINUE)
+				continue;
+			ret =3D res;
+			goto out;
+		}
=20
 		switch (expr->atom) {
 		/* match DW_OP_regXX at first location */
@@ -1251,6 +1275,16 @@ static int parameter__reg(Dwarf_Attribute *attr, i=
nt expected_reg, struct cu *cu
 			if (cu->producer_clang && conf->true_signature)
 				ret =3D PARM_FAIL_CLANG;
 			break;
+		case DW_OP_lit0 ... DW_OP_lit31:
+		case DW_OP_constu:
+		case DW_OP_consts:
+			if (cu->producer_clang && conf->true_signature) {
+				if (loc_num !=3D 0)
+					break;
+				ret =3D PARM_OPTIMIZED_CLANG;
+				goto out;
+			}
+			break;
 		/* match DW_OP_entry_value(DW_OP_regXX) at any location */
 		case DW_OP_entry_value:
 		case DW_OP_GNU_entry_value:
@@ -1341,9 +1375,12 @@ static struct parameter *parameter__new(Dwarf_Die =
*die, struct cu *cu,
 			int expected_reg =3D cu->register_params[reg_idx];
 			int actual_reg =3D parameter__reg(&attr, expected_reg, cu, conf);
=20
-			if (actual_reg =3D=3D PARM_DEFAULT_FAIL)
+			if (actual_reg =3D=3D PARM_DEFAULT_FAIL) {
 				parm->optimized =3D 1;
-			else if (actual_reg =3D=3D PARM_FAIL_CLANG || (expected_reg >=3D 0 &&=
 expected_reg !=3D actual_reg))
+			} else if (actual_reg =3D=3D PARM_OPTIMIZED_CLANG) {
+				parm->optimized =3D 1;
+				info->skip_idx++;
+			} else if (actual_reg =3D=3D PARM_FAIL_CLANG || (expected_reg >=3D 0 =
&& expected_reg !=3D actual_reg)) {
 				/* mark parameters that use an unexpected
 				 * register to hold a parameter; these will
 				 * be problematic for users of BTF as they
@@ -1351,6 +1388,7 @@ static struct parameter *parameter__new(Dwarf_Die *=
die, struct cu *cu,
 				 * contents.
 				 */
 				parm->unexpected_reg =3D 1;
+			}
 		} else if (!cu->producer_clang && has_const_value) {
 			parm->optimized =3D 1;
 		} else if (cu->producer_clang) {
--=20
2.47.3

