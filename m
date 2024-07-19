Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E395664
	for <dwarves@vger.kernel.org>; Fri, 19 Jul 2024 19:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721416384; cv=none; b=nZpzPugIJwCTgy6i5bi4ZWQoJoT0vZv2ydhopqe6QHKy+AXSOCQRAN1u/dNmWbOS170GwwoxfcBPs0Bkwk/WIGS3/XollBAjjdFpYEHy4ZHfZCYjsy3BsWzMk0xs6RL16wdIDg9WDU0o/HNN3UWk9N/CZY7FMLmLY5xT7f3jW/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721416384; c=relaxed/simple;
	bh=89uaCHjJmoYNKNUudPcSGeLkpsTk7YHKOq4uyJAOEaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJpw61+4F2t9EwymrtbtsDNq8ddISvUIexQo4r9XrO6oWK1Zvt/DsCW0wFtnl2rBv01ixY24+Si4UxH+kg8O0AVMFJNDHXmuIJtFalUXw8LYuYn90LpjKGt95hOAszzj9qwEe4abhZuW9ZckU11wlGazDpnul8FTc0tb5/VNjtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAhGIjRM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAhGIjRM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E026C32782;
	Fri, 19 Jul 2024 19:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721416384;
	bh=89uaCHjJmoYNKNUudPcSGeLkpsTk7YHKOq4uyJAOEaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EAhGIjRMyI4fFE1jZcsmibkcL48JU4p+pig/8VH4RzsRW3QXI8qOSrRIZgFk2FA05
	 hx3cjg1r8xmj/0FOi2BdOD9ojNbQWWpLFu3GPgSZRIT81Ad+4yuwNFiXaogzas9O1G
	 GtVz7mHDmcM9/N6uHAWxZWhIQSl2U3k6/LfHkwQWdfk9zGmZMroPb7mFX5NL3uUttA
	 +1G/Uv33U+rfstnWGSXdai39vCsiqNLNXUvpKy9UnePTq8SQWORtlC41xfrMFzOW1O
	 HdK0kx+dDBPX3L7RW2lmWhihZd7Qc2EtxgyBcn1Xc+uhHPTXgSFa4ZjPga4UzEC3F8
	 7E29FSaFjU29w==
Date: Fri, 19 Jul 2024 16:13:00 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Domenico Andreoli <cavok@debian.org>
Cc: Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>,
	Ben Hutchings <ben@decadent.org.uk>, 1076564@bugs.debian.org,
	dwarves@vger.kernel.org
Subject: Re: Bug#1076564: pahole BTF processing seems flaky on powerpc
Message-ID: <Zpq6vEB3G1UlAeGR@x1>
References: <172133976964.70930.13662511677581571913.reportbug@deadeye.wl.decadent.org.uk>
 <ZpoNZHIYuERg49N1@localhost>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpoNZHIYuERg49N1@localhost>

Adding Alan and Jiri to the CC list.

On Fri, Jul 19, 2024 at 08:53:24AM +0200, Domenico Andreoli wrote:
> Hi Arnaldo,
> 
> On Thu, Jul 18, 2024 at 11:56:09PM +0200, Ben Hutchings wrote:
> > Package: pahole
> > Version: 1.27-1
> > Severity: normal
> > X-Debbugs-Cc: debian-kernel@lists.debian.org
> > 
> > Several kernel builds on powerpc have failed recently:
> > 
> > 6.8.12-1:    https://buildd.debian.org/status/fetch.php?pkg=linux&arch=powerpc&ver=6.8.12-1&stamp=1717234422&raw=1
> > 6.9.9-1:     https://buildd.debian.org/status/fetch.php?pkg=linux&arch=powerpc&ver=6.9.9-1&stamp=1720906547&raw=1
> > 6.10-1~exp1: https://buildd.debian.org/status/fetch.php?pkg=linux&arch=powerpc&ver=6.10-1%7Eexp1&stamp=1721287862&raw=1
> > 
> > Note, these log files are up to 270 MB in size and should be
> > downloaded; at least Firefox becomes unresponsive when trying to
> > display them.
> > 
> > For each of these, the failure seems to start with an error from
> > pahole such as:
> > 
> >     [102044] ARRAY (anon) type_id=99491 index_type_id=14 nr_elems=12 Error emitting BTF type
> >     Encountered error while encoding BTF.
> 
> Does the above error ring any bell?

Nope
 
> Is there anything I can do to help?

From the 6.10-1~exp1:
https://buildd.debian.org/status/fetch.php?pkg=linux&arch=powerpc&ver=6.10-1%7Eexp1&stamp=1721287862&raw=1
file:

+ LLVM_OBJCOPY=powerpc-linux-gnu-objcopy pahole -J -j --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func --lang_exclude=rust .tmp_vmlinux.btf

Can I have access to that .tmp_vmlinux.btf file so that I can try to
reproduce it here?

- Arnaldo
 
> > 
> > This does *not* happen consistently.  Compare these successful
> > builds:
> > 
> > 6.8.12-1:    https://buildd.debian.org/status/fetch.php?pkg=linux&arch=powerpc&ver=6.8.12-1&stamp=1717278092&raw=1
> > - This same version failed to build on the first try.
> > 6.9.7-1:     https://buildd.debian.org/status/fetch.php?pkg=linux&arch=powerpc&ver=6.9.7-1&stamp=1719538806&raw=1
> > - Earlier and later 6.9.x versions failed to build.
> > 
> > Both pahole versions 1.26-1 and 1.27-1 have been used in both
> > successful and failing builds.
> > 
> > Ben.
> > 
> > -- System Information:
> > Debian Release: trixie/sid
> >   APT prefers unstable-debug
> >   APT policy: (500, 'unstable-debug'), (500, 'stable-updates'), (500, 'stable-security'), (500, 'oldstable-updates'), (500, 'oldstable-security'), (500, 'oldoldstable-updates'), (500, 'oldoldstable'), (500, 'unstable'), (500, 'stable'), (500, 'oldstable'), (1, 'experimental')
> > Architecture: amd64 (x86_64)
> > Foreign Architectures: i386
> > 
> > Kernel: Linux 6.9.9-amd64 (SMP w/12 CPU threads; PREEMPT)
> > Locale: LANG=en_GB.UTF-8, LC_CTYPE=en_GB.UTF-8 (charmap=UTF-8), LANGUAGE not set
> > Shell: /bin/sh linked to /usr/bin/dash
> > Init: systemd (via /run/systemd/system)
> > LSM: AppArmor: enabled
> > 
> > Versions of packages pahole depends on:
> > ii  libbpf1     1:1.4.3-1
> > ii  libc6       2.39-4
> > ii  libdw1t64   0.191-2
> > ii  libelf1t64  0.191-2
> > ii  zlib1g      1:1.3.dfsg+really1.3.1-1
> > 
> > pahole recommends no packages.
> > 
> > pahole suggests no packages.
> > 
> > -- debconf-show failed
> 
> -- 
> rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
> ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05


