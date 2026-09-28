Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3445F3A6EE3
	for <dwarves@vger.kernel.org>; Mon, 28 Sep 2026 18:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621214; cv=none; b=YlUHB+N2W5i7gz6AjOTQixwrx3lvehCVN5Up8x/uTkFbZHqw7/xY5I1gEk0Jy2ocFVkUPxiz5Ub9Eef8mczlNOvsbg42ZyWLPGqrcvpxuEwVT1lDvmToI7Bbt0Tn/ZsD9fR+0V5BAR4tOYsoR5S0lIHOKe8FUyc/EhA2vvkt+Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621214; c=relaxed/simple;
	bh=or95/3fKeG87F5VCGtHjPCdbcuC4ENulwCwDhmijwwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FK/wxH6RBzcRSGhRtuKOdidBDsJrdS8mumbh6PR71GY0Xrz2lm7yZBr0deXGIonWKKHBj12udB2twtTuLgwTeaCa1jCZIEUt4nzjtK/Q8CTfIh/0NNes17dH0Jr8Lu3TUO0/nMd3+g/8AMWVN43qE4m9I53OZqKfm52UJqJVLW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGlutsJ1; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGlutsJ1"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c2940ef15c1so466039266b.1
        for <dwarves@vger.kernel.org>; Mon, 28 Sep 2026 11:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790621210; x=1791226010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b5+qRk/pzfHHSDFTEw3HOAc3hFgHSJGHdwGqqiO9I7M=;
        b=BGlutsJ1oBH2349b4wDlxiwPzclkMfnB0xt3/dFOITdVE/pcKCdME+7u6QpteNedzO
         098cwJADJOcsos1JpgrK1GKzUBY1bFdR8Nr4gce81SiLigzCfrnnfH7PuAd3DSFIO4SC
         L5GvI4EhFa1SHGbS472jBcboDTeFmYTmVEEc4fGJWHIBEDqOtZl1o43NEZtmneIjz8dc
         noAivTkUeICxFjuw8MT3eVatJlhOGDZknSzGxCIQiZDK2RbdisaoEZWgum5eJxP005+A
         HX2/9bA3i9hkeQjm2B+FARRBor72lroZ9A5S2d5+zYrrsC4h8isFhsQp4cZ5mN86ilGn
         vE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790621210; x=1791226010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b5+qRk/pzfHHSDFTEw3HOAc3hFgHSJGHdwGqqiO9I7M=;
        b=h6gCdQnKFowKHC/ydGMgWri74PW2G0gMhLM88Z6uX46/yx7mim69HYzr0k7vlcGNb9
         KLVVVnPbGq+aMpX7wP5NVL0ekUWq2c1B3tW0IGjzRATK5yuKb9gnu/ZWCi/htBhisouT
         LPDD7TSh0TynCuqZUOeMi9F7R8lJSbFPCWO6BOHEPv5hgujTQXm5t3AbHWwT3IswXnbD
         kS+l6qu0QiDq/OWDhhYH3uYAvtrVgp84YeX60ioFntRjEUxOBtWUR7zbJbTtfS1OjOJZ
         EehxGA/xf8UdSGjWYEwBvvaUFUEXyRJrawXA/+32CWTbxn7YO+F8BEGlZyth92AdJNJi
         vYkg==
X-Gm-Message-State: AFuF++kIQAaB7UHV03jLg0CYz2afWiRBZUDKgn4SBNJEwQaWU80gWzZd
	blggB/NmJTS76S8wBz9jcBNnpPn+YdEDOdiqPBRvmBOjtiG/yWKtgbQOLZNKlQ==
X-Gm-Gg: AYBFou0J7ecZCz+ef4QwecZSZbesOvEQsfcVIa4ypBZ9b9IidgvIhlM6E6oRJd6THol
	WxI0clTXmE1RYDb1BRJ6suhX8QPLCKyhO9aPGn1iC7CF9qETwiEdho8CsGREMJk+Odfo5IndzWz
	Jbz/xJzlExwULf7nzW7NBUpUPFHvQ6LH+E9Vag22/my4L3zu+K6aml1GU7d6RGfapcyc247C99D
	1+SGlW+iw3mq8/lfwCVYkl3obBAf8hZWDi3A5det93IzulGv6Yh/wANcMV/Wk0KMNYBea7hYJ+Y
	qT01lZNbSNVCagB7WHJLztLNHwOm4kuZoH/6dl9hrwKRj0udjCYriMOfn6JC4GOgzd4seeeMmAt
	Ox9acbA2UdLiyQclyRxdi4bUQEwN6fSDCyRUwB4z3MyZTMRInJWSIrqZJAURZDJvPUiyPw76PDb
	iw5bdee1IhF/O6MTo32vuv2U0aP6v6u8W31NvPXN+gvaZlbZq+03/KzqGEntHf0LNXuV+e8EKo9
	k1NLEJq666Mw1FGjvtRm/VwbhGYFuDR13toZAKSAB018K1HhT3/7eiFnnRLI78l2j+YOb1QPcI=
X-Received: by 2002:a17:907:1888:b0:c29:4513:f6fd with SMTP id a640c23a62f3a-c2ac24fee36mr1114312966b.35.1790621210310;
        Mon, 28 Sep 2026 11:46:50 -0700 (PDT)
Received: from KURWA.angora-ide.ts.net (mm-12-36-126-178.vitebsk.dynamic.pppoe.byfly.by. [178.126.36.12])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dc3e12208sm301760966b.42.2026.09.28.11.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 11:46:49 -0700 (PDT)
From: ElXreno <elxreno@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>
Cc: dwarves@vger.kernel.org,
	Yonghong Song <yonghong.song@linux.dev>,
	ElXreno <elxreno@gmail.com>
Subject: [PATCH dwarves 1/2] dwarf_loader: Keep the hash table size in struct dwarf_cu
Date: Mon, 28 Sep 2026 21:45:50 +0300
Message-ID: <20260928184551.1311109-2-elxreno@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928184551.1311109-1-elxreno@gmail.com>
References: <20260928184551.1311109-1-elxreno@gmail.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cus__merge_and_process_cu() sizes the merged CU hash tables by raising
the global hashtags__bits, which every lookup uses to pick a bucket.
The .debug_types tables were allocated before that with the old value,
so lookups through dcu->type_unit read past them:

  $ echo 'struct s { int a; } v; int main(void) { return v.a; }' > t.c
  $ gcc -gdwarf-4 -fdebug-types-section t.c -o t
  $ pahole -F dwarf --btf_features=force_cu_merging t
  struct s {
  	int                        a;                    /*     0     4 */

  	/* size: 4, cachelines: 1, members: 1 */
  	/* last cacheline: 4 bytes */
  };
  Segmentation fault         (core dumped) pahole -F dwarf --btf_features=force_cu_merging t

With -fsanitize=address:

  AddressSanitizer:DEADLYSIGNAL
  =================================================================
  ==3587655==ERROR: AddressSanitizer: SEGV on unknown address 0x709eec8aecc8 (pc 0x71ceed04645b bp 0x7ffdbc1ce760 sp 0x7ffdbc1ce760 T0)
  ==3587655==The signal is caused by a READ memory access.
      #0 0x71ceed04645b in hashtags__find /build/source/dwarf_loader.c:293
      #1 0x71ceed04645b in __dwarf_cu__find_type_by_ref /build/source/dwarf_loader.c:498
      #2 0x71ceed057ea3 in tag__recode_dwarf_type /build/source/dwarf_loader.c:4125
      #3 0x71ceed058c99 in cu__recode_dwarf_types_table /build/source/dwarf_loader.c:4235
      #4 0x71ceed058c99 in cu__recode_dwarf_types /build/source/dwarf_loader.c:4245
      #5 0x71ceed05944b in cus__merge_and_process_cu /build/source/dwarf_loader.c:5199
      #6 0x71ceed05944b in cus__load_module /build/source/dwarf_loader.c:5274
      #7 0x71ceed05944b in cus__process_dwflmod /build/source/dwarf_loader.c:5339
      #8 0x71ceecfa13c8 in __dwfl_getmodules_internal (/nix/store/dyxcy223n2jch1kdf35wxcc39qmz8if5-elfutils-0.195/lib/libdw.so.1+0x603c8) (BuildId: 7da69f67158848e14bbae81b88e52ce03588fc75)
      #9 0x71ceed0475f1 in cus__process_file /build/source/dwarf_loader.c:5405
      #10 0x71ceed0475f1 in dwarf__load_file /build/source/dwarf_loader.c:5442
      #11 0x71ceed01beb3 in cus__load_file /build/source/dwarves.c:2199
      #12 0x71ceed01ceb0 in cus__load_files /build/source/dwarves.c:2897
      #13 0x606bb7c3e059 in main /build/source/pahole.c:3757
      #14 0x71ceecc96284 in __libc_start_call_main (/nix/store/lm3pknxi0ipypy3lxh1wmm8wvvavdwrn-glibc-2.42-84/lib/libc.so.6+0x2b284) (BuildId: 67802a55cff437269d8d9608af391b6f583fca73)
      #15 0x71ceecc96337 in __libc_start_main@GLIBC_2.2.5 (/nix/store/lm3pknxi0ipypy3lxh1wmm8wvvavdwrn-glibc-2.42-84/lib/libc.so.6+0x2b337) (BuildId: 67802a55cff437269d8d9608af391b6f583fca73)
      #16 0x606bb7c3f144 in _start (/nix/store/rpa278wbckgfxlmpxpkmfdhlk7fbxkr2-pahole-korg-asan-1.32-c23e8b3/bin/pahole+0xf144)

  ==3587655==Register values:
  rax = 0x0000709eec8aecc8  rbx = 0x00006ebeeb9e0080  rcx = 0x000000000000002b  rdx = 0x00000e13dd915d99
  rdi = 0x00006e4eeb9e0020  rsi = 0x000000000000001d  rbp = 0x00007ffdbc1ce760  rsp = 0x00007ffdbc1ce760
   r8 = 0x0000000000000000   r9 = 0x0000000000000000  r10 = 0x00006ebeeb9e0071  r11 = 0x00006ebeeb9e0050
  r12 = 0x00006efeeb9e0200  r13 = 0x00006ebeeb9e0094  r14 = 0x00006efeeb9e0280  r15 = 0x0000606bb7c564a8
  AddressSanitizer can not provide additional info.
  SUMMARY: AddressSanitizer: SEGV /build/source/dwarf_loader.c:293 in hashtags__find
  ==3587655==ABORTING

The raised value also stays for the rest of the run, so the CUs of any
file loaded after a merged one get 2^21 bucket tables instead of 2^12.

Keep the size in each dwarf_cu and hash with it.

Fixes: 39227909db3c ("dwarf_loader: Permit merging all DWARF CU's for clang LTO built binary")
Assisted-by: LLM
Signed-off-by: ElXreno <elxreno@gmail.com>
---
 dwarf_loader.c | 49 ++++++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 1e5363a..53047f8 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -80,9 +80,9 @@ static inline void libdw__lock_unlock(void) { pthread_mutex_unlock(&libdw__lock)
 static uint32_t hashtags__bits = 12;
 static uint32_t max_hashtags__bits = 21;
 
-static uint32_t hashtags__fn(Dwarf_Off key)
+static uint32_t hashtags__fn(Dwarf_Off key, uint32_t hash_bits)
 {
-	return hash_64(key, hashtags__bits);
+	return hash_64(key, hash_bits);
 }
 
 bool no_bitfield_type_recode = true;
@@ -172,6 +172,7 @@ struct alt_pu {
 struct dwarf_cu {
 	struct hlist_head *hash_tags;	/* tags (functions, etc.) keyed by DWARF offset */
 	struct hlist_head *hash_types;	/* types keyed by DWARF offset */
+	uint32_t  hash_bits;
 	struct dwarf_tag *last_type_lookup;
 	struct cu *cu;
 	struct dwarf_cu *type_unit;	/* .debug_types offset space */
@@ -185,12 +186,13 @@ struct dwarf_cu {
 	bool	  processing_alt;	/* true while processing alt-file DIEs */
 };
 
-static int dwarf_cu__init(struct dwarf_cu *dcu, struct cu *cu)
+static int dwarf_cu__init(struct dwarf_cu *dcu, struct cu *cu, uint32_t hash_bits)
 {
 	static struct dwarf_tag sentinel_dtag = { .id = ULLONG_MAX, };
-	uint64_t hashtags_size = 1UL << hashtags__bits;
+	uint64_t hashtags_size = 1UL << hash_bits;
 
 	dcu->cu = cu;
+	dcu->hash_bits = hash_bits;
 
 	dcu->hash_tags = cu__malloc(cu, sizeof(struct hlist_head) * hashtags_size);
 	if (!dcu->hash_tags)
@@ -228,11 +230,11 @@ static int dwarf_cu__init(struct dwarf_cu *dcu, struct cu *cu)
 	return 0;
 }
 
-static struct dwarf_cu *dwarf_cu__new(struct cu *cu)
+static struct dwarf_cu *dwarf_cu__new(struct cu *cu, uint32_t hash_bits)
 {
 	struct dwarf_cu *dwarf_cu = cu__zalloc(cu, sizeof(*dwarf_cu));
 
-	if (dwarf_cu != NULL && dwarf_cu__init(dwarf_cu, cu) != 0) {
+	if (dwarf_cu != NULL && dwarf_cu__init(dwarf_cu, cu, hash_bits) != 0) {
 		cu__free(cu, dwarf_cu);
 		dwarf_cu = NULL;
 	}
@@ -272,22 +274,22 @@ static void __tag__print_type_not_found(struct tag *tag, const char *func)
 #define tag__print_type_not_found(tag) \
 	__tag__print_type_not_found(tag, __func__)
 
-static void hashtags__hash(struct hlist_head *hashtable,
+static void hashtags__hash(struct hlist_head *hashtable, uint32_t hash_bits,
 			   struct dwarf_tag *dtag)
 {
-	struct hlist_head *head = hashtable + hashtags__fn(dtag->id);
+	struct hlist_head *head = hashtable + hashtags__fn(dtag->id, hash_bits);
 	hlist_add_head(&dtag->hash_node, head);
 }
 
 static struct dwarf_tag *hashtags__find(const struct hlist_head *hashtable,
-					const Dwarf_Off id)
+					uint32_t hash_bits, const Dwarf_Off id)
 {
 	if (id == 0)
 		return NULL;
 
 	struct dwarf_tag *tpos;
 	struct hlist_node *pos;
-	uint32_t bucket = hashtags__fn(id);
+	uint32_t bucket = hashtags__fn(id, hash_bits);
 	const struct hlist_head *head = hashtable + bucket;
 
 	hlist_for_each_entry(tpos, pos, head, hash_node) {
@@ -317,7 +319,7 @@ static void cu__hash(struct cu *cu, struct tag *tag)
 	struct hlist_head *hashtable = tag__is_tag_type(tag) ?
 							target->hash_types :
 							target->hash_tags;
-	hashtags__hash(hashtable, tag__dwarf(tag));
+	hashtags__hash(hashtable, target->hash_bits, tag__dwarf(tag));
 }
 
 /* Binary search for the alt PU whose [start, end) range contains offset.
@@ -410,7 +412,7 @@ static void dwarf_cu__prune_unreferenced_alt_pus(struct dwarf_cu *dcu)
 	if (alt == NULL || dcu->nr_alt_pus == 0)
 		return;
 
-	uint64_t hashtags_size = 1UL << hashtags__bits;
+	uint64_t hashtags_size = 1UL << alt->hash_bits;
 
 	for (uint64_t i = 0; i < hashtags_size; i++) {
 		struct dwarf_tag *dtag;
@@ -467,7 +469,7 @@ static struct dwarf_tag *__dwarf_cu__find_tag_by_ref(const struct dwarf_cu *cu,
 		if (cu == NULL)
 			return NULL;
 	}
-	return hashtags__find(cu->hash_tags, ref);
+	return hashtags__find(cu->hash_tags, cu->hash_bits, ref);
 }
 
 #define dwarf_cu__find_tag_by_ref(cu, dtag, field) \
@@ -495,7 +497,7 @@ static struct dwarf_tag *__dwarf_cu__find_type_by_ref(struct dwarf_cu *dcu,
 	if (dcu->last_type_lookup->id == ref)
 		return dcu->last_type_lookup;
 
-	struct dwarf_tag *dtag = hashtags__find(dcu->hash_types, ref);
+	struct dwarf_tag *dtag = hashtags__find(dcu->hash_types, dcu->hash_bits, ref);
 
 	if (dtag)
 		dcu->last_type_lookup = dtag;
@@ -4565,7 +4567,7 @@ static int __cus__load_debug_types(struct cus *cus, struct conf_load *conf, Dwfl
 				return DWARF_CB_ABORT;
 			}
 
-			dcu = dwarf_cu__new(cu);
+			dcu = dwarf_cu__new(cu, hashtags__bits);
 			if (dcu == NULL) {
 				cu__delete(cu);
 				return DWARF_CB_ABORT;
@@ -4826,7 +4828,7 @@ static struct dwarf_cu *dwarf_cus__create_cu(struct dwarf_cus *dcus, Dwarf_Die *
 		return NULL;
 	}
 
-	struct dwarf_cu *dcu = dwarf_cu__new(cu);
+	struct dwarf_cu *dcu = dwarf_cu__new(cu, hashtags__bits);
 
 	if (dcu == NULL) {
 		cu__delete(cu);
@@ -5081,14 +5083,15 @@ static int cus__merge_and_process_cu(struct cus *cus, struct conf_load *conf,
 			 * Let us start with max_hashtags__bits and
 			 * go down to find a proper hashtag bit value.
 			 */
-			uint32_t default_hbits = hashtags__bits;
-			for (hashtags__bits = max_hashtags__bits;
-			     hashtags__bits >= default_hbits;
-			     hashtags__bits--) {
-				if (dwarf_cu__init(dcu, cu) == 0)
+			uint32_t hash_bits;
+
+			for (hash_bits = max_hashtags__bits;
+			     hash_bits >= hashtags__bits;
+			     hash_bits--) {
+				if (dwarf_cu__init(dcu, cu, hash_bits) == 0)
 					break;
 			}
-			if (hashtags__bits < default_hbits)
+			if (hash_bits < hashtags__bits)
 				goto out_abort;
 
 			dcu->cu = cu;
@@ -5116,7 +5119,7 @@ static int cus__merge_and_process_cu(struct cus *cus, struct conf_load *conf,
 			Dwarf *alt_dw = dwarf_getalt(dw);
 
 			if (alt_dw != NULL) {
-				struct dwarf_cu *alt_dcu = dwarf_cu__new(cu);
+				struct dwarf_cu *alt_dcu = dwarf_cu__new(cu, dcu->hash_bits);
 
 				if (alt_dcu == NULL)
 					goto out_abort;
-- 
2.55.0

