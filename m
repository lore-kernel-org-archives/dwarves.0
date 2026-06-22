Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F184D34D382
	for <dwarves@vger.kernel.org>; Mon, 22 Jun 2026 20:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782159910; cv=none; b=sRQmFeNQ46xedg/u8KitF7GF4+2Ji187aE44j0VqwXTFSMyaYFdv/tzVX/l5FLn9ByObgAPlKtbIF0Yq1TJd9c1KgmXBZKFONmYK5Uf/g1yEn3t85D2SFtMuMKIaM7vnhVwmoGis98gPYXa8tPxlsjU8fa4XSbDnX+7ihZdph88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782159910; c=relaxed/simple;
	bh=qHRZkkqXVPjhN6XOKnH3/hyvkcKviZFbXldwdBuqiHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SUJNWVLI8ZV64PXlpcPZ5updoYE1j6y1W4+Fj59rdz1hekaEHcTXVps9ZrhsVL3M2cb5OK7pSzJe056+SAtYGRi5aDix3OukPmI780IsI8NvNmqmttCbJ+k/Q+g2dSdoEanOoDqyQ9X/2oXkWN0kWAw3JqzjzfnQF1BNGnVnHMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TF2jV3uF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TF2jV3uF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0001F00A3A;
	Mon, 22 Jun 2026 20:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782159908;
	bh=oDKeh1z2NQlKHAPgsm6EZGfAFN4Qd6o2L9VTmQ+zn40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TF2jV3uFmJoKoDeEjG2IYCNpxaMslC9GdeEECtvdk1uy0GbRuDMPlSpYigIZKRIkc
	 I5PZbB/0t1PMWEhoFgWBUMnRWxxpHfiDChQrph8xMbpVWqfPVgZM8R+mZsNYJuv+l3
	 A5+9oTO9fYQPLsZCgQv+KHM7HCU9IAjrDtLsTTXHk+gFzKyVtEowvNrtbT+0z8mkw6
	 H7iym3EtYXHi05oRi7soPQk31ZvqOvp9xpLmKsepOUDPF+theekZeYfgbWFfbPZcYd
	 DAyEfpSnl5FF09JhzxweqBUPBapxFL6x2BeIcpp4GrDMe/aXLwwWVmynjGb0QS8MVS
	 sXtKzZrCrgLhw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 09/16] dwarf_loader: Populate DW_TAG_variant children in DW_TAG_variant_part
Date: Mon, 22 Jun 2026 17:24:32 -0300
Message-ID: <20260622202441.14799-10-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622202441.14799-1-acme@kernel.org>
References: <20260622202441.14799-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Rust discriminated unions (enums like Option<T> and Result<T,E>) are
represented in DWARF as:

  DW_TAG_structure_type
    DW_TAG_variant_part (DW_AT_discr -> discriminant member)
      DW_TAG_variant (DW_AT_discr_value = 0)
        DW_TAG_member "None" -> struct None
      DW_TAG_variant (DW_AT_discr_value = 1)
        DW_TAG_member "Some" -> struct Some

Commit 7b135647cbf22e0c ("dwarf_loader: Initial support for
DW_TAG_variant_part") added the variant_part container to pahole's
internal representation, but did not process its DW_TAG_variant children.
This meant the variant parts were always empty, and any Rust struct
backed by a variant_part appeared as a zero-member struct in the output.

Add a struct variant with name and discriminant value fields, a
variant__new() loader that extracts the DW_AT_discr_value and the child
DW_TAG_member's name and type reference, and wire it into
variant_part__new() so DW_TAG_variant children are populated at load
time.

Also add type recoding for variant type references in
namespace__recode_dwarf_types, so variant member types are resolved from
DWARF offsets to CU-local type indices, following the same pattern used
for regular struct/union members.

The variant_part__delete destructor is made non-static and extended to
clean up variant children, and helper functions and iterator macros are
added for the new types.

Before, with a Rust binary like sashiko-cli:

  $ pahole -F btf -C 'Option<u32>' code_with_type.o
  struct Option<u32> {

          /* size: 8, cachelines: 1, members: 0 */
          /* padding: 8 */
          /* last cacheline: 8 bytes */
  } __attribute__((__aligned__(16)));

After:

  $ pahole -F dwarf -C 'Option<u32>' code_with_type.o
  struct Option<u32> {
          struct None { ... } __attribute__((__aligned__(4)));
          struct Some {
                  u32 __0 __attribute__((__aligned__(4)));  /*  4  4 */
          } __attribute__((__aligned__(4)));

          /* size: 8, cachelines: 1, members: 0 */
  } __attribute__((__aligned__(4)));

The variant parts are now populated in pahole's internal representation
and available for downstream consumers (BTF/CTF encoders, pretty
printers).

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarf_loader.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++
 dwarves.c      | 42 ++++++++++++++++++++++++++++-
 dwarves.h      | 24 +++++++++++++++++
 3 files changed, 137 insertions(+), 1 deletion(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 956532bbc5a35410..fc88221ae339e7cd 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1209,6 +1209,32 @@ static struct template_parameter_pack *template_parameter_pack__new(Dwarf_Die *d
 	return pack;
 }
 
+static struct variant *variant__new(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
+{
+	struct variant *var = tag__alloc(cu, sizeof(*var));
+
+	if (var != NULL) {
+		tag__init(&var->tag, cu, die);
+		var->discr_value = attr_numeric(die, DW_AT_discr_value);
+		var->name = NULL;
+
+		Dwarf_Die child;
+		if (dwarf_child(die, &child) == 0) {
+			do {
+				if (dwarf_tag(&child) == DW_TAG_member) {
+					struct dwarf_tag *dtag = tag__dwarf(&var->tag);
+
+					var->name = attr_string(&child, DW_AT_name, conf);
+					dwarf_tag__set_attr_type(dtag, type, &child, DW_AT_type);
+					break;
+				}
+			} while (dwarf_siblingof(&child, &child) == 0);
+		}
+	}
+
+	return var;
+}
+
 static struct variant_part *variant_part__new(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
 {
 	struct variant_part *vpart = tag__alloc(cu, sizeof(*vpart));
@@ -1216,6 +1242,20 @@ static struct variant_part *variant_part__new(Dwarf_Die *die, struct cu *cu, str
 	if (vpart != NULL) {
 		tag__init(&vpart->tag, cu, die);
 		INIT_LIST_HEAD(&vpart->variants);
+
+		Dwarf_Die child;
+		if (dwarf_child(die, &child) == 0) {
+			do {
+				if (dwarf_tag(&child) == DW_TAG_variant) {
+					struct variant *var = variant__new(&child, cu, conf);
+					if (var == NULL) {
+						variant_part__delete(vpart, cu);
+						return NULL;
+					}
+					variant_part__add_variant(vpart, var);
+				}
+			} while (dwarf_siblingof(&child, &child) == 0);
+		}
 	}
 
 	return vpart;
@@ -2730,6 +2770,38 @@ check_type:
 next:
 		pos->type = dtype->small_id;
 	}
+
+	if (tag__is_struct(tag) || tag__is_union(tag)) {
+		struct type *type = tag__type(tag);
+		struct variant_part *vpart;
+		struct dwarf_cu *dcu = cu->priv;
+
+		type__for_each_variant_part(type, vpart) {
+			struct variant *variant;
+			struct dwarf_tag *dvpart = tag__dwarf(&vpart->tag);
+
+			if (dvpart->type != 0) {
+				struct dwarf_tag *dtype = dwarf_cu__find_tag_by_ref(dcu, dvpart, type);
+				if (dtype != NULL)
+					vpart->tag.type = dtype->small_id;
+			}
+
+			variant_part__for_each_variant(vpart, variant) {
+				struct dwarf_tag *dvar = tag__dwarf(&variant->tag);
+
+				if (dvar->type == 0)
+					continue;
+
+				struct dwarf_tag *dtype = dwarf_cu__find_type_by_ref(dcu, dvar, type);
+				if (dtype == NULL) {
+					tag__print_type_not_found(&variant->tag);
+					continue;
+				}
+				variant->tag.type = dtype->small_id;
+			}
+		}
+	}
+
 	return 0;
 }
 
diff --git a/dwarves.c b/dwarves.c
index 5fae87fa5fe35a28..04fe4a5ad62fffde 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -1289,11 +1289,18 @@ static void type__delete_class_members(struct type *type, struct cu *cu)
 	}
 }
 
-static void variant_part__delete(struct variant_part *vpart, struct cu *cu)
+void variant_part__delete(struct variant_part *vpart, struct cu *cu)
 {
+	struct variant *pos, *next;
+
 	if (vpart == NULL)
 		return;
 
+	list_for_each_entry_safe(pos, next, &vpart->variants, tag.node) {
+		list_del_init(&pos->tag.node);
+		cu__tag_free(cu, &pos->tag);
+	}
+
 	cu__tag_free(cu, &vpart->tag);
 }
 
@@ -1387,6 +1394,11 @@ void type__add_variant_part(struct type *type, struct variant_part *vpart)
 	list_add_tail(&vpart->tag.node, &type->variant_parts);
 }
 
+void variant_part__add_variant(struct variant_part *vpart, struct variant *var)
+{
+	list_add_tail(&var->tag.node, &vpart->variants);
+}
+
 struct class_member *type__last_member(struct type *type)
 {
 	struct class_member *pos;
@@ -1413,6 +1425,34 @@ static int type__clone_members(struct type *type, const struct type *from, struc
 		type__add_member(type, clone);
 	}
 
+	struct variant_part *vpart;
+
+	type__for_each_variant_part(from, vpart) {
+		struct variant_part *vp_clone = cu__tag_alloc(cu, sizeof(*vp_clone));
+
+		if (vp_clone == NULL)
+			return -1;
+
+		memcpy(vp_clone, vpart, sizeof(*vp_clone));
+		INIT_LIST_HEAD(&vp_clone->variants);
+
+		struct variant *variant;
+
+		variant_part__for_each_variant(vpart, variant) {
+			struct variant *v_clone = cu__tag_alloc(cu, sizeof(*v_clone));
+
+			if (v_clone == NULL) {
+				variant_part__delete(vp_clone, cu);
+				return -1;
+			}
+
+			memcpy(v_clone, variant, sizeof(*v_clone));
+			variant_part__add_variant(vp_clone, v_clone);
+		}
+
+		type__add_variant_part(type, vp_clone);
+	}
+
 	return 0;
 }
 
diff --git a/dwarves.h b/dwarves.h
index 638a469b11535061..f2dac86b05ed6d2e 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -1016,6 +1016,12 @@ static inline struct formal_parameter_pack *tag__formal_parameter_pack(const str
 
 void formal_parameter_pack__add(struct formal_parameter_pack *pack, struct parameter *param);
 
+struct variant {
+	struct tag	 tag;
+	const char	 *name;
+	uint64_t	 discr_value;
+};
+
 struct variant_part {
 	struct tag	 tag;
 	struct list_head variants;
@@ -1418,10 +1424,28 @@ static inline struct class_member *class_member__next(struct class_member *membe
 #define type__for_each_variant_part_safe_reverse(type, pos, n) \
 	list_for_each_entry_safe_reverse(pos, n, &(type)->variant_parts, tag.node)
 
+/**
+ * type__for_each_variant_part - iterate thru all variant_parts in a type
+ * @type: struct type instance to iterate
+ * @pos: struct variant_part iterator
+ */
+#define type__for_each_variant_part(type, pos) \
+	list_for_each_entry(pos, &(type)->variant_parts, tag.node)
+
 void type__add_member(struct type *type, struct class_member *member);
 void type__add_template_type_param(struct type *type, struct template_type_param *ttparm);
 void type__add_template_value_param(struct type *type, struct template_value_param *tvparam);
 void type__add_variant_part(struct type *type, struct variant_part *vpart);
+void variant_part__delete(struct variant_part *vpart, struct cu *cu);
+void variant_part__add_variant(struct variant_part *vpart, struct variant *var);
+
+/**
+ * variant_part__for_each_variant - iterate thru all variants in a variant_part
+ * @vpart: struct variant_part instance to iterate
+ * @pos: struct variant iterator
+ */
+#define variant_part__for_each_variant(vpart, pos) \
+	list_for_each_entry(pos, &(vpart)->variants, tag.node)
 
 struct class_member *
 	type__find_first_biggest_size_base_type_member(struct type *type,
-- 
2.54.0

