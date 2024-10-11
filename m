Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F6718027
	for <dwarves@vger.kernel.org>; Fri, 11 Oct 2024 16:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728665527; cv=none; b=M6AWM1+lOmN8xrHYw8PaQNYb2l09A71YznrZxkR7N6AbOHabEIGEYsoiuq42yTnIgHat85EDhnaKf0J0Wl71PwD/VbX7UR2ZF/dCcLVPAeYWe1nLQIZ1hitQZf0sbCBNNIoVwkC/DE+5MxajurL/TMU2WI8ZtXQ8+oGuHkaIV7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728665527; c=relaxed/simple;
	bh=h4aaX8Jq+NIsBj9/0GI+NdPrgovioPWS01Tj9WIchXM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ra16rwJRi1yA40CtNs5niODxaDvoBZ15v00drujlNcL/w/AXSJ521VsAxQTaB850qbkUZA7NcYIxMYsUvxXaHVtyB/2D1qfT6IxxejeLr6UoJk0iQJKTwrbmPm6fFbmsWESprwR1gCuw+snR6lEPa0nzMKvklqpODPYXp/Yu6aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=DdX1u0EW; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="DdX1u0EW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728665524; x=1728924724;
	bh=h4aaX8Jq+NIsBj9/0GI+NdPrgovioPWS01Tj9WIchXM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=DdX1u0EWMgIMyj/u3T82U5kwwdr2TUp84TBtF3MpGkv0rcbwOrsRZzwVbpQkWimEq
	 lf0a6AauM5O/yKv2cRSIpUXeSgI9SxWYKJ+0WGo6POINejG0GGOpurNV9Q72dMl8ui
	 RReKotoOd3ccf3UuUdpxGh4kYlGqMT2K2WaxjTvvSH1TlEEZ57rYqvexOGpEFgStiP
	 g9R0/C6x0DHgXykL3FyjrJ8BHqFxbOFnS4cXaCHWOoRjLEYBHj3S8f+0UzVkwfG6Ms
	 Dl7hXyaNa/R+Bf82mkgLvlJMY83drA0fyqqWrcUEe+kCx/SlGQxNKQ4pyCe9sPkXIh
	 5YXNi8Lsgo6Fw==
Date: Fri, 11 Oct 2024 16:52:00 +0000
To: Alan Maguire <alan.maguire@oracle.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Eduard Zingerman <eddyz87@gmail.com>, dwarves@vger.kernel.org, acme@kernel.org, andrii@kernel.org
Subject: Re: [PATCH v2 dwarves 0/5] btf_encoder: implement shared elf_functions table
Message-ID: <m_fH6Yg0CAytjEUTxfZPpbMVGqGQWhuep4D--XMNrOZJh6MUWlIozEXiCC6ulW4FK6UFvCFlZC_sF0oNsAW3sftTvfPBjpz5AN3MdnxfhB4=@pm.me>
In-Reply-To: <52889283-56c4-4cf6-aad6-b0fbea9e58fb@oracle.com>
References: <20241009233520.989453-1-ihor.solodrai@pm.me> <60b79369e829b33c577fe285b6597894e72b7042.camel@gmail.com> <4C0idzPIUJesSQi12dB1SgeTQlGl13N2CCsvjPfdLbvTEemTJoQZ4P-LJcOQqRyM69ZLKVv4mIKDQJvfMYMV2oITse1_uS_m_SjVigh8bL0=@pm.me> <af7ca712-7798-4204-9e15-fa2065154699@oracle.com> <52889283-56c4-4cf6-aad6-b0fbea9e58fb@oracle.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 4b954f16586016fc1598bcffe56096a8c608eff4
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Friday, October 11th, 2024 at 9:27 AM, Alan Maguire <alan.maguire@oracle=
.com> wrote:

[...]

> > Thanks for these stats! In general, I really like the direction; it als=
o
> > fits neatly with our future plans around encoding additional info like
> > function addresses; the previous approach of storing all info via name
> > matching wasn't ideal for that. I'll try it out and review the changes
> > tomorrow.
> >=20
> > One thing I'm curious about; I presume the above stats are for
> > single-threaded peak memory utilization, right? If that is correct, how
> > do things scale as we add threads? I'd assume that since we're now
> > sharing ELF function info, we should see a drop in peak memory
> > utilization for nthreads > 1 (as compared to the baseline next code)?
>=20
>=20
> Did some experiments here, saw no significant difference in terms of
> peak memory utilization; this may indicate the peak memory utilization
> is a function of something else. Comparing peak memory utilization
> between 1 and 8-threaded encoding, a similar pattern is observed for
> baseline next and this series, for baseline 1 vs 8 threads we see:
>=20
> < Maximum resident set size (kbytes): 1069304
> ---
>=20
> > Maximum resident set size (kbytes): 1119412
>=20
>=20
> ...while for this series 1 vs 8 threads we see
>=20
> < Maximum resident set size (kbytes): 1071148
> ---
>=20
> > Maximum resident set size (kbytes): 1125052
>=20
>=20
> So pretty similar really. Maybe a system with a larger number of
> processors would reveal something more here and show the benefits of
> shared ELF representations.
>=20
> > Another thing we're encouraging is running the tests; you can do this
> > via
> >=20
> > vmlinux=3D/path/2/vmlinux ./tests/tests
> >=20
> > Not too many there today, but we're working on growing the set of tests=
.
> > If you set VERBOSE=3D1 too you can get a lot of extra info around funct=
ion
> > encoding. One thing I think we should be careful about is to ensure we
> > get a similar number of functions encoded with these changes as compare=
d
> > to baseline. I don't see any major reason why we wouldn't, but good to
> > check regardless. Thanks!
>=20
>=20
> I tried this too, and compared verbose output of baseline and test
> btf_functions; both were identical:
>=20
> $ VERBOSE=3D1 vmlinux=3D/home/almagui/kbuild/bpf-next/vmlinux bash
> btf_functions.sh > /var/tmp/btf_functions.baseline
>=20
> $ VERBOSE=3D1 vmlinux=3D/home/almagui/kbuild/bpf-next/vmlinux bash
> btf_functions.sh > /var/tmp/btf_functions.test
>=20
> $ diff /var/tmp/btf_functions.baseline /var/tmp/btf_functions.test
> $
>=20
> This suggests the results are the same since we encode the same number
> of functions, refuse to encode the same number of inconsistent functions
> etc. Which is great!

Hi Alan. Thank you for testing!

I was going to run a couple more experiments today and respond, but
you beat me to it.

I am curious about the memory usage too. I'll try measuring how much
is used by btf_encoders and the elf_functions specifically, similar to
how I found the table was big before the function representation
changes [1]. I'll share if I find anything interesting.

[1] https://lore.kernel.org/dwarves/aQtEzThpIhRiwQpkgeZepPGr5Mt_zuGfPbxQxZg=
S6SSoPYoqM1afjDqEmIZkdH3YzvhWmWwqCS_8ZvFTcSZHvpkAeBpLRTAZEmrOhq0svfo=3D@pm.=
me/

>=20
> Alan
