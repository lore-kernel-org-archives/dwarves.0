Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDBE233D72
	for <dwarves@vger.kernel.org>; Fri,  8 Nov 2024 18:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731089135; cv=none; b=ostN165diKf2MVL1qL6S9UnJt739o/rybUTF5hIY5Bj7ooAgM83EDoWfT9aWmg/Fk2X1DGIo6ajiwESGhpSQwVQk5Y3bgNp4EgDJTy1fjmFEOsIWtNeGfYhRu8ZScDERH0KFUvMdrRPgkgFz+alNx49FwnDKYUIkMMVe91lR2xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731089135; c=relaxed/simple;
	bh=cuiy5GYjVBQIbA1G3tU1eosWyRaIYEfuH4DMlYdEvYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tg/3zthx8ZRfw8Nyj8KcfQOlC00vGRN0/WzbWtjUyhyEGZcvDlMY37ywOJ6PNSwlyjPhoAUAtueuqerqBi2K5UnT+qT2iC1ZQF0y8VNklbblRBpHdRggIrkNMBGcxiDGmo2lq8lEBA4bkyYWKJKVkkCYB8zsUnr4RrB84/nsgpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id CBE97ADDC53F; Fri,  8 Nov 2024 10:05:19 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com
Subject: [PATCH dwarves 2/3] dwarf_loader: Refactor function check_dwarf_locations()
Date: Fri,  8 Nov 2024 10:05:19 -0800
Message-ID: <20241108180519.1198396-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241108180508.1196431-1-yonghong.song@linux.dev>
References: <20241108180508.1196431-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The newly-added function check_dwarf_locations() supports two variants
of implementations: elfutils "version < 157" and "version >=3D 157".
The "version < 157" supports one single location (dwarf_getlocation())
and "version >=3D 157" supports location lists (dwarf_getlocations()).

Currently, even for dwarf_getlocations(), only the first location
and its first expression is checked. In the subsequent patch, all
locations and all expressions may be changed. So this patch refactors
the code such that two different implementations (based on elfutils
versions) are clearly separated. This makes subsequent change cleaner.

No functional change.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 dwarf_loader.c | 40 +++++++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 4bb9096..e0b8c11 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1160,22 +1160,47 @@ static struct template_parameter_pack *template_p=
arameter_pack__new(Dwarf_Die *d
 static bool check_dwarf_locations(Dwarf_Attribute *attr, struct paramete=
r *parm,
 				  struct cu *cu, int param_idx)
 {
+	int expected_reg =3D cu->register_params[param_idx];
 	Dwarf_Addr base, start, end;
 	struct location loc;
+	Dwarf_Op *expr;
=20
+	if (!parm->has_loc)
+		return false;
+
+#if _ELFUTILS_PREREQ(0, 157)
 	/* dwarf_getlocations() handles location lists; here we are
 	 * only interested in the first expr.
 	 */
-	if (parm->has_loc &&
-#if _ELFUTILS_PREREQ(0, 157)
-	    dwarf_getlocations(attr, 0, &base, &start, &end,
+	if (dwarf_getlocations(attr, 0, &base, &start, &end,
 			       &loc.expr, &loc.exprlen) > 0 &&
+		loc.exprlen !=3D 0) {
+		expr =3D loc.expr;
+
+		switch (expr->atom) {
+		case DW_OP_reg0 ... DW_OP_reg31:
+			/* mark parameters that use an unexpected
+			 * register to hold a parameter; these will
+			 * be problematic for users of BTF as they
+			 * violate expectations about register
+			 * contents.
+			 */
+			if (expected_reg >=3D 0 && expected_reg !=3D expr->atom)
+				parm->unexpected_reg =3D 1;
+			break;
+		default:
+			parm->optimized =3D 1;
+			break;
+		}
+
+		return true;
+	}
+
+	return false;
 #else
-	    dwarf_getlocation(attr, &loc.expr, &loc.exprlen) =3D=3D 0 &&
-#endif
+	if (dwarf_getlocation(attr, &loc.expr, &loc.exprlen) =3D=3D 0 &&
 		loc.exprlen !=3D 0) {
-		int expected_reg =3D cu->register_params[param_idx];
-		Dwarf_Op *expr =3D loc.expr;
+		expr =3D loc.expr;
=20
 		switch (expr->atom) {
 		case DW_OP_reg0 ... DW_OP_reg31:
@@ -1197,6 +1222,7 @@ static bool check_dwarf_locations(Dwarf_Attribute *=
attr, struct parameter *parm,
 	}
=20
 	return false;
+#endif
 }
=20
 static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
--=20
2.43.5

