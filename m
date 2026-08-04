Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D19380FF2
	for <dwarves@vger.kernel.org>; Tue,  4 Aug 2026 21:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785880315; cv=none; b=n/WpAg8s7GhFlgZzIRnFNQKlrTQtWV29gxny79R65zfseuW3MLQ3RxwvXIORxAJOB07qF685XuZpiWrTIHnmJdyEHlw24bpaeSPawjWZwq7J+MGkNEh5KDat7ZjA3N2A/CGv50snVgilb63KsjFQMMBUxH7P2bRYrCWfIzyxSLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785880315; c=relaxed/simple;
	bh=eEz0p+0rDpZate0GNVf+mjAlx42CeMUtDSYkur5UQdI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nZQriBh9EwNTGKoPyMiwI0sEZStMS5tmV2b0iclpZd6Fw9NXuF99fxGaRCG5wxXK5EPXzJjYWA/cZKY2et/gBC8pOomnxC0DB+PZ533e9r83qhp5LEVLRIrplPO1BDRgAHXHQtQnb0UIW9YjJ8q9n4KYcbPS9Aoez+UPgY/9UJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LwpQIYTL; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwpQIYTL"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso350230a91.1
        for <dwarves@vger.kernel.org>; Tue, 04 Aug 2026 14:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785880313; x=1786485113; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=eEz0p+0rDpZate0GNVf+mjAlx42CeMUtDSYkur5UQdI=;
        b=LwpQIYTLKmETteRef2C4aLRNDYs33WwzxD8GkmjcMFZmHU4wq7DQSlZB6pCZ4cw8Z6
         tkjUYO3G/HjFfrYDeS8oorRvyaIZBYQQU0c01Hn8UjxBHTsgEfY1WAVykjgLWb7PFFce
         tNzRtUElXwvbn9+6lOf8SPQdiZHJ+HZoxIn2PXytqiRU9ncwwzPEsvNaPG04YGKzbITw
         H2bE+M9p9Oyldjj2A30noV8fY5oXSqwjy0C5/jmM9MVHiXDrtrG+VWnOZaqrK9tZbJp9
         oiX0An5LyLULNIrmDCyUAEVXN/VWhExJD19n2df45vC2ofbulMr4q3aMfdoKpXLyo3ub
         7RQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785880313; x=1786485113;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eEz0p+0rDpZate0GNVf+mjAlx42CeMUtDSYkur5UQdI=;
        b=HfxE+Rl5+5weM1Xkgix7mI2LI6JRca6CfnNGWWuw0PYaeFU15r6/12NsuU+DzGTyfD
         Sm/C0waEjDqG6CRSYK6BtA8Dso2A4+5d3pJXSbi9cQ7urgfqe1GmWROCmppufpSWa5/o
         osubeAoMMkh5KBqB8EeJJR1/NRLugc2NwDtwMPc/acbgm+80iCXWqzS7psi7fmwXGU8Y
         Bz3eeQY6QUwQeCetYTGg0ucurk1JxYGvNgiaZEtg5TO/JbS5jAFdeZJsQKj/mX497RS+
         IsoHimlFlJ7xZvFo8VHBPh3HBosU5XzAYEdwqODs7QNvFYF1cHIETmp7RQIUcswMPNac
         fGTw==
X-Forwarded-Encrypted: i=1; AHgh+RqHe2MpSQqjLZWbf/N1eLte9u/4uDGFf85YK2vA8caRDM5dV7yRa9ANZwJUhNP8P/YobY1qAjJ6@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6KrV0hLZc2rcfOF4GK5LZ4aTrOQ0CNUMBGv5trmsJAsSPuvhG
	kScFC0ukQgVIo7X8ix5wmnhIqNSm0f1DpL6HDI5xHeQYPxrbiHqwhkiGp+Ezng==
X-Gm-Gg: AR+sD12EJBoWfPfgd2RPngR/gjfY4lWvWTW1Bb1FYS6MaG7TOlugA5/WIKJLZbWzGyy
	trFoswhlSbxLJgmpq+oQ40Mt8Q6RndMkwsTGQ4z9VuFpaMMFalx1464nyLxzj5rZnFqqEd6VW3p
	44Tw/FKzBfyDskabSr+VNGdq8DzZwDDvvCxRgNk5qI7bwuLQIqNhGYuQ3Z/oOHoYDzDvAUg1Ir1
	Z1Q9CeBGx/ppCtKZK6nQDf0qM4oj89WM6VP3ZfvX4sXryK2S3SFdMFki5BdirqWgAWwbfoX5yxz
	XpT4Owa/roMua1RDO+aATBwEJhTb5IitawlBZn9rsCQ4EloAKTkktbOCw30ljrB5cYlm68L5eVN
	7VniG/SjzGgRrOlm3HNNVpHxKglC/OpuIuYhnlQH34Z6/rZ6ICHdLe1sPuyKi08QEPUOcESYLzB
	1Wp6AQ42iqLcLq8Wqdgvt8bRn5A/TYSJMEB41Pz2bkpiWbNB9kf5OBjCiCokIpVxgmd7KgdYnMm
	+/hk2f6xP5DVuT5kcPHMTunqeI=
X-Received: by 2002:a17:90a:c107:b0:38e:6f90:eabd with SMTP id 98e67ed59e1d1-3903c53783cmr1921679a91.5.1785880313341;
        Tue, 04 Aug 2026 14:51:53 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39039179b07sm592007a91.5.2026.08.04.14.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 14:51:52 -0700 (PDT)
Message-ID: <56590122d4901653aa2827088b9a83447ee745e0.camel@gmail.com>
Subject: Re: [PATCH dwarves] btf_encoder: Infer arena kfunc arguments from
 suffixes
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Ihor Solodrai
	 <ihor.solodrai@linux.dev>, Alan Maguire <alan.maguire@oracle.com>, Arnaldo
 Carvalho de Melo
	 <acme@kernel.org>, dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Tejun Heo <tj@kernel.org>, Emil Tsalapatis
 <emil@etsalapatis.com>
Date: Tue, 04 Aug 2026 14:51:50 -0700
In-Reply-To: <DKGHMNV38DFI.1RZJ281XECD14@gmail.com>
References: <20260803125518.2279340-1-memxor@gmail.com>
	 <4cb8bb30-1f01-4b78-a6b1-4ade3b965039@linux.dev>
	 <DKGENYO9FITK.1M51V4BULBSYT@gmail.com>
	 <8dc173dc3d051d338916c72cae070238718fd196.camel@gmail.com>
	 <6c9500d4-7401-44f0-93a6-88a827026ae0@linux.dev>
	 <4d20aecf677f4aec3e8e70106d4bdbcb01902e69.camel@gmail.com>
	 <DKGHMNV38DFI.1RZJ281XECD14@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-08-04 at 23:46 +0200, Kumar Kartikeya Dwivedi wrote:
> On Tue Aug 4, 2026 at 11:34 PM CEST, Eduard Zingerman wrote:
> > On Tue, 2026-08-04 at 14:19 -0700, Ihor Solodrai wrote:
> > > On 8/4/26 1:22 PM, Eduard Zingerman wrote:
> > > > On Tue, 2026-08-04 at 21:27 +0200, Kumar Kartikeya Dwivedi wrote:
> > > > > On Tue Aug 4, 2026 at 8:43 PM CEST, Ihor Solodrai wrote:
> > > > > > On 8/3/26 5:55 AM, Kumar Kartikeya Dwivedi wrote:
> > > > > > > [...]
> > > > >=20
> > > > > >=20
> > > > > > So while I understand the reluctance to add KF_ARENA_ARG3..N, I=
 don't
> > > > > > think we want to introduce and support yet another mechanism fo=
r arena
> > > > > > argument annotations. If we do, we'll be stuck with a mess of
> > > > > > supporting two/three ways of doing the same thing for the fores=
eeable future.
> > > > >=20
> > > > > I think one major difference is that KF_ARENA_ARG* things were mo=
stly for
> > > > > annotating the vmlinux.h with the right address space label befor=
e, but didn't
> > > > > carry any semantic meaning for the kfunc's type checks.
> > > > >=20
> > > > > That changes with these suffixes though. The pointer will be tran=
slated when
> > > > > passed into the kfunc. IMO it would be odd to diverge for this pa=
rticular case,
> > > > > since we use suffixes for every other case where we constrain the=
 input type of
> > > > > the kfunc argument or give it special meaning.
> > > > >=20
> > > > > We also want to have similar annotation on struct_ops callbacks, =
where we also
> > > > > use suffixes, so it seemed better to keep it consistent.
> > > >=20
> > > > I agree that we should follow the principle of least surprise here =
and
> > > > use suffixes, as everything else uses suffixes as well.
> > >=20
> > > Ok, I understand the motivation. Let's say we use the suffixes.
> > >=20
> > > Should this enable getting rid of KF_ARENA* flags then? For the
> > > purposes of generating address_space(1), we can also just check the
> > > name suffix, no?
> >=20
> > That would be ideal, yes.
> >=20
> > > >=20
> > > > And yes, the __arena and KF_ARENA_ARG* annotations have different
> > > > semantics:
> > > > - __arena means that user space arena address is passed as is
> > > > - KF_ARENA_ARG* means that a user space address is converted
> > > > =C2=A0 to a kernel space address before passing.
> > >=20
> > > Also I am a little confused about whether we *need* to be able to
> > > express two distinct meanings of "arena pointer" or not?
> > >=20
> > > My understanding is that "arena pointer" is a feature of an arg type
> > > that has a single meaning: the pointer has one base in BPF world, and
> > > a different base when executed in the kernel.
> > >=20
> > > The things that are missing is auto-conversion (Tejun's RFC [1]) and =
more
> > > comprehensive support of PTR_TO_ARENA in the verifier.
> > >=20
> > > This is still only one "arena" annotation per arg. Do we actually nee=
d
> > > the proliferation of __arena, __arena__nullable and/or __arena_kern,
> > > __arena_user? Can't we have a single defined semantics of how arena
> > > pointers are supposed to work?
> > >=20
> > > I can imagine something like follows:
> > > =C2=A0 * arena pointers can not be null, check for nulls
> > > =C2=A0=C2=A0=C2=A0 before passing from BPF prog to the kernel
> >=20
> > We are deliberately lax when handling arena and don't do any kind of
> > value tracking there. So e.g. the following won't work:
> >=20
> > =C2=A0 if (foo->ptr) {
> > =C2=A0=C2=A0=C2=A0 ...
> > =C2=A0=C2=A0=C2=A0 kfunc(foo->ptr);
> > =C2=A0 }
> >=20
> > Unless compiler decides to keep foo->ptr in a register. I'm not sure
> > whether enforcing non-null here from the verifier side is the right
> > call.
> >=20
> > > =C2=A0 * arena pointers are converted to the kernel space for
> > > =C2=A0=C2=A0=C2=A0 kfunc/struct_ops callback by the verifier
> > >=20
> > > With the documented and enforced semantics like this one way of
> > > annotating and one annotation should be enough.
> > >=20
> > > What am I missing?
> >=20
> > At the moment we have two consumers:
> > - Planned sched_ext related kfuncs that need kernel space pointers.
> > - Existing kfuncs with KF_ARENA_ARG:
> > =C2=A0 - bpf_arena_alloc_pages
> > =C2=A0 - bpf_arena_free_pages
> > =C2=A0 - bpf_arena_reserve_pages
> > =C2=A0 They, take a user space address. Looking at the code is appears =
that
> > =C2=A0 all three can be changed to handle kernel space address.
> > =C2=A0 On the other hand, neither of these *needs* the passed pointer t=
o be
> > =C2=A0 converted to a kernel side arena pointer. So that would be just =
some
> > =C2=A0 useless work.
>=20
> I don't think it's useless work, they translate manually because the actu=
al page
> table operations happen using the kernel address anyway. IMO they probabl=
y need
> access to both, and having one gives other, but kaddr is more important f=
or them
> to actually carry out the page table manipulation.

From what I see these function compute the page number by subtracting
user vm start from the pointer. So, if switched to a kernel pointer
that would uaddr -> kaddr -> (kaddr - start) / page_size.
Compared to current (uaddr - ustart) / page_size.
But we can live with that.

What's an overall conclusion? A single __arena suffix and modified
existing consumers? What would be the semantics for __nullable?
