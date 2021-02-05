Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03435C433E0
	for <linux-dwarves@archiver.kernel.org>; Fri,  5 Feb 2021 13:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B693A64FBC
	for <linux-dwarves@archiver.kernel.org>; Fri,  5 Feb 2021 13:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhBENpr (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 5 Feb 2021 08:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbhBENnh (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Fri, 5 Feb 2021 08:43:37 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38084C061222
        for <dwarves@vger.kernel.org>; Fri,  5 Feb 2021 05:42:48 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id b62so3800458wmc.5
        for <dwarves@vger.kernel.org>; Fri, 05 Feb 2021 05:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=bhWfXx9Qgpn0E0Ol053PNCp6i4yy+5CeY3XooaJfTt8=;
        b=O0/3dIv+NX7O4GuQZ8vFvL45ODVXKFXA38Ur0roS5Cy2+wODqwrmN3BeoNnIVtitfn
         tOwVGgRrMlNQtWhEmXOoM45N8UD7HIpfnl4XMDJEuuFutlWGsXbcyC/e3ANBAK8tFk1B
         eLoGBq7KnVQwWlcqIz099cOYWDzsIW6LLMBCc5hT465poxUojcDl7YUSdiykSN3LZ2AF
         Twj72dUHH5bgLHwAkcSfrEQdB/C1C3oj8yyNWETdJlLnHQrBR+epa/t0bZCkGDnUW1hS
         D0pXwIMvv3W4KSiHofeX7wIXRfNUxPF8t7afYmGPhhI59aTTQI3PUxskX4Cf0orZWJVW
         ejtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bhWfXx9Qgpn0E0Ol053PNCp6i4yy+5CeY3XooaJfTt8=;
        b=gfMfI5UpVRxi3GSfJMpfX1xLmbYkMsaT3CgVGc8tR2g5KXELKdzyfxPk9og8Co20wV
         9Di+2N3szxYx5tML0XvgDAwSwYOnkJ4dXWoi9kUKZw//LDcxXZ9N+snsY4BEpqet50XQ
         bmxT9gfnrxobnTEmJCmVVCRuinVOWWzb8MR4cyMilmOTmmP/iBadkqcGg8cRAncUfPZH
         0TRtkmCzwGQ9jM9BoXwBwuvMdiAR9PHDGxSsjxC2eLU6ZxyLIbv8PlP1v17cUQ3UGL3y
         GFZulu8Af9vXVUe9qOQdNqI8INUHBS0KfxmQKyMb0PgOBhVTVKk44xa7AU+wT8LkNEsy
         zgiQ==
X-Gm-Message-State: AOAM5310nYvwVXC3OQYbh7xiMvfQVvl58512oz53XcizcKui50H+i5iT
        CpVRVGqJHhsuPObfYt4xsR/vU3XrDTm1aaxkgleC7URPeA6zQOGZsj5zsqr6IOeBvvG+j9KCV/b
        GMpk7wBiw+0QiXQltadmQE65BlzET5XC1L5Ml6UEMJE6i3nS3CJJvtKV/6jjMlhMu1Fr/
X-Google-Smtp-Source: ABdhPJx7SUfQq5sqjd7T84qgQzY7enqhVF5EUx7LVx002Wfk2U31hjpfIKjEHtRD1tkeQ5+QM2tqV92Da6ZW6Q==
Sender: "gprocida via sendgmr" <gprocida@tef.lon.corp.google.com>
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:110:656b:9716:1ea:3de6])
 (user=gprocida job=sendgmr) by 2002:a05:600c:35c9:: with SMTP id
 r9mr447046wmq.0.1612532565173; Fri, 05 Feb 2021 05:42:45 -0800 (PST)
Date:   Fri,  5 Feb 2021 13:42:20 +0000
In-Reply-To: <20210205134221.2953163-1-gprocida@google.com>
Message-Id: <20210205134221.2953163-5-gprocida@google.com>
Mime-Version: 1.0
References: <20210201172530.1141087-1-gprocida@google.com> <20210205134221.2953163-1-gprocida@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH dwarves v3 4/5] btf_encoder: Add .BTF section using libelf
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

Layout is left completely up to libelf and existing section offsets
are likely to change.

Signed-off-by: Giuliano Procida <gprocida@google.com>
---
 libbtf.c | 127 +++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 81 insertions(+), 46 deletions(-)

diff --git a/libbtf.c b/libbtf.c
index 4ae7150..9f4abb3 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -698,6 +698,7 @@ int32_t btf_elf__add_datasec_type(struct btf_elf *btfe, const char *section_name
 
 static int btf_elf__write(const char *filename, struct btf *btf)
 {
+	const char dot_BTF[] = ".BTF";
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
+		if (strcmp(secname, dot_BTF) == 0) {
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
+		size_t new_str_size = dot_btf_offset + sizeof(dot_BTF);
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
+		memcpy(str_table + dot_btf_offset, dot_BTF, sizeof(dot_BTF));
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

