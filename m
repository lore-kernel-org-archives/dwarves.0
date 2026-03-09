Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AA13D75C6
	for <dwarves@vger.kernel.org>; Mon,  9 Mar 2026 15:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773070370; cv=none; b=mh2cV6uYP4nAcRwfeDCly48MS0EI73B6lI1nQI4G04A3oVzboIR2PfYYBJ0SUzkF8DkirMx9qdKg2WI3TmcA93mqMpvO+a7WcWFNhJ4YHb1pM9izVpB/1KMxcEqNigrIC1omqgegMXvCyb9r7aJEbVu3Gz9HC2IKFZCZeClrf28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773070370; c=relaxed/simple;
	bh=O+y0C4p4L19nDYSPSHBk6LjmInFTppb+/DZ/TQIF37M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tw3H8yGf/Gn4KwORds5euK2Z5SwT/sCG+H1CVANJvUfy+eC++W9fv8Qa9lHll/aXO7METHF909KF68FUg3XWKNCw+ewmxnb7/P/4oUqwBJCC6SLEpL1H3TgMQ6FI4DTTFGLz0tRQW0Glf6UiB0GT4D7/FxkpGN0zNXuZ7RTCj2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 4854E24944399; Mon,  9 Mar 2026 08:32:41 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH dwarves v2 5/9] dwarf_loader: Change exprlen checking condition in parameter__reg()
Date: Mon,  9 Mar 2026 08:32:41 -0700
Message-ID: <20260309153241.1920126-1-yonghong.song@linux.dev>
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

The change does not change any functionalities. But it allows
DW_OP_stack_value preserved in longer location list for future
parameter checking.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 dwarf_loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index d538607..2237e20 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1226,7 +1226,7 @@ static int parameter__reg(Dwarf_Attribute *attr, in=
t expected_reg, struct cu *cu
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

