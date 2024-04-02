Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB3F15B962;
	Tue,  2 Apr 2024 19:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086805; cv=none; b=R9jh9dRcoMt5OdRvIOWqmNt+vNa4emb5DS8cKTbE7Ktz8TzOURJRGY4Z57Wadws1DnS9pdv9Cx8nit3VBCeACE957ItlScZZlD/bG6sjo0oD73BGHLQGzDEwbWGmHKNX68vQiYkupbKgn2NlE6cTGhX9PYZaos9aKKpnkgKVeUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086805; c=relaxed/simple;
	bh=kOiNeJGVcoAa111TeF9EUHg4UgiYzaQpUB2MIZ6+pgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BgAGq2t09UYbPKUSNMCNMcWuYG5IRs1mdOIPr3DkAI8c2zd8E3nukEv7s1sZ1+c0uJK+qZRNJ51y5JK/tOQZ+cOoYJRkwdogoI9NrkglbfjB3dbBq6IVdHV5nBFsXGoEO5cSJE51Ijc/vqlPm1o5iBy0V1OwjFGJvK2WQGmZ/L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flnBI7bv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flnBI7bv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1D9C43394;
	Tue,  2 Apr 2024 19:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712086805;
	bh=kOiNeJGVcoAa111TeF9EUHg4UgiYzaQpUB2MIZ6+pgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=flnBI7bvgMGdQCbpNB8dC8Yz/Fp3VYQcjVLjpj6PHAuRkuR1u6tCfDYxOPxVFh8XA
	 mOrA/kvLD2HiQdOAfxENnwlcE3EhnjngJtKwGw3iGo6dobQ8SB3VgRtwq1PZkFXdmL
	 uO8mBkULZLD6FXgFU1l6cy0o2TitCJ2w37LlMcmM5rP8BhiNeYdjt0kg8dZ7CvFCJY
	 RAARUgKkYVtH3fQ1lcIClS7oRfm5tY+KGnkN2ikl7/IUgFuPbLdvTw2DdCDaO6Mpqi
	 4cTQL4y6GfJp4T+HMU4VviHorps6cb2JcBQerSDzuklm/dwR2NXCjeHkOkBxcl9snh
	 wFYG0cIbaa43A==
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
Subject: [PATCH 04/12] dwarf_loader: Introduce dwarf_cus__process_cu()
Date: Tue,  2 Apr 2024 16:39:37 -0300
Message-ID: <20240402193945.17327-5-acme@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402193945.17327-1-acme@kernel.org>
References: <20240402193945.17327-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Finishing the separation of creating a dcu/cu pair from processing it,
as we'll need to add the new dcu/cu pair to the list under cus__lock(),
so that we process it in order to keep a reproducible BTF encoding.

Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Kui-Feng Lee <kuifeng@fb.com>
Cc: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarf_loader.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 125e361ef2bf3f7b..5090509309446890 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -3233,6 +3233,16 @@ static struct dwarf_cu *dwarf_cus__create_cu(struct dwarf_cus *dcus, Dwarf_Die *
 	return dcu;
 }
 
+static int dwarf_cus__process_cu(struct dwarf_cus *dcus, Dwarf_Die *cu_die,
+				 struct cu *cu, void *thr_data)
+{
+	if (die__process_and_recode(cu_die, cu, dcus->conf) != 0 ||
+	    cus__finalize(dcus->cus, cu, dcus->conf, thr_data) == LSK__STOP_LOADING)
+		return DWARF_CB_ABORT;
+
+       return DWARF_CB_OK;
+}
+
 static int dwarf_cus__create_and_process_cu(struct dwarf_cus *dcus, Dwarf_Die *cu_die,
 					    uint8_t pointer_size, void *thr_data)
 {
@@ -3241,13 +3251,7 @@ static int dwarf_cus__create_and_process_cu(struct dwarf_cus *dcus, Dwarf_Die *c
 	if (dcu == NULL)
 		return DWARF_CB_ABORT;
 
-	struct cu *cu = dcu->cu;
-
-	if (die__process_and_recode(cu_die, cu, dcus->conf) != 0 ||
-	    cus__finalize(dcus->cus, cu, dcus->conf, thr_data) == LSK__STOP_LOADING)
-		return DWARF_CB_ABORT;
-
-       return DWARF_CB_OK;
+	return dwarf_cus__process_cu(dcus, cu_die, dcu->cu, thr_data);
 }
 
 static int dwarf_cus__nextcu(struct dwarf_cus *dcus, Dwarf_Die *die_mem, Dwarf_Die **cu_die, uint8_t *pointer_size, uint8_t *offset_size)
-- 
2.44.0

