Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E48B3242B8
	for <dwarves@vger.kernel.org>; Sat, 23 May 2026 16:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779555517; cv=none; b=pZWrwfxsxzE8nRC2olpaxHc25MSJ+JCSgkCThjPDsq5aWthpr14CRH33raAnzOkjsoRrNu7zQovCZe1rM1u7HsjWaEZZZ7Jt7QaAa6csTXBLW1WqPfA5PWBxdW6mOCRCw3cf6DX2CiPRuLBzi5Y1C+Oj+PZJ9jO1ed0d3LWwxas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779555517; c=relaxed/simple;
	bh=KAku2K3e1kz9p/8tKw2rYHDrBLNFkWi+59AUN17bsGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e+o1tK13ONzNDd6h9Yg2NA5YwbHN0PE2nIhyGi2Lhy2rzNEFoSEZ7y+OMNuDMlPu1BMTJnzZZjzmvZHbr5eyfmTLsGJHjcPylOyIzwNPYD+wm5eJ2Dl9m0dxQRTF+B+PAGRqaMkkpztcRZRpIN3eLOcZSxxJz3P0IkcWSz6hGA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 1E375EE9018FA; Sat, 23 May 2026 09:58:22 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH dwarves v5 09/11] dwarf_loader: Handle expression lists
Date: Sat, 23 May 2026 09:58:00 -0700
Message-ID: <20260523165822.1229712-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260523165712.1225231-1-yonghong.song@linux.dev>
References: <20260523165712.1225231-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Location lists having more than one op's are checked.
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

With this patch, the number of invalid true signatures is reduced from 83=
 to 18.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 dwarf_loader.c | 240 +++++++++++++++++++++++++++++++++++++++++++++++--
 dwarves.h      |   1 +
 2 files changed, 234 insertions(+), 7 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index b888783..870c167 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1204,6 +1204,8 @@ static ptrdiff_t __dwarf_getlocations(Dwarf_Attribu=
te *attr,
 #define	PARM_UNEXPECTED		-2
 #define	PARM_OPTIMIZED_OUT	-3
 #define	PARM_CONTINUE		-4
+#define	PARM_TWO_ADDR_LEN	-5
+#define	PARM_TO_BE_IMPROVED	-6
=20
 /* Max 20 register parameters, considering some parameters may be optimi=
zed out.  */
 #define	MAX_PRESCAN_PARAMS	20
@@ -1291,7 +1293,47 @@ static int parameter__peek_first_reg(Dwarf_Die *di=
e)
 	return -1;
 }
=20
-static int parameter__multi_exprs(Dwarf_Op *expr, int loc_num)
+/* Traverse the parameter type until finding the member type which has e=
xpected
+ * struct type offset.
+ */
+static Dwarf_Die *get_member_with_offset(Dwarf_Die *die, int offset, Dwa=
rf_Die *member_die)
+{
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
+
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
+/* For two address length case, first_half and second_half represents th=
e parameter.
+ * The first_half and second_half accumulates field information across p=
ossible multiple
+ * location lists.
+ */
+static int parameter__multi_exprs(Dwarf_Op *expr, int loc_num, struct cu=
 *cu, size_t exprlen,
+				  Dwarf_Die *die, int expected_reg, int byte_size,
+				  unsigned long *first_half, unsigned long *second_half, int *ret)
 {
 	switch (expr[0].atom) {
 	case DW_OP_lit0 ... DW_OP_lit31:
@@ -1302,9 +1344,169 @@ static int parameter__multi_exprs(Dwarf_Op *expr,=
 int loc_num)
 		return PARM_OPTIMIZED_OUT;
 	}
=20
+	if (byte_size <=3D cu->addr_size || !cu->agg_use_two_regs) {
+		/* parameter_size <=3D cu->addr_size */
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
+		/* cu->addr < parameter_size <=3D cu->addr * 2
+		 * first_half encodes field starts for the first register.
+		 * second_half encodes field starts for the second register.
+		 *
+		 * For example:
+		 *   loclist 1: DW_OP_reg5 RDI, DW_OP_piece 0x8, DW_OP_reg4 RSI, DW_OP=
_piece 0x1
+		 *   loclist 2: DW_OP_piece 0x8, DW_OP_reg4 RSI, DW_OP_piece 0x1
+		 *   loclist 3: DW_OP_piece 0x8, DW_OP_reg4 RSI, DW_OP_piece 0x1)
+		 *
+		 * After iterating all the above three location lists (see PARM_CONTIN=
UE below),
+		 * first_half encodes as 0x1 and second_half encodes as 0x1. The 'ret'=
 value will
+		 * encode the first used register which is RDI. Each bit in first_half=
/second_half
+		 * represents a member field.
+		 *
+		 * Another example:
+		 *   loclist 1: DW_OP_reg5 RDI, DW_OP_piece 0x4
+		 *   loclist 2: DW_OP_piece 0x4, DW_OP_reg4 RDI, DW_OP_piece 0x4
+		 *
+		 * After iterating all the above two location lists, first_half encode=
s 0x11.
+		 * After loclist 1, first_half encoding is 0x1. After loclist 2, first=
_half encoding is 0x11.
+		 * second_half is 0. The 'ret' value is RDI.
+		 */
+		int off =3D 0;
+		for (int i =3D 0; i < exprlen; i++) {
+			if (expr[i].atom =3D=3D DW_OP_piece) {
+				int num =3D expr[i].number;
+				if (i =3D=3D 0) {
+					off =3D num;
+					continue;
+				}
+				if (off < cu->addr_size) (*first_half) |=3D (1 << off);
+				else (*second_half) |=3D (1 << (off - cu->addr_size));
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
+/* The first_half and second_half, computed in parameter__multi_exprs(),=
 are handled here. */
+static int parameter__handle_two_addr_len(int expected_reg, unsigned lon=
g first_half, unsigned long second_half,
+					  int ret, Dwarf_Die *die, struct conf_load *conf, struct cu *cu,
+					  struct parameter *parm, int param_idx, int reg_idx, int byte_size=
,
+					  struct func_info *info)
+{
+	if (!first_half && !second_half)
+		return ret;
+
+	if (ret !=3D expected_reg)
+		return ret;
+
+	if (!conf->true_signature)
+		return PARM_DEFAULT_FAIL;
+
+	/* Both halves are used based on dwarf */
+	if (first_half && second_half)
+		return PARM_TWO_ADDR_LEN;
+
+	/* Only one half is used. Check if the next parameter's starting regist=
er
+	 * indicates the ABI still reserves the full register space for this
+	 * parameter. If so, the compiler only eliminated the dead half but the
+	 * register layout is preserved =E2=80=94 keep the original source type=
.
+	 *
+	 * Use register_params[] array for the expected next register since
+	 * DW_OP_reg numbers are not necessarily sequential across architecture=
s.
+	 */
+	if (param_idx + 1 < info->nr_params) {
+		int next_start =3D info->param_start_regs[param_idx + 1];
+
+		if (next_start >=3D 0) {
+			int num_regs =3D (byte_size + cu->addr_size - 1) / cu->addr_size;
+			int next_reg_idx =3D reg_idx + num_regs;
+
+			if (next_reg_idx < cu->nr_register_params &&
+			    next_start =3D=3D cu->register_params[next_reg_idx])
+				return PARM_TWO_ADDR_LEN;
+		}
+	}
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
+	 * type for it. For more than one field, another option could be named =
as
+	 * <parameter_name>__first_half or <parameter_name>__second_half, but i=
t is not
+	 * that intuitive.
+	 */
+	if (__builtin_popcountll(first_half) >=3D 2 || __builtin_popcountll(sec=
ond_half) >=3D 2)
+		return PARM_TO_BE_IMPROVED;
+
+	int field_offset;
+	if (__builtin_popcountll(first_half) =3D=3D 1)
+		field_offset =3D __builtin_ctzll(first_half);
+	else
+		field_offset =3D cu->addr_size + __builtin_ctzll(second_half);
+
+	/* FIXME: Only struct type is supported. */
+	Dwarf_Die member_die;
+	if (!get_member_with_offset(die, field_offset, &member_die))
+		return PARM_TO_BE_IMPROVED;
+
+	/* FIXME: cannot get a proper member_name, e.g. if the member type is a=
 union. */
+	const char *member_name =3D attr_string(&member_die, DW_AT_name, conf);
+	if (!member_name)
+		return PARM_TO_BE_IMPROVED;
+
+	/* true_sig_member_name is the member name which will be used for later=
 btf name
+	 * like <parameter_name>__<member_name>.
+	 */
+	parm->true_sig_member_name =3D member_name;
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
@@ -1313,15 +1515,18 @@ static int parameter__multi_exprs(Dwarf_Op *expr,=
 int loc_num)
  * - otherwise if no register was found for locations, return PARM_DEFAU=
LT_FAIL.
  */
 static int parameter__reg(Dwarf_Attribute *attr, int expected_reg, struc=
t conf_load *conf,
-			  struct func_info *info)
+			  struct func_info *info, struct cu *cu, Dwarf_Die *die,
+			  struct parameter *parm, int param_idx, int reg_idx)
 {
 	Dwarf_Addr base, start, end;
 	Dwarf_Op *expr, *entry_ops;
 	Dwarf_Attribute entry_attr;
 	size_t exprlen, entry_len;
 	ptrdiff_t offset =3D 0;
+	int byte_size =3D 0;
 	int loc_num =3D -1;
 	int ret =3D PARM_DEFAULT_FAIL;
+	unsigned long first_half =3D 0, second_half =3D 0;
=20
 	/* use libdw__lock as dwarf_getlocation(s) has concurrency issues
 	 * when libdw is not compiled with experimental --enable-thread-safety
@@ -1341,8 +1546,17 @@ static int parameter__reg(Dwarf_Attribute *attr, i=
nt expected_reg, struct conf_l
 			if (!info->signature_changed || !conf->true_signature)
 				continue;
=20
+			if (!byte_size)
+				byte_size =3D get_type_byte_size(die, cu);
+			/* This should not happen. */
+			if (!byte_size) {
+				ret =3D PARM_UNEXPECTED;
+				goto out;
+			}
+
 			int res;
-			res =3D parameter__multi_exprs(expr, loc_num);
+			res =3D parameter__multi_exprs(expr, loc_num, cu, exprlen, die, expec=
ted_reg,
+						     byte_size, &first_half, &second_half, &ret);
 			if (res =3D=3D PARM_CONTINUE)
 				continue;
 			ret =3D res;
@@ -1391,6 +1605,11 @@ static int parameter__reg(Dwarf_Attribute *attr, i=
nt expected_reg, struct conf_l
 			break;
 		}
 	}
+
+	ret =3D parameter__handle_two_addr_len(expected_reg, first_half, second=
_half,
+					     ret, die, conf, cu, parm, param_idx, reg_idx,
+					     byte_size, info);
+
 out:
 	pthread_mutex_unlock(&libdw__lock);
 	return ret;
@@ -1415,10 +1634,9 @@ static struct parameter *parameter__new(Dwarf_Die =
*die, struct cu *cu,
 		if (!info->signature_changed) {
 			if (cu->producer_clang || param_idx >=3D cu->nr_register_params)
 				return parm;
+			reg_idx =3D param_idx;
 		} else {
 			reg_idx =3D param_idx - info->skip_idx;
-			if (reg_idx >=3D cu->nr_register_params)
-				return parm;
 		}
=20
 		/* Parameters which use DW_AT_abstract_origin to point at
@@ -1459,15 +1677,23 @@ static struct parameter *parameter__new(Dwarf_Die=
 *die, struct cu *cu,
 		true_sig_enabled =3D conf->true_signature && info->signature_changed;
=20
 		if (parm->has_loc) {
+			if (reg_idx >=3D cu->nr_register_params)
+				return parm;
+
 			int expected_reg =3D cu->register_params[reg_idx];
-			int actual_reg =3D parameter__reg(&attr, expected_reg, conf, info);
+			int actual_reg =3D parameter__reg(&attr, expected_reg, conf, info, cu=
, die,
+							parm, param_idx, reg_idx);
=20
 			if (actual_reg =3D=3D PARM_DEFAULT_FAIL) {
 				parm->optimized =3D 1;
 			} else if (actual_reg =3D=3D PARM_OPTIMIZED_OUT) {
 				parm->optimized =3D 1;
 				info->skip_idx++;
-			} else if (actual_reg =3D=3D PARM_UNEXPECTED || (expected_reg >=3D 0 =
&& expected_reg !=3D actual_reg)) {
+			} else if (actual_reg =3D=3D PARM_TWO_ADDR_LEN) {
+				/* account for parameter with two registers */
+				info->skip_idx--;
+			} else if (actual_reg =3D=3D PARM_UNEXPECTED || actual_reg =3D=3D PAR=
M_TO_BE_IMPROVED ||
+				   (expected_reg >=3D 0 && expected_reg !=3D actual_reg)) {
 				/* mark parameters that use an unexpected
 				 * register to hold a parameter; these will
 				 * be problematic for users of BTF as they
diff --git a/dwarves.h b/dwarves.h
index 2d94dff..2fc937a 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -948,6 +948,7 @@ size_t lexblock__fprintf(const struct lexblock *lexbl=
ock, const struct cu *cu,
 struct parameter {
 	struct tag tag;
 	const char *name;
+	const char *true_sig_member_name;
 	uint8_t optimized:1;
 	uint8_t unexpected_reg:1;
 	uint8_t has_loc:1;
--=20
2.53.0-Meta

