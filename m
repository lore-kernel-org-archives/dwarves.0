Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D39EC6379D
	for <linux-dwarves@archiver.kernel.org>; Tue, 24 Nov 2020 16:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21C9A206C0
	for <linux-dwarves@archiver.kernel.org>; Tue, 24 Nov 2020 16:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390290AbgKXQT3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 24 Nov 2020 11:19:29 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:53480 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388568AbgKXQT3 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 24 Nov 2020 11:19:29 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-uI6aVNfhPeGlON9xgfZbPw-1; Tue, 24 Nov 2020 11:19:26 -0500
X-MC-Unique: uI6aVNfhPeGlON9xgfZbPw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00212107B45A;
        Tue, 24 Nov 2020 16:19:25 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.200])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CBC194D;
        Tue, 24 Nov 2020 16:19:22 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCH 1/2] btf_encoder: Factor filter_functions function
Date:   Tue, 24 Nov 2020 17:19:18 +0100
Message-Id: <20201124161919.2152187-2-jolsa@kernel.org>
In-Reply-To: <20201124161919.2152187-1-jolsa@kernel.org>
References: <20201124161919.2152187-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Reorder the filter_functions function so we can add
processing of kernel modules in following patch.

There's no functional change intended.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 btf_encoder.c | 57 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 20 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index c40f059580da..467c4657b2c0 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -101,14 +101,17 @@ static int addrs_cmp(const void *_a, const void *_b)
 	return *a < *b ? -1 : 1;
 }
 
-static int filter_functions(struct btf_elf *btfe, struct funcs_layout *fl)
+static int get_vmlinux_addrs(struct btf_elf *btfe, struct funcs_layout *fl,
+			     unsigned long **paddrs, unsigned long *pcount)
 {
-	unsigned long *addrs, count, offset, i;
-	int functions_valid = 0;
+	unsigned long *addrs, count, offset;
 	Elf_Data *data;
 	GElf_Shdr shdr;
 	Elf_Scn *sec;
 
+	if (!fl->mcount_start || !fl->mcount_stop)
+		return 0;
+
 	/*
 	 * Find mcount addressed marked by __start_mcount_loc
 	 * and __stop_mcount_loc symbols and load them into
@@ -138,7 +141,32 @@ static int filter_functions(struct btf_elf *btfe, struct funcs_layout *fl)
 	}
 
 	memcpy(addrs, data->d_buf + offset, count * sizeof(addrs[0]));
+	*paddrs = addrs;
+	*pcount = count;
+	return 0;
+}
+
+static int setup_functions(struct btf_elf *btfe, struct funcs_layout *fl)
+{
+	unsigned long *addrs = NULL, count, i;
+	int functions_valid = 0;
+
+	/*
+	 * Check if we are processing vmlinux image and
+	 * get mcount data if it's detected.
+	 */
+	if (get_vmlinux_addrs(btfe, fl, &addrs, &count))
+		return -1;
+
+	if (!addrs) {
+		if (btf_elf__verbose)
+			printf("ftrace symbols not detected, falling back to DWARF data\n");
+		delete_functions();
+		return 0;
+	}
+
 	qsort(addrs, count, sizeof(addrs[0]), addrs_cmp);
+	qsort(functions, functions_cnt, sizeof(functions[0]), functions_cmp);
 
 	/*
 	 * Let's got through all collected functions and filter
@@ -162,6 +190,9 @@ static int filter_functions(struct btf_elf *btfe, struct funcs_layout *fl)
 
 	functions_cnt = functions_valid;
 	free(addrs);
+
+	if (btf_elf__verbose)
+		printf("Found %d functions!\n", functions_cnt);
 	return 0;
 }
 
@@ -470,11 +501,6 @@ static void collect_symbol(GElf_Sym *sym, struct funcs_layout *fl)
 		fl->mcount_stop = sym->st_value;
 }
 
-static int has_all_symbols(struct funcs_layout *fl)
-{
-	return fl->mcount_start && fl->mcount_stop;
-}
-
 static int collect_symbols(struct btf_elf *btfe, bool collect_percpu_vars)
 {
 	struct funcs_layout fl = { };
@@ -501,18 +527,9 @@ static int collect_symbols(struct btf_elf *btfe, bool collect_percpu_vars)
 			printf("Found %d per-CPU variables!\n", percpu_var_cnt);
 	}
 
-	if (functions_cnt && has_all_symbols(&fl)) {
-		qsort(functions, functions_cnt, sizeof(functions[0]), functions_cmp);
-		if (filter_functions(btfe, &fl)) {
-			fprintf(stderr, "Failed to filter dwarf functions\n");
-			return -1;
-		}
-		if (btf_elf__verbose)
-			printf("Found %d functions!\n", functions_cnt);
-	} else {
-		if (btf_elf__verbose)
-			printf("ftrace symbols not detected, falling back to DWARF data\n");
-		delete_functions();
+	if (functions_cnt && setup_functions(btfe, &fl)) {
+		fprintf(stderr, "Failed to filter dwarf functions\n");
+		return -1;
 	}
 
 	return 0;
-- 
2.26.2

