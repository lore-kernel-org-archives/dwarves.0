Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39F5364EA0
	for <dwarves@vger.kernel.org>; Thu,  5 Mar 2026 22:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772751347; cv=none; b=fC+e1aC+Vrvzp2qlHG+FmQ/Lrx8Ggp7iiIoOJc215/l23yEKLivXhy3FLdryx/mcL9S3oPdRCY93tuxMVKormANVONRHfer4ubyf7AFsQ9rZcydI/bKsGa/bJ042pJdbouBPeCyjcgRTpASQ6lH1YdmcNoyz1coZM8fkDR6XPrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772751347; c=relaxed/simple;
	bh=gpF6KJ7ATjBU/cu88VlB8n+7nA1b/iKOKGsRmflOIqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Immb326Un1Iijg+lO7a/i5zD/N8R7sBhoSclpQMQuPT2htTaOb7e4E8vAjYRFEuBSm+9vo15bxhotvekrFkJu9F8MiUWLbj41ceTwyl021t3yulO8vLWjJvc1UcvvrLvuTzbQ/lxguDCA2uOMHpe8NZO2LL3ykrObfDoqGXc7fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id BA4D322AAAAEE; Thu,  5 Mar 2026 14:55:31 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH dwarves 7/9] dwarf_loader: Handle expression lists
Date: Thu,  5 Mar 2026 14:55:31 -0800
Message-ID: <20260305225531.1155994-1-yonghong.song@linux.dev>
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

The corresponding type is checked for the parameter.
If the parameter size is less or equal to size of long,
the argument should match the corresponding ABI register.
For example:

0x0aba0808:   DW_TAG_subprogram
                DW_AT_name      ("addrconf_ifdown")
                DW_AT_calling_convention        (DW_CC_nocall)
                DW_AT_type      (0x0ab7d8e9 "int")
		...

0x0aba082b:     DW_TAG_formal_parameter
                  DW_AT_location        (indexed (0x32b) loclist =3D 0x01=
6eabcd:
                     [0xffffffff83f6fef9, 0xffffffff83f6ff98): DW_OP_reg5=
 RDI
                     [0xffffffff83f6ff98, 0xffffffff83f70080): DW_OP_reg1=
2 R12
                     [0xffffffff83f70080, 0xffffffff83f70111): DW_OP_breg=
7 RSP+112
                     [0xffffffff83f70111, 0xffffffff83f7014f): DW_OP_reg1=
2 R12
                     [0xffffffff83f7014f, 0xffffffff83f7123c): DW_OP_breg=
7 RSP+112
                     [0xffffffff83f7123c, 0xffffffff83f7128c): DW_OP_entr=
y_value(DW_OP_reg5 RDI), DW_OP_stack_value
                     [0xffffffff83f7128c, 0xffffffff83f712a9): DW_OP_reg1=
2 R12
                     [0xffffffff83f712a9, 0xffffffff83f712cd): DW_OP_breg=
7 RSP+112
                     [0xffffffff83f712cd, 0xffffffff83f712d2): DW_OP_entr=
y_value(DW_OP_reg5 RDI), DW_OP_stack_value
                     [0xffffffff83f712d2, 0xffffffff83f713dd): DW_OP_breg=
7 RSP+112)
                  DW_AT_name    ("dev")
                  DW_AT_type    (0x0ab7cb7d "net_device *")
		  ...

0x0aba0836:     DW_TAG_formal_parameter
                  DW_AT_location        (indexed (0x32c) loclist =3D 0x01=
6eac39:
                     [0xffffffff83f6fef9, 0xffffffff83f6ff15): DW_OP_breg=
4 RSI+0, DW_OP_constu 0xffffffff, DW_OP_and, DW_OP_convert (0x0ab7b571) "=
DW_ATE_unsigned_1", DW_OP_convert (0x0ab7b576) "DW_ATE_unsigned_8", DW_OP=
_stack_value
                     [0xffffffff83f6ff15, 0xffffffff83f7127c): DW_OP_breg=
7 RSP+36, DW_OP_deref_size 0x4, DW_OP_convert (0x0ab7b571) "DW_ATE_unsign=
ed_1", DW_OP_convert (0x0ab7b576) "DW_ATE_unsigned_8", DW_OP_stack_value
                     [0xffffffff83f7128c, 0xffffffff83f713dd): DW_OP_breg=
7 RSP+36, DW_OP_deref_size 0x4, DW_OP_convert (0x0ab7b571) "DW_ATE_unsign=
ed_1", DW_OP_convert (0x0ab7b576) "DW_ATE_unsigned_8", DW_OP_stack_value)
                  DW_AT_name    ("unregister")
                  DW_AT_type    (0x0ab7c933 "bool")
		  ...

The parameter 'unregister' is the second argument which matches ABI regis=
ter RSI.
So the function "addrconf_ifdown" signature is valid.

If the parameter size is '2 x size_of_long', more handling is necessary, =
e.g., below:

0x0a01e174:   DW_TAG_subprogram
                DW_AT_name      ("check_zeroed_sockptr")
                DW_AT_calling_convention        (DW_CC_nocall)
                DW_AT_type      (0x09fead35 "int")
		...

0x0a01e187:     DW_TAG_formal_parameter
                  DW_AT_location        (indexed (0x5b6) loclist =3D 0x01=
57f03f:
                     [0xffffffff83c941c0, 0xffffffff83c941c4): DW_OP_reg5=
 RDI, DW_OP_piece 0x8, DW_OP_reg4 RSI, DW_OP_piece 0x1
                     [0xffffffff83c941c4, 0xffffffff83c941cc): DW_OP_piec=
e 0x8, DW_OP_reg4 RSI, DW_OP_piece 0x1
                     [0xffffffff83c941e1, 0xffffffff83c941e4): DW_OP_piec=
e 0x8, DW_OP_reg4 RSI, DW_OP_piece 0x1)
                  DW_AT_name    ("src")
                  DW_AT_type    (0x09ff832d "sockptr_t")
		  ...

0x0a01e193:     DW_TAG_formal_parameter
                  DW_AT_const_value     (64)
                  DW_AT_name    ("offset")
                  DW_AT_type    (0x09fee984 "size_t")
		  ...

0x0a01e19e:     DW_TAG_formal_parameter
                  DW_AT_location        (indexed (0x5b7) loclist =3D 0x01=
57f06b:
                     [0xffffffff83c941c0, 0xffffffff83c941d1): DW_OP_reg1=
 RDX
                     [0xffffffff83c941d1, 0xffffffff83c941e1): DW_OP_entr=
y_value(DW_OP_reg1 RDX), DW_OP_stack_value
                     [0xffffffff83c941e1, 0xffffffff83c941e9): DW_OP_reg1=
 RDX)
                  DW_AT_name    ("size")
                  DW_AT_type    (0x09fee984 "size_t")
		  ...

The first parameter 'src' will take two ABI registers. This patch correct=
ly detects such a pattern
to construct the true signature.

However, it is possible that only one 'size_of_long' is used from '2 x si=
ze_of_long'. For example

0x019520c6:   DW_TAG_subprogram
                DW_AT_name      ("map_create")
                DW_AT_calling_convention        (DW_CC_nocall)
                DW_AT_type      (0x01934b29 "int")
		...

0x01952111:     DW_TAG_formal_parameter
                  DW_AT_location        (indexed (0x31b) loclist =3D 0x00=
34fa0f:
                     [0xffffffff81892345, 0xffffffff8189237c): DW_OP_reg5=
 RDI
                     [0xffffffff8189237c, 0xffffffff818923bd): DW_OP_reg3=
 RBX
                     [0xffffffff818923bd, 0xffffffff818923d4): DW_OP_entr=
y_value(DW_OP_reg5 RDI), DW_OP_stack_value
                     [0xffffffff818923d4, 0xffffffff81892dcb): DW_OP_reg3=
 RBX
                     [0xffffffff81892df3, 0xffffffff81892e01): DW_OP_entr=
y_value(DW_OP_reg5 RDI), DW_OP_stack_value
                     [0xffffffff81892e01, 0xffffffff818932a9): DW_OP_reg3=
 RBX)
                  DW_AT_name    ("attr")
                  DW_AT_type    (0x01934d17 "bpf_attr *")
		  ...

0x0195211d:     DW_TAG_formal_parameter
                  DW_AT_location        (indexed (0x31a) loclist =3D 0x00=
34f9dc:
                     [0xffffffff81892345, 0xffffffff81892357): DW_OP_piec=
e 0x8, DW_OP_reg4 RSI, DW_OP_piece 0x1
                     [0xffffffff81892357, 0xffffffff81892f02): DW_OP_piec=
e 0x8, DW_OP_breg7 RSP+20, DW_OP_deref_size 0x4, DW_OP_stack_value, DW_OP=
_piece 0x1
                     [0xffffffff81892f07, 0xffffffff818932a9): DW_OP_piec=
e 0x8, DW_OP_breg7 RSP+20, DW_OP_deref_size 0x4, DW_OP_stack_value, DW_OP=
_piece 0x1)
                  DW_AT_name    ("uattr")
                  DW_AT_type    (0x019512ab "bpfptr_t")
		  ...

For parameter 'uattr', only second half of parameter is used. For such ca=
ses,
the name and the type is changed in pahole and eventually going to vmlinu=
x btf.
  [55697] FUNC_PROTO '(anon)' ret_type_id=3D106780 vlen=3D2
          'attr' type_id=3D455
          'uattr__is_kernel' type_id=3D82014
  [82014] TYPEDEF 'bool' type_id=3D67434
  [113251] FUNC 'map_create' type_id=3D55697 linkage=3Dstatic
You can see the new parameter name is 'uattr__is_kernel' and the type is =
'bool'.

This makes thing easier for users to get the true signature.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 dwarf_loader.c | 225 +++++++++++++++++++++++++++++++++++++++++++++++--
 dwarves.h      |   1 +
 2 files changed, 219 insertions(+), 7 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 712a957..3a9b2c0 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1100,6 +1100,16 @@ static void arch__set_register_params(const GElf_E=
hdr *ehdr, struct cu *cu)
 	}
 }
=20
+static bool arch__agg_use_two_regs(const GElf_Ehdr *ehdr)
+{
+	switch (ehdr->e_machine) {
+	case EM_S390:
+		return false;
+	default:
+		return true;
+	}
+}
+
 static struct template_type_param *template_type_param__new(Dwarf_Die *d=
ie, struct cu *cu, struct conf_load *conf)
 {
 	struct template_type_param *ttparm =3D tag__alloc(cu, sizeof(*ttparm));
@@ -1199,8 +1209,79 @@ struct func_info {
 #define	PARM_FBREG_FAIL		-2
 #define	PARM_OPTIMIZED_CLANG	-3
 #define	PARM_CONTINUE		-4
+#define	PARM_TWO_ADDR_LEN	-5
+#define	PARM_TO_BE_IMPROVED	-6
+
+static int __get_type_byte_size(Dwarf_Die *die) {
+	Dwarf_Attribute attr;
+	if (dwarf_attr(die, DW_AT_type, &attr) =3D=3D NULL)
+		return 0;
+
+	Dwarf_Die type_die;
+	if (dwarf_formref_die(&attr, &type_die) =3D=3D NULL)
+		return 0;
+
+	uint64_t bsize =3D attr_numeric(&type_die, DW_AT_byte_size);
+	if (bsize =3D=3D 0)
+		return __get_type_byte_size(&type_die);
+
+	return bsize;
+}
+
+static int get_type_byte_size(Dwarf_Die *die) {
+	int byte_size =3D 0;
+
+	Dwarf_Attribute attr;
+	if (dwarf_attr(die, DW_AT_abstract_origin, &attr)) {
+		Dwarf_Die origin;
+		if (dwarf_formref_die(&attr, &origin))
+			byte_size =3D __get_type_byte_size(&origin);
+	} else {
+		byte_size =3D __get_type_byte_size(die);
+	}
+	return byte_size;
+}
+
+/* Traverse the parameter type until finding the member type which has e=
xpected
+ * struct type offset.
+*/
+static Dwarf_Die *get_member_with_offset(Dwarf_Die *die, int offset, Dwa=
rf_Die *member_die) {
+	Dwarf_Attribute attr;
+	if (dwarf_attr(die, DW_AT_type, &attr) =3D=3D NULL)
+		return NULL;
+
+	Dwarf_Die type_die;
+	if (dwarf_formref_die(&attr, &type_die) =3D=3D NULL)
+		return NULL;
+
+	uint64_t bsize =3D attr_numeric(&type_die, DW_AT_byte_size);
+	if (bsize =3D=3D 0)
+		return get_member_with_offset(&type_die, offset, member_die);
+
+	if (dwarf_tag(&type_die) !=3D DW_TAG_structure_type)
+		return NULL;
=20
-static int parameter__multi_exprs(Dwarf_Op *expr, int loc_num) {
+	if (!dwarf_haschildren(&type_die) || dwarf_child(&type_die, member_die)=
 !=3D 0)
+		return NULL;
+	do {
+		if (dwarf_tag(member_die) !=3D DW_TAG_member)
+			continue;
+
+		int off =3D attr_numeric(member_die, DW_AT_data_bit_offset);
+		if (off =3D=3D offset * 8)
+			return member_die;
+	} while (dwarf_siblingof(member_die, member_die) =3D=3D 0);
+
+	return NULL;
+}
+
+/* For two address length case, lower_half and upper_half represents the=
 parameter.
+ * The lower_half and upper_half accumulates field information across po=
ssible multiple
+ * location lists.
+ */
+static int parameter__multi_exprs(Dwarf_Op *expr, int loc_num, struct cu=
 *cu, size_t exprlen,
+				  Dwarf_Die *die, int expected_reg, int byte_size,
+				  unsigned long *lower_half, unsigned long *upper_half, int *ret) {
 	switch (expr[0].atom) {
 	case DW_OP_lit0 ... DW_OP_lit31:
 	case DW_OP_constu:
@@ -1210,9 +1291,119 @@ static int parameter__multi_exprs(Dwarf_Op *expr,=
 int loc_num) {
 		return PARM_OPTIMIZED_CLANG;
 	}
=20
+	if (byte_size <=3D cu->addr_size || !cu->agg_use_two_regs) {
+		switch (expr[0].atom) {
+		case DW_OP_reg0 ... DW_OP_reg31:
+			if (loc_num !=3D 0)
+				break;
+			*ret =3D expr[0].atom;
+			if (*ret =3D=3D expected_reg)
+				return *ret;
+			break;
+		case DW_OP_breg0 ... DW_OP_breg31:
+			if (loc_num !=3D 0)
+				break;
+			bool has_op_stack_value =3D false;
+			for (int i =3D 1; i < exprlen; i++) {
+				if (expr[i].atom =3D=3D DW_OP_stack_value) {
+					has_op_stack_value =3D true;
+					break;
+				}
+			}
+			if (!has_op_stack_value)
+				break;
+			/* The existence of DW_OP_stack_value means that
+			 * DW_OP_bregX register is used as value.
+			 */
+			*ret =3D expr[0].atom - DW_OP_breg0 + DW_OP_reg0;
+			if (*ret =3D=3D expected_reg)
+				return *ret;
+		}
+	} else {
+		/* cu->addr * 2 */
+		int off =3D 0;
+		for (int i =3D 0; i < exprlen; i++) {
+			if (expr[i].atom =3D=3D DW_OP_piece) {
+				int num =3D expr[i].number;
+				if (i =3D=3D 0) {
+					off =3D num;
+					continue;
+				}
+				if (off < cu->addr_size) (*lower_half) |=3D (1 << off);
+				else (*upper_half) |=3D (1 << (off - cu->addr_size));
+				off +=3D num;
+			} else if (expr[i].atom >=3D DW_OP_reg0 && expr[i].atom <=3D DW_OP_re=
g31) {
+				if (off < cu->addr_size)
+					*ret =3D expr[i].atom;
+				else if (*ret < 0)
+					*ret =3D expr[i].atom;
+			}
+			/* FIXME: not handling DW_OP_bregX yet since we do not have
+			 * a use case for it yet for linux kernel.
+			 */
+		}
+	}
+
 	return PARM_CONTINUE;
 }
=20
+/* The lower_half and upper_half, computed in parameter__multiple_exprs(=
), are handled here.
+ */
+static int parameter__handle_two_addr_len(int expected_reg, unsigned lon=
g lower_half, unsigned long upper_half,
+					  int ret, Dwarf_Die *die, struct conf_load *conf, struct cu *cu,
+					  struct parameter *parm) {
+	if (!lower_half && !upper_half)
+		return ret;
+
+	if (ret !=3D expected_reg)
+		return ret;
+
+	if (!conf->true_signature)
+		return PARM_DEFAULT_FAIL;
+
+	/* Both halfs are used based on dwarf */
+	if (lower_half && upper_half)
+		return PARM_TWO_ADDR_LEN;
+
+	/* FIXME: parm->name may be NULL due to abstract origin. We do not want=
 to
+	 * update abstract origin as the type in abstract origin may be used
+	 * in some other places. We could remove abstract origin in this parame=
ter
+	 * and add name and type in parameter itself. Right now, for current bp=
f-next
+	 * repo, we do not have instances below where parm->name is NULL for x8=
6_64 arch.
+	 */
+	if (!parm->name)
+		return PARM_TO_BE_IMPROVED;
+
+	/* FIXME: Only support single field now so we can have a good parameter=
 name and
+	 * type for it.
+	 */
+	if (__builtin_popcountll(lower_half) >=3D 2 || __builtin_popcountll(upp=
er_half) >=3D 2)
+		return PARM_TO_BE_IMPROVED;
+
+	int field_offset;
+	if (__builtin_popcountll(lower_half) =3D=3D 1)
+		field_offset =3D __builtin_ctzll(lower_half);
+	else
+		field_offset =3D cu->addr_size + __builtin_ctzll(upper_half);
+
+	/* FIXME: Only struct type is supported. */
+	Dwarf_Die member_die;
+	if (!get_member_with_offset(die, field_offset, &member_die))
+		return PARM_TO_BE_IMPROVED;
+
+	const char *member_name =3D attr_string(&member_die, DW_AT_name, conf);
+	int len =3D sizeof(parm->name) + sizeof(member_name) + 3;
+	char *new_name =3D malloc(len);
+	sprintf(new_name, "%s__%s", parm->name, member_name);
+	parm->name =3D new_name;
+
+	struct tag *tag =3D &parm->tag;
+	struct dwarf_tag *dtag =3D tag__dwarf(tag);
+	dwarf_tag__set_attr_type(dtag, type, &member_die, DW_AT_type);
+
+	return ret;
+}
+
 /* For DW_AT_location 'attr':
  * - if first location is DW_OP_regXX with expected number, return the r=
egister;
  *   otherwise save the register for later return
@@ -1220,15 +1411,18 @@ static int parameter__multi_exprs(Dwarf_Op *expr,=
 int loc_num) {
  *   list, return the register; otherwise save register for later return
  * - otherwise if no register was found for locations, return PARM_DEFAU=
LT_FAIL.
  */
-static int parameter__reg(Dwarf_Attribute *attr, int expected_reg, struc=
t cu *cu, struct conf_load *conf)
+static int parameter__reg(Dwarf_Attribute *attr, int expected_reg, struc=
t cu *cu, struct conf_load *conf,
+			  Dwarf_Die *die, struct parameter *parm, struct func_info *info)
 {
 	Dwarf_Addr base, start, end;
 	Dwarf_Op *expr, *entry_ops;
 	Dwarf_Attribute entry_attr;
 	size_t exprlen, entry_len;
 	ptrdiff_t offset =3D 0;
+	int byte_size =3D 0;
 	int loc_num =3D -1;
 	int ret =3D PARM_DEFAULT_FAIL;
+	unsigned long lower_half =3D 0, upper_half =3D 0;
=20
 	/* use libdw__lock as dwarf_getlocation(s) has concurrency issues
 	 * when libdw is not compiled with experimental --enable-thread-safety
@@ -1248,8 +1442,15 @@ static int parameter__reg(Dwarf_Attribute *attr, i=
nt expected_reg, struct cu *cu
 			if (!cu->producer_clang || !conf->true_signature)
 				continue;
=20
+			if (!byte_size)
+				byte_size =3D get_type_byte_size(die);
+			/* This should not happen. */
+			if (!byte_size)
+				return PARM_DEFAULT_FAIL;
+
 			int res;
-			res =3D parameter__multi_exprs(expr, loc_num);
+			res =3D parameter__multi_exprs(expr, loc_num, cu, exprlen, die, expec=
ted_reg,
+						     byte_size, &lower_half, &upper_half, &ret);
 			if (res =3D=3D PARM_CONTINUE)
 				continue;
 			ret =3D res;
@@ -1297,6 +1498,10 @@ static int parameter__reg(Dwarf_Attribute *attr, i=
nt expected_reg, struct cu *cu
 			break;
 		}
 	}
+
+	ret =3D parameter__handle_two_addr_len(expected_reg, lower_half, upper_=
half,
+					     ret, die, conf, cu, parm);
+
 out:
 	pthread_mutex_unlock(&libdw__lock);
 	return ret;
@@ -1332,8 +1537,6 @@ static struct parameter *parameter__new(Dwarf_Die *=
die, struct cu *cu,
 			}
 		}
 		reg_idx =3D param_idx - info->skip_idx;
-		if (reg_idx >=3D cu->nr_register_params)
-			return parm;
 		/* Parameters which use DW_AT_abstract_origin to point at
 		 * the original parameter definition (with no name in the DIE)
 		 * are the result of later DWARF generation during compilation
@@ -1371,15 +1574,22 @@ static struct parameter *parameter__new(Dwarf_Die=
 *die, struct cu *cu,
 		parm->has_loc =3D dwarf_attr(die, DW_AT_location, &attr) !=3D NULL;
=20
 		if (parm->has_loc) {
+			if (reg_idx >=3D cu->nr_register_params)
+				return parm;
+
 			int expected_reg =3D cu->register_params[reg_idx];
-			int actual_reg =3D parameter__reg(&attr, expected_reg, cu, conf);
+			int actual_reg =3D parameter__reg(&attr, expected_reg, cu, conf, die,=
 parm, info);
=20
 			if (actual_reg =3D=3D PARM_DEFAULT_FAIL) {
 				parm->optimized =3D 1;
 			} else if (actual_reg =3D=3D PARM_OPTIMIZED_CLANG) {
 				parm->optimized =3D 1;
 				info->skip_idx++;
-			} else if (actual_reg =3D=3D PARM_FBREG_FAIL || (expected_reg >=3D 0 =
&& expected_reg !=3D actual_reg)) {
+			} else if (actual_reg =3D=3D PARM_TWO_ADDR_LEN) {
+				/* account for parameter with two registers */
+				info->skip_idx--;
+			} else if (actual_reg =3D=3D PARM_FBREG_FAIL || actual_reg =3D=3D PAR=
M_TO_BE_IMPROVED ||
+				   (expected_reg >=3D 0 && expected_reg !=3D actual_reg)) {
 				/* mark parameters that use an unexpected
 				 * register to hold a parameter; these will
 				 * be problematic for users of BTF as they
@@ -3419,6 +3629,7 @@ static int cu__set_common(struct cu *cu, struct con=
f_load *conf,
=20
 	cu->little_endian =3D ehdr.e_ident[EI_DATA] =3D=3D ELFDATA2LSB;
 	cu->nr_register_params =3D arch__nr_register_params(&ehdr);
+	cu->agg_use_two_regs =3D arch__agg_use_two_regs(&ehdr);
 	arch__set_register_params(&ehdr, cu);
 	return 0;
 }
diff --git a/dwarves.h b/dwarves.h
index ad33828..b7bae87 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -303,6 +303,7 @@ struct cu {
 	uint8_t		 uses_global_strings:1;
 	uint8_t		 little_endian:1;
 	uint8_t		 producer_clang:1;
+	uint8_t		 agg_use_two_regs:1;    /* An aggregate like {long a; long b;}=
 */
 	uint8_t		 nr_register_params;
 	int		 register_params[ARCH_MAX_REGISTER_PARAMS];
 	int		 functions_saved;
--=20
2.47.3

