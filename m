Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE5C463B60;
	Wed, 29 Jul 2026 19:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352064; cv=none; b=fUQXH46oZc4OvOcyyElhDpePYlKVWBOxnshuulZ5b6S86khgV0Ho4SAmME9cUS7lbWS7xY74zf8NThlZt8owW+jAOCX53BlFs1ksiQpnGsmX3XIqeCMJJJwcbZ81bA1g+l/2oeA3/I6JjhqnWH+xU52jmsSbyUG+t7ugpDUySj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352064; c=relaxed/simple;
	bh=97bUZvdU8nQyXWaUrlll4w2M0BevpnWnQRUPn4m1ZdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O86AExfsb7sNVCryZt9qNGtUI3U8iul5LbHWaTj7uT8viu1M0fN7ZQfarvDWqYmIW6iRH7Ez/AN9ARIEBD3vjiYs1mmGNMFMArCWdVWiWT2dIGYTob3BJCDXcmaCgnRP7NQlGQAuwGD1cM/ANOqULlXha1fu3k/0BQscTxqONhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJKN7fk0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJKN7fk0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A071F00A3A;
	Wed, 29 Jul 2026 19:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785352063;
	bh=PUr2Zla+Q4G+OZ2VlhtLuWWT7AAwHZPc1/vWy/qJKDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eJKN7fk0T22UD/TY/wFnN4Ar7Pn/Dg5Doqpd3qOFB6BvLb2RUa5IKq/6pRL6H/lfT
	 OfNgxc14b+/hDhlRvbCaxB1aQ53W7uYGSoK9/mLo/1M27Db3wLpOIci6RavWnUgKs0
	 tLYoS61lp0jWG0Z6DF/1sTKZOiAB++Efe75r6gWcKS592sbZjUGlvEdEvb5ZPtzZB6
	 Rrl7qqv26IcCyFWXI9Pok/JiTLD+u/j/KEssnRV8pobtE/5NKsT5B+oOnsmzrThtiw
	 GPZHe52WpCMSg89JbgKgYsTZErKZTl4iW14ZhVkQM7pz4fpL0ilnl0m8A7zNUxLfHm
	 aL/6rcZRV5N2w==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 02/31] Fix -Wsign-compare warnings across the codebase
Date: Wed, 29 Jul 2026 16:07:02 -0300
Message-ID: <20260729190733.72876-3-acme@kernel.org>
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

Fix all 15 signed/unsigned comparison warnings triggered by
-Wsign-compare:

  pahole.c: use size_t for ARRAY_SIZE() loop iterators in
  init_btf_features(), find_btf_feature(),
  show_supported_btf_features() and btf_features__enable_default(),
  moving declarations into the for statements.

  btf_encoder.c: use size_t for ARRAY_SIZE() loops in
  should_skip_decl() and btf_encoder__should_skip_kfunc(), use
  size_t for the offset in is_sym_kfunc_set(), and unsigned int
  for the loop counter matching ranges_cnt.

  btf_loader.c: cast bitfield arithmetic to size_t in ternary
  where the other branch is pos->byte_size (size_t).

  dwarf_loader.c: cast int8_t bitfield_offset to uint32_t before
  comparing against uint32_t bit_size — by this point the value
  has already been corrected to non-negative.

  dwarves.c: use uint16_t for byte_hole_size to match the int
  hole field it compares against, and add an id >= 0 guard before
  the ARRAY_SIZE() comparison in lang__int2str().

  dwarves_fprintf.c: use uint64_t for loop variable matching
  attributes->cnt type.

  dwarves_reorganize.c: use int for remainder/inc (bounded by
  addr_size), and cast byte_size comparison to size_t where the
  hole value is known non-negative.

Fixes: 7bc9b9975545ab53 ("pahole: Add --btf_features support")
Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 btf_encoder.c        | 12 +++++-------
 btf_loader.c         |  2 +-
 dwarf_loader.c       |  2 +-
 dwarves.c            |  4 ++--
 dwarves_fprintf.c    |  3 +--
 dwarves_reorganize.c |  6 +++---
 pahole.c             | 14 ++++----------
 7 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 993a61cf320c6d92..9f8cd279fa92af1c 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1211,14 +1211,13 @@ static struct btf_encoder_func_state *btf_encoder__alloc_func_state(struct btf_e
 	return state;
 }
 
-static bool str_contains_suffix(const char *str, const char * const *suffixes, int nr_suffixes)
+static bool str_contains_suffix(const char *str, const char * const *suffixes, size_t nr_suffixes)
 {
 	const char *suffix = strchr(str, '.');
-	int i;
 
 	if (!suffix)
 		return false;
-	for (i = 0; i < nr_suffixes; i++) {
+	for (size_t i = 0; i < nr_suffixes; i++) {
 		if (strstr(suffix, suffixes[i]))
 			return true;
 	}
@@ -2087,7 +2086,7 @@ static int is_sym_kfunc_set(GElf_Sym *sym, const char *name, Elf_Data *idlist, s
 {
 	void *ptr = idlist->d_buf;
 	struct btf_id_set8 *set;
-	int off;
+	size_t off;
 
 	/* kfuncs are only found in BTF_SET8's */
 	if (!strstarts(name, BTF_ID_SET8_PFX))
@@ -2282,7 +2281,7 @@ static int btf_encoder__collect_kfuncs(struct btf_encoder *encoder)
 		ptrdiff_t off;
 		GElf_Sym sym;
 		bool found;
-		int j;
+		unsigned int j;
 
 		if (!gelf_getsym(symbols, i, &sym)) {
 			elf_error("Failed to get ELF symbol(%d)", i);
@@ -2568,12 +2567,11 @@ static bool filter_variable_name(const char *name)
 		X("__func_stack_frame_non_standard_")
 		#undef X
 	};
-	int i;
 
 	if (*name != '_')
 		return false;
 
-	for (i = 0; i < ARRAY_SIZE(skip); i++) {
+	for (size_t i = 0; i < ARRAY_SIZE(skip); i++) {
 		if (strncmp(name, skip[i].s, skip[i].len) == 0)
 			return true;
 	}
diff --git a/btf_loader.c b/btf_loader.c
index 92d4832c47af21a0..caead39775da54da 100644
--- a/btf_loader.c
+++ b/btf_loader.c
@@ -744,7 +744,7 @@ static int class__fixup_btf_bitfields(const struct conf_load *conf, struct tag *
 		 */
 		smallest_offset = pos->byte_offset;
 		smallest_offset += pos->bitfield_size ?
-			(pos->bitfield_offset + pos->bitfield_size + 7) / 8 :
+			(size_t)(pos->bitfield_offset + pos->bitfield_size + 7) / 8 :
 			pos->byte_size;
 	}
 
diff --git a/dwarf_loader.c b/dwarf_loader.c
index a4cd91178bccde99..14c90080f538e10d 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -3786,7 +3786,7 @@ static int class_member__cache_byte_size(struct tag *tag, struct cu *cu,
 	/* align on underlying base type natural alignment boundary */
 	member->bitfield_offset += (member->byte_offset % member->byte_size) * 8;
 	member->byte_offset = member->bit_offset / member->bit_size * member->bit_size / 8;
-	if (member->bitfield_offset >= member->bit_size) {
+	if ((uint32_t)member->bitfield_offset >= member->bit_size) {
 		member->bitfield_offset -= member->bit_size;
 		member->byte_offset += member->byte_size;
 	}
diff --git a/dwarves.c b/dwarves.c
index ef93239d26827711..f05c4d3b4b669335 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -1577,7 +1577,7 @@ const struct class_member *class__find_bit_hole(const struct class *class,
 						const uint16_t bit_hole_size)
 {
 	struct class_member *pos;
-	const size_t byte_hole_size = bit_hole_size / 8;
+	const uint16_t byte_hole_size = bit_hole_size / 8;
 
 	type__for_each_data_member(&class->type, pos)
 		if (pos == trailer)
@@ -2449,7 +2449,7 @@ const char *lang__int2str(int id)
 {
 	const char *lang = NULL;
 
-	if (id < ARRAY_SIZE(languages))
+	if (id >= 0 && (size_t)id < ARRAY_SIZE(languages))
 		lang = languages[id];
 	else if (id == DW_LANG_Mips_Assembler)
 		return "asm";
diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
index ab1c381db64651c6..e44ac05c3b9e7e73 100644
--- a/dwarves_fprintf.c
+++ b/dwarves_fprintf.c
@@ -1206,10 +1206,9 @@ const char *function__prototype(const struct function *func,
 static size_t tag__attributes_fprintf(const struct tag *tag, FILE *fp)
 {
 	size_t printed = 0;
-	int i;
 
 	if (tag->attributes)
-		for (i = 0; i < tag->attributes->cnt; ++i)
+		for (uint64_t i = 0; i < tag->attributes->cnt; ++i)
 			printed += fprintf(fp, "%s ", tag->attributes->values[i]);
 
 	return printed;
diff --git a/dwarves_reorganize.c b/dwarves_reorganize.c
index 14f5e8228fa8a95d..50652fefcf14cbb2 100644
--- a/dwarves_reorganize.c
+++ b/dwarves_reorganize.c
@@ -82,7 +82,7 @@ void class__fixup_alignment(struct class *class, const struct cu *cu)
 			class->type.size -= dec;
 			class__subtract_offsets_from(class, pos, dec);
 		} else for (power2 = cu->addr_size; power2 >= 2; power2 /= 2) {
-			const size_t remainder = pos->byte_offset % power2;
+			const int remainder = pos->byte_offset % power2;
 
 			if (pos->byte_size == power2) {
 				if (remainder == 0) /* perfectly aligned */
@@ -95,7 +95,7 @@ void class__fixup_alignment(struct class *class, const struct cu *cu)
 					pos->bit_offset -= remainder * 8;
 					class__subtract_offsets_from(class, pos, remainder);
 				} else {
-					const size_t inc = power2 - remainder;
+					const int inc = power2 - remainder;
 
 					if (last_member->hole == 0)
 						++class->nr_holes;
@@ -811,7 +811,7 @@ restart:
 			if (class->padding > 0 &&
 			    member != last_member &&
 			    last_member->byte_size != 0 &&
-			    last_member->byte_size <= member->hole) {
+			    last_member->byte_size <= (size_t)member->hole) {
 				if (class__move_member(class, member, last_member, cu, 1, verbose, fp))
 					goto restart;
 			}
diff --git a/pahole.c b/pahole.c
index 033baedcc602cc75..390d5f2dd20e4dfd 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1249,8 +1249,6 @@ bool set_btf_features_initial;
 
 static void init_btf_features(void)
 {
-	int i;
-
 	/* Only set initial values once, as multiple --btf_features=
 	 * may be specified on command-line, and setting values
 	 * again could clobber values.   The aim is to enable
@@ -1258,16 +1256,14 @@ static void init_btf_features(void)
 	 */
 	if (set_btf_features_initial)
 		return;
-	for (i = 0; i < ARRAY_SIZE(btf_features); i++)
+	for (size_t i = 0; i < ARRAY_SIZE(btf_features); i++)
 		*btf_features[i].conf_value = btf_features[i].initial_value;
 	set_btf_features_initial = true;
 }
 
 static struct btf_feature *find_btf_feature(char *name)
 {
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(btf_features); i++) {
+	for (size_t i = 0; i < ARRAY_SIZE(btf_features); i++) {
 		if (strcmp(name, btf_features[i].name) == 0)
 			return &btf_features[i];
 	}
@@ -1285,9 +1281,7 @@ static void enable_btf_feature(struct btf_feature *feature)
 
 static void show_supported_btf_features(FILE *output)
 {
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(btf_features); i++) {
+	for (size_t i = 0; i < ARRAY_SIZE(btf_features); i++) {
 		if (btf_features[i].feature_check && !btf_features[i].feature_check())
 			continue;
 		if (i > 0)
@@ -1299,7 +1293,7 @@ static void show_supported_btf_features(FILE *output)
 
 static void btf_features__enable_default(void)
 {
-	for (int i = 0; i < ARRAY_SIZE(btf_features); i++) {
+	for (size_t i = 0; i < ARRAY_SIZE(btf_features); i++) {
 		if (btf_features[i].default_enabled)
 			enable_btf_feature(&btf_features[i]);
 	}
-- 
2.55.0

