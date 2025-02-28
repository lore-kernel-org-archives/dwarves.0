Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A070230BC7
	for <dwarves@vger.kernel.org>; Fri, 28 Feb 2025 19:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772031; cv=none; b=Ij3sXPaDWLX7tXq9dYx+wJ69yKs2xhTgjPj1t1pMcco4noY/yRlxFY9vxgVCJSCLs5QWYYHBCSPXojcmM7ik6DYUSLUi6QhzKxeniucuG2DMExsn84SdwTP/+6CNEEf5/DGmHb1xK6b70QeV+uhelVYq9fy8DRp1n7/XsuhP+xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772031; c=relaxed/simple;
	bh=Guo10HdlaAGZHMFUVxR5YuXor45bibwU7M52IKr49FQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tH2mpNepD/JOu1pe9XiaRx3nZdXS8uU1qwgkb/72SVym7GuOMKUHxoQ++67rstcmRewEwekIXwhmwKjmzTRap5mwRV+i2Q6N5kKhhONj+QWGxap42wocAlt2mhBf5nsc2wo4hn/j6IELkn9e1+9YGftrsNZZ23hLBCsOs5rJ5rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cKaPWpxT; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cKaPWpxT"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740772028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QxSX4iYXoDwa3gjEWnNt/KC9Rahol/AIrnhMlp5C9yU=;
	b=cKaPWpxT6CMyjFH1vEQyzVA+n9iuVAWqRxfgp7KZKKF02QR2nUbGuh3gJjDOr0goUkQtoM
	l4B9tNItScXiRbbfsQbg3J79zMFj2UDsWNVKMMqlBILlEhrDNatQ3iyd5BVpEQBnK30/Tp
	dLYkTwDIvUFGIAFfuvh6DoOcLmZLtTY=
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
Subject: [PATCH dwarves v4 3/6] pahole: sync with libbpf mainline
Date: Fri, 28 Feb 2025 11:46:51 -0800
Message-ID: <20250228194654.1022535-4-ihor.solodrai@linux.dev>
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

Pull recently added libbpf API functions:
  * btf__add_decl_attr()
  * btf__add_type_attr()

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 lib/bpf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bpf b/lib/bpf
index 09b9e83..42a6ef6 160000
--- a/lib/bpf
+++ b/lib/bpf
@@ -1 +1 @@
-Subproject commit 09b9e83102eb8ab9e540d36b4559c55f3bcdb95d
+Subproject commit 42a6ef63161a8dc4288172b27f3870e50b3606f7
-- 
2.48.1

