Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB94E14A82
	for <dwarves@vger.kernel.org>; Thu, 23 May 2024 20:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716496884; cv=none; b=m+WQOfP3h0mtE2zhxI5M7QKnsbMN+RoAWvYre/IPacfM/XXQ5GGpKOqg8mrGZy0p6VHVsiuS/E9Gg9qgi0tGZfKKLQ15vHqxuc+GwPf815fZ24FT6fK9T3iM1n8mZ9vLkG6DIH4AyulcQhKfV/+gtIozS7Rp7rkAoSOLTWXRWvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716496884; c=relaxed/simple;
	bh=FRU5N7B/oLuusD9l1lE9UPPG2phiaB0R/srHxBIs5vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eSFDOcGMmfV2QiuxM13Mi0HyUYeZUqh7RyBZwrqU8q8+NEoVPRmf5CxAz3r99M44oYcAGQeFhNSi19Pj12MwAIWvVqF9dUpKt+04OSuQ5OYJa/o/xqaQAHZaYGZEY9ttddbJ9bFtaZMw1EXaAEhqIgF/ngTEgRyKEjPYWL6Q/p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EijkLdPP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EijkLdPP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2275C2BD10;
	Thu, 23 May 2024 20:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716496884;
	bh=FRU5N7B/oLuusD9l1lE9UPPG2phiaB0R/srHxBIs5vw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EijkLdPPniUnRFQERjiYXUv+RY9eet3VrihQFntLthyorDiW1kqSRnbRRnPi35W0Y
	 +65B5EKiHWiU9NfR8GgotqyPyN0zVI5tJNLb4Tiqq5Bx/7mHRlwnRL1cjwIFWG8V4G
	 8oXoPtGzVskHqZuXQjAZbksDVt8u561+BXBJZwQhGdM14sgNDhn222NjEym0JF4yNP
	 P0EkS7J0h3sfU2d08wmEmAZ63o5ElxG7M/mzoTctkY0A12dhKYb5qFgFt3w/YaZACb
	 tGsip09dLWt9ZhUvAFW7loZtV5I2s+4GlNVUfMNG7AU9cjfthOtuPJsfWw/VoQCWyT
	 k4dx/GG6wip/Q==
Date: Thu, 23 May 2024 17:41:20 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Giuliano Procida <gprocida@google.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, dwarves@vger.kernel.org
Subject: Re: pahole -J non-determinism and reproducible builds
Message-ID: <Zk-p8EPf-5juWsS1@x1>
References: <CAGvU0H=MvKi=fk6K1M7O+OoGdnNzweXE1m=18yv2DHoPbRVASg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGvU0H=MvKi=fk6K1M7O+OoGdnNzweXE1m=18yv2DHoPbRVASg@mail.gmail.com>

On Thu, May 23, 2024 at 08:25:17PM +0100, Giuliano Procida wrote:
> Hi.
> 
> (edited repost due to unfortunate HTML email).
> 
> Until the reproducible BTF changes land in a new pahole version, and for
> anyone stuck on older versions, pahole -J -j typically produces
> non-deterministic BTF.
> 
> For Android, we are converging to hermetic, reproducible builds. .BTF
> sections are a significant difference we see. I have trivial patches to
> pass -j1 instead of -j for the older versions we are using (1.23 and 1.25).
> 
> Trivial patches:
> https://android-review.googlesource.com/q/Ibd72ac638faa1826f6655b336cc7001591ea70f1

That should be at least configurable thru a CONFIG_REPRODUCIBLE_BUILD
that then would check the pahole version and if less than 1.27 then
would use -j1

So it continues to use -j from the version where it was introduced,
1.22, but for people wanting reproducible builds it plain don't use -j
or if you really want to be explicit, uses -j1 as you did.

For >= 1.27 we will have 'reproducible_build' added to the
--btf_features= line if CONFIG_REPRODUCIBLE_BUILD is set.
 
> Gaining determinism for the older versions means giving up some performance.
> About a factor of 2.1 in our case (or an extra 10s on vmlinux).
 
> Do others want performance or determinism, should I send patches to LKML
> and the stable list?

But that is with older paholes, for 1.27, to be released next week, one
will just use '--btf_features=+reproducible_build and continue to have
parallel DWARF loading with serialized BTF encoding, which should be
close to the non-reproducible build numbers.
 
> Off-topic: pahole -J -j9 is faster than -j on my machine with 36
> cores, by another
> factor of 2. This is v1.25. -j1 18.7s, -j9 4.5s, -j 8.9s.

I'll try to profile that on a 5950X (16 cores, 32 threads) and a 14700K
(8 performance cores (16 threads) + 12 efficiency cores (12 threads),
total 28 threads) to try and see if I can get a better heuristic that
takes into account these factors on the most recent codebase that will
become 1.27 next week.

- Arnaldo
