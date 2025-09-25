Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40ABE2E2F03
	for <dwarves@vger.kernel.org>; Thu, 25 Sep 2025 23:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758841666; cv=none; b=ZzkdaqgaCKSLh9RWNP91JCr9aYztpfM2H7HinkMK+Y6AuZq9fsf9N9ch1AbxcpqphcgZonJlXtYjROaSgp+L4LpTiKx2RCj/WkIC4Ff34LcktklfOlGwjx5FuccDJpkhFDQK2KHSEolqHHV0kF8vbWf4ig5O5sSco8U1C32muyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758841666; c=relaxed/simple;
	bh=1O/3QW9Bo8enlcammiBNt10RN7XU2tCfL0QONEK69Yg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EyFR+QCC/iVnbuznxMqrL4S80dS8qRS5N4qFkg2Pkw7v6eeii8/gD0SNq5+S41oL9dyvQoLAvdAe1OW7x2ym+K+xxqz5P1G0WVR99DxNQEiC3mj/Y1qIWX8hagRZxwrSCddAP4LIjio7nM49oeLa7Xvgw+ri0Syx+iWZcneG0IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3gMf2gc; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3gMf2gc"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-27edcbcd158so11675785ad.3
        for <dwarves@vger.kernel.org>; Thu, 25 Sep 2025 16:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758841664; x=1759446464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1O/3QW9Bo8enlcammiBNt10RN7XU2tCfL0QONEK69Yg=;
        b=V3gMf2gceZ/qwZkzGLEJaSKfjmrMz2xBthsMhLB1Z/b2uxS3+WdRnm0QEmHXkPMtGS
         SdYWNsyqDYBj2BxKXFuykYi6eGTSb5G4cmWSk/EVCdHhZExeyR0e5x0XunyDhZwI32sy
         F2SB1CukMCH4VRd3i9j3M+u7KHETUFxz8P6FVdKzAaV/GdNjMhqEhXD35zj5ER00DNEW
         Cy+agiHKVfR4RLCqk19BOxkIIpmFXMppL0VeNUPoCdfWcBbFJ7hB9M1TGd3WFU1j9x7j
         3rFK2uSCvDaifXfc/Xbz7iqKtuu2ByzYxQwFvv1kczaoxUG6m05ncGakeW1eumW5yCzg
         p1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758841664; x=1759446464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1O/3QW9Bo8enlcammiBNt10RN7XU2tCfL0QONEK69Yg=;
        b=rhhZyMi3gVDWBA6X/DbivOFlExeAi1cSl9RQcoxJLC3SyB0ScE3Vk7eeorxUoq9g4T
         XT1ssxzREh1c3lCtCbQkmnYbM3cCyPQFFx7hCbHMN3CA2qQSDZNnHiLehvy1JOTAdzlm
         gLriVZC9x/z53pxxxkFT4h5gOJblAC8PKSR79Qi2Gz7zI4cvT8mvxF5M/GsgN/P40n3M
         QhscBuixgsBT03z1pgyIU0WO+6pI3gkSrz6d88W2ia50Nzo4ySKJC8/DXC0EyDZ8rFoa
         H31kyYDBM0L7jWO2LS7bhzwlsleKBCoidoxr1XLKVT2m8s1bH4kxoU1iFbyFUyz3pZRo
         C+vg==
X-Forwarded-Encrypted: i=1; AJvYcCWxpckv6Lqxcx2TCe0fjRSSTCMEvZ/GRMXL5iIls3WI4hb4+IZDC/5JchWeomA82Gje3A1zaC7t@vger.kernel.org
X-Gm-Message-State: AOJu0YzKhndekxVKdohEzGBkwLnpYzq1QerrHCs65bLeVQNlKJHqZvK9
	GRNrNZ8JEgFtFb6oHiexkdLBEiqJcL3dpQNIYbSYN/y2dLOOaYj2hHuBr6IFDT4IC5tJgPC7qiU
	LjqbFXtiSDquJ0lYCf9JXxezuIfQADuc=
X-Gm-Gg: ASbGncsP7DkTTAoUFEsIgAXbjlDWwQF8wufJUoD23lZ7ssYunoE75AW3dl45cEwR2Bv
	zEfim4gu6BiuW0unWx2zELcalm+NsSQJO8LN0L1n+ngd0VlFCq5ZVlMx8S8nZmlWvJLihmiu9AO
	9dj8Gp/vmjSTxs60AJxWpgpn21zldvWqdnhCMsdU7Zni9TUUYrtt5DyJf4WRQmuazi6chTvE7hn
	LeWM5kwMVm2WGY6h9JTQ0s=
X-Google-Smtp-Source: AGHT+IEH5cefaUkqKIf2ymoWpciMaPkvwaRrN3bUmRLSiEMn3NZ0VhbVW6Zdg4yuXstIds2Efuuiqw0hY1HoR/Yv4Fw=
X-Received: by 2002:a17:903:2c0d:b0:275:27ab:f6c4 with SMTP id
 d9443c01a7336-27ed4a315b5mr58511205ad.33.1758841664495; Thu, 25 Sep 2025
 16:07:44 -0700 (PDT)
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
 <CAEf4BzYm=dTqT=Aj-=Jg=n8AtcxZL1CiQiY5mVbUNA-pesz=sQ@mail.gmail.com> <CAP01T74_ZfQtHTsBmjNsGnuB4TeTTqqw2BOb8=3od6znS8XtQg@mail.gmail.com>
In-Reply-To: <CAP01T74_ZfQtHTsBmjNsGnuB4TeTTqqw2BOb8=3od6znS8XtQg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Sep 2025 16:07:30 -0700
X-Gm-Features: AS18NWCTAJb9fEnMfMCNx4DEDOxdjvv0SIXpwgoyHl12LxtlFRKXxY_taxwKBoM
Message-ID: <CAEf4BzY1g1svHDfQu8UmauTerWLMEk=OMWKO-f9HSe7tfB1arA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/6] bpf: implement KF_IMPLICIT_PROG_AUX_ARG flag
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Eduard <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	dwarves <dwarves@vger.kernel.org>, Alan Maguire <alan.maguire@oracle.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Tejun Heo <tj@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 3:58=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Fri, 26 Sept 2025 at 00:54, Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Sep 25, 2025 at 12:35=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Sep 25, 2025 at 6:23=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > I do see the benefit of having the generic "KF_MAGIC_ARG(s)" flag o=
n
> > > > the kernel side of things and having access to full BTF information
> > > > for parameters to let verifier know what specific kind of magic
> > > > argument that kfunc has, though. So as an alternative, maybe we can
> > > > create both a kfunc definition *meant for BPF programs* (i.e., with=
out
> > > > magic argument(s)), and then have a full original definition (produ=
ced
> > > > by pahole, it will need to understand KF_MAGIC_ARGS anyways) with f=
ull
> > > > type information *for internal BPF verifier needs*. I don't know
> > > > what's the best way to do that, maybe just a special ".magic" suffi=
x,
> > > > just to let the verifier easily find that? On the kernel side, if
> > > > kfunc has BPF_MAGIC_ARGS kflag we just look up "my_fancy_kfunc.magi=
c"
> > > > FUNC definition?
> > >
> > > Interesting idea. Maybe to simplify backward compat the pahole can
> > > emit two BTFs: kfunc_foo(args), kfunc_foo_impl(args, void *aux)
> > > into vmlinux BTF.
> > > bpftool will emit both in vmlinux.h and bpf side doesn't need to chan=
ge.
> > > libbpf doesn't need to change either.
> > > The verifier would need a special check to resolve two kfunc BTFs
> > > name into one kallsym name, since both kfuncs is one actual function
> > > on the kernel.
> > > bpf_wq_set_callback_impl() definition doesn't change. Only:
> > > -BTF_ID_FLAGS(func, bpf_wq_set_callback_impl)
> > > +BTF_ID_FLAGS(func, bpf_wq_set_callback_impl, KF_PROG_ARG)
> > >
> > > and the verifier can check that the last arg is aux__prog when
> > > KF_PROG_ARG is specified.
> > >
> > > The runtime performance will be slightly better too, since
> > > no need for wrappers like:
> > >
> > > +__bpf_kfunc int bpf_wq_set_callback_impl(struct bpf_wq *wq,
> > > + int (callback_fn)(void *map, int *key, void *value),
> > > + unsigned int flags,
> > > + void *aux__prog)
> > > +{
> > > + return bpf_wq_set_callback(wq, callback_fn, flags, aux__prog);
> > > +}
> > >
> > > It's just one jmpl insn, but still.
> >
> > So basically xxx_impl() will be a phantom function that verifier will
> > recognize and it will need to have corresponding xxx() kfunc with
> > corresponding KF_PROG_ARG for everything to work. Makes sense.
> >
> > Two notes:
> >
> > a) KF flag would need to be more generically named, because we'll have
> > other implicit arguments (like those for bpf_obj_new_impl, for
> > example), which will be distinguished based on their BTF type
> >
> > b) bpf_stream_vprintk() throws a bit of a wrench into all this because
> > it doesn't follow _impl naming convention. Any suggestions on how to
> > deal with that?
>
> We can probably do a compat break for this kfunc alone for now, it's
> not been a long time since it's been out (1 release) not much adoption
> yet.

Ideally there would be 0 releases with that name :) it's just
tantalizing that we can s/bpf_stream_vprintk/bpf_stream_vprintk_impl/
in like 8 places and avoid this altogether, but it is so late in the
release that I suspect no one will want to do this last minute "fix".

> And then double down on this convention going forward.
>
> >
