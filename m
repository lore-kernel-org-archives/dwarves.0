Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C7E35A141
	for <dwarves@vger.kernel.org>; Wed, 29 Oct 2025 19:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764590; cv=none; b=HGtHBkyXokX+v2vXUcvFdPyQz6L4DikF6SOCn4Kuo3NUxpkspFy2PvFvliF1K8Wh1t3UHlhgPvjpDIB9NATlltpD8Mvvichi4uj/In7lvCgHgLuV/XeRJNFGFfMDMSwSsaPih/UlsoqRHEvUD1QHKYgHsElAdmVOwatTqS4b2BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764590; c=relaxed/simple;
	bh=BWW0Wh6Gz1RU5+4+VQ0C/qBHZmmchnqo4g0V3ToPsjc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DjEoQ0fQOzRUOsZzzzHwautmAxl9QE7JOZX94bxooDur17zdKseAo0WScoJ19gsu0gfrIG+lnk1TKqF6vCxAD15xx88o6dSgPqtt42SNGK+4uibqBtj8plbTbrRpo/rIX/p/cWGV5bpMGnjomX8vOd+rLqbKsvGMFdUcAYqXOwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tQ1CSLgv; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tQ1CSLgv"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761764582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pmM+QqxAYzQ0Ex8rQKlGyKdJwhlWLhvgdGRBawkKa4U=;
	b=tQ1CSLgvHfyG0HMiizZ5pW2JHqE74l+rOdKWIITRlvsJwjUKxIXIb9zPyYSTPd0mDCLvdW
	serTCSJcx+q/bb+baVJF2XelUdc2twY3gMfQlYMZkW6ZNHDCX7ajJbvpagh8ufi1DqJPEh
	RpF/TcUJDro6io9NliDwS89PzLSvZ34=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: dwarves@vger.kernel.org,
	alan.maguire@oracle.com,
	acme@kernel.org
Cc: bpf@vger.kernel.org,
	andrii@kernel.org,
	ast@kernel.org,
	eddyz87@gmail.com,
	tj@kernel.org,
	kernel-team@meta.com
Subject: [PATCH dwarves v1 0/3] btf_encoder: support for BPF magic kernel functions
Date: Wed, 29 Oct 2025 12:02:46 -0700
Message-ID: <20251029190249.3323752-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This series implements BTF encoding of BPF kernel functions marked
with KF_MAGIC_ARGS flag in pahole.

The kfunc flag indicates that the arguments of a kfunc with __magic
suffix are implicitly set by the verifier, and so pahole must emit two
functions to BTF:
  * kfunc_impl() with the arguments matching kernel declaration
  * kfunc() with __magic arguments omitted

For more details see relevant patch series for BPF:
"bpf: magic kernel functions"

This series is built upon KF_IMPLICIT_PROG_AUX_ARG support [1],
although the approach changed signifcantly to call it a v2.

[1] https://lore.kernel.org/dwarves/20250924211512.1287298-1-ihor.solodrai@linux.dev/

Ihor Solodrai (3):
  btf_encoder: refactor btf_encoder__add_func_proto
  btf_encoder: factor out btf_encoder__add_bpf_kfunc()
  btf_encoder: support kfuncs with KF_MAGIC_ARGS flag

 btf_encoder.c | 292 ++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 222 insertions(+), 70 deletions(-)

-- 
2.51.1

