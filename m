Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBB533F386
	for <dwarves@vger.kernel.org>; Fri, 19 Dec 2025 17:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766166851; cv=none; b=qq8KhfxhT8Tu1TDLJU56zW27yM/uIBNdoOsakNsT5geMte89aFi9cz/2yRZxBYSoMcHIRahSWSm9fru3HmD9w5aU09i3MQ3tLxPKVGChOrTM4iXPUcq+/Ms9BNSWKdoej5doAjm68qLZfqvAosALXugZJbl4VbPol5e64Ms1YNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766166851; c=relaxed/simple;
	bh=mlHSWSBLpIhmXYKUU7YjbqE1RuN2t+EbAOcGCKN3VWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u4Y6Ql8EncTL9qAyLImgguC+PYIr/P5wWllVQuIRt/z55skbq0woeFrauADsGXqL/WF+hYX7C6ZnCS7aaQBy6EldAWKnkLlZ64AI3XaTgIbcb4+b7T6ap18u4lRY8ioz38ph4ub9U6K9ujit8POvxdurNV/Em+pN/t78A268Xcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7zl539d; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7zl539d"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34c2f335681so1658369a91.1
        for <dwarves@vger.kernel.org>; Fri, 19 Dec 2025 09:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766166847; x=1766771647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGkU1TtcYlusMyPc5nfopaf9vQ7RjBHGP0wCoiak/X8=;
        b=O7zl539d1Cu5PwEc+LgNbXXF0CtT9YvMo35yMgTqi76gaB0ov/SRCOIlZBEGdUR4/6
         Avu0zAe3C9X7WQcngmh919XTK9Vmu9LxxN13brGRkLb6qq8oQx6vr6zYHqzeJPEpPWyc
         W/6lEtxmlCAs5KYXX7df952hswK3ity5El3locjbP5RjfNwwY5O8nsUpF+0bdN++BPvi
         v8VLN/lLjHYEhmnvr81szAiolqOgl136aiz50avTeopU9igMzEeFaoIrWKhF9gUJP7zg
         yoeXgH4IHslUiK3AETMgNxA0AigIGTNA82DGZ4rBsa0mavoB/AJ3mw+PGdQvifq2gATs
         fE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766166847; x=1766771647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gGkU1TtcYlusMyPc5nfopaf9vQ7RjBHGP0wCoiak/X8=;
        b=WvtcUnLEBlpqMez9gZ9PBicMs3GPbOrjthVifspYBIRAWK9kyUNf71R+qdw/soDziG
         jTTizK6kLaoAJfnZl6RUn7F6B/Q3GK58ALw4C2u/ZrDfDIGQ2hJQyej25WxGIi2FYUDz
         t4hCKuoMFTRTxQgLzxyyiTaBB8BYgWeWIL4icpHIANVrTTeEhlOYhCf9zdFguilp+Sil
         lU79kjTjTM65Oh+GoXGbPtKWkUblTcCoh+5TNcmqi642fWilPZSO4FI1pN+kEsYnz8Sa
         IdCMd8mbjLc11rhe79ammJNjoc0PSk2103tMb5k3yFJtuJYc6F8cR8p+8TJdu+hN7XMU
         p6Mw==
X-Forwarded-Encrypted: i=1; AJvYcCWJbbr7CDn9WjVWkklm8OBqQqwt/CUlKU5OaROyLWU39QLt/sKRQtjAb6Q08mGLGE2SfoJgNcO6@vger.kernel.org
X-Gm-Message-State: AOJu0YzNuVyJOCXGrrgOuWCMZ034TJqxscioSgsRW4vB2Ffwok2Plvew
	OXwHAojQyL4Bx4E978u6yrXPLypLEVKrhTXSK+gst+y0dQ7dikVMIXVBXxT/kWW0Yp1c+dJEKaq
	m7ZQEQhW4eGoQQiIyceUPoja+YnKw9Fg=
X-Gm-Gg: AY/fxX44Q8N3odeN9mfa7LIySFDdjx++guFqUujceTRKGxma7YzrNf+QKXk76tSPCVX
	u0ErEsfkWs634mk2Pi2h8wqwSOFXjPUcNDCc7rzc3paXDMhlRmAvrXg/WnTCxcAy442socJxj9a
	HxSmfzHAuoSBbSt0vy20lXPxdrUlWcFCJ2tUNSS3fO4ehJBg1Tc1FuCZbEpta1Vl1pDJXwtdrIe
	TEvMYn1rwTzHaqL4+yLTJz56aBN9aXfVplDtyixpMAcaYwwrAvZ7j6sZhXjXCCkpGOTJgg=
X-Google-Smtp-Source: AGHT+IEqrsmcYQtbT9sRx9Q89w9Kjb+8rBi/G66Xb3s8q8hEtmvD0WGrTkG+T/Kl8HTwu7qqBxS46rKomlLvpzyJA50=
X-Received: by 2002:a17:90a:e705:b0:340:f05a:3ec2 with SMTP id
 98e67ed59e1d1-34e921be200mr3477042a91.17.1766166846805; Fri, 19 Dec 2025
 09:54:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
 <20251215091730.1188790-2-alan.maguire@oracle.com> <CAEf4Bzaw6KRU2yDbawOe+eusCjCwvg0FwhkpvGA3HE=gC=ZLbQ@mail.gmail.com>
 <42914a9b-0f34-4cee-bc36-4847373fa0b5@oracle.com>
In-Reply-To: <42914a9b-0f34-4cee-bc36-4847373fa0b5@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Dec 2025 09:53:54 -0800
X-Gm-Features: AQt7F2pS4YIT8Rep9aUdSQpIyCHWmTEgJfZsp2X6jBHMJOji4mhYY4By4nlNOXQ
Message-ID: <CAEf4BzZuikZK5cZQyV=ge6UBKHxc+dwTLjcHZB_1Smw1AwntNA@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 01/10] btf: add kind layout encoding to UAPI
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org, 
	ihor.solodrai@linux.dev, dwarves@vger.kernel.org, bpf@vger.kernel.org, 
	ttreyer@meta.com, mykyta.yatsenko5@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 5:15=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 16/12/2025 19:23, Andrii Nakryiko wrote:
> > On Mon, Dec 15, 2025 at 1:18=E2=80=AFAM Alan Maguire <alan.maguire@orac=
le.com> wrote:
> >>
> >> BTF kind layouts provide information to parse BTF kinds. By separating
> >> parsing BTF from using all the information it provides, we allow BTF
> >> to encode new features even if they cannot be used by readers. This
> >> will be helpful in particular for cases where older tools are used
> >> to parse newer BTF with kinds the older tools do not recognize;
> >> the BTF can still be parsed in such cases using kind layout.
> >>
> >> The intent is to support encoding of kind layouts optionally so that
> >> tools like pahole can add this information. For each kind, we record
> >>
> >> - length of singular element following struct btf_type
> >> - length of each of the btf_vlen() elements following
> >>
> >> The ideas here were discussed at [1], [2]; hence
> >>
> >> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> >> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> >>
> >> [1] https://lore.kernel.org/bpf/CAEf4BzYjWHRdNNw4B=3DeOXOs_ONrDwrgX4bn=
=3DNuc1g8JPFC34MA@mail.gmail.com/
> >> [2] https://lore.kernel.org/bpf/20230531201936.1992188-1-alan.maguire@=
oracle.com/
> >> ---
> >>  include/uapi/linux/btf.h       | 11 +++++++++++
> >>  tools/include/uapi/linux/btf.h | 11 +++++++++++
> >>  2 files changed, 22 insertions(+)
> >>
> >> diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
> >> index 266d4ffa6c07..c1854a1c7b38 100644
> >> --- a/include/uapi/linux/btf.h
> >> +++ b/include/uapi/linux/btf.h
> >> @@ -8,6 +8,15 @@
> >>  #define BTF_MAGIC      0xeB9F
> >>  #define BTF_VERSION    1
> >>
> >> +/*
> >> + * kind layout section consists of a struct btf_kind_layout for each =
known
> >> + * kind at BTF encoding time.
> >> + */
> >> +struct btf_kind_layout {
> >> +       __u8 info_sz;           /* size of singular element after btf_=
type */
> >> +       __u8 elem_sz;           /* size of each of btf_vlen(t) element=
s */
> >
> > So Eduard pointed out that at some point we discussed having a name of
> > a kind (i.e., "struct", "typedef", etc). By now I have no recollection
> > what were the arguments, do you remember? I'm not sure how I feel now
> > about having extra 4 bytes per kind, but that's not really a lot of
> > data (20*4 =3D 80 bytes added), so might as well add it, I suppose?
> >
>
> Yeah we went back and forth on that; I think it's on balance worthwhile
> to be honest; tools can be a bit more expressive about what's missing.
>
> > I think we were also discussing having flags per kind to designate
> > some extra semantics, where applicable. Again, don't remember
> > arguments for or against, but one case where I think this would be
> > very beneficial is when we add something like type_tag, which is
> > inevitably used from "normal" struct and will be almost inevitable in
> > normal vmlinux BTF. Think about it, we have some field which will be
> > CONST -> PTR -> TYPE_TAG -> STRUCT. That TYPE_TAG shouldn't just
> > totally break (old) bpftool's dump, as it really can be easily ignored
> > **if we know TYPE_TAG can be ignored and it is just a reference
> > type**. That reference type means that there is another type pointed
> > to using struct btf_type::type field (instead of that field being a
> > size).
> >
> > So I think it would be nice to encode this as a flag that says a) kind
> > can be ignored without compromising type integrity (i.e., memory
> > layout is preserved) which will be true for all kinds of modifier
> > kinds (const/volatile/restrict/type_tag, even for typedef that should
> > be true) and b) kind is reference type, so struct btf_type::type is a
> > "pointer" to a valid other underlying type.
> >
> > Thoughts?
> >
>
> Again we did go back and forth here but to me there's much more value in
> being both able to parse _and_ sanitize BTF, at least for the simple case=
s.
> What we can include are as you say types in the type graph that are optio=
nal
> reference kinds (like type tag), and kinds that are not implicated in the
> known type graph like the location stuff (it only points _to_ known kinds=
,
> no known kinds will point to location data). So any case where known
> types + optional ref types constitute the type graph we are good.
> Anything more complex than these would involve having to represent the
> layout of type references within unknown kinds (kind of like what we do f=
or
> field iteration) which seems a bit much.
>
> Now one thing that we might want to introduce here is a sanitization-frie=
ndly
> kind, either re-using BTF_KIND_UNKN or adding a new vlen-supporting kind
> which can be used to overwrite kinds we don't want in the sanitized outpu=
t.
> We need this to preserve the type ids for the kernel BTF we sanitize.
> I get that it seems weird to add a new incompatibility to handle incompat=
ibility,
> but the sooner we do it the better I guess. The reason I suggest it now i=
s we'd
> potentially need some more complex sanitization for the location stuff fo=
r
> cases like large location sections, and it might be cleaner to have a spe=
cial
> "ignore this it's just sanitization info" kind, especially for cases like
> BTF C dump.

So you mean you'd like some "dummy" BTF kind with 4-byte-per-vlen so
we can "overwrite" any possible unknown BTF kind?.. As you said,
though, this would only work for new kernels, so that's sad... I don't
know, I don't hate the idea, but curious what others think.

Alternatively, we can just try to never add kinds where the vlen
element is not a multiple of 8 or 12. We can then use ENUM
(8-bytes-per-vlen) or ENUM64 (12-bytes-per-vlen) to paper over unknown
types. FUNC_PROTO (8-bytes-per-vlen) and DATASEC (12-bytes-per-vlen)
are other options. We just don't have 4-bytes-per-vlen for the most
universal "filler", unfortunately.

The advantage of the latter is full backwards compatibility with old kernel=
s.

>
>
> >> +};
> >> +
> >>  struct btf_header {
> >>         __u16   magic;
> >>         __u8    version;
> >> @@ -19,6 +28,8 @@ struct btf_header {
> >>         __u32   type_len;       /* length of type section       */
> >>         __u32   str_off;        /* offset of string section     */
> >>         __u32   str_len;        /* length of string section     */
> >> +       __u32   kind_layout_off;/* offset of kind layout section */
> >> +       __u32   kind_layout_len;/* length of kind layout section */
> >
> > nit: kind_layout is a bit mouthful, have you considered "descr" (for
> > description/descriptor) or just "layout" as a name designator?
> >
>
> Yep, layout seems good. Thanks!
>
> Alan
