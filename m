Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FCD18AF9;
	Wed,  3 Apr 2024 21:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712180296; cv=none; b=eOiHCa/TkD4/ceHC3POuEW2opJPFpR3VFwmUorrRfKTCg0j18Pnm7oEsZ+NTQSGlvGra/9dC8EPrCrC/kP8JEliel8xoJ/ewphorSdK5VxBQsZ76ddrc6d0Hk5nudEgxF1zM56ybpyIVxYQNvIVXPijf8uqV/5J3Q9KEVefcB0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712180296; c=relaxed/simple;
	bh=fJ67n6xbBSw+d9rVvxbMMX4TT9iAw9CQYmCSdSKX+u0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LuSQUyf8N8LOpG2YemT7KyL4aYZoWCJmG7y8oZNoDAAbqLqS4ANGMS/T7n9I6FpxcM1z7EySwxKaeTeimhRV/7AcKC+gTH4OHwRSs2F8VjwfaAgqR0tLJ16Fc+/9neM26BVJuVmrRhzpMVPR6LDuumy8ONGM/XWZhboPWxwzUm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVzkfijX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVzkfijX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99806C433C7;
	Wed,  3 Apr 2024 21:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712180296;
	bh=fJ67n6xbBSw+d9rVvxbMMX4TT9iAw9CQYmCSdSKX+u0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iVzkfijXE/sBIbmH7rKEOvlYpGzA5DvizHdJpVcSkBHOlhc9k8ydA70jEjjslhvPz
	 zi4fEDeCCIXHRLAnbRJSzQ0mHf1PAjnFklTaz8QGYqMbvC9CScvDb7ffu+KdbxpPWv
	 hJHJpadV2sMmxNB8jMnNFgA7a7e1UKA+/Acz3Jqs8SO9lzFoCEeQT9EDE4QKfeWLGo
	 OlSuJ2hgY4ZCFag5cVsrcYZgNGTs2vRnkzBrdNwsD7u/snK9/eeaeHKzSwB6/LWEud
	 qUMPWlc07VdgP6jZE6ru8JCnWK5gohGU2kvGAINHr3zDaDtH7TFXPbgeem9/yeFmnx
	 T/INaCGFJKewQ==
Date: Wed, 3 Apr 2024 18:38:12 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: dwarves@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>, bpf@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Kui-Feng Lee <kuifeng@fb.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH 02/12] pahole: Disable BTF multithreaded encoded when
 doing reproducible builds
Message-ID: <Zg3MRC4bhJgMmDTt@x1>
References: <20240402193945.17327-1-acme@kernel.org>
 <20240402193945.17327-3-acme@kernel.org>
 <CAEf4Bza1BG+f__D4fvDvZueGxL0yrMuVu6LZQmNyme584L7r4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bza1BG+f__D4fvDvZueGxL0yrMuVu6LZQmNyme584L7r4w@mail.gmail.com>

On Wed, Apr 03, 2024 at 11:19:33AM -0700, Andrii Nakryiko wrote:
> We can still produce per-thread smaller BTFs in parallel, that won't
> hurt reproducibility. You only need to concatenate them in
> reproducible order at the very end.
> 
> Or maybe it's already working like this, not sure, I'm a bit rusty in
> pahole internals nowadays, sorry :)

Yeah, its just that I didn't get to that point yet, I just stopped here
to have the parallel reproducible feature working, will continue with
the parallel BTF part.

- Arnaldo
 
> > diff --git a/pahole.c b/pahole.c
> > index 96e153432fa212a5..fcb4360f11debeb9 100644
> > --- a/pahole.c
> > +++ b/pahole.c
> > @@ -3173,6 +3173,14 @@ struct thread_data {
> >         struct btf_encoder *encoder;
> >  };
> 
> [...]
