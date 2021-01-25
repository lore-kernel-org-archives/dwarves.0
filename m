Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A2FC433E9
	for <linux-dwarves@archiver.kernel.org>; Tue, 26 Jan 2021 19:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E850023127
	for <linux-dwarves@archiver.kernel.org>; Tue, 26 Jan 2021 19:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbhAZFnE (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728619AbhAYNJS (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 25 Jan 2021 08:09:18 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AD2C06178B
        for <dwarves@vger.kernel.org>; Mon, 25 Jan 2021 05:06:41 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id k64so6104882wmb.6
        for <dwarves@vger.kernel.org>; Mon, 25 Jan 2021 05:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=F7AnyDl54dMT8pOE1ownSAAEiPW1w7lE/lQbqOo0kHk=;
        b=gEL1ZGEf6L6I9cex2xnE/t/vNl60tu9KjliGn4SahnLmh6CyGc/Lo+XIX8ZjtSUqeO
         1TfQA6qBxqMlBFW2RVP3Po39K+y8a8EvV9LyIjW582NWOYd4fBDtjrHP4IArCiCKpPKG
         yyQckg3gsbosC0cftj2QNTmGUXHK3KHriyb9LW/0HQGrVPgAfWugDiAFVrHBx/t+fKZO
         6vZKxI2/0KWze6DUnm6CzOcgyPHq5XSAQy4FfPOEwN8dkIT5e1G62pUY8ePXmBTKDwOc
         tpNEVZ7MqCVBd+7NQnDmmP/i7F5lDN6o/NH6Jt7691pwkKbw3/dRXlkuyirw7cg0PSN5
         wjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=F7AnyDl54dMT8pOE1ownSAAEiPW1w7lE/lQbqOo0kHk=;
        b=XvAKG99VYR9FwSrqk1X7HbeXW4LYYfS4HeGvBVEvPeaiO1YJr+7rQMej2LC/PI5WRw
         RmTPpAC8jZWJsap2Rbl0roCIfLKx5DiwONW6LXscG8btYViDcYHstJLdKNjSloe9Injd
         GPCtoe7nA8W2dfUhWEeffdH2ZLXOZrXCwKWy6mloQdU5GrJl+EUENQw4IluQftSNOy6Y
         4lwUM5flxwrTqwEsIjeg/wJl1NVrGO37rPa2JZ0nfh9d7S59EqgaP+XQ7gnR/ZAsaBeU
         2zHv8lM0IkyiYMDKlA2va5xKBPPrevIYVD/TczguqPLgGbuvXxxq3SxObrtXXIpHENof
         n1TA==
X-Gm-Message-State: AOAM533L1gOePIzO0ip7mAPNbO5OpAG1BX9ZEBXt8+wyFPpSAgAvqAaD
        zON804VpztHJX/8rnli1p7LXefrd0+UJHu5d9rmJ6pdzYQFRjV6hGFrmw4GxP+0ikx7kQZlUgBi
        HbM9ysWx8cz4yvNNpTJJl+n/kDpE5PBdOaAQP++6td7DCnitKu/FuFcQIzz5IuK1S63A0
X-Google-Smtp-Source: ABdhPJyjiMlHb58uSEQ07K9Y2g0t6ehfwAR0BVHTzeyY324+46HvLumnWJtqRYMh7IzIGPVXnR8ZPTKoHd9LZA==
Sender: "gprocida via sendgmr" <gprocida@tef.lon.corp.google.com>
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:110:a6ae:11ff:fe11:4f04])
 (user=gprocida job=sendgmr) by 2002:a05:6000:188b:: with SMTP id
 a11mr848105wri.151.1611579999642; Mon, 25 Jan 2021 05:06:39 -0800 (PST)
Date:   Mon, 25 Jan 2021 13:06:23 +0000
In-Reply-To: <20210125130625.2030186-1-gprocida@google.com>
Message-Id: <20210125130625.2030186-3-gprocida@google.com>
Mime-Version: 1.0
References: <20210125130625.2030186-1-gprocida@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH dwarves 2/4] btf_encoder: Add .BTF section using libelf
From:   Giuliano Procida <gprocida@google.com>
To:     dwarves@vger.kernel.org
Cc:     acme@kernel.org, andrii@kernel.org, ast@kernel.org,
        gprocida@google.com, maennich@google.com, kernel-team@android.com,
        kernel-team@fb.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

pahole -J uses libelf directly when updating a .BTF section. However,
it uses llvm-objcopy to add .BTF sections. This commit switches to
using libelf for both cases.

This eliminates pahole's dependency on llvm-objcopy. One unfortunate
side-effect is that vmlinux actually increases in size. It seems that
llvm-objcopy modifies the .strtab section, discarding many strings. I
speculate that is it discarding strings not referenced from .symtab
and updating the references therein.

In this initial version layout is left completely up to libelf which
may be OK for non-loadable object files, but is probably no good for
things like vmlinux where all the offsets may change. This is
addressed in a follow-up commit.

Signed-off-by: Giuliano Procida <gprocida@google.com>
---
 libbtf.c | 145 ++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 100 insertions(+), 45 deletions(-)

diff --git a/libbtf.c b/libbtf.c
index 9f76283..fb8e043 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -699,6 +699,7 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 	uint32_t raw_btf_size;
 	int fd, err = -1;
 	size_t strndx;
+	void *str_table = NULL;
 
 	fd = open(filename, O_RDWR);
 	if (fd < 0) {
@@ -741,74 +742,128 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 	}
 
 	/*
-	 * First we look if there was already a .BTF section to overwrite.
+	 * First we check if there is already a .BTF section present.
 	 */
-
 	elf_getshdrstrndx(elf, &strndx);
+	Elf_Scn *btf_scn = 0;
 	while ((scn = elf_nextscn(elf, scn)) != NULL) {
 		shdr = gelf_getshdr(scn, &shdr_mem);
 		if (shdr == NULL)
 			continue;
 		char *secname = elf_strptr(elf, strndx, shdr->sh_name);
 		if (strcmp(secname, ".BTF") == 0) {
-			btf_data = elf_getdata(scn, btf_data);
+			btf_scn = scn;
 			break;
 		}
 	}
 
-	raw_btf_data = btf__get_raw_data(btf, &raw_btf_size);
-
-	if (btf_data) {
-		/* Exisiting .BTF section found */
-		btf_data->d_buf = (void *)raw_btf_data;
-		btf_data->d_size = raw_btf_size;
-		elf_flagdata(btf_data, ELF_C_SET, ELF_F_DIRTY);
+	Elf_Scn *str_scn = elf_getscn(elf, strndx);
+	if (!str_scn) {
+		fprintf(stderr, "%s: elf_getscn(strndx) failed\n", __func__);
+		goto out;
+	}
 
-		if (elf_update(elf, ELF_C_NULL) >= 0 &&
-		    elf_update(elf, ELF_C_WRITE) >= 0)
-			err = 0;
-		else
-			fprintf(stderr, "%s: elf_update failed: %s.\n",
-				__func__, elf_errmsg(elf_errno()));
+	size_t dot_btf_offset = 0;
+	if (btf_scn) {
+		/* Existing .BTF section found */
+		btf_data = elf_getdata(btf_scn, NULL);
+		if (!btf_data) {
+			fprintf(stderr, "%s: elf_getdata failed: %s\n", __func__,
+				elf_errmsg(elf_errno()));
+			goto out;
+		}
 	} else {
-		const char *llvm_objcopy;
-		char tmp_fn[PATH_MAX];
-		char cmd[PATH_MAX * 2];
-
-		llvm_objcopy = getenv("LLVM_OBJCOPY");
-		if (!llvm_objcopy)
-			llvm_objcopy = "llvm-objcopy";
-
-		/* Use objcopy to add a .BTF section */
-		snprintf(tmp_fn, sizeof(tmp_fn), "%s.btf", filename);
-		close(fd);
-		fd = creat(tmp_fn, S_IRUSR | S_IWUSR);
-		if (fd == -1) {
-			fprintf(stderr, "%s: open(%s) failed!\n", __func__,
-				tmp_fn);
+		/* Add ".BTF" to the section name string table */
+		Elf_Data *str_data = elf_getdata(str_scn, NULL);
+		if (!str_data) {
+			fprintf(stderr, "%s: elf_getdata(str_scn) failed: %s\n",
+				__func__, elf_errmsg(elf_errno()));
 			goto out;
 		}
-
-		if (write(fd, raw_btf_data, raw_btf_size) != raw_btf_size) {
-			fprintf(stderr, "%s: write of %d bytes to '%s' failed: %d!\n",
-				__func__, raw_btf_size, tmp_fn, errno);
-			goto unlink;
+		dot_btf_offset = str_data->d_size;
+		size_t new_str_size = dot_btf_offset + 5;
+		str_table = malloc(new_str_size);
+		if (!str_table) {
+			fprintf(stderr, "%s: malloc(%zu) failed: %s\n", __func__,
+				new_str_size, elf_errmsg(elf_errno()));
+			goto out;
 		}
+		memcpy(str_table, str_data->d_buf, dot_btf_offset);
+		memcpy(str_table + dot_btf_offset, ".BTF", 5);
+		str_data->d_buf = str_table;
+		str_data->d_size = new_str_size;
+		elf_flagdata(str_data, ELF_C_SET, ELF_F_DIRTY);
+
+		/* Create a new section */
+		btf_scn = elf_newscn(elf);
+		if (!btf_scn) {
+			fprintf(stderr, "%s: elf_newscn failed: %s\n",
+			__func__, elf_errmsg(elf_errno()));
+			goto out;
+		}
+		btf_data = elf_newdata(btf_scn);
+		if (!btf_data) {
+			fprintf(stderr, "%s: elf_newdata failed: %s\n",
+			__func__, elf_errmsg(elf_errno()));
+			goto out;
+		}
+	}
 
-		snprintf(cmd, sizeof(cmd), "%s --add-section .BTF=%s %s",
-			 llvm_objcopy, tmp_fn, filename);
-		if (system(cmd)) {
-			fprintf(stderr, "%s: failed to add .BTF section to '%s': %d!\n",
-				__func__, filename, errno);
-			goto unlink;
+	/* (Re)populate the BTF section data */
+	raw_btf_data = btf__get_raw_data(btf, &raw_btf_size);
+	btf_data->d_buf = (void *)raw_btf_data;
+	btf_data->d_size = raw_btf_size;
+	btf_data->d_type = ELF_T_BYTE;
+	btf_data->d_version = EV_CURRENT;
+	elf_flagdata(btf_data, ELF_C_SET, ELF_F_DIRTY);
+
+	/* Update .BTF section in the SHT */
+	GElf_Shdr btf_shdr_mem;
+	GElf_Shdr *btf_shdr = gelf_getshdr(btf_scn, &btf_shdr_mem);
+	if (!btf_shdr) {
+		fprintf(stderr, "%s: elf_getshdr(btf_scn) failed: %s\n",
+			__func__, elf_errmsg(elf_errno()));
+		goto out;
+	}
+	btf_shdr->sh_entsize = 0;
+	btf_shdr->sh_flags = 0;
+	if (dot_btf_offset)
+		btf_shdr->sh_name = dot_btf_offset;
+	btf_shdr->sh_type = SHT_PROGBITS;
+	if (!gelf_update_shdr(btf_scn, btf_shdr)) {
+		fprintf(stderr, "%s: gelf_update_shdr failed: %s\n",
+			__func__, elf_errmsg(elf_errno()));
+		goto out;
+	}
+
+	if (elf_update(elf, ELF_C_NULL) < 0) {
+		fprintf(stderr, "%s: elf_update (layout) failed: %s\n",
+			__func__, elf_errmsg(elf_errno()));
+		goto out;
+	}
+
+	size_t phnum = 0;
+	if (!elf_getphdrnum(elf, &phnum)) {
+		for (size_t ix = 0; ix < phnum; ++ix) {
+			GElf_Phdr phdr;
+			GElf_Phdr *elf_phdr = gelf_getphdr(elf, ix, &phdr);
+			size_t filesz = gelf_fsize(elf, ELF_T_PHDR, 1, EV_CURRENT);
+			fprintf(stderr, "type: %d %d\n", elf_phdr->p_type, PT_PHDR);
+			fprintf(stderr, "offset: %lu %lu\n", elf_phdr->p_offset, ehdr->e_phoff);
+			fprintf(stderr, "filesize: %lu %lu\n", elf_phdr->p_filesz, filesz);
 		}
+	}
 
-		err = 0;
-	unlink:
-		unlink(tmp_fn);
+	if (elf_update(elf, ELF_C_WRITE) < 0) {
+		fprintf(stderr, "%s: elf_update (write) failed: %s\n",
+			__func__, elf_errmsg(elf_errno()));
+		goto out;
 	}
+	err = 0;
 
 out:
+	if (str_table)
+		free(str_table);
 	if (fd != -1)
 		close(fd);
 	if (elf)
-- 
2.30.0.280.ga3ce27912f-goog

