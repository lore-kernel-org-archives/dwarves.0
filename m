Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE15B456284;
	Wed, 29 Jul 2026 19:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352089; cv=none; b=egz8bzyukfLZBvH4UGcR5H9s8NLilZ4qc608co1Yc2Rs8xSS6hkFoSJ7Avex/CVDJ8cPGjNwWxyIAuGIHMardBJpNvWe+sh9Q53h+xRkRkbayXZOUWfq/Kz81vkZ3T+bwaDVPmEzwuHXiEIMHRp8rUcitNZUIBFVwpmqbru0FAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352089; c=relaxed/simple;
	bh=3Lt9VSJ59lloJBAqpUJMgbJ6gL5EC5YW+eqG95emNMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VKx+mPje7RfJifoIfuFVbyD/X3nRTF6KHGmLZlaQuiPPxHa1GtrtmO+rM74n1EakinRzimya6P1LShJ40eqbGo3T4kHlUo6fRfqRgJMDVVMQ4psjqyZAFiY/Ntr6NIUkA9iJ2RaWLjanCUlhyHq0BNjzd7m1gVadvNU8W4FfTe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQajnxgn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQajnxgn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A48B1F000E9;
	Wed, 29 Jul 2026 19:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785352088;
	bh=tGxF0XzXe8E9bj6vRovZ29tdqRuFMVR57NMMuYepgB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EQajnxgniboQ0J3vILZ7v6Bw0rcJYjkqcc7JWmJ1UlWmZSMwlZA6+UDYJ36akDB0E
	 1lHQd8ub7pgS4gabu4qso0e/tK94H3+0rCnrLno3s0/UeuJElK1hVqPQxaOy5+bNci
	 y50JY5l7F/WUhArCcJFxy2mIzAEz7Y6C0FrWvlCP7X34a/Eapn2oGsmHUWLyruahR+
	 tUL5gggKyaa3aq8kwKCzFOzsf3uDQI9KAS5t1TYNovMIHzqPnH3dvLmS20Qi7qQtqv
	 uDBhnpVXrNNcVntrhA0Eku9Xd0sOOQtBRTsRF5++0DLUV8ZCbMcKqVlmJ85/B9MEAh
	 JnX8rzs6ye+Mw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 13/31] btf_encoder: Fix early cleanup crashes in btf_encoder__new/delete
Date: Wed, 29 Jul 2026 16:07:13 -0300
Message-ID: <20260729190733.72876-14-acme@kernel.org>
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

Fix three issues in btf_encoder initialization and cleanup:

1. INIT_LIST_HEAD(&encoder->elf_functions_list) was done after two
   goto out_delete paths (strdup and btf__new failures).  Since the
   encoder is zalloc'd, elf_functions_list.next is NULL, so
   btf_encoder__delete() → elf_functions_list__clear() → list_for_each_safe
   dereferences NULL.  Move the INIT_LIST_HEAD to the start.

2. btf_encoder__delete() iterates secinfo[] unconditionally, but if
   the calloc for secinfo fails, the pointer is NULL while seccnt is
   already set, causing a NULL dereference.  Add a NULL guard.

3. Add NULL check for elf_strptr() return value before strcmp() in
   btf_encoder__write_elf(), preventing a crash on malformed ELF files.

Before: NULL deref on strdup failure + secinfo alloc failure + bad ELF
After:  clean error paths in all cases

Fixes: 99e78ff34f8171f9 ("btf_encoder: Introduce elf_functions_list")
Reported-by: Sashiko:gemini-3-1-pro-preview
Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 btf_encoder.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 0fbd7e3420b0457f..5c12e79f5ef648ba 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -2029,7 +2029,7 @@ static int btf_encoder__write_elf(struct btf_encoder *encoder, const struct btf
 		if (shdr == NULL)
 			continue;
 		char *secname = elf_strptr(elf, strndx, shdr->sh_name);
-		if (strcmp(secname, btf_secname) == 0) {
+		if (secname != NULL && strcmp(secname, btf_secname) == 0) {
 			btf_data = elf_getdata(scn, btf_data);
 			break;
 		}
@@ -2780,6 +2780,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 	struct elf_functions *funcs = NULL;
 
 	if (encoder) {
+		INIT_LIST_HEAD(&encoder->elf_functions_list);
 		encoder->cu = cu;
 		encoder->raw_output = detached_filename != NULL;
 		encoder->source_filename = strdup(cu->filename);
@@ -2818,7 +2819,6 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 		if (conf_load->encode_btf_global_vars)
 			encoder->encode_vars |= BTF_VAR_GLOBAL;
 
-		INIT_LIST_HEAD(&encoder->elf_functions_list);
 		funcs = btf_encoder__elf_functions(encoder);
 		if (!funcs)
 			goto out_delete;
@@ -2912,9 +2912,11 @@ void btf_encoder__delete(struct btf_encoder *encoder)
 	if (encoder == NULL)
 		return;
 
-	for (shndx = 0; shndx < encoder->seccnt; shndx++)
-		__gobuffer__delete(&encoder->secinfo[shndx].secinfo);
-	free(encoder->secinfo);
+	if (encoder->secinfo) {
+		for (shndx = 0; shndx < encoder->seccnt; shndx++)
+			__gobuffer__delete(&encoder->secinfo[shndx].secinfo);
+		free(encoder->secinfo);
+	}
 	zfree(&encoder->filename);
 	zfree(&encoder->source_filename);
 	btf__free(encoder->btf);
-- 
2.55.0

