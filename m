Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A994D4D2EE6;
	Wed, 29 Jul 2026 19:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352129; cv=none; b=QmtiWxbZJqVo1E0gM+J7QUIQAkyJNLZpd31FO2skqVHmA2mJuqcdl1WOJ76r/c13OHc4P9F3H36KAigzNlNteSvkpb7OziRWjY8WIvF0+1tczBqWKYT/oacqQq/2HEJF30pOylfPC+D37COXEvEVt7sfPVXeyybwG9sBLr06Adk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352129; c=relaxed/simple;
	bh=qQy6L9tz3Wd3B5A8vpaamUrY6IXKwvcseodu9tXVSN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uqE2/DIjk5d/s+DgFOBRXB0GkJEysE+EbqSpDDhWn6/EaJsH4RT1qs6fuuOXoTcSAcEPQeLTCUK2MOpELUnaoqmJO9++Y60+3W7KMs+KZ16NFk0iRHcGyCAeYvAXd/zbt+lhe03BA9Ptz8CyZHWxKawIW7rMiOnnTKD0Wt0JCZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6BQqyOp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6BQqyOp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2FD31F00A3D;
	Wed, 29 Jul 2026 19:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785352127;
	bh=A5iZtCJcavM74TkrWSEh9AncIDUUeLTOR/fa70FDcGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X6BQqyOpQDvhSVVeCShn3GzVXrOVQHqv0mKk0R6Odm89g7W1eBaIQrtSEOWMUdKxb
	 LlpX/0Hs05TG1DE+3LNIPCRGPvnI86l5qTdKFpkkEaRqUsyvRrbBIm/HGhhS1yc/n5
	 X6K0NVpRw7xEjfeielRw45pzLvS6QXZuc2rK+/B5PyG0wgWcrojHUDO/IPfmcZ/A6O
	 412ICd+U7mzho7Z/0/OSBab4YVvqNLd+ZcXwR5637t/XvIiVISgftwDNJskdX/K+JY
	 M15ecq6r18RvfyAVv2DwmgZcDXR3qPm/TVV9jYFrtDJ941c0gaGz4ZGVIh1W+lgcBy
	 yZarhspzmFigA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 30/31] btf_loader: Fix multi-dimensional array loading
Date: Wed, 29 Jul 2026 16:07:30 -0300
Message-ID: <20260729190733.72876-31-acme@kernel.org>
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

create_new_array() had a FIXME — it loaded every BTF_KIND_ARRAY as a
1D array (dimensions=1, nr_entries=[nelems]) and lost the chaining
that encodes multi-dim arrays.

BTF chains dimensions through the element type field:
  inner: ARRAY { type=int,   nelems=4 }  ← int[4]
  outer: ARRAY { type=inner, nelems=3 }  ← int[3][4]

When the outer node is loaded, the inner has already been loaded (BTF
types are processed in id order, and inner always has a lower id).
Detect this by checking whether cu__type(cu, ap->type) is a
DW_TAG_array_type, and if so, absorb its dimensions:

  array->dimensions   = inner->dimensions + 1
  array->nr_entries[] = [ap->nelems, inner->nr_entries...]
  array->tag.type     = inner->tag.type   ← skip to base element type

Note: cu__type() (types_table) must be used, not cu__tag() (tags_table);
DW_TAG_array_type entries are stored in the types table.

Before: int a[3][4] round-tripped as int a[4][3] (reversed dimensions,
        because each BTF_KIND_ARRAY was 1D and the display chain printed
        dimensions from innermost to outermost)
After:  int a[3][4] and int a[2][3][4] round-trip correctly via BTF

Fixes: 472256d3c57bef53 ("btf_loader: Introduce a loader for the BTF format")
Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 btf_loader.c        |  46 ++++++++++---
 tests/btf_arrays.sh | 158 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 194 insertions(+), 10 deletions(-)
 create mode 100755 tests/btf_arrays.sh

diff --git a/btf_loader.c b/btf_loader.c
index 5857c3b6d2fc4b2b..66ffd1a0b5ad73a3 100644
--- a/btf_loader.c
+++ b/btf_loader.c
@@ -200,20 +200,46 @@ static int create_new_array(struct cu *cu, const struct btf_type *tp, uint32_t i
 	if (array == NULL)
 		return -ENOMEM;
 
-	/* FIXME: where to get the number of dimensions?
-	 * it it flattened? */
-	array->dimensions = 1;
-	array->nr_entries = malloc(sizeof(uint32_t));
+	/*
+	 * BTF encodes each dimension of a multi-dimensional array as a
+	 * separate BTF_KIND_ARRAY node chained via the element type field.
+	 * For example, int a[3][4] becomes:
+	 *   inner: BTF_KIND_ARRAY { type=int,   nelems=4 }
+	 *   outer: BTF_KIND_ARRAY { type=inner, nelems=3 }
+	 *
+	 * Reconstruct the pahole multi-dim representation (one array_type
+	 * with dimensions[] and nr_entries[]) by absorbing any inner
+	 * BTF_KIND_ARRAY that was already loaded.
+	 */
+	struct tag *elem_tag = cu__type(cu, ap->type);
 
-	if (array->nr_entries == NULL) {
-		free(array);
-		return -ENOMEM;
+	if (elem_tag && elem_tag->tag == DW_TAG_array_type &&
+	    tag__array_type(elem_tag)->dimensions < UINT8_MAX) {
+		struct array_type *inner = tag__array_type(elem_tag);
+
+		array->dimensions = inner->dimensions + 1;
+		array->nr_entries = malloc(array->dimensions * sizeof(uint32_t));
+		if (array->nr_entries == NULL) {
+			free(array);
+			return -ENOMEM;
+		}
+		array->nr_entries[0] = ap->nelems;
+		memcpy(&array->nr_entries[1], inner->nr_entries,
+		       inner->dimensions * sizeof(uint32_t));
+		/* point directly to the base element type, skipping the inner array node */
+		array->tag.type = inner->tag.type;
+	} else {
+		array->dimensions = 1;
+		array->nr_entries = malloc(sizeof(uint32_t));
+		if (array->nr_entries == NULL) {
+			free(array);
+			return -ENOMEM;
+		}
+		array->nr_entries[0] = ap->nelems;
+		array->tag.type = ap->type;
 	}
 
-	array->nr_entries[0] = ap->nelems;
 	array->tag.tag = DW_TAG_array_type;
-	array->tag.type = ap->type;
-
 	cu__add_tag_with_id(cu, &array->tag, id);
 
 	return 0;
diff --git a/tests/btf_arrays.sh b/tests/btf_arrays.sh
new file mode 100755
index 0000000000000000..42979156b24c041c
--- /dev/null
+++ b/tests/btf_arrays.sh
@@ -0,0 +1,158 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright © 2026 Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+#
+# Test BTF multi-dimensional array encoding and loading round-trip.
+#
+# BTF represents each dimension of a multi-dimensional array as a separate
+# chained BTF_KIND_ARRAY node.  For int a[3][4]:
+#   inner: ARRAY { type=int,   nelems=4 }
+#   outer: ARRAY { type=inner, nelems=3 }
+#
+# The encoder (btf_encoder.c) must emit one BTF_KIND_ARRAY per dimension,
+# from innermost to outermost.  The loader (btf_loader.c) must collapse
+# the chain back into pahole's flat multi-dim array_type.
+#
+# Tests:
+#  1. BTF dump has the right number of chained ARRAY nodes for each dim
+#  2. pahole -F btf output matches DWARF output for all array members
+#  3. Array sizes are preserved across the encode→load round-trip
+
+. "$(dirname "$0")/test_lib.sh"
+
+outdir=$(make_tmpdir)
+trap cleanup EXIT
+
+title_log "BTF multi-dimensional array encoding and round-trip."
+
+CC=${CC:-gcc}
+if ! command -v ${CC%% *} > /dev/null 2>&1; then
+	info_log "skip: $CC not available"
+	test_skip
+fi
+
+if ! command -v bpftool > /dev/null 2>&1; then
+	info_log "skip: bpftool not available"
+	test_skip
+fi
+
+src=$(make_tmpsrc)
+obj=$(make_tmpobj)
+
+cat > "$src" << 'EOF'
+struct multidim {
+	int a1d[5];
+	int a2d[3][4];
+	int a3d[2][3][4];
+	char s[8];
+};
+
+struct multidim g;
+EOF
+
+$CC -g -c -o "$obj" "$src" 2>/dev/null
+if [ $? -ne 0 ]; then
+	error_log "FAIL: compilation failed"
+	test_fail
+fi
+
+# --- BTF encoding ---
+
+btf="$outdir/arrays.btf"
+pahole --btf_encode_detached="$btf" "$obj" 2>/dev/null
+if [ $? -ne 0 ] || [ ! -s "$btf" ]; then
+	error_log "FAIL: pahole --btf_encode_detached failed"
+	test_fail
+fi
+
+dump=$(bpftool btf dump file "$btf" 2>/dev/null)
+if [ -z "$dump" ]; then
+	error_log "FAIL: bpftool btf dump produced no output"
+	test_fail
+fi
+
+# --- Check 1: chained ARRAY nodes for int[3][4] ---
+# After btf__dedup the chain int[4] → int[3][4] must be present.
+
+inner4_id=$(echo "$dump" | grep "ARRAY.*nr_elems=4" | head -1 | sed 's/\[\([0-9]*\)\].*/\1/')
+if [ -z "$inner4_id" ]; then
+	error_log "FAIL: no ARRAY with nr_elems=4 found for int[3][4] inner dim"
+	test_fail
+fi
+info_log "inner ARRAY nr_elems=4 at type_id=$inner4_id: ok"
+
+# There must be an ARRAY referencing inner4_id with nr_elems=3 (outer of int[3][4])
+if ! echo "$dump" | grep -q "ARRAY.*type_id=${inner4_id}.*nr_elems=3"; then
+	error_log "FAIL: no outer ARRAY(type=${inner4_id}, nr_elems=3) for int[3][4]"
+	test_fail
+fi
+info_log "outer ARRAY nr_elems=3 referencing inner: ok"
+
+# --- Check 2: struct member type_ids must differ between a2d and a3d ---
+# If they were the same, a3d would not add the extra outer dimension.
+
+a2d_type=$(echo "$dump" | grep "'a2d'" | sed "s/.*type_id=\([0-9]*\).*/\1/")
+a3d_type=$(echo "$dump" | grep "'a3d'" | sed "s/.*type_id=\([0-9]*\).*/\1/")
+
+if [ -z "$a2d_type" ] || [ -z "$a3d_type" ]; then
+	error_log "FAIL: could not extract type_ids for a2d ($a2d_type) or a3d ($a3d_type)"
+	test_fail
+fi
+if [ "$a2d_type" = "$a3d_type" ]; then
+	error_log "FAIL: a2d and a3d share the same type_id ($a2d_type); a3d not encoded with extra dim"
+	test_fail
+fi
+info_log "a2d type_id=$a2d_type, a3d type_id=$a3d_type (distinct): ok"
+
+# --- Check 3: round-trip via pahole -F btf ---
+# In-place encoding then reload via BTF frontend must match DWARF output.
+
+pahole -J "$obj" 2>/dev/null
+if [ $? -ne 0 ]; then
+	error_log "FAIL: pahole -J in-place encoding failed"
+	test_fail
+fi
+
+btf_out=$(pahole -F btf -C multidim "$obj" 2>/dev/null)
+
+if [ -z "$btf_out" ]; then
+	error_log "FAIL: pahole -F btf -C multidim produced no output"
+	test_fail
+fi
+
+# 1D array preserved
+if ! echo "$btf_out" | grep -q "a1d\[5\]"; then
+	error_log "FAIL: round-trip: a1d[5] not found in BTF output"
+	test_fail
+fi
+info_log "a1d[5] preserved: ok"
+
+# 2D array — exact dimension order must match DWARF
+if ! echo "$btf_out" | grep -q "a2d\[3\]\[4\]"; then
+	error_log "FAIL: round-trip: a2d[3][4] not found in BTF output"
+	test_fail
+fi
+info_log "a2d[3][4] preserved: ok"
+
+# 3D array — exact dimension order must match DWARF
+if ! echo "$btf_out" | grep -q "a3d\[2\]\[3\]\[4\]"; then
+	error_log "FAIL: round-trip: a3d[2][3][4] not found in BTF output"
+	test_fail
+fi
+info_log "a3d[2][3][4] preserved: ok"
+
+# char array preserved
+if ! echo "$btf_out" | grep -q "s\[8\]"; then
+	error_log "FAIL: round-trip: s[8] not found in BTF output"
+	test_fail
+fi
+info_log "s[8] preserved: ok"
+
+# --- Check 4: struct size preserved ---
+if ! echo "$btf_out" | grep -q "size: 172"; then
+	error_log "FAIL: struct multidim size=172 not preserved after BTF round-trip"
+	test_fail
+fi
+info_log "struct multidim size=172 preserved: ok"
+
+test_pass
-- 
2.55.0

