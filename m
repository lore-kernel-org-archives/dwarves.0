Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F7B3659E8
	for <dwarves@vger.kernel.org>; Thu,  5 Mar 2026 22:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772751335; cv=none; b=qMnFLdASMXGyiPUiITD9R5NsIvklPsv3g6vsWKP7VljAh5+NTeKSTyKRJ7O4vP7lqPwE0Fgwvo9z6CwBqHWJQxpn5m8FvtQcWnqqnMxmXoUTwpSlqK2JEUOziV7t2Lszzn0uVWyQTkUVBYYkgCMeKBfkPjwaNSohuFVytflCprA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772751335; c=relaxed/simple;
	bh=uODyuNdh7x5Jz8OLp0UbCOex0Lp+8dbJXwpLGBFAfQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N8Yqh+6jQvAOrCF1pT5Un9pQSvu/dJAKtLo2qNI6jyIfOfbaDtqkSok1grUaoNiEC0lCsixqlzOHZnuCz9pEL6tcpTnjxWmx5JuPUbNIzSBTR6PlDVb7ciYRBxnMqpNU1aBLt3WZM0QLaGI/sDRYaYbSg4rNdYWcuMqQ3vKJYPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 7824022AAAA9E; Thu,  5 Mar 2026 14:55:21 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH dwarves 5/9] dwarf_loader: Change exprlen checking condition in parameter__reg()
Date: Thu,  5 Mar 2026 14:55:21 -0800
Message-ID: <20260305225521.1153821-1-yonghong.song@linux.dev>
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

The change does not change any functionalities. But it allows
DW_OP_stack_value preserved in longer location list for future
parameter checking.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 dwarf_loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 3d9b626..684115d 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1226,7 +1226,7 @@ static int parameter__reg(Dwarf_Attribute *attr, in=
t expected_reg)
 		 * DW_OP_stack_value instructs interpreter to pop current value from
 		 * DWARF expression evaluation stack, and thus is not important here.
 		 */
-		if (exprlen > 1 && expr[exprlen - 1].atom =3D=3D DW_OP_stack_value)
+		if (exprlen =3D=3D 2 && expr[exprlen - 1].atom =3D=3D DW_OP_stack_valu=
e)
 			exprlen--;
=20
 		if (exprlen !=3D 1)
--=20
2.47.3

