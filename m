Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6948E26FDB3
	for <dwarves@vger.kernel.org>; Wed,  5 Nov 2025 18:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762369188; cv=none; b=WaAliPdCUMkOYJ66Jb2Ei4slfAFvrM5BDMk17UBYgADFLJ3fR3269LdtPJvlmbhKZMGqk7MDHN+T6m93Vc3Z91b+CV9YLGFun2AKR++0+zIWgqUIoxZ6gVl2aYkCsfOiQYIeCarWj8QgTAlYv+0595hSEPTzchzYXf97D7wLIfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762369188; c=relaxed/simple;
	bh=3GwN5gWb07Yf5LOcMgdhPtd1aiTrudPwLqJ4k/U+JCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a3iKdpsENY0GkP4EDhj24k2wK2/JT5ph+ia153WjZZbc0r1xyINI80TkSA1akfBUCavW31S0VKAqZ+oukRxLtvpT0+TdcRNITDjh6LyCVZTnIpCDJLwM31eS78rcxZRQfKPwF8m2K0JZhpBfJ6OKSZx3hZSF1PVRPb4RRASrr74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uIrIVMWq; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uIrIVMWq"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762369182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ArQX/hFYiBzDmap8PQiaxRMbGd76dktq6M3+JyIauSY=;
	b=uIrIVMWq52vlGdnIkfacilq22rSLri3ZM1/+oo2YTwZCTkVdeRBWO07XYd2xZpFcMHBSdX
	GY7McJeXKav45eYdVCeJ6OvKouxpCdHNcxi63yBr1b0QYlHqNtQe1KgramLUlJhsteZEOU
	HJ77ErUBmahykAEqXgwZC+yFEU/IjEg=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: dwarves@vger.kernel.org,
	alan.maguire@oracle.com,
	acme@kernel.org,
	eddyz87@gmail.com
Cc: bpf@vger.kernel.org,
	andrii@kernel.org,
	ast@kernel.org,
	kernel-team@meta.com
Subject: [PATCH dwarves v3 0/3] btf_encoder: refactor emission of BTF funcs
Date: Wed,  5 Nov 2025 10:59:23 -0800
Message-ID: <20251105185926.296539-1-ihor.solodrai@linux.dev>
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

While addressing comments from Eduard, I noticed that we don't
actually need to carry the encoder in btf_encoder_func_state, because
only one encoder exists at all times. So in v3 I added a patch
removing encoder from the state struct, which resolves the ambiguity
of where state->encoder should be used.

v2: https://lore.kernel.org/dwarves/20251104233532.196287-1-ihor.solodrai@linux.dev/
v1: https://lore.kernel.org/dwarves/20251029190249.3323752-2-ihor.solodrai@linux.dev/

Ihor Solodrai (3):
  btf_encoder: Remove encoder pointer from btf_encoder_func_state
  btf_encoder: Refactor btf_encoder__add_func_proto
  btf_encoder: Factor out BPF kfunc emission

 btf_encoder.c | 204 +++++++++++++++++++++++++++++---------------------
 1 file changed, 117 insertions(+), 87 deletions(-)

-- 
2.51.1

