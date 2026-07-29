Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B68B463B6C;
	Wed, 29 Jul 2026 19:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352079; cv=none; b=d27xmHpzJUwNENq50osw6lyFC41lmGG8XTIqzz058Hd3MvDhj1KiXseXJ+cvkjTRXh5F0GZYrg37O8BkYVnl8/CAvzdByO8wasR/fY8UP8OqG7tA5h5zHHZhhBM65v7OfaPLihJiax1TEOn7V4LkMBki87+SfoCiIwCgyjWfd5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352079; c=relaxed/simple;
	bh=4xaGBmI2s6txN4WNlc8mY1taLA9SAPyIzmsSR6ym9Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j1lHcEn8kIztPLWEbeJvBCuUwFNJ6Xj+0qxN44fFKy5Qr21l/drQ/7yGcB+ic5EvgtT2bOlmZxyBKM7NwAxd+IdjP7KUFAVzAcaU/B+cH3EeKOUoYzWEG2+xEREKwU+5ucimzIoloPLIMUZqolrMHDFCZNI1aNya/4AOAzzd4P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhqcWpc8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhqcWpc8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352C71F00A3A;
	Wed, 29 Jul 2026 19:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785352077;
	bh=1A3bIfssB7WAn3TNln8+Px3u3vzHXPdnrDMkW4c8gn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MhqcWpc8JHd2lYTsB0W8rduyz2aaRqnHpIhA/AU4o2QhpS5Y9ehjvZAHiSrYR3Q97
	 U8wZcagnhwZEuoZm4oMBQxM3bI5i7JAsYDS811PPQX6nbEEwpivqSbtSHUeRb9fvxx
	 5aa+U2LhPrvEYtYq1d+ArjMMHnvUw3HJD6WwpCwMsoRIKQf/97FKw3tHKYna1nYw9l
	 6j226Bo3HBv4PswuuqS2Pt3KQsTjP8R8kfeK0oMH1SSYw+xeodjlD3g+IM3bMcR9Oe
	 z1FZ1Iw8LSJgeMA+2bh4b33DBInFWu9LcmAplLPMtf2V3TluXScJZclKQimsdH8eLt
	 vyKbPahIsc97g==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 08/31] dwarf_loader: Allocate type_dcu via dwarf_cu__new to fix dangling stack pointer
Date: Wed, 29 Jul 2026 16:07:08 -0300
Message-ID: <20260729190733.72876-9-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729190733.72876-1-acme@kernel.org>
References: <20260729190733.72876-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

In cus__load_module(), type_dcu was declared on the stack and passed
to __cus__load_debug_types(), which stores the pointer in type_cu->priv.
After cus__load_module() returns, type_cu->priv points to a dead stack
frame.  When dwarf_cu__delete() later calls cu__free(cu, cu->priv), it
passes an invalid stack address to free(), causing heap corruption or a
crash.

Move the allocation into __cus__load_debug_types() using dwarf_cu__new(),
which allocates through cu__zalloc() — respecting the CU's obstack
setting so that the type_dcu lifetime is tied to the type_cu that owns
it and cleanup goes through the normal dwarf_cu__delete() path.

Fixes: 2938a70e1e2a73ff ("Add support for .debug_types sections.")
Reported-by: Sashiko:gemini-3-1-pro-preview # Running on a local machine
Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarf_loader.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 14c90080f538e10d..b87519fa73405ff7 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -3889,7 +3889,7 @@ static int cu__set_common(struct cu *cu, struct conf_load *conf,
 
 static int __cus__load_debug_types(struct cus *cus, struct conf_load *conf, Dwfl_Module *mod, Dwarf *dw, Elf *elf,
 				   const char *filename, const unsigned char *build_id,
-				   int build_id_len, struct cu **cup, struct dwarf_cu *dcup)
+				   int build_id_len, struct cu **cup, struct dwarf_cu **dcup)
 {
 	Dwarf_Off off = 0, noff, type_off;
 	size_t cuhl;
@@ -3897,6 +3897,7 @@ static int __cus__load_debug_types(struct cus *cus, struct conf_load *conf, Dwfl
 	uint64_t signature;
 
 	*cup = NULL;
+	*dcup = NULL;
 
 	while (dwarf_next_unit(dw, off, &noff, &cuhl, NULL, NULL, &pointer_size,
 			       &offset_size, &signature, &type_off)
@@ -3904,6 +3905,7 @@ static int __cus__load_debug_types(struct cus *cus, struct conf_load *conf, Dwfl
 
 		if (*cup == NULL) {
 			struct cu *cu;
+			struct dwarf_cu *dcu;
 
 			cu = cu__new("", pointer_size, build_id,
 				     build_id_len, filename, conf->use_obstack);
@@ -3913,17 +3915,18 @@ static int __cus__load_debug_types(struct cus *cus, struct conf_load *conf, Dwfl
 				return DWARF_CB_ABORT;
 			}
 
-			if (dwarf_cu__init(dcup, cu) != 0) {
+			dcu = dwarf_cu__new(cu);
+			if (dcu == NULL) {
 				cu__delete(cu);
 				return DWARF_CB_ABORT;
 			}
-			dcup->cu = cu;
 			/* Funny hack.  */
-			dcup->type_unit = dcup;
-			cu->priv = dcup;
+			dcu->type_unit = dcu;
+			cu->priv = dcu;
 			cu->dfops = &dwarf__ops;
 
 			*cup = cu;
+			*dcup = dcu;
 			cus__add(cus, cu);
 		}
 
@@ -4488,27 +4491,30 @@ static int cus__load_module(struct cus *cus, struct conf_load *conf,
 	int build_id_len = 0;
 #endif
 	struct cu *type_cu;
-	struct dwarf_cu type_dcu;
+	struct dwarf_cu *type_dcu;
 	int type_lsk = LSK__KEEPIT;
 	int lsk_worker_status = LSK__ABORT;
 
 	int res = __cus__load_debug_types(cus, conf, mod, dw, elf, filename, build_id, build_id_len, &type_cu, &type_dcu);
-	if (res != 0) {
+	if (res != 0)
 		return res;
-	}
 
 	if (type_cu != NULL) {
 		cu__finalize(type_cu, cus, conf);
-		type_lsk = cus__steal_now(cus, type_cu, conf);
-		if (type_lsk == LSK__DELETE) {
+		if (conf && conf->steal)
+			type_lsk = conf->steal(type_cu, conf);
+		/* Defer cu__delete() for LSK__DELETE until after main
+		 * CUs are processed — they need type_dcu alive for
+		 * DW_FORM_ref_sig8 resolution.  Remove from the list
+		 * now so the consumer doesn't see it twice. */
+		if (type_lsk == LSK__DELETE)
 			cus__remove(cus, type_cu);
-		}
 	}
 
 	if (cus__merging_cu(dw, elf)) {
 		res = cus__merge_and_process_cu(cus, conf, mod, dw, elf, filename,
 						build_id, build_id_len,
-						type_cu ? &type_dcu : NULL);
+						type_cu ? type_dcu : NULL);
 	} else {
 		struct dwarf_cus dcus = {
 			.off      = 0,
@@ -4518,7 +4524,7 @@ static int cus__load_module(struct cus *cus, struct conf_load *conf,
 			.dw       = dw,
 			.elf      = elf,
 			.filename = filename,
-			.type_dcu = type_cu ? &type_dcu : NULL,
+			.type_dcu = type_cu ? type_dcu : NULL,
 			.build_id = build_id,
 			.build_id_len = build_id_len,
 			.nr_cus_created = 0,
@@ -4527,12 +4533,15 @@ static int cus__load_module(struct cus *cus, struct conf_load *conf,
 		lsk_worker_status = dcus.lsk_status;
 	}
 
+	/* Deferred type CU cleanup: now that main CUs have finished
+	 * resolving DW_FORM_ref_sig8 refs through type_dcu, it is
+	 * safe to free the type CU. */
+	if (type_cu != NULL && type_lsk == LSK__DELETE)
+		cu__delete(type_cu);
+
 	if (res && lsk_worker_status == LSK__ABORT)
 		return res;
 
-	if (type_lsk == LSK__DELETE)
-		cu__delete(type_cu);
-
 	return DWARF_CB_OK;
 }
 
-- 
2.55.0

