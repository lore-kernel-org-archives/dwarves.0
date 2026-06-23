Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F215C3C7DF5
	for <dwarves@vger.kernel.org>; Tue, 23 Jun 2026 22:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782253758; cv=none; b=Jv4xqeJjEEQvReaga8hNPaocHJks2Tn/eyobv4IPm7ICXDooj38cOTBgbdNAfX1RkiKN7BBbADEj8gv+zth/D/ZuqbQ2DcpPrsy4GkhtUmQOCipDmGmPhMLV6ORebomDIC9jAFxrJCMQaEzZt/SbPyRTVImS3Lh0F21wk2oO8Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782253758; c=relaxed/simple;
	bh=5HUxJz2uJXla7iJDNzfqnb9fqDUPJbfWSeZKrPZl9pY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PqBhV7F71j6xjl1CJfKq1LhQX4EJlArddWPQGkCoiNKwxafp23AaR9JkBYYHXt0otst3t9H4tr4Ze1igotCYD6bCY6trO1Xp7UX3T2cgTnSpKKXGy+0SsDX5NPwVs3rL2rP915BQLEfAoxc9wbP1UhM7JEM/bqGD1n55Z4zv30M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 4B2451973BE6F0; Tue, 23 Jun 2026 15:29:06 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH dwarves v8 3/5] dwarf_loader: Analyze per-parameter information for true signatures
Date: Tue, 23 Jun 2026 15:29:05 -0700
Message-ID: <20260623222906.3293063-1-yonghong.song@linux.dev>
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

Add a function-level pass, function__analyze_parameter_locations(), run
from cu__resolve_func_ret_types_optimized() which walks a function's
parameters in ABI argument-register order and consumes the location state
decoded by parameter__decode_location() in the previous commit. Each
parameter advances the expected-register index by the number of argument
registers it occupies (parameter__abi_slots(), e.g. a two-eightbyte
aggregate consumes two registers).

For every producer it keeps the existing bookkeeping, now driven by the
decoded fields:
 - a parameter with no location, a constant value, or (for non-clang) no
   register found is marked optimized out
 - a parameter found in a register other than the expected one is marked
   unexpected_reg

When true_signature is enabled it reconstructs the real register-level
signature:
 - parameters that were optimized out are dropped from the signature
 - a parameter whose location cannot be tied to its expected register,
   wrong register, no register found, or a non-aggregate sitting on the
   stack - marks the function unexpected_reg so no untrustworthy signatur=
e
   is emitted;
 - an aggregate genuinely passed on the stack (passed_in_memory) is kept;
 - an aggregate split across registers via DW_OP_piece is kept whole when
   it is fully used or the next parameter still lands on its expected
   register, otherwise it is rewritten to the single member actually pass=
ed
   in a register (true_sig_*).

Together with the decoding commit this replaces the previous inline,
per-parameter register check in parameter__new().

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 dwarf_loader.c | 152 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 149 insertions(+), 3 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 01954c6..7ccad93 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -3013,6 +3013,150 @@ static void ftype__recode_dwarf_types(struct tag =
*tag, struct cu *cu)
 	}
 }
=20
+static struct parameter *ftype__next_parameter(struct ftype *ftype, stru=
ct parameter *parm)
+{
+	if (parm->tag.node.next =3D=3D &ftype->parms)
+		return NULL;
+	return list_entry(parm->tag.node.next, struct parameter, tag.node);
+}
+
+static int parameter__abi_slots(const struct parameter *parm, const stru=
ct cu *cu)
+{
+	int slots;
+
+	if (!cu->agg_use_two_regs || parm->type_byte_size <=3D cu->addr_size)
+		return 1;
+
+	slots =3D (parm->type_byte_size + cu->addr_size - 1) / cu->addr_size;
+	return slots > 0 ? slots : 1;
+}
+
+static bool parameter__has_piece_info(const struct parameter *parm)
+{
+	return parm->first_reg_fields || parm->second_reg_fields;
+}
+
+static bool parameter__uses_full_aggregate(const struct parameter *parm)
+{
+	return parm->first_reg_fields && parm->second_reg_fields;
+}
+
+static bool ftype__next_parameter_preserves_slots(struct ftype *ftype, s=
truct parameter *parm,
+						  int reg_idx, int slots, struct cu *cu)
+{
+	struct parameter *next =3D ftype__next_parameter(ftype, parm);
+	int next_reg_idx;
+
+	if (!next || next->loc_reg =3D=3D PARAMETER_UNKNOWN_REG)
+		return false;
+
+	next_reg_idx =3D reg_idx + slots;
+	return next_reg_idx < cu->nr_register_params &&
+	       next->loc_reg =3D=3D cu->register_params[next_reg_idx];
+}
+
+static bool parameter__apply_true_sig_member(struct parameter *parm, str=
uct cu *cu)
+{
+	struct dwarf_tag tmp =3D {};
+	struct dwarf_tag *dtype;
+
+	if (!parm->true_sig_member_name || parm->true_sig_type =3D=3D 0)
+		return false;
+
+	tmp.type =3D parm->true_sig_type;
+	tmp.from_types_section.type =3D parm->true_sig_type_from_types;
+	dtype =3D __dwarf_cu__find_type_by_ref(cu->priv, tmp.type, tmp.from_typ=
es_section.type);
+	if (!dtype)
+		return false;
+
+	parm->tag.type =3D dtype->small_id;
+	return true;
+}
+
+static void function__analyze_parameter_locations(struct function *fn, s=
truct cu *cu,
+						  struct conf_load *conf)
+{
+	struct ftype *ftype =3D &fn->proto;
+	struct parameter *pos;
+	bool true_sig_enabled =3D conf->true_signature;
+	int reg_idx =3D 0;
+
+	ftype__for_each_parameter(ftype, pos) {
+		bool consumes_register =3D true;
+		bool regs_available =3D reg_idx < cu->nr_register_params;
+		int slots =3D parameter__abi_slots(pos, cu);
+		int expected_reg =3D regs_available ? cu->register_params[reg_idx] : -=
1;
+		int reg_slots =3D pos->passed_in_memory ? 1 : slots;
+
+		if (pos->has_loc) {
+			if (true_sig_enabled && pos->loc_const_value) {
+				pos->optimized =3D 1;
+				consumes_register =3D false;
+				goto next;
+			}
+
+			if (!regs_available) {
+				consumes_register =3D false;
+				goto next;
+			}
+
+			if (true_sig_enabled && pos->loc_stack) {
+				if (pos->passed_in_memory)
+					consumes_register =3D false;
+				else
+					pos->unexpected_reg =3D 1;
+				goto next;
+			}
+
+			if (pos->loc_reg =3D=3D PARAMETER_UNKNOWN_REG) {
+				if (true_sig_enabled)
+					pos->unexpected_reg =3D 1;
+				else
+					pos->optimized =3D 1;
+				goto next;
+			}
+
+			if (expected_reg >=3D 0 && expected_reg !=3D pos->loc_reg) {
+				pos->unexpected_reg =3D 1;
+				goto next;
+			}
+
+			if (true_sig_enabled && parameter__has_piece_info(pos)) {
+				if (parameter__uses_full_aggregate(pos)) {
+					reg_idx +=3D slots;
+					continue;
+				}
+
+				if (ftype__next_parameter_preserves_slots(ftype, pos, reg_idx, slots=
, cu)) {
+					pos->true_sig_member_name =3D 0;
+					reg_idx +=3D slots;
+					continue;
+				}
+
+				if (parameter__apply_true_sig_member(pos, cu)) {
+					reg_idx++;
+					continue;
+				}
+			}
+		} else if (pos->has_const_value && !cu->producer_clang) {
+			pos->optimized =3D 1;
+		} else if (true_sig_enabled) {
+			if (regs_available &&
+			    ftype__next_parameter_preserves_slots(ftype, pos, reg_idx, slots,=
 cu)) {
+				reg_idx +=3D slots;
+				continue;
+			}
+
+			pos->optimized =3D 1;
+			consumes_register =3D false;
+		}
+
+next:
+		if (consumes_register)
+			reg_idx +=3D reg_slots;
+	}
+}
+
 static void lexblock__recode_dwarf_types(struct lexblock *tag, struct cu=
 *cu)
 {
 	struct tag *pos;
@@ -3288,7 +3432,7 @@ static bool param__is_struct(struct cu *cu, struct =
tag *tag)
 	}
 }
=20
-static int cu__resolve_func_ret_types_optimized(struct cu *cu)
+static int cu__resolve_func_ret_types_optimized(struct cu *cu, struct co=
nf_load *conf)
 {
 	struct ptr_table *pt =3D &cu->functions_table;
 	uint32_t i;
@@ -3299,6 +3443,8 @@ static int cu__resolve_func_ret_types_optimized(str=
uct cu *cu)
 		struct function *fn =3D tag__function(tag);
 		bool has_unexpected_reg =3D false, has_struct_param =3D false;
=20
+		function__analyze_parameter_locations(fn, cu, conf);
+
 		/* mark function as optimized if parameter is, or
 		 * if parameter does not have a location; at this
 		 * point location presence has been marked in
@@ -3477,7 +3623,7 @@ static int die__process_and_recode(Dwarf_Die *die, =
struct cu *cu, struct conf_lo
 	if (ret !=3D 0)
 		return ret;
=20
-	return cu__resolve_func_ret_types_optimized(cu);
+	return cu__resolve_func_ret_types_optimized(cu, conf);
 }
=20
 static int class_member__cache_byte_size(struct tag *tag, struct cu *cu,
@@ -4240,7 +4386,7 @@ static int cus__merge_and_process_cu(struct cus *cu=
s, struct conf_load *conf,
 	 * encoded in another subprogram through abstract_origin
 	 * tag. Let us visit all subprograms again to resolve this.
 	 */
-	if (cu__resolve_func_ret_types_optimized(cu) !=3D LSK__KEEPIT)
+	if (cu__resolve_func_ret_types_optimized(cu, conf) !=3D LSK__KEEPIT)
 		goto out_abort;
=20
 	cu__finalize(cu, cus, conf);
--=20
2.53.0-Meta

