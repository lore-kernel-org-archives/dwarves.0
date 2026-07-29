Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27FE463B74;
	Wed, 29 Jul 2026 19:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352080; cv=none; b=miApFH1arLH0BvOMEVYtMac6Qdc4FsdZAvxoCAS1LeBTr0riaD5tDOTJ12ticftnoFYyNFvdTZGnETmu6szKFN3IsG7mJ3QmdicT63LhJ9ZFLLBTjtotGO/7ERLbiVp/ny/JyGuwU/Ss0slXbj9/lg0lsiFUeE4hC7xXYWe21Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352080; c=relaxed/simple;
	bh=QQyWxrJAbupgBaoxZsBGxvzWj6INlcEOie3mc4/oNEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N0S2R/b/5L6acwQ2r+hp4cID8rn6bzT6ZbWOsCtr8Od16p2IluGLNeFOoF/2HFHUFkCcp04jWD2LNJj0FtJIi6gAeuk7jaMzBv5lHk+TB2TPlFAsQmQ5E7jL/CcdBECMA9jbam4LjyB/XiODXfqMrtkN2ltEkvwRU00btiinq9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBv996k7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBv996k7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765D91F000E9;
	Wed, 29 Jul 2026 19:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785352079;
	bh=+QHOXulET+zapoHrT4rAZJ7/ESQwApgk9y18fw4zJMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mBv996k7Tm4FOQpmGDoUGX3HBqcdTfHIqzUcjhhThdAgpZJMdvnI5N+W7sKtW3ia0
	 e81hLK8tbfvPew0JxOiE1t7vCDpsNmHRIu4E4dAASO7qew7WSXfS7MoFft/9alnK1s
	 r2Bh1SzghAgCFALqd3gr+1A24jwjoJY94v8DZnxZo94KCCQgQlscYKAHhmVtvbziIy
	 MRTRg2zIckSImEj0MDNflhrA6eGQ2mRdEGAsY1NW6p+Dlqy0DequdGPO65CU7Oquji
	 69zmskVfivO6oD2tSTTO9jLa3c2Qz1cC47kvYi7/ybmpJdwIo/iNacfpoOs/pEp33p
	 bePn/Dj4br1Xw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 09/31] dwarf_loader: Fix annotation failure leaks in variable and typedef creation
Date: Wed, 29 Jul 2026 16:07:09 -0300
Message-ID: <20260729190733.72876-10-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729190733.72876-1-acme@kernel.org>
References: <20260729190733.72876-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

die__create_new_variable() and die__create_new_typedef() leak their
allocated objects when add_child_llvm_annotations() fails: the
allocation succeeds but the error path returns NULL without freeing it.

Split the compound NULL-or-annotation-failure check in
die__create_new_variable() into separate checks, and add explicit
cleanup (tag__delete / type__delete) before returning NULL on
annotation failure in both functions.

Fixes: aa8c494e65a77fa5 ("dwarf_loader: Parse DWARF tag DW_TAG_LLVM_annotation")
Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarf_loader.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index b87519fa73405ff7..ddf7cdcfd467beb4 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -2078,8 +2078,10 @@ static struct tag *die__create_new_typedef(Dwarf_Die *die, struct cu *cu, struct
 	if (tdef == NULL)
 		return NULL;
 
-	if (add_child_llvm_annotations(die, -1, conf, &tdef->namespace.annots))
+	if (add_child_llvm_annotations(die, -1, conf, &tdef->namespace.annots)) {
+		type__delete(tdef, cu);
 		return NULL;
+	}
 
 	return &tdef->namespace.tag;
 }
@@ -2190,8 +2192,13 @@ static struct tag *die__create_new_variable(Dwarf_Die *die, struct cu *cu, struc
 {
 	struct variable *var = variable__new(die, cu, conf, top_level);
 
-	if (var == NULL || add_child_llvm_annotations(die, -1, conf, &var->annots))
+	if (var == NULL)
+		return NULL;
+
+	if (add_child_llvm_annotations(die, -1, conf, &var->annots)) {
+		tag__delete(&var->ip.tag, cu);
 		return NULL;
+	}
 
 	return &var->ip.tag;
 }
-- 
2.55.0

