Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23B7AD2C
	for <dwarves@vger.kernel.org>; Wed, 17 Dec 2025 00:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765931455; cv=none; b=aTLNFcrA0db+QUPTp5qD0SMsTPDLClD6RQzRmhWMk55U2Us/xocCpLoVj445rMplmmLmlY4CzdGFQUvfKM0cX1ZJte6K2xt7IYTt8RW6KgnJFkGfkBkh0p/t9PRMR0PebBB0sW/1kFFRZqiEvmwYJ3Pb5HzvgcOMirbbtq38RVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765931455; c=relaxed/simple;
	bh=SotrV8IUZuBScb2UJwbCliIUozqPspnjyHBdT91P79Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eSRwm2zUXi34tm/Xv2CC6XGGsjsNJvUfSbuV1EfXr/Za+NMwQPIE/YqMtdZ/hxfrNNJsjdcysNTRUhLALChu+q5vbkCKy4p0udNx8fNUyORMbcaG6XIqJZm8dhBXjG/UIlbOYjOBNjR/zlxvuRjPQLEEV9BZF4NNLvpGDbiIpGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6U5Hgl8; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6U5Hgl8"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34ab8e0df53so5545747a91.3
        for <dwarves@vger.kernel.org>; Tue, 16 Dec 2025 16:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765931453; x=1766536253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SotrV8IUZuBScb2UJwbCliIUozqPspnjyHBdT91P79Q=;
        b=k6U5Hgl85BbWehW4b7LDkU417Cb1Przgeu9e8tQ9Ci/jj64IAHgZjbu6th8BerQdnP
         TcIcG2MvfGeAiBR/eENrbt/IfopGmf8ficP/5VbfehrOOgp6tWZNlMQQYH1nfK6XpLHT
         ZfUCSr1Tk0imn1g1SfYsKu+E2Dp8avBeKrsrZQCMFphcjQ78qGovhyjer/fSPHXezDjT
         FjyYPHOktVPWwe3a+oTR7HOcf/IAyQl9efQ6lbC3eTuF2PmbhqJVw1ZRHK+qMJXQ1Jmf
         AwetToDPvJyGee1PXfD2Di3Gp9ISgp50oZTrkaKPOZGEYYsZnDhD1SdicO6S4mfP73Qd
         TzKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765931453; x=1766536253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SotrV8IUZuBScb2UJwbCliIUozqPspnjyHBdT91P79Q=;
        b=qyU2rlLTjGmSVJw1Mb8LIzuM7DxRrXZap4s3mVV+UMariqK9NczBc76i8XuJiApSbl
         HVCryjfDf+sINkxZ6xVk+BqL2GDA383f++qjEH4bIHMJLJGv76q0ONymPzi77O4WDVKX
         /4Cz6i/YPP+E9sDjoh/l4WIHk72lH9BdVmDeLSBQDVO16BH96aGmZ4F8MKhSMmVpML2d
         wYbk+vubPvSiwxQacB+GFE5C9s5jfmZvXi76zLv5k0eEZWUton457XzDg3rvNNrdB2oh
         s2H+KPJeHIlvBmT62t11+ild/pLJlYEDhE71gw4f3lq5qrqh7+CVzc8khCJ0b6zdse+M
         Se9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWwPpvkP6B9Cej6RB33UWY839cTSBo6IlSi+dtXbQhZQ99ias06O9Z8mqM5kfcLycU69un06c14@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu1nUqDkdr6cFcIFN8SUhSxOLP2o+FAom56mFtVf9SsCroAA1H
	XwYPrHV75fLX/HLTAfBltoeGyofTGmoQPBwtjFx2v78byA1yPczr+ist3Yd9sFKLQRauBXKJPry
	5p57apY/7SjNBDKHDwAQ6wR+mW9uvfRg=
X-Gm-Gg: AY/fxX4wYpbuWCdkipk4S7JE+VzQTd03nxNYiwImUxaULAggZDMSrJmmX/lrcIcYHhI
	BbSQRpm1XIFfsCDvEwGBm52WpKleDu2kBbBmkm9wBiIKTG5PBp5Ok6hjD0GhsIXj9r9SuaYGsg3
	74/wdoRQPSdKg73rLiNPQ9cwBwcjIL/6c7QHjJ9qxcQgfsJYlQLri3gZo28I14+InTcWsxyy4I4
	ftQL7EUZ7yIY6PiUsNBpb5dYVUORNB81yAl7FHJTOvx3kcTi9G/mkwkC8lEqX2dBIvXyglVxcBI
	ar0pMbySNwuewOZEqINcPQ==
X-Google-Smtp-Source: AGHT+IEAXe83mZuuvkfzzKpv8B159m1t148ouzZk6cVtfWnGkmJ5ZbHs5jtGDW8JKI/JAl5SLOUeh6TeXvThSpPI+W8=
X-Received: by 2002:a17:90b:4c:b0:340:c64d:38d3 with SMTP id
 98e67ed59e1d1-34abd6e0220mr16571869a91.12.1765931453016; Tue, 16 Dec 2025
 16:30:53 -0800 (PST)
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
 <CAEf4BzawMy=woHx_yHY0iiD0x12B_+J8mFgV5zT3aCpG2N0s-g@mail.gmail.com>
 <4b12236c974db52ea19985cc9c5e08e021db9ec1.camel@gmail.com>
 <CAEf4BzbAXGdROrnGZZ_GBZmn9muKz9Cr+yUbovo+pmx-8GLdhg@mail.gmail.com> <d05e0af873f2f36359b34cc3865c44c98bc291e0.camel@gmail.com>
In-Reply-To: <d05e0af873f2f36359b34cc3865c44c98bc291e0.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 16 Dec 2025 16:30:40 -0800
X-Gm-Features: AQt7F2qmn0IYw7WdOwlW-Ep_LUROpG4Ov1w1PnLnGoxTjHIlQ0uEPx65f29SdlA
Message-ID: <CAEf4BzYbrT03M2w1gWJT4QPrVZtGC5rpCQGmHomDb4i7yEU0JA@mail.gmail.com>
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

On Tue, Dec 16, 2025 at 3:36=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2025-12-16 at 15:00 -0800, Andrii Nakryiko wrote:
> > On Tue, Dec 16, 2025 at 2:35=E2=80=AFPM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > On Tue, 2025-12-16 at 14:23 -0800, Andrii Nakryiko wrote:
> > >
> > > [...]
> > >
> > > > Ok, so what you are saying is that if there is layout info we shoul=
d
> > > > always use that instead of hard-coded knowledge about kind layout,
> > > > right? Ok, I can agree to that, but see note about extensibility
> > > > below.
> > > >
> > > > But that's a bit different from validating that the recorded layout
> > > > of, say, BTF_KIND_STRUCT is what we expect (sizeof(struct btf_type)=
 +
> > > > vlen * sizeof(struct btf_member)). Because if we enforce that, then=
 we
> > > > still preclude any extensions to those layouts in the future. And i=
f
> > > > we do that, what's the point of looking at layout info for kinds we=
 do
> > > > know about?
> > >
> > > If full flexibility is allowed, then all places where e.g. libbpf
> > > iterates params or struct members require an update. That's a big
> > > change.
> > >
> > > I suggested checking layout sizes for existing types as a half-measur=
e
> > > allowing to avoid such changes.
> >
> > Shouldn't we just say that layout info will never change for the kind?
> > Whatever fixed + vlen size it starts with, that's set in stone.
>
> If we are not going full flexibility road (a lot of work with unclear pur=
pose),
> then fixing the layouts for existing types is what we should do.

agreed

> I suggested adding layout sizes check in BTF validation phase to
> enforce a consistent view at the BTF layout.

ok

>
> > > > > Given that BTF rewrites would only be unsound in presence of unkn=
own
> > > > > types the whole feature looks questionable to me.
> > > >
> > > > What are those "BTF rewrites" you are referring to? I'm getting a b=
it
> > > > lost in this discussion, tbh.
> > >
> > > E.g. btf__permute(), as it will not permute all types if some of the
> > > are unknown. Or dedup.
> >
> > Yes, agreed, I don't think we should allow modifications like that of
> > course, who said we should?
>
> No one says, I suggested adding a check in libbpf,
> so that btf_ensure_modifiable() can report an error in such cases.

yeah, I never disagreed with that. Not sure how this whole thing got
into this discussion, but yes, we are on the same page w.r.t. this

>
> > >
> > > > This feature is designed to allow introducing new (presumably,
> > > > optional) kinds and not break older versions of libbpf/bpftool to a=
t
> > > > least be able to dump known contents. Does the current implementati=
on
> > > > achieve that goal? What other goals do you think this feature shoul=
d
> > > > support?
> > >
> > > I don't think anything other than dump is possible to support.
> >
> > Ok, then we are on the same page.
> >
> > One interesting question is what to do about libbpf's BTF
> > sanitization? Should we still try to replace unknown types with
> > something that byte-size-wise is compatible? It might not work in all
> > cases, depending on the semantics of unknown KIND, but it should work
> > in practice if we are careful about adding new kinds "responsibly".
> > WDYT?
>
> The question here is to how to compute the size for the unknown.
> It is possible to have a flag specifying if btf_type->size is a true
> size. But computation is more sophisticated for e.g. arrays.
> On the other hand, if member of some structure has unknown kind,
> it can be safely deleted, as struct has size field and offsets for all
> members. So, sanitization by deleting types of unknown kind is
> possible to some extent.

I think it's unlikely we'll add some kind that will be directly
embeddable into struct except for some modifiers. For modifiers (which
I'm arguing we should add a flag stating that this kind is used as a
modifier and its type field is actually a type ID field), we can
replace them either with typedef or const and preserve layout and most
of semantics. And for optional stuff like decl_tag, they are usually
stand-alone pointing to types (rather than having types pointed to
them), so just replacing them with something that is compatible in
terms of byte size in BTF data should be sufficient.

I think BTF sanitization will have to be best effort, but if we keep
sanitization in mind, we can ensure reasonable behavior.

Ultimately, though, you should always strive to use the very latest
libbpf with your BPF object files. So maybe no sanitization of unknown
kinds is the right (and simple) answer here: just update libbpf and it
will take care of sanitization of *known* kinds.
