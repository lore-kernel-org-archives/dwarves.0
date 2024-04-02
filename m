Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE3D15CD5C;
	Tue,  2 Apr 2024 19:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086811; cv=none; b=HsmIZUYYE2r+KYfN2U9qj3gF6qATx0VBmGKDeZnzvlxEjWowGo9rwQyj8Vc2AjJfwUcZgheZ2BArsjv9jq8GYiGdSgt1OtXGa1rYpx8ZyChN03uenj6J9Xlwdw9MR90vxmqWlxj2yM/gqtrrAXj8R2k7WXNHf47LlmrTOXqq60k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086811; c=relaxed/simple;
	bh=hf3RkDjDLj8EiGw9zjPmBSt3sYnB/bc1kdIdDMLEDn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CIqYnBorGTT/vwrmkBL3Fp3gbEKyOQvB5QFENCxUhAjUpc71BlxoYZKJ6ohNYrwMiwZe4Vi+R3YgxJLZBNQHG1JxmU4VoNZOHR93wgz/5CpBAug02WETKRoQZUk0XKZp1A82otR+sOQcb0g3rnOHHaCNc5A9zeydg2W9FhFS6Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M10ZWBr1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M10ZWBr1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C672C433A6;
	Tue,  2 Apr 2024 19:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712086810;
	bh=hf3RkDjDLj8EiGw9zjPmBSt3sYnB/bc1kdIdDMLEDn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M10ZWBr1Qi5s3T0NA04Q2WXSjqxYHYNSo+xQP5E3F64YrTKVIwv6pKBNLgH2QPQP3
	 BpusbUzPiMBymgrKaVYBJ3Ih4Rr0tNGuE6UXTIXgfN/O5h1ZkcESNI/7vC7NC/tZzK
	 v26ODkL94KG8+4GGsZ9F6jvQnKaGhsf00MgrK0Wj+6ExiL9LQI9RU738e206XzHmqV
	 rBp8JGMyJMTg8Oz2mYZXdNwrAj9bXvPfF46jlSK82mQMcydFj85hwS8N7Ym5332Nd5
	 OTjghP1+pU9W8VlnreyJE5qPi5H96LOA+6j2004OSQbQetJaenuhOZZeNwRtWJOvzl
	 ym3r16DKKVfgQ==
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
Date: Tue,  2 Apr 2024 16:39:39 -0300
Message-ID: <20240402193945.17327-7-acme@kernel.org>
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

