Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0530E34D3B5
	for <dwarves@vger.kernel.org>; Mon, 22 Jun 2026 20:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782159917; cv=none; b=nwO7a7pZOxg/AjQw8BUb0NBCWnaOfCEUoZbjXSxDe1Yi8FS7lgz4tkpI4qWOLInuungzX7LD0FgZpMWsebjKTNJRh39fj8w4OV80vC6lEPOiADlw467gcZFQ2W8qf9/RhJYADOWVnsMGs14lF+eGZviUzoyacwevReIIMF3o+ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782159917; c=relaxed/simple;
	bh=o8mcfs+pH2t2fRFldQzcQSR71EU4BR0HhveVakjC6u8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bGiNx1GGjiRm/kPdGZJSL99UQ6/43tmaj2r4eh5L7jmEjIr78V7F6GX6dFg0uQWPQ/Gy1mD+qEHXPl3yO01HmfYvAekT1xQFi3nLjcIcA0lUwY6cyUaUAXXOMEBTQ4ud+SBT87+jsHgOvbxQTPj0CFLWtHh+UHSJYPbkIhmejpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGsFn8vu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGsFn8vu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD13A1F000E9;
	Mon, 22 Jun 2026 20:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782159915;
	bh=338SUE2+KfI1a/FdOzg8W8P9XpwWjmQfCX+QpLrr0kc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KGsFn8vuXfUA65mVhkcWWoL+oBkSdIjwdTzmFx8lXHGv6zdLEzjn94oBUKh9bfk3T
	 6k8CXc9994LgGhDN3OWAxo8vJcCWIJuA3dKgDrZ2YzMnWfdFzaqhPAW5AfDWdHC466
	 C9Jg1+lN1EVwjrmMYCMFdmegp8IqqVilX/qe+oNT6kYyaSX1bjGNQ33vqwpjGhFfHJ
	 WK1XPjKw8/O5cadR0KXJ5GiXzQxwBBoQKNP1/ngKaLZwBIvBSk1Z1E/pZKjQJ3jsfz
	 yKcfSZ0sYS4KSpCuZZf2hLZDZMpRNAc1mUaYvhGpS9NAKXPtIAmfJPXN+B9AL4i17J
	 tN2m10W9ffqGw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 12/16] dwarf_loader: Support DW_TAG_imported_unit for same-file partial units
Date: Mon, 22 Jun 2026 17:24:35 -0300
Message-ID: <20260622202441.14799-13-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622202441.14799-1-acme@kernel.org>
References: <20260622202441.14799-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Binaries processed by the dwz(1) tool have their DWARF type information
deduplicated into DW_TAG_partial_unit entries that are then referenced
via DW_TAG_imported_unit from each DW_TAG_compile_unit that uses those
types. This is the standard DWARF mechanism for cross-CU type sharing.

On Fedora/RHEL, most debuginfo packages are built with dwz, making this
a common pattern. For instance, bash-debuginfo has 10,486
DW_TAG_partial_unit, 384 DW_TAG_compile_unit, and 8,572
DW_TAG_imported_unit entries — all using same-file references (no .dwz
alternate DWARF file involved).

Before this patch, pahole skipped DW_TAG_partial_unit with a warning:

  WARNING: DW_TAG_partial_unit used, some types will not be considered!
           Probably this was optimized using a tool like 'dwz'
           A future version of pahole will support this.

And DW_TAG_imported_unit was silently ignored (returned NULL), causing
pahole to report "file has no dwarf type information" for binaries like
bash and glibc.

The fix adds die__process_imported_unit(), called from die__process_unit()
when encountering DW_TAG_imported_unit. It follows DW_AT_import to the
referenced DW_TAG_partial_unit DIE and processes its children inline into
the importing compile unit's type tables. This works because
dwarf_formref_die() already handles all DWARF reference forms, and each
CU maintains its own independent hash tables — so the same partial unit
can be safely imported by multiple CUs, each getting its own copy of the
types.

Since imported units can themselves contain DW_TAG_imported_unit entries
(nested imports), a depth limit of 64 is enforced to prevent stack
overflow from pathological or corrupted DWARF.  A warning is emitted if
the limit is reached.

Some binaries (e.g. chromium-browser on Fedora 44, built with Rust
components) also have DW_TAG_imported_unit entries that reference partial
units in an alternate debug file via DW_FORM_GNU_ref_alt (the
.gnu_debugaltlink mechanism). When elfutils resolves such a reference, it
returns DIEs from the alternate file whose offsets are in a different
address space — processing these into the main CU's hash tables corrupts
type references and causes a crash during type recoding.

The same DW_FORM_GNU_ref_alt form can also appear on regular type
attributes (DW_AT_type, DW_AT_abstract_origin, DW_AT_specification,
etc.), not just on DW_TAG_imported_unit's DW_AT_import. Guard all paths
via attr_form_is_ref_alt(), which skips the reference and warns once, so
users know why some types are missing rather than getting a crash.

The korg/alt_dwarf branch had a previous attempt at this that also
handled the .dwz alternate DWARF file case (DW_FORM_GNU_ref_alt), but it
was never merged and is now 294 commits behind master. This patch takes a
simpler approach focused on the same-file case first, which covers dwz
output on Fedora/RHEL where all partial units are within the same .debug
file.

Before (bash-5.3.9-3.fc44.x86_64 debuginfo):
  $ pahole -F dwarf /usr/lib/debug/usr/bin/bash-5.3.9-3.fc44.x86_64.debug
  WARNING: DW_TAG_partial_unit used, some types will not be considered!
  pahole: /usr/lib/debug/usr/bin/bash-5.3.9-3.fc44.x86_64.debug: file has no dwarf type information

After:
  $ pahole -F dwarf /usr/lib/debug/usr/bin/bash-5.3.9-3.fc44.x86_64.debug | wc -l
  1605
  $ pahole -F dwarf -C variable /usr/lib/debug/usr/bin/bash-5.3.9-3.fc44.x86_64.debug
  struct variable {
  	char *                     name;                 /*     0     8 */
  	char *                     value;                /*     8     8 */
  	...
  	/* size: 48, cachelines: 1, members: 7 */
  };

Before (chromium-browser debuginfo, Fedora 44):
  $ pahole /usr/lib/debug/.../chromium-browser-149.0.7827.155-1.fc44.x86_64.debug
  Segmentation fault

After:
  $ pahole /usr/lib/debug/.../chromium-browser-149.0.7827.155-1.fc44.x86_64.debug
  WARNING: DW_FORM_GNU_ref_alt (dwz alternate debug file) not yet supported,
           some types will not be available.

Reported-by: Sashiko:gemini-3-1-pro-preview # Running on a local machine
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarf_loader.c | 153 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 131 insertions(+), 22 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 9f7d2bd23359191b..7091655588cd8b4d 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -136,6 +136,9 @@ struct dwarf_cu {
 	struct dwarf_tag *last_type_lookup;
 	struct cu *cu;
 	struct dwarf_cu *type_unit;
+	Dwarf_Off *imported_units;
+	uint32_t  nr_imported_units;
+	uint32_t  allocated_imported_units;
 };
 
 static int dwarf_cu__init(struct dwarf_cu *dcu, struct cu *cu)
@@ -161,6 +164,9 @@ static int dwarf_cu__init(struct dwarf_cu *dcu, struct cu *cu)
 		INIT_HLIST_HEAD(&dcu->hash_types[i]);
 	}
 	dcu->type_unit = NULL;
+	dcu->imported_units = NULL;
+	dcu->nr_imported_units = 0;
+	dcu->allocated_imported_units = 0;
 	// To avoid a per-lookup check against NULL in dwarf_cu__find_type_by_ref()
 	dcu->last_type_lookup = &sentinel_dtag;
 	return 0;
@@ -185,6 +191,7 @@ static void dwarf_cu__delete(struct cu *cu)
 
 	struct dwarf_cu *dcu = cu->priv;
 
+	free(dcu->imported_units);
 	// dcu->hash_tags & dcu->hash_types are on cu->obstack
 	cu__free(cu, dcu);
 	cu->priv = NULL;
@@ -446,12 +453,32 @@ static const char *attr_string(Dwarf_Die *die, uint32_t name, struct conf_load *
 	return str;
 }
 
+static bool attr_form_is_ref_alt(Dwarf_Attribute *attr)
+{
+	if (attr->form == DW_FORM_GNU_ref_alt) {
+		static bool warned;
+
+		if (!warned) {
+			fprintf(stderr,
+				"WARNING: DW_FORM_GNU_ref_alt (dwz alternate debug file) not yet supported,\n"
+				"         some types will not be available.\n");
+			warned = true;
+		}
+		return true;
+	}
+	return false;
+}
+
 static bool attr_type(Dwarf_Die *die, uint32_t attr_name, Dwarf_Off *offset)
 {
 	Dwarf_Attribute attr;
 
 	if (dwarf_attr(die, attr_name, &attr) != NULL) {
 		Dwarf_Die type_die;
+		if (attr_form_is_ref_alt(&attr)) {
+			*offset = 0;
+			return 0;
+		}
 		if (dwarf_formref_die(&attr, &type_die) != NULL) {
 			*offset = dwarf_dieoffset(&type_die);
 			return attr.form == DW_FORM_ref_sig8;
@@ -679,7 +706,8 @@ static void type__init(struct type *type, Dwarf_Die *die, struct cu *cu, struct
 	Dwarf_Attribute attr;
 	if (dwarf_attr(die, DW_AT_type, &attr) != NULL) {
 		Dwarf_Die type_die;
-		if (dwarf_formref_die(&attr, &type_die) != NULL) {
+		if (!attr_form_is_ref_alt(&attr) &&
+		    dwarf_formref_die(&attr, &type_die) != NULL) {
 			uint64_t encoding = attr_numeric(&type_die, DW_AT_encoding);
 
 			if (encoding == DW_ATE_signed || encoding == DW_ATE_signed_char)
@@ -993,9 +1021,14 @@ static int add_gnu_annotation_chain(Dwarf_Die *die, int component_idx,
 	Dwarf_Attribute attr;
 	Dwarf_Die annot_die;
 
-	while (dwarf_attr(die, DW_AT_GNU_annotation, &attr) != NULL &&
-	       dwarf_formref_die(&attr, &annot_die) != NULL &&
-	       dwarf_tag(&annot_die) == DW_TAG_GNU_annotation) {
+	while (dwarf_attr(die, DW_AT_GNU_annotation, &attr) != NULL) {
+		if (attr_form_is_ref_alt(&attr))
+			break;
+		if (dwarf_formref_die(&attr, &annot_die) == NULL)
+			break;
+		if (dwarf_tag(&annot_die) != DW_TAG_GNU_annotation)
+			break;
+
 		int ret = add_tag_annotation(&annot_die, component_idx, conf, head);
 		if (ret)
 			return ret;
@@ -1791,9 +1824,13 @@ check_gnu_attr:
 		goto out;
 
 	/* Handle GCC-style DW_AT_GNU_annotation attribute */
-	while (dwarf_attr(die, DW_AT_GNU_annotation, &attr) != NULL &&
-	       dwarf_formref_die(&attr, &annot_die) != NULL &&
-	       dwarf_tag(&annot_die) == DW_TAG_GNU_annotation) {
+	while (dwarf_attr(die, DW_AT_GNU_annotation, &attr) != NULL) {
+		if (attr_form_is_ref_alt(&attr))
+			break;
+		if (dwarf_formref_die(&attr, &annot_die) == NULL)
+			break;
+		if (dwarf_tag(&annot_die) != DW_TAG_GNU_annotation)
+			break;
 		name = attr_string(&annot_die, DW_AT_name, conf);
 		if (strcmp(name, "btf_type_tag") != 0)
 			break;
@@ -2614,7 +2651,7 @@ static struct tag *__die__process_tag(Dwarf_Die *die, struct cu *cu,
 
 	switch (dwarf_tag(die)) {
 	case DW_TAG_imported_unit:
-		return NULL; // We don't support imported units yet, so to avoid segfaults
+		return &unsupported_tag; // Handled in die__process_unit()
 	case DW_TAG_array_type:
 		tag = die__create_new_array(die, cu);		break;
 	case DW_TAG_string_type: // FORTRAN stuff, looks like an array
@@ -2682,9 +2719,90 @@ static struct tag *__die__process_tag(Dwarf_Die *die, struct cu *cu,
 	return tag;
 }
 
-static int die__process_unit(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
+#define MAX_IMPORTED_UNIT_DEPTH 64
+
+static int die__process_unit(Dwarf_Die *die, struct cu *cu, struct conf_load *conf, int import_depth);
+
+static bool dwarf_cu__imported_unit_visited(struct dwarf_cu *dcu, Dwarf_Off offset)
+{
+	for (uint32_t i = 0; i < dcu->nr_imported_units; i++)
+		if (dcu->imported_units[i] == offset)
+			return true;
+	return false;
+}
+
+static int dwarf_cu__mark_imported_unit(struct dwarf_cu *dcu, struct cu *cu, Dwarf_Off offset)
+{
+	if (dcu->nr_imported_units == dcu->allocated_imported_units) {
+		uint32_t new_size = dcu->allocated_imported_units ? dcu->allocated_imported_units * 2 : 16;
+		Dwarf_Off *new_array = realloc(dcu->imported_units, new_size * sizeof(Dwarf_Off));
+		if (new_array == NULL)
+			return -ENOMEM;
+		dcu->imported_units = new_array;
+		dcu->allocated_imported_units = new_size;
+	}
+	dcu->imported_units[dcu->nr_imported_units++] = offset;
+	return 0;
+}
+
+static int die__process_imported_unit(Dwarf_Die *die, struct cu *cu, struct conf_load *conf, int import_depth)
+{
+	Dwarf_Attribute attr;
+
+	if (dwarf_attr(die, DW_AT_import, &attr) == NULL)
+		return 0;
+
+	if (attr_form_is_ref_alt(&attr))
+		return 0;
+
+	Dwarf_Die imported_die;
+
+	if (dwarf_formref_die(&attr, &imported_die) == NULL)
+		return 0;
+
+	if (dwarf_tag(&imported_die) != DW_TAG_partial_unit)
+		return 0;
+
+	if (import_depth >= MAX_IMPORTED_UNIT_DEPTH) {
+		static bool warned;
+
+		if (!warned) {
+			fprintf(stderr,
+				"WARNING: DW_TAG_imported_unit nesting too deep (>%d), "
+				"some types will not be available.\n",
+				MAX_IMPORTED_UNIT_DEPTH);
+			warned = true;
+		}
+		return 0;
+	}
+
+	Dwarf_Off offset = dwarf_dieoffset(&imported_die);
+	struct dwarf_cu *dcu = cu->priv;
+
+	if (dwarf_cu__imported_unit_visited(dcu, offset))
+		return 0;
+
+	if (dwarf_cu__mark_imported_unit(dcu, cu, offset))
+		return -ENOMEM;
+
+	Dwarf_Die child;
+
+	if (dwarf_child(&imported_die, &child) == 0)
+		return die__process_unit(&child, cu, conf, import_depth + 1);
+
+	return 0;
+}
+
+static int die__process_unit(Dwarf_Die *die, struct cu *cu, struct conf_load *conf, int import_depth)
 {
 	do {
+		if (dwarf_tag(die) == DW_TAG_imported_unit) {
+			int err = die__process_imported_unit(die, cu, conf, import_depth);
+			if (err)
+				return err;
+			continue;
+		}
+
 		struct tag *tag = die__process_tag(die, cu, 1, conf);
 		if (tag == NULL)
 			return -ENOMEM;
@@ -3305,17 +3423,8 @@ static int die__process(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
 		return 0; // so that other units can be processed
 	}
 
-	if (tag == DW_TAG_partial_unit) {
-		static bool warned;
-
-		if (!warned) {
-			fprintf(stderr, "WARNING: DW_TAG_partial_unit used, some types will not be considered!\n"
-					"         Probably this was optimized using a tool like 'dwz'\n"
-					"         A future version of pahole will support this.\n");
-			warned = true;
-		}
-		return 0; // so that other units can be processed
-	}
+	if (tag == DW_TAG_partial_unit)
+		return 0; // Processed inline when reached via DW_TAG_imported_unit
 
 	if (tag != DW_TAG_compile_unit && tag != DW_TAG_type_unit) {
 		fprintf(stderr, "%s: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_unit or DW_TAG_skeleton_unit expected got %s (0x%x) @ %llx!\n",
@@ -3336,7 +3445,7 @@ static int die__process(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
 		return DWARF_CB_OK;
 
 	if (dwarf_child(die, &child) == 0) {
-		int err = die__process_unit(&child, cu, conf);
+		int err = die__process_unit(&child, cu, conf, 0);
 		if (err)
 			return err;
 	}
@@ -4099,7 +4208,7 @@ static int cus__merge_and_process_cu(struct cus *cus, struct conf_load *conf,
 				filtered = conf->early_cu_filter(&unmerged_cu) == NULL;
 			}
 
-			if (!filtered && die__process_unit(&child, cu, conf) != 0)
+			if (!filtered && die__process_unit(&child, cu, conf, 0) != 0)
 				goto out_abort;
 		}
 
-- 
2.54.0

