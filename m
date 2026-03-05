Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E1D364EA2
	for <dwarves@vger.kernel.org>; Thu,  5 Mar 2026 22:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772751330; cv=none; b=EEkdACaUaoxiLJxsudUh10zTlAqH/QyhghVAPYn8LR4bb21Mc7xq5JqWud7xJPVklFS6EjFfT1AAMl3jMpu7/jsJfBk9QAhey4470ltjLDiIDiz9UjQHbrI+zfZRDEQqas5TXs/yf18AhvNnQyv3Ub7i5yg7Bi6K++Jiw6a1yIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772751330; c=relaxed/simple;
	bh=4Rcb8G2r9lqox+tpDyvmKJ32oAtGPLJLyDWaoj8LIQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TzPDy72B1DFNoVnS5S5x7r4GK/4IjVk4f7rF2MH04ZWLKUyiP/RJwBlzr4+AHzciOHePef+vGRFFSOfz+oQQXiTH4OgSGqQaAiHU7vfnZSFc0HPle6J7lMxJ0l1XjmBFDwLcUhFTz1UMdwIn5F5jXZOQFZUWmvxC/fqktovrtMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 5695B22AAAA80; Thu,  5 Mar 2026 14:55:16 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH dwarves 4/9] dwarf_laoder: Handle locations with DW_OP_fbreg
Date: Thu,  5 Mar 2026 14:55:16 -0800
Message-ID: <20260305225516.1153725-1-yonghong.song@linux.dev>
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
 dwarf_loader.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 7da3926..3d9b626 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1196,6 +1196,7 @@ struct func_info {
 };
=20
 #define	PARM_DEFAULT_FAIL	-1
+#define	PARM_FBREG_FAIL		-2
=20
 /* For DW_AT_location 'attr':
  * - if first location is DW_OP_regXX with expected number, return the r=
egister;
@@ -1240,6 +1241,15 @@ static int parameter__reg(Dwarf_Attribute *attr, i=
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
+			ret =3D PARM_FBREG_FAIL;
+			break;
 		/* match DW_OP_entry_value(DW_OP_regXX) at any location */
 		case DW_OP_entry_value:
 		case DW_OP_GNU_entry_value:
@@ -1332,7 +1342,7 @@ static struct parameter *parameter__new(Dwarf_Die *=
die, struct cu *cu,
=20
 			if (actual_reg =3D=3D PARM_DEFAULT_FAIL)
 				parm->optimized =3D 1;
-			else if (expected_reg >=3D 0 && expected_reg !=3D actual_reg)
+			else if (actual_reg =3D=3D PARM_FBREG_FAIL || (expected_reg >=3D 0 &&=
 expected_reg !=3D actual_reg))
 				/* mark parameters that use an unexpected
 				 * register to hold a parameter; these will
 				 * be problematic for users of BTF as they
--=20
2.47.3

