Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9151271443
	for <dwarves@vger.kernel.org>; Sat, 23 May 2026 16:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779555465; cv=none; b=YemFh/khOf4T86UT6bM+j3P9MwWHErNQcpocLKRyQCythGoiG0EolYLWsRJqBvo2fR/aMD0u+h8MPpFLabvp2Z8+om3mOel03CkbxEq1oj77U1Ooo0P/Z3u0XbgFzZiplVuUNRMEp4gZcdc9wDCb+j4Mn/qoz7si/1e9n31bkrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779555465; c=relaxed/simple;
	bh=awSbOcGvKQii+5x9QecxE08J9G2u06TxH91nvrX2xLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=naNXmg+5Iquir2hNPV6R9eYsliV/E0o6NUfvlUp6qbvs9JzzqPS9oWinvX7KGlghp6A3yjo5U3iuqOuljUEk3rgl9jvuNSOwXlzAGfYlKbTDRxW0jbjPMAC+uhE6x8VK1GFrZE36GJFMHCq4xGWTUrh+qEFT0+sXU8t7vBCyGUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 4F8ABEE8FB9A2; Sat, 23 May 2026 09:57:33 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH dwarves v5 04/11] dwarf_loader: Refactor initial ret -1 to be macro PARM_DEFAULT_FAIL
Date: Sat, 23 May 2026 09:57:33 -0700
Message-ID: <20260523165733.1227236-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260523165712.1225231-1-yonghong.song@linux.dev>
References: <20260523165712.1225231-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Later on, More macro return values will be implemented to make
code easier to understand.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 dwarf_loader.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 49993ee..0b5530d 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1190,6 +1190,8 @@ static ptrdiff_t __dwarf_getlocations(Dwarf_Attribu=
te *attr,
 	return ret;
 }
=20
+#define	PARM_DEFAULT_FAIL	-1
+
 /* Max 20 register parameters, considering some parameters may be optimi=
zed out.  */
 #define	MAX_PRESCAN_PARAMS	20
=20
@@ -1281,7 +1283,7 @@ static int parameter__peek_first_reg(Dwarf_Die *die=
)
  *   otherwise save the register for later return
  * - if location DW_OP_entry_value(DW_OP_regXX) with expected number is =
in the
  *   list, return the register; otherwise save register for later return
- * - otherwise if no register was found for locations, return -1.
+ * - otherwise if no register was found for locations, return PARM_DEFAU=
LT_FAIL.
  */
 static int parameter__reg(Dwarf_Attribute *attr, int expected_reg)
 {
@@ -1291,7 +1293,7 @@ static int parameter__reg(Dwarf_Attribute *attr, in=
t expected_reg)
 	size_t exprlen, entry_len;
 	ptrdiff_t offset =3D 0;
 	int loc_num =3D -1;
-	int ret =3D -1;
+	int ret =3D PARM_DEFAULT_FAIL;
=20
 	/* use libdw__lock as dwarf_getlocation(s) has concurrency issues
 	 * when libdw is not compiled with experimental --enable-thread-safety
@@ -1403,7 +1405,7 @@ static struct parameter *parameter__new(Dwarf_Die *=
die, struct cu *cu,
 			int expected_reg =3D cu->register_params[reg_idx];
 			int actual_reg =3D parameter__reg(&attr, expected_reg);
=20
-			if (actual_reg < 0)
+			if (actual_reg =3D=3D PARM_DEFAULT_FAIL)
 				parm->optimized =3D 1;
 			else if (expected_reg >=3D 0 && expected_reg !=3D actual_reg)
 				/* mark parameters that use an unexpected
--=20
2.53.0-Meta

