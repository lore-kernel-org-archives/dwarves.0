Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F5544C4F0
	for <dwarves@vger.kernel.org>; Fri, 25 Sep 2026 21:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790372195; cv=none; b=Z3sYMK21RedvStEv/hndY36VbF8fYQrypWraalGs9kszOfZbdn0d92Zb/hQnosGc5qSAYbM35+DThlo2VU8VwVhtZRGLTA34Y1duLd7ZawYqKBywSMukwnqfvJeMMw28IfsPvvpsSPkrAoTHy7nMWC5VzuURP8J3S3Vrofpdcqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790372195; c=relaxed/simple;
	bh=JZwiaVgiIJbH8gFfFR2g3WyYsOdDfVPB1yeqcE/omyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gVHpE3OVCWS2W3bbtB9UMrCdEHb8SLTFJgGYmsV4QqlbBfuaWKHFC+m5cfuL+qGlTpjbKnFKpcShcDgArP11b8JVxSgUH6lIxdYLOKgWGdsZmeCaflgSJHKcZSPodn2/OLY2HO+VPKTsCCyE89ULV03Cxcz8wCZKCElTLXEeNec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 9C88F2D343D4DC; Fri, 25 Sep 2026 14:36:19 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH dwarves 1/2] dwarf_loader: Trust the entry value register over the first location entry
Date: Fri, 25 Sep 2026 14:36:19 -0700
Message-ID: <20260925213619.2187751-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A parameter's location list describes where the parameter lives from each
entry's start address on, and a producer may leave the entry PC out of th=
e
list entirely, as clang does when the parameter is moved into a
callee-saved register during the prologue.  Here is @lazy, the second
parameter of a kfunc in a clang 21.1.8 x86-64 vmlinux:

  0x00dcf39e: DW_TAG_subprogram
                DW_AT_low_pc    (0xffffffff81553d70)
                DW_AT_high_pc   (0xffffffff81553ee3)
                ...
                DW_AT_name      ("scx_bpf_task_set_lazy_resched")
                DW_AT_decl_file ("kernel/sched/ext/ext.c")
                ...

  0x00dcf3c3:   DW_TAG_formal_parameter
                  DW_AT_location        (indexed (0x1491) loclist =3D 0x0=
01e825f:
                     [0xffffffff81553d8b, 0xffffffff81553e5f): DW_OP_reg6=
 RBP
                     [0xffffffff81553e5f, 0xffffffff81553ec8): DW_OP_entr=
y_value(DW_OP_reg4 RSI), DW_OP_stack_value
                     [0xffffffff81553ec8, 0xffffffff81553eca): DW_OP_reg6=
 RBP
                     [0xffffffff81553eca, 0xffffffff81553ecc): DW_OP_entr=
y_value(DW_OP_reg4 RSI), DW_OP_stack_value
                     [0xffffffff81553ecc, 0xffffffff81553ee3): DW_OP_reg6=
 RBP)
                  DW_AT_name    ("lazy")
                  DW_AT_decl_file       ("kernel/sched/ext/ext.c")
                  DW_AT_decl_line       (9747)
                  DW_AT_type    (0x00d59515 "bool")

@lazy arrives in RSI, but the function starts at 0xffffffff81553d70 while
the list starts at 0xffffffff81553d8b: the range covering the function
entry is missing and the first entry present names RBP, the register @laz=
y
was moved to.  parameter__decode_location() took the register from that
first entry and only consulted DW_OP_entry_value when no register had bee=
n
found yet, so loc_reg ended up as RBP, the parameter looked like it was i=
n
an unexpected register and the whole function was dropped from BTF:

  scx_bpf_task_set_lazy_resched : skipping BTF encoding of function due t=
o
  unexpected register usage for parameter

which in turn breaks the kernel build for a kfunc, the failure Tejun Heo
reported:

  WARN: resolve_btfids: no BTF func for kfunc scx_bpf_task_set_lazy_resch=
ed in scx_kfunc_ids_any
  WARN: resolve_btfids: unresolved symbol scx_bpf_task_set_lazy_resched

DW_OP_entry_value(DW_OP_regN) says the parameter still holds the value re=
gN
had on entry to the function, so regN is by definition the register the
parameter was passed in.  That is better evidence than the first location
list entry, so prefer it.  Parameters described by DW_OP_piece keep the
registers the pieces name, since a single entry value register cannot
describe a multi-register aggregate.

On the vmlinux above this encodes 34 more functions, among them the kfunc=
,
and drops none.

Reported-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 dwarf_loader.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 1e5363a..2c6850e 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1736,6 +1736,11 @@ static void parameter__set_loc_reg(struct paramete=
r *parm, int reg)
 		parm->loc_reg =3D reg;
 }
=20
+static bool parameter__has_piece_info(const struct parameter *parm)
+{
+	return parm->first_reg_fields || parm->second_reg_fields;
+}
+
 static void parameter__set_field_bit(unsigned long *fields, int byte_off=
set)
 {
 	if (byte_offset >=3D 0 && byte_offset < (int)(sizeof(*fields) * 8))
@@ -1848,6 +1853,7 @@ static void parameter__decode_location(Dwarf_Attrib=
ute *attr, struct conf_load *
 				       struct cu *cu, Dwarf_Die *die,
 				       struct parameter *parm)
 {
+	int entry_value_reg =3D PARAMETER_UNKNOWN_REG;
 	Dwarf_Addr base, start, end;
 	Dwarf_Op *expr, *entry_ops;
 	Dwarf_Attribute entry_attr;
@@ -1893,15 +1899,34 @@ static void parameter__decode_location(Dwarf_Attr=
ibute *attr, struct conf_load *
 			break;
 		case DW_OP_entry_value:
 		case DW_OP_GNU_entry_value:
-			if (dwarf_getlocation_attr(attr, expr, &entry_attr) =3D=3D 0 &&
+			if (entry_value_reg =3D=3D PARAMETER_UNKNOWN_REG &&
+			    dwarf_getlocation_attr(attr, expr, &entry_attr) =3D=3D 0 &&
 			    dwarf_getlocation(&entry_attr, &entry_ops, &entry_len) =3D=3D 0 &=
&
 			    entry_len =3D=3D 1 && dwarf_op__is_reg(entry_ops->atom))
-				parameter__set_loc_reg(parm, entry_ops->atom);
+				entry_value_reg =3D entry_ops->atom;
 			break;
 		}
 	}
 	libdw__lock_unlock();
=20
+	/*
+	 * DW_OP_entry_value(DW_OP_regN) says the parameter still holds the
+	 * value regN had on entry to the function, so regN is the register the
+	 * parameter was passed in.  Prefer it over the register named by the
+	 * first location list entry: that entry only describes where the
+	 * parameter lives from its own start address on, and producers do omit
+	 * the entry PC from the list, as clang does when the parameter is
+	 * moved into a callee-saved register during the prologue: the first
+	 * entry then names that register instead of the argument register,
+	 * making the whole function look like it uses unexpected registers.
+	 *
+	 * Parameters described by pieces keep the register(s) the pieces name;
+	 * a single entry value register cannot describe a multi-register
+	 * aggregate.
+	 */
+	if (entry_value_reg !=3D PARAMETER_UNKNOWN_REG && !parameter__has_piece=
_info(parm))
+		parm->loc_reg =3D entry_value_reg;
+
 	parameter__finish_piece_decode(parm, die, conf, cu);
 }
=20
@@ -3692,11 +3717,6 @@ static int parameter__align_reg_idx(const struct p=
arameter *parm, int reg_idx,
 	return (reg_idx + align - 1) & ~(align - 1);
 }
=20
-static bool parameter__has_piece_info(const struct parameter *parm)
-{
-	return parm->first_reg_fields || parm->second_reg_fields;
-}
-
 static bool parameter__uses_full_aggregate(const struct parameter *parm)
 {
 	return parm->first_reg_fields && parm->second_reg_fields;
--=20
2.53.0-Meta

