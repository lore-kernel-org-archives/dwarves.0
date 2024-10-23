Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D04DDAB
	for <dwarves@vger.kernel.org>; Wed, 23 Oct 2024 14:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693713; cv=none; b=g0HoIn9EuTYGqZj2oyZRfSKKCXPnAi2rbWwvwT8luok+DaptIJYd0D7LKCaO5IRt1IyCF67o2FD4KfUBErbg3HR6ydjYWPgHABS4M/+K7DJASMQ4R8MrdT3BrvSH2Na6dHSQPGka1NgQR5teO8J2uCFvIkhIEFPtfpNA0b6ST0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693713; c=relaxed/simple;
	bh=nDx97O8/zSRWawwE5DtrFdVfHebmr5vJam6LRV2ou/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ovvr9mdq4P6cex/NRCzoKXL/mioYOw4A5QJlHMXYDiRRUbHrxu+utbnQpNB9SAtr8rvrVOpcICMaj+RMywVxdbv+va/H5Tq5rOq/j8mI6TFFEDG9AtXw4f33X4jRngdnsRqQJTM+A8IXAGbUfQNj4wbidX/pRq9yrqUTwcffuLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mi62y83G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mi62y83G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59886C4CEC6;
	Wed, 23 Oct 2024 14:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693712;
	bh=nDx97O8/zSRWawwE5DtrFdVfHebmr5vJam6LRV2ou/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mi62y83Go2Y6Kg4o3ApVc+6szcFPyeGpicKM+HoQMDfoLeCs8Xwqf4mRYQarBPLMp
	 rSkLvS/8MqC1tqWDmHd/H3hm16h7XDknop+m0OlR+WQinESoYEYG6mnb0+XeUotHji
	 lTxTD8puW5zgnsiqqcOpupWJrzE9xFstwO2y9LNq6XRFxxomkjBvDmo5fwDSN6zLOw
	 X5wOO1ofq0Gbqhzbt9GmpUy8sb993+IoDQlXxTmUHUtdMl3/Kelk3/ASOj2RifiwGr
	 VxzTGY3HOcTdOUiJdXo5KgRpCs2HoA8jFlEycvAO0p5lqkrbyWWWXJi06KVgxIaAyJ
	 etT3ai2KNRsZw==
Date: Wed, 23 Oct 2024 11:28:29 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: dwarves@vger.kernel.org, eddyz87@gmail.com
Subject: Re: [PATCH dwarves 1/2] btf_loader: send warnings to stderr
Message-ID: <ZxkIDR-gucj5Vqrj@x1>
References: <20241017092433.690192-1-alan.maguire@oracle.com>
 <ZxFzGNrgeFMSswGe@x1>
 <dfab8a0a-5144-4754-ad9c-91dd69add143@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dfab8a0a-5144-4754-ad9c-91dd69add143@oracle.com>

On Wed, Oct 23, 2024 at 12:41:33PM +0100, Alan Maguire wrote:
> hey Arnaldo
> 
> 
> 
> On 17/10/2024 21:27, Arnaldo Carvalho de Melo wrote:
> > On Thu, Oct 17, 2024 at 10:24:32AM +0100, Alan Maguire wrote:
> >> Among other things, this helps simplify tests/btf_functions.sh.
> > 
> > Thanks, applied both patches.
> >
> 
> I'm still not seeing those patches in the next tree; is it possible they
> got lost in the flurry of changes? Thanks!

It was on my office machine:

b77d88003eb53fa1 (HEAD -> master) btf_encoder: Use the ELF_C_READ_MMAP mode with elf_begin()
11b59c00770dbe26 tests/btf_functions: Redirect stderr for pfunct --format_path=btf
0ee47254eae5ae26 btf_loader: Send warnings to stderr
e91433cb3bb5bf58 tests: Use PAHOLE_LANG_EXCLUDE=rust to skip Rust CUs
97f2f7ba05508273 pfunct: Use languages__init() to honour PAHOLE_LANG_EXCLUDE
cbb1149c4eaf01b1 languages: Introduce languages__cu_filtered() from pahole's cu__filter()
fa7458521b6e421f languages: Use PAHOLE_LANG_EXCLUDE env var if present, as a fallback
1f25386486e4d7b5 languages: Introduce language__init()
8fc09fd3315ce934 core: Adopt the languages__parse(), languages__in() and 'struct languages' from pahole
b9a0283d24fe31c5 languages: Start making 'struct languages' a class
⬢ [acme@toolbox pahole]$

I'm doing some tests and pushing it out to next.

- Arnaldo
