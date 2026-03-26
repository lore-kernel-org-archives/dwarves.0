Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E00B38CFFB
	for <dwarves@vger.kernel.org>; Thu, 26 Mar 2026 01:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774488748; cv=none; b=W6YjnBAEEZKJXZ3uyBxKErx5nsVs2djgnwXZpFii369uwC5PKGQaj5SbEUOVnlhUpmXp3ZeTHb1orjPR2kSN80i61+KyqEdxigXRaVw0Cyb7cKMuUfyjkGfZzFYj/WHRwRGYb/ilO8t0BG5rwO3W7+bbBysCaYqyRi0i2tFEXZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774488748; c=relaxed/simple;
	bh=PANRz+fro1eKNpqVlSNAzAJAajwwVgEUZ7sJdyA8rLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FMQBzmNyOD5bKjAXpsaDEmrlr26EoqgACeub2le7cuQrIO7Iu0Pde6NoQHKFo7wTmJHGn9vZKP5u0bRgUiywJyvFiT3TAuOFCxlRGqfWqwJ08R69ISHBlXq+LTDkwhVmML4vqTjZIjfmHcYhTn3Xg9WpIoPay1QzGk1RwqzoqrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 342082E280FDA; Wed, 25 Mar 2026 18:32:15 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH dwarves v4 06/11] dwarf_loader: Change exprlen checking condition in parameter__reg()
Date: Wed, 25 Mar 2026 18:32:15 -0700
Message-ID: <20260326013215.2906073-1-yonghong.song@linux.dev>
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

The change does not change any functionalities. But it allows
DW_OP_stack_value preserved in longer location list for future
parameter checking.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 dwarf_loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 9e103ac..9b91590 100644
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
2.52.0

