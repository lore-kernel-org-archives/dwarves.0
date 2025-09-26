Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4370D1F2BB5
	for <dwarves@vger.kernel.org>; Fri, 26 Sep 2025 15:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758899498; cv=none; b=RsaK10QwwsrZirLhhsFssBtKeEPMdKInvUt7Na+scuThimonAVLIpmOWmZKVJOM2+W6mj/g8+A/Yxjs21uA/VgYGylC16IHLpbo1zsTet02HPas29KQ6mZqQDJVXMmB72CjeY49IS7audUWaYtq6eeOQlqol5kxWzRslHp2g8/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758899498; c=relaxed/simple;
	bh=g9pIptTJimWNIf/L/brlFk5fsMJfisO7ECBgQLbZUxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZavheooBoP2nycbQnwmnVcTW1nbzIaYa9MKvMExiKfrYTpGJD4u48OSZqSoS2XKspAbb/syzhvyxNUCWiF6zkA9nmUCtIIE7oQakywOhN/7rADqrqETNFCUyodVViLCzwYbLwzHiaxSosOYENl5Xwa/8FETKp4gOIrwouaqItKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eoseU7mK; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eoseU7mK"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-32ed19ce5a3so1972764a91.0
        for <dwarves@vger.kernel.org>; Fri, 26 Sep 2025 08:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758899496; x=1759504296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9pIptTJimWNIf/L/brlFk5fsMJfisO7ECBgQLbZUxo=;
        b=eoseU7mKR8vj5pTw4/Wtuk0Bwu9dZLJR/JFWwOFVAth0xqA7R5bduIjjUy3+bfYiLD
         nW1FM+gwIZvZlwPzB00SxL3uBeCiDD71qzASvfg9nGvBOvQLkPqSgmoq7mOtrgU2hAqn
         lvbMmRc0noIQJZp1/BobeLKG11LBgm0gdx2xkw+fveHS/vHI3OSxgbSU9l9um4WgRI6e
         vsFYCAUQCIIx1jTH8wpAcZLqRFvy8ofodyM323lzzYok2tznIq6S5EreDtBKT077ZJk+
         rYNxulPWH5+fOMZDAAB0lMIj/t57VAh8pDrteqE/94i4hlD/jlqMh5KdNN99b1MEqvAb
         kKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758899496; x=1759504296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g9pIptTJimWNIf/L/brlFk5fsMJfisO7ECBgQLbZUxo=;
        b=V9VvIq+UGqLhTGGccxCNgOAJIIAgiHYogoIF1G0q2YClv1zwWGSf+5IS56Aj3UxM4a
         qW4glEPmv2N5T5Fa5eD2ZmzbA2ebO7Xdic0PaOBecv7KW1ecyj0LMbzE3wdaBFp4OvOb
         gl5AU3ZL4YrdjqZ+Lie+eQzp2glKFlRf75EQLKY+snV90SSYzzKm2itUgUprJXT4iQfz
         NFs8eabk6c9MzsY6W+J9sxDC5ZhNDgTddvqVrcYbHTWC8Je41bAvQXmia1X+enTz6LIc
         ZdwL1gmqkU+clLqrKevf9aEi3bNVe20rTmXw4/wkyQgM73KHHYlzcOy9mT5o/a8EYwkK
         NHiw==
X-Forwarded-Encrypted: i=1; AJvYcCU9bJT1MW1LIf6PMxd1g3A3OpZDUMTVWY3uHVEWRiAwZosxVrVSpB7gQjjN3wj8TqjxZXuAdtCb@vger.kernel.org
X-Gm-Message-State: AOJu0YzOuFd8dDcMfSNC865CzGt1l9lFskI00sHHNeuZWm7ZzV/etia8
	+rg9vO+WUKBVlUbWcSj0McXnWuTl14C0TQCNpQ+PbRLjTnOb/DjrZzuOmEgnyuFKTcD3KSXc5IC
	66ChDlD3G1JovY/maQMNDCkxShHzeLVE=
X-Gm-Gg: ASbGncscz2L9fMlk4RNSGroRKH2XEp9pRRFUoN4FaYH97rt1IqH5sbowEbfaMgj+hJL
	KVCAGj5/J6zAJ0SBKNSvHB0Tkmf3W34P28C/36Rp36jVCspRZYglSKALnEqKe7mdWTrTn3n0SYJ
	M9cVQS0Bt1HFPPv7SYMfQML3uDcKOuUFYz6k58hBu3msITF+ylhI1ilZpVR9Lu1fmeukWBGTcgd
	pORqxUpTrZ1ieA=
X-Google-Smtp-Source: AGHT+IFhJlYN40bI1MEGGa45XXHXXTHqcL+90nE/4Q0kdrKgnR2L0H7EcM4P1dJR7SAXJ5OZiKfRAiJ+xE3eBBKayEg=
X-Received: by 2002:a17:90b:1b12:b0:32e:3686:830e with SMTP id
 98e67ed59e1d1-334302782a8mr7663171a91.23.1758899496215; Fri, 26 Sep 2025
 08:11:36 -0700 (PDT)
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
 <CAEf4BzYm=dTqT=Aj-=Jg=n8AtcxZL1CiQiY5mVbUNA-pesz=sQ@mail.gmail.com>
 <CAP01T74_ZfQtHTsBmjNsGnuB4TeTTqqw2BOb8=3od6znS8XtQg@mail.gmail.com>
 <CAEf4BzY1g1svHDfQu8UmauTerWLMEk=OMWKO-f9HSe7tfB1arA@mail.gmail.com> <CAADnVQJX3guxpXuyP_spuNQMtWOxmh3DbDSyY+1_kz2z6_VDUQ@mail.gmail.com>
In-Reply-To: <CAADnVQJX3guxpXuyP_spuNQMtWOxmh3DbDSyY+1_kz2z6_VDUQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 26 Sep 2025 08:11:23 -0700
X-Gm-Features: AS18NWBVh-eDMGsV6DeA-MzCTtUSumqnZn07H3JmR1vfv4XHhrnBxxxj1HSVa_M
Message-ID: <CAEf4Bzb9jiFegQQHLpgBvVUS1HcEWuCJFfvG+2UNevT_0Ki5ng@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/6] bpf: implement KF_IMPLICIT_PROG_AUX_ARG flag
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Eduard <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	dwarves <dwarves@vger.kernel.org>, Alan Maguire <alan.maguire@oracle.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Tejun Heo <tj@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 5:10=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Sep 26, 2025 at 12:07=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Sep 25, 2025 at 3:58=E2=80=AFPM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Fri, 26 Sept 2025 at 00:54, Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Thu, Sep 25, 2025 at 12:35=E2=80=AFPM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Thu, Sep 25, 2025 at 6:23=E2=80=AFPM Andrii Nakryiko
> > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > >
> > > > > > I do see the benefit of having the generic "KF_MAGIC_ARG(s)" fl=
ag on
> > > > > > the kernel side of things and having access to full BTF informa=
tion
> > > > > > for parameters to let verifier know what specific kind of magic
> > > > > > argument that kfunc has, though. So as an alternative, maybe we=
 can
> > > > > > create both a kfunc definition *meant for BPF programs* (i.e., =
without
> > > > > > magic argument(s)), and then have a full original definition (p=
roduced
> > > > > > by pahole, it will need to understand KF_MAGIC_ARGS anyways) wi=
th full
> > > > > > type information *for internal BPF verifier needs*. I don't kno=
w
> > > > > > what's the best way to do that, maybe just a special ".magic" s=
uffix,
> > > > > > just to let the verifier easily find that? On the kernel side, =
if
> > > > > > kfunc has BPF_MAGIC_ARGS kflag we just look up "my_fancy_kfunc.=
magic"
> > > > > > FUNC definition?
> > > > >
> > > > > Interesting idea. Maybe to simplify backward compat the pahole ca=
n
> > > > > emit two BTFs: kfunc_foo(args), kfunc_foo_impl(args, void *aux)
> > > > > into vmlinux BTF.
> > > > > bpftool will emit both in vmlinux.h and bpf side doesn't need to =
change.
> > > > > libbpf doesn't need to change either.
> > > > > The verifier would need a special check to resolve two kfunc BTFs
> > > > > name into one kallsym name, since both kfuncs is one actual funct=
ion
> > > > > on the kernel.
> > > > > bpf_wq_set_callback_impl() definition doesn't change. Only:
> > > > > -BTF_ID_FLAGS(func, bpf_wq_set_callback_impl)
> > > > > +BTF_ID_FLAGS(func, bpf_wq_set_callback_impl, KF_PROG_ARG)
> > > > >
> > > > > and the verifier can check that the last arg is aux__prog when
> > > > > KF_PROG_ARG is specified.
> > > > >
> > > > > The runtime performance will be slightly better too, since
> > > > > no need for wrappers like:
> > > > >
> > > > > +__bpf_kfunc int bpf_wq_set_callback_impl(struct bpf_wq *wq,
> > > > > + int (callback_fn)(void *map, int *key, void *value),
> > > > > + unsigned int flags,
> > > > > + void *aux__prog)
> > > > > +{
> > > > > + return bpf_wq_set_callback(wq, callback_fn, flags, aux__prog);
> > > > > +}
> > > > >
> > > > > It's just one jmpl insn, but still.
> > > >
> > > > So basically xxx_impl() will be a phantom function that verifier wi=
ll
> > > > recognize and it will need to have corresponding xxx() kfunc with
> > > > corresponding KF_PROG_ARG for everything to work. Makes sense.
> > > >
> > > > Two notes:
> > > >
> > > > a) KF flag would need to be more generically named, because we'll h=
ave
> > > > other implicit arguments (like those for bpf_obj_new_impl, for
> > > > example), which will be distinguished based on their BTF type
>
> agree
>
> > > >
> > > > b) bpf_stream_vprintk() throws a bit of a wrench into all this beca=
use
> > > > it doesn't follow _impl naming convention. Any suggestions on how t=
o
> > > > deal with that?
> > >
> > > We can probably do a compat break for this kfunc alone for now, it's
> > > not been a long time since it's been out (1 release) not much adoptio=
n
> > > yet.
> >
> > Ideally there would be 0 releases with that name :) it's just
> > tantalizing that we can s/bpf_stream_vprintk/bpf_stream_vprintk_impl/
> > in like 8 places and avoid this altogether, but it is so late in the
> > release that I suspect no one will want to do this last minute "fix".
>
> I think we can still do it even after 6.17 is released and
> backport it as a fix.

ok then, sounds like a plan
