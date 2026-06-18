Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0C4274FD0
	for <dwarves@vger.kernel.org>; Thu, 18 Jun 2026 00:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781744276; cv=none; b=ZB1lp1NrvlKhtaSic/AOTFBaKUHoT6R9I1cdrmGD3ZGT+y7j6zmfllv+muTgwYRwh6MKgRQ1d0Vge5kDMHqxkQkSkvn/Rld3qep2XB9+Uk5i+DLaNhJ099+55xzRfngsRyJZg1Fqm/rFnzE1lPAtOJg2RFGn5EGclSBv+U/GTSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781744276; c=relaxed/simple;
	bh=AzjY8+QzCdHnH3/Em3y1xcbFlKkWlZlJO5H2gQAiQNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXyAhCG6mXtjHK6FB+UwYkDrD8QsJHsE2YpURJ102GkqAuUlGrF7SnpySPOGcP5sTWnKyHuS5nj0D0+K3zXMI4yfJaonRo2H6Bocaq+AUAyZRB2cwaRvU+WOE1z2sVa6R/+UHNZePmvz1ngQRnGYkSVydYnvAo5AfWq1xUnK7X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sNf+3DN3; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sNf+3DN3"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781744272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BUakG8fjik13xPEz2DRSf5509YfWCpLcC7n1Ahdqzm4=;
	b=sNf+3DN3Tkzo12GER08FhTqpRCtxZyReCWGYk8eG9sQOI3RNKqZkcH/21AfSad8pm0mdOI
	a/EmxosViS5W3kr2KrjTDTxV4rYvbiFw/8O/hG59NYa1EKFwPzWoQPqqd5hG1T5d6ffz3J
	Txe5iK133KZrgbOcAUdYqX+U9QJl29o=
From: Vineet Gupta <vineet.gupta@linux.dev>
To: dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	acme@kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	jose.marchesi@oracle.com,
	David Faust <david.faust@oracle.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PAHOLE v5 2/5] dwarf_loader: Extract die__add_btf_type_tag() helper [NFC]
Date: Wed, 17 Jun 2026 17:57:28 -0700
Message-ID: <20260618005731.273181-3-vineet.gupta@linux.dev>
In-Reply-To: <20260618005731.273181-1-vineet.gupta@linux.dev>
References: <20260618005731.273181-1-vineet.gupta@linux.dev>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

NFC change preparing for DW_TAG_GNU_annotation support.
Extract the btf_type_tag annotation creation logic into helper
die__add_btf_type_tag().

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
---
Changes since v [4]
 - Collected the review tags [Emil, Yonghong]

Changes since v3 [3]
 - Fix comment to kernel style [Arnaldo]

Changes since v2 [2]
 - die__add_btf_type_tag() returns pointer not error code [Alan]

Changes since v1 [1]
 - NFC reinstate some original comments

[4] https://lore.kernel.org/bpf/20260602195512.1511013-1-vineet.gupta@linux.dev/
[3] https://lore.kernel.org/bpf/20260601183511.594100-1-vineet.gupta@linux.dev/
[2] https://lore.kernel.org/bpf/20260528223616.2035618-1-vineet.gupta@linux.dev/
[1] https://lore.kernel.org/bpf/20260526181818.4159927-1-vineet.gupta@linux.dev/
---
 dwarf_loader.c | 58 +++++++++++++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 24 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 16fb7becffee..42a0f3f74ce3 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1600,14 +1600,44 @@ static struct btf_type_tag_type *die__create_new_btf_type_tag_type(Dwarf_Die *di
 	return tag;
 }
 
+static struct btf_type_tag_ptr_type *die__add_btf_type_tag(struct btf_type_tag_ptr_type *tag,
+							    Dwarf_Die *die, Dwarf_Die *adie,
+							    struct cu *cu, struct conf_load *conf)
+{
+	struct btf_type_tag_type *annot;
+	uint32_t id;
+
+	if (tag == NULL) {
+		tag = die__create_new_btf_type_tag_ptr_type(die, cu);
+		if (!tag)
+			return NULL;
+	}
+
+	annot = die__create_new_btf_type_tag_type(adie, cu, conf);
+	if (annot == NULL)
+		return NULL;
+
+	if (cu__table_add_tag(cu, &annot->tag, &id) < 0)
+		return NULL;
+
+	struct dwarf_tag *dtag = tag__dwarf(&annot->tag);
+	dtag->small_id = id;
+	cu__hash(cu, &annot->tag);
+
+	/*
+	 * Prepends: for annotations tag1 -> tag2 -> tag3,
+	 * the tag->tags list ends up as tag3 -> tag2 -> tag1.
+	 */
+	list_add(&annot->node, &tag->tags);
+	return tag;
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
@@ -1627,29 +1657,9 @@ static struct tag *die__create_new_pointer_tag(Dwarf_Die *die, struct cu *cu,
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
-			return NULL;
-
-		if (cu__table_add_tag(cu, &annot->tag, &id) < 0)
+		tag = die__add_btf_type_tag(tag, die, cdie, cu, conf);
+		if (tag == NULL)
 			return NULL;
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

