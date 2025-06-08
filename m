Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65377FD
	for <dwarves@vger.kernel.org>; Sun,  8 Jun 2025 07:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749369171; cv=none; b=oK/MUDVaeoAQcthhk+Dvk/FrUCh6IWcBm0/4EMs0d8kmFGNBWi/ZHdA/8KaiEqXtMX8l32pcTuBehRKTKiIu30UiGFwfVI8LhJq0qxmQFnlG2gpb3QQ/hfwwUVcoj9t3tY+eTaMbaEpwLkHWvjGnS9ADPVu9Gkh8Gv6L706BijI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749369171; c=relaxed/simple;
	bh=ZnWBLC8jwWTqFOhkyeqMwTN4x+rbulL0XDU9Atxi+bo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=cv+dfmqIk26UCHghMJcXgs8z7S4e8dQTCD8u4wRV3BOb4gkdYW/yN6t0W6KYOFgo1i5r6isTQV1MKEfxNKl+2qJVjaHqLM7gIWVzOf5wGnpeI/7UHBG55G9l7gCswUm83l4IN2erv1gF5FdPDU2wLlvaZEpdpRtCvs4ARBY7qiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from mop.sam.mop (unknown [82.8.138.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 4EB0B34131D;
	Sun, 08 Jun 2025 07:52:47 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: nick.alcock@oracle.com
Cc: acme@kernel.org,alan.maguire@oracle.com,andrii@kernel.org,ast@kernel.org,bruce.mcculloch@oracle.com,david.faust@oracle.com,dwarves@vger.kernel.org,elena.zannoni@oracle.com,jose.marchesi@oracle.com,stephen.brennan@oracle.com
Subject: Re: Proof-of-concept GCC/GNU ld toolchain-driven BTF
 generation/deduplication
In-Reply-To: <87ldqf1i19.fsf@esperi.org.uk>
Organization: Gentoo
User-Agent: mu4e 1.12.9; emacs 31.0.50
Date: Sun, 08 Jun 2025 08:52:44 +0100
Message-ID: <874iwqvfeb.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thanks for this, I'm really excited to see it. The disk space (and time
needed) for DWARF has been a problem for us especially as a source-based
distribution because we can't assume all builds are done on some beefy
centralised builder ;)

I'll wait to give it a go until there's some pahole wiring, then I'll
try daily driving it.

Have you got a list of what's left to do and also what you need from the
community? Or is this a preview of what you're working on and not
expecting much discussion yet?

cheers,
sam
