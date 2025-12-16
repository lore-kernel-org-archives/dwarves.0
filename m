Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB8424A058
	for <dwarves@vger.kernel.org>; Tue, 16 Dec 2025 21:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765920076; cv=none; b=UmEu1N0Y7TGZdA1bO3adYMpea63eG67SYlwcrSpVbM1IdQcMOAYOY5bLJRKQHRdAul6ButXy723nZVt29nQpB1uZTZiBA+LKcjLXplvfhrapyTGcn/WLZ2FX1OGi7tQkC/G8f7SC3BznY5OcTSG2Y17HonlRD2LJA6f8E2eQXmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765920076; c=relaxed/simple;
	bh=v95pH7bJavW1yy0EbAc0eMNauC38Nug89wS17zz4aTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQVXstE50/6wXafJuRVIi3Xdp39pth93GnqfhVkyWor1ss6CMYG2eOk+gkjNWBgoOabMpFoQ++4fsk8+5lHZB5b0hTKtEsovQNQNaRPtj7BM6WrDLrzRukOuV5Gtbx2CafXJnLWMjHyFECX5LEZyKMQ1mZctAFQIe4piKSUu87c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUZXKB+3; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUZXKB+3"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29f102b013fso61961725ad.2
        for <dwarves@vger.kernel.org>; Tue, 16 Dec 2025 13:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765920074; x=1766524874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4d6xbGDlPMkC8s0TB0glzVoxYsLUnwcjK38/9AA8CQ=;
        b=IUZXKB+3QrVUHYF83j8Z+1Gg2OIUodNA+U0dh5yuaDbwUrokfdAgIRwMzIb9wk4Xw5
         dh99SAJ+i63KmjUAR5hX5sEHRTirCjPAi37vdTlG/NDIei2YMloy3DuMkykqc9b/9Mus
         r6drbVU12JvI2Zp9fP2leqpnUAs5ZzeGbj6J/6bIQNTJq23hc+v5jpeoKJ8KezmEJo+r
         v/CPO3H8lEnWs46d0g6aFCd284rkSzZGyfuDbmDf5jzYc1P/AAipgYOhX07Vd9oBZ5B+
         FxI18tO87V+yH0+P+S2CF2uP/SKL1BsbcPGdFhbKKYdvzY1L7g0Obw2/KakDnvcofAsT
         EP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765920074; x=1766524874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+4d6xbGDlPMkC8s0TB0glzVoxYsLUnwcjK38/9AA8CQ=;
        b=OE5X14jBYv7ymVl98xTPfJIWxBBDVrDfO971uZyopFJBaM6KBF9HrijR9HacKHQ+rv
         QEJUQlCyI5pIPEddsa86wN1/nE/z8k3rlU9stzKsOEOzY5USSkL3Yho7xifHO8d06TcN
         wj3S1fAQ6MrBRlSXjjMP/VBUS/k2UrspLZwg3pnI+wQ5G5o/nZLxJuLQkz2shNPSg4rd
         0N0Tcq16f1aBxZ9hyYycz5AouPkVJi2CHLWFRFnK7mRWSPO+gxpwOKoQ/0HKVUrO0rxL
         vo5Ft8ttiaUSgt9px58gJHs+KXvr5jn31hUC5FH56J21b5QFeSYu6TKFNmeXeZWvF8on
         fMEA==
X-Forwarded-Encrypted: i=1; AJvYcCUm5lP2hn31IJEMRY46H0sXRj22XK0jIcJpFaLkxTi00Qjv43WlcYBIX10pjC12HqmmPzjK6JY+@vger.kernel.org
X-Gm-Message-State: AOJu0Yys8NTSgpiouhHuvi0X7t7uTf9ssJ8atf56KJfuvHCu7KiTM6bS
	+wp1pqbEAiavkS0BYYhzF/HzNaRTKwyV797W/I1pL+H3F7DDu7B2sG0gpUGoJDqGOkVSHnx4SdO
	DZ9L7w1bn1BGG6sB/kZUrLLKzmtf7bnk=
X-Gm-Gg: AY/fxX6pWOMPcR7Sp6DqHpiYsr4mJ3N5B9GVqjamaz3q84pNttqBNqgLytnZfed3FHY
	liWKdIHgIN2wCEqvNLrAU5vhcV96RnU8A0Am9vGFwZkFG5Qtn3kghWriVoNynLuKaXW/7rVwCZ/
	NVcrBLQGiw/5ejOAc7UpZlHEd+OYUcnCCQW3mpJCnEQh6FT3cJwQ0bBVWJnkH2qskP49YN2/NlR
	NLj5LGn12p3DPspwkcFlE1KgIwTZtqD9TCIG/XOZsf8kThFDcDwfGcd0/W7qOEgA2M7khLYEIip
	cNXS1TpW/Zsfpc0d3aFswA==
X-Google-Smtp-Source: AGHT+IFoep0oLAG/nrLykz8n/8DsH0Rf9tEOMC+sONrcMBfUHwvXvS37ChpiBO4Oe8k8+8D0XWXWjiRrSp2eid8sHfY=
X-Received: by 2002:a17:902:f68e:b0:2a0:9081:8a6 with SMTP id
 d9443c01a7336-2a090810c7dmr138597295ad.20.1765920073876; Tue, 16 Dec 2025
 13:21:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
 <20251215091730.1188790-7-alan.maguire@oracle.com> <1351a3a944fab86e7fe1babf8b31cde4e722077e.camel@gmail.com>
In-Reply-To: <1351a3a944fab86e7fe1babf8b31cde4e722077e.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 16 Dec 2025 13:21:01 -0800
X-Gm-Features: AQt7F2peW1lUI3AxV_2-Ru6CuffwHUb37ImNsAwgjVE87BodZ29bK-HPti6ZDIw
Message-ID: <CAEf4BzbgjZfxUeB78D4u4LRzESsTSdzOgFJAkOqEoQcRWuS=2g@mail.gmail.com>
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

On Mon, Dec 15, 2025 at 10:51=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Mon, 2025-12-15 at 09:17 +0000, Alan Maguire wrote:
>
> If strict kind layout checks are the goal, would it make sense to
> check sizes declared in kind_layout for known types?
>
> [...]
>
> > @@ -5215,23 +5216,36 @@ static s32 btf_check_meta(struct btf_verifier_e=
nv *env,
> >               return -EINVAL;
> >       }
> >
> > -     if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX ||
> > -         BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_UNKN) {
> > +     if (!btf_name_offset_valid(env->btf, t->name_off)) {
> > +             btf_verifier_log(env, "[%u] Invalid name_offset:%u",
> > +                              env->log_type_id, t->name_off);
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_UNKN) {
> >               btf_verifier_log(env, "[%u] Invalid kind:%u",
> >                                env->log_type_id, BTF_INFO_KIND(t->info)=
);
> >               return -EINVAL;
> >       }
> >
> > -     if (!btf_name_offset_valid(env->btf, t->name_off)) {
> > -             btf_verifier_log(env, "[%u] Invalid name_offset:%u",
> > -                              env->log_type_id, t->name_off);
> > +     if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX && env->btf->kind_layou=
t &&
> > +         ((BTF_INFO_KIND(t->info) + 1) * sizeof(struct btf_kind_layout=
)) <
> > +          env->btf->hdr.kind_layout_len) {
> > +             btf_verifier_log(env, "[%u] unknown but required kind %u"=
,
> > +                              env->log_type_id,
> > +                              BTF_INFO_KIND(t->info));
> >               return -EINVAL;
> > +     } else {
> > +             if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX) {
> > +                     btf_verifier_log(env, "[%u] Invalid kind:%u",
> > +                                      env->log_type_id, BTF_INFO_KIND(=
t->info));
> > +                     return -EINVAL;
> > +             }
> > +             var_meta_size =3D btf_type_ops(t)->check_meta(env, t, met=
a_left);
> > +             if (var_meta_size < 0)
> > +                     return var_meta_size;
> >       }
> >
> > -     var_meta_size =3D btf_type_ops(t)->check_meta(env, t, meta_left);
> > -     if (var_meta_size < 0)
> > -             return var_meta_size;
> > -
> >       meta_left -=3D var_meta_size;
>
> It appears that a smaller change here would achieve same results:
>
>     -        if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX ||
>     +        u32 layout_kind_max =3D env->btf->hdr.kind_layout_len / size=
of(struct btf_kind_layout);
>     +        if (BTF_INFO_KIND(t->info) > layout_kind_max ||
>                  BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_UNKN) {
>                      btf_verifier_log(env, "[%u] Invalid kind:%u",
>                                       env->log_type_id, BTF_INFO_KIND(t->=
info));
>                      return -EINVAL;
>              }
>
>     +        if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX) {
>     +                btf_verifier_log(env, "[%u] unknown but required kin=
d %u",
>     +                                 env->log_type_id,
>     +                                 BTF_INFO_KIND(t->info));
>     +        }
>     +
>              if (!btf_name_offset_valid(env->btf, t->name_off)) {
>                      btf_verifier_log(env, "[%u] Invalid name_offset:%u",
>                                       env->log_type_id, t->name_off);
>
> wdyt?
>
> But tbh, the "unknown but required kind" message seems unnecessary,
>

Hm.. Do I understand that this patch will actually allow uploading BTF
with some kinds that are unknown to the kernel? I don't think we
should allow this. If the kernel sees a kind that it knows nothing
about, it should reject the BTF. libbpf will sanitize such BTF so that
the host kernel never sees unknown/unsupported BTF kind.

I think doing layout info validation is a good thing, I'd keep it, but
having layout information is not a substitute for kernel knowing full
semantics of the kind. Let's not relax kernel-side validation for BTF.

> >
> >       return saved_meta_left - meta_left;
> > @@ -5405,7 +5419,8 @@ static int btf_parse_str_sec(struct btf_verifier_=
env *env)
> >       start =3D btf->nohdr_data + hdr->str_off;
> >       end =3D start + hdr->str_len;
> >
> > -     if (end !=3D btf->data + btf->data_size) {
> > +     if (hdr->hdr_len < sizeof(struct btf_header) &&
> > +         end !=3D btf->data + btf->data_size) {
>
> Given that btf_check_sec_info() checks for overlap and total size,
> is this check needed at all?
>
> >               btf_verifier_log(env, "String section is not at the end")=
;
> >               return -EINVAL;
> >       }
>
> [...]
