Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A2C345CDD
	for <dwarves@vger.kernel.org>; Thu, 18 Jun 2026 17:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781804010; cv=none; b=PVghQzUQ3Pfu3A85mPWjklF7ESGLmioV4LVZLbp+8vHAuJBkoee+J+gh6DYdSNaeZDvwAJz3bLZD0qMFnwxcWGwRvmt+fP5QFh5bA64whwFs0KBVIR2C122KkGrYlqa+GXx7lRCe+90qaDWa9ML0jCLaMvjdURWsE7E4qB2BrLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781804010; c=relaxed/simple;
	bh=8Z3xwV/6GQhZARPC+6W004BfEgJFPFIEP6uW7N/YOkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MEMTnk40R5AR1W/n+M7nwc4QBfXiTDP7s8pfYMNoeE3ijYgkcchFCGefpgCzEu800G7fiDVPb7drteM6gsdM+nmN77fvBoju59fP3NmmaGozRJoWgyLWu15sb9JUxh7MYzi7a8fTudqLxW3LQ+OpshINuQHPKdn21kcDUOe4I+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OnCa4aGE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnCa4aGE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C0F1F000E9;
	Thu, 18 Jun 2026 17:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781804009;
	bh=D+QUsj/ZpLLWjABAuN1T9iR5LOfK4ZYb6QPuT9oUn8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OnCa4aGEzJDRKazEuLq4urfU/q8nV8b64/mAC9VrdLp964H9uAUX1gYPT6cGfB/1J
	 /+2l0Ir9mYnk1H1H5Lrzba4inQuu2263735NDywBegWcAwSwMks8M8HvMoF0Jl3sZb
	 fISw+Rgh09PTn6IXABDQhxGVGXJUpQk2qc4/LaJ7n+ob3IHZFJTSJD/kxZgKBHLTY3
	 MSnKYG7vPPqTX4duq2EvTRUfoqK4zTshqA57QbzbGNipo2skMfIFcUvVosJNi5xZ1m
	 NO3YtfmOvUQ7uhxQuR5u5N51deQ1tULrIhzdRVAY/jg5Twt9LOd2/vO6D4vzYha3vF
	 aH4/ucwkujPDw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4/7] encoders: Fix diagnostic messages for unexpected tags in enumerations
Date: Thu, 18 Jun 2026 14:33:13 -0300
Message-ID: <20260618173316.83598-5-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618173316.83598-1-acme@kernel.org>
References: <20260618173316.83598-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Print the actual unexpected child tag's name and id instead of the
parent enumeration's, so the diagnostic message is useful for debugging.

Fixes: a1b3ec41fcc2433d ("dwarf_loader: Initial support for DW_TAG_subprogram in DW_TAG_enumeration")
Assisted-by: Claude:claude-opus-4-6-1m
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 btf_encoder.c     | 2 +-
 ctf_encoder.c     | 2 +-
 dwarves_fprintf.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index be880f3fdb32f792..12c22b003b7990bf 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1800,7 +1800,7 @@ static int32_t btf_encoder__add_enum_type(struct btf_encoder *encoder, struct ta
 	type__for_each_enumerator(etype, pos) {
 		if (pos->tag.tag != DW_TAG_enumerator) {
 			fprintf(stderr, "Unexpected DW_TAG_%s <%llx>, skipping it...\n",
-				dwarf_tag_name(tag->tag), tag__orig_id(tag, cu));
+				dwarf_tag_name(pos->tag.tag), tag__orig_id(&pos->tag, cu));
 			continue;
 		}
 		name = enumerator__name(pos);
diff --git a/ctf_encoder.c b/ctf_encoder.c
index 1c61c76ba20e06bc..f2c63c2b039026f8 100644
--- a/ctf_encoder.c
+++ b/ctf_encoder.c
@@ -157,7 +157,7 @@ static int enumeration_type__encode(struct tag *tag, const struct cu *cu, uint32
 	type__for_each_enumerator(etype, pos) {
 		if (pos->tag.tag != DW_TAG_enumerator) {
 			fprintf(stderr, "Unexpected DW_TAG_%s <%llx>, skipping it...\n",
-				dwarf_tag_name(tag->tag), tag__orig_id(tag, cu));
+				dwarf_tag_name(pos->tag.tag), tag__orig_id(&pos->tag, cu));
 			continue;
 		}
 		ctf__add_enumerator(ctf, pos->name, pos->value, &position);
diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
index a3c8b391b9222fcd..4b6edcce81ebce71 100644
--- a/dwarves_fprintf.c
+++ b/dwarves_fprintf.c
@@ -501,8 +501,8 @@ size_t enumeration__fprintf(const struct tag *tag, const struct cu *cu,
 						   (unsigned long long)pos->value);
 			break;
 		default:
-			printed += fprintf(fp, "/* Unexpected %s <%llx> */\n", dwarf_tag_name(tag->tag),
-					   tag__orig_id(tag, cu));
+			printed += fprintf(fp, "/* Unexpected %s <%llx> */\n", dwarf_tag_name(pos->tag.tag),
+					   tag__orig_id(&pos->tag, cu));
 			continue;
 		}
 		printed += fprintf(fp, ",\n");
-- 
2.54.0

