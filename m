Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BB1230BE2
	for <dwarves@vger.kernel.org>; Fri, 28 Feb 2025 19:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772035; cv=none; b=jFwtbZA2M8ged1GEzRTRt7DY6aR5SvGjnigMiUPxciqDdtTtncZZZ2N7EfCmVmczZZMPSzx0SCBmmObqD4/aH6ogrXFH0usPFwd8onEX+SL5zMnPJizeaqlYCgWEQ5nP9YBQ1nLsdrbWmHct+8qPFuAs5LVHGP6CVC+jLnRNzIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772035; c=relaxed/simple;
	bh=ckQNuNmGjM8ecvTnFMutrWxOhwHzxGo6fdCAJ6Ia6sc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tFmZN56yoSloHovN3oZxObgr7SPMOL6Cyfc1EOgda3EQWHQZJMc0gP2s+TC7GBu6ikO3W0Mn6WETZWiJikw6/y7OqyOwqp4yizJfZ0KoYMRy2ZeVumt8ykUI3/g7magKjYKsGgR5xZVGveyDwXJHQrkJmkOuHaoHtGIp6ENAh8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vN6oGCSJ; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vN6oGCSJ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740772021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R6NtA1IcvY6lp5dUu6ImTMyn+vAgJw/OBPwKBKOPKck=;
	b=vN6oGCSJ2ZXCthutI5ziUuKgKerR0T0OK10QFpcgAjYuOiso0A/8keMevSECaQW4X/yaEr
	dtdfJCAv/w3gQJtE47blsDmjHOC3CKsZSGsa6ktA2uTRCi6DU8IbOCOPexPm3godoe1vG7
	HmyV3Glz/6bWd3GmDV1hdvKs2vCSa8E=
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
Subject: [PATCH dwarves v4 0/6] btf_encoder: emit type tags for bpf_arena pointers
Date: Fri, 28 Feb 2025 11:46:48 -0800
Message-ID: <20250228194654.1022535-1-ihor.solodrai@linux.dev>
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

v3->v4:
  * Add a patch (#2) replacing compile-time libbpf version checks with
    runtime checks for symbol availablility
  * Add a patch (#3) bumping libbpf submodule commit to latest master
  * Modify "btf_encoder: emit type tags for bpf_arena pointers"
    (#2->#4) to not use compile time libbpf version checks

v2->v3:
  * Nits in patch #1

v1->v2:
  * Rewrite patch #1 refactoring btf_encoder__tag_kfuncs(): now the
    post-processing step is removed entirely, and kfuncs are tagged in
    btf_encoder__add_func().
  * Nits and renames in patch #2
  * Add patch #4 editing man pages

v2: https://lore.kernel.org/dwarves/20250212201552.1431219-1-ihor.solodrai@linux.dev/
v1: https://lore.kernel.org/dwarves/20250207021442.155703-1-ihor.solodrai@linux.dev/

Ihor Solodrai (6):
  btf_encoder: refactor btf_encoder__tag_kfuncs()
  btf_encoder: use __weak declarations of version-dependent libbpf API
  pahole: sync with libbpf mainline
  btf_encoder: emit type tags for bpf_arena pointers
  pahole: introduce --btf_feature=attributes
  man-pages: describe attributes and remove reproducible_build

 btf_encoder.c      | 328 ++++++++++++++++++++++-----------------------
 dwarves.h          |  13 +-
 lib/bpf            |   2 +-
 man-pages/pahole.1 |   7 +-
 pahole.c           |  11 +-
 5 files changed, 188 insertions(+), 173 deletions(-)

-- 
2.48.1

