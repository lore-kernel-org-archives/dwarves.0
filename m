Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E611B2C21D0
	for <dwarves@vger.kernel.org>; Thu, 18 Jun 2026 17:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781804014; cv=none; b=BU0NssB8PCfQ5+JW5g3NdqbzyTe790IIFmzWvnapWAAWOytd/RowePW/HD/NiJjlGcwirDpRRmwCHspdSa8GFf9qONPeiEdfeBBUP2pGfGNAxPMSU36kotqyz/NDYSlVvMluPqcnMf1KtNJaAcM5wG4Wd/FqOHugkmp3Fdb1Gic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781804014; c=relaxed/simple;
	bh=bTzEo2L9A8MjRx3VdeLSJ4Y9XQxxLKUNttSDG4sq8Ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UuTrc4kx8v2a2w3ntyaHICaqnqsZBlyZdKmuKspn7OZlUxC6OQlRfI7a8/f4/15EsHLvEznGOVnTcVMgpFWjhfdmGLkkwaYtXxchIC6M983yoMFNtRPzhdl3BA7zu/rJuSELDr5BtSoJ6pLwIg4oT0ZnKgZXBP4JLDel1fS7SFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMYaxi79; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMYaxi79"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F0B1F000E9;
	Thu, 18 Jun 2026 17:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781804013;
	bh=Q+QcMJXwpptHRS1Oa8BswUBGRa4pACaKeZN1LqXhd6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EMYaxi798uKbmWFmgihLhOhgOnL00EcxJ1JfG4Obnqi3boNTA9mvv99aL92M2J1gV
	 Trf1s2F8TCObNsU5NdMbYkXbOQGyP/ojM4R9FHiudlTOLU0vvTxgKefkSpjUAtmE4K
	 sOgOR0W/G+iRwhF/FhDYKYw+1PoVUUf8pU0LnAOc4XQrSyWjx8Cgs41RubW+J1FWxO
	 hgRxbcAIqsB8y340ukXrkx57UEHs3hr/ElhtQE0K6/uelUVej+DfbfHYxjIZd7/aKl
	 wg25dVh7xawK9li2QrEh6cif58rYMpYFywMkneMrEkKSuxzk/E4JpqUoJ0mwOh/hfx
	 ov6TCvVT7eb5Q==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 6/7] dwarves: Use tag__delete for enumeration children
Date: Thu, 18 Jun 2026 14:33:15 -0300
Message-ID: <20260618173316.83598-7-acme@kernel.org>
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

Now that enumeration children can be other tag types like
DW_TAG_subprogram, use the generic tag__delete() which handles all tag
types, removing the enumerator-specific wrapper.

Fixes: a1b3ec41fcc2433d ("dwarf_loader: Initial support for DW_TAG_subprogram in DW_TAG_enumeration")
Assisted-by: Claude:claude-opus-4-6-1m
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarves.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/dwarves.c b/dwarves.c
index 2af10588ff2f20c5..90e244afb017d7d2 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -1333,11 +1333,6 @@ void type__delete(struct type *type, struct cu *cu)
 	cu__tag_free(cu, type__tag(type));
 }
 
-static void enumerator__delete(struct enumerator *enumerator, struct cu *cu)
-{
-	cu__tag_free(cu, &enumerator->tag);
-}
-
 void enumeration__delete(struct type *type, struct cu *cu)
 {
 	struct enumerator *pos, *n;
@@ -1347,7 +1342,7 @@ void enumeration__delete(struct type *type, struct cu *cu)
 
 	type__for_each_enumerator_safe_reverse(type, pos, n) {
 		list_del_init(&pos->tag.node);
-		enumerator__delete(pos, cu);
+		tag__delete(&pos->tag, cu);
 	}
 
 	if (type->suffix_disambiguation)
-- 
2.54.0

