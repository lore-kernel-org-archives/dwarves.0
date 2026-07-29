Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E2F488DAF;
	Wed, 29 Jul 2026 19:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352122; cv=none; b=uJSGjwy502ZTqWvPifM2P+TEDq/vrsGbLJSDLViVR03Ix6jt4Qw0NnJ2dybm90FokSSCJthHKU3Q4tyQfeQqFuYcGdtxXaAXpKWgQ8VH2tTL0gNntUMfxhHXeuAZrMFmuThD+XzRcDzfyvQ4tA3lx4qFrlIfF1WHFDmggk2E0Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352122; c=relaxed/simple;
	bh=EcHZ2nPwNPHE32gifLEPKSM77FtJ+PfuuGyN/hWIStk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Od69tyoF0/hGb8j/bmi6ovMxHacrUGiqUMuflra6qMEMRaffb3Y9nlxPcM92dp2Q2zNxr1y/urJIYLzzUTmKgA338fFfH9gniIPX6UuJnfOqwdqssZ/cZacvkIKwubnoM1sVhKNuwMlPmhMrFZ2qpMtFrlPMyNFAleGYEW4ejUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3AoEG0T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3AoEG0T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC0031F000E9;
	Wed, 29 Jul 2026 19:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785352120;
	bh=2nssT5UC4BX2zX12A49TS6EGK61ZHeSgO/HB8LiqMuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G3AoEG0TDuhxaJMiys4FE+gKr6JrufVBnoJEKeAR4A2m/pWzS8xM9K7KrhHKal9f4
	 qzmvnbqrE+cbw6zuzyp4FqUDidEjWOamgNUblqHHxXGaOAN7wEfjJlnGDuMh3L8geO
	 QKZtbIxG3qpF9Ow6eBUMteSH/jK8FY3r3SDZjuT2eiCHjrjpqkLEhkZg1p2zh9VcvZ
	 5WoOrfRusOj6terfGiSxBahNH+o0vzIsiKbSjYiRrQLwYggy8u350lDvNm1y0WKsAe
	 LcZYIcWEjgBMfEv5inM7zyAr07bAurbyVEhwrcKfXne2PJWo12znR4aikDn5W2fxjn
	 NkWCLVbtmfzxw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 27/31] dwarves: Remove 6 dead functions found via coverage analysis
Date: Wed, 29 Jul 2026 16:07:27 -0300
Message-ID: <20260729190733.72876-28-acme@kernel.org>
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

Coverage analysis showed that 6 non-static functions in dwarves.c have
zero callers anywhere in the codebase:

  base_type__language_defined: introduced in 51643cb290f9 ("core:
      Introduce base_type__language_defined()", 2023) for use in
      dwarves_emit.c, but that code path was superseded before
      reaching the main branch — never called on this lineage.

  cus__find_type_by_name: introduced in 7c12b234ee30 ("dwarves:
      Introduce cus__find_type_by_name()", 2020), last callers
      removed in 22f93766cf02 ("pahole: Support multiple types
      for pretty printing", 2020).

  cu__find_struct_or_union_by_name: introduced in da632a36862c
      ("dwarves: Introduce {cu,cus}__find_struct_or_union_by_name()
      methods", 2018), last caller removed in 3c1a9a3329d9
      ("pahole: Make --contains look for more than just unions,
      structs", 2020). The struct-only variant cu__find_struct_by_name
      is used instead.

  cus__find_struct_or_union_by_name: multi-CU wrapper introduced
      alongside cu__find_struct_or_union_by_name in da632a36862c
      (2018), never had any callers.

  cus__find_cu_by_name: locking wrapper introduced in 874e750fb8bd
      ("core: Move cus__find_pair() from codiff to the core", 2021).
      The static __cus__find_cu_by_name it wraps is still used by
      cus__find_pair, but the public wrapper was never called.

  class__find_bit_hole: introduced in 82892cd9dd97 ("[CLASSES]:
      First stab at implementing class__find_bit_hole", 2006), last
      caller removed in 57fce1596b9c ("[PAHOLE]: Use class__reorganize
      in class__packable", 2007).

Removes the functions from dwarves.c and their declarations from
dwarves.h.

Before: 174 functions, 2027 lines, 63.6% line coverage.
After: 168 functions, 1975 lines, 65.3% line coverage.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarves.c | 87 +------------------------------------------------------
 dwarves.h | 13 ---------
 2 files changed, 1 insertion(+), 99 deletions(-)

diff --git a/dwarves.c b/dwarves.c
index 94bab301d598695d..1748889bc051fcb4 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -311,29 +311,6 @@ static struct ase_type_name_to_size {
 	{ .name = NULL },
 };
 
-bool base_type__language_defined(struct base_type *bt)
-{
-	int i = 0;
-	char bf[64];
-	const char *name;
-
-	if (bt->name_has_encoding)
-		name = bt->name;
-	else
-		name = base_type__name(bt, bf, sizeof(bf));
-
-	while (base_type_name_to_size_table[i].name != NULL) {
-		if (bt->name_has_encoding) {
-			if (strcmp(base_type_name_to_size_table[i].name, bt->name) == 0)
-				return true;
-		} else if (strcmp(base_type_name_to_size_table[i].name, name) == 0)
-			return true;
-		++i;
-	}
-
-	return false;
-}
-
 size_t base_type__name_to_size(struct base_type *bt, struct cu *cu)
 {
 	int i = 0;
@@ -974,27 +951,7 @@ found:
 	return pos;
 }
 
-struct tag *cus__find_type_by_name(struct cus *cus, struct cu **cu, const char *name,
-				   const int include_decls, type_id_t *id)
-{
-	struct cu *pos;
-	struct tag *tag = NULL;
-
-	cus__lock(cus);
-
-	list_for_each_entry(pos, &cus->cus, node) {
-		tag = cu__find_type_by_name(pos, name, include_decls, id);
-		if (tag != NULL) {
-			if (cu != NULL)
-				*cu = pos;
-			break;
-		}
-	}
-
-	cus__unlock(cus);
-
-	return tag;
-}
+/* cus__find_type_by_name removed: dead code, no callers */
 
 static struct tag *__cu__find_struct_by_name(const struct cu *cu, const char *name,
 					     const int include_decls, bool unions, type_id_t *idp)
@@ -1034,12 +991,6 @@ struct tag *cu__find_struct_by_name(const struct cu *cu, const char *name,
 	return __cu__find_struct_by_name(cu, name, include_decls, false, idp);
 }
 
-struct tag *cu__find_struct_or_union_by_name(const struct cu *cu, const char *name,
-						    const int include_decls, type_id_t *idp)
-{
-	return __cu__find_struct_by_name(cu, name, include_decls, true, idp);
-}
-
 static struct tag *__cus__find_struct_by_name(struct cus *cus, struct cu **cu, const char *name,
 					      const int include_decls, bool unions, type_id_t *id)
 {
@@ -1069,12 +1020,6 @@ struct tag *cus__find_struct_by_name(struct cus *cus, struct cu **cu, const char
 	return __cus__find_struct_by_name(cus, cu, name, include_decls, false, idp);
 }
 
-struct tag *cus__find_struct_or_union_by_name(struct cus *cus, struct cu **cu, const char *name,
-					      const int include_decls, type_id_t *idp)
-{
-	return __cus__find_struct_by_name(cus, cu, name, include_decls, true, idp);
-}
-
 struct function *cu__find_function_at_addr(const struct cu *cu,
 					   uint64_t addr)
 {
@@ -1135,19 +1080,6 @@ out:
 	return pos;
 }
 
-struct cu *cus__find_cu_by_name(struct cus *cus, const char *name)
-{
-	struct cu *pos;
-
-	cus__lock(cus);
-
-	pos = __cus__find_cu_by_name(cus, name);
-
-	cus__unlock(cus);
-
-	return pos;
-}
-
 struct cu *cus__find_pair(struct cus *cus, const char *name)
 {
 	struct cu *cu;
@@ -1568,23 +1500,6 @@ bool class__has_flexible_array(struct class *class, const struct cu *cu)
 	return class->has_flexible_array;
 }
 
-const struct class_member *class__find_bit_hole(const struct class *class,
-					    const struct class_member *trailer,
-						const uint16_t bit_hole_size)
-{
-	struct class_member *pos;
-	const uint16_t byte_hole_size = bit_hole_size / 8;
-
-	type__for_each_data_member(&class->type, pos)
-		if (pos == trailer)
-			break;
-		else if (pos->hole >= byte_hole_size ||
-			 pos->bit_hole >= bit_hole_size)
-			return pos;
-
-	return NULL;
-}
-
 void class__find_holes(struct class *class)
 {
 	const struct type *ctype = &class->type;
diff --git a/dwarves.h b/dwarves.h
index 8f1640e4247d5115..99e9d183c853ea8b 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -196,17 +196,12 @@ void cus__remove(struct cus *cus, struct cu *cu);
 void cus__print_error_msg(const char *progname, const struct cus *cus,
 			  const char *filename, const int err);
 struct cu *cus__find_pair(struct cus *cus, const char *name);
-struct cu *cus__find_cu_by_name(struct cus *cus, const char *name);
 struct tag *cus__find_struct_by_name(struct cus *cus, struct cu **cu,
 				     const char *name, const int include_decls,
 				     type_id_t *id);
-struct tag *cus__find_struct_or_union_by_name(struct cus *cus, struct cu **cu,
-					      const char *name, const int include_decls, type_id_t *id);
 void *cu__tag_alloc(struct cu *cu, size_t size);
 void cu__tag_free(struct cu *cu, struct tag *tag);
 struct tag *cu__find_type_by_name(const struct cu *cu, const char *name, const int include_decls, type_id_t *idp);
-struct tag *cus__find_type_by_name(struct cus *cus, struct cu **cu, const char *name,
-				   const int include_decls, type_id_t *id);
 struct function *cus__find_function_at_addr(struct cus *cus, uint64_t addr, struct cu **cu);
 void cus__for_each_cu(struct cus *cus, int (*iterator)(struct cu *cu, void *cookie),
 		      void *cookie,
@@ -510,8 +505,6 @@ struct tag *cu__tag(const struct cu *cu, const uint32_t id);
 struct tag *cu__type(const struct cu *cu, const type_id_t id);
 struct tag *cu__find_struct_by_name(const struct cu *cu, const char *name,
 				    const int include_decls, type_id_t *id);
-struct tag *cu__find_struct_or_union_by_name(const struct cu *cu, const char *name,
-					     const int include_decls, type_id_t *id);
 bool cu__same_build_id(const struct cu *cu, const struct cu *other);
 void cu__account_inline_expansions(struct cu *cu);
 int cu__for_all_tags(struct cu *cu,
@@ -1530,10 +1523,6 @@ static inline int class__is_declaration(const struct class *cls)
 	return cls->type.declaration;
 }
 
-const struct class_member *class__find_bit_hole(const struct class *cls,
-					   const struct class_member *trailer,
-						const uint16_t bit_hole_size);
-
 #define class__for_each_member_from(cls, from, pos)			\
 	pos = list_prepare_entry(from, class__tags(cls), tag.node);	\
 	list_for_each_entry_from(pos, class__tags(cls), tag.node)	\
@@ -1605,8 +1594,6 @@ const char *base_type__name(const struct base_type *btype, char *bf, size_t len)
 
 size_t base_type__name_to_size(struct base_type *btype, struct cu *cu);
 
-bool base_type__language_defined(struct base_type *bt);
-
 struct array_type {
 	struct tag	tag;
 	uint32_t	*nr_entries;
-- 
2.55.0

