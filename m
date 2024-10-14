Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E772BD19
	for <dwarves@vger.kernel.org>; Mon, 14 Oct 2024 22:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728945576; cv=none; b=mJn6XOkB/4HonancXjn62JZ4n4BIuUsKkvRy/Yd3L5A0mPSurUoD+YEBsU++65mrW7yeBVGnBr/V3q9NgTv0Nw7Z/GsKpTAhu0hKZrXbRxJMpqJh/D+Qg6aIPXaDKHnCQgbJBA3R2+kkGU2iUo9siaCWx6569EvSfUIQH5IEXiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728945576; c=relaxed/simple;
	bh=ci4majRtWrxrdymYMltxwybeGV2uI+g5It90ArQ4pBU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VYhQfjE5UYj7+uCBthqGBlwlbms+wsdXhE1ZjKtnOt+4cl5kwZMk9/dLnk8EfT04Scngv4hLZ7pI2PqYuNmZpf1WGM1y5QQrBK1k5Iq0PRRxyvAhE49RR8QskT9a8Y9PbxM6+kc22nbi4l5gAqMD9pHKEDOJ+1S0CgiTip2LKAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=UsE1IThP; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="UsE1IThP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728945573; x=1729204773;
	bh=mr8QA7DdSZUyBQuADC5LtaGc8g4FriYXVS61dXyVPug=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=UsE1IThPcCRD8ilPuCIlpLRG7wcL5jq+rddhbmd64Dvlew4nKxayPs/V+5KXiJl3g
	 0dGgcIwzXQ14y7YmDVxdLyzf/QiKCAbpOh8HzXetw5cGjmb3t2F1RXHtDNaoT5Sffp
	 LQGBlr5PgJcix3v8IpEObzdAKH8AM0m6XQkvVbaVTRv87r4hqocoDa6fVv/9Ee4uoM
	 IZuUDLrB6b+1+M2kJUknPogUceJ2LpuKS+hvs49f20isplqxPIa0xYaD3/oAc9nvcB
	 3xYQUfrQq3QFc1O3j1PoRndUOOPZX6QwXiBvAJg0VtqhMkn2ueEXpKUB7Tv5EHPzwc
	 bRQNVLKtD7fuA==
Date: Mon, 14 Oct 2024 22:39:29 +0000
To: Eduard Zingerman <eddyz87@gmail.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, acme@kernel.org, alan.maguire@oracle.com, andrii@kernel.org
Subject: Re: [PATCH v2 dwarves 4/5] btf_encoder: make elf_functions.entry an elf_function list
Message-ID: <U_bKKwuFUoWNsHOg6gCjnx3-9xFdYjs2TkaFEc9bK6VUMPwSFrKtXmpHHWVd95-okxFCqcJXxpUApq-ndVz34uFvOsX-AB22iVEa0QjDOb8=@pm.me>
In-Reply-To: <079a99a2e5207d824ef69ba1d11a530d403711f1.camel@gmail.com>
References: <20241009233520.989453-1-ihor.solodrai@pm.me> <20241009233520.989453-5-ihor.solodrai@pm.me> <9f0b3a85b37d10bff446a43b2c154b1abd723d5f.camel@gmail.com> <lVQ48eIOm008BvczqG7o2mjZ7Ofw8u22LnM4gT4L1BGn8yBaE5sZm0TeYi4dBZ6LXGGm0b7l7g-1wtpH2rQoG7AC2LyjdsqP5oK-r5r4ka4=@pm.me> <ccbd5bd24ef1f68b6310434a55752cba961ed20d.camel@gmail.com> <079a99a2e5207d824ef69ba1d11a530d403711f1.camel@gmail.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: d95a730e5acb0f1adb985ea6e1605e9f74e9e667
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, October 14th, 2024 at 1:20 PM, Eduard Zingerman <eddyz87@gmail.c=
om> wrote:

> > [...]
> >=20
> > > I remember we discussed off-list simple accumulation of elf_function
> > > structs, and removing merge logic from btf_encoder__save_func(). I am
> > > hesitant to switch to that, because this would mean that multiple
> > > elf_function objects for the same encoder might be stored in
> > > elf_functions table. This in turn would require more changes. For
> > > example, how btf_encoder__find_function() should behave then?
> >=20
> > Then I don't understand how elf_function objects are protected against
> > concurrent update, btf_encoder__save_func():
> > - mutates elf_function instance;
> > - is called from btf_encoder__encode_cu(), called from pahole_stealer()=
,
> > executed concurrently;
> >=20
> > Here is a fragment of the btf_encoder__save_func():
> >=20
> > existing->optimized_parms |=3D state.optimized_parms;
> > existing->unexpected_reg |=3D state.unexpected_reg;
> > if (!existing->unexpected_reg &&
> > !funcs__match(encoder, func, encoder->btf, &state,
> > encoder->btf, existing))
> > existing->inconsistent_proto =3D 1;
> >=20
> > If concurrent access to elf_function instance is allowed,
> > '|=3D' operations need to be atomic and funcs_match() needs some mutex =
to
> > prevent BTF update (as you point out in the commit message).
> > What do I miss?
>=20
>=20
> Ok, I forgot about the implementation of the find_elf_function_in_list().
> Please ignore my previous comment and sorry for the noise.

Yeah. In case it's unclear for a reader, I'll try to explain.

btf_encoder__find_function() guarantees that a particular encoder gets
an elf_function struct that it "owns": meaning no other encoder
touches it.

Because of that btf_encoder__save_func() does not require any
synchronization code.  We know for sure that an encoder passed to it
is always the owner of the elf_function passed to it, and so the
elf_function can be safely modified.

