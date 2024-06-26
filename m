Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214597345E
	for <dwarves@vger.kernel.org>; Wed, 26 Jun 2024 23:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719442907; cv=none; b=Qm5nCa1un+4sukW7wXBVYiKBjbME4srWeWAMBWdp5SThsNOmu6RDcaz5Q2Hu64HIPmr5AcVqg8vbv+llXQquJWVJKNN340FG9UHGy1zpEEYMGxgca+T2xLZe16YZwhmwdMRqcXWAu83Hu3x+/jsVZzKi/6Oh5yW0T0nr0GBUzoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719442907; c=relaxed/simple;
	bh=+vnHQoKlNot1H4dnaSEmT+vvtrpMZLatkR1niVaqiwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2A4gCocnpRD9e732dOWn+ZPo+oGdg4wWGCNCNp2c/whcZzPU6r4uwT3f33GS4SSjnjd7I2EdbELuL3ws6ZfkF5jXo5FpSf5dtYeUFLKyF+XBQURjiviS48cADeQHuKuASDYw4QLnU33O8BsaKMMMyYeatSqzkjr6NsUDfAs3o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=LP++/fS0; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="LP++/fS0"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id CDD5714C1E1;
	Thu, 27 Jun 2024 01:01:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1719442902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GxhJu2Fg6oB56KmTJmFLr74G9UdoUOBeeKpu0EVMvRc=;
	b=LP++/fS0FZiDuezVeAPhxyKTUZ6UU5p2OSoEinOpmaQUfRHD3R8DRspzu8LKoDxkXEPjgZ
	DRIRfXxWmxjgxXFLAqQ9J49Gd6mGh88YbM9MVD1MfDHXYEBz0VNSpeNDfaYl4baf2RUdXz
	1sfH5nsTfhSwuJ0+OPj14TIIYL1n/dXKLwpl90ZTY20Pof5sdCKYR6C2Ru4vAN53wSZ8/V
	li3C0nmvz6OmC3Uz4Rnyh5Aj+1FkW1PUwMRvIoeOtt10TC7qBu2shKRBLEV+p+nyfBYu4u
	IluiySKKoPLqV/+yKeWhbwfurpUowHViRraU32QpeyMbf4m20PdLvqUsI8JVIQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 1d75209d;
	Wed, 26 Jun 2024 23:01:35 +0000 (UTC)
Date: Thu, 27 Jun 2024 08:01:20 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: acme@kernel.org, andrii.nakryiko@gmail.com, dwarves@vger.kernel.org,
	jolsa@kernel.org, williams@redhat.com, kcarcia@redhat.com,
	dxu@dxuuu.xyz, eddyz87@gmail.com
Subject: Re: [PATCH dwarves] pahole: enable --reproducible_build when
 SOURCE_DATE_EPOCH is set
Message-ID: <ZnydwHhgCbUbkm44@codewreck.org>
References: <20240626032253.3406460-1-asmadeus@codewreck.org>
 <c1414fb5-f7a8-4cb4-9c27-9c0c9b431f28@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c1414fb5-f7a8-4cb4-9c27-9c0c9b431f28@oracle.com>

Thanks for the reply!

Alan Maguire wrote on Wed, Jun 26, 2024 at 03:29:37PM +0100:
> On 26/06/2024 04:22, Dominique Martinet wrote:
> > The SOURCE_DATE_EPOCH environment variable is used in reproducible
> > builds to set build timestamps and is generally synonymous with
> > reproducible builds: instead of making users figure out how to pass
> > pahole flags (e.g. explicitly setting PAHOLE_FLAGS in linux) just assume
> > that the user wants a reproducible build if this variable is set.
> 
> From the kernel perspective it looks like as a result of [1]
> [1] https://patchwork.kernel.org/project/linux-kbuild/patch/1443741332.2730.75.camel@decadent.org.ukOB/
> the setting of SOURCE_DATE_EPOCH will be converted into
> KBUILD_BUILD_TIMESTAMP; I thought the plan was to add the
> BTF feature flag explicitly if KBUILD_BUILD_TIMESTAMP was set?

Hmm, that patch (2015) never got in apparently?...
And I don't see anythiing that'd make pahole output reproducible if
either variables are set in the kernel either right now; we still build
plenty of older kernels so even if such a patch gets in I'd rather this
is checked in pahole than kbuild.

For context, the patch I'm replacing right now is this one in nixpkgs
(2023):
https://github.com/NixOS/nixpkgs/commit/e1daacf987d6064bd7dc65a30e7715990bc1c011

(Where we used to force -j1 if SOURCE_DATE_EPOCH is set, and the new
feature makes it more appropriate for upstreaming so I decided to send
the patch)

> Are you planning for use-cases outside of kernel BTF generation?

From a quick check the only users of pahole in nixpkgs and alpine are
the linux kernel, so as far as I'm concerned if the linux build is
reproducible I'm happy.
OTOH I'm not sure we're actually properly setting KBUILD_BUILD_TIMESTAMP
properly everywhere (for example external modules), whereas
SOURCE_DATE_EPOCH is now universally set by the upper build system --
back in 2015 when that patch was sent the reproducible build efforts
just started and SOURCE_DATE_EPOCH wasn't well supported, but now I
can't imagine it not being set.

So I'd rather keep checking on SOURCE_DATE_EPOCH, but if you're sure
there won't ever be any user other than the kernel for pahole's btf
generation then I can change the patch to KBUILD_BUILD_TIMESTAMP and we
can go hunt users not setting it explicitly our our side.


Thanks,
-- 
Dominique Martinet | Asmadeus
