Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1A330595C
	for <dwarves@vger.kernel.org>; Tue, 16 Dec 2025 19:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765913674; cv=none; b=JzzX7JjLmgXHyJT19YVwIjt7e2eME/OGKOfO4tVCn8dPEpTXmaGYjCDMFfwddOX2382Fp5uogLWzDg2i+rlPQkdNOL6ZvyckJRUZ2k8TRPAjpgxocLVatTbMfVSXJMdcNN48IlN3aCeds7zuCCuIJyvC6X0w4w4722L/bnbLm00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765913674; c=relaxed/simple;
	bh=FOUuSxJdgORqB3D7sSJIl9DIFcwVTc2m8UMrIKsIHuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W17KsSyv0TtWmPfr9OGr8WkVC/2QRG8W7CP4ElC1Sjc0//xnbcJ2lwvjSEkpAz28gpmWshT07yJXYsHvmcTZ21Q1GB6YSQXvGIcm1DCH15zg7qojpbo41pddUbm6s46XxHOwy1VqDfIDH/TMSyKQLwCFZjkIdXlnLrurUCTHmnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJJQfmg1; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJJQfmg1"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a0f3f74587so31329915ad.2
        for <dwarves@vger.kernel.org>; Tue, 16 Dec 2025 11:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765913672; x=1766518472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oc7wkmO1G/O6pko8A6pYs9YQriGWhLxGOsAWt5QrAsQ=;
        b=QJJQfmg1Vsk/e99Pdd1B77NmhIIxCvwJN0XTkSV4NFeCzIranNc5QmMrgG5EocEXWj
         5vvbyKYZ46IohyXvo0xLwS5BVaAh/mriBcBnq+SLiVupzoE0+0sAACS8vqaAUv9mISdM
         FRiOizXeGZMCKo6nh/jPkBM0hfwONc4jbhwXujnaLHgrniueHfyWfqamcc6YKBQulOCw
         71OlgCWlN2c+8l4hBoM4L5thCp8EBFOlDxJD7zrsb01EWqH6ULT0f05nQnG6QmVzL4jq
         N4bcZGMau2ckp1ABGEq8Rcunld5zIavHD1M48+7uOBwc+eom01OfrULu/t0k3vYtgMMc
         +6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765913672; x=1766518472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oc7wkmO1G/O6pko8A6pYs9YQriGWhLxGOsAWt5QrAsQ=;
        b=m+3rxW4zfPcPuorqIJhj0CotfLIpcaBBNPQ0AuyizMKjYzc+jzOCsTtB6xF0xyWP3/
         Om+/KnaEiioaRlAUBPEJFwRRRyT1wvsC9K5++qSRdEJaXU8hqrkMBtooFwEXcvLlBN2t
         5t+qNo1fjVQTGRNQUIhpa8gjYqEDf3JCBS94h0YobI6JmnOFxi1nlnCuI0kQHvIxO/oX
         onR6XiiXvZF3MZg/hnYj+XF6rSpNJ9k9AcRY31RoKZwRNPJE1LwqCJPStCS5TLwG1SAO
         YnvaYab/pjrdEFfDR7aMWjHeewRC4+6P3reUTUNRw8dWm8QN7QkvWmylCFGoYjXlW00f
         QahQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZAEBwpofYe0Ld3AWl/eeaOioFZ4qO2Zk+LlX9hmMNP1ERhK7YtHVs3M12wj0Ar9YDleB4CtPm@vger.kernel.org
X-Gm-Message-State: AOJu0YwZviW5jIRcvaShntDzfg5YG1fvEEooBOuT/h3OgmF2lqeNyb06
	IVd1iTlsDmRDJ4VweuetQMyfytOEwew44LVmnKI96hP7xPo0hIMjswwRfi0sD7Ba9tbMCf/Kvgm
	L2RfYnDzLCODKZhenQgVz7wJYrs6Nh94=
X-Gm-Gg: AY/fxX5YpCgNuxlzgautkw8mrwqFy/yVh52aMkj1WvLOj/jyDQVek4SlWTcu1te578+
	23GgNmo/MOMqKuhxnd2Cn3LQk2q1SkEGjcvoRZ9ighN6+lS/RrcKWQg+iDKxoJi0oeXyRMX1kOQ
	ODkFMa8+TGJwpdFp1/xkBYGgG6Kej/oAxez5hOpOxChMdfGfzRkmtXUpokYtg3I0Bv+rU0HXHvM
	CpkzzM+9t9DoupBa2AlTc/9zFnklWGTBjENCSeXAG0DV/qD6NK6jxyPtjCnT0icldZr2GK606ma
	RX5OkPnl43yNX/SXlhb+bA==
X-Google-Smtp-Source: AGHT+IEsuGduX2I3bXsULyMkGChsdw2z5fq5cnIZQT+MZ84MVYQK1PlYH1Ek/DkKCc50LTlhFjXA528yfrA5Rwazwm8=
X-Received: by 2002:a17:903:37ce:b0:295:195:23b6 with SMTP id
 d9443c01a7336-29f26eff462mr157031955ad.55.1765913671737; Tue, 16 Dec 2025
 11:34:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215091730.1188790-1-alan.maguire@oracle.com> <20251215091730.1188790-3-alan.maguire@oracle.com>
In-Reply-To: <20251215091730.1188790-3-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 16 Dec 2025 11:34:19 -0800
X-Gm-Features: AQt7F2r7RadIHnW-JtgmqkW2Axe8h6an67lvT1fjUpr8JKMz67Elo4iajzTAOP4
Message-ID: <CAEf4Bza+C7nRxFDHS0dNDk5XF79nE6y4GqEu0bmtJPTMoFrNvQ@mail.gmail.com>
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

On Mon, Dec 15, 2025 at 1:18=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> Support reading in kind layout fixing endian issues on reading;
> also support writing kind layout section to raw BTF object.
> There is not yet an API to populate the kind layout with meaningful
> information.
>
> As part of this, we need to consider multiple valid BTF header
> sizes; the original or the kind layout-extended headers.
> So to support this, the "struct btf" representation is modified
> to always allocate a "struct btf_header" and copy the valid
> portion from the raw data to it; this means we can always safely
> check fields like btf->hdr->kind_layout_len.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/btf.c | 260 +++++++++++++++++++++++++++++++-------------
>  1 file changed, 183 insertions(+), 77 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index b136572e889a..8835aee6ee84 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -40,42 +40,53 @@ struct btf {
>
>         /*
>          * When BTF is loaded from an ELF or raw memory it is stored
> -        * in a contiguous memory block. The hdr, type_data, and, strs_da=
ta
> +        * in a contiguous memory block. The  type_data, and, strs_data

nit: two spaces, and so many commas around and ;) let's leave Oxford
comma, but comma after and is weird

>          * point inside that memory region to their respective parts of B=
TF
>          * representation:
>          *
> -        * +--------------------------------+
> -        * |  Header  |  Types  |  Strings  |
> -        * +--------------------------------+
> -        * ^          ^         ^
> -        * |          |         |
> -        * hdr        |         |
> -        * types_data-+         |
> -        * strs_data------------+
> +        * +--------------------------------+---------------------+
> +        * |  Header  |  Types  |  Strings  |Optional kind layout |

Space missing, boo. Keep diagrams beautiful!..

> +        * +--------------------------------+---------------------+
> +        * ^          ^         ^           ^
> +        * |          |         |           |
> +        * raw_data   |         |           |
> +        * types_data-+         |           |
> +        * strs_data------------+           |
> +        * kind_layout----------------------+
> +        *
> +        * A separate struct btf_header is allocated for btf->hdr,
> +        * and header information is copied into it.  This allows us
> +        * to handle header data for various header formats; the original=
,
> +        * the extended header with kind layout, etc.
>          *
>          * If BTF data is later modified, e.g., due to types added or
>          * removed, BTF deduplication performed, etc, this contiguous
> -        * representation is broken up into three independently allocated
> -        * memory regions to be able to modify them independently.
> +        * representation is broken up into four independent memory
> +        * regions.
> +        *
>          * raw_data is nulled out at that point, but can be later allocat=
ed
>          * and cached again if user calls btf__raw_data(), at which point
> -        * raw_data will contain a contiguous copy of header, types, and
> -        * strings:
> +        * raw_data will contain a contiguous copy of header, types, stri=
ngs
> +        * and optionally kind_layout.  kind_layout optionally points to =
a
> +        * kind_layout array - this allows us to encode information about
> +        * the kinds known at encoding time.  If kind_layout is NULL no
> +        * kind information is encoded.
>          *
> -        * +----------+  +---------+  +-----------+
> -        * |  Header  |  |  Types  |  |  Strings  |
> -        * +----------+  +---------+  +-----------+
> -        * ^             ^            ^
> -        * |             |            |
> -        * hdr           |            |
> -        * types_data----+            |
> -        * strset__data(strs_set)-----+
> +        * +----------+  +---------+  +-----------+   +-----------+
> +        * |  Header  |  |  Types  |  |  Strings  |   |kind_layout|
> +        * +----------+  +---------+  +-----------+   +-----------+

nit: spaces (and if we go with "layout" naming, this will be short and
beautiful " Layout " ;)

> +        * ^             ^            ^               ^
> +        * |             |            |               |
> +        * hdr           |            |               |
> +        * types_data----+            |               |
> +        * strset__data(strs_set)-----+               |
> +        * kind_layout--------------------------------+

[...]

> @@ -3888,7 +3989,7 @@ static int btf_dedup_strings(struct btf_dedup *d)
>
>         /* replace BTF string data and hash with deduped ones */
>         strset__free(d->btf->strs_set);
> -       d->btf->hdr->str_len =3D strset__data_size(d->strs_set);
> +       btf_hdr_update_str_len(d->btf, strset__data_size(d->strs_set));
>         d->btf->strs_set =3D d->strs_set;
>         d->strs_set =3D NULL;
>         d->btf->strs_deduped =3D true;
> @@ -5343,6 +5444,11 @@ static int btf_dedup_compact_types(struct btf_dedu=
p *d)
>         d->btf->type_offs =3D new_offs;
>         d->btf->hdr->str_off =3D d->btf->hdr->type_len;
>         d->btf->raw_size =3D d->btf->hdr->hdr_len + d->btf->hdr->type_len=
 + d->btf->hdr->str_len;
> +       if (d->btf->kind_layout) {
> +               d->btf->hdr->kind_layout_off =3D d->btf->hdr->str_off + r=
oundup(d->btf->hdr->str_len,
> +                                                                        =
     4);
> +               d->btf->raw_size =3D roundup(d->btf->raw_size, 4) + d->bt=
f->hdr->kind_layout_len;

maybe put layout data after type data, but before strings? rounding up
string section which is byte-based feels weird. I think old libbpf
implementations should handle all this well, because btf_header
explicitly specifies string section offset, no?

> +       }
>         return 0;
>  }
>
> --
> 2.39.3
>
