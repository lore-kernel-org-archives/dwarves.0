Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ADD3A1B6
	for <dwarves@vger.kernel.org>; Mon, 14 Oct 2024 19:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728934770; cv=none; b=l797iLf6JZ71Q+ZCec8Wsa7SBEbKig8aBeEn1UaG9J1AwYkIm58oRM90mqumwNFYVD2vygzaGs9r/WX4YZoSUALngyxhqQcin40gnpODIH+TuPEMirOtFKCbJyeZxSDBBHlNIADwU+sXTWsLSNe2HbHlI9bjnK5JX+AQYNFM4dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728934770; c=relaxed/simple;
	bh=YvWkNe+FCgk7qT8XpmxAM3HphZ5eFHrhUB2JiBTO5NI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TkInKtcAV7P1/rxnYPre05DR6zXL9v24W7RajRCpyy61O1bBRe5G7Ec95cqG39dHSj2xdYFtjuhP8bCemZwvSkWiXcD3L7tn5mvPUTBovtT7EYyc6wUuRdz8YdMmgssCuf+SUTbgV/wdpJU/29puvi4olHHz71KGjllkeJb1KWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Uso0SN3Z; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Uso0SN3Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728934758; x=1729193958;
	bh=YvWkNe+FCgk7qT8XpmxAM3HphZ5eFHrhUB2JiBTO5NI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Uso0SN3ZAnt8+kWg5loqvdgbdVNvzt5xl7TWCeZCyALNimvzTzOhS4ZIYvmKnuFHk
	 u4I6L4W7GmRAKrZVivkDFZhF97G68cpgVByqhTA1wbfv+/w3eqxYo15WL0Vm9Z2GM8
	 5UBpTAiNk0cpJCUyx2z5rCM1G6EgEyW2laLBUtX5K8R0nx5UevQFGGZBR7qj8wQ9+h
	 xMLDq4HIg0gdoLJqdH+XHEYuXVwlE0q8dqI56Eaj8/Me42kP0vvheHLCiqM1cFPjtv
	 EmMIJTR0IFBEGyiW8qdN7Uk8nNg9uYYKT3E/wJQoNSrJxYBueQfwPrSxva4r1AxPaf
	 cw8855X77l2Vw==
Date: Mon, 14 Oct 2024 19:39:17 +0000
To: Eduard Zingerman <eddyz87@gmail.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, acme@kernel.org, alan.maguire@oracle.com, andrii@kernel.org
Subject: Re: [PATCH v2 dwarves 4/5] btf_encoder: make elf_functions.entry an elf_function list
Message-ID: <lVQ48eIOm008BvczqG7o2mjZ7Ofw8u22LnM4gT4L1BGn8yBaE5sZm0TeYi4dBZ6LXGGm0b7l7g-1wtpH2rQoG7AC2LyjdsqP5oK-r5r4ka4=@pm.me>
In-Reply-To: <9f0b3a85b37d10bff446a43b2c154b1abd723d5f.camel@gmail.com>
References: <20241009233520.989453-1-ihor.solodrai@pm.me> <20241009233520.989453-5-ihor.solodrai@pm.me> <9f0b3a85b37d10bff446a43b2c154b1abd723d5f.camel@gmail.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 705e92847a9ed6776ef566f0e746000e036975d5
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday, October 10th, 2024 at 1:57 AM, Eduard Zingerman <eddyz87@gmail=
.com> wrote:

>=20
>=20
> On Wed, 2024-10-09 at 23:35 +0000, Ihor Solodrai wrote:
>=20
> > btf_encoder__save_func() accumulates observations of DWARF functions,
> > maintaining an elf_function per function name.
> >=20
> > Part of this routine is a funcs_match() call, which requires access to
> > BTF implicitly referenced by btf_encoder_func_state. In case when
> > elf_functions table is maintained for each btf_encoder this is not an
> > issue, because every btf_encoder_func_state available to this encoder
> > can only reference its own BTF. However, if elf_functions becomes
> > shared, existing elf_function/btf_encoder_function_state structs can
> > be produced by other encoders with their own BTFs. In this case
> > funcs_match() can not be called unless BTFs are available and writes
> > to them are synchronized in some manner (which is not desirable).
>=20
>=20
> Nit: Something is missing in explanation at this point.
> In the paragraph above you describe why funcs_match()
> can't be called concurrently.
>=20
> I think a sentence is needed explaining that the solution is to
> forgo concurrent funcs_match() calls and simply accumulate info
> about all functions in DWARF.
>=20

Ok, I'll try making the explanation better.

Just so it's clear, in this patchset there are no changes to
btf_encoder__save_func() at all.

This patch changes what's stored in the table (list of elf_function,
not a single elf_function), however there is still only one
elf_function per btf_encoder. This means that if a particular encoder
encounters the same function more than once, its
btf_encoder_func_state is going to be merged in
btf_encoder__save_func(). And in this case calling funcs_match() is
ok, because the functions are in the context of the same encoder
(hence the same BTF).

I remember we discussed off-list simple accumulation of elf_function
structs, and removing merge logic from btf_encoder__save_func(). I am
hesitant to switch to that, because this would mean that multiple
elf_function objects for the same encoder might be stored in
elf_functions table. This in turn would require more changes. For
example, how btf_encoder__find_function() should behave then?

I am inclined to stick with current (v2) approach, but want to make
sure you're aware of this.

Let me know what you think.

> > Accumulated states are later merged between encoders in
> > btf_encoder__add_saved_funcs(). To enable sharing of the elf_functions
> > table between encoders, two members are introduced to struct
> > elf_function:
> > - elf_function *next - to enable linked-list
> > - btf_encoder *owner - to find elf_function corresponding to a
> > particular encoder in a list
> >=20
> > Each element of elf_functions->entries is a head of a list that stores
> > elf_function structs one for each encoder that searched for this
> > function name at least once.
> >=20
> > btf_encoder__find_function() is modified to perform the search on
> > shared elf_functions table, and atomically update a corresponding list
> > as necessary.
> >=20
> > At this point each btf_encoder is still maintaining it's own
> > elf_functions table, but the updated implementation is used.
> >=20
> > Suggested-by: Eduard Zingerman eddyz87@gmail.com
> > Signed-off-by: Ihor Solodrai ihor.solodrai@pm.me
> > ---
>=20
>=20
> Aside from a few nits, I think the logic makes sense.
> Not sure if it is worth it to separate patches #4 and #5.
> [...]

