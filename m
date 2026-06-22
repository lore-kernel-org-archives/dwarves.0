Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE94F34CFDD
	for <dwarves@vger.kernel.org>; Mon, 22 Jun 2026 20:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782159891; cv=none; b=bfImXX+Zla+1DP66oQMKAYsVvke3GQKvD1orZn0IgdcbOwhFZk9Sz+GvnIq658eZcsFa9CY+DRMRk78mp+rBEX1Hccw86+FbQ8/YRbIzC1HxzjzaoFaq5nG/ammEYpaIMZ1UrVruY2GRVBcIFKSTNwcOOdNB5i6h8+hRZoTdsI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782159891; c=relaxed/simple;
	bh=7Q45Tibbo6Uf1OKpKKPIF9YQcmZ8cmSCHXGXlwOtUgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HdJCsQu5mB4rzHf85L26CiphCBMdO9Q2dxxuXYWicaRQwsRMupDjWH/uHRCsyvkugow+hr1pMP5Vc4C50tQdti18CJyEbFBE/M7NZYArD04XX/bz71dwtvsuDdOxVtciQBbgBS3IYIDVTrI3TuV9OQyNafwwG5DHEe7zp4XyyAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtEpCdPI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtEpCdPI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D22361F00A3A;
	Mon, 22 Jun 2026 20:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782159889;
	bh=wC/fV5aeiO2ApvABGlDN4DSzCLZtHNquD8Mq96C+FLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JtEpCdPIWxjo0tgOKMNMM1nvTn57gp69G4NiGRKqYxNc0lyh5BYjR3BiRYdVU5QRv
	 ItLYVie98YoQtMZ0Qxd05YbBFrmT5LfZ1KeOKpboDwoYW+xyXnDw4cqXQSS/lI3KF8
	 ug0pdGmWmMBE5VB3wgwMBK9rBbilDh/ox3Db7PJAMSfzm2yTiZSxGWmy2LW4PVTHHK
	 qeEtx8TEjRSZKDexkNsLkeEPtV8VsDgNFuvUo0SM9bXGCl5ZRdo0AqF+wHwmlC3Zoo
	 fWBryJv98A21x/bxnmSNQXgo4piPuGstnboXx5r+ufTCctzGRF7FTIIYwsdqqiG1Nk
	 TAmRvzTRov9qQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 01/16] dwarf_loader: Initial support for DW_TAG_variant_part
Date: Mon, 22 Jun 2026 17:24:24 -0300
Message-ID: <20260622202441.14799-2-acme@kernel.org>
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

Still doesn't handle its sub hierarchy, i.e. the DW_TAG_variant entries
and its underlying DW_TAG_member entries.

This was noticed when running the regression test that uses a debug
build of perf to process a perf.data file and test pahole's pretty
printing features, as now perf has a synthetic workload that is written
in rust:

 <0><20c95a>: Abbrev Number: 1 (DW_TAG_compile_unit)
    <20c95b>   DW_AT_producer    : (indirect string, offset: 0x4ee5a): clang LLVM (rustc version 1.93.1 (01f6ddf75 2026-02-11) (Fedora 1.93.1-1.fc43))
    <20c95f>   DW_AT_language    : 28	(Rust)
    <20c961>   DW_AT_name        : (indirect string, offset: 0x4eeaa): tests/workloads/code_with_type.rs/@/code_with_type.d6e680867bfb8b27-cgu.0
    <20c965>   DW_AT_stmt_list   : 0x5e1ed
    <20c969>   DW_AT_comp_dir    : (indirect string, offset: 0x487f1): /home/acme/git/perf-tools/tools/perf
    <20c96d>   DW_AT_low_pc      : 0
    <20c975>   DW_AT_ranges      : 0x2d0
⬢ [acme@toolbx pahole]$

So lets add some scaffolding for the Rust DWARF constructs involved for
us to be able to continue using perf with DWARF to test the pretty
printing features.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarf_loader.c | 26 +++++++++++++++++++++++++-
 dwarves.c      | 27 +++++++++++++++++++++++++++
 dwarves.h      | 16 ++++++++++++++++
 3 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 8ce34cbb8ed60aca..438ebd52893fdb8f 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -508,6 +508,8 @@ static void tag__init(struct tag *tag, struct cu *cu, Dwarf_Die *die)
 
 	if (tag->tag == DW_TAG_imported_module || tag->tag == DW_TAG_imported_declaration)
 		dwarf_tag__set_attr_type(dtag, type, die, DW_AT_import);
+	else if (tag->tag == DW_TAG_variant_part)
+		dwarf_tag__set_attr_type(dtag, type, die, DW_AT_discr);
 	else
 		dwarf_tag__set_attr_type(dtag, type, die, DW_AT_type);
 
@@ -1207,6 +1209,18 @@ static struct template_parameter_pack *template_parameter_pack__new(Dwarf_Die *d
 	return pack;
 }
 
+static struct variant_part *variant_part__new(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
+{
+	struct variant_part *vpart = tag__alloc(cu, sizeof(*vpart));
+
+	if (vpart != NULL) {
+		tag__init(&vpart->tag, cu, die);
+		INIT_LIST_HEAD(&vpart->variants);
+	}
+
+	return vpart;
+}
+
 /* Returns number of locations found or negative value for errors. */
 static ptrdiff_t __dwarf_getlocations(Dwarf_Attribute *attr,
 				      ptrdiff_t offset, Dwarf_Addr *basep,
@@ -2085,9 +2099,19 @@ static int die__process_class(Dwarf_Die *die, struct type *class,
 		case DW_TAG_GNU_template_template_param:
 #endif
 		case DW_TAG_subrange_type: // XXX: ADA stuff, its a type tho, will have other entries referencing it...
-		case DW_TAG_variant_part: // XXX: Rust stuff
 			tag__print_not_supported(die);
 			continue;
+		case DW_TAG_variant_part: {
+			struct variant_part *vpart = variant_part__new(die, cu, conf);
+
+			if (vpart == NULL)
+				return -ENOMEM;
+
+			// For rust it seems we have just one, but DWARF, according to Gemini, support having
+			// more than one DW_TAG_variant_part for a given DW_TAG_structure_type, so future proof it
+			type__add_variant_part(class, vpart);
+			continue;
+		}
 		case DW_TAG_template_type_parameter: {
 			struct template_type_param *ttparm = template_type_param__new(die, cu, conf);
 
diff --git a/dwarves.c b/dwarves.c
index ef93239d26827711..07acf00aaea42607 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -428,6 +428,7 @@ void __type__init(struct type *type)
 	INIT_LIST_HEAD(&type->type_enum);
 	INIT_LIST_HEAD(&type->template_type_params);
 	INIT_LIST_HEAD(&type->template_value_params);
+	INIT_LIST_HEAD(&type->variant_parts);
 	type->template_parameter_pack = NULL;
 	type->sizeof_member = NULL;
 	type->member_prefix = NULL;
@@ -1288,12 +1289,31 @@ static void type__delete_class_members(struct type *type, struct cu *cu)
 	}
 }
 
+static void variant_part__delete(struct variant_part *vpart, struct cu *cu)
+{
+	if (vpart == NULL)
+		return;
+
+	cu__tag_free(cu, &vpart->tag);
+}
+
+static void type__delete_variant_parts(struct type *type, struct cu *cu)
+{
+	struct variant_part *pos, *next;
+
+	type__for_each_variant_part_safe_reverse(type, pos, next) {
+		list_del_init(&pos->tag.node);
+		variant_part__delete(pos, cu);
+	}
+}
+
 void class__delete(struct class *class, struct cu *cu)
 {
 	if (class == NULL)
 		return;
 
 	type__delete_class_members(&class->type, cu);
+	type__delete_variant_parts(&class->type, cu);
 	cu__tag_free(cu, class__tag(class));
 }
 
@@ -1303,6 +1323,7 @@ void type__delete(struct type *type, struct cu *cu)
 		return;
 
 	type__delete_class_members(type, cu);
+	type__delete_variant_parts(type, cu);
 
 	if (type->suffix_disambiguation)
 		zfree(&type->namespace.name);
@@ -1366,6 +1387,11 @@ void type__add_template_value_param(struct type *type, struct template_value_par
 	list_add_tail(&tvparam->tag.node, &type->template_value_params);
 }
 
+void type__add_variant_part(struct type *type, struct variant_part *vpart)
+{
+	list_add_tail(&vpart->tag.node, &type->variant_parts);
+}
+
 struct class_member *type__last_member(struct type *type)
 {
 	struct class_member *pos;
@@ -1382,6 +1408,7 @@ static int type__clone_members(struct type *type, const struct type *from, struc
 
 	type->nr_members = type->nr_static_members = 0;
 	INIT_LIST_HEAD(&type->namespace.tags);
+	INIT_LIST_HEAD(&type->variant_parts);
 
 	type__for_each_member(from, pos) {
 		struct class_member *clone = class_member__clone(pos, cu);
diff --git a/dwarves.h b/dwarves.h
index 75c311a2f8ee4027..7fbda6cd11020572 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -1015,6 +1015,11 @@ static inline struct formal_parameter_pack *tag__formal_parameter_pack(const str
 
 void formal_parameter_pack__add(struct formal_parameter_pack *pack, struct parameter *param);
 
+struct variant_part {
+	struct tag	 tag;
+	struct list_head variants;
+};
+
 /*
  * tag.tag can be DW_TAG_subprogram_type or DW_TAG_subroutine_type.
  */
@@ -1285,6 +1290,7 @@ struct type {
 	uint8_t		 is_signed_enum:1;
 	struct list_head template_type_params;
 	struct list_head template_value_params;
+	struct list_head variant_parts;
 	struct template_parameter_pack *template_parameter_pack;
 };
 
@@ -1402,9 +1408,19 @@ static inline struct class_member *class_member__next(struct class_member *membe
 #define type__for_each_tag_safe_reverse(type, pos, n) \
 	list_for_each_entry_safe_reverse(pos, n, &(type)->namespace.tags, tag.node)
 
+/**
+ * type__for_each_variant_part_safe_reverse - safely iterate thru all variant_parts in a type, in reverse order
+ * @type: struct type instance to iterate
+ * @pos: struct variant_part iterator
+ * @n: struct variant_part temp iterator
+ */
+#define type__for_each_variant_part_safe_reverse(type, pos, n) \
+	list_for_each_entry_safe_reverse(pos, n, &(type)->variant_parts, tag.node)
+
 void type__add_member(struct type *type, struct class_member *member);
 void type__add_template_type_param(struct type *type, struct template_type_param *ttparm);
 void type__add_template_value_param(struct type *type, struct template_value_param *tvparam);
+void type__add_variant_part(struct type *type, struct variant_part *vpart);
 
 struct class_member *
 	type__find_first_biggest_size_base_type_member(struct type *type,
-- 
2.54.0

