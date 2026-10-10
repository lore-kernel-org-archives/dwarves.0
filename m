Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2D31A724C
	for <dwarves@vger.kernel.org>; Sat, 10 Oct 2026 00:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791593557; cv=none; b=qQ2oCdXEiWeqbfUCtZ/mTEK3r8qjBHFVi0ScDgiGVz5+Zr/wZNbAvEqnEywtyjDZADaLvLWec4RplJrH/y74RDxc781znydfuyM9S/zkazDApUGZwo3aoob/p/wHiZkUNGC5t3vj4OJQWdyASk3zaquC1ooDjRwNRQAMKAkzueU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791593557; c=relaxed/simple;
	bh=hm4bF6UTpInUG6tKa2h6eAFUkcFgdtBnKfgaoaSDPy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVm/CiNJf0p2tSMVtDj+FkeyIuNDa5X02+cD8uBn8jiKJd1BU8PH7oLDo/VP+2rpuCSPw76dzH7HQGkVi3boQItE4orwa/m7/lJgt9NbXB5b4ooCkB9SsMuUTCVKdhhKPwvJr0icXIVncEfOEKit/OhcC5VozB4hN0K0ilX7Fao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alanderk.com; spf=pass smtp.mailfrom=alanderk.com; dkim=pass (2048-bit key) header.d=alanderk.com header.i=@alanderk.com header.b=KN2rBOdV; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alanderk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alanderk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alanderk.com header.i=@alanderk.com header.b="KN2rBOdV"
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-39569e136f9so61302a91.0
        for <dwarves@vger.kernel.org>; Fri, 09 Oct 2026 17:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=alanderk.com; s=googol; t=1791593555; x=1792198355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V/AM8O9CHJtX62I5NgY34KmbH4WPnu861vwy2c/kGu4=;
        b=KN2rBOdVYSLb8NiEyk+tsvgv//sQOR184XKV9y5FYbskQ8a4UMRhccNu0AnyVzCxN6
         lCL4qL201jDRZVfwNxA6u3ePAhBLwNK1tPfXJfr37xxP0IuxqJnrMO8lyh2LAqeqPmzy
         XtKQczvYPT1ksWY3YDCnWiMY3Z0tQDUzNYo7jh7l2R/13ie72Za1vWqkB8a1ffUU+3RK
         TNs9VRpMWMZaGBnxXEfDr46cd8YMjri7udhvenegFZQMmx4XlLLOn7WBVUNONjkXZAF/
         qUs+0Xo9qa+b+4KNGv8Z1VpJkebRawizwTeKoO4jH6rWDJGGBb7q3I6HfuEXold7lz9T
         f2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791593555; x=1792198355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V/AM8O9CHJtX62I5NgY34KmbH4WPnu861vwy2c/kGu4=;
        b=Pf5b1VsFdhw+vbemczUOJvqvFuO2uwnwSt3CekaT5zGUxd/v+ALgU4lJRzdlNGoOAi
         tZ3h46823ZK1wSABVBsuMVtoT2CbMT0dTJr0z9pDE3Ktlkli3s3oLSgrd2WNB4HLe2PJ
         po1vEB9+a7ALlHmF53+073RqTAk9N3rITokq7oS4N0qfw4sMs/fTeFTW1heEGQ58iV0s
         WgylGV1oAt4B54UQYBihUVmmiVVmWgh4OtwEnWQNo6KPyewNDIUj0hv7CK4JwyYr/nrA
         MohoGLtBY95yK/rrOhYu5oJj/CSrB5PqkT7y48gmXzp5YqLvbl/hwbkliI9SgfAMQ3nx
         LZcA==
X-Gm-Message-State: AFq9FYJNR5jAgfauN/xbwo30fHpwUUvi/siNpYch0Z7uMtYtpnC6nou8
	j/kY5S4B7dqIjN2MkkBmNch2AcuP+VsPRB5uHvfpWntjQy+IJgUAmeA//j4q6HrI57A=
X-Gm-Gg: AYBFou35x/eSSsUGBZFTeLBfNDDkMcMxVJ3/4iUcNLI2BStgz82SW+49xl+W4pG1nd6
	fB9mMH9+RknGe9z8XgE3+eOJ2FsZvMRslVqLGPaNJdJr6v34wCG2E6gq10XEvrBozNErigoGPqr
	trF7Y2EgxIe5H5lB60MeBuMtBZDG0mGdh0iX3DxwAzsSyDMLDH8Kla92qxGlLd5zS+ewBhot5Vq
	yUPai9/ZdgsZJ+k6dA0G3IJF1u2smAt0R0PjZThsWgI6x2IpC74iM1J6ebN0pb5KyrVuM+uyyQV
	n9Ycb4+7bcEeSeUEyUtRgoNbOII5WmMQRx6DmXC72MrAPFSvfHk6nyfiZQjCASZqDZucrFlJz3e
	5t1prRygfPIaGAxGKrjsHIF9zcU51Ui6BK1u/3+xgo4hJ6hbsSUeqGG66eFEBtM1gOXW7sQF1bx
	86yXmj48hBaS8fi50CVZtD2PDRDxjvWZltBNiVAbPj/fmCU1HYDcPLobdGZ4oedD3TdPe4cEKmE
	DH2wvN6s+qaY399AUHkwHLYiw1wbPaRkg==
X-Received: by 2002:a17:90b:224c:b0:3a6:f1d2:57f8 with SMTP id 98e67ed59e1d1-3ab3a23c95bmr3158692a91.2.1791593555370;
        Fri, 09 Oct 2026 17:52:35 -0700 (PDT)
Received: from macmini4.tapir-palermo.ts.net ([138.199.43.94])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab50ce9d98sm4078226a91.9.2026.10.09.17.52.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 09 Oct 2026 17:52:34 -0700 (PDT)
From: Alan Derk <linux@alanderk.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>
Cc: dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH dwarves v2 2/2] dwarf_loader: Load types that kept CUs use from excluded CUs
Date: Sat, 10 Oct 2026 00:52:27 +0000
Message-ID: <20261010005227.976-3-linux@alanderk.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261010005227.976-1-linux@alanderk.com>
References: <20261010005227.976-1-linux@alanderk.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With clang LTO, LLVM emits a type such as int once, in the first CU
that uses it, and other CUs refer to it with DW_FORM_ref_addr. Since
commit b98565e7b17ec24d ("dwarf_loader: Honour --lang_exclude when
merging LTO built CUs") the DIEs of the CUs that --lang_exclude filters
out are skipped when merging, so a kept CU that uses a type from one of
them is left with a dangling reference. Members that use such a type
end up typed void: pahole crashes printing them, and -J encodes them
with type_id 0 and exits 0.

  $ head zero.c first.cpp second.c
  ==> zero.c <==
  char zero_c;

  ==> first.cpp <==
  int cpp_int;

  ==> second.c <==
  struct c_only { int b; } c_var;
  $ clang -flto -g -c zero.c second.c; clang++ -flto -g -c first.cpp
  $ clang -flto -fuse-ld=lld -shared -o three.so zero.o first.o second.o
  $ pahole --lang_exclude=c++14 three.so
  namespace__recode_dwarf_types: couldn't find 0x57 type for 0x8a (member)!
  struct c_only {
  	<ERROR(__class__fprintf:1838): 0 not found!>
  Segmentation fault

Remember the offsets of the CUs that the filter skips, and when a type
lookup misses an offset in one of them, load that DIE if it is a type.
The types it refers to are looked up when it is recoded, so they are
loaded too. As this adds types while recoding, cu__recode_dwarf_types()
now repeats its passes until no new tags show up.

After:

  $ pahole --lang_exclude=c++14 three.so
  struct c_only {
  	int                        b;                    /*     0     4 */
  ...

Only types are loaded. References to functions and variables in
excluded CUs, such as the abstract origin of a function inlined across
CUs or the function that a C++ using declaration names, still print
"couldn't find", as loading them would add functions in the excluded
language to the output. A nested C++ type that a kept CU refers to
directly is loaded as a top-level type.

Without --lang_exclude, or when no kept CU refers to an excluded one,
nothing is loaded and the output does not change.

Add tests/lang_exclude_lto_refs.sh for this.

Tested with clang 21 full LTO and ThinLTO builds of a C++/C program
in both link orders. Only base types (int, char, long) were loaded, and
apart from the order of the types the output matches that of the other
link order: text and BTF with C++ excluded, text with C excluded. Two
C++ objects built with -std=c++11 and -std=c++17 that include <cstdio>
give the same text with c++11 excluded in either order; there the C
library types they share, such as FILE, are loaded too. ASan reports no
errors on these apart from a leak with -J that predates this series.
gcc 16 LTO, Rust+C ThinLTO and Debian debuginfo processed by dwz load
nothing and do not change, and neither does the BTF of 7.2.9 x86_64 and
arm64 ThinLTO kernels with Rust enabled.

Fixes: b98565e7b17ec24d ("dwarf_loader: Honour --lang_exclude when merging LTO built CUs")
Assisted-by: LLM
Signed-off-by: Alan Derk <linux@alanderk.com>
---
 dwarf_loader.c                 | 95 +++++++++++++++++++++++++++++++---
 tests/lang_exclude_lto_refs.sh | 76 +++++++++++++++++++++++++++
 2 files changed, 164 insertions(+), 7 deletions(-)
 create mode 100755 tests/lang_exclude_lto_refs.sh

diff --git a/dwarf_loader.c b/dwarf_loader.c
index fbed36e..10ab37a 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -169,6 +169,11 @@ struct alt_pu {
 	bool	  hit;		/* referenced by main CUs? */
 };
 
+struct excluded_cu {
+	Dwarf_Off start;
+	Dwarf_Off end;
+};
+
 struct dwarf_cu {
 	struct hlist_head *hash_tags;	/* tags (functions, etc.) keyed by DWARF offset */
 	struct hlist_head *hash_types;	/* types keyed by DWARF offset */
@@ -183,6 +188,10 @@ struct dwarf_cu {
 	uint32_t  nr_alt_pus;
 	uint32_t  allocated_alt_pus;
 	bool	  processing_alt;	/* true while processing alt-file DIEs */
+	struct excluded_cu *excluded_cus;	/* skipped by early_cu_filter when merging */
+	uint32_t  nr_excluded_cus;
+	Dwarf	  *dw;
+	struct conf_load *conf;
 };
 
 static int dwarf_cu__init(struct dwarf_cu *dcu, struct cu *cu)
@@ -215,6 +224,8 @@ static int dwarf_cu__init(struct dwarf_cu *dcu, struct cu *cu)
 	dcu->alt_pus = NULL;
 	dcu->nr_alt_pus = 0;
 	dcu->allocated_alt_pus = 0;
+	dcu->excluded_cus = NULL;
+	dcu->nr_excluded_cus = 0;
 	/*
 	 * processing_alt is per-merged-CU state, not thread-safe.
 	 * The merged-CU path (cus__merge_and_process_cu) is
@@ -249,6 +260,7 @@ static void dwarf_cu__delete(struct cu *cu)
 
 	zfree(&dcu->imported_units);
 	zfree(&dcu->alt_pus);
+	zfree(&dcu->excluded_cus);
 	if (dcu->alt) {
 		cu__free(cu, dcu->alt->hash_tags);
 		cu__free(cu, dcu->alt->hash_types);
@@ -475,6 +487,8 @@ static struct dwarf_tag *__dwarf_cu__find_tag_by_ref(const struct dwarf_cu *cu,
 				    dtag->from_types_section.field, \
 				    dtag->from_alt.field)
 
+static struct dwarf_tag *dwarf_cu__load_excluded_type(struct dwarf_cu *dcu, Dwarf_Off ref);
+
 /* Same as __dwarf_cu__find_tag_by_ref but for type lookups (hash_types). */
 static struct dwarf_tag *__dwarf_cu__find_type_by_ref(struct dwarf_cu *dcu,
 						      const Dwarf_Off ref,
@@ -497,6 +511,8 @@ static struct dwarf_tag *__dwarf_cu__find_type_by_ref(struct dwarf_cu *dcu,
 
 	struct dwarf_tag *dtag = hashtags__find(dcu->hash_types, ref);
 
+	if (dtag == NULL)
+		dtag = dwarf_cu__load_excluded_type(dcu, ref);
 	if (dtag)
 		dcu->last_type_lookup = dtag;
 
@@ -3693,6 +3709,62 @@ static int die__process_unit(Dwarf_Die *die, struct cu *cu, struct conf_load *co
 	return 0;
 }
 
+static int dwarf_cu__add_excluded_cu(struct dwarf_cu *dcu, Dwarf_Off start, Dwarf_Off end)
+{
+	struct excluded_cu *cus = realloc(dcu->excluded_cus,
+					  (dcu->nr_excluded_cus + 1) * sizeof(*cus));
+
+	if (cus == NULL)
+		return -ENOMEM;
+
+	cus[dcu->nr_excluded_cus++] = (struct excluded_cu){ .start = start, .end = end };
+	dcu->excluded_cus = cus;
+	return 0;
+}
+
+static bool dwarf_cu__in_excluded_cu(const struct dwarf_cu *dcu, Dwarf_Off offset)
+{
+	for (uint32_t i = 0; i < dcu->nr_excluded_cus; i++)
+		if (offset >= dcu->excluded_cus[i].start && offset < dcu->excluded_cus[i].end)
+			return true;
+	return false;
+}
+
+/*
+ * With LTO, LLVM emits a type such as int once, in the first CU that uses it,
+ * and other CUs refer to it with DW_FORM_ref_addr. So the CUs kept when merging
+ * can refer to types in CUs that early_cu_filter excluded. Load those types
+ * when they are looked up, and nothing else from the excluded CUs.
+ */
+static struct dwarf_tag *dwarf_cu__load_excluded_type(struct dwarf_cu *dcu, Dwarf_Off ref)
+{
+	struct tag *tag, die_tag = {};
+	uint32_t id = 0;
+	Dwarf_Die die;
+
+	if (!dwarf_cu__in_excluded_cu(dcu, ref) || dwarf_offdie(dcu->dw, ref, &die) == NULL)
+		return NULL;
+
+	/*
+	 * A using declaration can name a function, and processing a function
+	 * adds its parameters to the CU's tables, so check the tag first.
+	 */
+	die_tag.tag = dwarf_tag(&die);
+	if (!tag__is_tag_type(&die_tag))
+		return NULL;
+
+	tag = die__process_tag(&die, dcu->cu, 1, dcu->conf);
+	if (tag == NULL || tag == &unsupported_tag)
+		return NULL;
+
+	/* As in die__process_unit(). */
+	if (tag->tag != DW_TAG_unspecified_type)
+		cu__add_tag(dcu->cu, tag, &id);
+	cu__hash(dcu->cu, tag);
+	tag__dwarf(tag)->small_id = id;
+	return tag__dwarf(tag);
+}
+
 static void ftype__recode_dwarf_types(struct tag *tag, struct cu *cu);
 
 static int namespace__recode_dwarf_types(struct tag *tag, struct cu *cu)
@@ -4497,10 +4569,10 @@ static int cu__resolve_func_ret_types_optimized(struct cu *cu, struct conf_load
 
 static int cu__recode_dwarf_types_table(struct cu *cu,
 					struct ptr_table *pt,
-					uint32_t i)
+					uint32_t *i)
 {
-	for (; i < pt->nr_entries; ++i) {
-		struct tag *tag = pt->entries[i];
+	for (; *i < pt->nr_entries; ++*i) {
+		struct tag *tag = pt->entries[*i];
 
 		if (tag != NULL) /* void, see cu__new */
 			if (tag__recode_dwarf_type(tag, cu))
@@ -4512,10 +4584,15 @@ static int cu__recode_dwarf_types_table(struct cu *cu,
 
 static int cu__recode_dwarf_types(struct cu *cu)
 {
-	if (cu__recode_dwarf_types_table(cu, &cu->types_table, 1) ||
-	    cu__recode_dwarf_types_table(cu, &cu->tags_table, 0) ||
-	    cu__recode_dwarf_types_table(cu, &cu->functions_table, 0))
-		return -1;
+	uint32_t types = 1, tags = 0, functions = 0;
+
+	/* Recoding can add tags, see dwarf_cu__load_excluded_type(). */
+	do {
+		if (cu__recode_dwarf_types_table(cu, &cu->types_table, &types) ||
+		    cu__recode_dwarf_types_table(cu, &cu->tags_table, &tags) ||
+		    cu__recode_dwarf_types_table(cu, &cu->functions_table, &functions))
+			return -1;
+	} while (types < cu->types_table.nr_entries || tags < cu->tags_table.nr_entries);
 	return 0;
 }
 
@@ -5366,6 +5443,8 @@ static int cus__merge_and_process_cu(struct cus *cus, struct conf_load *conf,
 
 			dcu->cu = cu;
 			dcu->type_unit = type_dcu;
+			dcu->dw = dw;
+			dcu->conf = conf;
 			cu->priv = dcu;
 			cu->dfops = &dwarf__ops;
 
@@ -5451,6 +5530,8 @@ static int cus__merge_and_process_cu(struct cus *cus, struct conf_load *conf,
 			};
 
 			filtered = conf->early_cu_filter(&unmerged_cu) == NULL;
+			if (filtered && dwarf_cu__add_excluded_cu(dcu, off, noff))
+				goto out_abort;
 		}
 
 		/*
diff --git a/tests/lang_exclude_lto_refs.sh b/tests/lang_exclude_lto_refs.sh
new file mode 100755
index 0000000..56bcb7b
--- /dev/null
+++ b/tests/lang_exclude_lto_refs.sh
@@ -0,0 +1,76 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Test --lang_exclude on clang LTO objects, where a kept CU refers to a type
+# in an excluded CU: LLVM emits int once, in the first CU that uses it.
+
+. "$(dirname "$0")/test_lib.sh"
+outdir=$(make_tmpdir)
+
+trap cleanup EXIT
+
+title_log "Language filtering of LTO CUs that refer to excluded CUs."
+
+for tool in clang clang++ ld.lld; do
+	if ! command -v $tool > /dev/null 2>&1; then
+		info_log "skip: $tool not available"
+		test_skip
+	fi
+done
+
+echo 'char zero_c;' > "$outdir/zero.c"
+
+cat > "$outdir/first.cpp" << 'EOF'
+struct cpp_only {
+	int	a;
+};
+
+struct cpp_only cpp_var;
+EOF
+
+cat > "$outdir/second.c" << 'EOF'
+struct c_only {
+	int	b;
+};
+
+struct c_only c_var;
+EOF
+
+obj="$outdir/lto.so"
+
+if ! clang -flto -g -c -o "$outdir/zero.o" "$outdir/zero.c" 2>/dev/null ||
+   ! clang++ -flto -g -c -o "$outdir/first.o" "$outdir/first.cpp" 2>/dev/null ||
+   ! clang -flto -g -c -o "$outdir/second.o" "$outdir/second.c" 2>/dev/null ||
+   ! clang -flto -fuse-ld=lld -shared -o "$obj" "$outdir/zero.o" \
+	"$outdir/first.o" "$outdir/second.o" 2>/dev/null; then
+	error_log "FAIL: compilation failed"
+	test_fail
+fi
+
+lang_exclude=c++,c++03,c++11,c++14
+btf="$outdir/lto.btf"
+
+check()
+{
+	if [ $1 -ne 0 ]; then
+		error_log "FAIL: $2: pahole failed"
+		test_fail
+	fi
+	if echo "$3" | grep -q "struct cpp_only"; then
+		error_log "FAIL: $2: --lang_exclude=c++ kept the C++ CU"
+		test_fail
+	fi
+	if ! echo "$3" | grep -Eq "^[[:space:]]+int[[:space:]]+b;"; then
+		error_log "FAIL: $2: c_only.b lost its type, int from the C++ CU"
+		test_fail
+	fi
+}
+
+output=$(pahole -F dwarf --lang_exclude=$lang_exclude "$obj" 2>/dev/null)
+check $? "DWARF" "$output"
+
+pahole -J --btf_encode_detached="$btf" --lang_exclude=$lang_exclude "$obj" > /dev/null 2>&1
+output=$(pahole -F btf "$btf" 2>/dev/null)
+check $? "BTF" "$output"
+
+test_pass
-- 
2.55.0

