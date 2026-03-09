Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E923D7D70
	for <dwarves@vger.kernel.org>; Mon,  9 Mar 2026 15:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773070368; cv=none; b=r83KY8m9PIeUx6Y0atYS5q+zwjajdJ2wn6X08Khq2R63/GhjY2h97JQvyIuHhU+ZKbfyQA9+i9d9iW7ynQyZ20NQJ7ojZWPywdx1kOcLksf0tEtF4BiX8Z1N0D7D0byAJxBeNrXASna1wP8pxtpbK63ZnTi8Pqg+AeABL20M5Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773070368; c=relaxed/simple;
	bh=gnYZLY+Woj8rWs+RO4xWLRxCNIHeQIKBF0zm5htDTWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u2ZbepN/B+FOpAICc7/RbK+sSnSmdG6Ej1GETtW+g3sr9NQNoQN1o79raCCgKDXAgPe66dao1wVjqe+FpACDWkOoVWBtMe9Ukzu7RJtcLBFQnAAfPCOsqX6Ep/kGXH5Fqmxb3zwV1cNCAjvhCveOBxB3U0AlcaJvD+qv4YTK+y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 278682494435E; Mon,  9 Mar 2026 08:32:36 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH dwarves v2 4/9] dwarf_laoder: Handle locations with DW_OP_fbreg
Date: Mon,  9 Mar 2026 08:32:36 -0700
Message-ID: <20260309153236.1918945-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260309153215.1917033-1-yonghong.song@linux.dev>
References: <20260309153215.1917033-1-yonghong.song@linux.dev>
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
 dwarf_loader.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 7da3926..d538607 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1196,6 +1196,7 @@ struct func_info {
 };
=20
 #define	PARM_DEFAULT_FAIL	-1
+#define	PARM_FAIL_CLANG		-2
=20
 /* For DW_AT_location 'attr':
  * - if first location is DW_OP_regXX with expected number, return the r=
egister;
@@ -1204,7 +1205,7 @@ struct func_info {
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
@@ -1240,6 +1241,16 @@ static int parameter__reg(Dwarf_Attribute *attr, i=
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
+			if (cu->producer_clang && conf->true_signature)
+				ret =3D PARM_FAIL_CLANG;
+			break;
 		/* match DW_OP_entry_value(DW_OP_regXX) at any location */
 		case DW_OP_entry_value:
 		case DW_OP_GNU_entry_value:
@@ -1328,11 +1339,11 @@ static struct parameter *parameter__new(Dwarf_Die=
 *die, struct cu *cu,
=20
 		if (parm->has_loc) {
 			int expected_reg =3D cu->register_params[reg_idx];
-			int actual_reg =3D parameter__reg(&attr, expected_reg);
+			int actual_reg =3D parameter__reg(&attr, expected_reg, cu, conf);
=20
 			if (actual_reg =3D=3D PARM_DEFAULT_FAIL)
 				parm->optimized =3D 1;
-			else if (expected_reg >=3D 0 && expected_reg !=3D actual_reg)
+			else if (actual_reg =3D=3D PARM_FAIL_CLANG || (expected_reg >=3D 0 &&=
 expected_reg !=3D actual_reg))
 				/* mark parameters that use an unexpected
 				 * register to hold a parameter; these will
 				 * be problematic for users of BTF as they
--=20
2.47.3

