Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A462925F988
	for <dwarves@vger.kernel.org>; Thu, 25 Sep 2025 17:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758820531; cv=none; b=Drpz1Yq3olT8sqXTvre4QvmzJglbYmWdtnKTB9I9PZBhaA7Ml5eaRq7y3cPe6ITun5vB2K3Cy8cOINghxtKY7ipAxVk8A55lsC64ag8G+3cDNOw5j6/RZcRLyFsKJ1dN1At5MjeD2r4lD4azDkrKXdCGXxX1Z9UGV8clP6spnLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758820531; c=relaxed/simple;
	bh=brKcv+SZBosARsBrRsCIGSFwpsXb1IgnE59o8tm6UmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sAC57D/bsZeSvgv1M11282AR+8eQ1AuOE7OdyJ+IQaZ7bJIZrgiuCiCZ8/A9r9KgbLxnLe37G2sK0vi8VtFPlOWV76yzyIou3ZLkBH11KMWIqLP9bcc2/HW1d9bM1s9J3fuiE3lMDSKoiwjX0yF+1Dfxa9xevj05KlvHfZ/4H60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bhkVkFqU; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhkVkFqU"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77f2e621ef8so1655738b3a.0
        for <dwarves@vger.kernel.org>; Thu, 25 Sep 2025 10:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758820529; x=1759425329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fP3e5XpX/mv2mFcDefKMMzsu7+cgHOTBv7hjzKJz3UM=;
        b=bhkVkFqUiFJIrcVibiFv+ckkP44eLYCXZ62emN0VTfyb7uS5dqjCVI6is8Z4T7wDoz
         GWpR4dVxoEzImmdEsCJ2G1AiwyWJH2C+Sx1iw/ZHbpeJbMpFKk3wyR7tv1btl4x7qasG
         vWU6aZZUSBVfe/ftx+sgNsOXQqxTZMFEZGCuRiexmSif0Oyu7T5XXEXngldC6mNh/ieV
         dIXmFiLoPOaAJ39HMpm6iDL/bixp/+x+RowoSHuCA+efAYFPMvgVkORErw/Y6TteUSFC
         OphAnc9lM2llEZT1TYlSAz7gtES9KkXY+N9rfDmNaw7BcRRC7AbI39mo2tE3UlsJ9VA8
         R/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758820529; x=1759425329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fP3e5XpX/mv2mFcDefKMMzsu7+cgHOTBv7hjzKJz3UM=;
        b=dG9lz+fgZPHdXcus+f1sLMCf5z5M7naSNB8U6PqzbvmDWt0J0P9ceulYb03HBIYmOj
         zjvlacsMSVqjoqA2nJadBk2mB5Z+hzuATFhaETXIemNAxMZgwLK3VWfz+mmlooM/UqoF
         URRN1RJf2oxto17vaanvj6kw/ny9B2vGAl5en3Qft6x3y6STM6ZBkJELveGoDTzOrKdC
         Uhkal+aau6JaDUU5g+T+4lMBNj8UE/ASkTtkZ46oykz6xYwMtYweNFqt88464IuH6/03
         jonm03mHZQmfq+4KhIBMbQ6b5TZiNIIunOn2GUyXW1vrvuO1pPrIF+RaFo7yFI46D+w1
         /ncg==
X-Forwarded-Encrypted: i=1; AJvYcCUQo9A0c6UQxFrzn3d1FX5RYPHU/5VyZlgtRWM7kJpx2LLIB7XxXj5H3yl23zaOR17tXSToVCVQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyH2QlPANT2NkMrLiCLyXLvmvK6FHt7Nw1XSwvHY1b5u8q7N3tV
	dU7CZrdtgmi9bN+tMMn3MY9jBcoI3vwjRQXtjyftRrb1UWyMr8p0RGhUvvmI23EzNWimqR6s5Z5
	HA+Sx8b8a6e0R+wTEP8DvNFNt3ZHFMkX68g==
X-Gm-Gg: ASbGncso0T6PZfgkBcD0Zsa0w49NyahvRf6G/f4f0qmLv2y4C4S30KVTfU00Xouk9Gq
	I2tXUos617+BjV4Jyvm4PviSeKp/1mYdHm0PhXTphtGwUz1367XXqPliewyzbsnXDsAAuhWsTaZ
	RoNb6E8rV0yWYAotwLTH+ZVi0O0fhmLlw8D4BdsP7IAAdSZDe3uf78N9ZjaKS89J6veCAuL8cMq
	6/WrfWBBLK2ocTwT00EaoY=
X-Google-Smtp-Source: AGHT+IEhH2YUTxIE9+nyCzayweg/wqeGqERQgiT8DAxYtFLnlo+kjlkgLrEKgyglDHa3hJjWMuPZHtd3BK+jEN4ANwA=
X-Received: by 2002:a17:90b:1c04:b0:32e:d600:4fe9 with SMTP id
 98e67ed59e1d1-3342a20be0emr4706103a91.4.1758820528547; Thu, 25 Sep 2025
 10:15:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924211512.1287298-1-ihor.solodrai@linux.dev>
 <20250924211512.1287298-3-ihor.solodrai@linux.dev> <4fb8a812fdd01f115a99317c8e46ad055b5bf102.camel@gmail.com>
 <a7f28918-7eda-42e9-ae41-446b7a2d9759@linux.dev> <b92d892f6a09fc7a411838ccf03dfebbba96384b.camel@gmail.com>
In-Reply-To: <b92d892f6a09fc7a411838ccf03dfebbba96384b.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Sep 2025 10:15:14 -0700
X-Gm-Features: AS18NWBrxfrNowky9yFmZ92ieSPJ0nogD7mzjj0Dmg02YrBfmCtvZRzyfhSKmNg
Message-ID: <CAEf4BzaaJLDDLqO64iuCVkMoT3jTnrCrRe-UB4_e0BWqa+FuNw@mail.gmail.com>
Subject: Re: [PATCH dwarves v1 2/2] btf_encoder: implement KF_IMPLICIT_PROG_AUX_ARG
 kfunc flag handling
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves@vger.kernel.org, 
	alan.maguire@oracle.com, acme@kernel.org, andrii <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org, tj@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 6:28=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2025-09-24 at 20:59 -0700, Ihor Solodrai wrote:
>
> [...]
>
> > I'm not sure how generic KF_IMPLICIT_ARG would even work.
> > Any *implicit* parameter requires a very concrete implementation in
> > the verifier: an actual pointer of a particular type is injected after
> > the verification.
>
> Does not seem complicated:
>
> - In pahole generate a special decl_tag for bpftool.
> - In bpftool, don't emit last argument to vmlinux.h, if that flag is pres=
ent.
> - on kernel side, when checking kfunc args, also check for the flag
>   and switch over types recorded for last function parameter in BTF.
>   If kernel knows how to handle it, great, if it does not, emit
>   verifier error.
> - Not sure, but likely, the change on the libbpf side will be needed,
>   as it compares function prototypes between program and kernel BTFs.

this is exactly the thing I'd like to avoid: setting up special CO-RE
matching rules for these few special kfuncs

>
> E.g., for bpf_wq_set_callback keep the definition as is:
>
> __bpf_kfunc int bpf_wq_set_callback(struct bpf_wq *wq,
>                                     int (callback_fn)(void *map, int *key=
, void *value),
>                                     unsigned int flags,
>                                     struct bpf_prog_aux *aux)
>
> Kernel BTF will have it with full set of parameters.
> But because of the flag, it will be printed w/o last parameter in
> vmlinux.h:
>
> extern int bpf_wq_set_callback(struct bpf_wq *wq,
>                                     int (callback_fn)(void *map, int *key=
, void *value),
>                                     unsigned int flags) __weak __ksym
>
> On kernel side check_kfunc_args() will have access to complete BTF
> declaration, so it can:
> - check presence of the flag
> - lookup bpf_prog_aux from the kernel side BTF
> - call set_kfunc_arg_prog_regno.
>
> > So we have to do a type check on pahole side to catch invalid kfunc
> > declarations. And the verifier of course must be very strict about
> > where it can pass pointers to kernel objects.
>
> Type checks on pahole side will require upgrades to both kernel and
> pahole, when new implicit parameter types are added. I'd try to avoid
> that.
>
> Also, do we plan to have several implicit parameters passed to a same
> function?
