Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DAD3314D2
	for <dwarves@vger.kernel.org>; Fri, 20 Mar 2026 19:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774033785; cv=none; b=SZXZlpboM7ECEDi8mDTKUTgK/8JivEt4UG2ynVpiiVNYbHmVZh9Q+g10s7KiePV0emLLDJw1CAW3HOMJa37p/kdHZo32qrRAPT49fsvD9yAWfiNU5hoHS6ufxopap5WEpzj4jZ99hLD7Kq+o3h1k1wt9LPBaWem/fX7hDEbC99g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774033785; c=relaxed/simple;
	bh=zcFQscBDswAelpsHw0NQpSHwQlpjn7RoznAsSiTN1rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AxB/UDq7XT/hQyGT//qKTHfL3nEKgnb3yIQNGQqmGUYjSHdpqFZjdSKv7gRMNsdBP2g/HoHJ6Ni0fR8f7b+i/4MF/f2fnDuBpzA+XUDd3grtoLGV8cF50BFL8hkUWuxSdYINkWk9OZ7sr7Y8h+kn6fBjxPk8UvFhUc6MXAirDUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id C182F2A7EACF6; Fri, 20 Mar 2026 12:09:27 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH dwarves v3 2/9] dwarf_loader: Handle signatures with dead arguments
Date: Fri, 20 Mar 2026 12:09:27 -0700
Message-ID: <20260320190927.1970829-1-yonghong.song@linux.dev>
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
 dwarf_loader.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 21f8bf1..a6e6587 100644
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
@@ -1264,6 +1265,7 @@ static struct parameter *parameter__new(Dwarf_Die *=
die, struct cu *cu,
 	if (parm !=3D NULL) {
 		bool has_const_value;
 		Dwarf_Attribute attr;
+		int reg_idx;
=20
 		tag__init(&parm->tag, cu, die);
 		parm->name =3D attr_string(die, DW_AT_name, conf);
@@ -1273,7 +1275,18 @@ static struct parameter *parameter__new(Dwarf_Die =
*die, struct cu *cu,
 		if (!info->signature_changed) {
 			if (cu->producer_clang || param_idx >=3D cu->nr_register_params)
 				return parm;
+		} else {
+			/* if true_signature is not enabled, mark parameter as
+			 * unexpected_reg since there is a skipped parameter before.
+			 */
+			if (!conf->true_signature && info->skip_idx) {
+				parm->unexpected_reg =3D 1;
+				return parm;
+			}
 		}
+		reg_idx =3D param_idx - info->skip_idx;
+		if (reg_idx >=3D cu->nr_register_params)
+			return parm;
 		/* Parameters which use DW_AT_abstract_origin to point at
 		 * the original parameter definition (with no name in the DIE)
 		 * are the result of later DWARF generation during compilation
@@ -1311,7 +1324,7 @@ static struct parameter *parameter__new(Dwarf_Die *=
die, struct cu *cu,
 		parm->has_loc =3D dwarf_attr(die, DW_AT_location, &attr) !=3D NULL;
=20
 		if (parm->has_loc) {
-			int expected_reg =3D cu->register_params[param_idx];
+			int expected_reg =3D cu->register_params[reg_idx];
 			int actual_reg =3D parameter__reg(&attr, expected_reg);
=20
 			if (actual_reg < 0)
@@ -1324,8 +1337,10 @@ static struct parameter *parameter__new(Dwarf_Die =
*die, struct cu *cu,
 				 * contents.
 				 */
 				parm->unexpected_reg =3D 1;
-		} else if (has_const_value) {
+		} else if (has_const_value || info->signature_changed) {
 			parm->optimized =3D 1;
+			if (info->signature_changed)
+				info->skip_idx++;
 		}
 	}
=20
--=20
2.52.0

