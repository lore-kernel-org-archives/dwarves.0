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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B52C433E0
	for <linux-dwarves@archiver.kernel.org>; Tue, 26 Jan 2021 05:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE6A4229C4
	for <linux-dwarves@archiver.kernel.org>; Tue, 26 Jan 2021 05:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbhAZFnL (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728620AbhAYNJU (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 25 Jan 2021 08:09:20 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2757AC06178C
        for <dwarves@vger.kernel.org>; Mon, 25 Jan 2021 05:06:43 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id m1so9096143qvp.0
        for <dwarves@vger.kernel.org>; Mon, 25 Jan 2021 05:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=dOg1QiodelMO3s6QTltbxMRrhmZPrGedZT/RtjNu99c=;
        b=ST28h8YK/Crnldiv/p9MQDP3VykreTpd8muxiNoUUf9g5+fE9n89ABEVaGsA/DmZmM
         QGLLmEMwgzoT1zm9zXhE2fbBsIYFVHxwCdXWF73Cm7ZflJVLP/IxZAglhmHNz18rY0VR
         YbWoFf+iky/tjPSyZxqF7OZ1Q9Fb7azOxLiEV2JYdTMdlOBA5/xrmIIxRG3/GYpQo0oe
         oVk9M1Gulu6CpzXlQZ4RbpzQTV/fYc/qyybOsFKIMJJ5XBmhyhjloCWBEPfiHHIVjCkv
         b3L0LiAs9jhn1i0FeC3v4egOe61hvfQpBqtHuOGXYBdir4UGnsspTwxdEkpTBuhYz0z6
         SWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dOg1QiodelMO3s6QTltbxMRrhmZPrGedZT/RtjNu99c=;
        b=Yf8RE35OfXXANSpWqzadrtD17urXeB/CxS0VNgUc41eSiHvG7gx5GYLYTfuPvCJHYm
         GVXD8e3paSIBWpqD0j1exAK6HDZJzO9jurFt2qRUbsWvJPWub7GOZHRptewxaiIqls55
         ZWZnExHf1kcgpUt5O8Ow/2CGcid0CYzr1UIbOHaR0Td5mpYl81F3ab9gyhXIHgSMYy+A
         zRuqkXR3Q3QGgaytQ/Nl4JJ/0QXOSs68TMZ+Q7waEAoy3rrE4N4dDVzkrdYyWMCx4SbB
         N8WJPU7bT2A86ZgS7Xxd2hAxvim5qRcWIHSQA7Ou4KZbk45BP0K7orkkzq8/a0WIi1fF
         e3Tg==
X-Gm-Message-State: AOAM5321llsTeQUvO4TxIZnn5gbbqgPi/CYmgIN6SDuTmgP3YX/qv4j7
        6QgJLqA2Ke4vTztDtTj3DdRaMUcMVI1Zbq5NfJg2N7zJcVXPMwrZGFbsd4KcmLIG6K13DnmLeua
        53Xtqx1RseWmNC/hMWGTVYaMchllTqm0yEHsOYvnHpJUN+YewLacYBonG/H2wTPUA9PjH
X-Google-Smtp-Source: ABdhPJxusPLuu8L6cOjZfu56gUEvavUCd/ln5OPZq6PolJbVhPzw4BWDFA5NKBaKijfx+MGp8ONe9qBn4wrRkw==
Sender: "gprocida via sendgmr" <gprocida@tef.lon.corp.google.com>
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:110:a6ae:11ff:fe11:4f04])
 (user=gprocida job=sendgmr) by 2002:a05:6214:913:: with SMTP id
 dj19mr575947qvb.33.1611580001730; Mon, 25 Jan 2021 05:06:41 -0800 (PST)
Date:   Mon, 25 Jan 2021 13:06:24 +0000
In-Reply-To: <20210125130625.2030186-1-gprocida@google.com>
Message-Id: <20210125130625.2030186-4-gprocida@google.com>
Mime-Version: 1.0
References: <20210125130625.2030186-1-gprocida@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH dwarves 3/4] btf_encoder: Manually lay out updated ELF sections
From:   Giuliano Procida <gprocida@google.com>
To:     dwarves@vger.kernel.org
Cc:     acme@kernel.org, andrii@kernel.org, ast@kernel.org,
        gprocida@google.com, maennich@google.com, kernel-team@android.com,
        kernel-team@fb.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

pahole -J needs to do the following to an ELF file:

* add or update the ".BTF" section
* maybe update the section name string table
* update the Section Header Table (SHT)

libelf either takes full control of layout or requires the user to
specify offset, size and alignment of all new and updated sections and
headers.

To avoid libelf moving program segments in particular, we position the
".BTF" and section name string table (typically named ".shstrtab")
sections after all others. The SHT always lives at the end of the file.

Note that the last section in an ELF file is normally the section name
string table and any ".BTF" section will normally be second last.
However, if these sections appear earlier, then we'll waste some space
in the ELF file when we rewrite them.

Signed-off-by: Giuliano Procida <gprocida@google.com>
---
 libbtf.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/libbtf.c b/libbtf.c
index fb8e043..4726e16 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -742,9 +742,28 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 	}
 
 	/*
-	 * First we check if there is already a .BTF section present.
+	 * The SHT is at the very end of the ELF and gets re-written in any case.
+	 *
+	 * We'll always add or update the .BTF section and when adding have to
+	 * re-write the section name string table (usually named .shstrtab). In
+	 * fact, as good citizens, we'll always leave the string table last, in
+	 * case someone else wants to add a section.
+	 *
+	 * However, if .BTF or the section name string table are followed by
+	 * further sections, we'll not try to be clever about shuffling
+	 * everything else in the ELF file, we'll just leave some dead space.
+	 * This actually happens in practice with vmlinux which has .strtab
+	 * after .shstrtab, resulting in a (small) hole the size of the original
+	 * .shstrtab.
+	 */
+
+	/*
+	 * First we look if there was already a .BTF section present and
+	 * determine the first usable offset in the ELF (for .BTF and the
+	 * section name table).
 	 */
 	elf_getshdrstrndx(elf, &strndx);
+	size_t high_water_mark = 0;
 	Elf_Scn *btf_scn = 0;
 	while ((scn = elf_nextscn(elf, scn)) != NULL) {
 		shdr = gelf_getshdr(scn, &shdr_mem);
@@ -753,7 +772,10 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 		char *secname = elf_strptr(elf, strndx, shdr->sh_name);
 		if (strcmp(secname, ".BTF") == 0) {
 			btf_scn = scn;
-			break;
+		} else if (elf_ndxscn(scn) != strndx) {
+			size_t limit = shdr->sh_offset + shdr->sh_size;
+			if (limit > high_water_mark)
+				high_water_mark = limit;
 		}
 	}
 
@@ -762,6 +784,12 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 		fprintf(stderr, "%s: elf_getscn(strndx) failed\n", __func__);
 		goto out;
 	}
+	GElf_Shdr str_shdr_mem;
+	GElf_Shdr *str_shdr = gelf_getshdr(str_scn, &str_shdr_mem);
+	if (!str_shdr) {
+		fprintf(stderr, "%s: elf_getshdr(str_scn) failed\n", __func__);
+		goto out;
+	}
 
 	size_t dot_btf_offset = 0;
 	if (btf_scn) {
@@ -793,6 +821,7 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 		str_data->d_buf = str_table;
 		str_data->d_size = new_str_size;
 		elf_flagdata(str_data, ELF_C_SET, ELF_F_DIRTY);
+		str_shdr->sh_size = new_str_size;
 
 		/* Create a new section */
 		btf_scn = elf_newscn(elf);
@@ -812,12 +841,15 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 	/* (Re)populate the BTF section data */
 	raw_btf_data = btf__get_raw_data(btf, &raw_btf_size);
 	btf_data->d_buf = (void *)raw_btf_data;
+	btf_data->d_off = 0;
 	btf_data->d_size = raw_btf_size;
 	btf_data->d_type = ELF_T_BYTE;
 	btf_data->d_version = EV_CURRENT;
 	elf_flagdata(btf_data, ELF_C_SET, ELF_F_DIRTY);
 
 	/* Update .BTF section in the SHT */
+	size_t new_btf_offset = high_water_mark;
+	size_t new_btf_size = raw_btf_size;
 	GElf_Shdr btf_shdr_mem;
 	GElf_Shdr *btf_shdr = gelf_getshdr(btf_scn, &btf_shdr_mem);
 	if (!btf_shdr) {
@@ -829,6 +861,8 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 	btf_shdr->sh_flags = 0;
 	if (dot_btf_offset)
 		btf_shdr->sh_name = dot_btf_offset;
+	btf_shdr->sh_offset = new_btf_offset;
+	btf_shdr->sh_size = new_btf_size;
 	btf_shdr->sh_type = SHT_PROGBITS;
 	if (!gelf_update_shdr(btf_scn, btf_shdr)) {
 		fprintf(stderr, "%s: gelf_update_shdr failed: %s\n",
@@ -836,6 +870,32 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 		goto out;
 	}
 
+	/* Update section name string table */
+	size_t new_str_offset = new_btf_offset + new_btf_size;
+	str_shdr->sh_offset = new_str_offset;
+	if (!gelf_update_shdr(str_scn, str_shdr)) {
+		fprintf(stderr, "gelf_update_shdr failed\n");
+		goto out;
+	}
+
+	/* Update SHT, allowing for ELF64 alignment */
+	size_t sht_offset = roundup(new_str_offset + str_shdr->sh_size, 8);
+	ehdr->e_shoff = sht_offset;
+	if (!gelf_update_ehdr(elf, ehdr)) {
+		fprintf(stderr, "gelf_update_ehdr failed\n");
+		goto out;
+	}
+
+	if (btf_elf__verbose) {
+		fprintf(stderr, ".BTF [0x%lx, +0x%lx)\n",
+			btf_shdr->sh_offset, btf_shdr->sh_size);
+		fprintf(stderr, ".shstrtab [0x%lx, +0x%lx)\n",
+			str_shdr->sh_offset, str_shdr->sh_size);
+		fprintf(stderr, "SHT [0x%lx, +%d*0x%x)\n",
+			ehdr->e_shoff, ehdr->e_shnum, ehdr->e_shentsize);
+	}
+
+	elf_flagelf(elf, ELF_C_SET, ELF_F_LAYOUT);
 	if (elf_update(elf, ELF_C_NULL) < 0) {
 		fprintf(stderr, "%s: elf_update (layout) failed: %s\n",
 			__func__, elf_errmsg(elf_errno()));
-- 
2.30.0.280.ga3ce27912f-goog

