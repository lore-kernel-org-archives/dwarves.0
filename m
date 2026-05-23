Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A41A31F99F
	for <dwarves@vger.kernel.org>; Sat, 23 May 2026 16:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779555452; cv=none; b=eDruEpGb2xBo1Dxd6cHyIUhOJMLRuwuj06aDuwEcPE8VrBbos28fxcjFZpGi0LzzFXtiSeuFyFCVtBsNXXM9RnO126HAASoWNflfa2O51ug9HhKi+gL6SHCfaWsCt3yd7MIM4vFrYkmQQEaDJB5iscCC2hMXtIG8qbdoYdg4rao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779555452; c=relaxed/simple;
	bh=38VxHEj8Gb5MV9dJ6kc2F8jflzlrfQdq6u2Gl6ZjjsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ndrlye5NHxbtiMsQYmdIsFBqElCHWd7oF0ahjqMgw1EegVfVKcdLpqRO6ZK+kVR+rURaK+OrV9saNrfl0Q23FrnGqi4Fj4zSr5XOF7ua8G+oPcvYfV6d6wepS3t/aIAUJZqHrteRhgLHg2k9PiwQVMn7ufxpdZkGND8O+BOl62U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 32CA4EE8FB96E; Sat, 23 May 2026 09:57:28 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH dwarves v5 03/11] dwarf_loader: Handle signatures with dead arguments
Date: Sat, 23 May 2026 09:57:28 -0700
Message-ID: <20260523165728.1226989-1-yonghong.song@linux.dev>
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

For llvm dwarf, the dead argument may be in the middle of
DW_TAG_subprogram. So we introduce skip_idx in order to
match expected registers properly.

For example:
  0x00042897:   DW_TAG_subprogram
                  DW_AT_name      ("create_dev")
                  DW_AT_calling_convention        (DW_CC_nocall)
                  DW_AT_type      (0x0002429a "int")
                  ...

  0x000428ab:     DW_TAG_formal_parameter
                    DW_AT_name    ("name")
                    DW_AT_type    (0x000242ed "char *")
                    ...

  0x000428b5:     DW_TAG_formal_parameter
                    DW_AT_location        (indexed (0x3f) loclist =3D 0x0=
00027f8:
                       [0xffffffff87681370, 0xffffffff8768137a): DW_OP_re=
g5 RDI
                       [0xffffffff8768137a, 0xffffffff87681392): DW_OP_re=
g3 RBX
                       [0xffffffff87681392, 0xffffffff876813ae): DW_OP_en=
try_value(DW_OP_reg5 RDI), DW_OP_stack_value)
                    DW_AT_name    ("dev")
                    DW_AT_type    (0x00026859 "dev_t")
                    ...

With skip_idx, we can identify that the second original argument
'dev' becomes the first one after optimization.

The previous patch has the following:
  0x0533fd03:   DW_TAG_subprogram
                  DW_AT_name      ("acpi_irq_penalty_update")
                  DW_AT_calling_convention        (DW_CC_nocall)
                  DW_AT_type      (0x05334dc7 "int")
                  ...

  0x0533fd15:     DW_TAG_formal_parameter
                    DW_AT_name    ("str")
                    DW_AT_type    (0x05335918 "char *")
                    ...

  0x0533fd1f:     DW_TAG_formal_parameter
                    DW_AT_location        (indexed (0x3b) loclist =3D 0x0=
0eb9d83:
                       [0xffff80008419f2e0, 0xffff80008419f324): DW_OP_re=
g1 W1
                       [0xffff80008419f324, 0xffff80008419f47c): DW_OP_re=
g19 W19
                       [0xffff80008419f47c, 0xffff80008419f494): DW_OP_en=
try_value(DW_OP_reg1 W1), DW_OP_stack_value
                       [0xffff80008419f494, 0xffff80008419f498): DW_OP_re=
g19 W19)
                    DW_AT_name    ("used")
                    DW_AT_type    (0x05334dc7 "int")
                    ...

It is also handled properly with parameter 'str' will have W0 register.

With this patch, I checked x86_64 that the number of invalid true signatu=
res is reduced
from 532 to 96. This suggests that majority of optimized functions are ca=
used by
dead arguments.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 dwarf_loader.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 88 insertions(+), 5 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index f0ac699..49993ee 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1195,10 +1195,62 @@ static ptrdiff_t __dwarf_getlocations(Dwarf_Attri=
bute *attr,
=20
 struct func_info {
 	bool signature_changed;
+	int skip_idx;
 	int nr_params;
 	int param_start_regs[MAX_PRESCAN_PARAMS];
 };
=20
+static int __get_type_byte_size(Dwarf_Die *die, struct cu *cu)
+{
+	Dwarf_Attribute attr;
+	if (dwarf_attr(die, DW_AT_type, &attr) =3D=3D NULL)
+		return 0;
+
+	Dwarf_Die type_die;
+	if (dwarf_formref_die(&attr, &type_die) =3D=3D NULL)
+		return 0;
+
+	/* A type does not have byte_size.
+	 * 0x000dac83: DW_TAG_formal_parameter
+			 DW_AT_location        (indexed (0x385) loclist =3D 0x00016175:
+			   [0xffff800080098cb0, 0xffff800080098cb4): DW_OP_breg8 W8+0
+			   [0xffff800080098cb4, 0xffff800080098ff4): DW_OP_breg31 WSP+16, DW_=
OP_deref
+			   [0xffff800080099054, 0xffff80008009908c): DW_OP_breg31 WSP+16, DW_=
OP_deref)
+			 DW_AT_name    ("ubuf")
+			 DW_AT_decl_file       ("/home/yhs/work/bpf-next/arch/arm64/kernel/pt=
race.c")
+			 DW_AT_decl_line       (886)
+			 DW_AT_type    (0x000d467e "const void *")
+
+	  * 0x000d467e: DW_TAG_pointer_type
+			  DW_AT_type      (0x000c4320 "const void")
+
+	  * 0x000c4320: DW_TAG_const_type
+	  */
+	if (dwarf_tag(&type_die) =3D=3D DW_TAG_pointer_type)
+		return cu->addr_size;
+
+	uint64_t bsize =3D attr_numeric(&type_die, DW_AT_byte_size);
+	if (bsize =3D=3D 0)
+		return __get_type_byte_size(&type_die, cu);
+
+	return bsize;
+}
+
+static int get_type_byte_size(Dwarf_Die *die, struct cu *cu)
+{
+	int byte_size =3D 0;
+
+	Dwarf_Attribute attr;
+	if (dwarf_attr(die, DW_AT_abstract_origin, &attr)) {
+		Dwarf_Die origin;
+		if (dwarf_formref_die(&attr, &origin))
+			byte_size =3D __get_type_byte_size(&origin, cu);
+	} else {
+		byte_size =3D __get_type_byte_size(die, cu);
+	}
+	return byte_size;
+}
+
 /* Get the first DW_OP_X (should be a register) from a parameter's DW_AT=
_location. */
 static int parameter__peek_first_reg(Dwarf_Die *die)
 {
@@ -1292,8 +1344,9 @@ static struct parameter *parameter__new(Dwarf_Die *=
die, struct cu *cu,
 	struct parameter *parm =3D tag__alloc(cu, sizeof(*parm));
=20
 	if (parm !=3D NULL) {
-		bool has_const_value;
+		bool has_const_value, true_sig_enabled;
 		Dwarf_Attribute attr;
+		int reg_idx;
=20
 		tag__init(&parm->tag, cu, die);
 		parm->name =3D attr_string(die, DW_AT_name, conf);
@@ -1303,8 +1356,10 @@ static struct parameter *parameter__new(Dwarf_Die =
*die, struct cu *cu,
 		if (!info->signature_changed) {
 			if (cu->producer_clang || param_idx >=3D cu->nr_register_params)
 				return parm;
-		} else if (param_idx >=3D cu->nr_register_params) {
-			return parm;
+		} else {
+			reg_idx =3D param_idx - info->skip_idx;
+			if (reg_idx >=3D cu->nr_register_params)
+				return parm;
 		}
=20
 		/* Parameters which use DW_AT_abstract_origin to point at
@@ -1342,9 +1397,10 @@ static struct parameter *parameter__new(Dwarf_Die =
*die, struct cu *cu,
 		 */
 		has_const_value =3D dwarf_attr(die, DW_AT_const_value, &attr) !=3D NUL=
L;
 		parm->has_loc =3D dwarf_attr(die, DW_AT_location, &attr) !=3D NULL;
+		true_sig_enabled =3D conf->true_signature && info->signature_changed;
=20
 		if (parm->has_loc) {
-			int expected_reg =3D cu->register_params[param_idx];
+			int expected_reg =3D cu->register_params[reg_idx];
 			int actual_reg =3D parameter__reg(&attr, expected_reg);
=20
 			if (actual_reg < 0)
@@ -1357,8 +1413,35 @@ static struct parameter *parameter__new(Dwarf_Die =
*die, struct cu *cu,
 				 * contents.
 				 */
 				parm->unexpected_reg =3D 1;
-		} else if (has_const_value) {
+		} else if (has_const_value && !cu->producer_clang) {
+			parm->optimized =3D 1;
+		} else if (true_sig_enabled) {
+			int byte_size, num_regs, next_reg_idx;
+
+			if (param_idx + 1 < info->nr_params) {
+				int next_start =3D info->param_start_regs[param_idx + 1];
+				if (next_start >=3D 0) {
+					/* check whether we should preserve the argument or not */
+					byte_size =3D get_type_byte_size(die, cu);
+					/* byte_size 0 should not happen. */
+					if (!byte_size) {
+						parm->unexpected_reg =3D 1;
+						return parm;
+					}
+
+					num_regs =3D (byte_size + cu->addr_size - 1) / cu->addr_size;
+					next_reg_idx =3D reg_idx + num_regs;
+					if (next_reg_idx < cu->nr_register_params &&
+					    next_start =3D=3D cu->register_params[next_reg_idx]) {
+						if (byte_size > cu->addr_size)
+							info->skip_idx--;
+						return parm;
+					}
+				}
+			}
+
 			parm->optimized =3D 1;
+			info->skip_idx++;
 		}
 	}
=20
--=20
2.53.0-Meta

