Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C86B34E744
	for <dwarves@vger.kernel.org>; Mon, 22 Jun 2026 20:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782159902; cv=none; b=A8thb/iGhwKZ/VQB2CvNhcK51Ry5DIvwEGXs+mO/r+xIrwiw2JpmSQ4Z/S56XbqdYdbQLMKTLae2TyIomiBQvno0k69iGYnYdmOA5ccOGV6cunYeMZXuXNoojbohSee+IIyv9EuuSpvEU/ughpzp4l9mOfq/7+7TqKn2KUAekmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782159902; c=relaxed/simple;
	bh=QoR5Gjkf3zyYVxHuA6lm25ZqLsyvX2Wn3wsWmTxG/x4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MFYovAr2iYLZoG0P4Io4fMk5k3fHZkQhVk8ZZiQA3Fu1muXSKxODQbGZIH5zZ4mntYpGFLsLa48Xw3aEpVpdE6apoOSV8kZ8bCjxHRnfvPsoB6IQa0dg43VbYdaafFnbnZla8HSv5e0f/4E4kHm+BxYWqKUTdEC3hvnVunIyU+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0D62Wj6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0D62Wj6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E5AE1F000E9;
	Mon, 22 Jun 2026 20:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782159901;
	bh=yjXHat9s33h2Q/wLtFy7nGx/T7QaMeXEYX0HIOWMxxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g0D62Wj6j+h8zyqlJMY/cxM+DmQtndZdRsUeHrL0kK5naZRoCas+nTL0jykzvFvmU
	 OoWPxPH4e9FHFEO4bg+6sTmj3qurR7OUDg2ibnPJZQjkh7/x8Q39tEwuYsHg+9Vtwl
	 Q0RWdpbN95of9Q4JCWufHInN4Tul27PfXICPmRL+LvFcADy0RqbD1uryaG42j5rcT9
	 JVhOdnzr3I6AriTeVJRrtfFKE180RfqJR9hc2Fqz+FdumH7Ze+an/j7wEahyPObdFM
	 yNVAiov67Due4YWAyPuo4SCh6Twgy42uisNASZxnc32OohglxJmyC1ayrlPFMA0HV6
	 nE2rkDQ1iTKlQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 06/16] dwarves: Use tag__delete for enumeration children
Date: Mon, 22 Jun 2026 17:24:29 -0300
Message-ID: <20260622202441.14799-7-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622202441.14799-1-acme@kernel.org>
References: <20260622202441.14799-1-acme@kernel.org>
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

Fixes: 5c0162ee40f06c95 ("dwarf_loader: Initial support for DW_TAG_subprogram in DW_TAG_enumeration")
Assisted-by: Claude:claude-opus-4-6-1m
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarves.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/dwarves.c b/dwarves.c
index e530627073f7352e..5fae87fa5fe35a28 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -1334,11 +1334,6 @@ void type__delete(struct type *type, struct cu *cu)
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
@@ -1348,7 +1343,7 @@ void enumeration__delete(struct type *type, struct cu *cu)
 
 	type__for_each_enumerator_safe_reverse(type, pos, n) {
 		list_del_init(&pos->tag.node);
-		enumerator__delete(pos, cu);
+		tag__delete(&pos->tag, cu);
 	}
 
 	if (type->suffix_disambiguation)
-- 
2.54.0

