Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770993D7D70
	for <dwarves@vger.kernel.org>; Mon,  9 Mar 2026 15:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773070358; cv=none; b=Vrc5LIC8qS5YqrYCcafrUIXYbHAFvCVzuPZF0e8sNJhV5PMbRGT/0Aa3w4gxZcu0kTEOzW23R+wI6nwbi83PQeKQTeRqsMwVaT+OWrOvz2/fhoAJks4qOVzeNk4sIWmFE0cCnVQNY3MuLRcEKx1gVLeYERuvtjjDtSiwSStPPaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773070358; c=relaxed/simple;
	bh=H1I2DIt1QJukpL239wNK12YDnP5dka3dIiStB9Eq7RI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V1KZdfs6rApC9CUhFK8u5icqF3491zl0UyryOmhBJFQtHHB7vNr+dOxvn8FTBbDau9Aif93+RtIXCYkpIty/YLIMSgX+POfp88gAutpfIIfHcuR7GRBihvSw5DbDb65Iu/hauFW8IRfUYrZeL/yM4uN49ci7KYmrmq7zVyZ18cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id D8D05249442F8; Mon,  9 Mar 2026 08:32:25 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH dwarves v2 2/9] dwarf_loader: Handle signatures with dead arguments
Date: Mon,  9 Mar 2026 08:32:25 -0700
Message-ID: <20260309153225.1918482-1-yonghong.song@linux.dev>
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

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 dwarf_loader.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 610b69e..1ced5e2 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1192,6 +1192,7 @@ static ptrdiff_t __dwarf_getlocations(Dwarf_Attribu=
te *attr,
=20
 struct func_info {
 	bool signature_changed;
+	int skip_idx;
 };
=20
 /* For DW_AT_location 'attr':
@@ -1264,13 +1265,28 @@ static struct parameter *parameter__new(Dwarf_Die=
 *die, struct cu *cu,
 	if (parm !=3D NULL) {
 		bool has_const_value;
 		Dwarf_Attribute attr;
+		int reg_idx;
=20
 		tag__init(&parm->tag, cu, die);
 		parm->name =3D attr_string(die, DW_AT_name, conf);
 		parm->idx =3D param_idx;
-		if (param_idx >=3D cu->nr_register_params || param_idx < 0)
+		if (param_idx < 0)
 			return parm;
-		if (cu->producer_clang && !info->signature_changed)
+		if (!cu->producer_clang && param_idx >=3D cu->nr_register_params)
+			return parm;
+		if (cu->producer_clang) {
+			if (!info->signature_changed)
+				return parm;
+			/* if true_signature is not enabled, mark parameter as
+			 * unexpected_reg since there is a skipped parameter before.
+			 */
+			if (!conf->true_signature && info->skip_idx) {
+				parm->unexpected_reg =3D 1;
+				return parm;
+			}
+		}
+		reg_idx =3D param_idx - info->skip_idx;
+		if (reg_idx >=3D cu->nr_register_params)
 			return parm;
 		/* Parameters which use DW_AT_abstract_origin to point at
 		 * the original parameter definition (with no name in the DIE)
@@ -1309,7 +1325,7 @@ static struct parameter *parameter__new(Dwarf_Die *=
die, struct cu *cu,
 		parm->has_loc =3D dwarf_attr(die, DW_AT_location, &attr) !=3D NULL;
=20
 		if (parm->has_loc) {
-			int expected_reg =3D cu->register_params[param_idx];
+			int expected_reg =3D cu->register_params[reg_idx];
 			int actual_reg =3D parameter__reg(&attr, expected_reg);
=20
 			if (actual_reg < 0)
@@ -1322,8 +1338,11 @@ static struct parameter *parameter__new(Dwarf_Die =
*die, struct cu *cu,
 				 * contents.
 				 */
 				parm->unexpected_reg =3D 1;
-		} else if (has_const_value) {
+		} else if (!cu->producer_clang && has_const_value) {
+			parm->optimized =3D 1;
+		} else if (cu->producer_clang) {
 			parm->optimized =3D 1;
+			info->skip_idx++;
 		}
 	}
=20
--=20
2.47.3

