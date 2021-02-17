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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A6FC433E0
	for <linux-dwarves@archiver.kernel.org>; Wed, 17 Feb 2021 11:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8589064DEC
	for <linux-dwarves@archiver.kernel.org>; Wed, 17 Feb 2021 11:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbhBQLKJ (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 17 Feb 2021 06:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbhBQLJz (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 17 Feb 2021 06:09:55 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6579FC061797
        for <dwarves@vger.kernel.org>; Wed, 17 Feb 2021 03:08:24 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id b201so2064764wmb.9
        for <dwarves@vger.kernel.org>; Wed, 17 Feb 2021 03:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=/jlrrw//5EBw0HxItehu19/zul9u1dKvK5phINfjwEk=;
        b=s13SxwqbF6VEmAgB0MOMVRv/Qo0IFrsZCbK/vRUoK1110OmI0lfLOl87udU+/ECgHi
         2TZTX9Y1VzOMZJRXiCuo503jWsCvZvfeZ94iYkfNIwVW5giC5/V2Uos5NFneM+FjJfn2
         yUfzuTvs1/wAyUQ8FIedv1v4Q4uJyLz+u5j2eHAnPIdsLJF436zqRHE/T0QAWNgZbypU
         G22K9d++X/SUaMT8ghhdxRBvtGjQuCerHzB3Sg/kNR0WNubRXUxpKSL1sEvAxpufW8Jl
         oPq234NoTsmcjUBzmcMmvxiT0EaF2odqXzGzh8pJ6fMy8IUL61MVZtgmK7UCVa+Sr2s+
         0elw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/jlrrw//5EBw0HxItehu19/zul9u1dKvK5phINfjwEk=;
        b=F28iJvsaeqsUFY7ARcXUeiocfQL6Iu/lWHGZdpN+Zp8qN8epI+bf/qef3Ksw7D9iAL
         sZbYGbsTy7X++vhltuLHSerDQPEm3oxKXaj6xcOHoJ3Ddd66B6DX5OZbG4FrYp6IhuxZ
         XuQs5phEA3KMkU8at+TJBz4bjF6WekGLK711G+5CFva1tVa9gnWLnOgUBjwgS177wcvi
         Vqqe/1sqDl+D0d3Bm29Yc8+rulo2V3wepqosBa4AJkGk/U9tw1WEv089w8+4cVrTdoc5
         r4oDuxbq6Zw0GQoWEgPBtq5+jkyFQpJM7i+r3sWgZKcaFNcG4NGQ6SMdW/Z9zNvyMEZi
         qstA==
X-Gm-Message-State: AOAM5327GNJMxH1gsG/SmaLAWgv/rx0v5mVC3qL682CNR7QXuIQEnWOo
        KfZ9nUEoO13aT8C41X5JiLcFbs+gBqG1NwGUzRCGK1lUK8poonP72VhIrSUZ3sv7lxRRmMCHpOp
        ziuEI74l2JVCMnJ3yq/5fPk/AN9sEcRn4NR4cYEq3qGJ7vaKcCjZD2fqOaQyXd31SMgF9
X-Google-Smtp-Source: ABdhPJx1JLkbNWtWhwyTxH9S+q24GjVOq5lYO+EjG/IBH4jQH5Xb+2PfqDArpk3BaNPsDuZHEEXnCfAdmtcMYQ==
Sender: "gprocida via sendgmr" <gprocida@tef.lon.corp.google.com>
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:110:61b3:1cb2:c180:c3f])
 (user=gprocida job=sendgmr) by 2002:a7b:ce12:: with SMTP id
 m18mr6895587wmc.148.1613560103057; Wed, 17 Feb 2021 03:08:23 -0800 (PST)
Date:   Wed, 17 Feb 2021 11:08:03 +0000
In-Reply-To: <20210217110804.75923-1-gprocida@google.com>
Message-Id: <20210217110804.75923-5-gprocida@google.com>
Mime-Version: 1.0
References: <20210205134221.2953163-1-gprocida@google.com> <20210217110804.75923-1-gprocida@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH dwarves v4 4/5] btf_encoder: Add .BTF section using libelf
From:   Giuliano Procida <gprocida@google.com>
To:     dwarves@vger.kernel.org, acme@kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, gprocida@google.com,
        maennich@google.com, kernel-team@android.com, kernel-team@fb.com,
        bpf@vger.kernel.org
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

Layout is left completely up to libelf and existing section offsets
are likely to change.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Giuliano Procida <gprocida@google.com>
---
 libbtf.c | 127 +++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 81 insertions(+), 46 deletions(-)

diff --git a/libbtf.c b/libbtf.c
index 4ae7150..9ff03ca 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -698,6 +698,7 @@ int32_t btf_elf__add_datasec_type(struct btf_elf *btfe, const char *section_name
 
 static int btf_elf__write(const char *filename, struct btf *btf)
 {
+	const char BTF_SEC_NAME[] = ".BTF";
 	GElf_Ehdr ehdr;
 	Elf_Data *btf_data = NULL;
 	Elf *elf = NULL;
@@ -705,6 +706,7 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 	uint32_t raw_btf_size;
 	int fd, err = -1;
 	size_t strndx;
+	void *str_table = NULL;
 
 	fd = open(filename, O_RDWR);
 	if (fd < 0) {
@@ -743,73 +745,106 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 	}
 
 	/*
-	 * First we look if there was already a .BTF section to overwrite.
+	 * First we check if there is already a .BTF section present.
 	 */
-
 	elf_getshdrstrndx(elf, &strndx);
+	Elf_Scn *btf_scn = NULL;
 	for (Elf_Scn *scn = elf_nextscn(elf, NULL); scn; scn = elf_nextscn(elf, scn)) {
 		GElf_Shdr shdr;
 		if (!gelf_getshdr(scn, &shdr))
 			continue;
 		char *secname = elf_strptr(elf, strndx, shdr.sh_name);
-		if (strcmp(secname, ".BTF") == 0) {
-			btf_data = elf_getdata(scn, btf_data);
+		if (strcmp(secname, BTF_SEC_NAME) == 0) {
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
+		elf_error("elf_getscn(strndx) failed");
+		goto out;
+	}
 
-		if (elf_update(elf, ELF_C_NULL) >= 0 &&
-		    elf_update(elf, ELF_C_WRITE) >= 0)
-			err = 0;
-		else
-			elf_error("elf_update failed");
+	size_t dot_btf_offset = 0;
+	if (btf_scn) {
+		/* Existing .BTF section found */
+		btf_data = elf_getdata(btf_scn, NULL);
+		if (!btf_data) {
+			elf_error("elf_getdata failed");
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
+			elf_error("elf_getdata(str_scn) failed");
 			goto out;
 		}
-
-		if (write(fd, raw_btf_data, raw_btf_size) != raw_btf_size) {
-			fprintf(stderr, "%s: write of %d bytes to '%s' failed: %d!\n",
-				__func__, raw_btf_size, tmp_fn, errno);
-			goto unlink;
+		dot_btf_offset = str_data->d_size;
+		size_t new_str_size = dot_btf_offset + sizeof(BTF_SEC_NAME);
+		str_table = malloc(new_str_size);
+		if (!str_table) {
+			fprintf(stderr, "%s: malloc (strtab) failed\n", __func__);
+			goto out;
 		}
-
-		snprintf(cmd, sizeof(cmd), "%s --add-section .BTF=%s %s",
-			 llvm_objcopy, tmp_fn, filename);
-		if (system(cmd)) {
-			fprintf(stderr, "%s: failed to add .BTF section to '%s': %d!\n",
-				__func__, filename, errno);
-			goto unlink;
+		memcpy(str_table, str_data->d_buf, dot_btf_offset);
+		memcpy(str_table + dot_btf_offset, BTF_SEC_NAME, sizeof(BTF_SEC_NAME));
+		str_data->d_buf = str_table;
+		str_data->d_size = new_str_size;
+		elf_flagdata(str_data, ELF_C_SET, ELF_F_DIRTY);
+
+		/* Create a new section */
+		btf_scn = elf_newscn(elf);
+		if (!btf_scn) {
+			elf_error("elf_newscn failed");
+			goto out;
+		}
+		btf_data = elf_newdata(btf_scn);
+		if (!btf_data) {
+			elf_error("elf_newdata failed");
+			goto out;
 		}
+	}
+
+	/* (Re)populate the BTF section data */
+	raw_btf_data = btf__get_raw_data(btf, &raw_btf_size);
+	btf_data->d_buf = (void *)raw_btf_data;
+	btf_data->d_size = raw_btf_size;
+	btf_data->d_type = ELF_T_BYTE;
+	btf_data->d_version = EV_CURRENT;
+	elf_flagdata(btf_data, ELF_C_SET, ELF_F_DIRTY);
+
+	/* Update .BTF section in the SHT */
+	GElf_Shdr btf_shdr;
+	if (!gelf_getshdr(btf_scn, &btf_shdr)) {
+		elf_error("elf_getshdr(btf_scn) failed");
+		goto out;
+	}
+	btf_shdr.sh_entsize = 0;
+	btf_shdr.sh_flags = 0;
+	if (dot_btf_offset)
+		btf_shdr.sh_name = dot_btf_offset;
+	btf_shdr.sh_type = SHT_PROGBITS;
+	if (!gelf_update_shdr(btf_scn, &btf_shdr)) {
+		elf_error("gelf_update_shdr failed");
+		goto out;
+	}
 
-		err = 0;
-	unlink:
-		unlink(tmp_fn);
+	if (elf_update(elf, ELF_C_NULL) < 0) {
+		elf_error("elf_update (layout) failed");
+		goto out;
+	}
+
+	if (elf_update(elf, ELF_C_WRITE) < 0) {
+		elf_error("elf_update (write) failed");
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
2.30.0.478.g8a0d178c01-goog

