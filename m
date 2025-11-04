Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1305333DED0
	for <dwarves@vger.kernel.org>; Tue,  4 Nov 2025 23:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762299355; cv=none; b=XcL5Fyieafo3W3/eVxjcO2ITAJuZI9afRDI/CBbWwRtqDXnykKzA9gRLqR5Eu4gT/Rlvw7XbRBdl7FugDSNbAACMW+FtE6uDoQsWn7XGY9hGQ9xqD6f5WOspLKOOKgDbSGRZ43lcaGlZWayi94VQ0HknDGlFJosunQ849zcqCl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762299355; c=relaxed/simple;
	bh=j46UobsjmgOp4qid0EdYnVcLSVN1rB3AXlEpsUVP69o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EAHWd6LakvsCrhN4qw4nsisJIXdZ1Z0YxAk0QcC063y1AMS0pLSQpzp2gWb/LHfY6cATcV7/IXZrzDK9t42HCRnjWhF7hE6VIGN7fTk5nA60wo73jt4I50bMP10s6/He3jpJJ0Qk6FB9TsqZOKMqI1ou0Q+VdA4RqAnZvwGUpxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kum2pEpw; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kum2pEpw"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762299350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SdxXfOrHeutJFYGlsdMunkP+GNQ5NgQ13gCRunrLukY=;
	b=kum2pEpwKiw+1t68UAuBfEW7zOYRpXLaAo0qNLAmdedx+YaxidKpZNAmNjSDDU+W8VhwSP
	FtQpcFQh8g/LtWnT+DFaTkL4gso3FByDE1kDHqXK9w5Fc/OAm5LzDH4Vw4tmMDNSlBRYEW
	tIm9UPaThDNX50bmJFRLviOT275m3BU=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: dwarves@vger.kernel.org,
	alan.maguire@oracle.com,
	acme@kernel.org,
	eddyz87@gmail.com
Cc: bpf@vger.kernel.org,
	andrii@kernel.org,
	ast@kernel.org,
	kernel-team@meta.com
Subject: [PATCH dwarves v2 0/2] btf_encoder: refactor emission of BTF funcs
Date: Tue,  4 Nov 2025 15:35:30 -0800
Message-ID: <20251104233532.196287-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This series refactors a few functions that handle how BTF functions
are emitted. The first patch splits btf_encoder__add_func_proto() into
two functions by input. The second patch separates BPF kfunc handling
from generic function handling.

v1: https://lore.kernel.org/dwarves/20251029190249.3323752-2-ihor.solodrai@linux.dev/

Ihor Solodrai (2):
  btf_encoder: refactor btf_encoder__add_func_proto
  btf_encoder: factor out btf_encoder__add_bpf_kfunc()

 btf_encoder.c | 171 +++++++++++++++++++++++++++++---------------------
 1 file changed, 101 insertions(+), 70 deletions(-)

-- 
2.51.1

