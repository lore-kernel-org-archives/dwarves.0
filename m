Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9F215B98E;
	Tue,  2 Apr 2024 19:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086818; cv=none; b=j7WmcoseKpeT8sSglW6SvHBI+q98YSnSZmLT/o5JZfpb8yuJ6SgQDP0K7wqKQ9l0Tv2g92/EBJMk6TooB4W23Nowj+Lx5B/lObNCrEMOERh9nd1Gkm1coVWlkl3pRXCe56laf4I8DuznBkHsiMoEQfxp0UMdRtM8Rz0A4mueMbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086818; c=relaxed/simple;
	bh=z7+fhvSYnE+bw/Mf0nRnQV50P8GFALuiKdWStWfrOt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sn5VkgrXoTED5MDnZDS+9Y6GJMyscT6BJPgKf268d0NNCriQkKdcRC/LprpmV4NSm0EXy/z4DK+KyU8ETvUm/nrxLtf4PmbYyrNIfauugUB+VN7cUdnH6LCwSkPy3i3odcbIqfw22CGHtiC0L+sJe0dXb+vQWmJuXXqnRLklWBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMOACjLL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMOACjLL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC49C43394;
	Tue,  2 Apr 2024 19:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712086818;
	bh=z7+fhvSYnE+bw/Mf0nRnQV50P8GFALuiKdWStWfrOt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IMOACjLLyzHouP6k3kd2qZwCQyfm3IicM25x6jJ1DxcMen0kaY7ejCz0Z70Zec33A
	 RbtcX+yRE+mGtnGhX4P7zOynwiGf4dTlJOUx0FmLV0ZTX/sYxlBQaRfMPj8eoiYkpn
	 py0uW3HOQaRcnzecSdwO5HN2YgZKXcGubjnThia/tG89XXOWm0hGVjgf2L6Rw4rCd0
	 UjZSN3fPWK8PwUc9IkE5nNePFSUKheoHmGHUofLuDCvHtWqvkG4rcHk5XLh2eAreSt
	 Pwo9wl94pZ1j9v+EsN/zkcGhafZdgnEkpwiTJ5JvwsipUYTJO1KNstSIgPL4u6NCef
	 SKU/sQDBsp7dQ==
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
Subject: [PATCH 09/12] dwarf_loader: Add the cu to the cus list early, remove on LSK_DELETE
Date: Tue,  2 Apr 2024 16:39:42 -0300
Message-ID: <20240402193945.17327-10-acme@kernel.org>
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

We want to keep it in the same order as in the original DWARF file we're
loading (e.g. vmlinux), we'll only remove it after we load and process
(e.g. convert to BTF).

Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Kui-Feng Lee <kuifeng@fb.com>
Cc: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarf_loader.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index a097b67a2d123b55..3ef22aada6f46f13 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -3034,12 +3034,12 @@ static int cus__finalize(struct cus *cus, struct cu *cu, struct conf_load *conf,
 	int lsk = cu__finalize(cu, conf, thr_data);
 	switch (lsk) {
 	case LSK__DELETE:
+		cus__remove(cus, cu);
 		cu__delete(cu);
 		break;
 	case LSK__STOP_LOADING:
 		break;
 	case LSK__KEEPIT:
-		cus__add(cus, cu);
 		break;
 	}
 	return lsk;
@@ -3064,7 +3064,7 @@ static int cu__set_common(struct cu *cu, struct conf_load *conf,
 	return 0;
 }
 
-static int __cus__load_debug_types(struct conf_load *conf, Dwfl_Module *mod, Dwarf *dw, Elf *elf,
+static int __cus__load_debug_types(struct cus *cus, struct conf_load *conf, Dwfl_Module *mod, Dwarf *dw, Elf *elf,
 				   const char *filename, const unsigned char *build_id,
 				   int build_id_len, struct cu **cup, struct dwarf_cu *dcup)
 {
@@ -3098,6 +3098,7 @@ static int __cus__load_debug_types(struct conf_load *conf, Dwfl_Module *mod, Dwa
 			cu->dfops = &dwarf__ops;
 
 			*cup = cu;
+			cus__add(cus, cu);
 		}
 
 		Dwarf_Die die_mem;
@@ -3250,6 +3251,8 @@ static int dwarf_cus__create_and_process_cu(struct dwarf_cus *dcus, Dwarf_Die *c
 	if (dcu == NULL)
 		return DWARF_CB_ABORT;
 
+	cus__add(dcus->cus, dcu->cu);
+
 	return dwarf_cus__process_cu(dcus, cu_die, dcu->cu, NULL);
 }
 
@@ -3282,6 +3285,9 @@ static int dwarf_cus__nextcu(struct dwarf_cus *dcus, struct dwarf_cu **dcu,
 			ret = -1;
 			goto out_unlock;
 		}
+		// Do it here to keep all CUs in cus->cus in the same
+		// order as in the DWARF file being loaded (e.g. vmlinux)
+		__cus__add(dcus->cus, (*dcu)->cu);
 	}
 
 out_unlock:
@@ -3496,15 +3502,15 @@ static int cus__load_module(struct cus *cus, struct conf_load *conf,
 	struct dwarf_cu type_dcu;
 	int type_lsk = LSK__KEEPIT;
 
-	int res = __cus__load_debug_types(conf, mod, dw, elf, filename, build_id, build_id_len, &type_cu, &type_dcu);
+	int res = __cus__load_debug_types(cus, conf, mod, dw, elf, filename, build_id, build_id_len, &type_cu, &type_dcu);
 	if (res != 0) {
 		return res;
 	}
 
 	if (type_cu != NULL) {
 		type_lsk = cu__finalize(type_cu, conf, NULL);
-		if (type_lsk == LSK__KEEPIT) {
-			cus__add(cus, type_cu);
+		if (type_lsk == LSK__DELETE) {
+			cus__remove(cus, type_cu);
 		}
 	}
 
-- 
2.44.0

