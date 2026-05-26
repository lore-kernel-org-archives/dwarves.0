Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A897F3FDBFC
	for <dwarves@vger.kernel.org>; Tue, 26 May 2026 18:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779819522; cv=none; b=X3YvJZ5nybS1g7RLH1SZatMXra05YCseW3v1XoPkkeMUtTDHSJ7/YmKuOhBpluXlrSS8HWo6igAgcBlzcYTh9OmoLnrEG7QKzjSeE11rC/2pbO3+LYo023KbKgdWHo5eYclqtXPztxEPZ3AGruH+HyeM5h7SCAX4wnXfZiBGpUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779819522; c=relaxed/simple;
	bh=9W0XTRZgM6vyO0z0pyvc6/ghlKztWK+8w5stFQPop7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nLc7S3NIf98eEQIuj+5eDoPsEwBuxO5D/fNkXf6zbzijRoqAgBj+zIIMPAiaE1h+TJXmc0JVyFoiRvR3hBaRs87El6FSLsnvSBh8MzyYsCuRElUcDfUgvlXS2RlZBCGZgzaoST+2QplB2fhRXD6A46aVej05ZRr6IW4iNGMSclI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HmrympiW; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HmrympiW"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779819517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eyqvlvGrxY2dgFuzelEmEhJMrKgwtBvwQKpvyFr/HkI=;
	b=HmrympiWnIY7ojm+gw40T9xfeoZKlvUmPISD/1MP0eTgaqdZc3lCDZGWmyBA5KUwj5aYDv
	UvyVhc6ewvYahNBvd0370Xeibv3qHF3k3Hs+i5OpVnNKOZWLxIGFph+LyuhJKhkQURsRZT
	PzcI0EADY4BN/yfbC8xvfmiF9wawoRQ=
From: Vineet Gupta <vineet.gupta@linux.dev>
To: dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	acme@kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	jose.marchesi@oracle.com,
	David Faust <david.faust@oracle.com>,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PATCH 1/2] dwarf_loader: Extract die__add_btf_type_tag() helper
Date: Tue, 26 May 2026 11:18:17 -0700
Message-ID: <20260526181818.4159927-1-vineet.gupta@linux.dev>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Extract the btf_type_tag annotation creation logic from
die__create_new_pointer_tag() into a reusable die__add_btf_type_tag()
helper. Pure refactor with no functional change, preparing for
DW_TAG_GNU_annotation support.

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
 dwarf_loader.c | 54 +++++++++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 16fb7becffee..365cc24e212d 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1600,14 +1600,40 @@ static struct btf_type_tag_type *die__create_new_btf_type_tag_type(Dwarf_Die *di
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
+		*tagp = die__create_new_btf_type_tag_ptr_type(die, cu);
+		if (!*tagp)
+			return -ENOMEM;
+	}
+
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
@@ -1622,34 +1648,12 @@ static struct tag *die__create_new_pointer_tag(Dwarf_Die *die, struct cu *cu,
 		if (dwarf_tag(cdie) != DW_TAG_LLVM_annotation)
 			continue;
 
-		/* Only check btf_type_tag annotations */
 		name = attr_string(cdie, DW_AT_name, conf);
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

