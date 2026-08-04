Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227193F0A9B
	for <dwarves@vger.kernel.org>; Tue,  4 Aug 2026 21:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785880675; cv=none; b=hsZ5YyI6m2xO4ffkkGqfGf6xIbxfmNeh1vXq9kLvoh1BWb/coi8xuG+2x6H/5+xxNnIAONNBIIGMNT8BxePiCbktzMqLbeMqIMZUVHRF359oN1MC9Yzpv6bDdIbm3SbHDW9MGKVZenpWbLmslkq8oOpRkQJj92mIcpu03TdexN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785880675; c=relaxed/simple;
	bh=bazBetjsxQq5MjeKEpDzSD7O7DNn6pnzRUUkEVy5L1s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=NX2RuI7YlL72r5dv92B7BZWzjEHBBHiBMHfHk6BAouNgd6/Bx5MLj/78tWG4poUrOGQ68eK277JZhB38XX4cGYdBBSp/qfxALPVe1xD6ivpbVU6LQwH89kFVGWCYMLcv+WXr5p6SQqyQTm1mMXCuGHMNhDwsm0d0eU3voRCiMLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b516oCJG; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b516oCJG"
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-498079e98beso671135e9.1
        for <dwarves@vger.kernel.org>; Tue, 04 Aug 2026 14:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785880672; x=1786485472; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bazBetjsxQq5MjeKEpDzSD7O7DNn6pnzRUUkEVy5L1s=;
        b=b516oCJGd4r1Lnmd+fHO2O/Pn85SA9Av6VdIUJybOKGPeYzOgwgL1cn4sg5dkjV9qF
         lUJNuG7quCm5LWkRNEMVnGW2ChJH5Ylh+GJC97L35BggRpxUt4vqUsQqYzMHZdax4syX
         2asG6OqaxaQEhwUWJMBKPxpAZOr82lXIxUET2Y9WEbgNek0D73os+09+B0wU71PnoLNL
         q0VGYF7nTT73JUQve/wXWRz1U/dg+wp77ILOnBdOvi9YvfKvqKHzb9Hg+Lq0yrJPgKyb
         8Z0p88o6Ps3fX73s3H9iOvuFM7ACveg00Ucu71/KSXw6RDWIqTTgezPuAdbCJodQCJOH
         Na/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785880672; x=1786485472;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bazBetjsxQq5MjeKEpDzSD7O7DNn6pnzRUUkEVy5L1s=;
        b=cVaJXSQ7bsoNvzqzB2bE/lTsLoHJ6aCMeCZzMvqJf19SxeRqz9rDPrH+uE9EcAV4lg
         zA0HFq2nVAuQ4nwifFxW/j6Y1rGl4srvjTVhfEkxN81SlyZ55if6AvCo0mkLnqBBkVeS
         GvwX8XL7ejOKxH6cMwY+bhTjGk5DvFUjJRJcLCR4po9t7y6KAtygEPAE5zeELJXm1j74
         AiBmC7iv/1hUcWGd+5DTrchaGWvFj+TUSI6gSQ1CaP4plaXmQ8S7qIfxgsF/CFk4ZPo4
         fiUPja6wqc6Qmt+6KnOdAjXZq4ZnZbKaG5R9GA5T+O7PQLPxTwWzZ3nznuaLlNcsdUme
         aMgQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp2g+TdBIvZzNXXty9udy/Z8TwyqDY2tRBZIvN3rOWLZ6ZboIEdM2b7Y7GVs4pPacCgAq1kmxSz@vger.kernel.org
X-Gm-Message-State: AOJu0YwtI1JAem/al1Inbg/jCZGvZaTOi0dg1cHVU4H45Kpa1em8BB6v
	bsOIj5l5K8D+wymayktLMFZBnaIvj2yYp15g7f1VGgtlXNHnLar8I2Ym3jsnzvGs
X-Gm-Gg: AR+sD133zld+B605VjRFo8Z7Yy8I0s8se5jL1Ok2q8kZ5jmk86cSnJLY1guVlfKjTEA
	17p+LMTloMq8uAieD9+W62JrYxh9xuzsn6nLmsotGO8eHvYV2TLIzGiNVP894Ak9QorPR5poK51
	9g+BNQlF2h5J8bfmL95DkgN4THaBAj2GHt3CaY4gLaEXpDNBOXGhZ2Pmpg+O2S8sLDXV3mJZFGb
	GfAcJS8/k9qEyoZsHJ2nnr0LLDRcWgST4I3mDIr/T9a5MZ6qCqkkMeB8SfeCjoYOjLdpvcRaLoN
	2/XVNVa3ZWDoWqbyuI+fZWljpIjO/1AZc5plpQxtELEgXOsRpXESOa3NGEINJehvz7YyVNVaaXQ
	NJ3B2Axyx8J35uqzIYWmcfGDpbE4+GjXXdIH2Ps9kMmIuHaG0Mgk6/93XfDzKngH368+AHuoH4H
	7mgLiRLIkp22VkPi1VaPvg7gCtDMw5ZyV2FVwskoRb/Uh1Zp41Uql+LqCgZ4rliC5rTYIL4HWD0
	Kc0XjA3RyIHSF6jFTpvgczbk8AzmHlfu+xSiP6BRTcm8WpgPisWj70m0XlrgpZaiPJNnZWEqfBe
	A3Ec4upk+5CHm23fmcsZblUWslo=
X-Received: by 2002:a05:600c:a47:b0:495:6e68:5df2 with SMTP id 5b1f17b1804b1-4994e7c0c62mr13336035e9.12.1785880672027;
        Tue, 04 Aug 2026 14:57:52 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e04269bsm34377685e9.13.2026.08.04.14.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 14:57:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Aug 2026 23:57:51 +0200
Message-Id: <DKGHV2DO6UTZ.PUD7JEAASRBR@gmail.com>
Cc: <bpf@vger.kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, "Tejun Heo" <tj@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>
Subject: Re: [PATCH dwarves] btf_encoder: Infer arena kfunc arguments from
 suffixes
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Alan Maguire" <alan.maguire@oracle.com>,
 "Arnaldo Carvalho de Melo" <acme@kernel.org>, <dwarves@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260803125518.2279340-1-memxor@gmail.com>
 <4cb8bb30-1f01-4b78-a6b1-4ade3b965039@linux.dev>
 <DKGENYO9FITK.1M51V4BULBSYT@gmail.com>
 <8dc173dc3d051d338916c72cae070238718fd196.camel@gmail.com>
 <6c9500d4-7401-44f0-93a6-88a827026ae0@linux.dev>
 <4d20aecf677f4aec3e8e70106d4bdbcb01902e69.camel@gmail.com>
 <DKGHMNV38DFI.1RZJ281XECD14@gmail.com>
 <56590122d4901653aa2827088b9a83447ee745e0.camel@gmail.com>
In-Reply-To: <56590122d4901653aa2827088b9a83447ee745e0.camel@gmail.com>

On Tue Aug 4, 2026 at 11:51 PM CEST, Eduard Zingerman wrote:
> On Tue, 2026-08-04 at 23:46 +0200, Kumar Kartikeya Dwivedi wrote:
>> On Tue Aug 4, 2026 at 11:34 PM CEST, Eduard Zingerman wrote:
>> > On Tue, 2026-08-04 at 14:19 -0700, Ihor Solodrai wrote:
>> > > On 8/4/26 1:22 PM, Eduard Zingerman wrote:
>> > > > On Tue, 2026-08-04 at 21:27 +0200, Kumar Kartikeya Dwivedi wrote:
>> > > > > On Tue Aug 4, 2026 at 8:43 PM CEST, Ihor Solodrai wrote:
>> > > > > > On 8/3/26 5:55 AM, Kumar Kartikeya Dwivedi wrote:
>> > > > > > > [...]
>> > > > >
>> > > > > >
>> > > > > > So while I understand the reluctance to add KF_ARENA_ARG3..N, =
I don't
>> > > > > > think we want to introduce and support yet another mechanism f=
or arena
>> > > > > > argument annotations. If we do, we'll be stuck with a mess of
>> > > > > > supporting two/three ways of doing the same thing for the fore=
seeable future.
>> > > > >
>> > > > > I think one major difference is that KF_ARENA_ARG* things were m=
ostly for
>> > > > > annotating the vmlinux.h with the right address space label befo=
re, but didn't
>> > > > > carry any semantic meaning for the kfunc's type checks.
>> > > > >
>> > > > > That changes with these suffixes though. The pointer will be tra=
nslated when
>> > > > > passed into the kfunc. IMO it would be odd to diverge for this p=
articular case,
>> > > > > since we use suffixes for every other case where we constrain th=
e input type of
>> > > > > the kfunc argument or give it special meaning.
>> > > > >
>> > > > > We also want to have similar annotation on struct_ops callbacks,=
 where we also
>> > > > > use suffixes, so it seemed better to keep it consistent.
>> > > >
>> > > > I agree that we should follow the principle of least surprise here=
 and
>> > > > use suffixes, as everything else uses suffixes as well.
>> > >
>> > > Ok, I understand the motivation. Let's say we use the suffixes.
>> > >
>> > > Should this enable getting rid of KF_ARENA* flags then? For the
>> > > purposes of generating address_space(1), we can also just check the
>> > > name suffix, no?
>> >
>> > That would be ideal, yes.
>> >
>> > > >
>> > > > And yes, the __arena and KF_ARENA_ARG* annotations have different
>> > > > semantics:
>> > > > - __arena means that user space arena address is passed as is
>> > > > - KF_ARENA_ARG* means that a user space address is converted
>> > > > =C2=A0 to a kernel space address before passing.
>> > >
>> > > Also I am a little confused about whether we *need* to be able to
>> > > express two distinct meanings of "arena pointer" or not?
>> > >
>> > > My understanding is that "arena pointer" is a feature of an arg type
>> > > that has a single meaning: the pointer has one base in BPF world, an=
d
>> > > a different base when executed in the kernel.
>> > >
>> > > The things that are missing is auto-conversion (Tejun's RFC [1]) and=
 more
>> > > comprehensive support of PTR_TO_ARENA in the verifier.
>> > >
>> > > This is still only one "arena" annotation per arg. Do we actually ne=
ed
>> > > the proliferation of __arena, __arena__nullable and/or __arena_kern,
>> > > __arena_user? Can't we have a single defined semantics of how arena
>> > > pointers are supposed to work?
>> > >
>> > > I can imagine something like follows:
>> > > =C2=A0 * arena pointers can not be null, check for nulls
>> > > =C2=A0=C2=A0=C2=A0 before passing from BPF prog to the kernel
>> >
>> > We are deliberately lax when handling arena and don't do any kind of
>> > value tracking there. So e.g. the following won't work:
>> >
>> > =C2=A0 if (foo->ptr) {
>> > =C2=A0=C2=A0=C2=A0 ...
>> > =C2=A0=C2=A0=C2=A0 kfunc(foo->ptr);
>> > =C2=A0 }
>> >
>> > Unless compiler decides to keep foo->ptr in a register. I'm not sure
>> > whether enforcing non-null here from the verifier side is the right
>> > call.
>> >
>> > > =C2=A0 * arena pointers are converted to the kernel space for
>> > > =C2=A0=C2=A0=C2=A0 kfunc/struct_ops callback by the verifier
>> > >
>> > > With the documented and enforced semantics like this one way of
>> > > annotating and one annotation should be enough.
>> > >
>> > > What am I missing?
>> >
>> > At the moment we have two consumers:
>> > - Planned sched_ext related kfuncs that need kernel space pointers.
>> > - Existing kfuncs with KF_ARENA_ARG:
>> > =C2=A0 - bpf_arena_alloc_pages
>> > =C2=A0 - bpf_arena_free_pages
>> > =C2=A0 - bpf_arena_reserve_pages
>> > =C2=A0 They, take a user space address. Looking at the code is appears=
 that
>> > =C2=A0 all three can be changed to handle kernel space address.
>> > =C2=A0 On the other hand, neither of these *needs* the passed pointer =
to be
>> > =C2=A0 converted to a kernel side arena pointer. So that would be just=
 some
>> > =C2=A0 useless work.
>>
>> I don't think it's useless work, they translate manually because the act=
ual page
>> table operations happen using the kernel address anyway. IMO they probab=
ly need
>> access to both, and having one gives other, but kaddr is more important =
for them
>> to actually carry out the page table manipulation.
>
> From what I see these function compute the page number by subtracting
> user vm start from the pointer. So, if switched to a kernel pointer
> that would uaddr -> kaddr -> (kaddr - start) / page_size.
> Compared to current (uaddr - ustart) / page_size.
> But we can live with that.
>
> What's an overall conclusion? A single __arena suffix and modified
> existing consumers? What would be the semantics for __nullable?

It would just signify expectations for kernel consumers, but we shouldn't b=
e
enforcing it in the verifier, since we'll inevitably have to track the stat=
e of
the arena pointer, which we shouldn't do.

It just degrades to pointer to first page when you break the expectation, w=
hich
should be reported as a fault through the BPF stream for the program (or ab=
orts
the program on fault, if that ever materializes in the future).
