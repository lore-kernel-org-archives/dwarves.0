Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEA023A98E
	for <dwarves@vger.kernel.org>; Wed, 18 Mar 2026 14:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773845547; cv=pass; b=agLNUJ2fwtN/qDl4V/tNr+t6m3DEbn4Y24V+UKHr07UXUXypGtAzhzmRgkxdLdCtOEcnhUAyKpoYmV6KuRCpp+lvKsY60JvaPihWLAb+yfwSef1pf5spjzZ5Cp9ks9jY7mcPFviJefKVu5K3gH5ewRGo9SCscxIjqpVQzQSrf6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773845547; c=relaxed/simple;
	bh=dtyJmL3ulsB2K04/QRakWuL0ygWl35EGvRyAQ+/kAD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dgUjFL5mJm/CLfWFLP6f9HtHE/EHQZZho3EIc0Rbmwpi9USMPDy9dGJPSMn/m358HXrm/nAY54RbpS7kPyKZHjSqfU6XOgTC6khBt12EVmxDmW6OxGcUj5OA/jXqJWzTTpT6TD5HtUndN1kial3Q+ELDprDpUIYHy0oOlVV7oio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGMhJxpQ; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGMhJxpQ"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439b94a19fdso6385725f8f.0
        for <dwarves@vger.kernel.org>; Wed, 18 Mar 2026 07:52:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773845544; cv=none;
        d=google.com; s=arc-20240605;
        b=iYPx8CEELDeEVA9ONyx0M9hCPp1N4/BjrPXtrclAOeoPU00uXKSPDyGztJSDSor4iz
         witLG1S5e1OxL1fCqpMeSmQxm17xalqcpNPtxViE0Ho4mBdcqqIByCmqJmMhsE7fj4qx
         Vj0lC195h3d2el69Otn1RUn13uHX3fRKA5bBlxLUwIsQO0gEs3s5O2QgVKMOKKjhYE9J
         weKdYStgdUtHb8jTYfUTQn49J8RNSfbw3cS68ASxNH70KTtxlxW1g/fz60/PUW5D5OuM
         LUTj/Sas4RlbABj95n9b2qPkXg37KVDv9m2FbyTSz1IQhSqzsbtmr06Sk3Q0x86zK2w+
         7Dew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HB+gA6ByzyLBH19NIOmS8rvUbE+H9OzxCLxj0msP9ro=;
        fh=Fj7gxFfe8lWo5AD9dj3NIEAF6P4zieVFxwTUhTkGeS0=;
        b=gps4T2jlluEWmoI01iv1ZjtjHzAz9pKc6KY0P270wId0g/Yp2ARN2dzF1o8TgRoP0V
         4dMv1kDLiz4ap2oaN+m74z6Sl7OSevioCWK8DXzrSDhutsRlYRzbcoFUYteTqm+423Ho
         zFUYcQwObf/gGd4vo0/BF8vLtX8OuH8Hi992J3lEA7P6Ba/7vrlnUNb1WwTE2HyccjlK
         UPdwcvuUWuNUFbKJOpscRqOhmnlQCbsgMx9Iy2SdbiJmAVe8xuDD6CR3JwNNpiFwaPVQ
         QYhHScJ52kvPH874EeezXLSFZ3VDe1b/quWIJCFWp5JqfhMYx5p5r1IRBZy3M3vYaHzJ
         raTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773845544; x=1774450344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HB+gA6ByzyLBH19NIOmS8rvUbE+H9OzxCLxj0msP9ro=;
        b=gGMhJxpQgnlIwW44l95K4TzJwhfCKyjEJbBYLtnr67gy2sEM7JfKVi0+hT7tT/mHFj
         b2pdtelWYDkpybDImY+hnYn5SQD1MtN6F3ozU88p8bpSyvFs/nqHJbARP3zeuIvUzGo8
         7e6xGvoLKNWj+ZlBesbhLtZSR18Lr2FkT9GtdvjrfoK1aoFTkTezbWF51qQ0EsSwVy7W
         uULqFbLcLtbQ9UxpFoLEc5dZ1dR0/JCEolX4LUSO6j2DMsu64mzdJjq3saRq9Z8AleZW
         nN1aNW39hgqC8tVqU46+BEG0mCou5HdILi9PmElFwVYruTYNQn4i5aUDzgeb+fvxxqx9
         xToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773845544; x=1774450344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HB+gA6ByzyLBH19NIOmS8rvUbE+H9OzxCLxj0msP9ro=;
        b=N3LYCPieatW7U4LIZiPUNBDqUDpaIlUkECzpLbNIYZzqG2mmIcft0/rGx3Zeu2IxP1
         GN36cI/+EwcHSVORdCaae41NpKqvNv+E8koncB7Ijgl8oOqtQ2EUN40v4wZjopN4HVBB
         h9gJQv2glsTH4VUAdxyaBL6RAu3HfGv3r9a1MXnbB1A/EzwzyYIyZdLgHfxXDptOj6lL
         8FD2Dokf+rjOd4L1CowCyX1+XcYJMkQEzVYNLcl/PWcLX34SXgiR+J6AVTh57Hb6iXnv
         iWRk0MB4xRc05NdRkMaafT9Eyl7ShtqN2/ijbEl+1/20qrkUfEqDUpcyS0BAzLmvhWc8
         XbZw==
X-Forwarded-Encrypted: i=1; AJvYcCV0Ou1pOm6Sxv8xIjQ44v/yJTIf6EiH+2uOH2w+/7ugSmR5TJRr1CjLaaz1ptfszvyKJvonzKoo@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4RnYKvGXnWQPlUmoTthO9N9lZnWufrYSM8oXhiLGYcJFda45/
	+a5RgXATWSSXZ8qx/d5pEKFkRkvaZ7ocUpRYaUa+YzfN1sJMl7weWPuUqF5P8NqeJFHfMTe8WvA
	DaWVldHOl+Y7sH76WpoC62QwYv7D+u7A=
X-Gm-Gg: ATEYQzwuVvRSI2N1/37uHFduDPBdQzN0rCQJMLBXJNrdsuY7oFctR/wEY/cy5ej8q2M
	PmbVcPCx03Rb9ni7dUR+q6VxhlX4uaF6IysPSUmvhYg4Orn+EC6YjZrAj2AU56dccy+jwRu4j+t
	DFEN4EimnOA6GopHUKZij6Br10B1k9Al8J522/nA1X+QOTC82cYQ8k3aXuzWXGBPVZPtD4/NAwS
	RrG84WC7jg3n7FMnSXGcdR7ExqHzQlpfCKMEYZqu/jkX6Wnndb3iUnGaZTQfYuK1gxnz9d3TY/c
	1iWwryPrgyHTAYmbG41iCbJPgOmz6l1xY37QCWBIFEW23nPpyndEx4dVMB2uHEZF8CdsITK+bp1
	a8v9HNOToPWNET1odMGo09C1eFm3Z6YBZO1Y/
X-Received: by 2002:a5d:64c3:0:b0:43b:47bc:c147 with SMTP id
 ffacd0b85a97d-43b527cc553mr6436462f8f.45.1773845544085; Wed, 18 Mar 2026
 07:52:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318132927.1142388-3-alan.maguire@oracle.com> <9bb62dd69d27eaaf36db9036240de0354722c839121572557dd161a2511c6a43@mail.kernel.org>
In-Reply-To: <9bb62dd69d27eaaf36db9036240de0354722c839121572557dd161a2511c6a43@mail.kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 18 Mar 2026 07:52:11 -0700
X-Gm-Features: AaiRm511EkeR7kwtmpLnyNHAISj-DqX9kUUsztIj5ywykAPSEKhNpeIJbJ-NsWc
Message-ID: <CAADnVQJEn3FXsSv6XJbCkhPuiJQzb8w35NteyGdsz3p=fu4Myw@mail.gmail.com>
Subject: Re: [PATCH v14 bpf-next 02/10] libbpf: Support layout section
 handling in BTF
To: bot+bpf-ci@kernel.org
Cc: Alan Maguire <alan.maguire@oracle.com>, Andrii Nakryiko <andrii@kernel.org>, 
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

On Wed, Mar 18, 2026 at 7:45=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 40becc9643688..37a3b317cb2f4 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
>
> [ ... ]
>
> > -static void btf_bswap_hdr(struct btf_header *h)
> > +static void btf_bswap_hdr(struct btf_header *h, __u32 hdr_len)
> >  {
> >       h->magic =3D bswap_16(h->magic);
> >       h->hdr_len =3D bswap_32(h->hdr_len);
> > @@ -224,66 +246,113 @@ static void btf_bswap_hdr(struct btf_header *h)
> >       h->type_len =3D bswap_32(h->type_len);
> >       h->str_off =3D bswap_32(h->str_off);
> >       h->str_len =3D bswap_32(h->str_len);
> > +     /* May be operating on raw data with hdr_len that does not includ=
e below fields */
> > +     if (hdr_len >=3D sizeof(struct btf_header)) {
> > +             h->layout_off =3D bswap_32(h->layout_off);
> > +             h->layout_len =3D bswap_32(h->layout_len);
> > +     }
> >  }
> >
> >  static int btf_parse_hdr(struct btf *btf)
> >  {
> > -     struct btf_header *hdr =3D btf->hdr;
> > -     __u32 meta_left;
> > +     struct btf_header *hdr =3D btf->raw_data;
> > +     __u32 hdr_len, meta_left;
> >
> > -     if (btf->raw_size < sizeof(struct btf_header)) {
> > +     if (btf->raw_size < offsetofend(struct btf_header, str_len)) {
> >               pr_debug("BTF header not found\n");
> >               return -EINVAL;
> >       }
> >
> > +     hdr_len =3D hdr->hdr_len;
> > +
> >       if (hdr->magic =3D=3D bswap_16(BTF_MAGIC)) {
> >               btf->swapped_endian =3D true;
> > -             if (bswap_32(hdr->hdr_len) !=3D sizeof(struct btf_header)=
) {
> > +             hdr_len =3D bswap_32(hdr->hdr_len);
> > +             if (hdr_len < offsetofend(struct btf_header, str_len)) {
> >                       pr_warn("Can't load BTF with non-native endiannes=
s due to unsupported header length %u\n",
> > -                             bswap_32(hdr->hdr_len));
> > +                             hdr_len);
> >                       return -ENOTSUP;
> >               }
> > -             btf_bswap_hdr(hdr);
> > +             btf_bswap_hdr(hdr, hdr_len);
>
> Could btf_bswap_hdr() access memory beyond the raw_data buffer here?

Alan,

before you respin please look through other bugs that gemini found:
https://sashiko.dev/#/patchset/20260318132927.1142388-1-alan.maguire%40orac=
le.com

pw-bot: cr
