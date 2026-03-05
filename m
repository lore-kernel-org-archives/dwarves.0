Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF257364E99
	for <dwarves@vger.kernel.org>; Thu,  5 Mar 2026 22:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772751323; cv=none; b=AoPkAUXAvaS/TipQD22kSlkSoDIyr28djo+cbnCARxdoPNnWG/kNLDBjAYY9C1Pk2KtrrA5BUh/x5mFcB9eAqAoRKmwBdvPvGCSNAlgV9yG1ZUvdkiZFKTY4lkQeV/jvVMF5CjQ21hY0v0fTC5qpnslFaRLfSh8fcB4NtuB15xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772751323; c=relaxed/simple;
	bh=el/jAe7QdJ/ypOCYkzyEsL/Q5bOa6lcn5Of60nvqwrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EKciGSu55QmP3po6C6Xhl6U4Zz8dJ4r1Dzxls1vr8mlGvkPnyQVqSN8jGF96H4NwOokBwCGFa1YY3qbynbkBZk5T4tO4qINWNdxr0/0OLaOqX/lfg4DUeyBiAt8o8v+7WbHYVUAEiHcAimaEGzAJjsxjC6CcIRToj1aLIhliFX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 36A1422AAAA55; Thu,  5 Mar 2026 14:55:11 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH dwarves 3/9] dwarf_loader: Refactor initial ret -1 to be macro PARM_DEFAULT_FAIL
Date: Thu,  5 Mar 2026 14:55:11 -0800
Message-ID: <20260305225511.1153597-1-yonghong.song@linux.dev>
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

Later on, More macro return values will be implemented to make
code easier to understand.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 dwarf_loader.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 1ced5e2..7da3926 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1195,12 +1195,14 @@ struct func_info {
 	int skip_idx;
 };
=20
+#define	PARM_DEFAULT_FAIL	-1
+
 /* For DW_AT_location 'attr':
  * - if first location is DW_OP_regXX with expected number, return the r=
egister;
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
@@ -1210,7 +1212,7 @@ static int parameter__reg(Dwarf_Attribute *attr, in=
t expected_reg)
 	size_t exprlen, entry_len;
 	ptrdiff_t offset =3D 0;
 	int loc_num =3D -1;
-	int ret =3D -1;
+	int ret =3D PARM_DEFAULT_FAIL;
=20
 	/* use libdw__lock as dwarf_getlocation(s) has concurrency issues
 	 * when libdw is not compiled with experimental --enable-thread-safety
@@ -1328,7 +1330,7 @@ static struct parameter *parameter__new(Dwarf_Die *=
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
2.47.3

