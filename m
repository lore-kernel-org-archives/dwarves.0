Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278D3271471
	for <dwarves@vger.kernel.org>; Thu, 18 Jun 2026 00:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781744279; cv=none; b=SviyizEtpUroxH5jYl2hy0yFW4t+H9gb0BP0gt3U/k9u0zXiOeTI6I8xHJ7GT/iyEOm3bXMMA58X1wr9PjK1aWVk3Ro96KvFDCdPCCipKYYwlqgkOEbsv7cUQtxCVk1/BRVBNr/ln/Tfa026hmTzy98V+khnwwC0/l615UOqBX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781744279; c=relaxed/simple;
	bh=9qae7IQbbCO/ae9jle/qaUe0QGjv10EOw+Nrz+GHxCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BDj1SGUbwUX/p/L03A+vI2M1WBBmhhG/8w1OTI+DQgVb1PuLrdmwLGISeObFWTzBswWPtPA3w3D+oiNxGE7Va/JwB+aGE/s7pUrohjLzIVAfGuvT+fck0vVdItxex6DvOTFbydcrTqsFQMBPKUvzvIoADqNdAZmiMrauu8cGLPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KPqbtA0j; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KPqbtA0j"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781744275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wPLRncmvcdbp6Zd2IWLG2B6K6WpS/BMl9s/PJP/Hpac=;
	b=KPqbtA0jAj7hVOPHHzn6fl9AWXi2TAyQgE+45W1rHiE/L9mWETTVfIttATWlxKPgCYq5Fv
	CfKxGJtSAGq0RRqhZ5aW2JfrvoXkr0MpIeVUD0IJyOdDTzkc0oy3k/ec1z+aFx8xeXioFT
	X7kPcoGjSLNns8mjRDjSHLGQGi3ptHM=
From: Vineet Gupta <vineet.gupta@linux.dev>
To: dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	acme@kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	jose.marchesi@oracle.com,
	David Faust <david.faust@oracle.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PAHOLE v5 3/5] dwarf_loader: Add support for DW_TAG_GNU_annotation
Date: Wed, 17 Jun 2026 17:57:29 -0700
Message-ID: <20260618005731.273181-4-vineet.gupta@linux.dev>
In-Reply-To: <20260618005731.273181-1-vineet.gupta@linux.dev>
References: <20260618005731.273181-1-vineet.gupta@linux.dev>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

gcc 16 was the first release to support DW_TAG_GNU_annotations and this
patch enables the same in pahole. Bulk of changes are dwarf_loader but
btf_encoder also gains support with minimal changes.

GCC encodes btf_type_tag and btf_decl_tag annotations differently from
LLVM. While LLVM uses DW_TAG_LLVM_annotation (0x6000) as child DIEs,
GCC uses DW_TAG_GNU_annotation (0x6001) as standalone sibling DIEs
referenced via DW_AT_GNU_annotation (0x2139) attributes, with chaining
through the same attribute on annotation DIEs themselves.

Handle both encoding styles:

For btf_type_tag (pointer annotations):
- Recognize DW_TAG_GNU_annotation alongside DW_TAG_LLVM_annotation in
  child annotation scanning.
- Follow DW_AT_GNU_annotation attribute chains on pointer types for
  GCC-style btf_type_tag resolution.
- Normalize DW_TAG_GNU_annotation to DW_TAG_LLVM_annotation in the
  internal representation so downstream code works unchanged.
- Preserve btf_type_tag emission order across both formats: LLVM child
  DIEs come in source order and are prepended (reversed) into the tag
  list, while a GCC DW_AT_GNU_annotation chain is already in BTF order
  and is appended. die__add_btf_type_tag() takes a 'prepend' argument
  to select between the two.

For btf_decl_tag (function/struct/member annotations):
- Add add_gnu_annotation_chain() to follow DW_AT_GNU_annotation
  attribute chains on function, struct, and member DIEs.
- GCC puts DW_AT_GNU_annotation on the function/struct DIE itself
  (not as child DIEs), referencing sibling annotation DIEs that chain
  via the same attribute.
- Follow DW_AT_GNU_annotation chains on formal parameter DIEs so that
  GCC-style parameter decl tags are loaded too.

Also:
- Silently skip standalone DW_TAG_GNU_annotation DIEs at CU level.
- Add tag__is_annotation() helper macro for annotation tag checks.
- Rename add_llvm_annotation -> add_tag_annotation,
  skip_llvm_annotations -> skip_tag_annotations since these now
  handle both LLVM and GNU annotation formats.

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
---
Changes since v4 [4]
 - Handle gcc-style function paramter tags [Alan]
 - Handle multi tag ordering correctly for LLVM and GCC [Alan]
 - Collected the review tags [Emil, Yonghong]

Changes since v3 [3]
 - Add helper tag__is_annotation [Emil]
 - Rename some functions containing "llvm" as they are common to LLVM/GCC tags [Emil]
 - Deduplicate checks before loop and inside loop in add_gnu_annotation_chain() and check_gnu_attr [Arnaldo]
 - Fix some typos and move some comments [Emi]

Changes since v2 [2]
 - Removed loop detection logic [Alan]
 - Move test changes to different patch [Alan]

Changes since v1 [1]
 - NFC Reduce indentation with early exits (Alexei offlist)

[4] https://lore.kernel.org/bpf/20260602195512.1511013-2-vineet.gupta@linux.dev/
[3] https://lore.kernel.org/bpf/20260601183511.594100-2-vineet.gupta@linux.dev/
[2] https://lore.kernel.org/bpf/20260528223616.2035618-2-vineet.gupta@linux.dev/
[1] https://lore.kernel.org/bpf/20260526181818.4159927-2-vineet.gupta@linux.dev/
---
 btf_encoder.c     |   1 +
 dutil.h           |  11 ++++
 dwarf_loader.c    | 141 +++++++++++++++++++++++++++++++++++++++-------
 dwarves.h         |   2 +-
 dwarves_fprintf.c |  12 ++--
 5 files changed, 141 insertions(+), 26 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 633bc6162ce0..d5af706d7638 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1831,6 +1831,7 @@ static int btf_encoder__encode_tag(struct btf_encoder *encoder, struct tag *tag,
 		name = namespace__name(tag__namespace(tag));
 		return btf_encoder__add_ref_type(encoder, BTF_KIND_TYPEDEF, ref_type_id, name, false);
 	case DW_TAG_LLVM_annotation:
+	case DW_TAG_GNU_annotation:
 		name = tag__btf_type_tag(tag)->value;
 		return btf_encoder__add_ref_type(encoder, BTF_KIND_TYPE_TAG, ref_type_id, name, false);
 	case DW_TAG_structure_type:
diff --git a/dutil.h b/dutil.h
index ff78aa6dfd10..be02c68cf4a7 100644
--- a/dutil.h
+++ b/dutil.h
@@ -35,6 +35,17 @@
 #define DW_TAG_LLVM_annotation 0x6000
 #endif
 
+#ifndef DW_TAG_GNU_annotation
+#define DW_TAG_GNU_annotation 0x6001
+#endif
+
+#ifndef DW_AT_GNU_annotation
+#define DW_AT_GNU_annotation 0x2139
+#endif
+
+#define tag__is_annotation(tag) \
+	((tag) == DW_TAG_LLVM_annotation || (tag) == DW_TAG_GNU_annotation)
+
 static inline __attribute__((const)) bool is_power_of_2(unsigned long n)
 {
         return (n != 0 && ((n & (n - 1)) == 0));
diff --git a/dwarf_loader.c b/dwarf_loader.c
index 42a0f3f74ce3..8ce34cbb8ed6 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -908,7 +908,12 @@ static int tag__recode_dwarf_bitfield(struct tag *tag, struct cu *cu, uint16_t b
 	return -ENOMEM;
 }
 
-static int add_llvm_annotation(Dwarf_Die *die, int component_idx, struct conf_load *conf,
+static bool die__tag_is_annotation(Dwarf_Die *die)
+{
+	return tag__is_annotation(dwarf_tag(die));
+}
+
+static int add_tag_annotation(Dwarf_Die *die, int component_idx, struct conf_load *conf,
 			       struct list_head *head)
 {
 	struct llvm_annotation *annot;
@@ -943,16 +948,48 @@ static int add_child_llvm_annotations(Dwarf_Die *die, int component_idx,
 
 	die = &child;
 	do {
-		if (dwarf_tag(die) == DW_TAG_LLVM_annotation) {
-			ret = add_llvm_annotation(die, component_idx, conf, head);
-			if (ret)
-				return ret;
-		}
+		if (!die__tag_is_annotation(die))
+			continue;
+
+		ret = add_tag_annotation(die, component_idx, conf, head);
+		if (ret)
+			return ret;
 	} while (dwarf_siblingof(die, die) == 0);
 
 	return 0;
 }
 
+/*
+ * Handle gcc style btf_decl_tag annotations attached directly to a DIE via
+ * the DW_AT_GNU_annotation attribute chain: functions, function parameters
+ * and struct/union members.
+ *
+ * Note: gcc does not yet emit decl tags for a whole struct/union or for a
+ * typedef, so calling this on such a DIE is harmless - the attribute is
+ * simply absent and the chain is empty.
+ *
+ * Pointers (btf_type_tag) are handled separately, inline in
+ * die__create_new_pointer_tag().
+ */
+static int add_gnu_annotation_chain(Dwarf_Die *die, int component_idx,
+				    struct conf_load *conf, struct list_head *head)
+{
+	Dwarf_Attribute attr;
+	Dwarf_Die annot_die;
+
+	while (dwarf_attr(die, DW_AT_GNU_annotation, &attr) != NULL &&
+	       dwarf_formref_die(&attr, &annot_die) != NULL &&
+	       dwarf_tag(&annot_die) == DW_TAG_GNU_annotation) {
+		int ret = add_tag_annotation(&annot_die, component_idx, conf, head);
+		if (ret)
+			return ret;
+
+		die = &annot_die;
+	}
+
+	return 0;
+}
+
 int class_member__dwarf_recode_bitfield(struct class_member *member,
 					struct cu *cu)
 {
@@ -1596,13 +1633,16 @@ static struct btf_type_tag_type *die__create_new_btf_type_tag_type(Dwarf_Die *di
 		return NULL;
 
 	tag__init(&tag->tag, cu, die);
+	/* Normalize DW_TAG_GNU_annotation to DW_TAG_LLVM_annotation internally */
+	tag->tag.tag = DW_TAG_LLVM_annotation;
 	tag->value = attr_string(die, DW_AT_const_value, conf);
 	return tag;
 }
 
 static struct btf_type_tag_ptr_type *die__add_btf_type_tag(struct btf_type_tag_ptr_type *tag,
 							    Dwarf_Die *die, Dwarf_Die *adie,
-							    struct cu *cu, struct conf_load *conf)
+							    struct cu *cu, struct conf_load *conf,
+							    bool prepend)
 {
 	struct btf_type_tag_type *annot;
 	uint32_t id;
@@ -1625,10 +1665,23 @@ static struct btf_type_tag_ptr_type *die__add_btf_type_tag(struct btf_type_tag_p
 	cu__hash(cu, &annot->tag);
 
 	/*
-	 * Prepends: for annotations tag1 -> tag2 -> tag3,
-	 * the tag->tags list ends up as tag3 -> tag2 -> tag1.
+	 * Consider:
+	 *   struct sample __tag(outer) __tag(inner) *global_ptr;
+	 * The BTF chain should describe the pointer as:
+	 *   PTR -> TYPE_TAG "inner" -> TYPE_TAG "outer" -> STRUCT "sample"
+	 * i.e. the tag nearest the '*' wraps the pointee first.
+	 *
+	 * LLVM emits the child annotation DIEs in source order (outer, inner),
+	 * so we prepend to end up with inner -> outer.
+	 *
+	 * GCC's DW_AT_GNU_annotation chain is already walked from the outermost
+	 * BTF wrapper (inner) towards the pointee, so we preserve that order by
+	 * appending.
 	 */
-	list_add(&annot->node, &tag->tags);
+	if (prepend)
+		list_add(&annot->node, &tag->tags);
+	else
+		list_add_tail(&annot->node, &tag->tags);
 	return tag;
 }
 
@@ -1637,19 +1690,21 @@ static struct tag *die__create_new_pointer_tag(Dwarf_Die *die, struct cu *cu,
 {
 	struct btf_type_tag_ptr_type *tag = NULL;
 	Dwarf_Die *cdie, child;
+	Dwarf_Attribute attr;
+	Dwarf_Die annot_die;
 	const char *name;
 
-	/* If no child tags or skipping btf_type_tag encoding, just create a new tag
-	 * and return
-	 */
-	if (!dwarf_haschildren(die) || dwarf_child(die, &child) != 0 ||
-	    conf->skip_encoding_btf_type_tag)
+	/* If skipping btf_type_tag encoding, just create a new tag, return */
+	if (conf->skip_encoding_btf_type_tag)
 		return tag__new(die, cu);
 
-	/* Otherwise, check DW_TAG_LLVM_annotation child tags */
+	if (!dwarf_haschildren(die) || dwarf_child(die, &child) != 0)
+		goto check_gnu_attr;
+
+	/* Handle LLVM style annotation tags if present */
 	cdie = &child;
 	do {
-		if (dwarf_tag(cdie) != DW_TAG_LLVM_annotation)
+		if (!die__tag_is_annotation(cdie))
 			continue;
 
 		/* Only check btf_type_tag annotations */
@@ -1657,11 +1712,33 @@ static struct tag *die__create_new_pointer_tag(Dwarf_Die *die, struct cu *cu,
 		if (strcmp(name, "btf_type_tag") != 0)
 			continue;
 
-		tag = die__add_btf_type_tag(tag, die, cdie, cu, conf);
+		/* LLVM child DIEs are in source order; prepend to reverse. */
+		tag = die__add_btf_type_tag(tag, die, cdie, cu, conf, true);
 		if (tag == NULL)
 			return NULL;
 	} while (dwarf_siblingof(cdie, cdie) == 0);
 
+check_gnu_attr:
+	if (tag != NULL)
+		goto out;
+
+	/* Handle GCC-style DW_AT_GNU_annotation attribute */
+	while (dwarf_attr(die, DW_AT_GNU_annotation, &attr) != NULL &&
+	       dwarf_formref_die(&attr, &annot_die) != NULL &&
+	       dwarf_tag(&annot_die) == DW_TAG_GNU_annotation) {
+		name = attr_string(&annot_die, DW_AT_name, conf);
+		if (strcmp(name, "btf_type_tag") != 0)
+			break;
+
+		/* GCC chain is already in BTF order; append to preserve it. */
+		tag = die__add_btf_type_tag(tag, die, &annot_die, cu, conf, false);
+		if (tag == NULL)
+			return NULL;
+
+		die = &annot_die;
+	}
+
+out:
 	return tag ? &tag->tag : tag__new(die, cu);
 }
 
@@ -1690,6 +1767,12 @@ static struct tag *die__create_new_class(Dwarf_Die *die, struct cu *cu, struct c
 		}
 	}
 
+	if (class != NULL &&
+	    add_gnu_annotation_chain(die, -1, conf, &class->type.namespace.annots) != 0) {
+		class__delete(class, cu);
+		class = NULL;
+	}
+
 	return class ? &class->type.namespace.tag : NULL;
 }
 
@@ -1822,6 +1905,8 @@ static struct tag *die__create_new_parameter(Dwarf_Die *die,
 		if (param_idx >= 0) {
 			if (add_child_llvm_annotations(die, param_idx, conf, &(tag__function(&ftype->tag)->annots)))
 				return NULL;
+			if (add_gnu_annotation_chain(die, param_idx, conf, &(tag__function(&ftype->tag)->annots)))
+				return NULL;
 		}
 	} else {
 		/*
@@ -2051,11 +2136,14 @@ static int die__process_class(Dwarf_Die *die, struct type *class,
 			cu__hash(cu, &member->tag);
 			if (add_child_llvm_annotations(die, member_idx, conf, &class->namespace.annots))
 				return -ENOMEM;
+			if (add_gnu_annotation_chain(die, member_idx, conf, &class->namespace.annots))
+				return -ENOMEM;
 			member_idx++;
 		}
 			continue;
 		case DW_TAG_LLVM_annotation:
-			if (add_llvm_annotation(die, -1, conf, &class->namespace.annots))
+		case DW_TAG_GNU_annotation:
+			if (add_tag_annotation(die, -1, conf, &class->namespace.annots))
 				return -ENOMEM;
 			continue;
 		default: {
@@ -2360,7 +2448,8 @@ static int die__process_function(Dwarf_Die *die, struct ftype *ftype,
 				goto out_enomem;
 			continue;
 		case DW_TAG_LLVM_annotation:
-			if (add_llvm_annotation(die, -1, conf, &(tag__function(&ftype->tag)->annots)))
+		case DW_TAG_GNU_annotation:
+			if (add_tag_annotation(die, -1, conf, &(tag__function(&ftype->tag)->annots)))
 				goto out_enomem;
 			continue;
 		default:
@@ -2408,6 +2497,12 @@ static struct tag *die__create_new_function(Dwarf_Die *die, struct cu *cu, struc
 		function = NULL;
 	}
 
+	if (function != NULL &&
+	    add_gnu_annotation_chain(die, -1, conf, &function->annots) != 0) {
+		function__delete(function, cu);
+		function = NULL;
+	}
+
 	return function ? &function->proto.tag : NULL;
 }
 
@@ -2469,6 +2564,9 @@ static struct tag *__die__process_tag(Dwarf_Die *die, struct cu *cu,
 		 */
 		tag = &unsupported_tag;
 		break;
+	case DW_TAG_GNU_annotation:
+		tag = &unsupported_tag;
+		break;
 	case DW_TAG_label:
 		if (conf->ignore_labels)
 			tag = &unsupported_tag; // callers will assume conf->ignore_labels is true
@@ -2494,7 +2592,8 @@ static int die__process_unit(Dwarf_Die *die, struct cu *cu, struct conf_load *co
 			// XXX special case DW_TAG_dwarf_procedure, appears when looking at a recent ~/bin/perf
 			// Investigate later how to properly support this...
 			if (dwarf_tag(die) != DW_TAG_dwarf_procedure &&
-			    dwarf_tag(die) != DW_TAG_label) // conf->ignore_labels == true, see die__process_tag()
+			    dwarf_tag(die) != DW_TAG_label && // conf->ignore_labels == true, see die__process_tag()
+			    dwarf_tag(die) != DW_TAG_GNU_annotation)
 				tag__print_not_supported(die);
 			continue;
 		}
diff --git a/dwarves.h b/dwarves.h
index 5ec16e750e83..75c311a2f8ee 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -670,7 +670,7 @@ static inline int tag__is_tag_type(const struct tag *tag)
 	       tag->tag == DW_TAG_volatile_type ||
 	       tag->tag == DW_TAG_atomic_type ||
 	       tag->tag == DW_TAG_unspecified_type ||
-	       tag->tag == DW_TAG_LLVM_annotation;
+	       tag__is_annotation(tag->tag);
 }
 
 static inline const char *tag__decl_file(const struct tag *tag,
diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
index 54f483244bd2..ab1c381db646 100644
--- a/dwarves_fprintf.c
+++ b/dwarves_fprintf.c
@@ -140,6 +140,8 @@ const char *dwarf_tag_name(const uint32_t tag)
 		return dwarf_gnu_tag_names[tag - DW_TAG_MIPS_loop];
 	else if (tag == DW_TAG_LLVM_annotation)
 		return "LLVM_annotation";
+	else if (tag == DW_TAG_GNU_annotation)
+		return "GNU_annotation";
 	return "INVALID";
 }
 
@@ -658,6 +660,7 @@ static const char *__tag__name(const struct tag *tag, const struct cu *cu,
 		snprintf(bf, len, "%s", variable__name(tag__variable(tag)));
 		break;
 	case DW_TAG_LLVM_annotation:
+	case DW_TAG_GNU_annotation:
 		type = cu__type(cu, tag->type);
 		if (type == NULL && tag->type != 0)
 			tag__id_not_found_snprintf(bf, len, tag->type);
@@ -723,7 +726,7 @@ static size_t type__fprintf_stats(struct type *type, const struct cu *cu,
 	return printed;
 }
 
-static type_id_t skip_llvm_annotations(const struct cu *cu, type_id_t id)
+static type_id_t skip_tag_annotations(const struct cu *cu, type_id_t id)
 {
 	struct tag *type;
 
@@ -731,7 +734,7 @@ static type_id_t skip_llvm_annotations(const struct cu *cu, type_id_t id)
 		if (id == 0)
 			break;
 		type = cu__type(cu, id);
-		if (type == NULL || type->tag != DW_TAG_LLVM_annotation || type->type == id)
+		if (type == NULL || !tag__is_annotation(type->tag) || type->type == id)
 			break;
 		id = type->type;
 	}
@@ -838,7 +841,7 @@ inner_struct:
 next_type:
 	switch (type->tag) {
 	case DW_TAG_pointer_type: {
-		type_id_t ptype_id = skip_llvm_annotations(cu, type->type);
+		type_id_t ptype_id = skip_tag_annotations(cu, type->type);
 
 		if (ptype_id != 0) {
 			int n;
@@ -936,7 +939,8 @@ print_modifier: {
 		else
 			printed += enumeration__fprintf(type, &tconf, fp);
 		break;
-	case DW_TAG_LLVM_annotation: {
+	case DW_TAG_LLVM_annotation:
+	case DW_TAG_GNU_annotation: {
 		struct tag *ttype = cu__type(cu, type->type);
 		if (ttype) {
 			type = ttype;
-- 
2.54.0

