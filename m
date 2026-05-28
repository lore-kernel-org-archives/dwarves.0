Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC48F279907
	for <dwarves@vger.kernel.org>; Thu, 28 May 2026 22:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780007805; cv=none; b=EGGQPw4if24thi0DKnovQckyFLJ/M2a0ecAASCiyqu0xS9e5I9JQDSKvQ+3LIvkU3DMviTCla0WbD6az1ANeA0dR52NMOFF5u8PkidtrpUf7ix3j164gQ7SmTRKliRlDW5UYAxbYUxMeO3mj/0pJHPzIX+zEuSHdNSlf/Y5+m/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780007805; c=relaxed/simple;
	bh=7roPbiFnnXS3rQAEhCNAPmEQtfXaUaQsUnu5esIU9vc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LNjGyiJhAesR8IEeVsrrhrTRzDJig7Fnv2g+UVnuos8IhqDrp6rZYdPg407R1RwHE1zxSwZWiI58JaAGTzDpJP96j63F23fbO6CHRv1dYn/shJawxSAFSkMU1iGHh1O1DuNyaQiexU9z7IG/sMcUnFMMNNygiW7YEzSFSVvmI6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uq/tibKu; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uq/tibKu"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780007791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uHk5KbbjVfZNvy/JdkHsDuPrfzh7M7BsJ3/z9XJfV3c=;
	b=uq/tibKuJbIuFvrVCFVTFW0nVHdu4PoxvKdppLb76atqvYXRyCbHvObi9DpbEzCGkEf4we
	bPLL/fk5sxINujxB0YTA/ELmH6UMdGBe5dyamS5Y8sn1FqBOCZ7hjyFWiaNBwwgmaK5hYR
	5RsxAzuDNAcTV/F8nGQ09g2pjn9rcxE=
From: Vineet Gupta <vineet.gupta@linux.dev>
To: dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	acme@kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	jose.marchesi@oracle.com,
	David Faust <david.faust@oracle.com>,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PAHOLE Patch v2 1/2] dwarf_loader: Extract die__add_btf_type_tag() helper [NFC]
Date: Thu, 28 May 2026 15:36:15 -0700
Message-ID: <20260528223616.2035618-1-vineet.gupta@linux.dev>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

NFC change preparing for DW_TAG_GNU_annotation support.
Extract the btf_type_tag annotation creation logic from into a helper
die__add_btf_type_tag().

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
Changes since v1 [1]
 - NFC reinstate some original comments

[1] https://lore.kernel.org/bpf/20260526181818.4159927-1-vineet.gupta@linux.dev/
---
 dwarf_loader.c | 58 +++++++++++++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 24 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 16fb7becffee..8fc9a6794f2f 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1600,14 +1600,45 @@ static struct btf_type_tag_type *die__create_new_btf_type_tag_type(Dwarf_Die *di
 	return tag;
 }
 
+static int die__add_btf_type_tag(struct btf_type_tag_ptr_type **tagp,
+				 Dwarf_Die *die, Dwarf_Die *adie,
+				 struct cu *cu, struct conf_load *conf)
+{
+	struct btf_type_tag_type *annot;
+	uint32_t id;
+
+	if (*tagp == NULL) {
+		/* Create a btf_type_tag_ptr type. */
+		*tagp = die__create_new_btf_type_tag_ptr_type(die, cu);
+		if (!*tagp)
+			return -ENOMEM;
+	}
+
+	/* Create a btf_type_tag type for this annotation. */
+	annot = die__create_new_btf_type_tag_type(adie, cu, conf);
+	if (annot == NULL)
+		return -ENOMEM;
+
+	if (cu__table_add_tag(cu, &annot->tag, &id) < 0)
+		return -ENOMEM;
+
+	struct dwarf_tag *dtag = tag__dwarf(&annot->tag);
+	dtag->small_id = id;
+	cu__hash(cu, &annot->tag);
+
+	/* For a list of DW_TAG_LLVM_annotation like tag1 -> tag2 -> tag3,
+	 * the tag->tags contains tag3 -> tag2 -> tag1.
+	 */
+	list_add(&annot->node, &(*tagp)->tags);
+	return 0;
+}
+
 static struct tag *die__create_new_pointer_tag(Dwarf_Die *die, struct cu *cu,
 					       struct conf_load *conf)
 {
 	struct btf_type_tag_ptr_type *tag = NULL;
-	struct btf_type_tag_type *annot;
 	Dwarf_Die *cdie, child;
 	const char *name;
-	uint32_t id;
 
 	/* If no child tags or skipping btf_type_tag encoding, just create a new tag
 	 * and return
@@ -1627,29 +1658,8 @@ static struct tag *die__create_new_pointer_tag(Dwarf_Die *die, struct cu *cu,
 		if (strcmp(name, "btf_type_tag") != 0)
 			continue;
 
-		if (tag == NULL) {
-			/* Create a btf_type_tag_ptr type. */
-			tag = die__create_new_btf_type_tag_ptr_type(die, cu);
-			if (!tag)
-				return NULL;
-		}
-
-		/* Create a btf_type_tag type for this annotation. */
-		annot = die__create_new_btf_type_tag_type(cdie, cu, conf);
-		if (annot == NULL)
+		if (die__add_btf_type_tag(&tag, die, cdie, cu, conf))
 			return NULL;
-
-		if (cu__table_add_tag(cu, &annot->tag, &id) < 0)
-			return NULL;
-
-		struct dwarf_tag *dtag = tag__dwarf(&annot->tag);
-		dtag->small_id = id;
-		cu__hash(cu, &annot->tag);
-
-		/* For a list of DW_TAG_LLVM_annotation like tag1 -> tag2 -> tag3,
-		 * the tag->tags contains tag3 -> tag2 -> tag1.
-		 */
-		list_add(&annot->node, &tag->tags);
 	} while (dwarf_siblingof(cdie, cdie) == 0);
 
 	return tag ? &tag->tag : tag__new(die, cu);
-- 
2.54.0

