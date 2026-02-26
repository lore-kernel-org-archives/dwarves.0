Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED196428472
	for <dwarves@vger.kernel.org>; Thu, 26 Feb 2026 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772123687; cv=pass; b=MBexFibngpsfldc4Ttq4Pvwa1wnQixSdhLlFmq1QePCRPuIutMEDDzxRTTHM3EkSHQIvW9WiB3bLTKbv0cHZ18eXcuLV5hsrLgwDOvA6zEWqfedbV1OKlD0O+/z+bw2xdwu+5MO67fFP+xyt9PxaP8dRg1i1umtkWPqkKa5OAUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772123687; c=relaxed/simple;
	bh=vjzTRvbWQqht790Rr00MYPk2OTbL82V6UIMNHq5W4T4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CS0NHYsWWQb3J7F0gRY2DmJ1xmyQdCinezwgdxiBDt770RBsUsBodlLULOYc5IZfYzY60VpGDx0YhQbXnYU4x1cMAWoyzt2tXKiKu9j+Mib3JRH1BMdyoEsTb9MzFBZrXBy/c3SDMTZ4A4dBNSbtYw5sX1Y29FMQ80McZFuzNU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+9wmOSV; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+9wmOSV"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439857ec679so938655f8f.2
        for <dwarves@vger.kernel.org>; Thu, 26 Feb 2026 08:34:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772123684; cv=none;
        d=google.com; s=arc-20240605;
        b=eJZ9KGIkuTjnk/Ey8ssVPUS7jAzLJO+BUB7aAZgZr7TFgaDfz/f/54XXCIqtL/rQXf
         jYYfw7dq6k6X97ph1nB85p553QIu8alhcRxQot4LP5gEWXjWy8X0Vzg0GaM8IrgjSZ4B
         Uv2XiZBfl9alvziKGfIwSt5awzlhIcDkQb5aHTigA8ci/ABrnwUSeoOGO1iSdiEkz25e
         YzhFU1gY32/hfXi7upytTPSDBvaR/4OygzvPMjg/9PuNpCwNU6uMSAhgwcUBi7K/ZgWz
         D8nJMFfeSfAD0cnBuFtP3vJU7SFhp8NegbRXzvATKdb1OP/F7q1XMk5DcuPw4HuKonh6
         MLKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nvW79o6Js6hFr7ZOr2szBhITqmlzECLaruyg3s/bQn8=;
        fh=dHQ7Y9xZsQzcTQ4ku6ExccqIT+sHKkDRnzFX5Eu73ZM=;
        b=XvIHoqDgE4SRmVIy6Jrg59nd7o6EwkVuR7Qq0Y/QJ9FBOoqzB1hwdOcVLEKm9q49yG
         +l7mnbpY+YBWZ4bHklIuix8TvFhNv9Npaa21bURKrGRMmwrfsEcMtvu0OCVbc+0rZVM2
         DyGg09AcmPfKgnfJrJOyPoja0z5zWFbApwXwJjdpDNBGKgBekrZu2Lwc2O6RwQauU+A7
         Du6jBzRhKy7YH6FIetbCXHCDnuIEq9PtLsZcxKPzMOry0DBAKptoOo2Irf6cM1bL67a3
         A486XjG/3dbwf42bL/A331JMYDefpomMISmHyKWAqAjhh7/byxQQh9/OP5LA7u9Kvrg/
         tuLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772123684; x=1772728484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvW79o6Js6hFr7ZOr2szBhITqmlzECLaruyg3s/bQn8=;
        b=b+9wmOSVyeoZK70Okx3TzX+fyP+lHSrAn3MSI8HUcEigNpc85TG+jzCIh8C2b6jSwI
         e6ljEKGycuqatVXkezoGM/ZTIpxUD7caJmybCMQHzvAD/DwsTBfwdsoD//W6f1iKpUi1
         amjBCKto8sck89K/tihXDXNxX1tBdRzuIt9UkCsL8xPiQbQvR8DlRYHqPgdKMAjFrYRF
         MazYolv6/kEQ5quCprPgHa86qvWWUFE22QDkDxTz7BWojUFSZICJdu/wTb9NEI9sL4X5
         Ow7BMopbeNUbECZEDEwny0zJvbNYKV1O7xtOz5PaBjckvu/fRxQmLzeVu6WBqM5TBHDt
         NMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772123684; x=1772728484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nvW79o6Js6hFr7ZOr2szBhITqmlzECLaruyg3s/bQn8=;
        b=goW/TDe8Rb96KLGsl+kcvHXhu0vdkCw92Hyxax6PhDtg7AEpzUpcykZ+QR8HHvbKH/
         wShA84WXyzqlXepM9L5vaRVhjOnzKK8xNjkGty5phoZgIUKNn5e96y1Ka1bu5Q8sJUil
         qj32SSwYivBEWq5IHXkLyYnqpYeiLG+BqJ+2E026UTdxj3lferMorxL2u1ZBLR4Zgb6o
         gKX/uIszCpACvUk4E7pznujlrUbaerrswOEks6ebDiO8vZi9FW9Ku0bo5tWiqRxsSSwD
         my8q5m0saDUPJH/s2+EWV2CcLd3zf/RTfdD+I/VjTiSREJDZUGZlkmtZdIELb9DnI27F
         RXkg==
X-Forwarded-Encrypted: i=1; AJvYcCXeOk1ZlkRrUYFCGgPezTBUXTSTdfiCQcrPHh8hmpiCjFcy/4S+UyJS/iULhbLYaFKUIcoLGceU@vger.kernel.org
X-Gm-Message-State: AOJu0YyeFCHkUipnBRO8eBNUvBQw2hyYUkEo7hp7NTltkah7JGf+NvVZ
	yZLYyCD6Tctln+YeUEuSqqse7u1Yn4x1dvn+R8udRteI5j3cEW1rbkObc10AcKfKttBemGzSvU7
	LN+G22J/402p2nrRVc33J9mB1kuCpSwE=
X-Gm-Gg: ATEYQzwmfREKRNv+r5+g6RnOZaDYcTBW/TSpeEjvqNb4EZqU2E3cO7CIEOPs6LCNtGy
	3yJbA59naZ7nIYYcw04SN1LiGFcUUZqWJSksLmlplPtTM2M2r8718kPwYH8at5zyFOMv16ZphaQ
	eADsVG6p5REd2jOMavTxepghZ5B+1uRGbdS/+d3m9w4patE4yi7lXzKKDHqBr6C4CEyVOecom76
	DWI13v5etImwOppsz3h2neJrCZ1S3+xHe7Pc2W0Pa4S99pD750aooiYPCyEdqdm1a0g92iKrKOM
	mfiqIjqqjlbGIWjUauFC0YoA7CVUSjRdqP3YeMs8nqG3wSdXCE7Rx+470OtWxBIjUPPr/WjbA1N
	ZFx+o3ccC
X-Received: by 2002:a05:6000:2c04:b0:431:67d:53b3 with SMTP id
 ffacd0b85a97d-439942fb94fmr8689612f8f.43.1772123683957; Thu, 26 Feb 2026
 08:34:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226085624.1909682-7-alan.maguire@oracle.com>
 <dc1d9fb29ac2eba86b21fb85ad1bac9d096f0e9680ef87b42a86200120b5e7a1@mail.kernel.org>
 <de9dbe59-7adc-4e00-a0eb-7f5b3cb88ae9@oracle.com>
In-Reply-To: <de9dbe59-7adc-4e00-a0eb-7f5b3cb88ae9@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 26 Feb 2026 08:34:32 -0800
X-Gm-Features: AaiRm51BqeCxGmIqbkWDPMk4IBLWoIS1BCNZ0qmfHTlkbbNF_eOvASirMb2ntx8
Message-ID: <CAADnVQJOv7aayd1Awsfhwmiotkex_-ie+_H2agx55Ka954rbqA@mail.gmail.com>
Subject: Re: [PATCH v9 bpf-next 06/10] btf: support kernel parsing of BTF with
 layout info
To: Alan Maguire <alan.maguire@oracle.com>
Cc: bot+bpf-ci@kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Quentin Monnet <qmo@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	dwarves <dwarves@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 8:26=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 26/02/2026 10:05, bot+bpf-ci@kernel.org wrote:
> >> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> >> --- a/kernel/bpf/btf.c
> >> +++ b/kernel/bpf/btf.c
> >
> > [ ... ]
> >
> >> @@ -5327,23 +5328,36 @@ static s32 btf_check_meta(struct btf_verifier_=
env *env,
> >>              return -EINVAL;
> >>      }
> >>
> >> +    if (!btf_name_offset_valid(env->btf, t->name_off)) {
> >> +            btf_verifier_log(env, "[%u] Invalid name_offset:%u",
> >> +                             env->log_type_id, t->name_off);
> >> +            return -EINVAL;
> >> +    }
> >> +
> >> +    if (BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_UNKN) {
> >>              btf_verifier_log(env, "[%u] Invalid kind:%u",
> >>                               env->log_type_id, BTF_INFO_KIND(t->info)=
);
> >>              return -EINVAL;
> >>      }
> >>
> >> +    if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX && env->btf->layout &&
> >> +        ((BTF_INFO_KIND(t->info) + 1) * sizeof(struct btf_layout)) <
> >> +         env->btf->hdr.layout_len) {
> >                                        ^
> >
> > Should this be <=3D instead of < ?  If the layout section has exactly
> > N entries, layout_len is N * sizeof(struct btf_layout).  For the
> > last covered kind (K =3D N - 1), this computes:
> >
> >     (K + 1) * sizeof(struct btf_layout) =3D=3D layout_len
> >
> > With < that evaluates to false, so the last kind covered by the
> > layout section falls through to the else branch and gets logged as
> > "Invalid kind" instead of "unknown but required kind".
> >
> > The libbpf equivalent in btf_type_size_unknown() uses:
> >
> >     __u32 layout_kinds =3D btf->hdr.layout_len / sizeof(struct btf_layo=
ut);
> >     if (!l || kind >=3D layout_kinds) {
> >
> > which accepts the last entry.  Using <=3D here would match that
> > behavior.
> >
>
> looking at this again, is it worth making the distinction between a kind
> that's in the BTF layout but unknown to the kernel versus one that is
> not in the BTF layout and unknown to the kernel? In both cases we reject
> the BTF, and given that the kernel cannot be in the business of trusting
> the layout provided with that BTF it seems like it's a distinction withou=
t
> a practical difference.

"unknown but required kind" means that the kernel doesn't understand
the kind, but its layout is described in BTF?
If so the sentence is odd, since presence in kind_layout doesn't mean
it's actually used. Here the check is when the kind is parsed.
So the kernel should reject it with existing "invalid kind" message and
that's it. It doesn't matter whether the unknown kind was described
in the layout.

But at the same time if the kind layout describes some unknown kinds
it's not an error. I think it's fine to load such BTF since all used
kinds are known.
