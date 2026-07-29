Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEBA25B0BE;
	Wed, 29 Jul 2026 19:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352110; cv=none; b=book9LZfk6PlzX/4AtVdRETBbPUlfw8ESPxgPq6knYDzSu+2KfEroa4f6cUJBfH7nexkLQOHNGfKKJswIOxUffSovPc5UlYUb/wuWjcg2pYbOanCuzbkTweaWngPFjQ6ur71eiiPw4PFeTvafS3AOWGuVG4KulMtCWGx0L3Iy6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352110; c=relaxed/simple;
	bh=76vzAiV8gJfxrbaMuj1oqu+XplZ31/OjUnUIa/mHkh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p5e7/gHHiRWuyO8Qxa5Cbo8AWJYm1sHfsrMJ04IiZfntq0ZMQ6I5wreh1i3wnKNN6wbwS5llkfKI29FyIUaXZ6TfXnkLWFQztlJYAC/H6k3QEtzsQRrK42v2ePJqDCO/kAnoPYl7IuDSYP9yHOLeyAQxbtgmi51ebUzkYNoVnYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXWOCnKJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXWOCnKJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADF21F00A3A;
	Wed, 29 Jul 2026 19:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785352109;
	bh=old4LgNo2wRn9GfR26Eyge2jpAb6fPGgH6OdHYzg2I0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SXWOCnKJU1s4cIBX8vBHjJQei3qZ7PC19BwMDFqGNvkv69eIba035phnQDrd3y+K8
	 Dmgy4xbcyH+mjUN3GeNkRiTgFX3+pHaLjfMZWI4JXJ938+XTdHJwhWwN3ITx214Wcm
	 zQr/lBmBOZHRA9KB36IE/aMb71BWC/qjmCH+8hl6LOnIPWGT0H6/O3hohIeCx4wzw2
	 MHwgXGKDZx36SrBSd8v/1g5D9HhKbcIZbyfhkk05WbR4XcrNrhdOKY8CW2fjMVTito
	 876sbwC56viJLuBP5C1DdrK9D5fQgCgK68Gf6fHtd70vk72ngS7Ex3nTZnB4sWLYuK
	 IIX6uEsDMNd1w==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 22/31] dwarf_loader, btf_loader: Replace stale FIXME/XXX comments with explanations
Date: Wed, 29 Jul 2026 16:07:22 -0300
Message-ID: <20260729190733.72876-23-acme@kernel.org>
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

Several FIXME and XXX comments referenced issues that were already
resolved or described intentional behavior that was never going to
change.  Replace them with proper explanations of why the code
behaves the way it does:

- Call site tags (DW_TAG_call_site): useful for debuggers, not for
  pahole's type reconstruction.

- Formal parameters in inline expansions: duplicates of the abstract
  origin's parameters, not needed for type reconstruction.

- Template value parameters on ftypes: already attached to the
  ftype's template value param list and used by class__fprintf.

- DW_TAG_dwarf_procedure: compiler-internal DWARF expressions with
  no type information to extract.

- BTF_KIND_DATASEC: describes runtime variable placement in ELF
  sections, intentionally ignored for type reconstruction.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 btf_loader.c   |  5 +++--
 dwarf_loader.c | 52 ++++++++++++++++++++++----------------------------
 2 files changed, 26 insertions(+), 31 deletions(-)

diff --git a/btf_loader.c b/btf_loader.c
index caead39775da54da..5857c3b6d2fc4b2b 100644
--- a/btf_loader.c
+++ b/btf_loader.c
@@ -428,8 +428,9 @@ static int create_new_datasec(struct cu *cu __maybe_unused, const struct btf_typ
 	//cu__add_tag_with_id(cu, &datasec->tag, id);
 
 	/*
-	 * FIXME: this will not be used to reconstruct some original C code,
-	 * its about runtime placement of variables so just ignore this for now
+	 * BTF_KIND_DATASEC describes runtime variable placement in ELF
+	 * sections, not C type information.  Not needed for pahole's
+	 * type reconstruction, so intentionally ignored.
 	 */
 	return 0;
 }
diff --git a/dwarf_loader.c b/dwarf_loader.c
index 04dffae3504efa06..61d55bd70d643731 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -2529,13 +2529,10 @@ static int die__process_inline_expansion(Dwarf_Die *die, struct lexblock *lexblo
 		case DW_TAG_GNU_call_site:
 		case DW_TAG_GNU_call_site_parameter:
 			/*
- 			 * FIXME: read http://www.dwarfstd.org/ShowIssue.php?issue=100909.2&type=open
- 			 * and write proper support.
-			 *
-			 * From a quick read there is not much we can use in
-			 * the existing dwarves tools, so just stop warning the user,
-			 * developers will find these notes if wanting to use in a
-			 * new tool.
+			 * Call site tags describe interprocedural call
+			 * metadata (callee, parameters, return values).
+			 * Useful for debuggers but not for pahole's type
+			 * reconstruction.  Silently skip them.
 			 */
 			continue;
 		case DW_TAG_lexical_block:
@@ -2544,15 +2541,10 @@ static int die__process_inline_expansion(Dwarf_Die *die, struct lexblock *lexblo
 			continue;
 		case DW_TAG_formal_parameter:
 			/*
-			 * FIXME:
-			 * So far DW_TAG_inline_routine had just an
-			 * abstract origin, but starting with
-			 * /usr/lib/openoffice.org/basis3.0/program/libdbalx.so
-			 * I realized it really has to be handled as a
-			 * DW_TAG_function... Lets just get the types
-			 * for 1.8, then fix this properly.
-			 *
-			 * cu__tag_not_handled(cu, die);
+			 * Inline expansions can have their own formal
+			 * parameter children duplicating the abstract
+			 * origin's parameters.  These are not needed
+			 * for type reconstruction — skip them.
 			 */
 			continue;
 		case DW_TAG_inlined_subroutine:
@@ -2635,13 +2627,10 @@ static int die__process_function(Dwarf_Die *die, struct ftype *ftype,
 		case DW_TAG_GNU_call_site:
 		case DW_TAG_GNU_call_site_parameter:
 			/*
-			 * XXX: read http://www.dwarfstd.org/ShowIssue.php?issue=100909.2&type=open
-			 * and write proper support.
-			 *
-			 * From a quick read there is not much we can use in
-			 * the existing dwarves tools, so just stop warning the user,
-			 * developers will find these notes if wanting to use in a
-			 * new tool.
+			 * Call site tags describe interprocedural call
+			 * metadata (callee, parameters, return values).
+			 * Useful for debuggers but not for pahole's type
+			 * reconstruction.  Silently skip them.
 			 */
 			continue;
 		case DW_TAG_dwarf_procedure:
@@ -2678,9 +2667,10 @@ static int die__process_function(Dwarf_Die *die, struct ftype *ftype,
 			continue;
 		}
 		case DW_TAG_template_value_parameter: {
-			/* FIXME: probably we'll have to attach this as a list of
-			 * template parameters to use at class__fprintf time... 
-			 * See die__process_class */
+			/*
+			 * Attached to the ftype's template value param list,
+			 * used by class__fprintf for C++ template display.
+			 */
 			struct template_value_param *tvparm = template_value_param__new(die, cu, conf);
 
 			if (tvparm == NULL)
@@ -2868,10 +2858,14 @@ static int die__process_unit(Dwarf_Die *die, struct cu *cu, struct conf_load *co
 			return -ENOMEM;
 
 		if (tag == &unsupported_tag) {
-			// XXX special case DW_TAG_dwarf_procedure, appears when looking at a recent ~/bin/perf
-			// Investigate later how to properly support this...
+			/*
+			 * DW_TAG_dwarf_procedure: compiler-internal
+			 * DWARF expressions, no type info to extract.
+			 * DW_TAG_label: skipped via conf->ignore_labels.
+			 * DW_TAG_GNU_annotation: handled elsewhere.
+			 */
 			if (dwarf_tag(die) != DW_TAG_dwarf_procedure &&
-			    dwarf_tag(die) != DW_TAG_label && // conf->ignore_labels == true, see die__process_tag()
+			    dwarf_tag(die) != DW_TAG_label &&
 			    dwarf_tag(die) != DW_TAG_GNU_annotation)
 				tag__print_not_supported(die);
 			continue;
-- 
2.55.0

