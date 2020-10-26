Return-Path: <SRS0=a5OZ=EB=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4599C4363A
	for <linux-dwarves@archiver.kernel.org>; Mon, 26 Oct 2020 22:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D54820878
	for <linux-dwarves@archiver.kernel.org>; Mon, 26 Oct 2020 22:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603751794;
	bh=PUjLXmjG8wQ6WNszKtPgodaQ/WvK7jviVkQTmw5U0Xs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Nf7EMgdqX89kdg5cd0FsZnhhDN4KWoaoFAbPkEWfDRWtT5KcnZo9eO7wE7zi1T9Jx
	 qTzoTOehx1aUqY0dG7yhQhLElsLgSpfNEM6Bb9Heidms/I9rDQ+gKTjrx4Wk56DVAV
	 cGSLDBm1qSqSJQtY0wya+cclscdvpANbl+jULurA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394412AbgJZWgd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 26 Oct 2020 18:36:33 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:21586 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390190AbgJZWgd (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 26 Oct 2020 18:36:33 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-58-yF8kCNxyDmn9fr2R2ew-1; Mon, 26 Oct 2020 18:36:27 -0400
X-MC-Unique: 58-yF8kCNxyDmn9fr2R2ew-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47EB4100738B;
        Mon, 26 Oct 2020 22:36:26 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2FAFC6EF50;
        Mon, 26 Oct 2020 22:36:24 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Subject: [PATCH 1/3] btf_encoder: Move find_all_percpu_vars in generic config function
Date:   Mon, 26 Oct 2020 23:36:15 +0100
Message-Id: <20201026223617.2868431-2-jolsa@kernel.org>
In-Reply-To: <20201026223617.2868431-1-jolsa@kernel.org>
References: <20201026223617.2868431-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Moving find_all_percpu_vars under generic onfig function
that walks over symbols and calls config_percpu_var.

We will add another config function that needs to go
through all the symbols, so it's better they go through
them just once.

There's no functional change intended.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 btf_encoder.c | 126 ++++++++++++++++++++++++++------------------------
 1 file changed, 66 insertions(+), 60 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 2a6455be4c52..2dd26c904039 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -250,7 +250,64 @@ static bool percpu_var_exists(uint64_t addr, uint32_t *sz, const char **name)
 	return true;
 }
 
-static int find_all_percpu_vars(struct btf_elf *btfe)
+static int config_percpu_var(struct btf_elf *btfe, GElf_Sym *sym)
+{
+	const char *sym_name;
+	uint64_t addr;
+	uint32_t size;
+
+	/* compare a symbol's shndx to determine if it's a percpu variable */
+	if (elf_sym__section(sym) != btfe->percpu_shndx)
+		return 0;
+	if (elf_sym__type(sym) != STT_OBJECT)
+		return 0;
+
+	addr = elf_sym__value(sym);
+	/*
+	 * Store only those symbols that have allocated space in the percpu section.
+	 * This excludes the following three types of symbols:
+	 *
+	 *  1. __ADDRESSABLE(sym), which are forcely emitted as symbols.
+	 *  2. __UNIQUE_ID(prefix), which are introduced to generate unique ids.
+	 *  3. __exitcall(fn), functions which are labeled as exit calls.
+	 *
+	 * In addition, the variables defined using DEFINE_PERCPU_FIRST are
+	 * also not included, which currently includes:
+	 *
+	 *  1. fixed_percpu_data
+	 */
+	if (!addr)
+		return 0;
+
+	sym_name = elf_sym__name(sym, btfe->symtab);
+	if (!btf_name_valid(sym_name)) {
+		dump_invalid_symbol("Found symbol of invalid name when encoding btf",
+				    sym_name, btf_elf__verbose, btf_elf__force);
+		return btf_elf__force ? 0 : -1;
+	}
+	size = elf_sym__size(sym);
+	if (!size) {
+		dump_invalid_symbol("Found symbol of zero size when encoding btf",
+				    sym_name, btf_elf__verbose, btf_elf__force);
+		return btf_elf__force ? 0 : -1;
+	}
+
+	if (btf_elf__verbose)
+		printf("Found per-CPU symbol '%s' at address 0x%lx\n", sym_name, addr);
+
+	if (percpu_var_cnt == MAX_PERCPU_VAR_CNT) {
+		fprintf(stderr, "Reached the limit of per-CPU variables: %d\n",
+			MAX_PERCPU_VAR_CNT);
+		return -1;
+	}
+	percpu_vars[percpu_var_cnt].addr = addr;
+	percpu_vars[percpu_var_cnt].sz = size;
+	percpu_vars[percpu_var_cnt].name = sym_name;
+	percpu_var_cnt++;
+	return 0;
+}
+
+static int config(struct btf_elf *btfe, bool do_percpu_vars)
 {
 	uint32_t core_id;
 	GElf_Sym sym;
@@ -260,69 +317,18 @@ static int find_all_percpu_vars(struct btf_elf *btfe)
 
 	/* search within symtab for percpu variables */
 	elf_symtab__for_each_symbol(btfe->symtab, core_id, sym) {
-		const char *sym_name;
-		uint64_t addr;
-		uint32_t size;
-
-		/* compare a symbol's shndx to determine if it's a percpu variable */
-		if (elf_sym__section(&sym) != btfe->percpu_shndx)
-			continue;
-		if (elf_sym__type(&sym) != STT_OBJECT)
-			continue;
-
-		addr = elf_sym__value(&sym);
-		/*
-		 * Store only those symbols that have allocated space in the percpu section.
-		 * This excludes the following three types of symbols:
-		 *
-		 *  1. __ADDRESSABLE(sym), which are forcely emitted as symbols.
-		 *  2. __UNIQUE_ID(prefix), which are introduced to generate unique ids.
-		 *  3. __exitcall(fn), functions which are labeled as exit calls.
-		 *
-		 * In addition, the variables defined using DEFINE_PERCPU_FIRST are
-		 * also not included, which currently includes:
-		 *
-		 *  1. fixed_percpu_data
-		 */
-		if (!addr)
-			continue;
-
-		sym_name = elf_sym__name(&sym, btfe->symtab);
-		if (!btf_name_valid(sym_name)) {
-			dump_invalid_symbol("Found symbol of invalid name when encoding btf",
-					    sym_name, btf_elf__verbose, btf_elf__force);
-			if (btf_elf__force)
-				continue;
+		if (do_percpu_vars && config_percpu_var(btfe, &sym))
 			return -1;
-		}
-		size = elf_sym__size(&sym);
-		if (!size) {
-			dump_invalid_symbol("Found symbol of zero size when encoding btf",
-					    sym_name, btf_elf__verbose, btf_elf__force);
-			if (btf_elf__force)
-				continue;
-			return -1;
-		}
+	}
 
-		if (btf_elf__verbose)
-			printf("Found per-CPU symbol '%s' at address 0x%lx\n", sym_name, addr);
+	if (do_percpu_vars) {
+		if (percpu_var_cnt)
+			qsort(percpu_vars, percpu_var_cnt, sizeof(percpu_vars[0]), percpu_var_cmp);
 
-		if (percpu_var_cnt == MAX_PERCPU_VAR_CNT) {
-			fprintf(stderr, "Reached the limit of per-CPU variables: %d\n",
-				MAX_PERCPU_VAR_CNT);
-			return -1;
-		}
-		percpu_vars[percpu_var_cnt].addr = addr;
-		percpu_vars[percpu_var_cnt].sz = size;
-		percpu_vars[percpu_var_cnt].name = sym_name;
-		percpu_var_cnt++;
+		if (btf_elf__verbose)
+			printf("Found %d per-CPU variables!\n", percpu_var_cnt);
 	}
 
-	if (percpu_var_cnt)
-		qsort(percpu_vars, percpu_var_cnt, sizeof(percpu_vars[0]), percpu_var_cmp);
-
-	if (btf_elf__verbose)
-		printf("Found %d per-CPU variables!\n", percpu_var_cnt);
 	return 0;
 }
 
@@ -351,7 +357,7 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 		if (!btfe)
 			return -1;
 
-		if (!skip_encoding_vars && find_all_percpu_vars(btfe))
+		if (config(btfe, !skip_encoding_vars))
 			goto out;
 
 		has_index_type = false;
-- 
2.26.2

