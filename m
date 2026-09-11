Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD7D39AD49
	for <dwarves@vger.kernel.org>; Fri, 11 Sep 2026 04:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789099809; cv=none; b=IDoncEZiU3+TaYKAtx98vk06hwtTL4I7LyhBEzrqFoLIucj4NuZzW7e+ChQLhW4BJG41MSWMVlQaILGnp19YjOZayhSiFijpxF8hPb8VMAUXcr3bJlPB489b9WhZWcYiCxzN2q3Y/y21Rc70ltHk3yy7GvT2nI8+mPs/3TkCfZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789099809; c=relaxed/simple;
	bh=8OdVyEiEpqfcHPHMr01UY010bwuHudvQme8bbid58K4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dkhwXBPiuHsFyc93ygzBSoUOOxXHJ4FMmALNdXpTB1f5h/KaDFG14DEKjNHAN7ajjgMXZBGEdkcGLr77tQRaeB9lw/bNVYt0BSkxxXmfs70nyyv56Q9irPkxcuP3hoKSKuipmxAiWuOEBt5PurnUYdAWV9GhisgcrmrQT5R7Lv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id AFDD629FDA2C36; Thu, 10 Sep 2026 21:09:55 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH dwarves 1/2] dwarf_loader: Skip the argument register the arm64 ABI leaves as a hole
Date: Thu, 10 Sep 2026 21:09:55 -0700
Message-ID: <20260911040955.339939-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

arm64 requires an argument whose alignment is twice the register size to
start on an even-numbered argument register, so such an argument arriving
when the next free register is an odd one leaves that register unused:

  u64 f_odd(u64 a, __int128 v, u64 b);

passes a in x0, v in x2:x3 -- skipping x1 -- and b in x4.  The x86-64 ABI
has no such rule and packs v into rsi:rdx instead.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 dwarf_loader.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++---
 dwarves.h      |  1 +
 2 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 61ef52f..81c2076 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1501,6 +1501,23 @@ static bool arch__agg_use_two_regs(const GElf_Ehdr=
 *ehdr)
 	}
 }
=20
+/*
+ * Some ABIs require an argument whose alignment is twice the register s=
ize to
+ * start on an even-numbered argument register, leaving a hole when the =
next
+ * free register is an odd one. For example, on arm64,
+ *	u64 f(u64 a, __int128 v, u64 b)
+ * passes a in x0, v in x2:x3 -- skipping x1 -- and b in x4.
+ */
+static bool arch__arg_align_two_regs(const GElf_Ehdr *ehdr)
+{
+	switch (ehdr->e_machine) {
+	case EM_AARCH64:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static struct template_type_param *template_type_param__new(Dwarf_Die *d=
ie, struct cu *cu, struct conf_load *conf)
 {
 	struct template_type_param *ttparm =3D tag__alloc(cu, sizeof(*ttparm));
@@ -3634,6 +3651,28 @@ static int parameter__abi_slots(const struct param=
eter *parm, const struct cu *c
 	return slots > 0 ? slots : 1;
 }
=20
+static int parameter__abi_reg_align(const struct parameter *parm, const =
struct cu *cu)
+{
+	struct tag *type;
+
+	if (!cu->arg_align_two_regs || parm->type_byte_size <=3D cu->addr_size)
+		return 1;
+
+	type =3D tag__strip_typedefs_and_modifiers(&parm->tag, cu);
+	if (type =3D=3D NULL)
+		return 1;
+
+	return tag__natural_alignment(type, cu) > cu->addr_size ? 2 : 1;
+}
+
+static int parameter__align_reg_idx(const struct parameter *parm, int re=
g_idx,
+				    const struct cu *cu)
+{
+	int align =3D parameter__abi_reg_align(parm, cu);
+
+	return (reg_idx + align - 1) & ~(align - 1);
+}
+
 static bool parameter__has_piece_info(const struct parameter *parm)
 {
 	return parm->first_reg_fields || parm->second_reg_fields;
@@ -3653,7 +3692,7 @@ static bool ftype__next_parameter_preserves_slots(s=
truct ftype *ftype, struct pa
 	if (!next || next->loc_reg =3D=3D PARAMETER_UNKNOWN_REG)
 		return false;
=20
-	next_reg_idx =3D reg_idx + slots;
+	next_reg_idx =3D parameter__align_reg_idx(next, reg_idx + slots, cu);
 	return next_reg_idx < cu->nr_register_params &&
 	       next->loc_reg =3D=3D cu->register_params[next_reg_idx];
 }
@@ -3702,6 +3741,7 @@ static void function__match_clang_parameter_locatio=
ns(struct ftype *ftype, struc
 		if (pos->passed_in_memory)
 			continue;
=20
+		reg_idx =3D parameter__align_reg_idx(pos, reg_idx, cu);
 		if (reg_idx >=3D cu->nr_register_params)
 			break;
=20
@@ -3732,11 +3772,17 @@ static void function__analyze_parameter_locations=
(struct function *fn, struct cu
=20
 	ftype__for_each_parameter(ftype, pos) {
 		bool consumes_register =3D true;
-		bool regs_available =3D reg_idx < cu->nr_register_params;
+		bool regs_available;
 		int slots =3D parameter__abi_slots(pos, cu);
-		int expected_reg =3D regs_available ? cu->register_params[reg_idx] : -=
1;
+		int expected_reg;
 		int reg_slots =3D pos->passed_in_memory ? 1 : slots;
=20
+		if (!pos->passed_in_memory)
+			reg_idx =3D parameter__align_reg_idx(pos, reg_idx, cu);
+
+		regs_available =3D reg_idx < cu->nr_register_params;
+		expected_reg =3D regs_available ? cu->register_params[reg_idx] : -1;
+
 		if (pos->has_loc) {
 			if (true_sig_enabled && pos->loc_const_value) {
 				pos->optimized =3D 1;
@@ -4467,6 +4513,7 @@ static int cu__set_common(struct cu *cu, struct con=
f_load *conf,
 	cu->little_endian =3D ehdr.e_ident[EI_DATA] =3D=3D ELFDATA2LSB;
 	cu->nr_register_params =3D arch__nr_register_params(&ehdr);
 	cu->agg_use_two_regs =3D arch__agg_use_two_regs(&ehdr);
+	cu->arg_align_two_regs =3D arch__arg_align_two_regs(&ehdr);
 	arch__set_register_params(&ehdr, cu);
 	return 0;
 }
diff --git a/dwarves.h b/dwarves.h
index df77f1e..70adbbf 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -304,6 +304,7 @@ struct cu {
 	uint8_t		 little_endian:1;
 	uint8_t		 producer_clang:1;
 	uint8_t		 agg_use_two_regs:1;	/* An aggregate like {long a; long b;} */
+	uint8_t		 arg_align_two_regs:1;	/* An over-aligned arg starts on an eve=
n register */
 	uint8_t		 nr_register_params;
 	int		 register_params[ARCH_MAX_REGISTER_PARAMS];
 	int		 functions_saved;
--=20
2.53.0-Meta

