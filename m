Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2523D7D83
	for <dwarves@vger.kernel.org>; Fri, 27 Feb 2026 23:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772233900; cv=pass; b=pC42JGfhpthEOydFveURhbkj9VtCiwXfF8kVGTK8eweKq7NULbwi4qXfMgCZ1E8/Id39LiO7luMsfibl1lhXOQhUwg9BxJiFTty4nCySCk/OzaFOpPp20rE5vnIsutyt5dwiv9U7ImLw+GXvOlzkOiw5T9sRK/ZrC1NXZnprWp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772233900; c=relaxed/simple;
	bh=ZJtIL/YuAAUbmVjuxoDUXEYCDVNpG+0hh59tvVeMMCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ly2JaHq/2QjH84iDoYH87AakQ3dK17lph1QJFW6tRTS54dQLDAfuu+zjCN/x6/fJmMgWrIVjo0cxL7V1JXLIWs4nifIDytFUIYVlivepVXT+4dGxdlmRgOHEDDhZnFFUwy8AGLeMjmCEdzQcm2mx0icYKuimYWrowZBWFlfOl6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6Qwx5Dy; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6Qwx5Dy"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4398dd671daso2796934f8f.0
        for <dwarves@vger.kernel.org>; Fri, 27 Feb 2026 15:11:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772233896; cv=none;
        d=google.com; s=arc-20240605;
        b=Fai/AlfDUvNFFJlfNdwbGBUjDSu0FN2yxE+fXhTCihftKaGj8ovkbsUHRS+c5ipnMv
         u1oojYjJHv+TI6Sl43UnNh0o2Jp5OTP+rZrZRuMeDO7CR/QjyS8FCLkyFHatHCzCA3r+
         zFZCilQzhKosyQHOYdYVdUfJIDnVSxIMAgF/PJggC6onYclVy8ZN5T6jLzyVJUGlK10L
         +fB7gV8wglxJju5PANJkNiILhOQ5NZtU7WQiA3kDkEI9QD+hdvK5ebzaTwrjBrTUY0AF
         xLL6FCAYUhE0LkUKUs+NZst2+8RvSJftccITJpZT5V+XEe1kfi+U5yA71gC9v2NnBEIp
         1nNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gzA6xhht+8ueih1UIwxBkikWdTm9mNoQ6gN29hqEPNE=;
        fh=yOGhWl6L7WMBmUWnxatyLgoL7610xgk+sqgyqddy/FU=;
        b=ZlIwobmdenqiEIYUANaNhqel8LEf41yVzaUqEXSlSiiUYW+I5/Y2QjiKrtQfjq3NIA
         K/UJQMH6pERpbbvgOuNa8k3Ve8MQ3T4cbXRXaZqlo008jtm1kzYS1xwZ4mtN0iikI0wV
         MBp/PAawzSGJb436Dizl+ovYE9HdXQYkZQMCoVuVHhrxiRidakw4ONCWtCy2kUng/tNi
         GMzssmBMR+lzUfcfLV8IEYYcTO/SB1QWmo1CC+cQlmVOuvxcJiKbb6v7yTmSsWLtp1Qg
         WkkzxLmPTvt32V+tBFKw9WUbBESq2s5H5zygsSUQ/1esfyxNEV4M39oCDseet3ErkddD
         AQ5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772233896; x=1772838696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzA6xhht+8ueih1UIwxBkikWdTm9mNoQ6gN29hqEPNE=;
        b=g6Qwx5DyJHD0rjqIef7ToBRWMpl4y5qjJ8PrUgxzXm4UQrqxfvqlyq2bpXvfmROI/Z
         +Mv+ZFbBz6ssrAJSC7RjAhZVsp1vlMIf07tmnUXr7vvHMUjAONw/nD2oAwSwx4zLjLCH
         Fu6TkyS26hl0AGwiJWth14+1VhyWgIMaiooptGEtGMBffK7YpwKVJh86tr40+XDbeEFs
         938ffjOEHCP+eDKeIo/UMKgGKPmq7U2/ekTlWlabTki7HIWy21y6yjCtxtDqETx6IHGo
         LBCpo1ueA84q8SteUsHHbEOqj9NvtxRca1XL2byTo0/rp6aPuHACmk17Sa1nW1VvTn+C
         fBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772233896; x=1772838696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gzA6xhht+8ueih1UIwxBkikWdTm9mNoQ6gN29hqEPNE=;
        b=jfbXXe1puTk0KLxMxUzGVcNCyb+pOMdRJFJ2rVb87tAVXfRVYmEsm8+em7Gb64WDtZ
         5zsrAyMFHc9TJy5f2a7o8Whk5oKkfkKo05iPJQMAOmTwi52+oDC1X4ION+iQLAinseM5
         vx/6qTBzc2BeM6dw/mAWSCJ8jZOVd0cqLX+fAIOmdYS0IsCd/YdaMbtJLPaOyVJSa8F7
         TbVcMa3VMHD2gr4yE5y3vanXn6IO64FzsOE/3U7Bkj08ttPgzpIpOq8b5KI4gPyflVuC
         F9kkiCMum68eLva/pxcOXTn7Y4QYkbpzvymuFrW23IZFLebuJwFez6bBOupmxUEl16zD
         0lWg==
X-Forwarded-Encrypted: i=1; AJvYcCWKyzjs/txbOMIBUbbCt/GNS3LRdRYdcMoa6OM/kGuiqd57WZF9HbWfoVTJNAGeR5RsI28yrpJg@vger.kernel.org
X-Gm-Message-State: AOJu0YwaZwrZRDPRTSbaRBb8dIw0f2uNleE5EryL0UxC5apmmdO2hEBe
	e5oxunNQqWO7Nw5h78CRPxjUh6bXchUCKPgMj5qfIp04fhxnCKrq9DhAvK6wDEz+jLrx6M2AYBN
	6LDDSgkeCrx7bemY00UniWHYXRjk8kqw=
X-Gm-Gg: ATEYQzw6iTQvvHZy02rTi5dHVwmRdRhB6TRnH0GGJ64diNKTnXburFWqaJjj71Y3hx2
	wZyIcByFCp7p8SPpRn/wSHGENGTwPVqMxDYA/ZO3rGfjzQx4rDoLEFQB9g6jqqySLrD4nbcZVnn
	Q5+S2QTDUmsfbW+kciyPsHqh/fKQl6nDh53RHXa1B0dU4p0TxNQ9XucCHsjKQVvKL7QDEo2X0xf
	wxNHYyfrLLbkZQWDlv85DNe+imVWYrx8/vb31mUPL1LRtuIGOCTelWy8ceJ4w4OWRaOYFkJ9XWc
	gDBbyIsZU40CVSAlJc2aNHSAM+fM+lNnJVd0REUKomRzBk/Nom40gUrpcx5ZP1VRy1YLzTEXVAS
	oxHXQWMvjhMbjM6CiO9djaiFQug==
X-Received: by 2002:a5d:64c4:0:b0:439:9564:4dda with SMTP id
 ffacd0b85a97d-4399de15292mr8596463f8f.23.1772233895745; Fri, 27 Feb 2026
 15:11:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227100426.2585191-3-alan.maguire@oracle.com> <4b1bf31957861b05ae30b2e2380890f820604cb8fcd7f0414ba706e25a8d54ed@mail.kernel.org>
In-Reply-To: <4b1bf31957861b05ae30b2e2380890f820604cb8fcd7f0414ba706e25a8d54ed@mail.kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 27 Feb 2026 15:11:24 -0800
X-Gm-Features: AaiRm51y9rA2RS_cWTzMeltHg1l6Igh3OVovGeqLX7TgUboY5BPlWdShdPJKXKg
Message-ID: <CAADnVQJ_-6n-coJ2=bWRfBUfvK0m5QPcqjnW1vZjqau4aLy8+A@mail.gmail.com>
Subject: Re: [PATCH v10 bpf-next 02/10] libbpf: Support layout section
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

On Fri, Feb 27, 2026 at 2:52=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 83fe79ffcb8f..7b58724a90a2 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
>
> [ ... ]
>
> >  static int btf_parse_hdr(struct btf *btf)
> >  {
> > -     struct btf_header *hdr =3D btf->hdr;
> > +     struct btf_header *hdr =3D btf->raw_data;
> > +     __u32 hdr_len =3D hdr->hdr_len;
> >       __u32 meta_left;
> >
> > -     if (btf->raw_size < sizeof(struct btf_header)) {
> > +     if (btf->raw_size < offsetofend(struct btf_header, str_len)) {
> >               pr_debug("BTF header not found\n");
> >               return -EINVAL;
> >       }
>
> Could the read of hdr->hdr_len at offset 4 above be an out-of-bounds
> access when raw_size is less than 8?
>
> The previous code set hdr as a pointer without dereferencing it, then
> checked raw_size before accessing any header fields.  The new code
> reads hdr->hdr_len before the raw_size check.
>
> btf_new() calls btf_parse_hdr() with whatever size the caller provided
> via btf__new() or btf_parse_elf(), so small or corrupt input could
> reach here.  On the mmap path the data could sit at a page boundary
> where offset 4 would fault.
>
> Moving the initialization of hdr_len to after the size check would
> restore the pre-patch safety:
>
>     struct btf_header *hdr =3D btf->raw_data;
>     __u32 hdr_len;
>     __u32 meta_left;
>
>     if (btf->raw_size < offsetofend(struct btf_header, str_len)) {
>         ...
>     }
>
>     hdr_len =3D hdr->hdr_len;

bot is correct.
Let's avoid potential oob read.
