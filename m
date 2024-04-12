Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B570414F13E;
	Fri, 12 Apr 2024 21:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956586; cv=none; b=pYbBTpb5raJEwLP+sZwXiTzRszX0736TytphH3MUvANTFWfNE8dNIT0ivde5CHdYHxRbOGddd+abobW5/jchSBAsru0TtBBcLn/lkMT0wB3j+swSh/ZVZZBc2ylyYGM6J7QhkVPCytFaUmRxl4SXmgZc95IrF9w5P4HiCGU0uG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956586; c=relaxed/simple;
	bh=hf3RkDjDLj8EiGw9zjPmBSt3sYnB/bc1kdIdDMLEDn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sa9kFVsELvO1FRSWb3zY2ayj/AjLQffC3OSI9Ba56vrSHltrNAnf6H5HXMFEtQUGxOvmeO/cF55QDs73mKfKDWahlJY3l6D8KPASoF3QEOW2supl/CD0u7TkU8P8TCXU57CN+qtR2T/hgp/3QPWFzWFTgOf7qXRXItORRQJDXJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SiuQkw4M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SiuQkw4M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA6DC3277B;
	Fri, 12 Apr 2024 21:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712956586;
	bh=hf3RkDjDLj8EiGw9zjPmBSt3sYnB/bc1kdIdDMLEDn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SiuQkw4MDsukb4b10CzqVL76QCB2I5W1H+//MAksqB0bz0SPfW4eb0/o9G8Eaq1Pd
	 uQ/zeGrGsBXD0wwwkw8RQ8WS8GZfa5QXco5cukQOtXhx2X3/yGXwnC5y7QI0HqNQ+J
	 2s9bDJwpMLeh2yMqFoNv/AO1dO6OyRfQdxCmi77c6Qglpd3kbE5UR7Nt0LXgvbVd0a
	 sgioV/t7wpjzSpPD8tTeag7IWYDInyReB6fTzVgq/6FLb4fb78xmJtEKHPn+yb8PMS
	 b0rZPaPKj+glMt8IZ+Qj6nYTC1EMuUZwE1wxmBbbJVL1q+W5NOE8n7mie4HLoNwYsn
	 xbDppE3EeStVw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: dwarves@vger.kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	bpf@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Kui-Feng Lee <kuifeng@fb.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 06/12] dwarf_loader: Remove unused 'thr_data' arg from dwarf_cus__create_and_process_cu()
Date: Fri, 12 Apr 2024 18:15:58 -0300
Message-ID: <20240412211604.789632-7-acme@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412211604.789632-1-acme@kernel.org>
References: <20240412211604.789632-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The only caller for dwarf_cus__create_and_process_cu() now is serial
loading of DWARF, so no point in passing the perf thread data, that is
always NULL, so remove that parameter.

Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Kui-Feng Lee <kuifeng@fb.com>
Cc: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarf_loader.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index a7a8b2bea112ba75..a097b67a2d123b55 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -3243,15 +3243,14 @@ static int dwarf_cus__process_cu(struct dwarf_cus *dcus, Dwarf_Die *cu_die,
        return DWARF_CB_OK;
 }
 
-static int dwarf_cus__create_and_process_cu(struct dwarf_cus *dcus, Dwarf_Die *cu_die,
-					    uint8_t pointer_size, void *thr_data)
+static int dwarf_cus__create_and_process_cu(struct dwarf_cus *dcus, Dwarf_Die *cu_die, uint8_t pointer_size)
 {
 	struct dwarf_cu *dcu = dwarf_cus__create_cu(dcus, cu_die, pointer_size);
 
 	if (dcu == NULL)
 		return DWARF_CB_ABORT;
 
-	return dwarf_cus__process_cu(dcus, cu_die, dcu->cu, thr_data);
+	return dwarf_cus__process_cu(dcus, cu_die, dcu->cu, NULL);
 }
 
 static int dwarf_cus__nextcu(struct dwarf_cus *dcus, struct dwarf_cu **dcu,
@@ -3377,8 +3376,7 @@ static int __dwarf_cus__process_cus(struct dwarf_cus *dcus)
 		if (cu_die == NULL)
 			break;
 
-		if (dwarf_cus__create_and_process_cu(dcus, cu_die,
-						     pointer_size, NULL) == DWARF_CB_ABORT)
+		if (dwarf_cus__create_and_process_cu(dcus, cu_die, pointer_size) == DWARF_CB_ABORT)
 			return DWARF_CB_ABORT;
 
 		dcus->off = noff;
-- 
2.44.0

