Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA9134CFDD
	for <dwarves@vger.kernel.org>; Mon, 22 Jun 2026 20:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782159900; cv=none; b=a9VzyK1fjRQtGAXw8aSvXJruDYAPoqQVLGJUe/apv+dzGKIhg/OuY3zwvrzDNTmS5ELrkjL9KKLHgs4n1SIJRO/TRHjMQbLjlOyArX/YR/MGGxoK9bA9RBrrnooj8H5VHFGy6sQj+kYOCo86bvoh7D7Fa1j3o+fYLF5/ORqmhoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782159900; c=relaxed/simple;
	bh=stI6wdyL3WW3yggTGfIgyNEv2zr4yqhkRGK0zUuZJtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aR/WvqEram9Ap8xCeh74M3v3M7atxVUbqoBZYTsocAWUj4djg9GFIHGZANDzVdQd6z8CENqvBAM9U4n5HDgvP1dwJPVDCQn2XxOu628tEkeZJO8x7HBdnqv+pmEUq06cKG88h14q4dy4WBYAuOlBs9+mNrfA0aMwKHKdD4N9eS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3Moykaf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3Moykaf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C4F1F00A3A;
	Mon, 22 Jun 2026 20:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782159899;
	bh=li1YK0EbQ6PXkJeQfyTUXJwwa/REmVgrCeZHaez3Eg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I3MoykafLninj5+UUTyeea17CCE8ND/SCN/1D6+YYl60tH12uaKpCtXxMXJfJTgz9
	 m7+hjPqMX3oSjULR+ZurJPOASmUXV+Cy2BVgR5NmB+AvquCbSlGgZzxfmaQ06iI98y
	 lGYHwZAhlVa6ygqEj0397A7VJjBynRhPZhLbKq9ODZj9zCZ4Kt3ul0TLDDskn0HGug
	 iFJsBPnt9LkdKCIG6OS7S4j7LRcGQwynVC6rg7bij39B+IJp5Lx6uL8qGC+LC1GP/8
	 TVph8mKDuUT5Bl99Qj/3inYTZB1dRswLTKSPSpVllo4Ebkut5nPBW67P70sFRZ/IdP
	 0/4yT2fEREsnQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 05/16] dwarves_fprintf: Accumulate function__fprintf return value in enumeration printing
Date: Mon, 22 Jun 2026 17:24:28 -0300
Message-ID: <20260622202441.14799-6-acme@kernel.org>
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

The return value of function__fprintf was being discarded, causing the
printed byte count to be wrong when enumerations contain DW_TAG_subprogram.

Fixes: 5c0162ee40f06c95 ("dwarf_loader: Initial support for DW_TAG_subprogram in DW_TAG_enumeration")
Assisted-by: Claude:claude-opus-4-6-1m
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarves_fprintf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
index e0887e14daa16c8c..eeb79d490e02c5c3 100644
--- a/dwarves_fprintf.c
+++ b/dwarves_fprintf.c
@@ -495,7 +495,7 @@ size_t enumeration__fprintf(const struct tag *tag, const struct cu *cu,
 
 		switch (pos->tag.tag) {
 		case DW_TAG_subprogram:
-			function__fprintf(&pos->tag, cu, conf, fp);
+			printed += function__fprintf(&pos->tag, cu, conf, fp);
 			break;
 		case DW_TAG_enumerator:
 			printed += fprintf(fp, "%-*s = ", max_entry_name_len, enumerator__name(pos));
-- 
2.54.0

