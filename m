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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342E9C43332
	for <linux-dwarves@archiver.kernel.org>; Mon,  1 Feb 2021 17:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 037ED64EBB
	for <linux-dwarves@archiver.kernel.org>; Mon,  1 Feb 2021 17:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbhBAR1H (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 1 Feb 2021 12:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbhBAR0r (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 1 Feb 2021 12:26:47 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F49C061793
        for <dwarves@vger.kernel.org>; Mon,  1 Feb 2021 09:26:07 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id o17so10788660wrv.4
        for <dwarves@vger.kernel.org>; Mon, 01 Feb 2021 09:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=2RQrtF4Yu/7TyUfyq3im7rIOCZ1idrksD+9OKNcN2CM=;
        b=KN1IiaHpAKfiWqYWp+yXLt0HSXylS1CHtzydscr1Z+p3MKyQ/1bbQuzEDeUKJ1+faG
         ADX3YTaaoft30bmkGRRv65kb11Y0O/tqyQdD8hjANJkNJLx4cmIyjhXqtBwwBGCsI7H3
         p6rYN1smuiWDyWhqtRR0M/BSQqJE+ReW6ftnJjh1aCoYud2J0vUPWd6s438Ni4M9gWZT
         3rb9354DJOZn7Nh7FE7yje+lFPs2bjp9XzYKBaS+qKxmYcZBrlhCGms+YVUeWTDn1+Je
         ygipHY6YdjONdFHFAmSRCUchgEtmlgoXBY1CQ+9KUGLkmc+RtD9zwBois5Zah1F04qw1
         0JKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2RQrtF4Yu/7TyUfyq3im7rIOCZ1idrksD+9OKNcN2CM=;
        b=S9bXFvkrUATeeeY5HphKZxfdfsdjWT8tQ1MDiKUssb+pHC0Ri0hPfN3ODy7KWLJGZ4
         XTUlAxyzNg72gv/pHNVZYp561TiaDI/Ed8mwn/ove2+q1eHVTiDAmrhyTOB8p2vwXIYZ
         U4yL+/Wq8u89860MnTOditgoa0Fd+vPnrRNK/Yq8maygtdewXWZKDrltL5oyWzAKwTcC
         dYzJQPXncnkXm1hFhQRAYSG8p+D9VN7L82miCjsE18WBt6m2RqkHPGBhWleJMmXLx8bz
         Wh2lBkx4qIfb04c+SwjT2km7Cdtjq/ktV3dltvZRASRqaeVFWK8BFNsCCUl+XGCcws2q
         4BMw==
X-Gm-Message-State: AOAM532ozoPjC02/tK9ogHVCPJqbMuqk35K1UyEDqZajaZ7O1Y2w+El1
        4J6EBEOOZP5APuhuftYTJ0/jz2KYFHN9ftEX0LM4L7hYLMz2xxE1BPM6+GwnwEybgq0pDJec00W
        Wi2Slt77qqCekeNVTcH8tOdo0rAb3vuGaJmqbs3yjln5AjkhpKMiPaLWZuaXDqK8CPEJ4
X-Google-Smtp-Source: ABdhPJzK+cSTbTHYsovUlZQ9WWYjGZmtSASuzYrI0Lfjb8GQccezB8Z/Vy72r7WQ5RS4vt7eHQ+xHhlVFkuPjw==
Sender: "gprocida via sendgmr" <gprocida@tef.lon.corp.google.com>
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:210:6893:b158:d9db:277c])
 (user=gprocida job=sendgmr) by 2002:a05:600c:35c9:: with SMTP id
 r9mr87875wmq.0.1612200365467; Mon, 01 Feb 2021 09:26:05 -0800 (PST)
Date:   Mon,  1 Feb 2021 17:25:29 +0000
In-Reply-To: <20210201172530.1141087-1-gprocida@google.com>
Message-Id: <20210201172530.1141087-4-gprocida@google.com>
Mime-Version: 1.0
References: <87a83353155506cc02141e6e4108d89aa4e7d284> <20210201172530.1141087-1-gprocida@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH dwarves v2 3/4] btf_encoder: Add .BTF as a loadable segment
From:   Giuliano Procida <gprocida@google.com>
To:     dwarves@vger.kernel.org
Cc:     acme@kernel.org, andrii@kernel.org, ast@kernel.org,
        gprocida@google.com, maennich@google.com, kernel-team@android.com,
        kernel-team@fb.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

In addition to adding .BTF to the Section Header Table, we also need
to add it to the Program Header Table and rewrite the PHT's
description of itself.

The segment as loadbale, at address 0 and read-only.

Signed-off-by: Giuliano Procida <gprocida@google.com>
---
 libbtf.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/libbtf.c b/libbtf.c
index 6e06a58..048a873 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -699,6 +699,7 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 	int fd, err = -1;
 	size_t strndx;
 	void *str_table = NULL;
+	GElf_Phdr *pht = NULL;
 
 	fd = open(filename, O_RDWR);
 	if (fd < 0) {
@@ -900,6 +901,47 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 		goto out;
 	}
 
+	size_t phnum = 0;
+	if (!elf_getphdrnum(elf, &phnum)) {
+		pht = malloc((phnum + 1) * sizeof(GElf_Phdr));
+		if (!pht) {
+			fprintf(stderr, "%s: malloc (PHT) failed\n", __func__);
+			goto out;
+		}
+		for (size_t ix = 0; ix < phnum; ++ix) {
+			if (!gelf_getphdr(elf, ix, &pht[ix])) {
+				fprintf(stderr,
+					"%s: gelf_getphdr(%zu) failed: %s\n",
+					__func__, ix, elf_errmsg(elf_errno()));
+				goto out;
+			}
+			if (pht[ix].p_type == PT_PHDR) {
+				size_t fsize = gelf_fsize(elf, ELF_T_PHDR,
+							  phnum+1, EV_CURRENT);
+				pht[ix].p_memsz = pht[ix].p_filesz = fsize;
+			}
+		}
+		pht[phnum].p_type = PT_LOAD;
+		pht[phnum].p_offset = btf_shdr->sh_offset;
+		pht[phnum].p_memsz = pht[phnum].p_filesz = btf_shdr->sh_size;
+		pht[phnum].p_vaddr = pht[phnum].p_paddr = 0;
+		pht[phnum].p_flags = PF_R;
+		void *phdr = gelf_newphdr(elf, phnum+1);
+		if (!phdr) {
+			fprintf(stderr, "%s: gelf_newphdr failed: %s\n",
+				__func__, elf_errmsg(elf_errno()));
+			goto out;
+		}
+		for (size_t ix = 0; ix < phnum+1; ++ix) {
+			if (!gelf_update_phdr(elf, ix, &pht[ix])) {
+				fprintf(stderr,
+					"%s: gelf_update_phdr(%zu) failed: %s\n",
+					__func__, ix, elf_errmsg(elf_errno()));
+				goto out;
+			}
+		}
+	}
+
 	if (elf_update(elf, ELF_C_WRITE) < 0) {
 		fprintf(stderr, "%s: elf_update (write) failed: %s\n",
 			__func__, elf_errmsg(elf_errno()));
@@ -908,6 +950,8 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 	err = 0;
 
 out:
+	if (pht)
+		free(pht);
 	if (str_table)
 		free(str_table);
 	if (fd != -1)
-- 
2.30.0.365.g02bc693789-goog

