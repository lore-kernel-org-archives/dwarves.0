Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C8B3A759D
	for <dwarves@vger.kernel.org>; Wed, 11 Mar 2026 23:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773272289; cv=pass; b=kyUG2jcj3LeVL0a7qzsyPieXxQ0DsauFPoyB09GuNoinvcgJjiYY8r8cLJxumLVLkt5k6fRXQJUnz98vk06S7WOtSG7Z/MjpHNTGQj6Xu3Jfzb//vG/oZrGi2Tx0faOyChlDJL/KugzzhRaQT/wJ+YsWBnAmYsmG4r3fIPb6j2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773272289; c=relaxed/simple;
	bh=PaEMK9G3SnpNNxiY44PYXbHAJqo1tfZ2/Na06xk0nbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rc14U9C6X1ew//X1qrzyYVbfUsKzu+itNm1rz+k40fjF98MgKp3UfJoZuHF4eseYpEgOiWVS+oJAzAx+d4U6Qqqnn5vH3h2Z+vwik0C/viMX3I0cXjNvtmQpb+syjyYsc3R4WFECm8NzP5uILYXKM0WDLoWriAoyngGF+yIfxIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SkTKukxy; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkTKukxy"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35a0b413684so227436a91.3
        for <dwarves@vger.kernel.org>; Wed, 11 Mar 2026 16:38:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773272288; cv=none;
        d=google.com; s=arc-20240605;
        b=krumBy7+CyxOE+0EMc3yA62fGrgud5pFcZeye9kZgFzdKc9zJa1/AkEpCXASHwo35B
         Qd2zvIxcy2att6BIeY8LPoxe5QHX0CHUgrUoJr9TpLF3AFe5fv+HZctACiiCISG41+Fs
         EL7ZVBFZZljyjuSbpi0vlx4crMX/cqzUujF0xYG5Ba1R/VjePaoE/4r81bB8+6VBKSM/
         EmqFXfl0WqfkPyr/jil61ITWx+HP+BW3YN40rFSMqUqRiNIPDmAMRkyiB0NimpUOvzrv
         24cB/Penuu7rFe5SsYwbDA0m72VS/FxpaI7washwi9CTxtZx/jF0121q8SdqB0Pt7yOp
         pR3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lg1BSN7SZeN8e1s6TD+FypmlHZGZs1b9Ja71KqsAJ5Q=;
        fh=cA4h/WFijlkPNy+tUR4hpf4W/dxD3Ugo/MN4mhZCpS0=;
        b=hbKS0muAb2Lfu4OFse++IBddX6RwOvdLccNH5SVh0or8dVBxSzYiahg43BDb1N8I0m
         hdd/uBMOLtYEgm/RdkMDvbQciQi6DVlDF4a0wzn7jEuKBH3FsU2dsy86rlzdRf7P5fZL
         /KxSsA7yzARVnv/k6lzxmC4e9AfkbHoNvsp93Kj4gC7juKGIXAxUT17kIUs/5wIRQkqs
         nwNPjoubH6LgQ6TUpiNObrL7RRZiJcOKpxhNoN/gnPOoscXWgOTtbYtSLv/VHfogo/bF
         vrH4sspQboetiA9/o0FI7twhoyLkJDrBoIRLSy+zJy03qnb8JKt1+kU/IObcz+Ohe2ka
         iKiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773272288; x=1773877088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lg1BSN7SZeN8e1s6TD+FypmlHZGZs1b9Ja71KqsAJ5Q=;
        b=SkTKukxywKGog+0ujyKaK9U4N07AkZyryhHP2ocyTSYi/jwkhcPxauFbHG6cKSLBPI
         rtrbm3UEpsjCVDaVIIRhn0Z7bznq5o+213b9fEnHNX2kAP25F9sGXYRxRyaWMw7vkhMS
         OqVaBvO0xZnY9VMopmQqicIp9bnOaPxg9ee7+epD722N1812gCuucPceVDEC8DPGNrAp
         onhOlqe0a7m/75enGzrWBd8eInR2YUG6YACTXvx791I+Qa3GgSk/cnDkhdQkKTx2y97B
         Yp0xQqt+NAWIbis3AeSvKSwWcs2OF8qYzbO7gb4V9T47X6opdWLJnLCMSbsWJJcBCXTt
         4PJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773272288; x=1773877088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lg1BSN7SZeN8e1s6TD+FypmlHZGZs1b9Ja71KqsAJ5Q=;
        b=RNc2b8js5uPAODdZtN+9hg02cZzTyBMECeEg/uwlqPLZkAZwEg/Ayn40K8faY84UKp
         o1uH3BThLBVBL9GPIRu11/vJhJNGMHrVrM8lOHZsJ9Onl7/K9baZCwOqcJIsspVdEONz
         ihXe/NtzwXQ/lVvldSD3cvHz9YPKGJFS9fu/PzvUX5RyK16Wt2KiMDGkMrdj1vny7zzt
         L51ghBhZe7l81vAmad4ku6WxKhrvM4tcdiwptnd4siGcbrcHzoiylFLNs4GROWuau7qN
         6hZhhpeyk04hn7IH7ERBOdtYi106ynA8NX3AKVT5GOwuitf1ps2asnkd8zT4dxuMvTuv
         k6wA==
X-Forwarded-Encrypted: i=1; AJvYcCX9DVvcrhApRKvMtHBqVd5wtgaNnuNndJjMJVzwizfEIjEEz/30NCgnsfuOROrEgipUSW/DLG4I@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjcz9Q932Rr1UB9i8ui0IdUG7Yb3BlvAq56UxdR0zH+67ANum3
	GDFz8a4aMNTZn0sRyNReR8nh2tyU3o6ZtD4NE64pZIflz97uoQX+D320mlBuok+XI3GEWueazic
	8znss0Mpkx6r5AJf9ncnLjVDO4FdeULk=
X-Gm-Gg: ATEYQzyFY1Imjk4I5YYMc9dvmYf37AkRmhE/RR2ZAkm6bodlSB1L3rBiVBw6kcY3VAu
	R+AcVMQ5PmOYdB0lktfhSrMrCnPl3OAK+eHB+jCCyDP3jfNNyHjG1fdVauSwqjMTBPBnyEdmyO7
	8FqYjLljoJyTZurQaf5p+zIQYcIkKFOLsozIBWqxbPbAsx0dOb5pgfaN04/j1XRgu34SG+KDANi
	Uec8i6+LWGRVZuu5nGDeC4vVFPEk/uv5SsczeIgRp5MYx+z93L0KGLmd3DIczsh4uAZFDz9Veqq
	1C3vBF0=
X-Received: by 2002:a17:90b:3d47:b0:356:41c2:897d with SMTP id
 98e67ed59e1d1-35a012ab2damr3994247a91.8.1773272287882; Wed, 11 Mar 2026
 16:38:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306113630.1281527-1-alan.maguire@oracle.com>
 <20260306113630.1281527-3-alan.maguire@oracle.com> <CAEf4Bza_kJowGmin4Hh2iOpwXZVgNoeGNniidSpZEjRjqWnVyA@mail.gmail.com>
 <128e9cac-c935-49ef-98df-30f3b6cd7822@oracle.com> <CAEf4BzZefR6qQwu1jENEMg15UCXXnfqfwHYRV5y4NAXWwuo4zw@mail.gmail.com>
 <50f76d21-ff5c-471d-bb11-208925778d32@oracle.com> <CAEf4BzatOXf0YgtQj0X+kQ=NSo_rFLAjQ0BHf-ZegFm+t43J3A@mail.gmail.com>
 <8294fca1-4d11-4c91-914a-c83d12f00ecc@oracle.com>
In-Reply-To: <8294fca1-4d11-4c91-914a-c83d12f00ecc@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Mar 2026 16:37:55 -0700
X-Gm-Features: AaiRm51gD5IW_TYNTs-zz5q3ENGT69qimtc2o9IOJwthhjDaC3kLaYVLVymQUC8
Message-ID: <CAEf4BzbNQhga9bQuj73yE3Eg0KDuntsr-EqNOLCjSz+9GgY6Sg@mail.gmail.com>
Subject: Re: [PATCH v13 bpf-next 2/8] libbpf: Support layout section handling
 in BTF
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org, 
	ihor.solodrai@linux.dev, mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 12:35=E2=80=AFPM Alan Maguire <alan.maguire@oracle.=
com> wrote:
>
> On 11/03/2026 19:21, Andrii Nakryiko wrote:
> > On Wed, Mar 11, 2026 at 12:17=E2=80=AFPM Alan Maguire <alan.maguire@ora=
cle.com> wrote:
> >>
> >> On 11/03/2026 18:16, Andrii Nakryiko wrote:
> >>> On Wed, Mar 11, 2026 at 11:10=E2=80=AFAM Alan Maguire <alan.maguire@o=
racle.com> wrote:
> >>>>
> >>>> On 11/03/2026 17:46, Andrii Nakryiko wrote:
> >>>>> On Fri, Mar 6, 2026 at 3:37=E2=80=AFAM Alan Maguire <alan.maguire@o=
racle.com> wrote:
> >>>>>>
> >>>>>> Support reading in layout fixing endian issues on reading;
> >>>>>> also support writing layout section to raw BTF object.
> >>>>>> There is not yet an API to populate the layout with meaningful
> >>>>>> information.
> >>>>>>
> >>>>>> As part of this, we need to consider multiple valid BTF header
> >>>>>> sizes; the original or the layout-extended headers.
> >>>>>> So to support this, the "struct btf" representation is modified
> >>>>>> to contain a "struct btf_header" and we copy the valid
> >>>>>> portion from the raw data to it; this means we can always safely
> >>>>>> check fields like btf->hdr.layout_len
> >>>>>>
> >>>>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> >>>>>> ---
> >>>>>>  tools/lib/bpf/btf.c | 309 ++++++++++++++++++++++++++++-----------=
-----
> >>>>>>  1 file changed, 200 insertions(+), 109 deletions(-)
> >>>>>>
> >>>>>
> >>>>> [...]
> >>>>>
> >>>>>>
> >>>>>> -       memcpy(p, hdr, hdr->hdr_len);
> >>>>>> +       memcpy(p, hdr, min((__u32)sizeof(struct btf_header), hdr->=
hdr_len));
> >>>>>
> >>>>> in all these cases where we have sizeof(struct btf_header), this
> >>>>> smells like a potential issue, tbh. We are silently truncating the
> >>>>> original header here, potentially. Which is ok for read-only case, =
but
> >>>>> do we error out if someone is trying to modify/write such BTF where=
 we
> >>>>> don't really understand all of it? Should we?
> >>>>>
> >>>>
> >>>> The kernel enforces that any additional data in the header beyond fi=
elds
> >>>> we know how to deal with is zero. We don't enforce this here, but we
> >>>> get a similar effect since we only copy the fields we care about. In=
 effect
> >>>> we wind up removing the aspects of the BTF we don't know about, so i=
f we
> >>>> read in such BTF, writing it out would not preserve any additional h=
eader
> >>>> information (say a new section offset/length) beyond the current siz=
e of
> >>>> struct btf_header. So writing such BTF after reading it in converts =
it to
> >>>> the BTF representation libbpf knows about (header fields + sections)=
.
> >>>
> >>> I don't think we should be doing this. Let's error out when someone
> >>> tries to modify BTF where we don't understand *all* aspects of it.
> >>>
> >>
> >> ok, so to do this I think we'd need to set a never_modifiable flag or =
similar
> >> on parsing when we find non-zero unknown header data, and then fail
> >> btf_ensure_modifiable().
> >
> > yep, I'd like some better name that would mean "there are extra btf
> > bits we don't understand", but I can't come up with a better name :)
> > if you can, prefer that over not very semantically meaningful "never
> > modifiable"
> >
>
> would btf->unknown_hdr_data work?

what about btf->has_hdr_extra ?
>
