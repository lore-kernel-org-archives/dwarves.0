Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5889F79D2
	for <dwarves@vger.kernel.org>; Sun,  7 Jul 2024 22:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720392679; cv=none; b=cbqIr9H6lL5SC6i3LZYzxX0FEnhvSLc6zrHqyOQ6CeGTMmnDek4zvvHRlUS9U6Uq6hrJY+boahvk20wZyQh+7lWM3QG7C4vMSCgUKemvrpa3Cy18QJ3KQ0Z033Rjk2oG/h9tt0AkKJaSPqATMFXh0WvxXuo9ptWNMojeHW7N/ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720392679; c=relaxed/simple;
	bh=G8OZUXvfPlIDS05ANhJXR0Tpt3mzVf7bUqpKjuh+tNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQDM5zq1rl+WIsAcaw/HcpbUTzyxak9dev5S7fJARbsCu4RFgoNckzDLITMkMp8BPfkN2RzDEeoFDoSB637ZDKR0pP/FGLS8rvzoiop8wjMnUhyTwgZiDh9n3ZvNRZHaAH4dcS3pTmsk5UZNWaDDE/cbL45CQ1xW+KQSduxALNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=hkaqEHxt; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="hkaqEHxt"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id C1F2714C1E1;
	Mon,  8 Jul 2024 00:51:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1720392674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pJUe8MqoULh2j72e+cpU0nXqp3S6yFTG9ewoBycxqKw=;
	b=hkaqEHxtW9I6D+1ThALQ5Hvm4rWj7vkG/dI0kyPQIaxdi90OSHPBceGAdTg9JAcZn9b9Sn
	bhpv0McfRDShjT2TI4ypzJ4FdOePK+zLhamL4+9yqQuJOpYE375NCNe9jSMJBUJ+AC2mzC
	VSYylIdtMukF8se9HPG2Z1m4PzkxKmgLFZhDUnZiAaVWDE3nkxeAFAxPxv4odFr/oKlU3x
	KC1Gvs/UdNl2b66if1KgOuf/byKmkXIEMYMjjd26t01EESD++IecGR9qZbE1oTHZHdQxqn
	N+4XHuEYcfxc3zzEemE6uEi2iI7u8Pl00EebEMsDYypRDYHDHmvahh1FKyeW0Q==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id aa7c8532;
	Sun, 7 Jul 2024 22:51:10 +0000 (UTC)
Date: Mon, 8 Jul 2024 07:50:55 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	dwarves@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>, Daniel Xu <dxu@dxuuu.xyz>,
	Eddy Z <eddyz87@gmail.com>
Subject: Re: [PATCH dwarves v3] pahole: enable --reproducible_build when
 SOURCE_DATE_EPOCH is set
Message-ID: <Zosbz-oFqmCZELNW@codewreck.org>
References: <20240707085036.562784-1-asmadeus@codewreck.org>
 <CA+JHD93-znUmWbsmiAR+Ved7U6m0JrGAq8aqQq6qRmT_osP0aQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+JHD93-znUmWbsmiAR+Ved7U6m0JrGAq8aqQq6qRmT_osP0aQ@mail.gmail.com>

Thanks for the reply!

This can wait until you're back to work, no worry about latency.

Arnaldo Carvalho de Melo wrote on Sun, Jul 07, 2024 at 11:12:06AM -0300:
> I'm in vacation, but it occurred to me that a
> 
> --set_from_env SOURCE_DATE_EPOCH=reproducible_build
> 
> Meaning: if variable SOURCE_DATE_EPOCH
>  Is set, set the boolean command line reproducible_build.

(I understood this as a new command line option to set any btf feature
from env, if the above option is passed to pahole)

From my position there are two faces to this:
- for new kernels, a change in Kbuild to add som flag would definitely
work.
The patch to set --btf_features=reproducible_build to pahole from Kbuild
if KBUILD_BUILD_TIMESTAMP is set got shot down by Masahiro Yamada, but
hopefully something will be worked out eventually...

- for nixos/old kernels, the current pahole version produces
reproducible output if SOURCE_DATE_EPOCH is set (because someone patched
it to default to -j1 in this case in our tree), and now the reproducible
build option exists I'd like to upstream something more appropriate
that'll "just work" without worrying about old kernel trees and adding
new explicit pahole arguments there.

So adding a new switch to set a flag from env probably won't help me
much, but a new env var like PAHOLE_BTF_FEATURES (PAHOLE_FLAGS is
used/overwritten by Kbuild...) that would just call into the
--btf-feature parsing code, e.g. exporting
PAHOLE_BTF_FEATURES=+reproducible_build would toggle the option) would
probably work for me.
(Have to be careful that this is not the same as --reproducible-build,
so perhaps something else might be better... but regardless it'll
probably work out for linux kernel builds)

It's less convenient than having SOURCE_DATE_EPOCH just "make it work",
but at least there'll be a single place to edit that'll work on all
older kernels for a given distro.
(and the "just work" side of things might come for newer kernels at some
point for distros that care less...)

What do you think?
-- 
Dominique Martinet | Asmadeus
