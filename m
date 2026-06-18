Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D2C2C21D0
	for <dwarves@vger.kernel.org>; Thu, 18 Jun 2026 17:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781804012; cv=none; b=sR+8TElTpQ57gF2CnpM8rqnVupDv5ceoaSycHNUEXGUPg58dz0ox+pFfqTPn5ObewMFKUQ0CmbDxY2B4bHJ892AZl2kQO8RVQl7ZJVRyn6GCKBtqJIJ01m+yixNnLOwbQne7Pb/exgYiye3NUko6V5o7VBJNlE5ra72bTFM62ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781804012; c=relaxed/simple;
	bh=l0C3Eed+UzM48G3KXLNU4ZGRBI55zXOw7FsoleeQEfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=noz6nOhFvcUWPIermh8Misw9LSWe1iJ2ySgFqvgTheGhaBYZVYXjDx3eQ0Sf/GHWSoe1k0elI2ngzg8yqVBCnYM19ki95hl0DcxNzVSdKnzFsmrQNiyffvEPn/NPead+ef8jgGUmd8UXP7sq+dyKDB9GEWFIveINSDBaXqMOx3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZWT2Crb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZWT2Crb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D3C1F00A3A;
	Thu, 18 Jun 2026 17:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781804011;
	bh=YDKSxFLBv8zkmVvNLw+i8yyMLyvtdvmb5PwaMddGrcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bZWT2CrbI1nwEgUhGuqlyplVkK2i01OU+BdHf0nDeeSrW9yvimanHjdG2oLNR9yGw
	 zFuoAf6JkOL8p1DdMMTe2Bf9JjdaXrv6T0q/+/nRRmEuA+G7E3HTjejeIhFxu7c3gs
	 WFddEvZfhTjfdDxt1k45QUCIP6HuK4D/Wq5soqFLA5WcWYl1TF5u1rYefCBuOo7ipS
	 yA926GWqi0Do1I/Z/zIyNWmj8TZTeD3aQYo3e13ZmS59GC7omgvrYEOD6/pZ2HXKgl
	 G+dPwPyhocaS4JKQEUY4a0DyvQgdVrt72CwxxeiZ4aYs/G5bbdgf8Ar9JdP08XiDx+
	 IcdrJn1JmzK4A==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 5/7] dwarves_fprintf: Accumulate function__fprintf return value in enumeration printing
Date: Thu, 18 Jun 2026 14:33:14 -0300
Message-ID: <20260618173316.83598-6-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618173316.83598-1-acme@kernel.org>
References: <20260618173316.83598-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The return value of function__fprintf was being discarded, causing the
printed byte count to be wrong when enumerations contain DW_TAG_subprogram.

Fixes: a1b3ec41fcc2433d ("dwarf_loader: Initial support for DW_TAG_subprogram in DW_TAG_enumeration")
Assisted-by: Claude:claude-opus-4-6-1m
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarves_fprintf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
index 4b6edcce81ebce71..9c12fc1ce8b2037a 100644
--- a/dwarves_fprintf.c
+++ b/dwarves_fprintf.c
@@ -490,7 +490,7 @@ size_t enumeration__fprintf(const struct tag *tag, const struct cu *cu,
 
 		switch (pos->tag.tag) {
 		case DW_TAG_subprogram:
-			function__fprintf(&pos->tag, cu, conf, fp);
+			printed += function__fprintf(&pos->tag, cu, conf, fp);
 			break;
 		case DW_TAG_enumerator:
 			printed += fprintf(fp, "%-*s = ", max_entry_name_len, enumerator__name(pos));
-- 
2.54.0

