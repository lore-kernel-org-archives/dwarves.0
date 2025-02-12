Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E8B20102A
	for <dwarves@vger.kernel.org>; Wed, 12 Feb 2025 20:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739391372; cv=none; b=hf4/un74XFSvDo9+6jpH2pol7PfkFuOEsckNmh+FWJJxwjIj2ZQjz3v5KhCca5RCH0Wux+y76tW3niYR/K61KEx1N6kWq7fmRcXdrcfWV70wTBahkrAWe/A2x1aHSGyXtl6LqN/Hr/QLC3SjHHgmgLc+SjYyn5x5ChwbHQtKGXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739391372; c=relaxed/simple;
	bh=5B7XUY7Nqzv/JAulD/+nuvN7VWFmcG0NDzGHpzzLUec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AV425fqS415vtgot5J7cIJO+S/sNJF8ywuMdIgT7vwS4dC1A6qf9uF0yjBKbKyLigtEnutyoPKKI1Ob7sUfMuw/7R5MaSVbHsbQCrmUZcOqODdT1/OnpebZd9oL4GzAIc/RUoKauP2Aug2ODepqeYO2KwhaKCcHQUfKmyMTVTqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Oxq/CT7x; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Oxq/CT7x"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739391358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nC7cn+rVIg6MpvIaDSw10GYWFuoeMxoQKkmD5OiTxUw=;
	b=Oxq/CT7xfg29b008y/BkP26YcbU1ZIz2yzEM65Lb++Ey1HmFGP1aQvd1RtlAtpgZ3mRufO
	8Upyme9qMZhuYvc5Z5U7bMICAjkzJRPfD4sRAkDyOkKZqGfDSIfpUALvu9HME7WjanksJt
	DKgZ+8vTyw/BOCxspCDyWuSW9/zH1Zs=
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
Subject: [PATCH v2 dwarves 0/4] btf_encoder: emit type tags for bpf_arena pointers
Date: Wed, 12 Feb 2025 12:15:48 -0800
Message-ID: <20250212201552.1431219-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch series implements emitting appropriate BTF type tags for
argument and return types of kfuncs marked with KF_ARENA_* flags.

For additional context see the description of BPF patch
"bpf: define KF_ARENA_* flags for bpf_arena kfuncs" [1].

The feature depends on recent changes in libbpf [2].

[1] https://lore.kernel.org/bpf/20250206003148.2308659-1-ihor.solodrai@linux.dev/
[2] https://lore.kernel.org/bpf/20250130201239.1429648-1-ihor.solodrai@linux.dev/

v1->v2:
  * Rewrite patch #1 refactoring btf_encoder__tag_kfuncs(): now the
    post-processing step is removed entirely, and kfuncs are tagged in
    btf_encoder__add_func().
  * Nits and renames in patch #2
  * Add patch #4 editing man pages

v1: https://lore.kernel.org/dwarves/20250207021442.155703-1-ihor.solodrai@linux.dev/

Ihor Solodrai (4):
  btf_encoder: refactor btf_encoder__tag_kfuncs()
  btf_encoder: emit type tags for bpf_arena pointers
  pahole: introduce --btf_feature=attributes
  man-pages: describe attributes and remove reproducible_build

 btf_encoder.c      | 282 +++++++++++++++++++++++----------------------
 dwarves.h          |   1 +
 man-pages/pahole.1 |   7 +-
 pahole.c           |  11 ++
 4 files changed, 161 insertions(+), 140 deletions(-)

-- 
2.48.1

