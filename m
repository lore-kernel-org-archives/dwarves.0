Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D452D9798
	for <dwarves@vger.kernel.org>; Tue, 16 Dec 2025 23:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765926058; cv=none; b=PrSeg1vhGxIyM+gMZOn0w0+5jCZtuqcW7CoY11ALkRlqSFupwIcP6gg/+zsCHUSwyH0bCVCkaSAThz/Xppdfl/xeaV23++xujwQbLHkWE6HjoHqmVB2iTarMxmXGcE1NC1hINJ+7hN26RwY9QIJYmmcuaspvwQ8v2SSOphiU8x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765926058; c=relaxed/simple;
	bh=QHTn7Ape7PKJS+Dlk3JnqkbYmgLXPYQwVFt/xRLllLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tJx5EYnausOIWP7cxV4wc9qHeh0D1VK+zROlH/84JSgtRmDErQPpaTkGB+AYuDPKAkmCsx/gjotC5EGy4vpEnnTvePER6+tcgbP5RgbwcWFbBGef5DZSwl47mxFYYXYb8lpCI8/xNOlDbOPo4oHnle06Pm8I3g0O1SqHfRaBu4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObzHemgW; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObzHemgW"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-34c24f4dfb7so3273425a91.0
        for <dwarves@vger.kernel.org>; Tue, 16 Dec 2025 15:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765926056; x=1766530856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHTn7Ape7PKJS+Dlk3JnqkbYmgLXPYQwVFt/xRLllLE=;
        b=ObzHemgWzswGq7qTddeKOUejvN267ay6lMeQEGIqatKeVJct4Fk0ZlK0LZr1i+VSQy
         FzgKwIzbraD/RamwIc4GEBwyar2C9RjsE/h0y+Y1gNFAWyKLAuqhjOFshLh84TahUgM7
         R3Ydtyx1lLSsLexxF+pjg/gtGBs7jqp3YB691D9ttQci4NpdH3E7Yq6a+qbTQi6yFH7N
         jiUJbeKWBpwIxvIrA3GTHCCcOcfa/CNaSBj+ATYA9r0a4Fdr36WOj1yNFA20rFWcPFTA
         9GpTlBglAAHtOg8CnuWEdkLP5wzcqi5/rwyXxMy6Ngl/HFUbQX6gEMAOX5DF0hhkVpTL
         yZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765926056; x=1766530856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QHTn7Ape7PKJS+Dlk3JnqkbYmgLXPYQwVFt/xRLllLE=;
        b=YOmMJqiTIcCfT/uCcjjgcUwsXuWRgZDif15QzO+ME6pypXV92ZzV1Ea5CxGxGz88sD
         w6a5GiFo/SNFxbQNon9hq8zTy2OXQsJsq9sZWrcuSZ6Z/Th93Yq/TL9/b2QhzLPWyFOW
         NC4aI6/oXVADPeVAaKtkYfOD2wavGr8QxnNimOJWhvUA9OIuHIAQ3NQl/ZisnTTmutaB
         ovDCh6sqqosfdJLOSlWjo9qF6i0Zj+a5p42sj+8LAQMk0pK2MvtFWApMzU4oY5zOnIwJ
         XAjhe1QnIIpUHe4hKtzhzHTFz+HlGqI5QI/8cZ8QSP6qOnrEZ/CMiD2t38A0+dDmeJ2z
         Fi2A==
X-Forwarded-Encrypted: i=1; AJvYcCU5ylpiWxrsf1wnLCDLAoC+H4D9aWl/jXRHxw8kIwvEcDCTilVb1u730C0kKmLZnkZsodFAjRzS@vger.kernel.org
X-Gm-Message-State: AOJu0YzLYJxu8ECeQFPpL7UmBL7T6Hj0xCw4MphzvgIk/UBp2m61O3Hp
	uOUsgRRmfRtfJa+SiIqh6nvuejrmhM1pnZBa7sKoWji2SooV61GV2BdFHtVo3Cx0UxCyL95tgxw
	xKRax6o6nSBPJ86AYB4BBuU6ZLjAVX8g=
X-Gm-Gg: AY/fxX58zm//q6YisjVSlIVhgboIc3ZUft6lvlkOsrZKY8B0UAG7I8qMcWgc7JxZa/W
	PRi0JnwcUHnfAH/Ev+9xbdfpxiaAbJ3lu16fvLtVlVfWqHJG/LWWoUkkE014K7tFexgzADmsBK7
	kJ1J74RJ4mpPPGPVTcm7H/VurfkdQdb37y41yZvkC+Kg/clw8BiRB+AAoTWvR5sG8rLic9Rf5Fe
	Otb8sRE3F8gNrOPIsTwBh6lfmnzv14leuWnWD7bpVvX+LtZAq9/FOEmlV4o8h8HL4TnGWHeccHP
	kRVM0CU+V/0=
X-Google-Smtp-Source: AGHT+IE4uq1aQEKzYCRpxkzI2n9m1G5wgHi2swQD76/eh1lmF6mHDy3JTiLnZJgHQzPfsAOYyPWms/YOppfF7trvdBU=
X-Received: by 2002:a17:90b:258c:b0:34c:cb3c:f544 with SMTP id
 98e67ed59e1d1-34ccb3d0d0dmr4181586a91.14.1765926056210; Tue, 16 Dec 2025
 15:00:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
 <20251215091730.1188790-4-alan.maguire@oracle.com> <9e1b071598f9c1c1adcac0d8cb2591c452a675fd.camel@gmail.com>
 <6f3027ee-576d-45de-9795-9a8e620292e9@oracle.com> <CAEf4BzYQeiECx9UpDqv6zRjd1EPjw8B44YX3KPGR1Z4dFKi1UA@mail.gmail.com>
 <27e4a60100602f769f3c5410a398a75fe0151967.camel@gmail.com>
 <CAEf4BzayA6if0xcTLux=eyASM1kpARmrOdDRmgG9F1SFa-fEcg@mail.gmail.com>
 <26e95f737d2de5133702c9b641946e70ec2d1dae.camel@gmail.com>
 <CAEf4BzawMy=woHx_yHY0iiD0x12B_+J8mFgV5zT3aCpG2N0s-g@mail.gmail.com> <4b12236c974db52ea19985cc9c5e08e021db9ec1.camel@gmail.com>
In-Reply-To: <4b12236c974db52ea19985cc9c5e08e021db9ec1.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 16 Dec 2025 15:00:42 -0800
X-Gm-Features: AQt7F2o1hIoyH552Fz8_fwBqLQ3Of6KbxG-ctMvRDSnbAC2TNEmRnbbWlpIdi4g
Message-ID: <CAEf4BzbAXGdROrnGZZ_GBZmn9muKz9Cr+yUbovo+pmx-8GLdhg@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 03/10] libbpf: use kind layout to compute an
 unknown kind size
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org, 
	ihor.solodrai@linux.dev, dwarves@vger.kernel.org, bpf@vger.kernel.org, 
	ttreyer@meta.com, mykyta.yatsenko5@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 2:35=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2025-12-16 at 14:23 -0800, Andrii Nakryiko wrote:
>
> [...]
>
> > Ok, so what you are saying is that if there is layout info we should
> > always use that instead of hard-coded knowledge about kind layout,
> > right? Ok, I can agree to that, but see note about extensibility
> > below.
> >
> > But that's a bit different from validating that the recorded layout
> > of, say, BTF_KIND_STRUCT is what we expect (sizeof(struct btf_type) +
> > vlen * sizeof(struct btf_member)). Because if we enforce that, then we
> > still preclude any extensions to those layouts in the future. And if
> > we do that, what's the point of looking at layout info for kinds we do
> > know about?
>
> If full flexibility is allowed, then all places where e.g. libbpf
> iterates params or struct members require an update. That's a big
> change.
>
> I suggested checking layout sizes for existing types as a half-measure
> allowing to avoid such changes.

Shouldn't we just say that layout info will never change for the kind?
Whatever fixed + vlen size it starts with, that's set in stone.

>
> > > Given that BTF rewrites would only be unsound in presence of unknown
> > > types the whole feature looks questionable to me.
> >
> > What are those "BTF rewrites" you are referring to? I'm getting a bit
> > lost in this discussion, tbh.
>
> E.g. btf__permute(), as it will not permute all types if some of the
> are unknown. Or dedup.

Yes, agreed, I don't think we should allow modifications like that of
course, who said we should?

>
> > This feature is designed to allow introducing new (presumably,
> > optional) kinds and not break older versions of libbpf/bpftool to at
> > least be able to dump known contents. Does the current implementation
> > achieve that goal? What other goals do you think this feature should
> > support?
>
> I don't think anything other than dump is possible to support.

Ok, then we are on the same page.

One interesting question is what to do about libbpf's BTF
sanitization? Should we still try to replace unknown types with
something that byte-size-wise is compatible? It might not work in all
cases, depending on the semantics of unknown KIND, but it should work
in practice if we are careful about adding new kinds "responsibly".
WDYT?

>
> [...]
