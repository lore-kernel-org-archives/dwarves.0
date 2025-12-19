Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0C326E70E
	for <dwarves@vger.kernel.org>; Fri, 19 Dec 2025 18:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766168540; cv=none; b=N3NBI36e0WG+BXhTKKjFALtqcsFrFVk81MktQqlhybJ3NjZRKsDaUMORBFBB3b9EWhJiM3PWJrzApGvEuuTO49spaX5OXb5f8SNoeOPPGWHWiyHinUGTJr/QWjODfzYscXdgHByQEW7hZjXsRtz/RZ3WNXdSbTnycoMgDLTeh/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766168540; c=relaxed/simple;
	bh=tM3Op05yEeJlG208v6uWg7gKqoy0605xU5EuYw3TroU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ns8m09FEkJbYV6JnX1JwNuBKtyi9W7nQifLkLan9I5ZGpByFXoXzB76tn/V0BUvyO1ugH5aRYDtla7EgDJigLXtYXVPgaCBAux2NVLKceMSIooPmgThwTU7x7GnADN+0XFyLWVa6ZGMzlyZg3zzEcb8yYrq53rPI1RtuQdIdAKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGBELkpm; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGBELkpm"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34e90f7b49cso1058247a91.3
        for <dwarves@vger.kernel.org>; Fri, 19 Dec 2025 10:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766168532; x=1766773332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bYmOUWke0U4r9sPgsIAmz4ZIv+PvBy4e3K3Biqcz4w=;
        b=bGBELkpmmhbCien3EEwHXyTSpq+gXLhZ61SD2WJzaXgMlsiSkDJ5fqrEyBMN3bT99e
         /krZTlMFBwF/MFc3Nr6cJjmA/hw3HTonPH0V0X2JUGZC64KEt3t9ul0x76fVUZgboH1e
         XneD9o1QY28NqMOohubYWZPhSCQydQc6ihzo1UUH4+rM49g8k03M2jOOkpJ+QVfT3vir
         a3G6jdkpvyUhuNoJT0eMT6IExUDAnHLSQBVGLUEpoAoSYl0hYhHXBo4t0Qpy35GNJ9/h
         +3/sw4SHzPGvJYMoR7XxpuVIqDX9g448+g5vSC3RkLD8zEl3ySa78yuocgHTr0aWQwYh
         SaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766168532; x=1766773332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2bYmOUWke0U4r9sPgsIAmz4ZIv+PvBy4e3K3Biqcz4w=;
        b=CB9Nf52qJO4j64KqczV8JxJNwvigvcgjit5hguYuUSo0h2JYFrrZkuFKOJY75hA0DH
         xPKFu27wk21zbIt0T6Mbj4Cs+lHAetR1yXSoX1g5h1J7Wn4udFSCLblX8dereSaKmr+M
         77m/S5ZeXhx5C0z6P4G//+yaxXdxZcuHXgKNymM9FTJII5ok849efgJO2+gB0NL/Aukp
         3jObPpBcHeiiCzsKl4X5dHlAGms8BdIuVSfU86n6i0rDG6IHIrDZbXaWE9nrErdWAx/9
         ac71+bX4xP/MxLDstR/N8u5rGvswXuKikwoXtEUmhkNhXi6iMgqHlh8GdUZhacjXHpFi
         qIfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoT12fZb+LU2zlaqKJncQIhMutZJbg2x7r2BEp3ISBPeqR7cg1B+isL3a2syuunI1H5rOMzncV@vger.kernel.org
X-Gm-Message-State: AOJu0YyPEz6m595DsPPAXjaKMmqeE+xAKH/0T33rgmunFeahHr7yYIzL
	IS+LRtMQXS5sljQq0O+nNodRXadJ4Pf0T+ynXyDsmPBSydY1PovaiR8JKsbjpnv3AedhrFd6q2i
	codueSk83TY67HghtYmWzxxw8o7u6xNM=
X-Gm-Gg: AY/fxX4ItZRUnGzrCKOmKIMxdadp0TLZEYDd+asLOKGVxG4eRUJU+Rz5mdJCQsNl5UJ
	o1KTT+yKJJRsry/FC5OTxm3de8jj2QvYUDf7YufrBD9xyV1A8aR5UY5jfjuJNpZ/0eXD3ghEHmr
	rjTh7Y9fvTLXZSYItIxcCFYNWVv4rVpIZ2KwIHWWV0ZXN4OTtd3WK3yik+Ikecn8uaCyGBJeaXG
	c+b4/lbndC9vYGEvhNfhtkCoRnKAtwWawLEnQl6P4vJCohlAzcz4iPfJ9hafOPQ+D+cXp4=
X-Google-Smtp-Source: AGHT+IEWrAp0w9BS6EC0wy8b1y3DgfEkArrWm+W166MmgWCZW7sKSC7lg+v18x74VaWGCl4Nontzy7eoe/c0AtzYQGg=
X-Received: by 2002:a17:90a:a790:b0:341:2141:df76 with SMTP id
 98e67ed59e1d1-34e921448f1mr1940959a91.13.1766168531935; Fri, 19 Dec 2025
 10:22:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
 <20251215091730.1188790-3-alan.maguire@oracle.com> <CAEf4Bza+C7nRxFDHS0dNDk5XF79nE6y4GqEu0bmtJPTMoFrNvQ@mail.gmail.com>
 <db38bb39-7d16-41b6-968d-61e3b7681440@oracle.com> <CAEf4Bzbn_eWC8W8+so-BgkzNOxx8jgEysU3kTzBCW1jwXPEfnQ@mail.gmail.com>
 <ccafde20-3ea5-458a-b2e7-219aaa9a7ff0@oracle.com>
In-Reply-To: <ccafde20-3ea5-458a-b2e7-219aaa9a7ff0@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Dec 2025 10:21:59 -0800
X-Gm-Features: AQt7F2o78iFA6oMNmQeEXBzdfdQZ7I8w7qdjeev0wH3xSnnQ4pGl2BR6oE5pH5I
Message-ID: <CAEf4BzZ+iH1XvaYOjE==GPJ6wFo14_QtrFYvyvWa=ebc6UKPbA@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 02/10] libbpf: Support kind layout section
 handling in BTF
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org, 
	ihor.solodrai@linux.dev, dwarves@vger.kernel.org, bpf@vger.kernel.org, 
	ttreyer@meta.com, mykyta.yatsenko5@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 10:19=E2=80=AFAM Alan Maguire <alan.maguire@oracle.=
com> wrote:
>
> On 19/12/2025 17:58, Andrii Nakryiko wrote:
> > On Fri, Dec 19, 2025 at 5:34=E2=80=AFAM Alan Maguire <alan.maguire@orac=
le.com> wrote:
> >>
> >> On 16/12/2025 19:34, Andrii Nakryiko wrote:
> >>> On Mon, Dec 15, 2025 at 1:18=E2=80=AFAM Alan Maguire <alan.maguire@or=
acle.com> wrote:
> >>>>
> >>>> Support reading in kind layout fixing endian issues on reading;
> >>>> also support writing kind layout section to raw BTF object.
> >>>> There is not yet an API to populate the kind layout with meaningful
> >>>> information.
> >>>>
> >>>> As part of this, we need to consider multiple valid BTF header
> >>>> sizes; the original or the kind layout-extended headers.
> >>>> So to support this, the "struct btf" representation is modified
> >>>> to always allocate a "struct btf_header" and copy the valid
> >>>> portion from the raw data to it; this means we can always safely
> >>>> check fields like btf->hdr->kind_layout_len.
> >>>>
> >>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> >>>> ---
> >>>>  tools/lib/bpf/btf.c | 260 +++++++++++++++++++++++++++++++----------=
---
> >>>>  1 file changed, 183 insertions(+), 77 deletions(-)
> >>>>
> >>>> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> >>>> index b136572e889a..8835aee6ee84 100644
> >>>> --- a/tools/lib/bpf/btf.c
> >>>> +++ b/tools/lib/bpf/btf.c
> >>>> @@ -40,42 +40,53 @@ struct btf {
> >>>>
> >>>>         /*
> >>>>          * When BTF is loaded from an ELF or raw memory it is stored
> >>>> -        * in a contiguous memory block. The hdr, type_data, and, st=
rs_data
> >>>> +        * in a contiguous memory block. The  type_data, and, strs_d=
ata
> >>>
> >>> nit: two spaces, and so many commas around and ;) let's leave Oxford
> >>> comma, but comma after and is weird
> >>>
> >>>>          * point inside that memory region to their respective parts=
 of BTF
> >>>>          * representation:
> >>>>          *
> >>>> -        * +--------------------------------+
> >>>> -        * |  Header  |  Types  |  Strings  |
> >>>> -        * +--------------------------------+
> >>>> -        * ^          ^         ^
> >>>> -        * |          |         |
> >>>> -        * hdr        |         |
> >>>> -        * types_data-+         |
> >>>> -        * strs_data------------+
> >>>> +        * +--------------------------------+---------------------+
> >>>> +        * |  Header  |  Types  |  Strings  |Optional kind layout |
> >>>
> >>> Space missing, boo. Keep diagrams beautiful!..
> >>>
> >>>> +        * +--------------------------------+---------------------+
> >>>> +        * ^          ^         ^           ^
> >>>> +        * |          |         |           |
> >>>> +        * raw_data   |         |           |
> >>>> +        * types_data-+         |           |
> >>>> +        * strs_data------------+           |
> >>>> +        * kind_layout----------------------+
> >>>> +        *
> >>>> +        * A separate struct btf_header is allocated for btf->hdr,
> >>>> +        * and header information is copied into it.  This allows us
> >>>> +        * to handle header data for various header formats; the ori=
ginal,
> >>>> +        * the extended header with kind layout, etc.
> >>>>          *
> >>>>          * If BTF data is later modified, e.g., due to types added o=
r
> >>>>          * removed, BTF deduplication performed, etc, this contiguou=
s
> >>>> -        * representation is broken up into three independently allo=
cated
> >>>> -        * memory regions to be able to modify them independently.
> >>>> +        * representation is broken up into four independent memory
> >>>> +        * regions.
> >>>> +        *
> >>>>          * raw_data is nulled out at that point, but can be later al=
located
> >>>>          * and cached again if user calls btf__raw_data(), at which =
point
> >>>> -        * raw_data will contain a contiguous copy of header, types,=
 and
> >>>> -        * strings:
> >>>> +        * raw_data will contain a contiguous copy of header, types,=
 strings
> >>>> +        * and optionally kind_layout.  kind_layout optionally point=
s to a
> >>>> +        * kind_layout array - this allows us to encode information =
about
> >>>> +        * the kinds known at encoding time.  If kind_layout is NULL=
 no
> >>>> +        * kind information is encoded.
> >>>>          *
> >>>> -        * +----------+  +---------+  +-----------+
> >>>> -        * |  Header  |  |  Types  |  |  Strings  |
> >>>> -        * +----------+  +---------+  +-----------+
> >>>> -        * ^             ^            ^
> >>>> -        * |             |            |
> >>>> -        * hdr           |            |
> >>>> -        * types_data----+            |
> >>>> -        * strset__data(strs_set)-----+
> >>>> +        * +----------+  +---------+  +-----------+   +-----------+
> >>>> +        * |  Header  |  |  Types  |  |  Strings  |   |kind_layout|
> >>>> +        * +----------+  +---------+  +-----------+   +-----------+
> >>>
> >>> nit: spaces (and if we go with "layout" naming, this will be short an=
d
> >>> beautiful " Layout " ;)
> >>>
> >>>> +        * ^             ^            ^               ^
> >>>> +        * |             |            |               |
> >>>> +        * hdr           |            |               |
> >>>> +        * types_data----+            |               |
> >>>> +        * strset__data(strs_set)-----+               |
> >>>> +        * kind_layout--------------------------------+
> >>>
> >>> [...]
> >>>
> >>>> @@ -3888,7 +3989,7 @@ static int btf_dedup_strings(struct btf_dedup =
*d)
> >>>>
> >>>>         /* replace BTF string data and hash with deduped ones */
> >>>>         strset__free(d->btf->strs_set);
> >>>> -       d->btf->hdr->str_len =3D strset__data_size(d->strs_set);
> >>>> +       btf_hdr_update_str_len(d->btf, strset__data_size(d->strs_set=
));
> >>>>         d->btf->strs_set =3D d->strs_set;
> >>>>         d->strs_set =3D NULL;
> >>>>         d->btf->strs_deduped =3D true;
> >>>> @@ -5343,6 +5444,11 @@ static int btf_dedup_compact_types(struct btf=
_dedup *d)
> >>>>         d->btf->type_offs =3D new_offs;
> >>>>         d->btf->hdr->str_off =3D d->btf->hdr->type_len;
> >>>>         d->btf->raw_size =3D d->btf->hdr->hdr_len + d->btf->hdr->typ=
e_len + d->btf->hdr->str_len;
> >>>> +       if (d->btf->kind_layout) {
> >>>> +               d->btf->hdr->kind_layout_off =3D d->btf->hdr->str_of=
f + roundup(d->btf->hdr->str_len,
> >>>> +                                                                   =
          4);
> >>>> +               d->btf->raw_size =3D roundup(d->btf->raw_size, 4) + =
d->btf->hdr->kind_layout_len;
> >>>
> >>> maybe put layout data after type data, but before strings? rounding u=
p
> >>> string section which is byte-based feels weird. I think old libbpf
> >>> implementations should handle all this well, because btf_header
> >>> explicitly specifies string section offset, no?
> >>>
> >>
> >> That sounds good, but I think there are some strictness issues with ho=
w we parse
> >> BTF on the kernel side that we may need to think about, especially if =
we want to
> >> make kind layout always available. In that case we'd need to think how=
 old kernels
> >> built with newer pahole might handle newer headers with layout info.
> >>
> >> First in btf_parse_hdr() the kernel rejects BTF with non-zero unsuppor=
ted fields.
> >> So trying to load vmlinux BTF generated by a pahole that adds layout i=
nfo will
> >> fail for such a kernel.
> >>
> >> Second when validating section info in btf_check_sec_info() we check f=
or overlaps
> >> between known sections, and we also check for gaps between known secti=
ons. Finally we
> >> also check for any additional data other than the known section data.
> >
> > I thought we don't validate gaps, I missed btf_check_sec_info()
> > checks, though. Good for kernel, it should be strict.
> >
> > But it's easy to drop this layout info in libbpf for BTF sanitization,
> > this shouldn't be a problem. Just shift everything to the left and
> > adjust strs_off.
> >
> >>
> >> For layout info stored between type+strings we'd wind up rejecting it =
for a few reasons:
> >>
> >> 1. we'd find non-zero data in the header (layout offset/len)
> >> 2. we'd find a "gap" between types+strings (the layout data)
> >>
> >> Similarly with layout at the end
> >>
> >> 1. we'd find non-zero data in the header (kind layout offset/len)
> >> 2. we'd find unaccounted-for data after the string data (the kind layo=
ut data)
> >>
> >> So either way we'd wind up with unsupported headers. One approach woul=
d be to
> >> do stable backports relaxing these header tests; I think we could rela=
x them to
> >> simply ensure no overlap between sections and that sections don't over=
run data
> >> length without risking having unusable BTF. Then a newer BTF header wi=
th additional
> >> layout info wouldn't get rejected. What do you think?
> >
> > See above, I don't see why we can't just sanitize BTF and drop layout
> > parts altogether. They are optional for kernel either way, no harm in
> > dropping them.
> >
>
> The sanitization for user-space consumption is doable alright, I was thin=
king
> of the case where the kernel itself reads in BTF for vmlinux/modules on b=
oot,
> and that BTF was generated by newer pahole so has unexpected layout info.
> If we just emitted layout info unconditionally that would mean newer paho=
le might
> generate BTf for a kernel that it could not read. If however we relaxed t=
he
> constraints a bit I think we could get the validation to succeed for olde=
r
> kernels while ignoring the bits of the BTF they don't care about. Fix tha=
t would
> also potentially future-proof addition of other sections to the BTF heade=
r without
> requiring options.

No, let's forget about allowing the kernel to let through some
unrecognized parts of BTF. Pahole will keep introducing feature flags
that we need to enable (like layout stuff, for example), so old
kernels built with new pahole will be just fine. And any
kernel-specific modifications will be moved to resolve_btfids and will
be in-sync with kernel logic. I think we are all good and we don't
have to invent new things on this front, potentially opening us up to
some unforeseen attacks through BTF injection.

>
> Alan
