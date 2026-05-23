Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7CE3126B2
	for <dwarves@vger.kernel.org>; Sat, 23 May 2026 16:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779555476; cv=none; b=pMVyBgGfTHWuLvrmOnuMet9VlUBAD5qTerzAdOce9YO5YZFm/opDvDoliNzPONZwyaWCi8Cwu2Hr1UY1WIMPdn7l5jYEiR906zOXRWnyjHPp6DVz37kQKDZh3469G2ewcoTmeNDIDUQiTeqba29O9XBYf8As1ey5YdVqpCEjD0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779555476; c=relaxed/simple;
	bh=vLGWYSZmhgl19a644igY9grP9mSQlAV80hPIFvW55KM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Om64xSmm2QO+0I+lAejAlekcqc+UVeOh8ROzK0pqqbHANzB0UuGodTtp6AtYn/7Co9gJIIeE0masGTq7Xjvr5dhp92iL6u4tceou0Bg9+ihDQAHebtLNQRYhFwcocZYygvRB3N1pxRD23MSAN7kGxO1Ki7aMNZ+KlCswOjVQYBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 084D9EE9015CE; Sat, 23 May 2026 09:57:43 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH dwarves v5 06/11] dwarf_loader: Change exprlen checking condition in parameter__reg()
Date: Sat, 23 May 2026 09:57:43 -0700
Message-ID: <20260523165743.1227875-1-yonghong.song@linux.dev>
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

The change does not change any functionalities. But it allows
DW_OP_stack_value preserved in longer location list for future
parameter checking.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 dwarf_loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index bf8b973..4b65e30 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1308,7 +1308,7 @@ static int parameter__reg(Dwarf_Attribute *attr, in=
t expected_reg, struct conf_l
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
2.53.0-Meta

