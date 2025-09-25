Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D741D19C546
	for <dwarves@vger.kernel.org>; Thu, 25 Sep 2025 22:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758840866; cv=none; b=mvl2IwH4nDeNUdm2O/gXRfc2fCM6hw8jJ/t+qsbMd4W4227w0CAtsObsyXrFrYRmATgCEUrTmysqz4BJ6mhbLHB6j6sI17MI+XqyeIyJ+v4RDYc/SASOIVYDsdJ9jtOqKXPg+hX3a995Mg5cKxDPH7JMwyIQ3B4iFNhurSsSvrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758840866; c=relaxed/simple;
	bh=v9IHZa6UUD2fyTqSiQjOSshlFhjUT7IFby7QXTQVXmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kBNpkN9q6LIEeSapqPfaFnTkhj8X8bNmkk2d73NHa4E4RGzL73LzPVfhl8uVIxg+HT3eRdfhw/cOUaoOy3N686PAseULyQ+wrFBxzhKRqBUms57rYmDjIpv9kKMCOzTwo9lylf4zGt7YuztR9+eOgrNj2bqF+42o0camm/+Kfuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGqNF727; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGqNF727"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b55640a2e33so1217885a12.2
        for <dwarves@vger.kernel.org>; Thu, 25 Sep 2025 15:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758840864; x=1759445664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9IHZa6UUD2fyTqSiQjOSshlFhjUT7IFby7QXTQVXmQ=;
        b=GGqNF727UbwJkcOxpUhD8pnTyI/3Rh3sDoxjoboAZhXNIwM24P3ZpK/TH/EOrIwZ7A
         UjDT3BsKz7LZ1lahYBlT5LaNrT3CaRy9ufZv9TguL6Do7Gm2Hy2VAQsJMfkQY47OK6Wn
         yk8pN8UIgqXEjYgN+EWNQyvwzFz8lW/cVuE5Na0MwoPGCq701xse3UFY2fr26/3fcnHe
         Wj7ZIToqOrCk5KnWFIA1SuMSwvug0YdgvkrK1Ryet32tJ3IxkedBafHuHaBP+m003tke
         cVC2MBkjbgPuje/W23rCfNAsfDOONjdHauNzO3P8H4QUh9ghRI9Jd+X2Utu+jblEPaQ3
         VqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758840864; x=1759445664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9IHZa6UUD2fyTqSiQjOSshlFhjUT7IFby7QXTQVXmQ=;
        b=dEj0DQH3U0d8ilCT4tSdPvyU3AAezpzfJj3MqQQZcGni6S0dKGx6tVBfCluZbMwyUP
         0gaH6hSzcxx/EFv7oHw647kMERewvUs27Q/BKClM5F96ZUeJ4GxSiIqZa4tEFCd6kVUq
         IWxXlpLfSlHentfxxBIUi+rVPBO108kfCSJlSQ3fFm8n2urlSS0UzpQX4w2u+XzTA4e+
         wOuQxRLUW9EtLmr6Ar6SR0f6U2xJkGGuDNH0M1+LG/RZKcexIY1H8H+PaG88hd3u50ew
         3vKw8vHgzAJTjwewL6m3PwbCkkvStOCMPMdedGYDyDv5R8NE/8PQyj9IEo8C8CPb7bmq
         MU8w==
X-Forwarded-Encrypted: i=1; AJvYcCUSFt34XBVaULh4lOjGJul9ws4RwpkjuY0J0hbnH4TGzumC48qM2jQ5ZX95J83irRWMLT09xjAx@vger.kernel.org
X-Gm-Message-State: AOJu0YwtItFL1qYKumNZVt32AVtsE98pva5Fvj2BM5EXgKemh97vC9Th
	8KNZ8zp9RkQz7P1FK42wcwHURlQ1Wj/0GKUAzMJm/W5zy/CUlftOFtGKmzI/pSO56k7gobxR+RA
	NpDZxVGTRP+NwpRgIhnM1PylrWTtHwQo=
X-Gm-Gg: ASbGncv50pCgtktQpgNDlgAJaHfFEG6/PvpyxGpeOYweIutkX4FeZ/mxkdSrk5zaj6K
	4SUgsfbNq7BUZfBkKRRwssx1q0jlnLOP4v3CE/T2ttxizsItS2tjqwXkXe7AgNA2h5U5VAt0u3h
	GuRFXJ+v/p8wP/ZI7EN7z2Id96EseHzdyWrxh8rLMnqUBu79TZO1RV90Ak0arwJudXucshsqDzz
	sU6Em5xIs3XJtywclPd6UA=
X-Google-Smtp-Source: AGHT+IEG2F90O4jGCD9OhAsIUJZKquX6SjgPjBb5qsXYOBHi3LwpOs3TOyZ1k0XgKp5v4Zp/8he+0fWLFVZqq0Nqbec=
X-Received: by 2002:a17:90a:bf0f:b0:32e:3830:65d5 with SMTP id
 98e67ed59e1d1-3342a3013e9mr3710317a91.36.1758840864151; Thu, 25 Sep 2025
 15:54:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924211716.1287715-1-ihor.solodrai@linux.dev>
 <20250924211716.1287715-2-ihor.solodrai@linux.dev> <CAADnVQLvuubey0A0Fk=bzN-=JG2UUQHRqBijZpuvqMQ+xy4W4g@mail.gmail.com>
 <6a6403ec-166a-4d48-8bf5-f43ae1759e5f@linux.dev> <CAEf4BzbYXADoUge5C7zhzZAEDESE7YJFwW_jO4-F5L3j-bwPMw@mail.gmail.com>
 <CAADnVQL+28vPquMgw+hZMT1P6NkE5jLUXf=HDNj65N9np1rgfw@mail.gmail.com>
In-Reply-To: <CAADnVQL+28vPquMgw+hZMT1P6NkE5jLUXf=HDNj65N9np1rgfw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Sep 2025 15:54:08 -0700
X-Gm-Features: AS18NWAugdjCg0SYupnLaIvvV6KxFfvW1uIZoHwM0NWXVVuUpQNblEYuU1FUVkY
Message-ID: <CAEf4BzYm=dTqT=Aj-=Jg=n8AtcxZL1CiQiY5mVbUNA-pesz=sQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/6] bpf: implement KF_IMPLICIT_PROG_AUX_ARG flag
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	dwarves <dwarves@vger.kernel.org>, Alan Maguire <alan.maguire@oracle.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Tejun Heo <tj@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 12:35=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Sep 25, 2025 at 6:23=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > I do see the benefit of having the generic "KF_MAGIC_ARG(s)" flag on
> > the kernel side of things and having access to full BTF information
> > for parameters to let verifier know what specific kind of magic
> > argument that kfunc has, though. So as an alternative, maybe we can
> > create both a kfunc definition *meant for BPF programs* (i.e., without
> > magic argument(s)), and then have a full original definition (produced
> > by pahole, it will need to understand KF_MAGIC_ARGS anyways) with full
> > type information *for internal BPF verifier needs*. I don't know
> > what's the best way to do that, maybe just a special ".magic" suffix,
> > just to let the verifier easily find that? On the kernel side, if
> > kfunc has BPF_MAGIC_ARGS kflag we just look up "my_fancy_kfunc.magic"
> > FUNC definition?
>
> Interesting idea. Maybe to simplify backward compat the pahole can
> emit two BTFs: kfunc_foo(args), kfunc_foo_impl(args, void *aux)
> into vmlinux BTF.
> bpftool will emit both in vmlinux.h and bpf side doesn't need to change.
> libbpf doesn't need to change either.
> The verifier would need a special check to resolve two kfunc BTFs
> name into one kallsym name, since both kfuncs is one actual function
> on the kernel.
> bpf_wq_set_callback_impl() definition doesn't change. Only:
> -BTF_ID_FLAGS(func, bpf_wq_set_callback_impl)
> +BTF_ID_FLAGS(func, bpf_wq_set_callback_impl, KF_PROG_ARG)
>
> and the verifier can check that the last arg is aux__prog when
> KF_PROG_ARG is specified.
>
> The runtime performance will be slightly better too, since
> no need for wrappers like:
>
> +__bpf_kfunc int bpf_wq_set_callback_impl(struct bpf_wq *wq,
> + int (callback_fn)(void *map, int *key, void *value),
> + unsigned int flags,
> + void *aux__prog)
> +{
> + return bpf_wq_set_callback(wq, callback_fn, flags, aux__prog);
> +}
>
> It's just one jmpl insn, but still.

So basically xxx_impl() will be a phantom function that verifier will
recognize and it will need to have corresponding xxx() kfunc with
corresponding KF_PROG_ARG for everything to work. Makes sense.

Two notes:

a) KF flag would need to be more generically named, because we'll have
other implicit arguments (like those for bpf_obj_new_impl, for
example), which will be distinguished based on their BTF type

b) bpf_stream_vprintk() throws a bit of a wrench into all this because
it doesn't follow _impl naming convention. Any suggestions on how to
deal with that?
