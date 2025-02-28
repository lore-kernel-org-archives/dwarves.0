Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FCA230BE6
	for <dwarves@vger.kernel.org>; Fri, 28 Feb 2025 19:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772038; cv=none; b=XxwTra7aMEgA80+DF75fEbtTDiE9blRnSBk3cH6KPxombAst0zQGLVp6H+sJskI/WUuuYbXzUUhA2UC7H3J5XO+oh/6lF/WFVGPIE4BhrYPAlaoIyRcDMpebbFJOwSIbwPLr7wA+ihTallPf3n7c4rZlvYzdpF1avSq9vouGLU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772038; c=relaxed/simple;
	bh=vg72N/6DHfjyoSjIakVAL/xbwxGciAKI+kj6lrkH/RI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nxe/+sQSIMrcausiq/b+OJTgJkWivygHyo+AubqP/qAg8bTLm+OURs552Y+T/S4IjcTKlSZ1xlJNulJ5/Jk9hHi4tKh8miyB5UJif/OikrXKSuSMn2sZwwr3F3jZrA2PCqgL+wLf7nvfB3enCtREKC3qyhL189Lz1AMEAeY7Wj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pLrAzKZB; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pLrAzKZB"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740772034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NuvyfCtG+VEG28gEE9qzAwxBAEPojdpIbDgPKLNVZaI=;
	b=pLrAzKZB9BtHS6yZmEE5aGOB1Th7A7dGasHcsZVmTELMk7HpiqmvtFKNlQS1ogU2Tg4cZI
	fTXoQZqTZJ4QWZqCE9Y0MyJxQwDH0R5vXoyzf0sc96WW8OmuIXF4LYkacbEGH2cvKCa3Wd
	ydceeiCFE0GHH8amcBzfJ/vThP4srNw=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: dwarves@vger.kernel.org,
	bpf@vger.kernel.org
Cc: acme@kernel.org,
	alan.maguire@oracle.com,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	kernel-team@meta.com
Subject: [PATCH dwarves v4 6/6] man-pages: describe attributes and remove reproducible_build
Date: Fri, 28 Feb 2025 11:46:54 -0800
Message-ID: <20250228194654.1022535-7-ihor.solodrai@linux.dev>
In-Reply-To: <20250228194654.1022535-1-ihor.solodrai@linux.dev>
References: <20250228194654.1022535-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a description of the new --btf_feature=attributes.

Also remove reproducible_build description, as it is now a moot
feature flag.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
---
 man-pages/pahole.1 | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index 39e7b46..3125de3 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -327,9 +327,10 @@ Encode BTF using the specified feature list, or specify 'default' for all standa
 Supported non-standard features (not enabled for 'default')
 
 .nf
-	reproducible_build Ensure generated BTF is consistent every time;
-	                   without this parallel BTF encoding can result in
-	                   inconsistent BTF ids.
+	attributes         Allow generation of decl_tags and type_tags with
+	                   kind_flag = 1. These tags can be used to encode
+	                   arbitrary compiler attributes in BTF, but are
+	                   backward incompatible.
 	decl_tag_kfuncs    Inject a BTF_KIND_DECL_TAG for each discovered kfunc.
 	distilled_base     For split BTF, generate a distilled version of
 	                   the associated base BTF to support later relocation
-- 
2.48.1

