Received: from mail-wm2-f4.google.com (mail-wm2-f4.google.com [74.125.225.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D01342AF99
	for <dwarves@vger.kernel.org>; Tue,  4 Aug 2026 21:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785880017; cv=none; b=ZBWs3Gz8yg6RyqBAMaco8XIaelZL9o0XvhseskQD9xInAT//YPjdap1VpwcfqdwopsjpiXTYZFz/LI6f/XtajiDRQTyoVWQwzIDquROtZT+dAXCzImcDTjdK2cb7vhbKy1AUULQ80aN+DaKQvqEWlHCrWldPeRbIZFuqyF0F9ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785880017; c=relaxed/simple;
	bh=TFzYjcQ7cXWKf52aEKHbaRDrsz4SD9u9cG16spEct9E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hPC3txKqeeX2zvoRQnRbQkz0Tn6oxfWB64p7KfrLjh41rsafqRsDu9UDz/dZLBPCTAAoOkSDTWZEH70fLBbPGGg54ppHaMzwd2OdSsjbNwwTQKGnah4qnvP1Etigrh1yASUkKnHI9NvziIizdlLfTBVJPReNw2u6k1bFfzFoE3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+b+rE/Q; arc=none smtp.client-ip=74.125.225.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+b+rE/Q"
Received: by mail-wm2-f4.google.com with SMTP id 5b1f17b1804b1-4955f00e593so702975e9.0
        for <dwarves@vger.kernel.org>; Tue, 04 Aug 2026 14:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785880014; x=1786484814; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/HCxSPKGFa03XR0faEHZWkLShPx83eFqGMtoyP3gJeA=;
        b=g+b+rE/QeZXzeYubgdIew3TnI8JFpWH6KZVwT5F24JfG/ljtQeR/MuiftEcP5y707q
         HbkW6/hEbq+kQNaAlyXkX1vAaz2I1+ldoZmioMHYoNW2gsTdfw4K0vjmSE9UW6lV4ItT
         TQlEt/AE7WNThlOebDZdbYCDTSrYdfFLj++3EiaQhlEEHnkhUHRkyMBeMGzbNdvl64nP
         L87yO/yuRG0iy4sT8ZY85qGf1/aJ4VTyu4qNH8enF9z5EF6+WjQINYWuOsWPSxANcZP/
         utljLz+6HE8PiYiFFxqjpOKMNm49fWpAQGPzKZ1otvD01PH5FDkF+p+/gKUtXn5TTIIf
         QrMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785880014; x=1786484814;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/HCxSPKGFa03XR0faEHZWkLShPx83eFqGMtoyP3gJeA=;
        b=ZOD05abUjGX3HtNcGblQNRu/sXnsL51Q68cAQSw/dvNPwciklkP7zK0PkeXtdS0hLh
         VZbeeZvquyxDVy8gLeon+cOcEFmFHp6+7ymu1p0LBEdJZR5qBx1ZKCrVL6kl4NedpBC/
         xpQoVqVqmsXslLGIGmLTx6LBUkxUc+DGv23qdCvmFxaYpyu9j/IWEqS2Ta2GkiQIxMki
         b1u2fqTM2t9a2NT1x1DxFeTqDOtK1ktHFwbkNqED7vpamd+/kNsVxp8pYYGbi9oEawc8
         I78ttYryOzlBbCiiqETRdHe7kwDDJ1Lp8NxxtDle+7nlf1W3nA6wUS2JSFaZ3rVUlCAp
         93pQ==
X-Forwarded-Encrypted: i=1; AHgh+RowJNBtJVuJR8hktBZI+0VG62LP1h/kOwt3sL9M7o57U5GJ48ncaCnSTWb73Kqg+BApZf/H90br@vger.kernel.org
X-Gm-Message-State: AOJu0Ywur7tKWa8HaWFl7LbVOgDWPvQj2wd6NWVqrWbF4JkrHISw/e+3
	Zh946/j9RomonkW1T0yXimxP9DjQMncOy0vLVXeygMTizFP6DyOe1FMf
X-Gm-Gg: AR+sD11gusEFmu0D0Yig/rHl4iy+zBhTLpFPQaClz0slvwq0/B2DmhKb+vD2VbcM1iB
	Iwc+f82mxoNWAgfvFIDULA9sZcrs4FsNxGRvcAQO1PWZ6GSudn+ejn7BUnTTD3dqBJgzTdb9u6D
	ttdF431g51f31hjhYRqY2gqSAhhDo0O0Tmrv7Ig1Ci4zKp93tSKmZ1hMKkOIyWYkBmXeI+DWyi1
	LDYuYg53cYtCPeO/PJsyfNhY9mmyXAvxGeCu7BcLsAJwYwGkRnPy5MBwWp75YrBSyw3bcpIRVgr
	JNpKccuYXkWOQtkHB4LFhVeOwsUptWeWcOmYhRuhbjfGORx3WmfYtsX+aEKJhEBcXJ01WuNitHv
	XQ1fNd4HJEkSqvPlCaA4eRZSV3OKmgthWABtZlVvls52pw6ziXNNOQnmH4vHpr4jnzvJDl1VT/A
	UhsjC2vjlUSJ07bEIQcngxbEGpK7FtRUB8kn4uFLx33CFjoSkdGef6FARsSbGkMaPjsfXoFVeP2
	TXYt2WvurKvX5pPukTm3Nqg0ZZqCvDIqb42BVn04tK2/iVaFcKaKXXk+6pXnF0X5bDAFjNlAfXu
	gG4NYbiX3+sDPL7Ppj6Pnc7RTek=
X-Received: by 2002:a05:600c:620e:b0:495:6274:56c2 with SMTP id 5b1f17b1804b1-4994e70a6f5mr19571105e9.2.1785880013603;
        Tue, 04 Aug 2026 14:46:53 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994dfe64e0sm34458565e9.6.2026.08.04.14.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 14:46:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Aug 2026 23:46:52 +0200
Message-Id: <DKGHMNV38DFI.1RZJ281XECD14@gmail.com>
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
In-Reply-To: <4d20aecf677f4aec3e8e70106d4bdbcb01902e69.camel@gmail.com>

On Tue Aug 4, 2026 at 11:34 PM CEST, Eduard Zingerman wrote:
> On Tue, 2026-08-04 at 14:19 -0700, Ihor Solodrai wrote:
>> On 8/4/26 1:22 PM, Eduard Zingerman wrote:
>> > On Tue, 2026-08-04 at 21:27 +0200, Kumar Kartikeya Dwivedi wrote:
>> > > On Tue Aug 4, 2026 at 8:43 PM CEST, Ihor Solodrai wrote:
>> > > > On 8/3/26 5:55 AM, Kumar Kartikeya Dwivedi wrote:
>> > > > > [...]
>> > >
>> > > >
>> > > > So while I understand the reluctance to add KF_ARENA_ARG3..N, I do=
n't
>> > > > think we want to introduce and support yet another mechanism for a=
rena
>> > > > argument annotations. If we do, we'll be stuck with a mess of
>> > > > supporting two/three ways of doing the same thing for the foreseea=
ble future.
>> > >
>> > > I think one major difference is that KF_ARENA_ARG* things were mostl=
y for
>> > > annotating the vmlinux.h with the right address space label before, =
but didn't
>> > > carry any semantic meaning for the kfunc's type checks.
>> > >
>> > > That changes with these suffixes though. The pointer will be transla=
ted when
>> > > passed into the kfunc. IMO it would be odd to diverge for this parti=
cular case,
>> > > since we use suffixes for every other case where we constrain the in=
put type of
>> > > the kfunc argument or give it special meaning.
>> > >
>> > > We also want to have similar annotation on struct_ops callbacks, whe=
re we also
>> > > use suffixes, so it seemed better to keep it consistent.
>> >
>> > I agree that we should follow the principle of least surprise here and
>> > use suffixes, as everything else uses suffixes as well.
>>
>> Ok, I understand the motivation. Let's say we use the suffixes.
>>
>> Should this enable getting rid of KF_ARENA* flags then? For the
>> purposes of generating address_space(1), we can also just check the
>> name suffix, no?
>
> That would be ideal, yes.
>
>> >
>> > And yes, the __arena and KF_ARENA_ARG* annotations have different
>> > semantics:
>> > - __arena means that user space arena address is passed as is
>> > - KF_ARENA_ARG* means that a user space address is converted
>> > =C2=A0 to a kernel space address before passing.
>>
>> Also I am a little confused about whether we *need* to be able to
>> express two distinct meanings of "arena pointer" or not?
>>
>> My understanding is that "arena pointer" is a feature of an arg type
>> that has a single meaning: the pointer has one base in BPF world, and
>> a different base when executed in the kernel.
>>
>> The things that are missing is auto-conversion (Tejun's RFC [1]) and mor=
e
>> comprehensive support of PTR_TO_ARENA in the verifier.
>>
>> This is still only one "arena" annotation per arg. Do we actually need
>> the proliferation of __arena, __arena__nullable and/or __arena_kern,
>> __arena_user? Can't we have a single defined semantics of how arena
>> pointers are supposed to work?
>>
>> I can imagine something like follows:
>> =C2=A0 * arena pointers can not be null, check for nulls
>> =C2=A0=C2=A0=C2=A0 before passing from BPF prog to the kernel
>
> We are deliberately lax when handling arena and don't do any kind of
> value tracking there. So e.g. the following won't work:
>
>   if (foo->ptr) {
>     ...
>     kfunc(foo->ptr);
>   }
>
> Unless compiler decides to keep foo->ptr in a register. I'm not sure
> whether enforcing non-null here from the verifier side is the right
> call.
>
>> =C2=A0 * arena pointers are converted to the kernel space for
>> =C2=A0=C2=A0=C2=A0 kfunc/struct_ops callback by the verifier
>>
>> With the documented and enforced semantics like this one way of
>> annotating and one annotation should be enough.
>>
>> What am I missing?
>
> At the moment we have two consumers:
> - Planned sched_ext related kfuncs that need kernel space pointers.
> - Existing kfuncs with KF_ARENA_ARG:
>   - bpf_arena_alloc_pages
>   - bpf_arena_free_pages
>   - bpf_arena_reserve_pages
>   They, take a user space address. Looking at the code is appears that
>   all three can be changed to handle kernel space address.
>   On the other hand, neither of these *needs* the passed pointer to be
>   converted to a kernel side arena pointer. So that would be just some
>   useless work.

I don't think it's useless work, they translate manually because the actual=
 page
table operations happen using the kernel address anyway. IMO they probably =
need
access to both, and having one gives other, but kaddr is more important for=
 them
to actually carry out the page table manipulation.

>
> So there are two valid use cases.
>
> ...

