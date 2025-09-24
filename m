Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16622853EE
	for <dwarves@vger.kernel.org>; Wed, 24 Sep 2025 21:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758748668; cv=none; b=Dtt/K81K7io+mmeKzTIxBLoiCqoXuaqYxTZCCyj50q96HmWyRndEyeo/v8Kn15QNnkr2LvPibRLG+JHVRmyXPbyfQ7wIbvxW0MLr9/uhFLzR8CidDA2GLNCN50Kh5ofIIz/cqsRcfpcOhtoVKiFyhQ2Ro5tI5aCShtlenvklqG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758748668; c=relaxed/simple;
	bh=xi39pdyDTgQIcc/c7JTPAGQjufe08UgCQTE5w893Afw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HdI32Uqh/x9AbvBYO6i4t0tIKeqLdHxVxLlpXhFvhPandACE+vmBwHif3vaSEwKaKed//11nHL7j8LQ49cnD4q8sV01N0okCsSNKdEKMLGpxZ+5Gu5hvqxh6+eH2w0jo7pjlr/8gxH3Z2BCiw3hDZ15ZK4xBPPMVVgTc6r54zp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LW5HT7vd; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LW5HT7vd"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758748664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hcctq7KTnRmQl45yTysikP9cWkqMbB8WCJ2JVz0U1d4=;
	b=LW5HT7vdv8eyggZb0NALjT2L3yx0w8/731kpLAqhUnFK9mBv5AYVoMHxZKC7LrX02iG5kH
	w9Wv8GrEyhyrFoQ6wobmbHS5chOM+SSOIrt6HrCRjSfcieX6d8dU6y7aZ2kWeYnOrNpGsa
	k4kfn5fRYoGAYiaz97fHFHt9p5H+yJc=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: bpf@vger.kernel.org,
	andrii@kernel.org,
	ast@kernel.org
Cc: dwarves@vger.kernel.org,
	alan.maguire@oracle.com,
	acme@kernel.org,
	eddyz87@gmail.com,
	tj@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 3/6] selftests/bpf: update bpf_wq_set_callback macro
Date: Wed, 24 Sep 2025 14:17:13 -0700
Message-ID: <20250924211716.1287715-4-ihor.solodrai@linux.dev>
In-Reply-To: <20250924211716.1287715-1-ihor.solodrai@linux.dev>
References: <20250924211716.1287715-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Subsequent patch introduces bpf_wq_set_callback kfunc with an
implicit bpf_prog_aux argument.

To ensure backward compatibility add a weak declaration and make
bpf_wq_set_callback macro to check for the new kfunc first.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/testing/selftests/bpf/bpf_experimental.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index d89eda3fd8a3..341408d017ea 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -583,8 +583,13 @@ extern int bpf_wq_start(struct bpf_wq *wq, unsigned int flags) __weak __ksym;
 extern int bpf_wq_set_callback_impl(struct bpf_wq *wq,
 		int (callback_fn)(void *map, int *key, void *value),
 		unsigned int flags__k, void *aux__ign) __ksym;
+extern int bpf_wq_set_callback(struct bpf_wq *wq,
+		int (callback_fn)(void *map, int *key, void *value),
+		unsigned int flags) __weak __ksym;
 #define bpf_wq_set_callback(timer, cb, flags) \
-	bpf_wq_set_callback_impl(timer, cb, flags, NULL)
+	(bpf_wq_set_callback ? \
+		bpf_wq_set_callback(timer, cb, flags) : \
+		bpf_wq_set_callback_impl(timer, cb, flags, NULL))
 
 struct bpf_iter_kmem_cache;
 extern int bpf_iter_kmem_cache_new(struct bpf_iter_kmem_cache *it) __weak __ksym;
-- 
2.51.0

