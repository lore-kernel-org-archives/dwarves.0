Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1263E46DFE7
	for <dwarves@vger.kernel.org>; Tue,  4 Aug 2026 20:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785874949; cv=none; b=OPG0HCcW/vvvtvr+hwFBplKeOZtgdtrcUquXMxoA6RLXTJRQ/mRr6mfsC3NKKHqRwifTf/yP6CQXkSXurlrVnJ3ZStCzySytcnikmJ5zdEDY79waOoUbTUsH7dpii6Mbnt7ZMulRmhw7KrPAWkBrzOANVfJGnVhZxP5dWEs8dL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785874949; c=relaxed/simple;
	bh=NpDg81ImNnGRaw7mFsLEQ88n5IRxKun1SR+hSX5sGuI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=beCIi2uyNDNWsEfUkoRJD0LoBN+BcuI6+GZWxn/fvU1yabR9ksF7fNBKzfJanloes/B4Y7l2rEZ1fXKZAaeycwGJlnsIslaGN8awL8qmqBjs50ZRmMnlSZV+G6jfYgdyAT39LVZ5HL1EVTVp64RG0o6LDbV0XfD3Kbz6+HGessY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JjxaSAw7; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjxaSAw7"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-ca957432c7fso171183a12.1
        for <dwarves@vger.kernel.org>; Tue, 04 Aug 2026 13:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785874929; x=1786479729; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7ftS2LMAcBlBW1ItZDSSZ+b7js/jMGHHGF4CgsMVjVY=;
        b=JjxaSAw7PsVmE0tlX2MPpp1Vr3mgQep6eE/CAL+s3nCmEKW7xQuCCSjBf9aoVihH5B
         3Z6eZxEYcr1C0Z5uTXphCrVsSycDM4Yy1KW0zUFHxrzuw7IpLi2WPlvmB0KwwfwyQPhG
         2zX82eJivubcD5V4KFD+aY+HaxnnnLRh2gfwPGCATPPD6wgdsw52KFvkZNGpjnpwk6oz
         WP0Q1x2M5m8LDuQ38g3NBfCVuhGbfi0gO9dHNs59fGyTIsgBA5wJMjau+dByS6QlqhaR
         HzWCmmuQ0GpeRzAKnwAwvS2aTDDq3udBvf5t+Qy6itdLZp7kJRvfivPygyJn5xgxkslu
         3dLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785874929; x=1786479729;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7ftS2LMAcBlBW1ItZDSSZ+b7js/jMGHHGF4CgsMVjVY=;
        b=emJmHnBA52F6UMWoIbXFtpb2J2a4yzG+C/o2I1U0ud+OftXRrQ/nU/tJ1v3j7lFxZ8
         pNgsoai9OJaPkqUAUYmWIQQ9IFHefNE6px/aTB/w69NvFmdXsUt+OojkBkpj97jVmicP
         40gwOlWf04R9IvrzPUX5rusYTgPyys2LshNT3GJClA2f0lVcEY9sMa44lhpaAnLbFiY2
         Wu5s4RYE2711wMn7aL82QEilYt5G5CE8tZm12qdpIvE18VIkiYvs9pOud2qicfutckMY
         YP0MGUNqxTQnf38oG0tT9vJ7n5lDuFaep3Iky+ai8Wq8JEGntcsXlwnooSPKdPsqkE7z
         ZoHw==
X-Forwarded-Encrypted: i=1; AHgh+RpH3ds/tQ3WPQHr7/DS2RLsHLAeo3Xuk6J3XoqG7ZjZLXI5czqzdol2uaDX5RepwkzlAV3G0PKK@vger.kernel.org
X-Gm-Message-State: AOJu0YxxbBE8yPyaZ3D91dT4HxBYINnr/uu+ZW1Gx58JsUuF2bbZceE7
	8xTF+33Id4Qi7obczhWtJsK3t6arVkKeFXFh1aLBYn5mPuhmd2M2sP6q
X-Gm-Gg: AR+sD122F6jQoi4imNA7yUX4PFhAkQb4q2SqB1+pCJhYFaUfwa73TJL0Z7MT2zt6KzR
	t80dafZAl8Iqd0Cq80wnPmU1NEMOxGRZQf1/kr1HUfj4oq+LSN2xFDvWaLqpVW2TTMKl/c6utMj
	BkOvuhVNvRAfNL2kWDHWSzekzPy8f7GX+6DYdaN/iIevogipbFCCjyvl050bI/nnFSu9TxXSI1V
	f5BsMnviE7VXyO5gnq0Afw9Oc92pUOrsLqczW+x7z3ZyuKalhLKhbDt/FXV9mqneU1yXjJQZVza
	WCW8Rth8a0mgx6ZGoIzdXdyUvu1EB2+LM3lopjS8AyiJQ4gzoz6S4lrkiUi34np8l9ecCu4DZs2
	vMRLogxA+36KhuGQ2ocwK2dX3gel5xZI6KYQXaGHBPDJe2tp+YAugFi3C0fGcyVn7yp2Gy7D1cZ
	CQxy98PbN2SPrm0iO7qSbGZUVi98XFLFO4MRGo2m5ZIXSuuSS1xJ8XdQsBy6huF68UHecrOFOfg
	jH1IUCFuojZDkbN
X-Received: by 2002:a05:6a00:2d8b:b0:848:2d1d:836f with SMTP id d2e1a72fcca58-84f2e017a86mr1173106b3a.28.1785874928530;
        Tue, 04 Aug 2026 13:22:08 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f2e2c3e6esm256446b3a.9.2026.08.04.13.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 13:22:08 -0700 (PDT)
Message-ID: <8dc173dc3d051d338916c72cae070238718fd196.camel@gmail.com>
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
Date: Tue, 04 Aug 2026 13:22:04 -0700
In-Reply-To: <DKGENYO9FITK.1M51V4BULBSYT@gmail.com>
References: <20260803125518.2279340-1-memxor@gmail.com>
	 <4cb8bb30-1f01-4b78-a6b1-4ade3b965039@linux.dev>
	 <DKGENYO9FITK.1M51V4BULBSYT@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-08-04 at 21:27 +0200, Kumar Kartikeya Dwivedi wrote:
> On Tue Aug 4, 2026 at 8:43 PM CEST, Ihor Solodrai wrote:
> > On 8/3/26 5:55 AM, Kumar Kartikeya Dwivedi wrote:
> > > The kernel verifier recognizes __arena and __arena_nullable parameter
> > > suffixes for registered kfuncs. These arguments need the matching
> > > address_space(1) BTF type attribute so bpftool emits usable declarati=
ons.
> >=20
> > Hi Kartikeya,
> >=20
> > +cc: Emil, Tejun
> >=20
> > This patch is certainly a no-go, because of the ongoing effort to move
> > decl/type tag BTF generation from pahole to resolve_btfids [1][2]. I'm
> > going to send the last unlanded bits of that soon.
> >=20
> > *If* we decide to make this change, it shouldn't be done in pahole.
> >=20
>=20
> Ah, I was unaware. Once you share those changes I'd be happy to rework th=
is
> support for resolve_btfids instead (i.e., tack it wherever we do
> KF_ARENA_ARGS<N> handling right now).
>=20
> > But even setting that aside:
> >=20
> > > The kernel verifier recognizes __arena and __arena_nullable
> > > parameter suffixes for registered kfuncs.
> >=20
> > This is not true. The only way the kernel can recognize an arena
> > argument is via one of the three kfunc flags: KF_ARENA_RET,
> > KF_ARENA_ARG1 and KF_ARENA_ARG2. No __arena suffix support exist:
> >=20
> > =C2=A0 $ git log --oneline -n1
> > =C2=A0 7f333f85f83d (HEAD -> bpf-next, origin/for-next, origin/bpf-next=
, bpf-next/master, bpf-next/for-next, bpf-next/HEAD) Merge branch 'bpf-inva=
lidate-rcu-pointers-after-final-spin-unlock'
> > =C2=A0 $ grep -r --include=3D"*.[ch]" __arena=C2=A0 kernel/bpf/
> > =C2=A0=C2=A0=C2=A0 # ...nothing
> >=20
>=20
> Yeah, I worded it poorly, I meant it was supposed to gain support for tho=
se
> soon^TM, by way of the series here:
> https://lore.kernel.org/bpf/20260803125115.2264733-1-memxor@gmail.com
>=20
> > __arena symbol is only used in sched_ext, libarena and selftests code
> > as an alias to __atrribute__((address_space(1))) or a type tag:
> >=20
> > =C2=A0 $ grep -r --include=3D"*.[ch]" 'define __arena '
> > =C2=A0 tools/sched_ext/include/scx/bpf_arena_common.bpf.h:#define __are=
na __attribute__((address_space(1)))
> > =C2=A0 tools/testing/selftests/bpf/libarena/include/bpf_arena_common.h:=
#define __arena __attribute__((address_space(1))) __attribute__((btf_type_t=
ag("arena")))
> > =C2=A0 tools/testing/selftests/bpf/libarena/include/bpf_arena_common.h:=
#define __arena __attribute__((btf_type_tag("arena")))
> >=20
> > AFAIR prior discussions that led to KF_ARENA_* flags implementation,
> > we decided to *not* add an __arena arg suffix support. We were talking
> > about getting rid of this suffix-annotation mechanism completely.
> >=20
> > What we want long term is proper decl/type tags support from
> > compilers, so that in the kernel we could have and use:
> >=20
> > =C2=A0 #define __arena __attribute__((btf_type_tag("arena")))
> >=20
> > At the time KF_ARENA_* flags were introduced, this wasn't feasible
> > because GCC compiler didn't support the tags. I think it does since
> > recently, but even so we'll have to support older compiler builds for
> > quite a while.
>=20
> I wasn't involved in the discussion for choosing the flag, so I do not re=
member
> the nuance involved in making the choices back then. But please correct m=
e or
> provide context in case I do not capture something accurately below.
>=20
> >=20
> > So while I understand the reluctance to add KF_ARENA_ARG3..N, I don't
> > think we want to introduce and support yet another mechanism for arena
> > argument annotations. If we do, we'll be stuck with a mess of
> > supporting two/three ways of doing the same thing for the foreseeable f=
uture.
>=20
> I think one major difference is that KF_ARENA_ARG* things were mostly for
> annotating the vmlinux.h with the right address space label before, but d=
idn't
> carry any semantic meaning for the kfunc's type checks.
>=20
> That changes with these suffixes though. The pointer will be translated w=
hen
> passed into the kfunc. IMO it would be odd to diverge for this particular=
 case,
> since we use suffixes for every other case where we constrain the input t=
ype of
> the kfunc argument or give it special meaning.
>=20
> We also want to have similar annotation on struct_ops callbacks, where we=
 also
> use suffixes, so it seemed better to keep it consistent.

I agree that we should follow the principle of least surprise here and
use suffixes, as everything else uses suffixes as well.

And yes, the __arena and KF_ARENA_ARG* annotations have different
semantics:
- __arena means that user space arena address is passed as is
- KF_ARENA_ARG* means that a user space address is converted
  to a kernel space address before passing.

It appears, though, that from the BPF program side having an address
space annotation on the kfunc parameter would be helpful, as it avoids
an additional cast.

Tbh, it sounds like we want __arena_user and __arena_kern suffixes.

> I agree that all of these should be using type tags, but we're not there =
yet.

Let's put aside the type tags discussion for the time being.

...
