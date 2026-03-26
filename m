Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4525B211A05
	for <dwarves@vger.kernel.org>; Thu, 26 Mar 2026 01:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774488739; cv=none; b=nDB07w/ztNnl+TqsEH2U4JNBqmIhMu7aOUlhF7ja5ihWCahrz3QQShoAqlWYUOG3c3NrWk1MalGKNYJvmB+scfA1K76C2MAjxPa8JEIbw36B/Vm7HT8AU/9S2pSyO9SRfu/gywyrzCrzUbO82JA8akpNWb86845UgfVOmhnbUl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774488739; c=relaxed/simple;
	bh=ORznJtcDeB2xEbX1NqQgMEwuzyg/N22ir6CqW3SoT7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ONcTWqK5U09UaShzw8T5kWAkEkh6qkXT+5rSKoz2f6vVg53ZNtBUeqCEVQMW5y4qrVINnS2UVkO7pjXCMcp1jDc/ZV4ngNG43T5o/pXD9TLfXlBsI58ePTnF5dHgfmc8cY0/w7sp3TwMuRQaHKdw7hY/utoUV5L1ffuOjD61nrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id E22FA2E280F6B; Wed, 25 Mar 2026 18:32:04 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH dwarves v4 04/11] dwarf_loader: Refactor initial ret -1 to be macro PARM_DEFAULT_FAIL
Date: Wed, 25 Mar 2026 18:32:04 -0700
Message-ID: <20260326013204.2904431-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260326013144.2901265-1-yonghong.song@linux.dev>
References: <20260326013144.2901265-1-yonghong.song@linux.dev>
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
index c1b7763..c8aeca2 100644
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
2.52.0

