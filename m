Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E622DC339
	for <dwarves@vger.kernel.org>; Tue, 16 Dec 2025 22:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765923000; cv=none; b=u8T3NQFZtiQyO5ht7s/XYqV6F7x6AX+61Jp11saS1SS4mprYqSqJCVuDOVHJ84apam8Yi9nXieuRZGUn9PqHQ62akFL9otyqLaYIiTsYwbR1wJlGhFuLR19UwrrhBB5sJzNjGDdAPrviDl3pXYTlqpTnNk8cZr2DeH88KkJk0NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765923000; c=relaxed/simple;
	bh=VnD05L81E7UPJUQIXZqI8i7Y0uB5J3FzlEQYTU4586U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y9IC1XvyFeExbAxndhU4nY/eoHhdE5acdTWi/rHYNtZHm9kyCmyMAx4ywVxsVZawQXosv0juXUe7v54xoLE3CcY1YmA/J8Z3L1787l+AcGuGFgyGyVlQXPdLqK2cUlH5f8hBtt/pmrDw+M4NuX0HBdG6Exeopc9DI5xkrjYwGW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amt2hac5; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amt2hac5"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a099233e8dso31132085ad.3
        for <dwarves@vger.kernel.org>; Tue, 16 Dec 2025 14:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765922999; x=1766527799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Z66AwqDtODxBjHY9XlX+LsynBwtoVi3CGvh3SOUtMY=;
        b=amt2hac5UVBBPFtomtbH4UMt+a2wHtV9AShlNT7EswGiHAcQdEygSGXtlwfHFoC9KC
         x9/eiWnXmcVXkiNPJxUk8lmQKON4nQ3egsNoRMMPhbGFBpKYLBsDRl4rs+RtVvSdnSj2
         +LjKxnRKRaAGuDbXVxSD3Tfivl9Fn6p/JnO7DSkzu05L06jKaaetviVm5D9c7IF7wrCK
         5vM6dgkqVOt4yHeQmqR/wysI6nb1jFALag7wIRmiHT4O+G67RaFPG0lgjuK+4LhlfQtO
         ELtUPUiy3ZOM92OpogjCK7SyHD6bslaVjtF+hjOwUKx3hYX+GhYPdW6FWvHc8tam85zk
         TrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765922999; x=1766527799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Z66AwqDtODxBjHY9XlX+LsynBwtoVi3CGvh3SOUtMY=;
        b=NdVzNUZOI9flQMiVxZLz6KMjVUKpvi2egE7zO/783MuXyC3+QhbyI7IJN0/1jxH6iw
         JdKNaQWaELW1UZytLEmcNjMIJUklCdHUWo8hTS2qH9wM9lSjuL+sa5r8R9mRgT9DBBK4
         yOHDR2WMiDlqwyArXdbhSmpbTgtWAXujrLaKmrikzOU6Z4/MUSu/hRWP6jOODxojokcC
         IBnVxA2lVqKM7OSFeRfk8gV1EKAszYACpObEz/tXVBs+igidzICyndYDvCfgSKp5PaXl
         mvsObc2KHFdfcCneW0W6uTIQpxXA4dqNqdlVNXTuVQZItzKffOJdNcCuqkZR9oVt/Akd
         Am5w==
X-Forwarded-Encrypted: i=1; AJvYcCXlPBvEXKNgz9XRBybNkNgfneFI8TBe4bOa7wXgzIfTBrPbfHaOURCUKIpHjCEiBJRKOeuZLP/f@vger.kernel.org
X-Gm-Message-State: AOJu0YzO1tuXOIvwVFox0maa0SGHFgvyw9lXJwNAzceI9YAGHMLjjttC
	rgSA3c7AJjmtQTRelwpiC8ZGB1f3LEdbWMyynVaPDs9UoiUVSukAv575Qgcmm0XjqVFNN/M+X7L
	rxb1ucVWzJYQqMQ3VXa9npbX3OCLjSlQ=
X-Gm-Gg: AY/fxX77kx0S0gO+JdlaXs/V4KLmliuIfQh86Go4NV+GaH9ZTYO+jjChAobno5QoE3D
	5I0Bio49HudWwPLqYPpDJvgzFbmO8SLP1KikptGaqFewI7St2zufzg83r/wMBmKF0WFQ1G13fTg
	Dhiod2py0XMJoXvj3AgV9eIHbmAmVSMHe3TVdL16lARI40H5vJNiIN7qmp7ksi+geFjZDmXGwyu
	eFDlq/s21Gu82lkuGs0XP0TxShaMPMZfvPfw8vdVGtNV6vDuZxt15WaKRJcOkcn8tRJlW7iDw+L
	F0+pMo2GN9A=
X-Google-Smtp-Source: AGHT+IHi97YN5wLpUNbCwo9EoKx/q7L6WfwzQ0F705p18iUPsSCcPfkk/AzYKbDG7XVtdlbf/RhatBt4wl5l0U0dYZ4=
X-Received: by 2002:a17:902:db08:b0:2a0:da38:96d8 with SMTP id
 d9443c01a7336-2a0da3897afmr104177705ad.25.1765922998504; Tue, 16 Dec 2025
 14:09:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
 <20251215091730.1188790-7-alan.maguire@oracle.com> <1351a3a944fab86e7fe1babf8b31cde4e722077e.camel@gmail.com>
 <CAEf4BzbgjZfxUeB78D4u4LRzESsTSdzOgFJAkOqEoQcRWuS=2g@mail.gmail.com> <87d08c49a65a951944e5b2254e605e3c4a064e50.camel@gmail.com>
In-Reply-To: <87d08c49a65a951944e5b2254e605e3c4a064e50.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 16 Dec 2025 14:09:45 -0800
X-Gm-Features: AQt7F2roT4Lkplu1fE_gn3gnMwMoz9b3-EETCt9iEER0_bmqiKFM8FKDObcp37U
Message-ID: <CAEf4Bza6=yBpM0QNrFt4MaBHNTCVxvMrE1Sj+eqHGbKh0CcBJQ@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 06/10] btf: support kernel parsing of BTF with
 kind layout
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org, 
	ihor.solodrai@linux.dev, dwarves@vger.kernel.org, bpf@vger.kernel.org, 
	ttreyer@meta.com, mykyta.yatsenko5@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 1:25=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2025-12-16 at 13:21 -0800, Andrii Nakryiko wrote:
> > On Mon, Dec 15, 2025 at 10:51=E2=80=AFPM Eduard Zingerman <eddyz87@gmai=
l.com> wrote:
> > >
> > > On Mon, 2025-12-15 at 09:17 +0000, Alan Maguire wrote:
> > >
> > > If strict kind layout checks are the goal, would it make sense to
> > > check sizes declared in kind_layout for known types?
> > >
> > > [...]
> > >
> > > > @@ -5215,23 +5216,36 @@ static s32 btf_check_meta(struct btf_verifi=
er_env *env,
> > > >               return -EINVAL;
> > > >       }
> > > >
> > > > -     if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX ||
> > > > -         BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_UNKN) {
> > > > +     if (!btf_name_offset_valid(env->btf, t->name_off)) {
> > > > +             btf_verifier_log(env, "[%u] Invalid name_offset:%u",
> > > > +                              env->log_type_id, t->name_off);
> > > > +             return -EINVAL;
> > > > +     }
> > > > +
> > > > +     if (BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_UNKN) {
> > > >               btf_verifier_log(env, "[%u] Invalid kind:%u",
> > > >                                env->log_type_id, BTF_INFO_KIND(t->i=
nfo));
> > > >               return -EINVAL;
> > > >       }
> > > >
> > > > -     if (!btf_name_offset_valid(env->btf, t->name_off)) {
> > > > -             btf_verifier_log(env, "[%u] Invalid name_offset:%u",
> > > > -                              env->log_type_id, t->name_off);
> > > > +     if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX && env->btf->kind_l=
ayout &&
> > > > +         ((BTF_INFO_KIND(t->info) + 1) * sizeof(struct btf_kind_la=
yout)) <
> > > > +          env->btf->hdr.kind_layout_len) {
> > > > +             btf_verifier_log(env, "[%u] unknown but required kind=
 %u",
> > > > +                              env->log_type_id,
> > > > +                              BTF_INFO_KIND(t->info));
> > > >               return -EINVAL;
> > > > +     } else {
> > > > +             if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX) {
> > > > +                     btf_verifier_log(env, "[%u] Invalid kind:%u",
> > > > +                                      env->log_type_id, BTF_INFO_K=
IND(t->info));
> > > > +                     return -EINVAL;
> > > > +             }
> > > > +             var_meta_size =3D btf_type_ops(t)->check_meta(env, t,=
 meta_left);
> > > > +             if (var_meta_size < 0)
> > > > +                     return var_meta_size;
> > > >       }
> > > >
> > > > -     var_meta_size =3D btf_type_ops(t)->check_meta(env, t, meta_le=
ft);
> > > > -     if (var_meta_size < 0)
> > > > -             return var_meta_size;
> > > > -
> > > >       meta_left -=3D var_meta_size;
> > >
> > > It appears that a smaller change here would achieve same results:
> > >
> > >     -        if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX ||
> > >     +        u32 layout_kind_max =3D env->btf->hdr.kind_layout_len / =
sizeof(struct btf_kind_layout);
> > >     +        if (BTF_INFO_KIND(t->info) > layout_kind_max ||
> > >                  BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_UNKN) {
> > >                      btf_verifier_log(env, "[%u] Invalid kind:%u",
> > >                                       env->log_type_id, BTF_INFO_KIND=
(t->info));
> > >                      return -EINVAL;
> > >              }
> > >
> > >     +        if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX) {
> > >     +                btf_verifier_log(env, "[%u] unknown but required=
 kind %u",
> > >     +                                 env->log_type_id,
> > >     +                                 BTF_INFO_KIND(t->info));

hm... did you mean to have return -EINVAL here? Then it wouldn't let
through anything that's not known to verifier.

> > >     +        }
> > >     +
> > >              if (!btf_name_offset_valid(env->btf, t->name_off)) {
> > >                      btf_verifier_log(env, "[%u] Invalid name_offset:=
%u",
> > >                                       env->log_type_id, t->name_off);
> > >
> > > wdyt?
> > >
> > > But tbh, the "unknown but required kind" message seems unnecessary,
> > >
> >
> > Hm.. Do I understand that this patch will actually allow uploading BTF
> > with some kinds that are unknown to the kernel? I don't think we
> > should allow this. If the kernel sees a kind that it knows nothing
> > about, it should reject the BTF. libbpf will sanitize such BTF so that
> > the host kernel never sees unknown/unsupported BTF kind.
> >
> > I think doing layout info validation is a good thing, I'd keep it, but
> > having layout information is not a substitute for kernel knowing full
> > semantics of the kind. Let's not relax kernel-side validation for BTF.
>
> I don't think this patch relaxes anything.

See above, I got confused by your proposed refactoring that does
change the behavior (probably missed that return -EINVAL, though).

> It just generates a different error message for kinds that are unknown
> to kernel and:
> - described in the layout info
> - not described in the layout info.
> (Personally, I don't think that this differentiation is necessary).

agreed, there is little point. It's just an unknown kind to the kernel

>
> Otherwise the patch does basic sanity checks for layout section itself.
