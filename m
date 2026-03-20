Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CBE32ABC0
	for <dwarves@vger.kernel.org>; Fri, 20 Mar 2026 19:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774033794; cv=none; b=YSqbS2yrqrDypEOTutXXB2CCoJS/782fctAF7Dm83lMwwprJvgKU+SwNtJ3hsoyL04V3Tb0rKp40sVRfrDNspZeCVOrephicT/mXrjDreke23cJZu1mtvj2wDCHBZwPjjeDV7MP7l5FZlC5w7d7DJlBpP22PEiYv7h27c1ehQ7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774033794; c=relaxed/simple;
	bh=X+BV84ZzKnti1yFZH07fbCzlvx0avw0P7aGd4Z33PJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GkE0wn9cz73JGouFQrgu9k7st/HbOrN9FEdqp0KUaFuDp1WgeaWkhoT2Jscpv5I+WoJlrh+Te31l+u1dhg7QXejaqqkoSFv1vI0XuCXif+fRkNLdqOVj5tJmOCQQz9V9L3PaYAT6BXF9MQ16cdTskKoejBaIFwBtRBw4htXT23Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 124572A7EAD44; Fri, 20 Mar 2026 12:09:38 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH dwarves v3 4/9] dwarf_laoder: Handle locations with DW_OP_fbreg
Date: Fri, 20 Mar 2026 12:09:38 -0700
Message-ID: <20260320190938.1972050-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260320190917.1970524-1-yonghong.song@linux.dev>
References: <20260320190917.1970524-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

DW_OP_fbreg means the parameter value will be stored on the
stack. So the corresponding parameter register is not used.
For example:

  0x071f7717:   DW_TAG_subprogram
                  DW_AT_name      ("jent_health_failure")
                  DW_AT_calling_convention        (DW_CC_nocall)
                  DW_AT_type      (0x071f7626 "unsigned int")
                  ...

  0x071f7728:     DW_TAG_formal_parameter
                    DW_AT_location        (DW_OP_fbreg -8)
                    DW_AT_name    ("ec")
                    DW_AT_type    (0x071f7ab6 "rand_data *")
                    ...

  0x071f7734:     NULL

In the above, the parameter 'ec' type is a pointer so it perfectly fits
into a register. But the location uses 'DW_OP_fbreg -8' which prevents
from generating a function with true signatures.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 dwarf_loader.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 7b3f551..c259417 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1196,6 +1196,7 @@ struct func_info {
 };
=20
 #define	PARM_DEFAULT_FAIL	-1
+#define	PARM_UNEXPECTED		-2
=20
 /* For DW_AT_location 'attr':
  * - if first location is DW_OP_regXX with expected number, return the r=
egister;
@@ -1204,7 +1205,8 @@ struct func_info {
  *   list, return the register; otherwise save register for later return
  * - otherwise if no register was found for locations, return PARM_DEFAU=
LT_FAIL.
  */
-static int parameter__reg(Dwarf_Attribute *attr, int expected_reg)
+static int parameter__reg(Dwarf_Attribute *attr, int expected_reg, struc=
t conf_load *conf,
+			  struct func_info *info)
 {
 	Dwarf_Addr base, start, end;
 	Dwarf_Op *expr, *entry_ops;
@@ -1240,6 +1242,16 @@ static int parameter__reg(Dwarf_Attribute *attr, i=
nt expected_reg)
 			if (ret =3D=3D expected_reg)
 				goto out;
 			break;
+		case DW_OP_fbreg:
+			/* The locaiton like
+			 *   DW_AT_location        (DW_OP_fbreg +<num>)
+			 * indicates that the parameter is on the stack. But it is possible
+			 * that the parameter can fit in register(s). So conservatively
+			 * mark this parameter not suitable for true signatures.
+			 */
+			if (info->signature_changed && conf->true_signature)
+				ret =3D PARM_UNEXPECTED;
+			break;
 		/* match DW_OP_entry_value(DW_OP_regXX) at any location */
 		case DW_OP_entry_value:
 		case DW_OP_GNU_entry_value:
@@ -1327,11 +1339,11 @@ static struct parameter *parameter__new(Dwarf_Die=
 *die, struct cu *cu,
=20
 		if (parm->has_loc) {
 			int expected_reg =3D cu->register_params[reg_idx];
-			int actual_reg =3D parameter__reg(&attr, expected_reg);
+			int actual_reg =3D parameter__reg(&attr, expected_reg, conf, info);
=20
 			if (actual_reg =3D=3D PARM_DEFAULT_FAIL)
 				parm->optimized =3D 1;
-			else if (expected_reg >=3D 0 && expected_reg !=3D actual_reg)
+			else if (actual_reg =3D=3D PARM_UNEXPECTED || (expected_reg >=3D 0 &&=
 expected_reg !=3D actual_reg))
 				/* mark parameters that use an unexpected
 				 * register to hold a parameter; these will
 				 * be problematic for users of BTF as they
--=20
2.52.0

