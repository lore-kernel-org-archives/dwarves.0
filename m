Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70928139579
	for <dwarves@vger.kernel.org>; Tue, 16 Dec 2025 21:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765919093; cv=none; b=Ze9rh7RtSOFAG/y0O8deNH1l+OIBLYGJP+mMiNws698DJmFMSKhaz3hPJJtM+RJe6lHqdT8hBSOGPiebG4rt5Tl5Lz7u7Lk6GucoQRPERUnK8NhYKcB4CKNJgp4RHmV86K6v2CLS5ftkNB/wS2rrOg7I4eQguCAGhVssGOou9ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765919093; c=relaxed/simple;
	bh=FDeqb4YVxKH/kBQ78qSpKhuU3RRP/gsIDLhtpIGKkso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cRkYYaxMyVw8lsVEvQFQtPVYb0fNISzIrxCTPUYb5Q6DXRpD5b5gVh/pic7LQjM6+ucL2BTzgvmWqOXAQACOt0YPl2d0ks+FWc8m2KCNglQuCyHp+wqZCSCU2RxIe8qFAYyzVZPU89LnA92geRfLwLdnGoTalwkIKkgx4Hu5BR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUoDVYSI; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUoDVYSI"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-34c5f0222b0so2634498a91.3
        for <dwarves@vger.kernel.org>; Tue, 16 Dec 2025 13:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765919091; x=1766523891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIXd/dFGyEZDpmc4f1kvbOIwtnfZwt/kYFCBECgbqUI=;
        b=FUoDVYSIFvWWLCn+Iu80vXvllnLbyEMu0e17MJk4oXbZeIfOK9jXrUTSLKvvXn/pjI
         +bFD/lY9bbh3OhmdL337Tv7fE4/UA2gsTkygfyo8RG/HotXP6A1kvrH8IHkWHWB+pwwp
         79SicwiOzO3clw56ixWEkn6GP3rS1jYKA0VwBLa/0k4j6KrPtcCFpabCpwlev740Zsc/
         LsKHxXDPDXUgjIkmmb1kruxh4vtanv0EHLsNZfXrPclxdCbSWwpKlT2b2943sPQ43rw3
         Fp1uDOKFpc71oJ/BvUiabGtmJ9OvUFTfdIs4QvE3FUKAZRcZecqJ/q62tm5pCnOox30f
         41Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765919091; x=1766523891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EIXd/dFGyEZDpmc4f1kvbOIwtnfZwt/kYFCBECgbqUI=;
        b=Oct9JnGXr7cKbYAbDq6g+Ne2DBGWBVCW3K5tJsFb8O8z6qOzkD3+KcJBcp0s57yoHA
         0vFnnuGX6CU6wolGrS9k3JIAFxAgOi7jwy1GZ3nzQLCrY0BodDPUOmVnIOVm90JodEx6
         Co/HML6adNraJzWb8YaE8x3m+tsOOTvt8PZnspF5i+Kc1B0Wu6CsWMqwjcv9CWRj/NKG
         yhS/E1khyL9WHL+jtqahNJ3Fv0e5kZUF6SPtJsan7Hex51+KGpll3htYOVoSTpBJpV2M
         2oLmH9IFo2xr7p//200pPLN1sMgDALjknn1UKZ2MB1zQ2yw6oamLfAK09W48zmbq7p2A
         oH5g==
X-Forwarded-Encrypted: i=1; AJvYcCWeoGYGrWkSLNJyoyT1gFALdfQBYrg+Z2gKhj0JHvzOTWQxYpV2hjfNmTN5aEkrSW8YFFEqAnPJ@vger.kernel.org
X-Gm-Message-State: AOJu0YytNFRErrAhC0NamvpQdOrAtqJZNX0BUHdGVrbWoEFvAVBFa6gO
	cZhr9OBd0aBO0N+XI0AnxyHuC0hqPm9UQE8uMh2gSWw7nPSk8naUsjW67PflEkQwd7/N0CYFwn7
	u/1g13h4JS8k53e3ZyZm3UpXkMJ6nsL8=
X-Gm-Gg: AY/fxX6Y0abzNecINpEF+jK8yXMSalxXxK8S5syAGRgkD2N+DnU0/6Jv9XqstzkbujJ
	ibUsKDFaQx7P7PlI8iKOfjrof2xQgHYZDcCFu5j4Vg2xe8FO+X2cmWScTLVWKAH9CSMUJ8FOgC3
	f50VgLqqNHt7jQdoSJPKOMI7zp2Tp+p701PRwTwxNPaO04t16uWwPnrmEH+LH4doImYE/q6TrFC
	JyLLWiJQbJth86L8MOMXLlBOr1WgDKr3di6GDus/AJglVRvNwvATbtaJRwePsE+IzyBJ2dVx1fw
	CTQAlU/oSEkwFeUR9byntg==
X-Google-Smtp-Source: AGHT+IFMIwh21ikhDKMfcfZPq4afb5cjuBNy7xli0B2P36QEj2XlMh+oD2CeTSCGleHnEUkf/OoKwXOajg43jVFbqkg=
X-Received: by 2002:a17:90b:2891:b0:32b:9774:d340 with SMTP id
 98e67ed59e1d1-34abd78d3a2mr13349984a91.33.1765919090552; Tue, 16 Dec 2025
 13:04:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215091730.1188790-1-alan.maguire@oracle.com> <20251215091730.1188790-5-alan.maguire@oracle.com>
In-Reply-To: <20251215091730.1188790-5-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 16 Dec 2025 13:04:37 -0800
X-Gm-Features: AQt7F2qWwrDEBXsFsq1OiDW_11tfqC-ZuahsYEDLv8_rqpT-CV-RT2EpvUPVwIQ
Message-ID: <CAEf4BzZuFB6zvMjdqKDumUAT4vr5MeA3LBqTh5xRZmAQ5KC10g@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 04/10] libbpf: Add kind layout encoding support
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
> Support encoding of BTF kind layout data via btf__new_empty_opts().
>
> Current supported opts are base_btf and add_kind_layout.
>
> Kind layout information is maintained in btf.c in the
> kind_layouts[] array; when BTF is created with the
> add_kind_layout option it represents the current view
> of supported BTF kinds.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/btf.c      | 60 ++++++++++++++++++++++++++++++++++++++--
>  tools/lib/bpf/btf.h      | 20 ++++++++++++++
>  tools/lib/bpf/libbpf.map |  1 +
>  3 files changed, 78 insertions(+), 3 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 3936ee04a46a..589a9632a630 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -29,6 +29,35 @@
>
>  static struct btf_type btf_void;
>
> +/* Describe how kinds are laid out; some have a singular element followi=
ng the "struct btf_type",
> + * some have BTF_INFO_VLEN(t->info) elements.  Specify sizes for both.  =
Flags are currently unused.
> + * Kind layout can be optionally added to the BTF representation in a de=
dicated section to
> + * facilitate parsing.  New kinds must be added here.
> + */
> +struct btf_kind_layout kind_layouts[NR_BTF_KINDS] =3D {

static?

> +/*     singular element size           vlen element(s) size */
> +{      0,                              0                               }=
, /* _UNKN */

use

[BTF_KIND_UNKN] =3D { 0, 0 },
[BTF_KIND_INT] =3D { sizeof(__u32), 0 },
and so on

it's succinct and self-descriptive

[...]

>  static struct btf *btf_new(const void *data, __u32 size, struct btf *bas=
e_btf, bool is_mmap)
> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index cc01494d6210..dcc166834937 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -109,6 +109,26 @@ LIBBPF_API struct btf *btf__new_empty(void);
>   */
>  LIBBPF_API struct btf *btf__new_empty_split(struct btf *base_btf);
>
> +struct btf_new_opts {
> +       size_t sz;
> +       struct btf *base_btf;   /* optional base BTF */
> +       bool add_kind_layout;   /* add BTF kind layout information */

Why an option? Let's just always emit this. And teach libbpf to
"sanitize" layout if the host kernel doesn't support it. Looking at
kernel validation code, it should be enough to just zero-out layout
len/off fields in the header. (Maybe we'll need to zero out layout
data itself, but I don't see any zero checks for that, so probably is
fine without that).

As a general rule, let's avoid adding options if we can just make it
work unconditionally. Options are never a great solution, it's just
sometimes a necessary evil.

> +       size_t:0;
> +};
> +#define btf_new_opts__last_field add_kind_layout
> +
> +/**
> + * @brief **btf__new_empty_opts()** creates an unpopulated BTF object wi=
th
> + * optional *base_btf* and BTF kind layout description if *add_kind_layo=
ut*
> + * is set
> + * @return new BTF object instance which has to be eventually freed with
> + * **btf__free()**
> + *
> + * On error, NULL is returned and the thread-local `errno` variable is
> + * set to the error code.
> + */
> +LIBBPF_API struct btf *btf__new_empty_opts(struct btf_new_opts *opts);
> +
>  /**
>   * @brief **btf__distill_base()** creates new versions of the split BTF
>   * *src_btf* and its base BTF. The new base BTF will only contain the ty=
pes
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 84fb90a016c9..0fb9a1f70e72 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -453,4 +453,5 @@ LIBBPF_1.7.0 {
>                 bpf_map__exclusive_program;
>                 bpf_prog_assoc_struct_ops;
>                 bpf_program__assoc_struct_ops;
> +               btf__new_empty_opts;
>  } LIBBPF_1.6.0;
> --
> 2.39.3
>
