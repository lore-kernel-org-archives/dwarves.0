Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB13B364EA0
	for <dwarves@vger.kernel.org>; Thu,  5 Mar 2026 22:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772751341; cv=none; b=DqNDBaj4lGqrT9EKR+BIacmUwJJrKkyqq+wydl28BX7yglFyZRRa5WJE/mWXp1EgCGAk5o5i0HtY5/iBtpQitwJ8LaEKiEJ36dcT2EMUZInY17hEXkOtcWtSBLZuJ5+NWw+bClJFKzgAAoU52GPG+8zQejvk+FugOkJca5gNTpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772751341; c=relaxed/simple;
	bh=8KKOOfS17dFmGeTmgnIpvBPRZOoAIN6vB0t5z8H7z5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tAr7zMBEQeCd87ixqr4I88PAU2udejflOvUgdEL1uY7BGg1ykQ1mxNvOwLzN91uMjuJFVW5aqyQAPRqcR9F3o9BcO5pyq7xvRoDCqIMw/TAsmMaBiNi31fkwK0BxJ2dO2mbPDDn39aOtHheBtGpSH7ivkgE0XbG+7cApA5PxojU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 98BA722AAAACB; Thu,  5 Mar 2026 14:55:26 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH dwarves 6/9] dwarf_loader: Detect optimized parameters with locations having constant values
Date: Thu,  5 Mar 2026 14:55:26 -0800
Message-ID: <20260305225526.1155050-1-yonghong.song@linux.dev>
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
 dwarf_loader.c | 50 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 44 insertions(+), 6 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 684115d..712a957 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1197,6 +1197,21 @@ struct func_info {
=20
 #define	PARM_DEFAULT_FAIL	-1
 #define	PARM_FBREG_FAIL		-2
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
@@ -1205,7 +1220,7 @@ struct func_info {
  *   list, return the register; otherwise save register for later return
  * - otherwise if no register was found for locations, return PARM_DEFAU=
LT_FAIL.
  */
-static int parameter__reg(Dwarf_Attribute *attr, int expected_reg)
+static int parameter__reg(Dwarf_Attribute *attr, int expected_reg, struc=
t cu *cu, struct conf_load *conf)
 {
 	Dwarf_Addr base, start, end;
 	Dwarf_Op *expr, *entry_ops;
@@ -1229,8 +1244,17 @@ static int parameter__reg(Dwarf_Attribute *attr, i=
nt expected_reg)
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
@@ -1250,6 +1274,16 @@ static int parameter__reg(Dwarf_Attribute *attr, i=
nt expected_reg)
 			 */
 			ret =3D PARM_FBREG_FAIL;
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
@@ -1338,11 +1372,14 @@ static struct parameter *parameter__new(Dwarf_Die=
 *die, struct cu *cu,
=20
 		if (parm->has_loc) {
 			int expected_reg =3D cu->register_params[reg_idx];
-			int actual_reg =3D parameter__reg(&attr, expected_reg);
+			int actual_reg =3D parameter__reg(&attr, expected_reg, cu, conf);
=20
-			if (actual_reg =3D=3D PARM_DEFAULT_FAIL)
+			if (actual_reg =3D=3D PARM_DEFAULT_FAIL) {
 				parm->optimized =3D 1;
-			else if (actual_reg =3D=3D PARM_FBREG_FAIL || (expected_reg >=3D 0 &&=
 expected_reg !=3D actual_reg))
+			} else if (actual_reg =3D=3D PARM_OPTIMIZED_CLANG) {
+				parm->optimized =3D 1;
+				info->skip_idx++;
+			} else if (actual_reg =3D=3D PARM_FBREG_FAIL || (expected_reg >=3D 0 =
&& expected_reg !=3D actual_reg)) {
 				/* mark parameters that use an unexpected
 				 * register to hold a parameter; these will
 				 * be problematic for users of BTF as they
@@ -1350,6 +1387,7 @@ static struct parameter *parameter__new(Dwarf_Die *=
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

