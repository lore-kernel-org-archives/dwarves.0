Received: from nyx.n621.de (v4gw.hekate.n621.de [136.243.2.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7572F7F1E
	for <dwarves@vger.kernel.org>; Tue, 14 Jul 2026 14:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.243.2.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784038534; cv=none; b=Z+AxkHByGrkypXezb2hpCKkkq1/oyUeu2ofU1QlPPluf22xZ7aAjI6Vg2pFi6MN0BewsfGrTh9DDy0EUurlqBnCtc0KjhApkP2q9jiC5IgHZ18oxBR9yaVj09md6CXBg9kkh/Hku9HBDjSCD7O4S4321Mn4Yk6IhRGlWz2moOc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784038534; c=relaxed/simple;
	bh=9944f/pAuu7wouO5FwxJojqccYcIDAj2VAoFkDUU/dc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TWMuQlj0A8shmG3Pza6kk+xdqoeRHzM+puU1C3pGMXaml32IHQZ3Pj5lXDmFYUTB/UNluef1oTS/g+cT66oErnE6jq7F7CP5tBkJVFAMK1il54jMu11914t2T88fAeHaon44X3ti0D62X6zAFcyjqxK/DwfZ28djS/+EwQcfVlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=n621.de; spf=pass smtp.mailfrom=n621.de; dkim=pass (1024-bit key) header.d=n621.de header.i=@n621.de header.b=Bj8drJCu; arc=none smtp.client-ip=136.243.2.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=n621.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=n621.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=n621.de header.i=@n621.de header.b="Bj8drJCu"
Received: from charybdis.office.fixme.cloud (localhost [127.0.0.1])
	by nyx.n621.de (Postfix) with ESMTP id 96385E00350;
	Tue, 14 Jul 2026 16:09:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=n621.de; s=dkim;
	t=1784038142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AvJZcqx1jmUVX09I1sK6E8PQDSVOVjoRgCiNHexU5GA=;
	b=Bj8drJCu766f0Bv+4E4mzslXRclf5m7SHiDssq2skevqhfYxYM60LZG+yTlOVgAbwNl8eV
	A7AJw6ucnz4ITGuRnMMaPLO7ghoEGaVWKzkeKkkIocJPShE7f1AiCkwv3XHrftsApJ/yg+
	XcfS6RJ/MeZBWikX4M2qA2Dxeil1n3M=
From: Florian Larysch <fl@n621.de>
To: alan.maguire@oracle.com,
	dwarves@vger.kernel.org
Cc: Florian Larysch <fl@n621.de>
Subject: [PATCH] pahole: fix BTF function parameter type match check
Date: Tue, 14 Jul 2026 16:08:17 +0200
Message-ID: <20260714140858.17507-1-fl@n621.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BTF_KIND_FUNC_PROTO arm in types__match() first checks whether two
function types identified by t1/t2 have matching return types and then
attempts to iterate over the function parameters (p1/p2) to check them
for compatibility too.

However, the loop just repeats the check on t1/t2 instead of p1/p2, so
we just keep re-checking return type compatibility, ignoring possible
mismatches of the actual parameter types.

Fix this by actually comparing p1 and p2. This also resolves a
unused-but-set-variable build-time warning.

Signed-off-by: Florian Larysch <fl@n621.de>
---
 btf_encoder.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index d5af706..3aca2c2 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1129,8 +1129,8 @@ static bool types__match(struct btf_encoder *encoder,
 					  btf2, t2->type))
 				return false;
 			for (i = 0; i < vlen; i++, p1++, p2++) {
-				if (!types__match(encoder, btf1, t1->type,
-						  btf2, t2->type))
+				if (!types__match(encoder, btf1, p1->type,
+						  btf2, p2->type))
 					return false;
 			}
 			return true;
-- 
2.55.0

