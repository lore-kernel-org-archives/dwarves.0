Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3925132F764;
	Fri, 31 Jul 2026 19:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785526276; cv=none; b=ZAWEB+o7Y0cRCPAiBQqqNlcY38JQIKepm8Hj1k8ZwmEjO+o0tXb+Xr8tcIFBN9ZzA2Aa/Ny7UdWWRvcff5AM573Fcmnb8EkbVrxBjMzGCtinE2H22fFJ5oha7YSoG76A+1MT6c7iTr8R9aa33m4J5yB6rQTeGlJDBGfhg01Flrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785526276; c=relaxed/simple;
	bh=PC5soVmnqBdPJifA5cntGHC+YEsVQsYl+PZnoO3gZtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCfa2IChVHFYGGasszgH/Kx5hOFT2aSqPSguMGNt62nOd3VgNu1saLZBm8OKF+BO1qQTv9McPmnqY/VWCQg/tGpaBe6mWnAB65KV2rJSSk/9sIznj+8C0rfFmq67CI0p+nGsxYEkcPEUhSm330qacTNdzM2+lSRWZtUqlEYidiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXB2xarj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXB2xarj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89131F00ACA;
	Fri, 31 Jul 2026 19:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785526273;
	bh=7iVuRi5yYxygMVIp9fKGBHveriMjSbEiG6I9MsVTy6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kXB2xarjsXurmSix9RxHjK3ng0xrqoBI5FuF3D0G501ivEVt36EgipLQHA1UukC5j
	 UNgaTaoTUH7UcZjZJGQwZWu7MguhDrPMzQC0Jh035cp5jzCqKK0NYIRSnKjkg3xwBb
	 5WTrM2SG+2vtb1R9gt6KhClM9lnUaw4kM/uxWvFa65UzqxMUnjbykQc9JPMlVn/fxf
	 +ZKC+CG4PnzOXXf9pG8ZcVAqakrsoZpHbdtfxy5XMP32ZP1VM1INmu9zQNffaC3LXK
	 ecl1EeiNn/3hDg9hsZUAPhvqRViqXa6dZzc+1lrRfIATHBEpxl47NDMWcHEcNbCXRV
	 vYhqnpKjHwyHw==
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
Subject: [PATCH 02/12] dwarf_loader: Initial support for DW_TAG_subprogram in DW_TAG_enumeration
Date: Fri, 31 Jul 2026 16:30:50 -0300
Message-ID: <20260731193102.110693-3-acme@kernel.org>
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

In Rust enums can have subprograms, add initial support for it.

Example of a Rust enumeration with a DW_TAG_subprogram tag.

  $ pahole -C ProgramKind /tmp/build/perf-tools-next/tests/workloads/code_with_type.a
  enum ProgramKind {
  	PathLookup = 0,
  	Relative   = 1,
  	Absolute   = 2,
  	enum ProgramKind new(struct &std::ffi::os_str::OsStr),
  } __attribute__((__packed__));
  $

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 btf_encoder.c     | 26 +++++++++++++++++------
 ctf_encoder.c     | 23 ++++++++++++++------
 dwarf_loader.c    | 39 +++++++++++++++++++++++++++-------
 dwarves.c         | 10 ++++-----
 dwarves.h         |  2 +-
 dwarves_emit.c    | 10 ++++-----
 dwarves_fprintf.c | 54 +++++++++++++++++++++++++++++++++++------------
 pahole.c          |  9 +++++---
 8 files changed, 123 insertions(+), 50 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 4b422e09800f3fbb..83ce21186ea7da36 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1888,7 +1888,7 @@ static int32_t btf_encoder__add_struct_type(struct btf_encoder *encoder, struct
 }
 
 static int32_t btf_encoder__add_enum_type(struct btf_encoder *encoder, struct tag *tag,
-					  struct conf_load *conf_load)
+					  const struct cu *cu, struct conf_load *conf_load)
 {
 	struct type *etype = tag__type(tag);
 	struct enumerator *pos;
@@ -1900,9 +1900,22 @@ static int32_t btf_encoder__add_enum_type(struct btf_encoder *encoder, struct ta
 		return type_id;
 
 	type__for_each_enumerator(etype, pos) {
-		name = enumerator__name(pos);
-		if (btf_encoder__add_enum_val(encoder, name, pos->value, etype, conf_load))
-			return -1;
+		switch (pos->tag.tag) {
+		case DW_TAG_enumerator:
+			name = enumerator__name(pos);
+			if (btf_encoder__add_enum_val(encoder, name, pos->value, etype, conf_load))
+				return -1;
+			break;
+		case DW_TAG_subprogram:
+			if (encoder->verbose)
+				fprintf(stderr, "BTF: DW_TAG_subprogram in enumeration '%s' not supported, skipping\n",
+					type__name(etype) ?: "(anonymous)");
+			break;
+		default:
+			fprintf(stderr, "BTF: unexpected DW_TAG_%s in enumeration '%s', skipping\n",
+				dwarf_tag_name(pos->tag.tag), type__name(etype) ?: "(anonymous)");
+			break;
+		}
 	}
 
 	return type_id;
@@ -1929,8 +1942,7 @@ static int tag__nr_btf_ids(const struct tag *tag)
 }
 
 static int btf_encoder__encode_tag(struct btf_encoder *encoder, struct tag *tag,
-				   const struct cu *cu __maybe_unused,
-				   struct conf_load *conf_load)
+				   const struct cu *cu, struct conf_load *conf_load)
 {
 	/* single out type 0 as it represents special type "void" */
 	uint32_t ref_type_id = btf_encoder__tag_type(encoder, tag->type);
@@ -2000,7 +2012,7 @@ static int btf_encoder__encode_tag(struct btf_encoder *encoder, struct tag *tag,
 		return id;
 	}
 	case DW_TAG_enumeration_type:
-		return btf_encoder__add_enum_type(encoder, tag, conf_load);
+		return btf_encoder__add_enum_type(encoder, tag, cu, conf_load);
 	case DW_TAG_subroutine_type:
 		return btf_encoder__add_func_proto_for_ftype(encoder, tag__ftype(tag));
         case DW_TAG_unspecified_type:
diff --git a/ctf_encoder.c b/ctf_encoder.c
index b761287d45348c59..f9e75a5821ce4e83 100644
--- a/ctf_encoder.c
+++ b/ctf_encoder.c
@@ -142,7 +142,7 @@ static int subroutine_type__encode(struct tag *tag, uint32_t core_id, struct ctf
 	return 0;
 }
 
-static int enumeration_type__encode(struct tag *tag, uint32_t core_id, struct ctf *ctf)
+static int enumeration_type__encode(struct tag *tag, const struct cu *cu, uint32_t core_id, struct ctf *ctf)
 {
 	struct type *etype = tag__type(tag);
 	int64_t position;
@@ -154,13 +154,24 @@ static int enumeration_type__encode(struct tag *tag, uint32_t core_id, struct ct
 		return -1;
 
 	struct enumerator *pos;
-	type__for_each_enumerator(etype, pos)
-		ctf__add_enumerator(ctf, pos->name, pos->value, &position);
+	type__for_each_enumerator(etype, pos) {
+		switch (pos->tag.tag) {
+		case DW_TAG_enumerator:
+			ctf__add_enumerator(ctf, pos->name, pos->value, &position);
+			break;
+		case DW_TAG_subprogram:
+			break;
+		default:
+			fprintf(stderr, "CTF: unexpected DW_TAG_%s in enumeration '%s', skipping\n",
+				dwarf_tag_name(pos->tag.tag), type__name(etype) ?: "(anonymous)");
+			break;
+		}
+	}
 
 	return 0;
 }
 
-static void tag__encode_ctf(struct tag *tag, uint32_t core_id, struct ctf *ctf)
+static void tag__encode_ctf(struct tag *tag, const struct cu *cu, uint32_t core_id, struct ctf *ctf)
 {
 	switch (tag->tag) {
 	case DW_TAG_base_type:
@@ -190,7 +201,7 @@ static void tag__encode_ctf(struct tag *tag, uint32_t core_id, struct ctf *ctf)
 		subroutine_type__encode(tag, core_id, ctf);
 		break;
 	case DW_TAG_enumeration_type:
-		enumeration_type__encode(tag, core_id, ctf);
+		enumeration_type__encode(tag, cu, core_id, ctf);
 		break;
 	}
 }
@@ -253,7 +264,7 @@ int cu__encode_ctf(struct cu *cu, int verbose)
 	uint32_t id;
 	struct tag *pos;
 	cu__for_each_type(cu, id, pos)
-		tag__encode_ctf(pos, id, ctf);
+		tag__encode_ctf(pos, cu, id, ctf);
 
 	struct hlist_head hash_addr[HASHADDR__SIZE];
 
diff --git a/dwarf_loader.c b/dwarf_loader.c
index af166ec9064e82c6..11477dcd7373a844 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -2310,6 +2310,8 @@ out_delete:
 	return NULL;
 }
 
+static struct tag *die__create_new_function(Dwarf_Die *die, struct cu *cu, struct conf_load *conf);
+
 static struct tag *die__create_new_enumeration(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
 {
 	Dwarf_Die child;
@@ -2331,18 +2333,39 @@ static struct tag *die__create_new_enumeration(Dwarf_Die *die, struct cu *cu, st
 
 	die = &child;
 	do {
-		struct enumerator *enumerator;
+		switch (dwarf_tag(die)) {
+		case DW_TAG_enumerator: {
+			struct enumerator *enumerator = enumerator__new(die, cu, conf);
+
+			if (enumerator == NULL)
+				goto out_delete;
+
+			enumeration__add(enumeration, enumerator);
+			cu__hash(cu, &enumerator->tag);
+		}
+			continue;
+		case DW_TAG_subprogram: {
+			struct tag *tag = die__create_new_function(die, cu, conf);
+			uint32_t id;
+
+			if (tag == NULL)
+				goto out_delete;
+
+			if (cu__table_add_tag(cu, tag, &id) < 0) {
+				tag__delete(tag, cu);
+				goto out_delete;
+			}
 
-		if (dwarf_tag(die) != DW_TAG_enumerator) {
+			struct dwarf_tag *dtag = tag__dwarf(tag);
+			dtag->small_id = id;
+			namespace__add_tag(&enumeration->namespace, tag);
+			cu__hash(cu, tag);
+			break;
+		}
+		default:
 			cu__tag_not_handled(cu, die);
 			continue;
 		}
-		enumerator = enumerator__new(die, cu, conf);
-		if (enumerator == NULL)
-			goto out_delete;
-
-		enumeration__add(enumeration, enumerator);
-		cu__hash(cu, &enumerator->tag);
 	} while (dwarf_siblingof(die, die) == 0);
 out:
 	return &enumeration->namespace.tag;
diff --git a/dwarves.c b/dwarves.c
index b48d9a3b9c43eebc..58852d3783b894ff 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -1256,11 +1256,6 @@ void type__delete(struct type *type, struct cu *cu)
 	cu__tag_free(cu, type__tag(type));
 }
 
-static void enumerator__delete(struct enumerator *enumerator, struct cu *cu)
-{
-	cu__tag_free(cu, &enumerator->tag);
-}
-
 void enumeration__delete(struct type *type, struct cu *cu)
 {
 	struct enumerator *pos, *n;
@@ -1270,7 +1265,7 @@ void enumeration__delete(struct type *type, struct cu *cu)
 
 	type__for_each_enumerator_safe_reverse(type, pos, n) {
 		list_del_init(&pos->tag.node);
-		enumerator__delete(pos, cu);
+		tag__delete(&pos->tag, cu);
 	}
 
 	if (type->suffix_disambiguation)
@@ -1928,6 +1923,9 @@ static void enumeration__calc_prefix(struct type *enumeration)
 	struct enumerator *entry;
 
 	type__for_each_enumerator(enumeration, entry) {
+		if (entry->tag.tag != DW_TAG_enumerator)
+			continue;
+
 		const char *curr_name = enumerator__name(entry);
 
 		if (previous_name) {
diff --git a/dwarves.h b/dwarves.h
index 0fc57ed0c7576c01..f5368f68c2460488 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -1646,7 +1646,7 @@ static inline const char *enumerator__name(const struct enumerator *enumerator)
 
 void enumeration__delete(struct type *type, struct cu *cu);
 void enumeration__add(struct type *type, struct enumerator *enumerator);
-size_t enumeration__fprintf(const struct tag *tag_enum,
+size_t enumeration__fprintf(const struct tag *tag_enum, const struct cu *cu,
 			    const struct conf_fprintf *conf, FILE *fp);
 
 int dwarves__init(void);
diff --git a/dwarves_emit.c b/dwarves_emit.c
index 01b33b7ec41eb947..aaf0f8f9a7ea815a 100644
--- a/dwarves_emit.c
+++ b/dwarves_emit.c
@@ -100,7 +100,7 @@ static struct type *type_emissions__find_fwd_decl(const struct type_emissions *e
 	return NULL;
 }
 
-static int enumeration__emit_definitions(struct tag *tag,
+static int enumeration__emit_definitions(struct tag *tag, const struct cu *cu,
 					 struct type_emissions *emissions,
 					 const struct conf_fprintf *conf,
 					 FILE *fp)
@@ -121,7 +121,7 @@ static int enumeration__emit_definitions(struct tag *tag,
 		return 0;
 	}
 
-	enumeration__fprintf(tag, conf, fp);
+	enumeration__fprintf(tag, cu, conf, fp);
 	fputs(";\n", fp);
 
 	// See comment on enumeration__fprintf(), it seems this happens with DWARF as well
@@ -198,10 +198,10 @@ static int typedef__emit_definitions(struct tag *tdef, struct cu *cu,
 		if (type__name(ctype) == NULL) {
 			fputs("typedef ", fp);
 			conf.suffix = type__name(def);
-			enumeration__emit_definitions(type, emissions, &conf, fp);
+			enumeration__emit_definitions(type, cu, emissions, &conf, fp);
 			goto out;
 		} else
-			enumeration__emit_definitions(type, emissions, &conf, fp);
+			enumeration__emit_definitions(type, cu, emissions, &conf, fp);
 	}
 		break;
 	case DW_TAG_structure_type:
@@ -380,7 +380,7 @@ next_indirection:
 			struct conf_fprintf conf = {
 				.suffix = NULL,
 			};
-			return enumeration__emit_definitions(type, emissions, &conf, fp);
+			return enumeration__emit_definitions(type, cu, emissions, &conf, fp);
 		}
 		break;
 	case DW_TAG_structure_type:
diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
index d7edb0cb14a5b803..75615072d03d32a0 100644
--- a/dwarves_fprintf.c
+++ b/dwarves_fprintf.c
@@ -155,6 +155,8 @@ const char tabs[] = "\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t";
 
 static size_t union__fprintf(struct type *type, const struct cu *cu,
 			     const struct conf_fprintf *conf, FILE *fp);
+static size_t function__fprintf(const struct tag *tag, const struct cu *cu,
+				const struct conf_fprintf *conf, FILE *fp);
 
 /*
  * In dwarves_emit.c we can call type__emit() using a locally setup conf_fprintf for which
@@ -406,7 +408,7 @@ next_type:
 		struct conf_fprintf tconf = *pconf;
 
 		tconf.suffix = type__name(type);
-		return printed + enumeration__fprintf(tag_type, &tconf, fp);
+		return printed + enumeration__fprintf(tag_type, cu, &tconf, fp);
 	}
 	}
 
@@ -450,7 +452,15 @@ static int enumeration__max_entry_name_len(struct type *type)
 	struct enumerator *pos;
 
 	type__for_each_enumerator(type, pos) {
-		int len = strlen(enumerator__name(pos));
+		int len = 0;
+
+		if (pos->tag.tag == DW_TAG_enumerator)
+			len = strlen(enumerator__name(pos));
+		else if (pos->tag.tag == DW_TAG_subprogram) {
+			const char *fname = function__name(tag__function(&pos->tag));
+			if (fname)
+				len = strlen(fname);
+		}
 
 		if (type->max_tag_name_len < len)
 			type->max_tag_name_len = len;
@@ -459,7 +469,8 @@ out:
 	return type->max_tag_name_len;
 }
 
-size_t enumeration__fprintf(const struct tag *tag, const struct conf_fprintf *conf, FILE *fp)
+size_t enumeration__fprintf(const struct tag *tag, const struct cu *cu,
+			    const struct conf_fprintf *conf, FILE *fp)
 {
 	struct type *type = tag__type(tag);
 	struct enumerator *pos;
@@ -480,13 +491,25 @@ size_t enumeration__fprintf(const struct tag *tag, const struct conf_fprintf *co
 	}
 
 	type__for_each_enumerator(type, pos) {
-		printed += fprintf(fp, "%.*s\t%-*s = ", indent, tabs,
-				   max_entry_name_len, enumerator__name(pos));
-		if (conf->hex_fmt)
-			printed += fprintf(fp, "%#llx", (unsigned long long)pos->value);
-		else
-			printed += fprintf(fp, type->is_signed_enum ?  "%lld" : "%llu",
-					   (unsigned long long)pos->value);
+		printed += fprintf(fp, "%.*s\t", indent, tabs);
+
+		switch (pos->tag.tag) {
+		case DW_TAG_subprogram:
+			printed += function__fprintf(&pos->tag, cu, conf, fp);
+			break;
+		case DW_TAG_enumerator:
+			printed += fprintf(fp, "%-*s = ", max_entry_name_len, enumerator__name(pos));
+			if (conf->hex_fmt)
+				printed += fprintf(fp, "%#llx", (unsigned long long)pos->value);
+			else
+				printed += fprintf(fp, type->is_signed_enum ?  "%lld" : "%llu",
+						   (unsigned long long)pos->value);
+			break;
+		default:
+			printed += fprintf(fp, "/* Unexpected %s <%llx> */\n", dwarf_tag_name(pos->tag.tag),
+					   tag__orig_id(&pos->tag, cu));
+			continue;
+		}
 		printed += fprintf(fp, ",\n");
 	}
 
@@ -586,9 +609,12 @@ static const char *__tag__name(const struct tag *tag, const struct cu *cu,
 		strncpy(bf, name, len);
 	}
 		break;
-	case DW_TAG_subprogram:
-		strncpy(bf, function__name(tag__function(tag)), len);
+	case DW_TAG_subprogram: {
+		const char *fname = function__name(tag__function(tag));
+		if (fname)
+			strncpy(bf, fname, len);
 		break;
+	}
 	case DW_TAG_pointer_type:
 		return tag__ptr_name(tag, cu, bf, len, "*", conf);
 	case DW_TAG_reference_type:
@@ -937,7 +963,7 @@ print_modifier: {
 		if (type__name(ctype) != NULL && !expand_types)
 			printed += fprintf(fp, "enum %-*s %s", tconf.type_spacing - 5, type__name(ctype), name ?: "");
 		else
-			printed += enumeration__fprintf(type, &tconf, fp);
+			printed += enumeration__fprintf(type, cu, &tconf, fp);
 		break;
 	case DW_TAG_LLVM_annotation:
 	case DW_TAG_GNU_annotation: {
@@ -2173,7 +2199,7 @@ size_t tag__fprintf(struct tag *tag, const struct cu *cu,
 		printed += array_type__fprintf(tag, cu, "array", pconf, fp);
 		break;
 	case DW_TAG_enumeration_type:
-		printed += enumeration__fprintf(tag, pconf, fp);
+		printed += enumeration__fprintf(tag, cu, pconf, fp);
 		break;
 	case DW_TAG_typedef:
 		printed += typedef__fprintf(tag, cu, pconf, fp);
diff --git a/pahole.c b/pahole.c
index 5cf92833e6e84df9..0a7b810568f0dfeb 100644
--- a/pahole.c
+++ b/pahole.c
@@ -2162,7 +2162,7 @@ static const char *enumeration__lookup_value(struct type *enumeration, uint64_t
 	struct enumerator *entry;
 
 	type__for_each_enumerator(enumeration, entry) {
-		if (entry->value == value)
+		if (entry->tag.tag == DW_TAG_enumerator && entry->value == value)
 			return enumerator__name(entry);
 	}
 
@@ -2187,7 +2187,7 @@ static struct enumerator *enumeration__lookup_entry_from_value(struct type *enum
 	struct enumerator *entry;
 
 	type__for_each_enumerator(enumeration, entry) {
-		if (entry->value == value)
+		if (entry->tag.tag == DW_TAG_enumerator && entry->value == value)
 			return entry;
 	}
 
@@ -2213,6 +2213,9 @@ static struct enumerator *enumeration__find_enumerator(struct type *enumeration,
 	struct enumerator *entry;
 
 	type__for_each_enumerator(enumeration, entry) {
+		if (entry->tag.tag != DW_TAG_enumerator)
+			continue;
+
 		const char *entry_name = enumerator__name(entry);
 
 		if (!strcmp(entry_name, name))
@@ -3268,7 +3271,7 @@ static bool print_enumeration_with_enumerator(struct cu *cu, const char *name)
 
 	cu__for_each_enumeration(cu, id, enumeration) {
 		if (enumeration__find_enumerator(enumeration, name) != NULL) {
-			enumeration__fprintf(type__tag(enumeration), &conf, stdout);
+			enumeration__fprintf(type__tag(enumeration), cu, &conf, stdout);
 			fputc('\n', stdout);
 			return true;
 		}
-- 
2.55.0

