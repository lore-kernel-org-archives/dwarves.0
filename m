Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6383ED5D0
	for <dwarves@vger.kernel.org>; Mon,  1 Jun 2026 18:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780338927; cv=none; b=a9I+Xm0Wk5dw4uVK2tyd9OHLvK1WWdwUXqJIDtvitB5vrWOimwc8LhgvRyKKX2UCQ5boP3eAhPi7vlQA/DUmw4DBGerWydmk5qXQB5yBPK1jTAPxdrC8BNoZkmxnMSCPmHkK+B0UuVYAGm7SsDxVq6HwI4FL/A17x5AT3XSWyNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780338927; c=relaxed/simple;
	bh=56tdB5Cjnw4+uaX/wfGJ7DcCWJXHV7HiJlE9rfiYOH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=poyVFuRCHkQGfXhy23zWL1F7MIh+41dyjrfTIncAD0DHvKd9A+dLKizwPC31A1xaosIsCsf1E9Bpd34vPpZlgXJ4wmrR6lKAil27Bux9jD/FdwkaiIE/XD5UibITtYfqyt6hYydY4ieV6NkdaHnYlkWh8GvFb2cpRQn2adW6G6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WJ1O/hFq; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WJ1O/hFq"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780338922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vm6kHYJ8on4TsZj23bzeIxKbN8OjKbeAVyOofUJj8Kc=;
	b=WJ1O/hFqakQ3UW6NIP8HxKJZUsVlMN9EdgrxoqGcJMp6AI69TVQLa+FeD2gXKFjxSERL5Y
	8K5tLTSMK7ko9D6qhjJTXPA1Dls0tHxDGG1ZW3i8naYHVoUXsBDU1d1OrR6TZty3yRr85r
	yoH3wzSj2iUt4gxhiG7RjijTME1dxb8=
From: Vineet Gupta <vineet.gupta@linux.dev>
To: dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	acme@kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	jose.marchesi@oracle.com,
	David Faust <david.faust@oracle.com>,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PAHOLE v3 2/3] dwarf_loader: Add support for DW_TAG_GNU_annotation
Date: Mon,  1 Jun 2026 11:35:10 -0700
Message-ID: <20260601183511.594100-2-vineet.gupta@linux.dev>
In-Reply-To: <20260601183511.594100-1-vineet.gupta@linux.dev>
References: <20260601183511.594100-1-vineet.gupta@linux.dev>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

gcc 16 was first release to support DW_TAG_GNU_annotation and this patch
enables the same in pahole. Bulk of changes are in dwarf_loader but
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
  GCC-style btf_type_tag resolution, with cycle detection.
- Normalize DW_TAG_GNU_annotation to DW_TAG_LLVM_annotation in the
  internal representation so downstream code works unchanged.

For btf_decl_tag (function/struct/member annotations):
- Add add_gnu_annotation_chain() to follow DW_AT_GNU_annotation
  attribute chains on function, struct, and member DIEs.
- GCC puts DW_AT_GNU_annotation on the function/struct DIE itself
  (not as child DIEs), referencing sibling annotation DIEs that chain
  via the same attribute.

Also:
- Silently skip standalone DW_TAG_GNU_annotation DIEs at CU level.
- Update pfunct-btf-decl-tags.sh test to use GCC 16+ when available and
  now passes.

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
Changes since v2 [2]
 - Removed loop detection logic
 - Move test changes to different patch

Changes since v1 [1]
 - NFC Reduce indentation with early exits (Alexei offlist)

[2] https://lore.kernel.org/bpf/20260528223616.2035618-2-vineet.gupta@linux.dev/
[1] https://lore.kernel.org/bpf/20260526181818.4159927-2-vineet.gupta@linux.dev/
---

 btf_encoder.c     |   1 +
 dutil.h           |   8 ++++
 dwarf_loader.c    | 102 ++++++++++++++++++++++++++++++++++++++++++----
 dwarves.h         |   3 +-
 dwarves_fprintf.c |   8 +++-
 5 files changed, 110 insertions(+), 12 deletions(-)

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
index ff78aa6dfd10..abe0e62b412f 100644
--- a/dutil.h
+++ b/dutil.h
@@ -35,6 +35,14 @@
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
 static inline __attribute__((const)) bool is_power_of_2(unsigned long n)
 {
         return (n != 0 && ((n & (n - 1)) == 0));
diff --git a/dwarf_loader.c b/dwarf_loader.c
index 8b5b526299b5..878565884f85 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -908,6 +908,12 @@ static int tag__recode_dwarf_bitfield(struct tag *tag, struct cu *cu, uint16_t b
 	return -ENOMEM;
 }
 
+static bool die__tag_is_annotation(Dwarf_Die *die)
+{
+	unsigned int tag = dwarf_tag(die);
+	return tag == DW_TAG_LLVM_annotation || tag == DW_TAG_GNU_annotation;
+}
+
 static int add_llvm_annotation(Dwarf_Die *die, int component_idx, struct conf_load *conf,
 			       struct list_head *head)
 {
@@ -943,7 +949,7 @@ static int add_child_llvm_annotations(Dwarf_Die *die, int component_idx,
 
 	die = &child;
 	do {
-		if (dwarf_tag(die) == DW_TAG_LLVM_annotation) {
+		if (die__tag_is_annotation(die)) {
 			ret = add_llvm_annotation(die, component_idx, conf, head);
 			if (ret)
 				return ret;
@@ -953,6 +959,35 @@ static int add_child_llvm_annotations(Dwarf_Die *die, int component_idx,
 	return 0;
 }
 
+/* Handle gcc sytle btf_decl_tag annotations for functions/struct/member tags
+ * Pointers are handled seperately, inline in die__create_new_pointer_tag ()
+ */
+static int add_gnu_annotation_chain(Dwarf_Die *die, int component_idx,
+				    struct conf_load *conf, struct list_head *head)
+{
+	Dwarf_Attribute attr;
+	Dwarf_Die annot_die;
+
+	if (dwarf_attr(die, DW_AT_GNU_annotation, &attr) == NULL ||
+	    dwarf_formref_die(&attr, &annot_die) == NULL)
+		return 0;
+
+	for (;;) {
+		if (dwarf_tag(&annot_die) != DW_TAG_GNU_annotation)
+			break;
+
+		int ret = add_llvm_annotation(&annot_die, component_idx, conf, head);
+		if (ret)
+			return ret;
+
+		if (dwarf_attr(&annot_die, DW_AT_GNU_annotation, &attr) == NULL ||
+		    dwarf_formref_die(&attr, &annot_die) == NULL)
+			break;
+	}
+
+	return 0;
+}
+
 int class_member__dwarf_recode_bitfield(struct class_member *member,
 					struct cu *cu)
 {
@@ -1596,6 +1631,8 @@ static struct btf_type_tag_type *die__create_new_btf_type_tag_type(Dwarf_Die *di
 		return NULL;
 
 	tag__init(&tag->tag, cu, die);
+	/* Normalize DW_TAG_GNU_annotation to DW_TAG_LLVM_annotation internally */
+	tag->tag.tag = DW_TAG_LLVM_annotation;
 	tag->value = attr_string(die, DW_AT_const_value, conf);
 	return tag;
 }
@@ -1636,19 +1673,21 @@ static struct tag *die__create_new_pointer_tag(Dwarf_Die *die, struct cu *cu,
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
+	/* Handle LLVM style annotation tags if present */
+	if (!dwarf_haschildren(die) || dwarf_child(die, &child) != 0)
+		goto check_gnu_attr;
+
 	cdie = &child;
 	do {
-		if (dwarf_tag(cdie) != DW_TAG_LLVM_annotation)
+		if (!die__tag_is_annotation(cdie))
 			continue;
 
 		/* Only check btf_type_tag annotations */
@@ -1661,6 +1700,31 @@ static struct tag *die__create_new_pointer_tag(Dwarf_Die *die, struct cu *cu,
 			return NULL;
 	} while (dwarf_siblingof(cdie, cdie) == 0);
 
+check_gnu_attr:
+	/* Check for GCC-style DW_AT_GNU_annotation attribute */
+	if (tag != NULL ||
+	    dwarf_attr(die, DW_AT_GNU_annotation, &attr) == NULL ||
+	    dwarf_formref_die(&attr, &annot_die) == NULL)
+		goto out;
+
+	for (;;) {
+		if (dwarf_tag(&annot_die) != DW_TAG_GNU_annotation)
+			break;
+
+		name = attr_string(&annot_die, DW_AT_name, conf);
+		if (strcmp(name, "btf_type_tag") != 0)
+			break;
+
+		tag = die__add_btf_type_tag(tag, die, &annot_die, cu, conf);
+		if (tag == NULL)
+			return NULL;
+
+		if (dwarf_attr(&annot_die, DW_AT_GNU_annotation, &attr) == NULL ||
+		    dwarf_formref_die(&attr, &annot_die) == NULL)
+			break;
+	}
+
+out:
 	return tag ? &tag->tag : tag__new(die, cu);
 }
 
@@ -1689,6 +1753,12 @@ static struct tag *die__create_new_class(Dwarf_Die *die, struct cu *cu, struct c
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
 
@@ -2050,10 +2120,13 @@ static int die__process_class(Dwarf_Die *die, struct type *class,
 			cu__hash(cu, &member->tag);
 			if (add_child_llvm_annotations(die, member_idx, conf, &class->namespace.annots))
 				return -ENOMEM;
+			if (add_gnu_annotation_chain(die, member_idx, conf, &class->namespace.annots))
+				return -ENOMEM;
 			member_idx++;
 		}
 			continue;
 		case DW_TAG_LLVM_annotation:
+		case DW_TAG_GNU_annotation:
 			if (add_llvm_annotation(die, -1, conf, &class->namespace.annots))
 				return -ENOMEM;
 			continue;
@@ -2359,6 +2432,7 @@ static int die__process_function(Dwarf_Die *die, struct ftype *ftype,
 				goto out_enomem;
 			continue;
 		case DW_TAG_LLVM_annotation:
+		case DW_TAG_GNU_annotation:
 			if (add_llvm_annotation(die, -1, conf, &(tag__function(&ftype->tag)->annots)))
 				goto out_enomem;
 			continue;
@@ -2407,6 +2481,12 @@ static struct tag *die__create_new_function(Dwarf_Die *die, struct cu *cu, struc
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
 
@@ -2468,6 +2548,9 @@ static struct tag *__die__process_tag(Dwarf_Die *die, struct cu *cu,
 		 */
 		tag = &unsupported_tag;
 		break;
+	case DW_TAG_GNU_annotation:
+		tag = &unsupported_tag;
+		break;
 	case DW_TAG_label:
 		if (conf->ignore_labels)
 			tag = &unsupported_tag; // callers will assume conf->ignore_labels is true
@@ -2493,7 +2576,8 @@ static int die__process_unit(Dwarf_Die *die, struct cu *cu, struct conf_load *co
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
index 5ec16e750e83..42b8e39aa2dd 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -670,7 +670,8 @@ static inline int tag__is_tag_type(const struct tag *tag)
 	       tag->tag == DW_TAG_volatile_type ||
 	       tag->tag == DW_TAG_atomic_type ||
 	       tag->tag == DW_TAG_unspecified_type ||
-	       tag->tag == DW_TAG_LLVM_annotation;
+	       tag->tag == DW_TAG_LLVM_annotation ||
+	       tag->tag == DW_TAG_GNU_annotation;
 }
 
 static inline const char *tag__decl_file(const struct tag *tag,
diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
index 1ec478c2a027..a514d7e98923 100644
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
@@ -731,7 +734,7 @@ static type_id_t skip_llvm_annotations(const struct cu *cu, type_id_t id)
 		if (id == 0)
 			break;
 		type = cu__type(cu, id);
-		if (type == NULL || type->tag != DW_TAG_LLVM_annotation || type->type == id)
+		if (type == NULL || (type->tag != DW_TAG_LLVM_annotation && type->tag != DW_TAG_GNU_annotation) || type->type == id)
 			break;
 		id = type->type;
 	}
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

