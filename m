Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1E51B422A
	for <dwarves@vger.kernel.org>; Thu, 20 Mar 2025 16:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742488340; cv=none; b=Y+x3sb8Er5Ok0yz70hSO/GTuV4jY4s4JvCFtD2QE3kZYwB4Q5abVia6it2aIYt0B3OBHy9RDB2pSuqMzGzQAqJ/yxIXdln2kwlMLPanZlTW+HJar2i2ikCfRU/GofjMQzwHp8lxbRfKmDvs3fTBO/J5Jk8RD2IkZ63CNi2Ya58A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742488340; c=relaxed/simple;
	bh=vD1y1DDkDUM4yp5FfHeL2BOmu+2bZs6XIZphB0iRpJA=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=ZHofWMSTkGYcpnkwrwmnr2tD4bHpJDvXpLMA0TtuFPTKDpAwNR7UhwLMojtxbyNVP0Jxcx9B+9dA9CF9YtnPmk4HNVQPX2yauvLX3VzSehvAqCFzLzv6kufvq0cywcJAzAeIKGVaIFGU9XrPE+HnDs5368Nvxs5832degDMsEiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QGgyIOsb; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QGgyIOsb"
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742488326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vD1y1DDkDUM4yp5FfHeL2BOmu+2bZs6XIZphB0iRpJA=;
	b=QGgyIOsbWeb4a1fYAwm5TBWPrEe6TdULZ1Tm0s4pq761ldH4PCCEyq7diPuH/Mgv8zLfG+
	G3kSzsXM8L4VAXA4PsryfXcBBVfkMcka2q3V0SKYXEk/FMO2wWCsflURxxS2Gp96rtjMBx
	iPtKdDlUJX54KuJD52YjnXv3HlQc+RM=
Date: Thu, 20 Mar 2025 16:32:04 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <9c3d6c77c79bfa2175a727886ce235152054f605@linux.dev>
TLS-Required: No
Subject: Re: [PATCH dwarves v4 0/6] btf_encoder: emit type tags for bpf_arena
  pointers
To: dwarves@vger.kernel.org, bpf@vger.kernel.org
Cc: acme@kernel.org, alan.maguire@oracle.com, ast@kernel.org,
 andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com,
 kernel-team@meta.com
In-Reply-To: <20250228194654.1022535-1-ihor.solodrai@linux.dev>
References: <20250228194654.1022535-1-ihor.solodrai@linux.dev>
X-Migadu-Flow: FLOW_OUT

On 2/28/25 11:46 AM, Ihor Solodrai wrote:
> This patch series implements emitting appropriate BTF type tags for
> argument and return types of kfuncs marked with KF_ARENA_* flags.
>
> For additional context see the description of BPF patch
> "bpf: define KF_ARENA_* flags for bpf_arena kfuncs" [1].
>
> The feature depends on recent changes in libbpf [2].
>
> [1] https://lore.kernel.org/bpf/20250206003148.2308659-1-ihor.solodrai@=
linux.dev/
> [2] https://lore.kernel.org/bpf/20250130201239.1429648-1-ihor.solodrai@=
linux.dev/
>
> v3->v4:
> * Add a patch (#2) replacing compile-time libbpf version checks with
> runtime checks for symbol availablility
> * Add a patch (#3) bumping libbpf submodule commit to latest master
> * Modify "btf_encoder: emit type tags for bpf_arena pointers"
> (#2->#4) to not use compile time libbpf version checks
>
> v2->v3:
> * Nits in patch #1
>
> v1->v2:
> * Rewrite patch #1 refactoring btf_encoder__tag_kfuncs(): now the
> post-processing step is removed entirely, and kfuncs are tagged in
> btf_encoder__add_func().
> * Nits and renames in patch #2
> * Add patch #4 editing man pages
>
> v2: https://lore.kernel.org/dwarves/20250212201552.1431219-1-ihor.solod=
rai@linux.dev/
> v1: https://lore.kernel.org/dwarves/20250207021442.155703-1-ihor.solodr=
ai@linux.dev/
>
> Ihor Solodrai (6):
> btf_encoder: refactor btf_encoder__tag_kfuncs()
> btf_encoder: use __weak declarations of version-dependent libbpf API
> pahole: sync with libbpf mainline
> btf_encoder: emit type tags for bpf_arena pointers
> pahole: introduce --btf_feature=3Dattributes
> man-pages: describe attributes and remove reproducible_build

Hi Alan, Arnaldo.

This series hasn't received any comments in a while.
Do you plan to review/land this?

Thanks.

>
> btf_encoder.c | 328 ++++++++++++++++++++++-----------------------
> dwarves.h | 13 +-
> lib/bpf | 2 +-
> man-pages/pahole.1 | 7 +-
> pahole.c | 11 +-
> 5 files changed, 188 insertions(+), 173 deletions(-)
>
