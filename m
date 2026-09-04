Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBBD28373
	for <dwarves@vger.kernel.org>; Fri,  4 Sep 2026 01:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788485626; cv=none; b=vFzwP6bStSPnln7p9e1Ocoz+yNB1JlgZvb5ffLx33acSxBT4uNLGMGRnob4eI68uAvAUpBu1FuKWj4gPL2+VE7c+bNQBDmcDTynySgw9ZD9EF9baDoC3LM35Pq6PzQsgfPwzW+16L/WOaUWYYEHAsgEyjXKFblsYal30Yn9NzOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788485626; c=relaxed/simple;
	bh=UMkTOiGWuYiVT+nbvy7J624sBdM5OUQ/DJKVTzkarjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctHr3y9FSu0kysTsgqm/hgmtREMA8y176BA4efkmdgpT0CStToeC64STIlBokWDpUuSVSrBLd+rm1vVt6NK19K8R4MQ3nKkr+Us+9T7o5ciRZJYvIBvopJH4nEF2jv+8tNMRq8evVFGj8yGJFnwQz/oCs8uss9phIDzrww0G3nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ycxw1yFq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ycxw1yFq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32611F000E9;
	Fri,  4 Sep 2026 01:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788485625;
	bh=364P8Xias9351RXm/AXMPflufLdXSTzuPAXweVnEUy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ycxw1yFqxM05ihGOFr6fUA/qwiv1aiLZuuACGYjOqcsNgbbnr/v3cyVWa+/UU85Ky
	 9ANCxjC4sY1UIYu2ONqqJfH+U0/x5vZH9XM8bqa5ubV5xGR4GIRNSF3gpsT2peCJM1
	 IU1RPCzPfZXy7jUTI7SeHcuFtHyAEUr0Ehnve8yMtdmBK+X6hudmwDyD2hZcTtjRXC
	 bdD1uKyNH47/V/ERXttRqZwXh8wIBKDOVKoY9eadnAsQUUmTo7z7ThkdqbBtkP2LuW
	 KL9j6vfTM4X+KwiXz0QufHg7xSzUB4Kky0iG8wub3GnFKt/adngncAuyLfS2iwB0/Z
	 Eee5pSgTlVmgQ==
Date: Thu, 3 Sep 2026 22:33:42 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Aditya Dutt <duttaditya18@gmail.com>
Cc: dwarves@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH dwarves 0/2] pahole: Fix -C -T segfault
Message-ID: <apof9qe3rmRECtUG@x2>
References: <20260903205659.1543175-1-duttaditya18@gmail.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903205659.1543175-1-duttaditya18@gmail.com>

On Fri, Sep 04, 2026 at 02:26:57AM +0530, Aditya Dutt wrote:
> 'formatter' is NULL when -T is given and the -C path calls it, which
> segfaults.
> Patch 2 rejects that, like '-m -C' already does.
> Patch 1 fixes the '-m -C' error, which names '--class' incorrectly.
> 
> -T has set 'formatter' to NULL since commit 286c7740fd98c4df but -C did
> not call formatter until f5857bd34b220a64 (used to call tag__fprintf
> before), so added Fixes tag referencing it. 
> 
> I think support for the combinations '-T -C' and '-m -C' could be added
> in the future.
> 
> Problem with doing that right now is that the counting logic lives in
> the 'class_name == NULL' block that -C skips. And -C stops loading CUs
> once all classes are found.

Thanks, applied, I'll now stop processing patches and release 1.32
tomorrow.

- Arnaldo
