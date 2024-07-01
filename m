Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE892F29
	for <dwarves@vger.kernel.org>; Mon,  1 Jul 2024 23:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719876980; cv=none; b=HwsnPD10xG7wjH3VqRHED/wSmMkJnGUHKelBKiHJw0Y+g74843SYDJUWw+u3JnznR4DwVrZ7egYrdpS25zJ0uxJBWr4Ru5H+IF+xjo43ldpK7exfMDdoUrlLyisiWrlvij4tR9t79Ynapk+3vEqJzYuVAkotVzBYBtC9mglU5Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719876980; c=relaxed/simple;
	bh=yoZANEc8m6J9rRTSqh7IZ/FkJsR+0qMmWqVvzRR7/aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cksMp20bBv0AR5P8/m2H279/vpTl9TlF8tQHJHPjQ9h/PThdLNp90dpo8ZxKBYMD8KECfTAF13NE9mgcdAHpkvhnXt140ctbr/cWfuu9TJtiW33JC02gIvd1/hT8LR9cOFir1d+lgmdexMdi0cl47t6sKtIqJqMrx8SOr5EjFac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=ZO5ZkpyT; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="ZO5ZkpyT"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id AD6B514C1E1;
	Tue,  2 Jul 2024 01:36:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1719876969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GatGxFTKDpzgV45DT/ipx/xb5G6Po9jh1GQe7ZO4oRI=;
	b=ZO5ZkpyTV+v/XwHdf2QoFUk7VE/3mXTyrIU7H4NUnXhVaJIewQYtSwKKEaZ8XhR6TGMy5i
	FzkM7DF2vhSkBiripTUIdN9EfK1lnAKB13I2xGAC+xN4MZ9V2NzvvincHrnpDIU4y2Cem+
	egDDNp19g6juAlw4wSvGRmtvpkEii39iqamMH2+T63/IRhSunUc7rEC3nU1Iu57DuViRez
	pdL3BopVr7X6mAdsoJI/XHSGPUcglAPsFH03mBM1FrEKrL656rTDpg8P+5D8QP/Q2bPaRC
	/bL7HYxrsgsOrOgtWUkH6wOq0U1ZKEOtsiSx7IjksbIy2WbYKT6s6T8YCXzEgQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id de87ad87;
	Mon, 1 Jul 2024 23:36:02 +0000 (UTC)
Date: Tue, 2 Jul 2024 08:35:47 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: acme@kernel.org, andrii.nakryiko@gmail.com, dwarves@vger.kernel.org,
	jolsa@kernel.org, williams@redhat.com, kcarcia@redhat.com,
	dxu@dxuuu.xyz, eddyz87@gmail.com
Subject: Re: [PATCH dwarves] pahole: enable --reproducible_build when
 SOURCE_DATE_EPOCH is set
Message-ID: <ZoM9UymFjr5n8PPK@codewreck.org>
References: <20240626032253.3406460-1-asmadeus@codewreck.org>
 <c1414fb5-f7a8-4cb4-9c27-9c0c9b431f28@oracle.com>
 <ZnydwHhgCbUbkm44@codewreck.org>
 <fc0bff28-eb41-401b-95d4-49fd4b72e5c7@oracle.com>
 <1213004a-c75a-4882-bd51-47d458c67e04@oracle.com>
 <Zn8SsFuSAG2qPgzC@codewreck.org>
 <149bf9d7-3ac4-43d0-ae73-28f685807c68@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <149bf9d7-3ac4-43d0-ae73-28f685807c68@oracle.com>

Alan Maguire wrote on Mon, Jul 01, 2024 at 05:44:15PM +0100:
> >  - in theory, sure; this patch works. I say we can do this independantly
> > of any other effort. The propere way of setting reproducible build in
> > the kernel is not SOURCE_DATE_EPOCH but KBUILD_BUILD_TIMESTAMP and
> > handling it at kernel makefile level is sound.
> 
> Okay, so I propose we try and get the KBUILD_BUILD_TIMESTAMP-based
> change upstream. I'll send that later today. That doesn't mean we can't
> add the envvar-based method too, it just means we have something
> upstream that handles reproducible builds more explicitly.

Thanks.

> >  - in practice, (nixos hat) some modules won't set it but will only have
> > SOURCE_DATE_EPOCH available, and there are trees that won't be updated
> > for years (and that's being optimistic), so our local patch in pahole is
> > here to stay for a while and the benefits far outweight the rebasing
> > work.
> >  - (alpine hat) alpine doesn't seem to care as much about
> > reproducibility (the nixos patch wasn't in and nobody complained so far),
> > undecided at this point. Makefile.btf patch is probably good enough, but
> > since I'm maintaining the patch anyway it's no extra work to add it
> > there, undecided at this point.
> > 
> >
> 
> One thing I think would be worth doing in your patch would be adding
> debug logging (if in verbose mode) that we are enabling reproducible
> builds due to the presence of the SOURCE_DATE_EPOCH envvar. I don't
> think we can do this in the non-debug case because build logs would just
> be flooded with a few thousand of these messages for each module we add
> BTF to using pahole. With that small addition I'd be happy with the
> change. Can you send a v2 with that added? Thanks!

That makes sense, I'll send a v2 with a debug log message
tonight/tomorrow

-- 
Dominique Martinet | Asmadeus
