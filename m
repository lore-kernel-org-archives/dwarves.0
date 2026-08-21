Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64D139D6D6
	for <dwarves@vger.kernel.org>; Fri, 21 Aug 2026 21:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787348139; cv=none; b=FJLZDy8T7b6mQUposv3hGgfi2VYvRTHxhUeE72COxYrY6hAacqR9LcABOVjuF7QXKccJtnsDUv0/a6YNNWdptbMLFUt2uA3pgKkoXpIFmzhXxP0KotdeDZ60ZCTYJym8o/FrwNZoMmebsOdGAaHGH5pg9sHENDBRSJaFuNZ0J1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787348139; c=relaxed/simple;
	bh=X+ZAmXi36lNIt1DH2MkWSGk0vnSJBE4PWFGyKUKavIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YAbdIaUEGdqblF7sYequWSTHQFA+dZhtYvQxAUS7hvTUoW5U1WEHudY4NhNDbq/CoLH99c7fLb7wp1xV9BpRSFTjGlug/ihQp77SMiumtgi/3Huyf8/e/rH3PBZ8RhMle9tnvsrP0ENp/pUdtyB6LA3sIkF0Hfk+bzjnSD3hASE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCHezglN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCHezglN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 759B41F000E9;
	Fri, 21 Aug 2026 21:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787348138;
	bh=A7v5yACRkOFu5bjL4jHO76FOPqnMShp9JMGH+MPgZs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kCHezglN1SCQz8+JwlieaHUUGcSQcdNJVT4q7oLyaqfgP4lhAKFRL9iivmgVmGTXd
	 7jk9Ry8KpTL4EBWRXwObOR7UpvYVFtnfxfIAo1rcyknkJx1S3vjfzFWa7gxeP9SPq4
	 Fh53aDDOx9t01Ngl7iO526208Aexh5KNy1weLsjQIPAzNRgOTnQuElhfeMh+bGThqF
	 c/9UFdXoyH8Lvip0cQsG3tToK1pFaZGVsKkszt3I9LSz7b/IcYlh3lvSuAZr8sS58o
	 BwWkL0/jblTUpCMWASDM5mDXfWudIzT+uiEeILi9PPdJ5neJ6A0Ucw/VF2toikXGDz
	 PRZ/yyPNAGzIA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v2 7/9] dwarf_loader: Add cu parameter to tag__set_spec() and dwarf_tag__set_attr_type()
Date: Fri, 21 Aug 2026 18:35:06 -0300
Message-ID: <20260821213510.22423-8-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260821213510.22423-1-acme@kernel.org>
References: <20260821213510.22423-1-acme@kernel.org>
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
 dwarf_loader.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 086dd2bb9161dcae..103381c4dbfdf860 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -536,7 +536,7 @@ static void tag__free(struct tag *tag, struct cu *cu)
 	cu__free(cu, dtag);
 }
 
-#define dwarf_tag__set_attr_type(dtag, field, die, attr_name) \
+#define dwarf_tag__set_attr_type(dtag, field, die, attr_name, cu) \
 	dtag->from_types_section.field = attr_type(die, attr_name, &dtag->field)
 
 static void tag__init(struct tag *tag, struct cu *cu, Dwarf_Die *die)
@@ -548,13 +548,13 @@ static void tag__init(struct tag *tag, struct cu *cu, Dwarf_Die *die)
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
 
@@ -597,10 +597,10 @@ static struct tag *tag__new(Dwarf_Die *die, struct cu *cu)
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
@@ -611,7 +611,7 @@ static struct ptr_to_member_type *ptr_to_member_type__new(Dwarf_Die *die,
 	if (ptr != NULL) {
 		tag__init(&ptr->tag, cu, die);
 		struct dwarf_tag *dtag = tag__dwarf(&ptr->tag);
-		dwarf_tag__set_attr_type(dtag, containing_type, die, DW_AT_containing_type);
+		dwarf_tag__set_attr_type(dtag, containing_type, die, DW_AT_containing_type, cu);
 	}
 
 	return ptr;
@@ -702,7 +702,7 @@ static void type__init(struct type *type, Dwarf_Die *die, struct cu *cu, struct
 	type->size		 = attr_numeric(die, DW_AT_byte_size);
 	type->alignment		 = attr_alignment(die, conf);
 	type->declaration	 = attr_numeric(die, DW_AT_declaration);
-	tag__set_spec(&type->namespace.tag, die);
+	tag__set_spec(&type->namespace.tag, die, cu);
 	type->definition_emitted = 0;
 	type->fwd_decl_emitted	 = 0;
 	type->resized		 = 0;
@@ -815,7 +815,7 @@ static struct variable *variable__new(Dwarf_Die *die, struct cu *cu, struct conf
 		if (!var->declaration && cu->has_addr_info)
 			var->scope = dwarf__location(die, &var->ip.addr, &var->location);
 		if (has_specification) {
-			tag__set_spec(&var->ip.tag, die);
+			tag__set_spec(&var->ip.tag, die, cu);
 		}
 	}
 
@@ -1702,7 +1702,7 @@ static struct inline_expansion *inline_expansion__new(Dwarf_Die *die, struct cu
 		tag__init(&exp->ip.tag, cu, die);
 		dtag->decl_file = attr_string(die, DW_AT_call_file, conf);
 		dtag->decl_line = attr_numeric(die, DW_AT_call_line);
-		dwarf_tag__set_attr_type(dtag, type, die, DW_AT_abstract_origin);
+		dwarf_tag__set_attr_type(dtag, type, die, DW_AT_abstract_origin, cu);
 		exp->ip.addr = 0;
 		exp->high_pc = 0;
 
@@ -1864,7 +1864,7 @@ static struct function *function__new(Dwarf_Die *die, struct cu *cu, struct conf
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

