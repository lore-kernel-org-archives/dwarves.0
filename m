Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0D315CD43;
	Tue,  2 Apr 2024 19:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086803; cv=none; b=rdEszzdQHaTGbwEyXKJgHsJB0pex2OoecQ6pyCSHXQO2IqoSQDHSJvHrpNTYzETcyBIyUeVB/GDmbNGO/ABYO5cr7D6oMoIKLiA+WdhzTnEHaEom80u359sE7F0hZJfXn6EkhZxl9k93sQXsKv2+0o/E6O1JJvFsUN2S9DlTNyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086803; c=relaxed/simple;
	bh=q+NUCdJP4mSxrZnr1exlGkXjhSC5UscKjBVbqiYsyl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rIsSuWi4jd2FFJ/oyvejxp43OwnntUDfKjl4cXFsLMqfiTeNKtDazNAzmwG7itmKDcjZgzpCPFunlx4+/D52hVHFO2o94Yqienrcw4KEbaQwD+9H81shgAyMoothE0qVMlsd1gcbAp9BIUuSTdUmHkeSL32TAGV85HcVZkhs7lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvFq5hmE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvFq5hmE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C051C433F1;
	Tue,  2 Apr 2024 19:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712086802;
	bh=q+NUCdJP4mSxrZnr1exlGkXjhSC5UscKjBVbqiYsyl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XvFq5hmE59YgDgI35s2xIuFQw67EnlIW5BwxblGpIOxcWyZuA08VQD64j47+zWXfW
	 vj3+ze4YyKTH0P+rF7dF/PjxNs/7PpGm2laojrHYkyxnrSu1FxW88GHrlN42PRp3NN
	 v8gIX31cyX6S6eUROzsvajRwHhWmRx8/guX42gDsZSF9DPPMjbZAWkki2hZ78Hf/YZ
	 bLxJhxwF9rJWjBd0Hde0u4U/h7C/kWeyHFdP4Z1V6dK0SaOQ6AGudiBcqFeS/XErAi
	 Cc1Pw91oCStE84p2AG1GznCIQMMps+yXzFm/ATAbyA/OuXgNq7EslkeDeuThtZh9Qt
	 au477FS3p93Sg==
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
Subject: [PATCH 03/12] dwarf_loader: Separate creating the cu/dcu pair from processing it
Date: Tue,  2 Apr 2024 16:39:36 -0300
Message-ID: <20240402193945.17327-4-acme@kernel.org>
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

We will need it so that we add the dcu to a list in the same order as
the CUs are in the DWARF file (vmlinux mostly).

Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Kui-Feng Lee <kuifeng@fb.com>
Cc: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarf_loader.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 1dffb3f433cb7c8e..125e361ef2bf3f7b 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -3207,8 +3207,7 @@ struct dwarf_thread {
 	void			*data;
 };
 
-static int dwarf_cus__create_and_process_cu(struct dwarf_cus *dcus, Dwarf_Die *cu_die,
-					    uint8_t pointer_size, void *thr_data)
+static struct dwarf_cu *dwarf_cus__create_cu(struct dwarf_cus *dcus, Dwarf_Die *cu_die, uint8_t pointer_size)
 {
 	/*
 	 * DW_AT_name in DW_TAG_compile_unit can be NULL, first seen in:
@@ -3218,17 +3217,32 @@ static int dwarf_cus__create_and_process_cu(struct dwarf_cus *dcus, Dwarf_Die *c
 	const char *name = attr_string(cu_die, DW_AT_name, dcus->conf);
 	struct cu *cu = cu__new(name ?: "", pointer_size, dcus->build_id, dcus->build_id_len, dcus->filename, dcus->conf->use_obstack);
 	if (cu == NULL || cu__set_common(cu, dcus->conf, dcus->mod, dcus->elf) != 0)
-		return DWARF_CB_ABORT;
+		return NULL;
 
 	struct dwarf_cu *dcu = dwarf_cu__new(cu);
 
-	if (dcu == NULL)
-		return DWARF_CB_ABORT;
+	if (dcu == NULL) {
+		cu__delete(cu);
+		return NULL;
+	}
 
 	dcu->type_unit = dcus->type_dcu;
 	cu->priv = dcu;
 	cu->dfops = &dwarf__ops;
 
+	return dcu;
+}
+
+static int dwarf_cus__create_and_process_cu(struct dwarf_cus *dcus, Dwarf_Die *cu_die,
+					    uint8_t pointer_size, void *thr_data)
+{
+	struct dwarf_cu *dcu = dwarf_cus__create_cu(dcus, cu_die, pointer_size);
+
+	if (dcu == NULL)
+		return DWARF_CB_ABORT;
+
+	struct cu *cu = dcu->cu;
+
 	if (die__process_and_recode(cu_die, cu, dcus->conf) != 0 ||
 	    cus__finalize(dcus->cus, cu, dcus->conf, thr_data) == LSK__STOP_LOADING)
 		return DWARF_CB_ABORT;
-- 
2.44.0

