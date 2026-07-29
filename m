Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36864C9544;
	Wed, 29 Jul 2026 19:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352127; cv=none; b=EQmBTJYNzQsidKShR+SV3CIOnpM9FX8zZiMabbGag9FWakH1slr1NU/0TLThi7mL6gZ2zeElvaOI3bf5NWDNOOJMDvXAiIQ+r3JUMfDxhM2SU97awRIGWYVKjQ5hwPxx4+P3yNC51/zPJcV7KA0/O0ZQYPrDXqOuFvie3VB4fmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352127; c=relaxed/simple;
	bh=4lkl627Gt7k0GxEinHXfMI74LjJptCGdMKhB7mCYCl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jZzrx1Z2BHMi9qsN3cArhHTSKDWPrRHFrCvUL8FuKPAMlEWlHRgSLsgYiZDxnP2dY3z/QGkevN7eWXVyIHmf9Wb2yQ9bpP37SUvH/DQzRkLtfX+RAcs0Bo2NynY2d2VTwr0+YsukwphZwQOEZJ4xA8cvPrPdT+iEQQsSECqEpQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ooPcD2mp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ooPcD2mp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6D11F000E9;
	Wed, 29 Jul 2026 19:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785352125;
	bh=RtZTemb5b5nrbqjNaqSrhZXzDroTIGju7SZirrk5Z50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ooPcD2mpCtpiXZT+8E6cYZedQedYX7WGaasnmH2sTr1VCvJMIkBGLRSABIQ/zbJKs
	 /UUuer4TRfhHXrohXFrMZJNxRhyJXUlWLlGGi+WgYQmLD778nybgKcYl4BWp6dfzDC
	 KPSPaJ63IHhk9GnlLOcD46cr825PdU3V8BEbfZ703Q3Lsb/qy0QrMgbY6Hf7+lSWxr
	 j0nogGarB7PJlpeBY0HQQTFTYLHcBks+iQoRZblSlWO5k8kYZsZvzVyZBekRq0qjrE
	 V6+cnDh1M65SzwS9wCW0J8Mg3ShvO9eF1H0kpaN/tV8kVG9BVr2t8z6QqsaeHsWcu2
	 P3RBVnchCH8jA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 29/31] btf_encoder: Fix multi-dimensional array encoding
Date: Wed, 29 Jul 2026 16:07:29 -0300
Message-ID: <20260729190733.72876-30-acme@kernel.org>
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

Before this fix, DW_TAG_array_type with more than one dimension was
encoded as a single BTF_KIND_ARRAY using array_type__nelems() which
returns the FLAT total element count.  For int a[3][4] that produced:

  ARRAY(type=int, nelems=12)  ← wrong, flat count

BTF encodes each dimension as a separate chained BTF_KIND_ARRAY:

  inner: ARRAY(type=int,   nelems=4)
  outer: ARRAY(type=inner, nelems=3)

The encoder now loops from innermost to outermost dimension, emitting
one BTF_KIND_ARRAY per dimension, matching the BTF format used by
bpftool and the kernel verifier.

Because one DWARF type now maps to D BTF types (one per dimension),
the simple linear formula  type_id_off + core_id  no longer gives the
correct BTF id for any type that appears after a multi-dimensional
array.  A pre-scan pass (btf_encoder__precompute_btf_ids) runs before
the encoding loop and fills btf_id_map[] with the correct expected BTF
id for every DWARF core_id, accounting for:

  - NULL holes in types_table (type_id_null_adj)
  - Skipped types (DW_TAG_unspecified_type → encode_tag returns 0)
  - Extra BTF slots consumed by multi-dim arrays

btf_encoder__tag_type() consults the map first so that cross-references
from struct members, pointers, and typedefs resolve to the right BTF id
even before the referenced type has been encoded.  The map is
authoritative whenever it covers a given id — a 0-sentinel entry
correctly resolves to BTF void rather than falling through to the
linear formula.

Audited: DW_TAG_unspecified_type is the sole return-0 path in
encode_tag; all callees (add_base_type, add_ref_type, add_struct_type,
add_enum_type, add_func_proto, add_array) return >= 1 or negative.

The drift check is updated to compare the actual returned BTF id against
the pre-computed map entry rather than the old linear formula.

Before: pahole -F btf showed int a[3][4] as int a[4][3] or int a[12]
After:  int a[2][3][4] encodes as three chained BTF_KIND_ARRAY nodes
        and round-trips correctly to int a[2][3][4]

And these all match:

⬢ [acme@toolbx pahole]$ pahole -F btf -C lru_gen_folio vmlinux.btf
struct lru_gen_folio {
	long unsigned int          max_seq;              /*     0     8 */
	long unsigned int          min_seq[2];           /*     8    16 */
	long unsigned int          timestamps[4];        /*    24    32 */
	struct list_head           folios[4][2][5];      /*    56   640 */
	/* --- cacheline 10 boundary (640 bytes) was 56 bytes ago --- */
	long int                   nr_pages[4][2][5];    /*   696   320 */
	/* --- cacheline 15 boundary (960 bytes) was 56 bytes ago --- */
	long unsigned int          avg_refaulted[2][4];  /*  1016    64 */
	/* --- cacheline 16 boundary (1024 bytes) was 56 bytes ago --- */
	long unsigned int          avg_total[2][4];      /*  1080    64 */
	/* --- cacheline 17 boundary (1088 bytes) was 56 bytes ago --- */
	long unsigned int          protected[1][2][4];   /*  1144    64 */
	/* --- cacheline 18 boundary (1152 bytes) was 56 bytes ago --- */
	atomic_long_t              evicted[1][2][4];     /*  1208    64 */
	/* --- cacheline 19 boundary (1216 bytes) was 56 bytes ago --- */
	atomic_long_t              refaulted[1][2][4];   /*  1272    64 */
	/* --- cacheline 20 boundary (1280 bytes) was 56 bytes ago --- */
	bool                       enabled;              /*  1336     1 */
	u8                         gen;                  /*  1337     1 */
	u8                         seg;                  /*  1338     1 */

	/* XXX 5 bytes hole, try to pack */

	/* --- cacheline 21 boundary (1344 bytes) --- */
	struct hlist_nulls_node    list;                 /*  1344    16 */

	/* size: 1360, cachelines: 22, members: 14 */
	/* sum members: 1355, holes: 1, sum holes: 5 */
	/* last cacheline: 16 bytes */
};

⬢ [acme@toolbx pahole]$ pahole -F dwarf -C lru_gen_folio vmlinux
struct lru_gen_folio {
	long unsigned int          max_seq;              /*     0     8 */
	long unsigned int          min_seq[2];           /*     8    16 */
	long unsigned int          timestamps[4];        /*    24    32 */
	struct list_head           folios[4][2][5];      /*    56   640 */
	/* --- cacheline 10 boundary (640 bytes) was 56 bytes ago --- */
	long int                   nr_pages[4][2][5];    /*   696   320 */
	/* --- cacheline 15 boundary (960 bytes) was 56 bytes ago --- */
	long unsigned int          avg_refaulted[2][4];  /*  1016    64 */
	/* --- cacheline 16 boundary (1024 bytes) was 56 bytes ago --- */
	long unsigned int          avg_total[2][4];      /*  1080    64 */
	/* --- cacheline 17 boundary (1088 bytes) was 56 bytes ago --- */
	long unsigned int          protected[1][2][4];   /*  1144    64 */
	/* --- cacheline 18 boundary (1152 bytes) was 56 bytes ago --- */
	atomic_long_t              evicted[1][2][4];     /*  1208    64 */
	/* --- cacheline 19 boundary (1216 bytes) was 56 bytes ago --- */
	atomic_long_t              refaulted[1][2][4];   /*  1272    64 */
	/* --- cacheline 20 boundary (1280 bytes) was 56 bytes ago --- */
	bool                       enabled;              /*  1336     1 */
	u8                         gen;                  /*  1337     1 */
	u8                         seg;                  /*  1338     1 */

	/* XXX 5 bytes hole, try to pack */

	/* --- cacheline 21 boundary (1344 bytes) --- */
	struct hlist_nulls_node    list;                 /*  1344    16 */

	/* size: 1360, cachelines: 22, members: 14 */
	/* sum members: 1355, holes: 1, sum holes: 5 */
	/* last cacheline: 16 bytes */
};

⬢ [acme@toolbx pahole]$

And:

⬢ [acme@toolbx pahole]$ bpftool btf dump file vmlinux.btf format c | grep lru_gen_folio -A20
struct lru_gen_folio {
	long unsigned int max_seq;
	long unsigned int min_seq[2];
	long unsigned int timestamps[4];
	struct list_head folios[4][2][5];
	long int nr_pages[4][2][5];
	long unsigned int avg_refaulted[2][4];
	long unsigned int avg_total[2][4];
	long unsigned int protected[1][2][4];
	atomic_long_t evicted[1][2][4];
	atomic_long_t refaulted[1][2][4];
	bool enabled;
	u8 gen;
	u8 seg;
	struct hlist_nulls_node list;
};

⬢ [acme@toolbx pahole]$ bpftool btf dump file vmlinux.btf format raw | grep lru_gen_folio -A20
[867] STRUCT 'lru_gen_folio' size=1360 vlen=14
	'max_seq' type_id=1 bits_offset=0
	'min_seq' type_id=4 bits_offset=64
	'timestamps' type_id=721 bits_offset=192
	'folios' type_id=870 bits_offset=448
	'nr_pages' type_id=873 bits_offset=5568
	'avg_refaulted' type_id=874 bits_offset=8128
	'avg_total' type_id=874 bits_offset=8640
	'protected' type_id=875 bits_offset=9152
	'evicted' type_id=878 bits_offset=9664
	'refaulted' type_id=878 bits_offset=10176
	'enabled' type_id=71 bits_offset=10688
	'gen' type_id=29 bits_offset=10696
	'seg' type_id=29 bits_offset=10704
	'list' type_id=695 bits_offset=10752
[868] ARRAY '(anon)' type_id=97 index_type_id=21 nr_elems=5
[869] ARRAY '(anon)' type_id=868 index_type_id=21 nr_elems=2
[870] ARRAY '(anon)' type_id=869 index_type_id=21 nr_elems=4
[871] ARRAY '(anon)' type_id=44 index_type_id=21 nr_elems=5
[872] ARRAY '(anon)' type_id=871 index_type_id=21 nr_elems=2
[873] ARRAY '(anon)' type_id=872 index_type_id=21 nr_elems=4

Fixes: 68645f7facc2eb69 ("btf: Add BTF support")
Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 btf_encoder.c | 299 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 260 insertions(+), 39 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index c7ebaec4829d121a..20d8317a909f775f 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -152,6 +152,27 @@ struct btf_encoder {
 			  encode_attributes,
 			  true_signature;
 	uint32_t	  array_index_id;
+	uint32_t	  *type_id_null_adj;
+	/*
+	 * Maps DWARF core_id → actual BTF type id.  Populated by
+	 * btf_encoder__precompute_btf_ids() before encoding begins.
+	 *
+	 * Entry value 0 means "skipped" (e.g. DW_TAG_unspecified_type);
+	 * this is safe as a sentinel because BTF type id 0 is void and
+	 * the first real type id is always >= 1.
+	 *
+	 * tag__nr_btf_ids() is the single source of truth for how many
+	 * BTF ids each DWARF tag consumes; both precompute and encode
+	 * use it so the mapping stays consistent.
+	 */
+	uint32_t	  *btf_id_map;
+	uint32_t	  btf_id_map_sz;
+	/*
+	 * Final extra/skipped counts from btf_encoder__precompute_btf_ids(),
+	 * used to compute the fallback array_index_id when "int" is absent.
+	 */
+	uint32_t	  btf_id_extra;
+	uint32_t	  btf_id_skipped;
 	struct elf_secinfo *secinfo;
 	size_t             seccnt;
 	int                encode_vars;
@@ -742,7 +763,15 @@ static int32_t btf_encoder__tag_type(struct btf_encoder *encoder, uint32_t tag_t
 	if (tag_type == 0)
 		return 0;
 
-	return encoder->type_id_off + tag_type;
+	/* Map is authoritative when it covers this id: entry 0 means
+	 * skipped (DW_TAG_unspecified_type, dwz-pruned) → void. */
+	if (encoder->btf_id_map && tag_type < encoder->btf_id_map_sz)
+		return encoder->btf_id_map[tag_type];
+
+	/* Fallback for map-absent CUs (nr == 0) or out-of-range ids */
+	uint32_t adj = encoder->type_id_null_adj ? encoder->type_id_null_adj[tag_type] : 0;
+
+	return encoder->type_id_off + tag_type - adj;
 }
 
 static int btf__tag_bpf_arena_ptr(struct btf *btf, int ptr_id)
@@ -1812,20 +1841,6 @@ static void dump_invalid_symbol(const char *msg, const char *sym,
 	fprintf(stderr, "PAHOLE: Error: Use '--btf_encode_force' to ignore such symbols and force emit the btf.\n");
 }
 
-static int tag__check_id_drift(struct btf_encoder *encoder, const struct tag *tag,
-			       uint32_t core_id, uint32_t btf_type_id)
-{
-	if (btf_type_id != (core_id + encoder->type_id_off)) {
-		fprintf(stderr,
-			"%s: %s id drift, core_id: %u, btf_type_id: %u, type_id_off: %u\n",
-			__func__, dwarf_tag_name(tag->tag),
-			core_id, btf_type_id, encoder->type_id_off);
-		return -1;
-	}
-
-	return 0;
-}
-
 static int32_t btf_encoder__add_struct_type(struct btf_encoder *encoder, struct tag *tag)
 {
 	struct type *type = tag__type(tag);
@@ -1858,18 +1873,6 @@ static int32_t btf_encoder__add_struct_type(struct btf_encoder *encoder, struct
 	return type_id;
 }
 
-static uint32_t array_type__nelems(struct tag *tag)
-{
-	int i;
-	uint32_t nelem = 1;
-	struct array_type *array = tag__array_type(tag);
-
-	for (i = array->dimensions - 1; i >= 0; --i)
-		nelem *= array->nr_entries[i];
-
-	return nelem;
-}
-
 static int32_t btf_encoder__add_enum_type(struct btf_encoder *encoder, struct tag *tag,
 					  struct conf_load *conf_load)
 {
@@ -1891,7 +1894,28 @@ static int32_t btf_encoder__add_enum_type(struct btf_encoder *encoder, struct ta
 	return type_id;
 }
 
+/*
+ * How many BTF type IDs will encoding this tag consume?
+ *  0 — skipped (DW_TAG_unspecified_type)
+ *  1 — the common case
+ *  D — multi-dimensional arrays (one BTF_KIND_ARRAY per dimension)
+ *
+ * Both btf_encoder__precompute_btf_ids() and btf_encoder__encode_tag()
+ * must agree on this; keeping the logic in one place prevents drift.
+ */
+static int tag__nr_btf_ids(const struct tag *tag)
+{
+	if (tag->tag == DW_TAG_unspecified_type)
+		return 0;
+	if (tag->tag == DW_TAG_array_type) {
+		int dims = tag__array_type(tag)->dimensions;
+		return dims < 1 ? 1 : dims;
+	}
+	return 1;
+}
+
 static int btf_encoder__encode_tag(struct btf_encoder *encoder, struct tag *tag,
+				   const struct cu *cu __maybe_unused,
 				   struct conf_load *conf_load)
 {
 	/* single out type 0 as it represents special type "void" */
@@ -1899,6 +1923,11 @@ static int btf_encoder__encode_tag(struct btf_encoder *encoder, struct tag *tag,
 	struct base_type *bt;
 	const char *name;
 
+	/*
+	 * Any case that returns 0 (skip) must have a matching entry in
+	 * tag__nr_btf_ids(); the precompute map depends on agreement.
+	 * The drift check will catch mismatches at runtime.
+	 */
 	switch (tag->tag) {
 	case DW_TAG_base_type:
 		bt   = tag__base_type(tag);
@@ -1927,10 +1956,35 @@ static int btf_encoder__encode_tag(struct btf_encoder *encoder, struct tag *tag,
 			return btf_encoder__add_ref_type(encoder, BTF_KIND_FWD, 0, name, tag->tag == DW_TAG_union_type);
 		else
 			return btf_encoder__add_struct_type(encoder, tag);
-	case DW_TAG_array_type:
-		/* TODO: Encode one dimension at a time. */
+	case DW_TAG_array_type: {
+		/*
+		 * BTF represents each array dimension as a separate chained
+		 * BTF_KIND_ARRAY node.  Emit from innermost to outermost so
+		 * that each outer node can reference the one just emitted.
+		 * For int a[3][4] (dimensions=2, nr_entries=[3,4]):
+		 *   i=1: ARRAY(type=int,   nelems=4) → id_inner
+		 *   i=0: ARRAY(type=id_inner, nelems=3) → returned id
+		 */
+		struct array_type *at = tag__array_type(tag);
+		int32_t id = ref_type_id;
+		int i;
+
 		encoder->need_index_type = true;
-		return btf_encoder__add_array(encoder, ref_type_id, encoder->array_index_id, array_type__nelems(tag));
+		/*
+		 * Malformed DWARF may produce 0 dimensions; emit one
+		 * BTF_KIND_ARRAY with 0 elements rather than returning the
+		 * bare element type (which would trigger an ID drift error).
+		 */
+		if (at->dimensions == 0) {
+			return btf_encoder__add_array(encoder, id, encoder->array_index_id, 0);
+		}
+		for (i = at->dimensions - 1; i >= 0; --i) {
+			id = btf_encoder__add_array(encoder, id, encoder->array_index_id, at->nr_entries[i]);
+			if (id < 0)
+				return id;
+		}
+		return id;
+	}
 	case DW_TAG_enumeration_type:
 		return btf_encoder__add_enum_type(encoder, tag, conf_load);
 	case DW_TAG_subroutine_type:
@@ -2985,10 +3039,80 @@ static bool ftype__has_uncertain_arg_loc(struct cu *cu, struct ftype *ftype)
 	return false;
 }
 
+/*
+ * Pre-compute the actual BTF type id for every DWARF core_id.
+ *
+ * The linear formula   type_id_off + core_id - null_adj   holds only for a
+ * strict 1-to-1 DWARF→BTF mapping.  Two things break it:
+ *
+ *  • Skipped types (DW_TAG_unspecified_type → encode_tag returns 0): each
+ *    skipped entry shifts all subsequent BTF ids down by 1.
+ *
+ *  • Multi-dimensional arrays: one BTF_KIND_ARRAY is emitted per dimension,
+ *    so a D-dimensional array occupies D consecutive BTF ids.  The "name" of
+ *    the type (the outermost array) lands at base + D - 1, and each inner
+ *    array consumed an extra slot, shifting all later ids up.
+ *
+ * By scanning the types table once before encoding we can fill btf_id_map[]
+ * with the correct expected id for every core_id.  btf_encoder__tag_type()
+ * then reads the map so that any type reference (struct member, pointer base,
+ * typedef chain, …) resolves to the right BTF id even when the referenced
+ * type hasn't been encoded yet.
+ *
+ * Assumes every non-skipped tag appends exactly nr_ids fresh BTF types;
+ * no in-CU dedup occurs (dedup is a separate libbpf btf__dedup() pass).
+ */
+static int btf_encoder__precompute_btf_ids(struct btf_encoder *encoder, struct cu *cu)
+{
+	uint32_t nr = cu->types_table.nr_entries;
+	uint32_t cid, extra = 0, skipped = 0;
+
+	if (!nr)
+		return 0;
+
+	encoder->btf_id_map = calloc(nr, sizeof(*encoder->btf_id_map));
+	if (!encoder->btf_id_map) {
+		fprintf(stderr, "btf_encoder: out of memory for btf_id_map (%u entries)\n", nr);
+		return -ENOMEM;
+	}
+	encoder->btf_id_map_sz = nr;
+
+	/* Mirror cu__for_each_type: valid core_ids are 1 .. nr-1 */
+	for (cid = 1; cid < nr; cid++) {
+		struct tag *t = cu->types_table.entries[cid];
+		uint32_t adj, base;
+		int nr_ids;
+
+		if (!t)
+			continue;
+
+		nr_ids = tag__nr_btf_ids(t);
+		if (nr_ids == 0) {
+			skipped++;
+			continue;
+		}
+
+		adj  = encoder->type_id_null_adj ? encoder->type_id_null_adj[cid] : 0;
+		base = encoder->type_id_off + cid - adj - skipped + extra;
+
+		/*
+		 * Multi-dim arrays consume nr_ids consecutive BTF slots;
+		 * the outermost (the type other entries reference) is the
+		 * last one emitted: base + nr_ids - 1.
+		 */
+		encoder->btf_id_map[cid] = base + (nr_ids - 1);
+		extra += nr_ids - 1;
+	}
+
+	encoder->btf_id_extra   = extra;
+	encoder->btf_id_skipped = skipped;
+	return 0;
+}
+
 int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct conf_load *conf_load)
 {
 	struct llvm_annotation *annot;
-	int btf_type_id, tag_type_id, skipped_types = 0;
+	int btf_type_id, tag_type_id;
 	struct elf_functions *funcs;
 	uint32_t core_id;
 	struct function *fn;
@@ -3005,6 +3129,50 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 
 	encoder->type_id_off = btf__type_cnt(encoder->btf) - 1;
 
+	/*
+	 * NULL holes in types_table occur only with dwz alternate debug
+	 * files: dwarf_cu__prune_unreferenced_alt_pus() NULLs entries for
+	 * imported partial unit types not referenced by this CU.  This
+	 * does not happen in the common kernel BTF case.
+	 *
+	 * Build a prefix-sum so btf_encoder__tag_type() can translate
+	 * types_table indices (small_ids) to dense BTF type IDs.
+	 */
+	encoder->type_id_null_adj = NULL;
+	if (cu->types_table.nr_entries > 0) {
+		uint32_t nr = cu->types_table.nr_entries;
+		uint32_t *adj = calloc(nr + 1, sizeof(*adj));
+
+		if (adj) {
+			uint32_t nulls = 0;
+
+			for (uint32_t i = 1; i < nr; i++) {
+				if (cu->types_table.entries[i] == NULL)
+					nulls++;
+				adj[i] = nulls;
+			}
+			adj[nr] = nulls;
+			if (nulls > 0)
+				encoder->type_id_null_adj = adj;
+			else
+				free(adj);
+		} else {
+			/* Without the adjustment table, NULL holes would cause
+			 * wrong BTF type IDs — fail rather than silently corrupt */
+			for (uint32_t i = 1; i < nr; i++) {
+				if (cu->types_table.entries[i] == NULL) {
+					fprintf(stderr, "btf_encoder: out of memory for type_id_null_adj (%u entries)\n", nr);
+					err = -ENOMEM;
+					goto out;
+				}
+			}
+		}
+	}
+
+	err = btf_encoder__precompute_btf_ids(encoder, cu);
+	if (err)
+		goto out;
+
 	if (!encoder->has_index_type) {
 		/* cu__find_base_type_by_name() takes "type_id_t *id" */
 		type_id_t id;
@@ -3012,24 +3180,58 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 			encoder->has_index_type = true;
 			encoder->array_index_id = btf_encoder__tag_type(encoder, id);
 		} else {
+			uint32_t nr = cu->types_table.nr_entries;
+			uint32_t adj = encoder->type_id_null_adj ? encoder->type_id_null_adj[nr] : 0;
+
 			encoder->has_index_type = false;
-			encoder->array_index_id = encoder->type_id_off + cu->types_table.nr_entries;
+			/*
+			 * Point past all encoded CU types.  Must account for
+			 * NULL holes (adj), skipped DW_TAG_unspecified_type
+			 * entries, and extra BTF slots from multi-dim arrays.
+			 */
+			encoder->array_index_id = encoder->type_id_off + nr - adj
+						  - encoder->btf_id_skipped
+						  + encoder->btf_id_extra;
 		}
 	}
 
 	cu__for_each_type(cu, core_id, pos) {
-		btf_type_id = btf_encoder__encode_tag(encoder, pos, conf_load);
+		btf_type_id = btf_encoder__encode_tag(encoder, pos, cu, conf_load);
 
-		if (btf_type_id == 0) {
-			++skipped_types;
+		if (btf_type_id == 0)
 			continue;
-		}
 
-		if (btf_type_id < 0 ||
-		    tag__check_id_drift(encoder, pos, core_id, btf_type_id + skipped_types)) {
+		/* Verify actual BTF id matches the pre-computed map entry. */
+		if (btf_type_id < 0) {
+			fprintf(stderr,
+				"%s: error encoding %s (core_id %u): %d\n",
+				__func__, dwarf_tag_name(pos->tag), core_id,
+				btf_type_id);
 			err = -1;
 			goto out;
 		}
+		if (encoder->btf_id_map && core_id < encoder->btf_id_map_sz) {
+			uint32_t expected = encoder->btf_id_map[core_id];
+
+			/* Inverse check: precompute expected skip but encode emitted */
+			if (!expected) {
+				fprintf(stderr,
+					"%s: %s unexpected emit, core_id: %u, btf_type_id: %u "
+					"(precompute predicted skip)\n",
+					__func__, dwarf_tag_name(pos->tag), core_id,
+					(uint32_t)btf_type_id);
+				err = -1;
+				goto out;
+			}
+			if ((uint32_t)btf_type_id != expected) {
+				fprintf(stderr,
+					"%s: %s id drift, core_id: %u, expected: %u, got: %u\n",
+					__func__, dwarf_tag_name(pos->tag), core_id,
+					expected, (uint32_t)btf_type_id);
+				err = -1;
+				goto out;
+			}
+		}
 	}
 
 	if (encoder->need_index_type && !encoder->has_index_type) {
@@ -3060,7 +3262,15 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 			continue;
 		}
 
-		btf_type_id = encoder->type_id_off + core_id;
+		if (!encoder->btf_id_map ||
+		    core_id >= encoder->btf_id_map_sz ||
+		    !encoder->btf_id_map[core_id]) {
+			if (encoder->verbose)
+				fprintf(stderr, "BTF: skipping annotations on unmapped %s (core_id %u)\n",
+					tag_name, core_id);
+			continue;
+		}
+		btf_type_id = (int)encoder->btf_id_map[core_id];
 		ns = tag__namespace(pos);
 		list_for_each_entry(annot, &ns->annots, node) {
 			tag_type_id = btf_encoder__add_decl_tag(encoder, annot->value, btf_type_id, annot->component_idx);
@@ -3122,6 +3332,17 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 	if (!err)
 		err = LSK__DELETE;
 out:
+	/*
+	 * Safe to free here: btf_encoder__save_func() stores
+	 * already-translated BTF type IDs, so the deferred
+	 * btf_encoder__add_saved_funcs() path never calls
+	 * btf_encoder__tag_type() after this point.
+	 */
+	zfree(&encoder->type_id_null_adj);
+	zfree(&encoder->btf_id_map);
+	encoder->btf_id_map_sz = 0;
+	encoder->btf_id_extra = 0;
+	encoder->btf_id_skipped = 0;
 	encoder->cu = NULL;
 	return err;
 }
-- 
2.55.0

