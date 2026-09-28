Received: from smtp02.hmg9.webhuset.no (smtp02.hmg9.webhuset.no [46.226.9.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA0B38D006
	for <dwarves@vger.kernel.org>; Mon, 28 Sep 2026 18:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.226.9.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620323; cv=none; b=swhCjDLdB8zCSmXlcnLLL75lIQ02KFKnxWQbK/HOC6GhFrC3fM0JyyiF84YlrId6kRR1YIiX5m8zYkCH4PJV/KRpbf4TDCT08g49pSa8OUEh54AHfMhHDUGfQi0RpLydsubul/aY692vxN1GPMrOMCkWfvuRqTQanW955uZ5qmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620323; c=relaxed/simple;
	bh=cySYqooicHTh0RyQEUB7cwLQNHv3SgnevPWBhA6tucQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ag1hMLOb5GpM+lfWJo4Y5r+J5bjC++B6tCq/5bx0XfOVirGBqQuQFySHwWcyQZIXcenIbjxfcjVPjSAoJR5NwV4cvhXsovLpF3CASTUB+5cNq9YhWRRRNnrJZ4XqElGN6RRz6U5n3Flbw54qq6q0/zonDcPX4GdIvJk0rfebCi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pfft.no; spf=pass smtp.mailfrom=pfft.no; arc=none smtp.client-ip=46.226.9.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pfft.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pfft.no
Received: from mail.pfft.no (unknown [109.247.74.5])
	by smtp02.hmg9.webhuset.no (Postfix) with ESMTPA id 60BED8008E
	for <dwarves@vger.kernel.org>; Mon, 28 Sep 2026 20:22:57 +0200 (CEST)
From: =?UTF-8?q?H=C3=A5vard=20F=2E=20Aasen?= <havard.f.aasen@pfft.no>
To: dwarves@vger.kernel.org
Cc: =?UTF-8?q?H=C3=A5vard=20F=2E=20Aasen?= <havard.f.aasen@pfft.no>
Subject: [PATCH 0/1] prefcnt: guard against NULL function parameters
Date: Mon, 28 Sep 2026 20:21:45 +0200
Message-ID: <20260928182217.301003-1-havard.f.aasen@pfft.no>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When prefcnt is invoked without an argument, it attempts to process the
debugging information for the running kernel. Depending on the
available BTF/ELF data, the function-parameter list may contain a NULL
entry.

I'm not convinced that the proposed patch is the only, or best way to
fix this issue. Both cus__load_running_kernel() and the total expansion
of list_for_each_entry() macro might be candidates for a more elegant
solution.

Håvard F. Aasen (1):
  prefcnt: guard against NULL function parameters

 prefcnt.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.53.0

