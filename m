Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0934632F764;
	Fri, 31 Jul 2026 19:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785526298; cv=none; b=K1p8nSm3yb5Cn7wUitll4EA2VevQrzvCV4nDMDYAWWLPt+vel3vmbNYLpd4fk1La7ZiPYgFCN3E695zQdC2DdaA0+uQ267Z641coBt/mufq8CyClUdVooBi59Kk9Oyz2SWZyWGWmHuUj6sesnQ/PYviu+ROYXM+4sgubAjoXE9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785526298; c=relaxed/simple;
	bh=wQ61moulW0ayFN6V7c86cyOAYxQ7GYknkE2n+3iITVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aGmFSuKd90tHMmSu9LOe4KPBEr2D9Tc/97eascSmI/HQzIiNMmSgAhI+BXmB3j02Qpb8TzAcZpYCnmUzn32Ig5WACLxUHS5rrjErN4lRM4jiDdq2sEUNFco1c2ROB/+M27LO7023rK+5L4/Ua/nUUPE1F3CC7CyBU1cvzvN740I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClD6dj+e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClD6dj+e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CDF1F00ACA;
	Fri, 31 Jul 2026 19:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785526295;
	bh=hQ9fezKJV+Qz8cWEatO0P3VQ4IOpA0ibFfWlZh63Iy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ClD6dj+eLqV6qyNsuXpUoH0Gx3VRSfF9mOJXltZVyM85fUtG5bcdEzdTPWxxjZjp7
	 Bq1IdolC1hHCvAjUlJERG9cL26iwdpRJ2OA/GPY3iW6NyrBHyPkoftLGd0AycF2/cB
	 xtHk+Km80nH6wTQbJgxlHQz7zYpBFouEsdDbOauxBlpZ1IRTDVUqOrH89zF42GNgkH
	 vJbUsLJgjcZI4VLTF/vqIc6V467u50RaP3qmIsVBRwFIN6+7/sORcn3qwoHQZdKsQr
	 XmENxCOzevyyndENRps4kB2LiwXPBxJr2X8DLSPP91BmGWGfkhIIUKUKQM2/+33+N1
	 1Se5wPshMSojw==
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
Subject: [PATCH 10/12] dwarf_loader: Support DW_FORM_GNU_ref_alt references to dwz alternate debug files
Date: Fri, 31 Jul 2026 16:30:58 -0300
Message-ID: <20260731193102.110693-11-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731193102.110693-1-acme@kernel.org>
References: <20260731193102.110693-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Binaries processed by dwz(1) can have shared types deduplicated into a
separate alternate debug file (.dwz), referenced via DW_FORM_GNU_ref_alt
through the .gnu_debugaltlink ELF section.  elfutils resolves these
references transparently via dwarf_getalt(), but pahole was skipping
them with a warning because the alt file's DWARF offset space is
separate from the main file's — mixing them in the same hash tables
caused type corruption and crashes.

Add a separate dwarf_cu (dcu->alt) with its own hash tables for the alt
file's offset space.  This mirrors the existing type_unit pattern but
uses direct lookup instead of fallback: the DWARF form tells us exactly
which hash table to use.

Key changes:

  - Add 'from_alt' bitfield to struct dwarf_tag, parallel to
    from_types_section, marking references that point to the alt file.

  - Add 'alt' pointer and 'processing_alt' flag to struct dwarf_cu.
    When processing children of an alt-file imported unit,
    processing_alt directs cu__hash() to use dcu->alt hash tables
    and causes all type references to be marked from_alt.

  - Update attr_type() to resolve DW_FORM_GNU_ref_alt via
    dwarf_formref_die() instead of skipping.  Returns the alt offset
    and sets is_alt so the caller marks from_alt on the dwarf_tag.
    When the alt file cannot be resolved (missing .gnu_debugaltlink
    target or build-id mismatch), emit a one-shot warning naming the
    artifact, the likely cause, and the fix (installing the matching
    debuginfo package).

  - Update dwarf_cu__find_{tag,type}_by_ref() to check from_alt and
    go directly to dcu->alt for lookup (not a fallback — the form
    is unambiguous).

  - Create the alt dwarf_cu in cus__merge_and_process_cu() via
    dwarf_getalt() before processing any CUs, so it's available
    when die__process_imported_unit() encounters the first alt ref.

  - Trigger the merged CU path when dwarf_getalt() finds an alt file,
    since the alt hash tables are only set up in that path.

  - Prune unreferenced alt partial units after processing all CUs:
    PUs directly imported by main-file CUs, or imported by any
    other PU, are conservatively retained — the hit-marking
    during pre-processing is not limited to main-CU-reachable
    PUs, so some unreferenced PUs may survive pruning.  Pruning
    creates NULL holes in types_table; a prefix-sum adjustment
    array in btf_encoder lets
    btf_encoder__tag_type() translate small_ids to dense BTF IDs in
    O(1).  This relies on a documented dwz invariant: inter-PU
    dependencies use DW_TAG_imported_unit, not bare DW_FORM_ref_addr.
    tag__check_pruned_alt_ref() detects violations at recode time by
    checking whether a failed from_alt lookup targets a pruned PU.

  - Alt PU ranges are kept in a sorted array and located via binary
    search (dwarf_cu__find_alt_pu), since large dwz alt files can
    contain thousands of partial units and every type reference needs
    to identify which PU it belongs to.

  - dwarf_cu__delete() now explicitly frees hash_tags and
    hash_types via cu__free() for all dwarf_cu instances, not just
    the alt one.  Under obstack this is a no-op, but in the
    non-obstack path it fixes a pre-existing leak.

  - Remove attr_form_is_ref_alt() and all its callers — no longer
    needed since alt refs are now resolved instead of skipped.

  - Add tests/dwz_alt_file.sh: creates two binaries sharing types,
    runs dwz to produce an alt file, verifies pahole resolves the
    shared types.  Includes a negative sub-test that hides the alt
    file and verifies the one-shot warning fires exactly once and
    pahole does not crash.

The btf_encoder__tag_type() call site consolidation and the
dwarf_tag__set_attr_type() / tag__set_spec() cu parameter threading
were split into separate prep patches.

Before (chromium-browser debuginfo, Fedora 44):

  $ pahole -F dwarf .../chromium-browser-149.0.7827.155-1.fc44.x86_64.debug
  WARNING: DW_FORM_GNU_ref_alt (dwz alternate debug file) not yet supported,
           some types will not be available.
  [no output]

After:

  $ pahole -F dwarf .../chromium-browser-149.0.7827.155-1.fc44.x86_64.debug | wc -l
  6378

This was based in previous, not AI assisted work back in 2023, as stored
in these branches:

  https://git.kernel.org/pub/scm/devel/pahole/pahole.git/log/?h=alt_dwarf and
  https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=WIP-imported-unit

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 btf_encoder.c         |   3 +-
 ctf_encoder.c         |  11 +
 dwarf_loader.c        | 579 +++++++++++++++++++++++++++++++++++++-----
 dwarves.h             |  20 ++
 tests/dwz_alt_file.sh | 204 +++++++++++++++
 5 files changed, 748 insertions(+), 69 deletions(-)
 create mode 100755 tests/dwz_alt_file.sh

diff --git a/btf_encoder.c b/btf_encoder.c
index acf0a5ade5e29014..1d645977319c9991 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -768,7 +768,8 @@ static int32_t btf_encoder__tag_type(struct btf_encoder *encoder, uint32_t tag_t
 	if (encoder->btf_id_map && tag_type < encoder->btf_id_map_sz)
 		return encoder->btf_id_map[tag_type];
 
-	/* Fallback for map-absent CUs (nr == 0) or out-of-range ids */
+	/* Fallback for map-absent CUs (nr == 0) or out-of-range ids;
+	 * adjust for NULL holes left by dwz alt PU pruning */
 	uint32_t adj = encoder->type_id_null_adj ? encoder->type_id_null_adj[tag_type] : 0;
 
 	return encoder->type_id_off + tag_type - adj;
diff --git a/ctf_encoder.c b/ctf_encoder.c
index f9e75a5821ce4e83..d7fc1c1f94875b16 100644
--- a/ctf_encoder.c
+++ b/ctf_encoder.c
@@ -263,6 +263,17 @@ int cu__encode_ctf(struct cu *cu, int verbose)
 
 	uint32_t id;
 	struct tag *pos;
+
+	/* CTF IDs must be sequential — NULL holes in the types table
+	 * (from dwz alternate debug files) would desync core vs CTF IDs.
+	 * Bail out rather than generate corrupt CTF. */
+	for (id = 1; id < cu->types_table.nr_entries; ++id) {
+		if (cu->types_table.entries[id] == NULL) {
+			fprintf(stderr, "ctf_encoder: NULL holes in types table not supported for CTF encoding\n");
+			goto out_delete;
+		}
+	}
+
 	cu__for_each_type(cu, id, pos)
 		tag__encode_ctf(pos, cu, id, ctf);
 
diff --git a/dwarf_loader.c b/dwarf_loader.c
index 39a49e9a5048dee7..aca886a6f675343e 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -118,6 +118,16 @@ static struct tag unsupported_tag;
 
 #define cu__tag_not_handled(cu, die) __cu__tag_not_handled(cu, die, __FUNCTION__)
 
+/*
+ * Each DWARF reference attribute can point to one of three offset spaces:
+ *  1. Main file — the default, looked up in dcu->hash_*
+ *  2. .debug_types — DW_FORM_ref_sig8, looked up in dcu->type_unit->hash_*
+ *  3. dwz alt file — DW_FORM_GNU_ref_alt, looked up in dcu->alt->hash_*
+ *
+ * The from_types_section and from_alt bitfields record which space each
+ * reference attribute targets, so the lookup functions go directly to the
+ * right hash table without fallback searches.
+ */
 struct dwarf_tag {
 	struct hlist_node hash_node;
 	Dwarf_Off	 type;
@@ -133,6 +143,12 @@ struct dwarf_tag {
 		bool		 containing_type:1;
 		bool		 specification:1;
 	} from_types_section;
+	struct {
+		bool		 type:1;
+		bool		 abstract_origin:1;
+		bool		 containing_type:1;
+		bool		 specification:1;
+	} from_alt;
 	uint16_t         decl_line;
 	uint32_t         small_id;
 	const char	 *decl_file;
@@ -148,15 +164,26 @@ static inline struct dwarf_tag *tag__dwarf(const struct tag *tag)
 	return ((struct dwarf_tag *)tag) - 1;
 }
 
+struct alt_pu {
+	Dwarf_Off start;	/* first DIE offset in this PU */
+	Dwarf_Off end;		/* first offset past this PU (next CU header) */
+	bool	  hit;		/* referenced by main CUs? */
+};
+
 struct dwarf_cu {
-	struct hlist_head *hash_tags;
-	struct hlist_head *hash_types;
+	struct hlist_head *hash_tags;	/* tags (functions, etc.) keyed by DWARF offset */
+	struct hlist_head *hash_types;	/* types keyed by DWARF offset */
 	struct dwarf_tag *last_type_lookup;
 	struct cu *cu;
-	struct dwarf_cu *type_unit;
-	Dwarf_Off *imported_units;
+	struct dwarf_cu *type_unit;	/* .debug_types offset space */
+	struct dwarf_cu *alt;		/* dwz alt file offset space */
+	Dwarf_Off *imported_units;	/* dedup: visited same-file partial unit offsets */
 	uint32_t  nr_imported_units;
 	uint32_t  allocated_imported_units;
+	struct alt_pu *alt_pus;
+	uint32_t  nr_alt_pus;
+	uint32_t  allocated_alt_pus;
+	bool	  processing_alt;	/* true while processing alt-file DIEs */
 };
 
 static int dwarf_cu__init(struct dwarf_cu *dcu, struct cu *cu)
@@ -182,9 +209,21 @@ static int dwarf_cu__init(struct dwarf_cu *dcu, struct cu *cu)
 		INIT_HLIST_HEAD(&dcu->hash_types[i]);
 	}
 	dcu->type_unit = NULL;
+	dcu->alt = NULL;
 	dcu->imported_units = NULL;
 	dcu->nr_imported_units = 0;
 	dcu->allocated_imported_units = 0;
+	dcu->alt_pus = NULL;
+	dcu->nr_alt_pus = 0;
+	dcu->allocated_alt_pus = 0;
+	/*
+	 * processing_alt is per-merged-CU state, not thread-safe.
+	 * The merged-CU path (cus__merge_and_process_cu) is
+	 * single-threaded; do not parallelize merged loading
+	 * without addressing this and the alt hash routing in
+	 * cu__hash().
+	 */
+	dcu->processing_alt = false;
 	// To avoid a per-lookup check against NULL in dwarf_cu__find_type_by_ref()
 	dcu->last_type_lookup = &sentinel_dtag;
 	return 0;
@@ -209,8 +248,16 @@ static void dwarf_cu__delete(struct cu *cu)
 
 	struct dwarf_cu *dcu = cu->priv;
 
-	free(dcu->imported_units);
-	// dcu->hash_tags & dcu->hash_types are on cu->obstack
+	zfree(&dcu->imported_units);
+	zfree(&dcu->alt_pus);
+	if (dcu->alt) {
+		cu__free(cu, dcu->alt->hash_tags);
+		cu__free(cu, dcu->alt->hash_types);
+		cu__free(cu, dcu->alt);
+		dcu->alt = NULL;
+	}
+	cu__free(cu, dcu->hash_tags);
+	cu__free(cu, dcu->hash_types);
 	cu__free(cu, dcu);
 	cu->priv = NULL;
 }
@@ -252,39 +299,198 @@ static struct dwarf_tag *hashtags__find(const struct hlist_head *hashtable,
 	return NULL;
 }
 
+/*
+ * cu__hash - insert a tag into the appropriate hash table
+ *
+ * Three hash table sets exist per merged CU:
+ *  - dcu->hash_types / hash_tags:  main-file DWARF offsets
+ *  - dcu->alt->hash_types / hash_tags:  dwz alt-file offsets
+ *  - dcu->type_unit->hash_types:  .debug_types offsets
+ *
+ * When dcu->processing_alt is set (i.e. we are processing children of
+ * an alt-file partial unit), tags are hashed into dcu->alt so that
+ * their alt-file offsets don't collide with main-file offsets.
+ */
 static void cu__hash(struct cu *cu, struct tag *tag)
 {
 	struct dwarf_cu *dcu = cu->priv;
+	struct dwarf_cu *target = (dcu->processing_alt && dcu->alt) ? dcu->alt : dcu;
 	struct hlist_head *hashtable = tag__is_tag_type(tag) ?
-							dcu->hash_types :
-							dcu->hash_tags;
+							target->hash_types :
+							target->hash_tags;
 	hashtags__hash(hashtable, tag__dwarf(tag));
 }
 
+/* Binary search for the alt PU whose [start, end) range contains offset.
+ * The array is sorted by .start (built monotonically by dwarf_nextcu)
+ * with non-overlapping ranges. Returns NULL if offset is not in any PU. */
+static struct alt_pu *dwarf_cu__find_alt_pu(struct dwarf_cu *dcu, Dwarf_Off offset)
+{
+	uint32_t lo = 0, hi = dcu->nr_alt_pus;
+
+	while (lo < hi) {
+		uint32_t mid = lo + (hi - lo) / 2;
+
+		if (offset < dcu->alt_pus[mid].start)
+			hi = mid;
+		else if (offset >= dcu->alt_pus[mid].end)
+			lo = mid + 1;
+		else
+			return &dcu->alt_pus[mid];
+	}
+	return NULL;
+}
+
+static bool dwarf_cu__alt_pu_is_hit(struct dwarf_cu *dcu, Dwarf_Off offset)
+{
+	struct alt_pu *pu = dwarf_cu__find_alt_pu(dcu, offset);
+	return pu ? pu->hit : false;
+}
+
+/* True when offset falls inside an alt PU that was not marked as hit —
+ * i.e. it was pruned by dwarf_cu__prune_unreferenced_alt_pus(). */
+static bool dwarf_cu__offset_in_pruned_alt_pu(struct dwarf_cu *dcu, Dwarf_Off offset)
+{
+	struct alt_pu *pu = dwarf_cu__find_alt_pu(dcu, offset);
+	return pu ? !pu->hit : false;
+}
+
+/* After a from_alt lookup miss during recode, check whether the target
+ * offset falls in a PU that was pruned.  This catches dwz invariant
+ * violations where an inter-PU dependency was not expressed via
+ * DW_TAG_imported_unit.
+ *
+ * Works for plain-form refs (ref4 etc.) within the alt file too:
+ * dwarf_tag__set_attr_type ORs processing_alt into from_alt, so
+ * intra-alt refs carry the bit even though their DWARF form is not
+ * DW_FORM_GNU_ref_alt. */
+static void tag__check_pruned_alt_ref(struct dwarf_cu *dcu, Dwarf_Off ref,
+				      bool from_alt)
+{
+	if (!from_alt || dcu == NULL || dcu->nr_alt_pus == 0)
+		return;
+	if (dwarf_cu__offset_in_pruned_alt_pu(dcu, ref))
+		fprintf(stderr,
+			"         reference %#llx is in a pruned dwz alternate partial unit — "
+			"possible dwz invariant violation\n"
+			"         (inter-PU dependency not expressed via DW_TAG_imported_unit)\n",
+			(unsigned long long)ref);
+}
+
+/*
+ * Remove types/functions from dwz alternate partial units that were
+ * never marked as hit.  A PU is marked hit when:
+ *
+ *  (a) a main-file CU references it via DW_FORM_GNU_ref_alt
+ *      (attribute ref or DW_TAG_imported_unit), or
+ *  (b) any other alt PU imports it via DW_TAG_imported_unit —
+ *      regardless of whether that importing PU is itself reachable
+ *      from a main CU, since the pre-processing pass in
+ *      cus__merge_and_process_cu() walks ALL alt PUs with
+ *      hit-marking enabled.
+ *
+ * (b) makes this a conservative over-approximation of "transitively
+ * reachable from main CUs": clusters of PUs that only import each
+ * other survive pruning even if no main CU references the cluster.
+ * Correctness is unaffected — only the amount pruned.  Tightening
+ * this to true main-rooted reachability would require recording
+ * PU→PU import edges during pre-processing and propagating hits
+ * from main-referenced roots before pruning.
+ *
+ * Safety invariant (why pruning can't remove something needed):
+ * dwz expresses inter-PU dependencies via DW_TAG_imported_unit,
+ * not bare DW_FORM_ref_addr.  If dwz violated this, the target PU
+ * could be pruned while still referenced; tag__check_pruned_alt_ref()
+ * detects that at recode time and prints a diagnostic.
+ */
+static void dwarf_cu__prune_unreferenced_alt_pus(struct dwarf_cu *dcu)
+{
+	struct dwarf_cu *alt = dcu->alt;
+	struct cu *cu = dcu->cu;
+
+	if (alt == NULL || dcu->nr_alt_pus == 0)
+		return;
+
+	uint64_t hashtags_size = 1UL << hashtags__bits;
+
+	for (uint64_t i = 0; i < hashtags_size; i++) {
+		struct dwarf_tag *dtag;
+		struct hlist_node *pos, *tmp;
+
+		hlist_for_each_entry_safe(dtag, pos, tmp, &alt->hash_types[i], hash_node) {
+			if (!dwarf_cu__alt_pu_is_hit(dcu, dtag->id)) {
+				struct tag *tag = dtag__tag(dtag);
+				hlist_del(&dtag->hash_node);
+				list_del_init(&tag->node);
+				cu->types_table.entries[dtag->small_id] = NULL;
+			}
+		}
+		hlist_for_each_entry_safe(dtag, pos, tmp, &alt->hash_tags[i], hash_node) {
+			if (!dwarf_cu__alt_pu_is_hit(dcu, dtag->id)) {
+				struct tag *tag = dtag__tag(dtag);
+				hlist_del(&dtag->hash_node);
+				list_del_init(&tag->node);
+				if (tag__is_function(tag)) {
+					rb_erase(&tag__function(tag)->rb_node, &cu->functions);
+					cu->functions_table.entries[dtag->small_id] = NULL;
+				} else
+					cu->tags_table.entries[dtag->small_id] = NULL;
+			}
+		}
+		/*
+		 * Don't free pruned tags here: child tags (members) have
+		 * list nodes linked through their parent's namespace.tags,
+		 * so freeing parents in hash_types before processing children
+		 * in hash_tags would cause use-after-free on list_del_init().
+		 * All tag memory is freed when the CU is destroyed.
+		 */
+	}
+}
+
+/*
+ * Lookup a tag (function, lexblock, etc.) by DWARF offset.
+ *
+ * The from_alt bit tells us the reference came from DW_FORM_GNU_ref_alt
+ * or was inside an alt partial unit (processing_alt), so we go directly
+ * to dcu->alt->hash_tags.  This is a direct lookup, not a fallback —
+ * the DWARF form tells us which offset space the reference belongs to.
+ */
 static struct dwarf_tag *__dwarf_cu__find_tag_by_ref(const struct dwarf_cu *cu,
-						     const Dwarf_Off ref, bool from_types)
+						     const Dwarf_Off ref,
+						     bool from_types, bool from_alt)
 {
 	if (cu == NULL)
 		return NULL;
-	if (from_types) {
+	if (from_types)
 		return NULL;
+	if (from_alt) {
+		cu = cu->alt;
+		if (cu == NULL)
+			return NULL;
 	}
 	return hashtags__find(cu->hash_tags, ref);
 }
 
 #define dwarf_cu__find_tag_by_ref(cu, dtag, field) \
-	__dwarf_cu__find_tag_by_ref(cu, dtag->field, dtag->from_types_section.field)
+	__dwarf_cu__find_tag_by_ref(cu, dtag->field, \
+				    dtag->from_types_section.field, \
+				    dtag->from_alt.field)
 
+/* Same as __dwarf_cu__find_tag_by_ref but for type lookups (hash_types). */
 static struct dwarf_tag *__dwarf_cu__find_type_by_ref(struct dwarf_cu *dcu,
-						      const Dwarf_Off ref, bool from_types)
+						      const Dwarf_Off ref,
+						      bool from_types, bool from_alt)
 {
 	if (dcu == NULL)
 		return NULL;
 	if (from_types) {
 		dcu = dcu->type_unit;
-		if (dcu == NULL) {
+		if (dcu == NULL)
+			return NULL;
+	} else if (from_alt) {
+		dcu = dcu->alt;
+		if (dcu == NULL)
 			return NULL;
-		}
 	}
 
 	if (dcu->last_type_lookup->id == ref)
@@ -299,7 +505,9 @@ static struct dwarf_tag *__dwarf_cu__find_type_by_ref(struct dwarf_cu *dcu,
 }
 
 #define dwarf_cu__find_type_by_ref(dcu, dtag, field) \
-	__dwarf_cu__find_type_by_ref(dcu, dtag->field, dtag->from_types_section.field)
+	__dwarf_cu__find_type_by_ref(dcu, dtag->field, \
+				     dtag->from_types_section.field, \
+				     dtag->from_alt.field)
 
 static void *memdup(const void *src, size_t len, struct cu *cu)
 {
@@ -493,31 +701,65 @@ static const char *attr_string(Dwarf_Die *die, uint32_t name, struct conf_load *
 	return str;
 }
 
-static bool attr_form_is_ref_alt(Dwarf_Attribute *attr)
-{
-	if (attr->form == DW_FORM_GNU_ref_alt) {
-		static bool warned;
-
-		if (!warned) {
-			fprintf(stderr,
-				"WARNING: DW_FORM_GNU_ref_alt (dwz alternate debug file) not yet supported,\n"
-				"         some types will not be available.\n");
-			warned = true;
-		}
-		return true;
-	}
-	return false;
-}
-
-static bool attr_type(Dwarf_Die *die, uint32_t attr_name, Dwarf_Off *offset)
+/**
+ * attr_type - extract a type reference attribute from a DWARF DIE
+ * @die: the DWARF DIE to read the attribute from
+ * @attr_name: the attribute to read (DW_AT_type, DW_AT_import, etc)
+ * @offset: output DWARF offset of the referenced DIE
+ * @is_alt: output flag, set when the reference points to a dwz alt file
+ *
+ * Resolves a DWARF reference attribute to a DIE offset.  Handles three
+ * reference forms:
+ *
+ *  - DW_FORM_GNU_ref_alt: reference into a dwz alternate debug file.
+ *    Resolved transparently by elfutils via dwarf_getalt().  Sets
+ *    @is_alt so callers use the alt hash tables for lookup.
+ *
+ *  - DW_FORM_ref_sig8: reference into a .debug_types section (DWARF4).
+ *    Returns true so callers use the type_unit hash tables.
+ *
+ *  - All other ref forms (ref1/ref2/ref4/ref8/ref_addr): same-file
+ *    references resolved by dwarf_formref_die().
+ *
+ * Return: true if the reference is from the types section (DW_FORM_ref_sig8),
+ *         false otherwise.  @offset and @is_alt are set on output.
+ */
+static bool attr_type(Dwarf_Die *die, uint32_t attr_name, Dwarf_Off *offset,
+		      bool *is_alt)
 {
 	Dwarf_Attribute attr;
 
+	*is_alt = false;
+
 	if (dwarf_attr(die, attr_name, &attr) != NULL) {
 		Dwarf_Die type_die;
-		if (attr_form_is_ref_alt(&attr)) {
+		if (attr.form == DW_FORM_GNU_ref_alt) {
+			if (dwarf_formref_die(&attr, &type_die) != NULL) {
+				*offset = dwarf_dieoffset(&type_die);
+				*is_alt = true;
+				return false;
+			}
+			/* elfutils couldn't resolve the alt reference —
+			 * .gnu_debugaltlink target is missing or has a
+			 * build-id mismatch.  Warn once per process:
+			 * when loading multiple files in batch mode,
+			 * only the first missing alt triggers the
+			 * message — subsequent files with the same
+			 * problem are silent.  This trades completeness
+			 * for avoiding stderr spam on large debuginfo
+			 * directories where many files share the same
+			 * missing alt package. */
+			static bool alt_resolve_warned;
+			if (!alt_resolve_warned) {
+				fprintf(stderr,
+					"WARNING: could not resolve dwz alternate debug file\n"
+					"         (.gnu_debugaltlink target missing or build-id mismatch?)\n"
+					"         Some types will not be available.\n"
+					"         Installing the matching debuginfo package may fix this.\n");
+				alt_resolve_warned = true;
+			}
 			*offset = 0;
-			return 0;
+			return false;
 		}
 		if (dwarf_formref_die(&attr, &type_die) != NULL) {
 			*offset = dwarf_dieoffset(&type_die);
@@ -525,7 +767,7 @@ static bool attr_type(Dwarf_Die *die, uint32_t attr_name, Dwarf_Off *offset)
 		}
 	}
 	*offset = 0;
-	return 0;
+	return false;
 }
 
 static int attr_location(Dwarf_Die *die, Dwarf_Op **expr, size_t *exprlen)
@@ -572,8 +814,44 @@ static void tag__free(struct tag *tag, struct cu *cu)
 	cu__free(cu, dtag);
 }
 
-#define dwarf_tag__set_attr_type(dtag, field, die, attr_name, cu) \
-	dtag->from_types_section.field = attr_type(die, attr_name, &dtag->field)
+static void dwarf_cu__mark_alt_pu_hit(struct dwarf_cu *dcu, Dwarf_Off offset)
+{
+	struct alt_pu *pu = dwarf_cu__find_alt_pu(dcu, offset);
+	if (pu)
+		pu->hit = true;
+}
+
+/*
+ * Extract a reference attribute and record which offset space it targets.
+ *
+ * from_alt is set when either:
+ *  (a) attr_type() saw DW_FORM_GNU_ref_alt — an explicit alt reference, OR
+ *  (b) we are inside an alt partial unit (processing_alt) — a same-file
+ *      ref form like DW_FORM_ref4 that still refers to the alt offset space.
+ *
+ * This bit drives the lookup functions to search dcu->alt hash tables.
+ */
+#define dwarf_tag__set_attr_type(dtag, field, die, attr_name, cu) do {	\
+	bool __is_alt;							\
+	struct dwarf_cu *__dcu = (cu)->priv;				\
+	dtag->from_types_section.field = attr_type(die, attr_name,	\
+						   &dtag->field, &__is_alt); \
+	dtag->from_alt.field = __is_alt ||				\
+			       (__dcu && __dcu->processing_alt);	\
+	/* Only mark alt PU as hit for actual cross-file refs	\
+	 * (DW_FORM_GNU_ref_alt).  During processing_alt,	\
+	 * internal refs within alt PUs use same-file forms	\
+	 * (ref4 etc.) and must NOT mark PUs as hit — doing	\
+	 * so would mark every PU via its own internal refs	\
+	 * and defeat pruning entirely.  Transitive deps are	\
+	 * handled by DW_TAG_imported_unit chains: if PU A	\
+	 * imports PU B, then B gets marked hit during the	\
+	 * alt pre-processing pass in			\
+	 * cus__merge_and_process_cu().			\
+	 */							\
+	if (__dcu && __is_alt)					\
+		dwarf_cu__mark_alt_pu_hit(__dcu, dtag->field);		\
+} while (0)
 
 static void tag__init(struct tag *tag, struct cu *cu, Dwarf_Die *die)
 {
@@ -633,7 +911,7 @@ static struct tag *tag__new(Dwarf_Die *die, struct cu *cu)
 	return tag;
 }
 
-static void tag__set_spec(struct tag *tag, Dwarf_Die *die, struct cu *cu __maybe_unused)
+static void tag__set_spec(struct tag *tag, Dwarf_Die *die, struct cu *cu)
 {
 	struct dwarf_tag *dtag = tag__dwarf(tag);
 	dwarf_tag__set_attr_type(dtag, specification, die, DW_AT_specification, cu);
@@ -749,8 +1027,7 @@ static void type__init(struct type *type, Dwarf_Die *die, struct cu *cu, struct
 	Dwarf_Attribute attr;
 	if (dwarf_attr(die, DW_AT_type, &attr) != NULL) {
 		Dwarf_Die type_die;
-		if (!attr_form_is_ref_alt(&attr) &&
-		    dwarf_formref_die(&attr, &type_die) != NULL) {
+		if (dwarf_formref_die(&attr, &type_die) != NULL) {
 			uint64_t encoding = attr_numeric(&type_die, DW_AT_encoding);
 
 			if (encoding == DW_ATE_signed || encoding == DW_ATE_signed_char)
@@ -1065,8 +1342,6 @@ static int add_gnu_annotation_chain(Dwarf_Die *die, int component_idx,
 	Dwarf_Die annot_die;
 
 	while (dwarf_attr(die, DW_AT_GNU_annotation, &attr) != NULL) {
-		if (attr_form_is_ref_alt(&attr))
-			break;
 		if (dwarf_formref_die(&attr, &annot_die) == NULL)
 			break;
 		if (dwarf_tag(&annot_die) != DW_TAG_GNU_annotation)
@@ -1520,7 +1795,9 @@ static void parameter__record_true_sig_member(struct parameter *parm, Dwarf_Die
 	if (!parm->true_sig_member_name)
 		return;
 
-	parm->true_sig_type_from_types = attr_type(&member_die, DW_AT_type, &parm->true_sig_type);
+	bool is_alt;
+	parm->true_sig_type_from_types = attr_type(&member_die, DW_AT_type, &parm->true_sig_type, &is_alt);
+	parm->true_sig_type_from_alt = is_alt;
 	if (parm->true_sig_type == 0)
 		parm->true_sig_member_name = NULL;
 }
@@ -2112,23 +2389,55 @@ check_gnu_attr:
 		goto out;
 
 	/* Handle GCC-style DW_AT_GNU_annotation attribute */
-	while (dwarf_attr(die, DW_AT_GNU_annotation, &attr) != NULL) {
-		if (attr_form_is_ref_alt(&attr))
-			break;
-		if (dwarf_formref_die(&attr, &annot_die) == NULL)
-			break;
-		if (dwarf_tag(&annot_die) != DW_TAG_GNU_annotation)
-			break;
-		name = attr_string(&annot_die, DW_AT_name, conf);
-		if (strcmp(name, "btf_type_tag") != 0)
-			break;
+	{
+		struct dwarf_cu *annot_dcu = cu->priv;
+		bool was_alt = annot_dcu->processing_alt;
 
-		/* GCC chain is already in BTF order; append to preserve it. */
-		tag = die__add_btf_type_tag(tag, die, &annot_die, cu, conf, false);
-		if (tag == NULL)
-			return NULL;
+		while (dwarf_attr(die, DW_AT_GNU_annotation, &attr) != NULL) {
+			bool is_alt_annot = (attr.form == DW_FORM_GNU_ref_alt);
 
-		die = &annot_die;
+			if (dwarf_formref_die(&attr, &annot_die) == NULL)
+				break;
+			if (dwarf_tag(&annot_die) != DW_TAG_GNU_annotation)
+				break;
+			name = attr_string(&annot_die, DW_AT_name, conf);
+			if (strcmp(name, "btf_type_tag") != 0)
+				break;
+
+			/*
+			 * Create the base wrapper before entering alt context
+			 * so the pointer's type ref stays in the main file's
+			 * hash tables.  Then set processing_alt so the
+			 * annotation itself is hashed into the alt tables.
+			 */
+			/* Mark annotation as hit for both cross-file refs
+			 * (DW_FORM_GNU_ref_alt) and intra-alt refs when
+			 * already in alt context, so annotations aren't
+			 * pruned by dwarf_cu__prune_unreferenced_alt_pus */
+			if (is_alt_annot || annot_dcu->processing_alt) {
+				dwarf_cu__mark_alt_pu_hit(annot_dcu,
+							  dwarf_dieoffset(&annot_die));
+				if (tag == NULL) {
+					tag = die__create_new_btf_type_tag_ptr_type(die, cu);
+					if (tag == NULL) {
+						annot_dcu->processing_alt = was_alt;
+						return NULL;
+					}
+				}
+				annot_dcu->processing_alt = true;
+			}
+
+			/* GCC chain is already in BTF order; append to preserve it. */
+			tag = die__add_btf_type_tag(tag, die, &annot_die, cu, conf, false);
+			if (tag == NULL) {
+				annot_dcu->processing_alt = was_alt;
+				return NULL;
+			}
+
+			die = &annot_die;
+		}
+
+		annot_dcu->processing_alt = was_alt;
 	}
 
 out:
@@ -3037,6 +3346,45 @@ static int dwarf_cu__mark_imported_unit(struct dwarf_cu *dcu, struct cu *cu, Dwa
 	return 0;
 }
 
+/*
+ * Defensive: dwarf_nextcu iterates monotonically so duplicates
+ * should not occur, but guard against it anyway.
+ */
+static bool dwarf_cu__alt_pu_visited(struct dwarf_cu *dcu, Dwarf_Off offset)
+{
+	/* Exact start match — reuse the range search since PU starts
+	 * are unique and searching for a start offset will land in
+	 * the PU whose start == offset (if it exists). */
+	struct alt_pu *pu = dwarf_cu__find_alt_pu(dcu, offset);
+	return pu && pu->start == offset;
+}
+
+static int dwarf_cu__add_alt_pu(struct dwarf_cu *dcu, Dwarf_Off start, Dwarf_Off end)
+{
+	if (dcu->nr_alt_pus == dcu->allocated_alt_pus) {
+		uint32_t new_size = dcu->allocated_alt_pus ? dcu->allocated_alt_pus * 2 : 16;
+		if (new_size <= dcu->allocated_alt_pus)
+			return -ENOMEM;
+		struct alt_pu *new_array = realloc(dcu->alt_pus, new_size * sizeof(*new_array));
+		if (new_array == NULL)
+			return -ENOMEM;
+		dcu->alt_pus = new_array;
+		dcu->allocated_alt_pus = new_size;
+	}
+	dcu->alt_pus[dcu->nr_alt_pus++] = (struct alt_pu){ .start = start, .end = end, .hit = false };
+	return 0;
+}
+
+/**
+ * die__process_imported_unit - process a DW_TAG_imported_unit reference
+ *
+ * For alt-file imports (DW_FORM_GNU_ref_alt / dwz): marks the partial
+ * unit as referenced for pruning.  Alt PUs are pre-processed in bulk
+ * by cus__merge_and_process_cu().
+ *
+ * For same-file imports: processes children inline into the CU's type
+ * tables, with dedup to avoid re-processing.
+ */
 static int die__process_imported_unit(Dwarf_Die *die, struct cu *cu, struct conf_load *conf, int import_depth)
 {
 	Dwarf_Attribute attr;
@@ -3044,8 +3392,7 @@ static int die__process_imported_unit(Dwarf_Die *die, struct cu *cu, struct conf
 	if (dwarf_attr(die, DW_AT_import, &attr) == NULL)
 		return 0;
 
-	if (attr_form_is_ref_alt(&attr))
-		return 0;
+	bool is_alt = (attr.form == DW_FORM_GNU_ref_alt);
 
 	Dwarf_Die imported_die;
 
@@ -3071,6 +3418,18 @@ static int die__process_imported_unit(Dwarf_Die *die, struct cu *cu, struct conf
 	Dwarf_Off offset = dwarf_dieoffset(&imported_die);
 	struct dwarf_cu *dcu = cu->priv;
 
+	if (is_alt || dcu->processing_alt) {
+		/*
+		 * Alt PUs are pre-processed in cus__merge_and_process_cu(),
+		 * so just mark this one as referenced for pruning.
+		 * Mark hits from both main CU imports (is_alt) and
+		 * inter-alt-PU imports (processing_alt) to handle
+		 * transitive dependencies between partial units.
+		 */
+		dwarf_cu__mark_alt_pu_hit(dcu, offset);
+		return 0;
+	}
+
 	if (dwarf_cu__imported_unit_visited(dcu, offset))
 		return 0;
 
@@ -3391,7 +3750,8 @@ static bool parameter__apply_true_sig_member(struct parameter *parm, struct cu *
 
 	tmp.type = parm->true_sig_type;
 	tmp.from_types_section.type = parm->true_sig_type_from_types;
-	dtype = __dwarf_cu__find_type_by_ref(cu->priv, tmp.type, tmp.from_types_section.type);
+	dtype = __dwarf_cu__find_type_by_ref(cu->priv, tmp.type, tmp.from_types_section.type,
+					     parm->true_sig_type_from_alt);
 	if (!dtype)
 		return false;
 
@@ -3547,10 +3907,15 @@ static void lexblock__recode_dwarf_types(struct lexblock *tag, struct cu *cu)
 			else
 				dtype = dwarf_cu__find_tag_by_ref(dcu, dpos, abstract_origin);
 			if (dtype == NULL) {
-				if (dpos->type != 0)
+				if (dpos->type != 0) {
 					tag__print_type_not_found(pos);
-				else
+					tag__check_pruned_alt_ref(dcu, dpos->type,
+								  dpos->from_alt.type);
+				} else {
 					tag__print_abstract_origin_not_found(pos);
+					tag__check_pruned_alt_ref(dcu, dpos->abstract_origin,
+								  dpos->from_alt.abstract_origin);
+				}
 				continue;
 			}
 			ftype__recode_dwarf_types(dtag__tag(dtype), cu);
@@ -3612,6 +3977,7 @@ static void lexblock__recode_dwarf_types(struct lexblock *tag, struct cu *cu)
 		dtype = dwarf_cu__find_type_by_ref(dcu, dpos, type);
 		if (dtype == NULL) {
 			tag__print_type_not_found(pos);
+			tag__check_pruned_alt_ref(dcu, dpos->type, dpos->from_alt.type);
 			continue;
 		}
 		pos->type = dtype->small_id;
@@ -3732,10 +4098,14 @@ static int tag__recode_dwarf_type(struct tag *tag, struct cu *cu)
 
 	case DW_TAG_namespace:
 		return namespace__recode_dwarf_types(tag, cu);
-	/* Damn, DW_TAG_inlined_subroutine is an special case
-           as dwarf_tag->id is in fact an abtract origin, i.e. must be
-	   looked up in the tags_table, not in the types_table.
-	   The others also point to routines, so are in tags_table */
+	/*
+	 * DW_TAG_inlined_subroutine uses DW_AT_abstract_origin to
+	 * reference the out-of-line subprogram.  inline_expansion__new()
+	 * stores this in dtag->type (not dtag->abstract_origin) via
+	 * dwarf_tag__set_attr_type(dtag, type, die, DW_AT_abstract_origin).
+	 * For dwz binaries, the target subprogram lives in the alt file,
+	 * so dtag->from_alt.type drives the lookup to dcu->alt->hash_tags.
+	 */
 	case DW_TAG_inlined_subroutine:
 	case DW_TAG_imported_module:
 		dtype = dwarf_cu__find_tag_by_ref(cu->priv, dtag, type);
@@ -3773,6 +4143,7 @@ find_type:
 check_type:
 	if (dtype == NULL) {
 		tag__print_type_not_found(tag);
+		tag__check_pruned_alt_ref(cu->priv, dtag->type, dtag->from_alt.type);
 		return 0;
 	}
 out:
@@ -4718,6 +5089,75 @@ static int cus__merge_and_process_cu(struct cus *cus, struct conf_load *conf,
 			dcu->type_unit = type_dcu;
 			cu->priv = dcu;
 			cu->dfops = &dwarf__ops;
+
+			/*
+			 * Check for a dwz alternate debug file.  Create
+			 * a separate dwarf_cu with its own hash tables
+			 * for the alt file's offset space, so that
+			 * DW_FORM_GNU_ref_alt references during
+			 * die__process_unit() can be hashed and looked
+			 * up without colliding with main-file offsets.
+			 *
+			 * Pre-process all partial units in the alt file
+			 * so that DW_FORM_GNU_ref_alt references from
+			 * regular attributes (DW_AT_abstract_origin,
+			 * DW_AT_type, etc. on inlined_subroutines and
+			 * other DIEs) can be resolved.  These direct
+			 * references can point to any DIE in the alt
+			 * file, not just those in explicitly imported
+			 * partial units.
+			 */
+			Dwarf *alt_dw = dwarf_getalt(dw);
+
+			if (alt_dw != NULL) {
+				struct dwarf_cu *alt_dcu = dwarf_cu__new(cu);
+
+				if (alt_dcu == NULL)
+					goto out_abort;
+
+				alt_dcu->cu = cu;
+				dcu->alt = alt_dcu;
+
+				Dwarf_Off alt_off = 0, alt_noff;
+				size_t alt_cuhl;
+
+				/*
+				 * First pass: register all alt PUs so that
+				 * forward references between them can be
+				 * resolved during processing.
+				 */
+				while (dwarf_nextcu(alt_dw, alt_off, &alt_noff,
+						   &alt_cuhl, NULL, NULL, NULL) == 0) {
+					Dwarf_Die alt_die_mem;
+
+					if (dwarf_offdie(alt_dw, alt_off + alt_cuhl,
+							 &alt_die_mem) != NULL &&
+					    !dwarf_cu__alt_pu_visited(dcu, alt_off + alt_cuhl)) {
+						if (dwarf_cu__add_alt_pu(dcu, alt_off + alt_cuhl, alt_noff))
+							goto out_abort;
+					}
+					alt_off = alt_noff;
+				}
+
+				/* Second pass: process DIEs now that all PUs
+				 * are in the array and can be marked as hit.
+				 */
+				dcu->processing_alt = true;
+
+				for (uint32_t i = 0; i < dcu->nr_alt_pus; i++) {
+					Dwarf_Die alt_cu_die, alt_child;
+
+					if (dwarf_offdie(alt_dw, dcu->alt_pus[i].start,
+							 &alt_cu_die) != NULL &&
+					    dwarf_child(&alt_cu_die, &alt_child) == 0) {
+						if (die__process_unit(&alt_child, cu, conf, 0) != 0)
+							goto out_abort;
+					}
+				}
+
+				dcu->processing_alt = false;
+			}
+
 			cu->language = attr_numeric(cu_die, DW_AT_language);
 			cu->producer_clang = attr_producer_clang(cu_die);
 			cus__add(cus, cu);
@@ -4746,6 +5186,9 @@ static int cus__merge_and_process_cu(struct cus *cus, struct conf_load *conf,
 	if (cu == NULL)
 		return 0;
 
+	if (dcu)
+		dwarf_cu__prune_unreferenced_alt_pus(dcu);
+
 	/* process merged cu */
 	if (cu__recode_dwarf_types(cu) != LSK__KEEPIT)
 		goto out_abort;
@@ -4803,7 +5246,7 @@ static int cus__load_module(struct cus *cus, struct conf_load *conf,
 			cus__remove(cus, type_cu);
 	}
 
-	if (conf->force_cu_merging || cus__merging_cu(dw, elf)) {
+	if (conf->force_cu_merging || cus__merging_cu(dw, elf) || dwarf_getalt(dw) != NULL) {
 		res = cus__merge_and_process_cu(cus, conf, mod, dw, elf, filename,
 						build_id, build_id_len,
 						type_cu ? type_dcu : NULL);
diff --git a/dwarves.h b/dwarves.h
index 38fec59ca78990df..e7dc8a447bd13b5b 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -393,6 +393,25 @@ bool languages__cu_filtered(struct languages *languages, struct cu *cu, bool ver
 			continue;				\
 		else
 
+/**
+ * cu__for_each_type_dense - iterate types, tracking NULL holes
+ * @cu: struct cu instance to iterate
+ * @id: type_id_t raw table index
+ * @pos: struct tag iterator
+ * @nulls: uint32_t counter incremented for each NULL entry
+ *
+ * Like cu__for_each_type but counts NULL entries in @nulls so
+ * callers that need a dense (hole-free) index can compute it
+ * as (id - nulls).  Use this when the table index must map to
+ * a sequential output ID (e.g. BTF/CTF encoding).
+ */
+#define cu__for_each_type_dense(cu, id, pos, nulls)		\
+	for (id = 1, nulls = 0;					\
+	     id < cu->types_table.nr_entries; ++id)		\
+		if (!(pos = cu->types_table.entries[id]))	\
+			++nulls;				\
+		else
+
 /**
  * cu__for_each_struct - iterate thru all the struct tags
  * @cu: struct cu instance to iterate
@@ -949,6 +968,7 @@ struct parameter {
 	int loc_reg;
 	uint16_t type_byte_size;
 	uint8_t true_sig_type_from_types:1;
+	uint8_t true_sig_type_from_alt:1;
 	uint8_t has_const_value:1;
 	uint8_t loc_const_value:1;
 	uint8_t loc_stack:1;
diff --git a/tests/dwz_alt_file.sh b/tests/dwz_alt_file.sh
new file mode 100755
index 0000000000000000..fc94f3618d86938b
--- /dev/null
+++ b/tests/dwz_alt_file.sh
@@ -0,0 +1,204 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright © 2026 Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+#
+# Test that pahole correctly resolves types from dwz alternate debug
+# files (.gnu_debugaltlink / DW_FORM_GNU_ref_alt).
+#
+# Creates two binaries sharing common types, runs dwz in multifile
+# mode to deduplicate them into a .dwz alt file, then verifies pahole
+# can resolve the shared types.
+
+. "$(dirname "$0")/test_lib.sh"
+
+outdir=$(make_tmpdir)
+trap cleanup EXIT
+
+title_log "DWZ alternate debug file type resolution."
+
+CC=${CC:-gcc}
+if ! command -v ${CC%% *} > /dev/null 2>&1; then
+	info_log "skip: $CC not available"
+	test_skip
+fi
+
+if ! command -v dwz > /dev/null 2>&1; then
+	info_log "skip: dwz not available"
+	test_skip
+fi
+
+READELF=${READELF:-$(command -v readelf || command -v eu-readelf || true)}
+if [ -z "$READELF" ]; then
+	info_log "skip: neither readelf nor eu-readelf available"
+	test_skip
+fi
+
+cat > "$outdir/shared_types.h" << 'HEOF'
+struct shared_base {
+	int id;
+	long flags;
+	char *name;
+	void *data;
+};
+
+struct shared_nested {
+	struct shared_base base;
+	int count;
+	double value;
+	char buffer[64];
+};
+
+struct shared_list {
+	struct shared_nested item;
+	struct shared_list *next;
+	struct shared_list *prev;
+};
+
+enum shared_state {
+	STATE_INIT = 0,
+	STATE_RUNNING = 1,
+	STATE_PAUSED = 2,
+	STATE_STOPPED = 3,
+	STATE_ERROR = 4,
+};
+
+typedef unsigned long shared_handle_t;
+typedef int (*shared_callback_t)(struct shared_base *, enum shared_state);
+
+struct shared_context {
+	struct shared_base base;
+	struct shared_list *items;
+	shared_callback_t callback;
+	shared_handle_t handle;
+	enum shared_state state;
+	int refcount;
+	char description[128];
+};
+HEOF
+
+cat > "$outdir/prog1.c" << 'EOF'
+#include "shared_types.h"
+
+int lib_init(struct shared_context *ctx) {
+	ctx->state = STATE_INIT;
+	ctx->refcount = 1;
+	return 0;
+}
+
+int main(void) {
+	struct shared_context ctx = { .base = { .id = 1, .name = "prog1" } };
+	struct shared_nested item = { .count = 42, .value = 3.14 };
+	lib_init(&ctx);
+	return item.count;
+}
+EOF
+
+cat > "$outdir/prog2.c" << 'EOF'
+#include "shared_types.h"
+
+shared_handle_t prog2_work(struct shared_context *ctx) {
+	struct shared_list node = {
+		.item = { .base = { .id = 2 }, .count = 10 },
+	};
+	ctx->items = &node;
+	ctx->state = STATE_PAUSED;
+	return ctx->handle;
+}
+
+int main(void) {
+	struct shared_context ctx = { .base = { .id = 99, .name = "prog2" } };
+	return (int)prog2_work(&ctx);
+}
+EOF
+
+# Try DWARF 4 first (old dwz chokes on DWARF 5 input), then fall back
+# to default -g so we do not silently lose coverage on distros where
+# gcc defaults to DWARF 5 and dwz is too old for it.
+dwz_ok=0
+for dwarf_flag in -gdwarf-4 -g; do
+	if ! $CC $dwarf_flag -I"$outdir" -o "$outdir/prog1" "$outdir/prog1.c" 2>"$outdir/cc.log"; then
+		info_log "   compile prog1 ($dwarf_flag) failed:"
+		info_log "   $(cat "$outdir/cc.log")"
+		continue
+	fi
+
+	if ! $CC $dwarf_flag -I"$outdir" -o "$outdir/prog2" "$outdir/prog2.c" 2>"$outdir/cc.log"; then
+		info_log "   compile prog2 ($dwarf_flag) failed:"
+		info_log "   $(cat "$outdir/cc.log")"
+		continue
+	fi
+
+	if ! dwz -m "$outdir/dwz_alt" "$outdir/prog1" "$outdir/prog2" 2>/dev/null; then
+		info_log "   dwz multifile mode failed with $dwarf_flag (types too small?)"
+		continue
+	fi
+
+	if ! $READELF -p .gnu_debugaltlink "$outdir/prog1" 2>/dev/null | grep -q dwz_alt; then
+		info_log "   dwz ($dwarf_flag) did not produce .gnu_debugaltlink"
+		continue
+	fi
+
+	info_log "   dwz multifile with $dwarf_flag: ok"
+	dwz_ok=1
+	break
+done
+
+if [ "$dwz_ok" -eq 0 ]; then
+	info_log "skip: could not produce dwz alt file with any DWARF version"
+	test_skip
+fi
+
+# Verify pahole can resolve the shared type from the alt file
+if ! pahole -F dwarf -C shared_context "$outdir/prog1" 2>/dev/null | grep -q "struct shared_context {"; then
+	error_log "FAIL: pahole could not resolve shared_context from prog1"
+	test_fail
+fi
+
+if ! pahole -F dwarf -C shared_context "$outdir/prog2" 2>/dev/null | grep -q "struct shared_context {"; then
+	error_log "FAIL: pahole could not resolve shared_context from prog2"
+	test_fail
+fi
+
+# Verify member resolution (shared_base is in the alt file)
+if ! pahole -F dwarf -C shared_context "$outdir/prog1" 2>/dev/null | grep -q "shared_base"; then
+	error_log "FAIL: shared_base member not resolved in shared_context"
+	test_fail
+fi
+
+# Verify no unexpected stderr output — catches warnings, errors, and
+# any new class of dwz-related diagnostics regardless of format
+pahole -F dwarf "$outdir/prog1" >/dev/null 2>"$outdir/pahole_stderr.log"
+if test -s "$outdir/pahole_stderr.log"; then
+	error_log "FAIL: pahole produced unexpected stderr processing dwz file:"
+	error_log "$(cat "$outdir/pahole_stderr.log")"
+	test_fail
+fi
+
+# Negative test: hide the alt file and verify pahole warns exactly once
+# and does not crash.  This is the scenario users hit in the wild with
+# partially installed debuginfo packages.
+mv "$outdir/dwz_alt" "$outdir/dwz_alt.hidden"
+
+pahole -F dwarf "$outdir/prog1" >/dev/null 2>"$outdir/pahole_noalt_stderr.log"
+noalt_rc=$?
+
+mv "$outdir/dwz_alt.hidden" "$outdir/dwz_alt"
+
+if [ "$noalt_rc" -ne 0 ]; then
+	error_log "FAIL: pahole crashed (rc=$noalt_rc) with missing alt file"
+	test_fail
+fi
+
+if ! grep -q "could not resolve dwz alternate debug file" "$outdir/pahole_noalt_stderr.log"; then
+	error_log "FAIL: missing-alt warning not emitted"
+	error_log "$(cat "$outdir/pahole_noalt_stderr.log")"
+	test_fail
+fi
+
+noalt_warn_count=$(grep -c "could not resolve dwz alternate debug file" "$outdir/pahole_noalt_stderr.log")
+if [ "$noalt_warn_count" -ne 1 ]; then
+	error_log "FAIL: missing-alt warning emitted $noalt_warn_count times, expected 1"
+	test_fail
+fi
+
+test_pass
-- 
2.55.0

