Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEA721C9FD
	for <dwarves@vger.kernel.org>; Thu,  6 Nov 2025 01:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762392530; cv=none; b=eWwenWbIYYsfjTRZ3i9TzZOGNmWArFB9GW/2Z7l9KaLXaXAXHMAlwkI3avTyrepv837qxRs+soxT3p3na13SDFUlph9XpmobtN23xQtso60JOlRrCnRaUvxH5cABMQvwFQAkUJXpeqL5StA7Os2oDRkCWENhxGe3JbpHa3CcCxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762392530; c=relaxed/simple;
	bh=WcHxGvowN6vG+Ksd0VAe7a4iheX3EK/6aEEiaQ1KOCs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kvevxLm9bm3X1B8JaaVgLqn5zcxSScfFZOG+ASJVWNn7MErMTiliUF+igxlp+hQ6GqaafI0/RVPGvEYJbutCngQmnf2Ytt3D6gzV1EykxaK7nski7/UvqS6cNhS2r/NEDIpiYv7bMMU3kaxXCublXNC0NA3M4PyufyRQWfKSmcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TD3Ga5F7; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TD3Ga5F7"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762392526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dq727exngc8zlm8pfuc4gKjHmwYVM713r4sOIDQK0UA=;
	b=TD3Ga5F7AtcPRUVIVybOYXfHSHOBLVZ23jjikCzcHKmeoLDYPZJ8yDSXDliVV9AVm9ICNU
	36uOQSypZKhKzUVevswSg+/NQexeKldP3wnWrkS73A6RXMp/8+hi23TWylYJmlfZShl7Sm
	XnF4yLdIt2TqEEbLhQeH35/qvR08UKg=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: dwarves@vger.kernel.org,
	alan.maguire@oracle.com,
	acme@kernel.org,
	eddyz87@gmail.com
Cc: bpf@vger.kernel.org,
	andrii@kernel.org,
	ast@kernel.org,
	kernel-team@meta.com
Subject: [PATCH dwarves v4 0/3] btf_encoder: refactor emission of BTF funcs
Date: Wed,  5 Nov 2025 17:28:32 -0800
Message-ID: <20251106012835.260373-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This series refactors a few functions that handle how BTF functions
are emitted.

v3->v4: Error handling nit from Eduard
v2->v3: Add patch removing encoder from btf_encoder_func_state

v3: https://lore.kernel.org/dwarves/20251105185926.296539-1-ihor.solodrai@linux.dev/
v2: https://lore.kernel.org/dwarves/20251104233532.196287-1-ihor.solodrai@linux.dev/
v1: https://lore.kernel.org/dwarves/20251029190249.3323752-2-ihor.solodrai@linux.dev/

Ihor Solodrai (3):
  btf_encoder: Remove encoder pointer from btf_encoder_func_state
  btf_encoder: Refactor btf_encoder__add_func_proto
  btf_encoder: Factor out BPF kfunc emission

 btf_encoder.c | 206 +++++++++++++++++++++++++++++---------------------
 1 file changed, 119 insertions(+), 87 deletions(-)

-- 
2.51.1

