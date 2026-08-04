Received: from mail-wm2-f4.google.com (mail-wm2-f4.google.com [74.125.225.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35F245C70C
	for <dwarves@vger.kernel.org>; Tue,  4 Aug 2026 19:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785871657; cv=none; b=CdbFOmI7EGQ7j6d1p7fb4QiQQXGusPj/HaOtINujJvPGBTVyQShcQmo7AcpmHPxsN+fZ6lVg7SEElM8hU/+U5PO85sq5FO2eMnKR5FTzUmjRI3ocN/4ddhDCNqvNZSj+a7AXR5848svC8GLFHlIIj7TKtEcVmBENiNqKgQuG7cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785871657; c=relaxed/simple;
	bh=kP/NFjKV8Cd5NAae9bJMec0CGdAf8nbPHae8ZnR+AjI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=JW8LUatrxjj6CkLCKFHL1aZwT9+Yj6qFiBv1klAo4S0Zvn+c71Hz5Pl4C5mXhLv3QgyI7Jh4FD14CINpWVnn6ZCvcaerQzPYjWxFgHiU1uv3N+jvCwAJ567fZSR+Vx3HIoplM9V2PKcCjqQbwfpOiPK1EaOsoGnd2DWqf359B44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQG0gRPl; arc=none smtp.client-ip=74.125.225.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQG0gRPl"
Received: by mail-wm2-f4.google.com with SMTP id 5b1f17b1804b1-4955f00e593so456855e9.0
        for <dwarves@vger.kernel.org>; Tue, 04 Aug 2026 12:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785871652; x=1786476452; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zdgRwhw64WkzElAtZDWQ5xZZ48P/57q3QV1Kmcq/TBw=;
        b=mQG0gRPlf+bIzg5EbPoZTD6KcegY17nJky3lNLIN8yF+fbPvLQ3OEB6mdA+S8P0H31
         dyReyS8Ndpd3iEU1xQX/Bwdu7b6lpZBDYRkDryyQWq/pZcHq1QoVuk8WuixkKDMchFyE
         seJ6D5leqeRbnTkIapEhxwrQ7X0r2xuETNozJvPKgh4lTFuLL0k7JaFUrVpeccmPgTCB
         E6sFVYy8jbR/VDLA2el72ebFwYlTCBrn8zCRaXnbORyyGDg937pmIQzDIu/s0xPr+aKq
         9wiNc4liADyG4sbRzsK3K+rQ1cUlB5Hr2N2F9P9YwoUUnh/tPxaQ6XOc+ih8OFZiJ3+Z
         /v3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785871652; x=1786476452;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zdgRwhw64WkzElAtZDWQ5xZZ48P/57q3QV1Kmcq/TBw=;
        b=jBG4sKYIzhotWfoRod75IgjqkM+xqJPaYImI6s8V2S9COqneEWEoZLlaUhwM98pjZx
         cEQTDEsmkEXcGPEEOYbpD28tqMBZ+UP/cW/hAwmLv2/bERMJCyoL2x6HNfbWt1ohWej5
         KB8xHEeTyNLlf9LZSKVeeij0YruXvFzvLBP1YwpxQW/TLC7aRalGCQuYpCPRwBwwvrOc
         yGManB4Z3/m77xjtNAxcIU8fDIgjHwAzmGvl0mUKmWBNiloqjggGsndZk8HmRE18lfqR
         xKifGDXykBYbCGbOIA6WU8CMU/+8Bh9PVD9UmNnTLESz3SdJHvNS5ATzPpiMlgM0mddv
         kFcQ==
X-Forwarded-Encrypted: i=1; AHgh+RovNvT6nnUVaFnHVBqYr7moyipvL01lPQ5yYL4E+j9b1pVAPdvEv7v+0AGA8JEREdZH0S7wAfuK@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6TyKXnStsoPdYsAuqJbWxRLOM/OYT5DhxB3y0+VFI15nKDAPf
	WrIogS4EzqoH3Z/OdtaDZCegLCvabIDdBZhaFojZcvQSNaZJd+2M8GU3
X-Gm-Gg: AR+sD10T7xeOyTCeitYWX8a8yoI4KG2PalkttxCoHRcsWcBD3j8sAQKywAEzxYeMjY3
	fSm0rp0DimJVBtFn9GkkdbuemAuo3asJJvDnyrRCIBpT+7xElpH8FPoRrA4hca3yyA2+1LQnGZ/
	xIV8CWftjNbMBARk3iat5Sfp3t6+ba5zlAu64x82CnMAX+UoU763ygOTlaV+QFFrUnmHGipXYr/
	9UkrNKNUwzMLQOT+q/2hNfqlWSGyNWRyIa2ZW62Slm5b0EZt/4sUl0uz1AXP6Sudfc0giN7f9DG
	oOwgXm7NPdB/YH6XZimbTkwK8rygolHRMVyxvwpPUhEWU/Vd7IAPharnVCSw4kVgg5Z6++PIzPj
	sWai4uo/xUdZweKg0+g+cBfJiut+jbTI5mYpVvgIIv+KI6CLkFcG3iLVfncyj2cZkTnPtrII0DP
	YcKQAFvqn4oH+By64dmv6BNgD+8VHaxSeh/Frn8AT+7XyOpr3dPS8GxYpJxmHm8EHrOJJ9Gnt8f
	1DbFZ/HtjdzGe05Mm6JrN+AswuNSsLs0Tv9/MQPETzrATLlhWDH1rkb3PiMSRxiUqWsYGoYpu94
	6PS7+GTKjp3ph2FoDzVMCjmP0bo=
X-Received: by 2002:a05:600c:3ba6:b0:499:48be:3189 with SMTP id 5b1f17b1804b1-4994e6c065fmr9279825e9.0.1785871652324;
        Tue, 04 Aug 2026 12:27:32 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949fcb46esm133637285e9.5.2026.08.04.12.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 12:27:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Aug 2026 21:27:31 +0200
Message-Id: <DKGENYO9FITK.1M51V4BULBSYT@gmail.com>
Cc: <bpf@vger.kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Tejun Heo" <tj@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>
Subject: Re: [PATCH dwarves] btf_encoder: Infer arena kfunc arguments from
 suffixes
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Alan Maguire"
 <alan.maguire@oracle.com>, "Arnaldo Carvalho de Melo" <acme@kernel.org>,
 <dwarves@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260803125518.2279340-1-memxor@gmail.com>
 <4cb8bb30-1f01-4b78-a6b1-4ade3b965039@linux.dev>
In-Reply-To: <4cb8bb30-1f01-4b78-a6b1-4ade3b965039@linux.dev>

On Tue Aug 4, 2026 at 8:43 PM CEST, Ihor Solodrai wrote:
> On 8/3/26 5:55 AM, Kumar Kartikeya Dwivedi wrote:
>> The kernel verifier recognizes __arena and __arena_nullable parameter
>> suffixes for registered kfuncs. These arguments need the matching
>> address_space(1) BTF type attribute so bpftool emits usable declarations=
.
>
> Hi Kartikeya,
>
> +cc: Emil, Tejun
>
> This patch is certainly a no-go, because of the ongoing effort to move
> decl/type tag BTF generation from pahole to resolve_btfids [1][2]. I'm
> going to send the last unlanded bits of that soon.
>
> *If* we decide to make this change, it shouldn't be done in pahole.
>

Ah, I was unaware. Once you share those changes I'd be happy to rework this
support for resolve_btfids instead (i.e., tack it wherever we do
KF_ARENA_ARGS<N> handling right now).

> But even setting that aside:
>
>> The kernel verifier recognizes __arena and __arena_nullable
>> parameter suffixes for registered kfuncs.
>
> This is not true. The only way the kernel can recognize an arena
> argument is via one of the three kfunc flags: KF_ARENA_RET,
> KF_ARENA_ARG1 and KF_ARENA_ARG2. No __arena suffix support exist:
>
>   $ git log --oneline -n1
>   7f333f85f83d (HEAD -> bpf-next, origin/for-next, origin/bpf-next, bpf-n=
ext/master, bpf-next/for-next, bpf-next/HEAD) Merge branch 'bpf-invalidate-=
rcu-pointers-after-final-spin-unlock'
>   $ grep -r --include=3D"*.[ch]" __arena  kernel/bpf/
>     # ...nothing
>

Yeah, I worded it poorly, I meant it was supposed to gain support for those
soon^TM, by way of the series here:
https://lore.kernel.org/bpf/20260803125115.2264733-1-memxor@gmail.com

> __arena symbol is only used in sched_ext, libarena and selftests code
> as an alias to __atrribute__((address_space(1))) or a type tag:
>
>   $ grep -r --include=3D"*.[ch]" 'define __arena '
>   tools/sched_ext/include/scx/bpf_arena_common.bpf.h:#define __arena __at=
tribute__((address_space(1)))
>   tools/testing/selftests/bpf/libarena/include/bpf_arena_common.h:#define=
 __arena __attribute__((address_space(1))) __attribute__((btf_type_tag("are=
na")))
>   tools/testing/selftests/bpf/libarena/include/bpf_arena_common.h:#define=
 __arena __attribute__((btf_type_tag("arena")))
>
> AFAIR prior discussions that led to KF_ARENA_* flags implementation,
> we decided to *not* add an __arena arg suffix support. We were talking
> about getting rid of this suffix-annotation mechanism completely.
>
> What we want long term is proper decl/type tags support from
> compilers, so that in the kernel we could have and use:
>
>   #define __arena __attribute__((btf_type_tag("arena")))
>
> At the time KF_ARENA_* flags were introduced, this wasn't feasible
> because GCC compiler didn't support the tags. I think it does since
> recently, but even so we'll have to support older compiler builds for
> quite a while.

I wasn't involved in the discussion for choosing the flag, so I do not reme=
mber
the nuance involved in making the choices back then. But please correct me =
or
provide context in case I do not capture something accurately below.

>
> So while I understand the reluctance to add KF_ARENA_ARG3..N, I don't
> think we want to introduce and support yet another mechanism for arena
> argument annotations. If we do, we'll be stuck with a mess of
> supporting two/three ways of doing the same thing for the foreseeable fut=
ure.

I think one major difference is that KF_ARENA_ARG* things were mostly for
annotating the vmlinux.h with the right address space label before, but did=
n't
carry any semantic meaning for the kfunc's type checks.

That changes with these suffixes though. The pointer will be translated whe=
n
passed into the kfunc. IMO it would be odd to diverge for this particular c=
ase,
since we use suffixes for every other case where we constrain the input typ=
e of
the kfunc argument or give it special meaning.

We also want to have similar annotation on struct_ops callbacks, where we a=
lso
use suffixes, so it seemed better to keep it consistent.

I agree that all of these should be using type tags, but we're not there ye=
t.

It is on my list of things to explore whether we can convert existing users=
 of
KF_ARENA_ARG<N> flags (bpf_arena_alloc_pages(), etc.). We will have to modi=
fy
the implementation, and ensure we don't break compatibility by moving from
ignoring the type of input register to something we constrain to PTR_TO_ARE=
NA
and SCALAR.

At that point, it should be possible to drop the kfunc flags, esp. if we ar=
e
worried about fragmenting ways of achieving the same thing (annotation of
vmlinux.h prototypes).

In functional terms, the only change on resolve_btfids side should be to us=
e the
BTF parameter's emitted name for deciding whether it should trigger behavio=
r
equivalent to the current KF_ARENA_ARG flags.

For better or worse, we need to be in this state of supporting suffixes unt=
il we
can declare bankruptcy of supporting GCC versions without type tags support=
.

> [...]
