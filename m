Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A293C4B89
	for <dwarves@vger.kernel.org>; Tue, 23 Jun 2026 22:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782253754; cv=none; b=DcpFe91Ek8bh1hAlMDXilhWeM6rd9i8FmY5z+AtWDi004NckPTu1Fwn5ZNKmOhslvy05MYjMLBj/hz6gmocP9ST+PQTGPz7Fn1X58w5Fe6VzLiX5xU+T6CZ5Mq272nYDFNfUmxcbX7MgsNZcCU25PZPjDlhElkN+s+Z5NKe9eMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782253754; c=relaxed/simple;
	bh=ttTKlcJK3rJjKYmYyXMV0hQjqORAbCm6sphyZh2iZ10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Juu2gXToSz4cwKDYYlFQZBOgqI7F8npuieOkMYJRSMx3C9KWIxeQ/9FAW0Dn5I8b1anBoZxgbeOVZ6exd/erMksB4RyMpg5f7R11oVl8iBahQHgn3GXAFmubs7ithu+0gWX/FfHbGud2fFFxKqjzRIiSix6Rvfo58PP46ljR5QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id DD3AF1973B5CE1; Tue, 23 Jun 2026 15:29:00 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH dwarves v8 2/5] dwarf_loader: Collect per-parameter information
Date: Tue, 23 Jun 2026 15:29:00 -0700
Message-ID: <20260623222900.3292238-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623222850.3290612-1-yonghong.song@linux.dev>
References: <20260623222850.3290612-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Scan all parameters and save necessary information in struct
parameter and such information will be used in the next patch
for analysis.

The collected per-parameter information includes
  - whether the parameter is const value or not
  - whether the parameter is a DW_OP_fbreg (location stack) or not
  - the location register for this parameter
  - the type byte size for this parameter (from parameter type)
  - whether the parameter is passed in memory
  - whether the parameter needs to two registers
  - If the source parameter needs 2 registers but the actual
    parameter (after optimization) only needs 1 register and only
    one field is used, record true_sig_member name and type.

Such information is also propagated to abstract-origin parameters in
ftype__recode_dwarf_types().

parameter__new() now only decodes this location state; the optimized and
unexpected_reg decisions that parameter__reg() used to drive are made by
the function-level analysis pass added in the next commit, which consumes
the decoded fields.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 dwarf_loader.c | 344 +++++++++++++++++++++++++++++++++++++++++--------
 dwarves.h      |  11 ++
 2 files changed, 298 insertions(+), 57 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 11a2377..01954c6 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1237,14 +1237,231 @@ static ptrdiff_t __dwarf_getlocations(Dwarf_Attr=
ibute *attr,
 	return ret;
 }
=20
-/* For DW_AT_location 'attr':
- * - if first location is DW_OP_regXX with expected number, return the r=
egister;
- *   otherwise save the register for later return
- * - if location DW_OP_entry_value(DW_OP_regXX) with expected number is =
in the
- *   list, return the register; otherwise save register for later return
- * - otherwise if no register was found for locations, return -1.
+#define PARAMETER_UNKNOWN_REG -1
+
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
+		Dwarf_Attribute attr;
+		Dwarf_Off bit_offset;
+
+		if (dwarf_attr(member_die, DW_AT_data_bit_offset, &attr) !=3D NULL)
+			bit_offset =3D __attr_offset(&attr);
+		else if (dwarf_attr(member_die, DW_AT_data_member_location, &attr) !=3D=
 NULL)
+			bit_offset =3D __attr_offset(&attr) * 8;
+		else
+			continue;
+
+		if (bit_offset =3D=3D offset * 8)
+			return member_die;
+	} while (dwarf_siblingof(member_die, member_die) =3D=3D 0);
+
+	return NULL;
+}
+
+static bool dwarf_op__is_reg(unsigned int atom)
+{
+	return atom >=3D DW_OP_reg0 && atom <=3D DW_OP_reg31;
+}
+
+static bool dwarf_expr__has_stack_value(Dwarf_Op *expr, size_t exprlen)
+{
+	for (size_t i =3D 1; i < exprlen; i++) {
+		if (expr[i].atom =3D=3D DW_OP_stack_value)
+			return true;
+	}
+	return false;
+}
+
+static void parameter__set_loc_reg(struct parameter *parm, int reg)
+{
+	if (parm->loc_reg =3D=3D PARAMETER_UNKNOWN_REG)
+		parm->loc_reg =3D reg;
+}
+
+static void parameter__set_field_bit(unsigned long *fields, int byte_off=
set)
+{
+	if (byte_offset >=3D 0 && byte_offset < (int)(sizeof(*fields) * 8))
+		*fields |=3D 1UL << byte_offset;
+}
+
+static void parameter__record_true_sig_member(struct parameter *parm, Dw=
arf_Die *die,
+					      int field_offset, struct conf_load *conf)
+{
+	Dwarf_Die member_die;
+
+	if (parm->true_sig_member_name)
+		return;
+	if (!parm->name)
+		return;
+	if (!get_member_with_offset(die, field_offset, &member_die))
+		return;
+
+	parm->true_sig_member_name =3D attr_string(&member_die, DW_AT_name, con=
f);
+	if (!parm->true_sig_member_name)
+		return;
+
+	parm->true_sig_type_from_types =3D attr_type(&member_die, DW_AT_type, &=
parm->true_sig_type);
+	if (parm->true_sig_type =3D=3D 0)
+		parm->true_sig_member_name =3D NULL;
+}
+
+static void parameter__finish_piece_decode(struct parameter *parm, Dwarf=
_Die *die,
+					   struct conf_load *conf, struct cu *cu)
+{
+	unsigned long first =3D parm->first_reg_fields;
+	unsigned long second =3D parm->second_reg_fields;
+	int field_offset;
+
+	if (!first && !second)
+		return;
+	if (first && second)
+		return;
+	if (__builtin_popcountl(first) >=3D 2 || __builtin_popcountl(second) >=3D=
 2)
+		return;
+
+	if (__builtin_popcountl(first) =3D=3D 1)
+		field_offset =3D __builtin_ctzl(first);
+	else
+		field_offset =3D cu->addr_size + __builtin_ctzl(second);
+
+	parameter__record_true_sig_member(parm, die, field_offset, conf);
+}
+
+/* For aggregate parameters represented by pieces, first_reg_fields and
+ * second_reg_fields record the byte offsets materialized in each ABI re=
gister.
+ * The later function-level pass decides whether the source aggregate is=
 still
+ * ABI-preserved or should be replaced by the single used member candida=
te.
  */
-static int parameter__reg(Dwarf_Attribute *attr, int expected_reg)
+static void parameter__multi_exprs(Dwarf_Op *expr, int loc_num, struct c=
u *cu,
+				   size_t exprlen, struct parameter *parm)
+{
+	switch (expr[0].atom) {
+	case DW_OP_lit0 ... DW_OP_lit31:
+	case DW_OP_constu:
+	case DW_OP_consts:
+		if (loc_num =3D=3D 0)
+			parm->loc_const_value =3D 1;
+		return;
+	}
+
+	if (parm->type_byte_size <=3D cu->addr_size || !cu->agg_use_two_regs) {
+		switch (expr[0].atom) {
+		case DW_OP_reg0 ... DW_OP_reg31:
+			if (loc_num =3D=3D 0)
+				parameter__set_loc_reg(parm, expr[0].atom);
+			return;
+		case DW_OP_breg0 ... DW_OP_breg31:
+			if (loc_num =3D=3D 0 && dwarf_expr__has_stack_value(expr, exprlen))
+				parameter__set_loc_reg(parm, expr[0].atom - DW_OP_breg0 + DW_OP_reg0=
);
+			return;
+		default:
+			return;
+		}
+	}
+
+	int off =3D 0;
+	for (size_t i =3D 0; i < exprlen; i++) {
+		if (expr[i].atom =3D=3D DW_OP_piece) {
+			int num =3D expr[i].number;
+
+			if (i =3D=3D 0) {
+				off =3D num;
+				continue;
+			}
+
+			if (off < cu->addr_size)
+				parameter__set_field_bit(&parm->first_reg_fields, off);
+			else
+				parameter__set_field_bit(&parm->second_reg_fields, off - cu->addr_si=
ze);
+			off +=3D num;
+		} else if (dwarf_op__is_reg(expr[i].atom)) {
+			if (off < cu->addr_size || parm->loc_reg =3D=3D PARAMETER_UNKNOWN_REG=
)
+				parameter__set_loc_reg(parm, expr[i].atom);
+		}
+		/* FIXME: not handling DW_OP_bregX pieces yet since we do not
+		 * have a use case for it yet in the Linux kernel.
+		 */
+	}
+}
+
+static void parameter__decode_location(Dwarf_Attribute *attr, struct con=
f_load *conf,
+				       struct cu *cu, Dwarf_Die *die,
+				       struct parameter *parm)
 {
 	Dwarf_Addr base, start, end;
 	Dwarf_Op *expr, *entry_ops;
@@ -1252,66 +1469,76 @@ static int parameter__reg(Dwarf_Attribute *attr, =
int expected_reg)
 	size_t exprlen, entry_len;
 	ptrdiff_t offset =3D 0;
 	int loc_num =3D -1;
-	int ret =3D -1;
=20
-	/* use libdw__lock as dwarf_getlocation(s) has concurrency issues
-	 * when libdw is not compiled with experimental --enable-thread-safety
-	 */
 	pthread_mutex_lock(&libdw__lock);
 	while ((offset =3D __dwarf_getlocations(attr, offset, &base, &start, &e=
nd, &expr, &exprlen)) > 0) {
+		bool had_stack_value;
+
 		loc_num++;
+		if (exprlen =3D=3D 0)
+			continue;
=20
-		/* Convert expression list (XX DW_OP_stack_value) -> (XX).
-		 * DW_OP_stack_value instructs interpreter to pop current value from
-		 * DWARF expression evaluation stack, and thus is not important here.
-		 */
-		if (exprlen > 1 && expr[exprlen - 1].atom =3D=3D DW_OP_stack_value)
+		had_stack_value =3D expr[exprlen - 1].atom =3D=3D DW_OP_stack_value;
+		if (exprlen =3D=3D 2 && had_stack_value)
 			exprlen--;
=20
-		if (exprlen !=3D 1)
+		if (exprlen !=3D 1) {
+			parameter__multi_exprs(expr, loc_num, cu, exprlen, parm);
 			continue;
+		}
=20
 		switch (expr->atom) {
-		/* match DW_OP_regXX at first location */
 		case DW_OP_reg0 ... DW_OP_reg31:
-			if (loc_num !=3D 0)
-				break;
-			ret =3D expr->atom;
-			if (ret =3D=3D expected_reg)
-				goto out;
+			if (loc_num =3D=3D 0)
+				parameter__set_loc_reg(parm, expr->atom);
+			break;
+		case DW_OP_breg0 ... DW_OP_breg31:
+			if (loc_num =3D=3D 0 && had_stack_value)
+				parameter__set_loc_reg(parm, expr->atom - DW_OP_breg0 + DW_OP_reg0);
+			break;
+		case DW_OP_fbreg:
+			if (loc_num =3D=3D 0)
+				parm->loc_stack =3D 1;
+			break;
+		case DW_OP_lit0 ... DW_OP_lit31:
+		case DW_OP_constu:
+		case DW_OP_consts:
+			if (loc_num =3D=3D 0)
+				parm->loc_const_value =3D 1;
 			break;
-		/* match DW_OP_entry_value(DW_OP_regXX) at any location */
 		case DW_OP_entry_value:
 		case DW_OP_GNU_entry_value:
 			if (dwarf_getlocation_attr(attr, expr, &entry_attr) =3D=3D 0 &&
 			    dwarf_getlocation(&entry_attr, &entry_ops, &entry_len) =3D=3D 0 &=
&
-			    entry_len =3D=3D 1) {
-				ret =3D entry_ops->atom;
-				if (ret =3D=3D expected_reg)
-					goto out;
-			}
+			    entry_len =3D=3D 1 && dwarf_op__is_reg(entry_ops->atom))
+				parameter__set_loc_reg(parm, entry_ops->atom);
 			break;
 		}
 	}
-out:
 	pthread_mutex_unlock(&libdw__lock);
-	return ret;
+
+	parameter__finish_piece_decode(parm, die, conf, cu);
 }
=20
-static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
-					struct conf_load *conf, int param_idx)
+static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu, s=
truct conf_load *conf,
+					struct ftype *ftype, int param_idx)
 {
 	struct parameter *parm =3D tag__alloc(cu, sizeof(*parm));
=20
 	if (parm !=3D NULL) {
-		bool has_const_value;
 		Dwarf_Attribute attr;
=20
 		tag__init(&parm->tag, cu, die);
 		parm->name =3D attr_string(die, DW_AT_name, conf);
 		parm->idx =3D param_idx;
-		if (param_idx >=3D cu->nr_register_params || param_idx < 0)
+		parm->loc_reg =3D PARAMETER_UNKNOWN_REG;
+		if (!ftype)
 			return parm;
+
+		parm->type_byte_size =3D get_type_byte_size(die, cu);
+		parm->passed_in_memory =3D parm->type_byte_size >
+			(cu->agg_use_two_regs ? 2 * cu->addr_size : cu->addr_size);
+
 		/* Parameters which use DW_AT_abstract_origin to point at
 		 * the original parameter definition (with no name in the DIE)
 		 * are the result of later DWARF generation during compilation
@@ -1345,26 +1572,10 @@ static struct parameter *parameter__new(Dwarf_Die=
 *die, struct cu *cu,
 		 * between these parameter representations.  See
 		 * ftype__recode_dwarf_types() below for how this is handled.
 		 */
-		has_const_value =3D dwarf_attr(die, DW_AT_const_value, &attr) !=3D NUL=
L;
+		parm->has_const_value =3D dwarf_attr(die, DW_AT_const_value, &attr) !=3D=
 NULL;
 		parm->has_loc =3D dwarf_attr(die, DW_AT_location, &attr) !=3D NULL;
-
-		if (parm->has_loc) {
-			int expected_reg =3D cu->register_params[param_idx];
-			int actual_reg =3D parameter__reg(&attr, expected_reg);
-
-			if (actual_reg < 0)
-				parm->optimized =3D 1;
-			else if (expected_reg >=3D 0 && expected_reg !=3D actual_reg)
-				/* mark parameters that use an unexpected
-				 * register to hold a parameter; these will
-				 * be problematic for users of BTF as they
-				 * violate expectations about register
-				 * contents.
-				 */
-				parm->unexpected_reg =3D 1;
-		} else if (has_const_value) {
-			parm->optimized =3D 1;
-		}
+		if (parm->has_loc)
+			parameter__decode_location(&attr, conf, cu, die, parm);
 	}
=20
 	return parm;
@@ -1384,7 +1595,7 @@ static int formal_parameter_pack__load_params(struc=
t formal_parameter_pack *pack
 			continue;
 		}
=20
-		struct parameter *param =3D parameter__new(die, cu, conf, -1);
+		struct parameter *param =3D parameter__new(die, cu, conf, NULL, -1);
=20
 		if (param =3D=3D NULL)
 			return -1;
@@ -1905,7 +2116,7 @@ static struct tag *die__create_new_parameter(Dwarf_=
Die *die,
 					     struct cu *cu, struct conf_load *conf,
 					     int param_idx)
 {
-	struct parameter *parm =3D parameter__new(die, cu, conf, param_idx);
+	struct parameter *parm =3D parameter__new(die, cu, conf, ftype, param_i=
dx);
=20
 	if (parm =3D=3D NULL)
 		return NULL;
@@ -2226,7 +2437,7 @@ out_enomem:
 }
=20
 static int die__process_function(Dwarf_Die *die, struct ftype *ftype,
-				  struct lexblock *lexblock, struct cu *cu, struct conf_load *conf);
+				 struct lexblock *lexblock, struct cu *cu, struct conf_load *conf);
=20
 static int die__create_new_lexblock(Dwarf_Die *die,
 				    struct cu *cu, struct lexblock *father, struct conf_load *conf)
@@ -2766,6 +2977,25 @@ static void ftype__recode_dwarf_types(struct tag *=
tag, struct cu *cu)
 			 */
 			if (pos->has_loc)
 				opos->has_loc =3D pos->has_loc;
+			if (pos->has_const_value)
+				opos->has_const_value =3D pos->has_const_value;
+			if (pos->loc_const_value)
+				opos->loc_const_value =3D pos->loc_const_value;
+			if (pos->loc_stack)
+				opos->loc_stack =3D pos->loc_stack;
+			if (pos->loc_reg !=3D PARAMETER_UNKNOWN_REG)
+				opos->loc_reg =3D pos->loc_reg;
+			if (pos->type_byte_size !=3D 0)
+				opos->type_byte_size =3D pos->type_byte_size;
+			if (pos->passed_in_memory)
+				opos->passed_in_memory =3D pos->passed_in_memory;
+			opos->first_reg_fields |=3D pos->first_reg_fields;
+			opos->second_reg_fields |=3D pos->second_reg_fields;
+			if (pos->true_sig_member_name && !opos->true_sig_member_name) {
+				opos->true_sig_member_name =3D pos->true_sig_member_name;
+				opos->true_sig_type =3D pos->true_sig_type;
+				opos->true_sig_type_from_types =3D pos->true_sig_type_from_types;
+			}
=20
 			if (pos->optimized)
 				opos->optimized =3D pos->optimized;
diff --git a/dwarves.h b/dwarves.h
index c0d7f5c..0d6f7dd 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -948,9 +948,20 @@ size_t lexblock__fprintf(const struct lexblock *lexb=
lock, const struct cu *cu,
 struct parameter {
 	struct tag tag;
 	const char *name;
+	const char *true_sig_member_name;
+	Dwarf_Off true_sig_type;
+	unsigned long first_reg_fields;
+	unsigned long second_reg_fields;
+	int loc_reg;
+	uint16_t type_byte_size;
+	uint8_t true_sig_type_from_types:1;
+	uint8_t has_const_value:1;
+	uint8_t loc_const_value:1;
+	uint8_t loc_stack:1;
 	uint8_t optimized:1;
 	uint8_t unexpected_reg:1;
 	uint8_t has_loc:1;
+	uint8_t passed_in_memory:1;	/* too large for the ABI argument registers=
 */
 	uint8_t idx;
 };
=20
--=20
2.53.0-Meta

