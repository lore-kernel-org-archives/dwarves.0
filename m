Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C21BC433ED
	for <linux-dwarves@archiver.kernel.org>; Fri,  7 May 2021 05:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15C8E61075
	for <linux-dwarves@archiver.kernel.org>; Fri,  7 May 2021 05:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234068AbhEGFsD (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 7 May 2021 01:48:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:38858 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233977AbhEGFsC (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Fri, 7 May 2021 01:48:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 47C80B048;
        Fri,  7 May 2021 05:47:01 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     acme@redhat.com
Cc:     dwarves@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Martin KaFai Lau <kafai@fb.com>, Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH v2] remove ftrace filter
Date:   Fri,  7 May 2021 07:47:00 +0200
Message-Id: <20210507054700.22742-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Functions in the .opd section on ppc64 are currently ignored as they
don't contain mcount calls -- they are excluded by the ftrace filter.
Therefore, pahole cannot produce a .BTF section from vmlinux and kernel
build fails on ppc64.

Remove the ftrace filter completely as was discussed:
 https://lore.kernel.org/bpf/20210501001653.x3b4rk4vk4iqv3n7@kafai-mbp.dhcp.thefacebook.com/
 https://lore.kernel.org/bpf/YI%2FLgjLxo9VCN%2Fd+@krava/

[v2] remove sh and sym_sec_idx from collect_function as suggested by
     Jirka

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Jiri Olsa <jolsa@redhat.com>
---
 btf_encoder.c | 285 ++------------------------------------------------
 1 file changed, 7 insertions(+), 278 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 80e896961d4e..7e1117c58449 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -27,17 +27,8 @@
  */
 #define KSYM_NAME_LEN 128
 
-struct funcs_layout {
-	unsigned long mcount_start;
-	unsigned long mcount_stop;
-	unsigned long mcount_sec_idx;
-};
-
 struct elf_function {
 	const char	*name;
-	unsigned long	 addr;
-	unsigned long	 size;
-	unsigned long	 sh_addr;
 	bool		 generated;
 };
 
@@ -64,12 +55,9 @@ static void delete_functions(void)
 #define max(x, y) ((x) < (y) ? (y) : (x))
 #endif
 
-static int collect_function(struct btf_elf *btfe, GElf_Sym *sym,
-			    size_t sym_sec_idx)
+static int collect_function(struct btf_elf *btfe, GElf_Sym *sym)
 {
 	struct elf_function *new;
-	static GElf_Shdr sh;
-	static size_t last_idx;
 	const char *name;
 
 	if (elf_sym__type(sym) != STT_FUNC)
@@ -91,257 +79,12 @@ static int collect_function(struct btf_elf *btfe, GElf_Sym *sym,
 		functions = new;
 	}
 
-	if (sym_sec_idx != last_idx) {
-		if (!elf_section_by_idx(btfe->elf, &sh, sym_sec_idx))
-			return 0;
-		last_idx = sym_sec_idx;
-	}
-
 	functions[functions_cnt].name = name;
-	functions[functions_cnt].addr = elf_sym__value(sym);
-	functions[functions_cnt].size = elf_sym__size(sym);
-	functions[functions_cnt].sh_addr = sh.sh_addr;
 	functions[functions_cnt].generated = false;
 	functions_cnt++;
 	return 0;
 }
 
-static int addrs_cmp(const void *_a, const void *_b)
-{
-	const __u64 *a = _a;
-	const __u64 *b = _b;
-
-	if (*a == *b)
-		return 0;
-	return *a < *b ? -1 : 1;
-}
-
-static int get_vmlinux_addrs(struct btf_elf *btfe, struct funcs_layout *fl,
-			     __u64 **paddrs, __u64 *pcount)
-{
-	__u64 *addrs, count, offset;
-	unsigned int addr_size, i;
-	Elf_Data *data;
-	GElf_Shdr shdr;
-	Elf_Scn *sec;
-
-	/* Initialize for the sake of all error paths below. */
-	*paddrs = NULL;
-	*pcount = 0;
-
-	if (!fl->mcount_start || !fl->mcount_stop)
-		return 0;
-
-	/*
-	 * Find mcount addressed marked by __start_mcount_loc
-	 * and __stop_mcount_loc symbols and load them into
-	 * sorted array.
-	 */
-	sec = elf_getscn(btfe->elf, fl->mcount_sec_idx);
-	if (!sec || !gelf_getshdr(sec, &shdr)) {
-		fprintf(stderr, "Failed to get section(%lu) header.\n",
-			fl->mcount_sec_idx);
-		return -1;
-	}
-
-	/* Get address size from processed file's ELF class. */
-	addr_size = gelf_getclass(btfe->elf) == ELFCLASS32 ? 4 : 8;
-
-	offset = fl->mcount_start - shdr.sh_addr;
-	count  = (fl->mcount_stop - fl->mcount_start) / addr_size;
-
-	data = elf_getdata(sec, 0);
-	if (!data) {
-		fprintf(stderr, "Failed to get section(%lu) data.\n",
-			fl->mcount_sec_idx);
-		return -1;
-	}
-
-	addrs = malloc(count * sizeof(addrs[0]));
-	if (!addrs) {
-		fprintf(stderr, "Failed to allocate memory for ftrace addresses.\n");
-		return -1;
-	}
-
-	if (addr_size == sizeof(__u64)) {
-		memcpy(addrs, data->d_buf + offset, count * addr_size);
-	} else {
-		for (i = 0; i < count; i++)
-			addrs[i] = (__u64) *((__u32 *) (data->d_buf + offset + i * addr_size));
-	}
-
-	*paddrs = addrs;
-	*pcount = count;
-	return 0;
-}
-
-static int
-get_kmod_addrs(struct btf_elf *btfe, __u64 **paddrs, __u64 *pcount)
-{
-	__u64 *addrs, count;
-	unsigned int addr_size, i;
-	GElf_Shdr shdr_mcount;
-	Elf_Data *data;
-	Elf_Scn *sec;
-
-	/* Initialize for the sake of all error paths below. */
-	*paddrs = NULL;
-	*pcount = 0;
-
-	/* get __mcount_loc */
-	sec = elf_section_by_name(btfe->elf, &btfe->ehdr, &shdr_mcount,
-				  "__mcount_loc", NULL);
-	if (!sec) {
-		if (btf_elf__verbose) {
-			printf("%s: '%s' doesn't have __mcount_loc section\n", __func__,
-			       btfe->filename);
-		}
-		return 0;
-	}
-
-	data = elf_getdata(sec, NULL);
-	if (!data) {
-		fprintf(stderr, "Failed to data for __mcount_loc section.\n");
-		return -1;
-	}
-
-	/* Get address size from processed file's ELF class. */
-	addr_size = gelf_getclass(btfe->elf) == ELFCLASS32 ? 4 : 8;
-
-	count = data->d_size / addr_size;
-
-	addrs = malloc(count * sizeof(addrs[0]));
-	if (!addrs) {
-		fprintf(stderr, "Failed to allocate memory for ftrace addresses.\n");
-		return -1;
-	}
-
-	if (addr_size == sizeof(__u64)) {
-		memcpy(addrs, data->d_buf, count * addr_size);
-	} else {
-		for (i = 0; i < count; i++)
-			addrs[i] = (__u64) *((__u32 *) (data->d_buf + i * addr_size));
-	}
-
-	/*
-	 * We get Elf object from dwfl_module_getelf function,
-	 * which performs all possible relocations, including
-	 * __mcount_loc section.
-	 *
-	 * So addrs array now contains relocated values, which
-	 * we need take into account when we compare them to
-	 * functions values, see comment in setup_functions
-	 * function.
-	 */
-	*paddrs = addrs;
-	*pcount = count;
-	return 0;
-}
-
-static int is_ftrace_func(struct elf_function *func, __u64 *addrs, __u64 count)
-{
-	__u64 start = func->addr;
-	__u64 addr, end = func->addr + func->size;
-
-	/*
-	 * The invariant here is addr[r] that is the smallest address
-	 * that is >= than function start addr. Except the corner case
-	 * where there is no such r, but for that we have a final check
-	 * in the return.
-	 */
-	size_t l = 0, r = count - 1, m;
-
-	/* make sure we don't use invalid r */
-	if (count == 0)
-		return false;
-
-	while (l < r) {
-		m = l + (r - l) / 2;
-		addr = addrs[m];
-
-		if (addr >= start) {
-			/* we satisfy invariant, so tighten r */
-			r = m;
-		} else {
-			/* m is not good enough as l, maybe m + 1 will be */
-			l = m + 1;
-		}
-	}
-
-	return start <= addrs[r] && addrs[r] < end;
-}
-
-static int setup_functions(struct btf_elf *btfe, struct funcs_layout *fl)
-{
-	__u64 *addrs, count, i;
-	int functions_valid = 0;
-	bool kmod = false;
-
-	/*
-	 * Check if we are processing vmlinux image and
-	 * get mcount data if it's detected.
-	 */
-	if (get_vmlinux_addrs(btfe, fl, &addrs, &count))
-		return -1;
-
-	/*
-	 * Check if we are processing kernel module and
-	 * get mcount data if it's detected.
-	 */
-	if (!addrs) {
-		if (get_kmod_addrs(btfe, &addrs, &count))
-			return -1;
-		kmod = true;
-	}
-
-	if (!addrs) {
-		if (btf_elf__verbose)
-			printf("ftrace symbols not detected, falling back to DWARF data\n");
-		delete_functions();
-		return 0;
-	}
-
-	qsort(addrs, count, sizeof(addrs[0]), addrs_cmp);
-	qsort(functions, functions_cnt, sizeof(functions[0]), functions_cmp);
-
-	/*
-	 * Let's got through all collected functions and filter
-	 * out those that are not in ftrace.
-	 */
-	for (i = 0; i < functions_cnt; i++) {
-		struct elf_function *func = &functions[i];
-		/*
-		 * For vmlinux image both addrs[x] and functions[x]::addr
-		 * values are final address and are comparable.
-		 *
-		 * For kernel module addrs[x] is final address, but
-		 * functions[x]::addr is relative address within section
-		 * and needs to be relocated by adding sh_addr.
-		 */
-		if (kmod)
-			func->addr += func->sh_addr;
-
-		/* Make sure function is within ftrace addresses. */
-		if (is_ftrace_func(func, addrs, count)) {
-			/*
-			 * We iterate over sorted array, so we can easily skip
-			 * not valid item and move following valid field into
-			 * its place, and still keep the 'new' array sorted.
-			 */
-			if (i != functions_valid)
-				functions[functions_valid] = functions[i];
-			functions_valid++;
-		}
-	}
-
-	functions_cnt = functions_valid;
-	free(addrs);
-
-	if (btf_elf__verbose)
-		printf("Found %d functions!\n", functions_cnt);
-	return 0;
-}
-
 static struct elf_function *find_function(const struct btf_elf *btfe,
 					  const char *name)
 {
@@ -620,23 +363,8 @@ static int collect_percpu_var(struct btf_elf *btfe, GElf_Sym *sym,
 	return 0;
 }
 
-static void collect_symbol(GElf_Sym *sym, struct funcs_layout *fl,
-			   size_t sym_sec_idx)
-{
-	if (!fl->mcount_start &&
-	    !strcmp("__start_mcount_loc", elf_sym__name(sym, btfe->symtab))) {
-		fl->mcount_start = sym->st_value;
-		fl->mcount_sec_idx = sym_sec_idx;
-	}
-
-	if (!fl->mcount_stop &&
-	    !strcmp("__stop_mcount_loc", elf_sym__name(sym, btfe->symtab)))
-		fl->mcount_stop = sym->st_value;
-}
-
 static int collect_symbols(struct btf_elf *btfe, bool collect_percpu_vars)
 {
-	struct funcs_layout fl = { };
 	Elf32_Word sym_sec_idx;
 	uint32_t core_id;
 	GElf_Sym sym;
@@ -648,9 +376,8 @@ static int collect_symbols(struct btf_elf *btfe, bool collect_percpu_vars)
 	elf_symtab__for_each_symbol_index(btfe->symtab, core_id, sym, sym_sec_idx) {
 		if (collect_percpu_vars && collect_percpu_var(btfe, &sym, sym_sec_idx))
 			return -1;
-		if (collect_function(btfe, &sym, sym_sec_idx))
+		if (collect_function(btfe, &sym))
 			return -1;
-		collect_symbol(&sym, &fl, sym_sec_idx);
 	}
 
 	if (collect_percpu_vars) {
@@ -661,9 +388,11 @@ static int collect_symbols(struct btf_elf *btfe, bool collect_percpu_vars)
 			printf("Found %d per-CPU variables!\n", percpu_var_cnt);
 	}
 
-	if (functions_cnt && setup_functions(btfe, &fl)) {
-		fprintf(stderr, "Failed to filter DWARF functions\n");
-		return -1;
+	if (functions_cnt) {
+		qsort(functions, functions_cnt, sizeof(functions[0]), functions_cmp);
+
+		if (btf_elf__verbose)
+			printf("Found %d functions!\n", functions_cnt);
 	}
 
 	return 0;
-- 
2.31.1

