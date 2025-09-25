Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D8430DEDF
	for <dwarves@vger.kernel.org>; Thu, 25 Sep 2025 17:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821324; cv=none; b=SfW+EEIeXSaAzUXOREZMhLD4ukOJaGb3AEdDTTl2V1FuCjtovDm4MXFNFB2SwaO2mRUEXYkeQJLr79GvA/MXYgbm3SDrK6P7GceJ6h24hIBgcM7da7KBKYXrAtxY09o7OUudlPTAZiSA+xX7CR1LUsfW4LKOdH63xC0hV5ItRbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821324; c=relaxed/simple;
	bh=rOcf7syoHsIouvlswXay6faEtX9NiT5q5lhurDm9gxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OaRCMIbIN1aou6fED4UGH/DYFMYT3SZoP1jC2uiMWRZGU0nSbI5Q404IcGhHBvf2LJJ0WKDvrCKe08CiNQLTrMmghTiwbbWio3qY1gY9PorMBtfJnghZAfzHtfn0Y9tWEskLutFwP72qc6aq3IfWb796MBRUEUDb8NKUJ9WJ52Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2FOppdA; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2FOppdA"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-330469eb750so1403678a91.2
        for <dwarves@vger.kernel.org>; Thu, 25 Sep 2025 10:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758821322; x=1759426122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ps1znGvbkVaXEVnKByBRiv/UuQfRsE9vw1c5JC/YArg=;
        b=d2FOppdA71KPVxL4yqVq0J17ketd9frW1ZFNY36rDd6h3QPd1vb1/3RRuw5Nr2heoV
         MBJQJqV8QGHt0GnbY/RygyLJlHE0dUUsXpDg/UW2qcJugWwzC87F0l/Xug/EmzdkpYzL
         QmQf5MZvxY2vR6tc1ijaNatih0Gb1lapR5Mr8/j98y/czntxUlZ+HUuqODHI21DQ2aqE
         JlSZU9AdzK+gLJnd8yOReBuHhobTtLLZTn9mPKpIa4tGpOduFm9vVe/8/FiY+jTUIsbQ
         vG9880L0MiJh/b5nMRMcbWrV9me3khSxMVHSEZfG9G6veSD2w1Akfnj60SEN2qH95DbW
         yTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758821322; x=1759426122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ps1znGvbkVaXEVnKByBRiv/UuQfRsE9vw1c5JC/YArg=;
        b=lzbqsCTc2XnyIJb/jOg1MCLsrXlN38meXRfBfjzVeaA9ZC7ZAY7R0I1wOmURzjZiGs
         hNRSYtKyyJQKYlSaLIlJqjs0Bi+sbEbJDodNLkJvkpn3clnEyBjg4SjhhwgmNnnlpw9m
         XcfmoUeBMreGyd2a0mTaDhRCOAPDh/ykddNkHbZdPSrhoS0i3uX3nW5XYuNZ8GgoKYqU
         KCs4gs1IWnhuy/wWO+BDXYigNc9whKxJeeFbo1/l1zGoUFDyqm842nYRHa3r0QvICieW
         XLtbcyigxnmNfkHG2eLcn4fj/dpRB0PZKCsGNslcIb9TKsmwOhSh8fjkpsFtIycMOw/W
         2aJg==
X-Forwarded-Encrypted: i=1; AJvYcCVOFuc+9w2g5jquLlUpGzS8tUrIWmcaCTkR86+f/0KrOR/P+oHEoUWNi8t0XioJd/Z//54LvaR0@vger.kernel.org
X-Gm-Message-State: AOJu0YwYzgdBD4/VdAOnArsLFVKr1aee6s/kgps5mQk1qH8XDuTsi780
	ZNwQuDFbP1I+aFDDF+sGWnhy7VaLLgKeqpZYw8ngzNf4k1MVJ19hfyfEefxECKMAOGPheMUL/91
	7qc4BdpGlcQqIGkzSJTJx6RQfR/5wuJ0=
X-Gm-Gg: ASbGncvHpRYlM6iVWTxBaqUZ3D+q/g7yW9q9WZWt7AzOGdMlNhUPxR7h2WYWJ6p/LcR
	WBoIYB4P1g5BlpDCstsu4fiAbUYOudK7EFqTFY42Mvf2RtQHwQCPH0IESaci9KlF4G3kM8O+fIJ
	B/4xsk59eq8448OSkEax3kMD2EgP9MlCxv/PK/UsLDtowML2IXMa8RblDJUuYbu1SOWmwMCOmo+
	rORdz579NQWEJVtR8EpS/8=
X-Google-Smtp-Source: AGHT+IERtJP4yKArjLd7Spfh81zpMovZaA2mNRIPJ9EYwYqEAhNv01fojMGCGP2U42CUl9VrWp6tPm5mBsH2WhMmmfM=
X-Received: by 2002:a17:90b:4f86:b0:31e:cc6b:320f with SMTP id
 98e67ed59e1d1-3342a2574b0mr4566533a91.5.1758821321850; Thu, 25 Sep 2025
 10:28:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924211716.1287715-1-ihor.solodrai@linux.dev>
 <20250924211716.1287715-6-ihor.solodrai@linux.dev> <CAADnVQLVeZd0JOz-GBgZfi=t5kvtH_z1Ri2w6b-AW7DHgEBv5w@mail.gmail.com>
In-Reply-To: <CAADnVQLVeZd0JOz-GBgZfi=t5kvtH_z1Ri2w6b-AW7DHgEBv5w@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Sep 2025 10:28:27 -0700
X-Gm-Features: AS18NWB-4LZf9cOXY9YqPOuXPeqtspFedHp8sVRj_k25pAwxrufXUj48JJ82jg0
Message-ID: <CAEf4BzY+9gxA+r6K4u==mC8DMs_0F6jsG72B4HXWQo5uQLOhZw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 5/6] bpf: mark bpf_stream_vprink kfunc with KF_IMPLICIT_PROG_AUX_ARG
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, dwarves <dwarves@vger.kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Tejun Heo <tj@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 3:01=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Sep 24, 2025 at 10:17=E2=80=AFPM Ihor Solodrai <ihor.solodrai@lin=
ux.dev> wrote:
> >
> > Update bpf_stream_vprink macro in libbpf and fix call sites in
>
> 't' is missing in bpf_stream_vprintk().
>
> > the relevant selftests.
> >
> > Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> > ---
> >  kernel/bpf/helpers.c                            | 2 +-
> >  kernel/bpf/stream.c                             | 3 +--
> >  tools/lib/bpf/bpf_helpers.h                     | 4 ++--
> >  tools/testing/selftests/bpf/progs/stream_fail.c | 6 +++---
> >  4 files changed, 7 insertions(+), 8 deletions(-)
> >
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 6b46acfec790..875195a0ea72 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -4378,7 +4378,7 @@ BTF_ID_FLAGS(func, bpf_strnstr);
> >  #if defined(CONFIG_BPF_LSM) && defined(CONFIG_CGROUPS)
> >  BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
> >  #endif
> > -BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_TRUSTED_ARGS)
> > +BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_TRUSTED_ARGS | KF_IMPLICIT_P=
ROG_AUX_ARG)
>
> This kfunc will be in part of 6.17 release in a couple days,
> so backward compat work is necessary.
> I don't think we can just remove the arg.

Can we still rename current "explicit prog_aux" version to
bpf_stream_vprintk_impl() still?

That would solve backwards compat problems and would be in line with
bpf_wq_set_callback_impl() approach.


If we can't, then we'd have to name the new function something different?

Don't know if there is some other  BPF CO-RE and ELF symbol aliasing
magic that can be used, we'll need to play with this to see what
works.

>
> > --- a/tools/lib/bpf/bpf_helpers.h
> > +++ b/tools/lib/bpf/bpf_helpers.h
> > @@ -316,7 +316,7 @@ enum libbpf_tristate {
> >  })
> >
> >  extern int bpf_stream_vprintk(int stream_id, const char *fmt__str, con=
st void *args,
> > -                             __u32 len__sz, void *aux__prog) __weak __=
ksym;
> > +                             __u32 len__sz) __weak __ksym;
>
> CI is complaining of conflicting types for 'bpf_stream_vprintk',
> since it's using pahole master.
> It will stop complaining once pahole changes are merged,
> but this issue will affect all developers until they
> update pahole.
> Not sure how to keep backward compat.
