Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D6833A03F
	for <dwarves@vger.kernel.org>; Fri, 20 Mar 2026 19:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774033796; cv=none; b=DyEyoEqd7Rl+GmA70N8WcWpLs/U0T7zEu0nhK8Q2+AnbcjP64S88PMdargmHqTSH+T56VOvp6G3bEPMpvIF5QjZvTFzVkdwMk317zHH/tZyZgNzTBCA92QU8U1GWfq7hMCE4nFJNfzKt4wWgbvKx/82t68OAAiUjh6mCvXGwlZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774033796; c=relaxed/simple;
	bh=JYTE8JRd1vaLfABAP/Ewau++SrRXQwzyoABWOyiWFIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tyFAoRvBV3nUUFfqPaBAzd9Dq2AjTz51UaUYgOR2hijlQqaTMtH7T5zIQ9gqR+hbF0fAAG5qloiRuU49N67ExNFKc3+ZA1U7WuVrcGKygRvMo88SzIyN/miPctoQudIpyl2RRer70Qx0vC/hE2v1RxhEPdnfOo04tN4xVbboC10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 358532A7EAD70; Fri, 20 Mar 2026 12:09:43 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH dwarves v3 5/9] dwarf_loader: Change exprlen checking condition in parameter__reg()
Date: Fri, 20 Mar 2026 12:09:43 -0700
Message-ID: <20260320190943.1972443-1-yonghong.song@linux.dev>
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

The change does not change any functionalities. But it allows
DW_OP_stack_value preserved in longer location list for future
parameter checking.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 dwarf_loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index c259417..117cd49 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1227,7 +1227,7 @@ static int parameter__reg(Dwarf_Attribute *attr, in=
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

