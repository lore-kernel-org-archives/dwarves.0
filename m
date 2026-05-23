Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5783A322533
	for <dwarves@vger.kernel.org>; Sat, 23 May 2026 16:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779555482; cv=none; b=Jr51XZFx2FThz+kycY8GE9KNybc/R1Vvr+fvmaaWGQ4vqJQFDR0IQplC79qKyvpf4dh+S6/vAjCyj3bbwZqsH5F7uBzBLSp9jg4OBY5rtgewCUy9UTrRSQ4lJEf1PN6siENLF0BwbodmesANrGYB8f+gS+XBNnXyIPYkQzLpuNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779555482; c=relaxed/simple;
	bh=CBtfFnnEhI+PT8qRA8NQ5J7NMzNvL8giHu49pFLV4T4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZxQe3utUEomrLMyGvJCopeiJzuQnK6uhgS3v1X1k9SR9DODezG0YXmtP9NFmFHr/DJK662v+LguYs8oyICVDNtFuZcaOcCL5nuIDsGlcEnj0kNtbVpFZedgdRilVwEsxdL7MffAQaGtFZOh2txRugNOChZ56W30k5ZAoCSYGx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 25B9DEE9015EA; Sat, 23 May 2026 09:57:50 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH dwarves v5 07/11] dwarf_loader: Detect optimized parameters with locations having constant values
Date: Sat, 23 May 2026 09:57:50 -0700
Message-ID: <20260523165750.1228272-1-yonghong.song@linux.dev>
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

The following is an example:

0x00899a78:   DW_TAG_subprogram
                DW_AT_calling_convention        (DW_CC_nocall)
                DW_AT_type      (0x008861cb "int")
                ...

0x00899a8c:     DW_TAG_formal_parameter
                  DW_AT_location        (indexed (0x3e) loclist =3D 0x000=
b2195:
                     [0xffffffff879be485, 0xffffffff879be49a): DW_OP_reg5=
 RDI
                     [0xffffffff879be49a, 0xffffffff879beac4): DW_OP_breg=
7 RSP+0)
                  DW_AT_name    ("mr")
                  DW_AT_type    (0x00899c88 "map_range *")
                  ...

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
                  DW_AT_type    (0x008861cb "int")
                  ...

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
                  DW_AT_type    (0x008861cf "unsigned long")
                  ...

0x00899ab0:     DW_TAG_formal_parameter
                  DW_AT_location        (indexed (0x40) loclist =3D 0x000=
b21c2:
                     [0xffffffff879be485, 0xffffffff879be4a9): DW_OP_reg1=
 RDX
                     [0xffffffff879be4a9, 0xffffffff879beac4): DW_OP_breg=
7 RSP+32)
                  DW_AT_name    ("end")
                  DW_AT_type    (0x008861cf "unsigned long")
                  ...

The parameter 'nr_range' is a constant and won't consume any ABI register=
.
With this commit, for x86_64, the number of invalid true signature reduce=
d from 96
to 83.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 dwarf_loader.c | 47 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 4 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 4b65e30..97f576a 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1192,6 +1192,8 @@ static ptrdiff_t __dwarf_getlocations(Dwarf_Attribu=
te *attr,
=20
 #define	PARM_DEFAULT_FAIL	-1
 #define	PARM_UNEXPECTED		-2
+#define	PARM_OPTIMIZED_OUT	-3
+#define	PARM_CONTINUE		-4
=20
 /* Max 20 register parameters, considering some parameters may be optimi=
zed out.  */
 #define	MAX_PRESCAN_PARAMS	20
@@ -1279,6 +1281,20 @@ static int parameter__peek_first_reg(Dwarf_Die *di=
e)
 	return -1;
 }
=20
+static int parameter__multi_exprs(Dwarf_Op *expr, int loc_num)
+{
+	switch (expr[0].atom) {
+	case DW_OP_lit0 ... DW_OP_lit31:
+	case DW_OP_constu:
+	case DW_OP_consts:
+		if (loc_num !=3D 0)
+			break;
+		return PARM_OPTIMIZED_OUT;
+	}
+
+	return PARM_CONTINUE;
+}
+
 /* For DW_AT_location 'attr':
  * - if first location is DW_OP_regXX with expected number, return the r=
egister;
  *   otherwise save the register for later return
@@ -1311,8 +1327,17 @@ static int parameter__reg(Dwarf_Attribute *attr, i=
nt expected_reg, struct conf_l
 		if (exprlen =3D=3D 2 && expr[exprlen - 1].atom =3D=3D DW_OP_stack_valu=
e)
 			exprlen--;
=20
-		if (exprlen !=3D 1)
-			continue;
+		if (exprlen !=3D 1) {
+			if (!info->signature_changed || !conf->true_signature)
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
@@ -1333,6 +1358,16 @@ static int parameter__reg(Dwarf_Attribute *attr, i=
nt expected_reg, struct conf_l
 			if (info->signature_changed && conf->true_signature)
 				ret =3D PARM_UNEXPECTED;
 			break;
+		case DW_OP_lit0 ... DW_OP_lit31:
+		case DW_OP_constu:
+		case DW_OP_consts:
+			if (info->signature_changed && conf->true_signature) {
+				if (loc_num !=3D 0)
+					break;
+				ret =3D PARM_OPTIMIZED_OUT;
+				goto out;
+			}
+			break;
 		/* match DW_OP_entry_value(DW_OP_regXX) at any location */
 		case DW_OP_entry_value:
 		case DW_OP_GNU_entry_value:
@@ -1417,9 +1452,12 @@ static struct parameter *parameter__new(Dwarf_Die =
*die, struct cu *cu,
 			int expected_reg =3D cu->register_params[reg_idx];
 			int actual_reg =3D parameter__reg(&attr, expected_reg, conf, info);
=20
-			if (actual_reg =3D=3D PARM_DEFAULT_FAIL)
+			if (actual_reg =3D=3D PARM_DEFAULT_FAIL) {
 				parm->optimized =3D 1;
-			else if (actual_reg =3D=3D PARM_UNEXPECTED || (expected_reg >=3D 0 &&=
 expected_reg !=3D actual_reg))
+			} else if (actual_reg =3D=3D PARM_OPTIMIZED_OUT) {
+				parm->optimized =3D 1;
+				info->skip_idx++;
+			} else if (actual_reg =3D=3D PARM_UNEXPECTED || (expected_reg >=3D 0 =
&& expected_reg !=3D actual_reg)) {
 				/* mark parameters that use an unexpected
 				 * register to hold a parameter; these will
 				 * be problematic for users of BTF as they
@@ -1427,6 +1465,7 @@ static struct parameter *parameter__new(Dwarf_Die *=
die, struct cu *cu,
 				 * contents.
 				 */
 				parm->unexpected_reg =3D 1;
+			}
 		} else if (has_const_value && !cu->producer_clang) {
 			parm->optimized =3D 1;
 		} else if (true_sig_enabled) {
--=20
2.53.0-Meta

