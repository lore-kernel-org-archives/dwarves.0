Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395AC329C60;
	Fri, 31 Jul 2026 19:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785526294; cv=none; b=q19XD64dTzhyW+WdURi2surJ/KWRPyqKTnH0OtT7zUhjb4+5RFMF2z3fnNwjcg+z7zIl36JXkSQXSqsqIKcNYlSha5ocRmmBhV3kPN7YBG2nJoWUJo4y4eevL6aBY5adGaAobcHefCsgVsAObajJIaTJs/p7Z3IEGhNxSkf8+R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785526294; c=relaxed/simple;
	bh=lpacyWrjmwI3yHUgzxJ3b2gAxfk1uJzsAcrvVxJ+zC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zdyu4w7yqjRkig22AfS1/QylK1T5VtMPu32jlWLZdmydMnRS3J14KgMci1oRGg3fBxQ1hjtMSGdbcIPEZ8y3TnR8AnaC1JLMivPMlXCplDTYsq1o2ffrSFgqspEC/grNu70sdk5ileaftvD3Qmj4zJ7oIiWwpKiqofzuGUJRpJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R13gkHeJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R13gkHeJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0981F00AC4;
	Fri, 31 Jul 2026 19:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785526292;
	bh=TNJz/A1+esW3OCzxyflOCjWUTVZmDS6CHrngfU/m8xo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R13gkHeJ1VqFHrEHADeMFFosjZlibmm+gclxsIck/a1H+WpSkwo4YEfmmDViJElLQ
	 CjNst++1/hqyy1+z82k+lHBurBKO9EwS6iAF/Y5MiEPm21CLHXXZq1RWg1wfTTwqcI
	 nBe/4CvGXzHQe4uNeAqOByhukenRpCY/Neg+1y45q1OQifSvMbbq/DVyI4J9cpzBa4
	 FQRPL/uCjd1CK4GKRmrYX21mfHicm7VY33XzbOqn2V2CHokhSUETqg65UfMuDCVoZj
	 OFpI3bFX8oH62+DCKysBgEXZ9fjMB/hKiDZEJlTWF4I6Fev2sSDjzxkast89CQwiTA
	 0FGlpHdfdPuIw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Mark Wieelard <mjw@redhat.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 09/12] dwarf_loader: Add cu parameter to tag__set_spec() and dwarf_tag__set_attr_type()
Date: Fri, 31 Jul 2026 16:30:57 -0300
Message-ID: <20260731193102.110693-10-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731193102.110693-1-acme@kernel.org>
References: <20260731193102.110693-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Thread the cu parameter through the reference-setting helpers, in
preparation for using it to track which offset space (main file vs dwz
alternate file) each reference targets.

The cu parameter is currently unused: dwarf_tag__set_attr_type() silently
ignores the extra macro argument, and tag__set_spec() marks it
__maybe_unused.

No functional change.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarf_loader.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index ab4036dc32cdda61..39a49e9a5048dee7 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -572,7 +572,7 @@ static void tag__free(struct tag *tag, struct cu *cu)
 	cu__free(cu, dtag);
 }
 
-#define dwarf_tag__set_attr_type(dtag, field, die, attr_name) \
+#define dwarf_tag__set_attr_type(dtag, field, die, attr_name, cu) \
 	dtag->from_types_section.field = attr_type(die, attr_name, &dtag->field)
 
 static void tag__init(struct tag *tag, struct cu *cu, Dwarf_Die *die)
@@ -584,13 +584,13 @@ static void tag__init(struct tag *tag, struct cu *cu, Dwarf_Die *die)
 	dtag->id  = dwarf_dieoffset(die);
 
 	if (tag->tag == DW_TAG_imported_module || tag->tag == DW_TAG_imported_declaration)
-		dwarf_tag__set_attr_type(dtag, type, die, DW_AT_import);
+		dwarf_tag__set_attr_type(dtag, type, die, DW_AT_import, cu);
 	else if (tag->tag == DW_TAG_variant_part)
-		dwarf_tag__set_attr_type(dtag, type, die, DW_AT_discr);
+		dwarf_tag__set_attr_type(dtag, type, die, DW_AT_discr, cu);
 	else
-		dwarf_tag__set_attr_type(dtag, type, die, DW_AT_type);
+		dwarf_tag__set_attr_type(dtag, type, die, DW_AT_type, cu);
 
-	dwarf_tag__set_attr_type(dtag, abstract_origin, die, DW_AT_abstract_origin);
+	dwarf_tag__set_attr_type(dtag, abstract_origin, die, DW_AT_abstract_origin, cu);
 	tag->recursivity_level = 0;
 	tag->attributes = NULL;
 
@@ -633,10 +633,10 @@ static struct tag *tag__new(Dwarf_Die *die, struct cu *cu)
 	return tag;
 }
 
-static void tag__set_spec(struct tag *tag, Dwarf_Die *die)
+static void tag__set_spec(struct tag *tag, Dwarf_Die *die, struct cu *cu __maybe_unused)
 {
 	struct dwarf_tag *dtag = tag__dwarf(tag);
-	dwarf_tag__set_attr_type(dtag, specification, die, DW_AT_specification);
+	dwarf_tag__set_attr_type(dtag, specification, die, DW_AT_specification, cu);
 }
 
 static struct ptr_to_member_type *ptr_to_member_type__new(Dwarf_Die *die,
@@ -647,7 +647,7 @@ static struct ptr_to_member_type *ptr_to_member_type__new(Dwarf_Die *die,
 	if (ptr != NULL) {
 		tag__init(&ptr->tag, cu, die);
 		struct dwarf_tag *dtag = tag__dwarf(&ptr->tag);
-		dwarf_tag__set_attr_type(dtag, containing_type, die, DW_AT_containing_type);
+		dwarf_tag__set_attr_type(dtag, containing_type, die, DW_AT_containing_type, cu);
 	}
 
 	return ptr;
@@ -738,7 +738,7 @@ static void type__init(struct type *type, Dwarf_Die *die, struct cu *cu, struct
 	type->size		 = attr_numeric(die, DW_AT_byte_size);
 	type->alignment		 = attr_alignment(die, conf);
 	type->declaration	 = attr_numeric(die, DW_AT_declaration);
-	tag__set_spec(&type->namespace.tag, die);
+	tag__set_spec(&type->namespace.tag, die, cu);
 	type->definition_emitted = 0;
 	type->fwd_decl_emitted	 = 0;
 	type->resized		 = 0;
@@ -851,7 +851,7 @@ static struct variable *variable__new(Dwarf_Die *die, struct cu *cu, struct conf
 		if (!var->declaration && cu->has_addr_info)
 			var->scope = dwarf__location(die, &var->ip.addr, &var->location);
 		if (has_specification) {
-			tag__set_spec(&var->ip.tag, die);
+			tag__set_spec(&var->ip.tag, die, cu);
 		}
 	}
 
@@ -1326,7 +1326,7 @@ static struct variant *variant__new(Dwarf_Die *die, struct cu *cu, struct conf_l
 					struct dwarf_tag *dtag = tag__dwarf(&var->tag);
 
 					var->name = attr_string(&child, DW_AT_name, conf);
-					dwarf_tag__set_attr_type(dtag, type, &child, DW_AT_type);
+					dwarf_tag__set_attr_type(dtag, type, &child, DW_AT_type, cu);
 					break;
 				}
 			} while (dwarf_siblingof(&child, &child) == 0);
@@ -1779,7 +1779,7 @@ static struct inline_expansion *inline_expansion__new(Dwarf_Die *die, struct cu
 		tag__init(&exp->ip.tag, cu, die);
 		dtag->decl_file = attr_string(die, DW_AT_call_file, conf);
 		dtag->decl_line = attr_numeric(die, DW_AT_call_line);
-		dwarf_tag__set_attr_type(dtag, type, die, DW_AT_abstract_origin);
+		dwarf_tag__set_attr_type(dtag, type, die, DW_AT_abstract_origin, cu);
 		exp->ip.addr = 0;
 		exp->high_pc = 0;
 
@@ -1941,7 +1941,7 @@ static struct function *function__new(Dwarf_Die *die, struct cu *cu, struct conf
 		func->declaration     = dwarf_hasattr(die, DW_AT_declaration);
 		func->external	      = dwarf_hasattr(die, DW_AT_external);
 		func->abstract_origin = dwarf_hasattr(die, DW_AT_abstract_origin);
-		tag__set_spec(&func->proto.tag, die);
+		tag__set_spec(&func->proto.tag, die, cu);
 		func->accessibility   = attr_numeric(die, DW_AT_accessibility);
 		func->virtuality      = attr_numeric(die, DW_AT_virtuality);
 		INIT_LIST_HEAD(&func->vtable_node);
-- 
2.55.0

