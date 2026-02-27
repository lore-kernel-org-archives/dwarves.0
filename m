Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8219D20E030
	for <dwarves@vger.kernel.org>; Fri, 27 Feb 2026 23:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772234201; cv=pass; b=lL7Qap9F0csswLT+uMAdMVZSjZ3EPi93bWJRhz2ARZ79yijat3VufHvHtjtEhNoWvF0tEAjCQtPaMLx/M9ivaATouPtOTs6l4yhi8UwKPNGA/V6Uv/CaVMvSOV9Dx0zmG6uUZav9P6QSj/RhGz8pLJR9z+qhJPyqVISVpGRiCr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772234201; c=relaxed/simple;
	bh=5bEY5UXLzjWPh44w4Cx2basuFz8GnNVWmKBlQs+YDkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bYR+8+9RplLX0AvuXf+v8/dQ7yuZ6wJg2XK7drkOZtrFOKMqEJZxZCTUu1c1TS3aOJ4jomOOBVZRyJYXYaqQNwNUzlLOBjoFdoz2gCofmDY8CGWRc1idEOcBUWkmBJvZVp4p77G8se+wmxF5Qx5/zPRqVa2K7oPuz7v8oyjN368=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hm1b7ubA; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hm1b7ubA"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43994aa265eso1501157f8f.3
        for <dwarves@vger.kernel.org>; Fri, 27 Feb 2026 15:16:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772234198; cv=none;
        d=google.com; s=arc-20240605;
        b=TEeTLMSWqwOSxOnBdBxKim8nhBGA3SIq2PK2mKp8aRiXjhXyEPSqYJEGD80YH+gdnv
         wWqVBbmXVJAlQnzabn83OfwJwMFqJhMznJrAuzvfmINUGaN83KadNAwFko99DAsFdL8z
         YRYJ5jqW5C+h8RzxSiqO5861LVvQkXXD1aEZ/RnopRdgLz/lx3AdFmk9zbE/ecqDfKm6
         m7+egxdDd+iapqKJ9f6o+YZdRiJYyxHRhQE5pScPzZrNq+5AbzPS7nYf0QIkKSocMZFB
         JkX3Ouiz+CCdVJs3gZzkAEI7G5+HNMgVuTA+XpmbigMnkBDo/F6Flm/Qr6fWqVSfvkth
         jABw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3xNg2kQtCk3Ev8PHb+VBqW9Vt5j3KhL+uqlascRwyC0=;
        fh=j6jffsCEtWjBPWK5bnmz0YxtzhDpuW3XEmePOrh2hKo=;
        b=Ce9YkU08eVY67DiXXavn6IU0RbjxBV4y5ZZIYbXRi9I0kWyVPCXGV2Vwp+37lTw7s1
         KTkp5sld7FEa5bFuFlbsGXei0y8M4krbAO5l//nLmTjxJSxarsQg8jO8hx9oZC0P3MZi
         5U6XY/Ax0YY8mLwbNJUSw01T1BgxzI0CKl8AWjptAumOCRIBktyv0ONnqVpHer173wWn
         UJksK6ApRLmPePseJeHL1Tr/6bACbvyNbzYLLnUF3Wd4ehr710m2tEq2CTk3DRCpyrnt
         cVhJRiMBvcrzoW5S5IdlBC13W5ihefSWzYlGhNVcwWfZxsWYq5i+Ri7QPBwr7WoJhn1A
         HCtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772234198; x=1772838998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xNg2kQtCk3Ev8PHb+VBqW9Vt5j3KhL+uqlascRwyC0=;
        b=Hm1b7ubA/WI3ynYaEofIMSVmOR27iFc93OSXQ1yRjCC+ElwWEyjwIEWEek+83Si9e1
         HeUwxmdKL6yGR12YfiLxnuq3OmP0z8Jgk0C6iYY1ZXVTrVFE2qKVP6HrpFdQGDTXRs6C
         S/lURKKVVe75gVH50P+GxmA+mw9mU2DaKcVDz0zyJcvA2WBUXUXN1kAwvvBGtexABPqa
         qqW8t8yUL2QlkFmrxdnEpe343rM23hlCOJmlLb6LzLqnsZx9awtas7aXvNknWM6Jf4RF
         pjh/l6HcT9LAxaE1q4b3SpJMLWTFTCkXHQPHgVYn+n/1AVcvLMuoduTsmPwsqSEuUZ+K
         wk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772234198; x=1772838998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3xNg2kQtCk3Ev8PHb+VBqW9Vt5j3KhL+uqlascRwyC0=;
        b=qCRT6GLnsVSPWXmz8Z7LH4PyrX1eSaS9k+JCM+5xcLLHeeNMjCdd6VJJEQDjq0d9+i
         w8SbJx/1DTdJ0B1xM0Ai9DSPWf9fTYn8TK3y9Vku//xElXLr2j3HYEDU/+fTAT0+ExhV
         +ueLR9b9fpLKY7YN6XiXrhh4UzOH6FFLV/LtNU9jS0R1sLcBu8aKh66h8ynxxENLdKvz
         4j+oA9dnKLTl7DC4D3oQ90rMhHQEVpDdm0G2ndOhKWQ3mGLuokU9RdHoKal46JKcHlse
         hkrMY8eZ1znAmclnqkF96MPsyJ/zwV99hqyxE1ScvpxbZIFMmbJ4Wx+Egq3e4umg+/kx
         ldUw==
X-Forwarded-Encrypted: i=1; AJvYcCUL6GjNbnWvAtPulusKyBWvPYUJyeZWJ2DxaoK+Pxz/+F1VICQj534xtxY1mktqJbGHVuLi+VMk@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm+3aExRlOugGZirKag+vNxV2biTdD/EExZUgI3Yf0yxw/7/iR
	MEJsoh+LiJW6hF/DLIzTEugSg+o75/JuCrtzB6V6YZ0vP8Jv0aj3RWfcHqlM9f4yRdP3ZS8Dn/K
	l7hpkiBNRIpdEtibG6MpUtQmQFQauozY=
X-Gm-Gg: ATEYQzwHprfhnWgTKg/wypvnkIYmD9138i2eQunDC20PZMrPtRwIzi7z77ML+qfaxrM
	ZWfShsLrtWfGCE6+stdgxxarmLAxsKH92Mw+WcVAWsWHCpPc5m1y4ub1Yc5mrPICUnY0Xy95fDG
	C7ygSaCo42QABfndVXcwqa8gSzHu15zCCdyfsvS0cx8Wr91+unTqUnQaNKSTdsQtcNGwa1nLN0K
	A8zYJEsxwXOnd2S/DAl7jLfCk0h6kJZi9PuTFJWIPGTbpTj1d909VGjAX2RCCLO0X4J4h0jf2+f
	Wm0+dyVqQlk3QlCLLD0a/VcypO1gnFLM4WYofL+5fAVTk8wLexX9+A+/xPND42Q8lGEj0tD7bx7
	wemNVLECafYgzuOcsWQK2AIA+EQ==
X-Received: by 2002:a05:6000:2012:b0:437:678a:5921 with SMTP id
 ffacd0b85a97d-4399ddd877emr7625802f8f.1.1772234197736; Fri, 27 Feb 2026
 15:16:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227100426.2585191-1-alan.maguire@oracle.com> <20260227100426.2585191-9-alan.maguire@oracle.com>
In-Reply-To: <20260227100426.2585191-9-alan.maguire@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 27 Feb 2026 15:16:26 -0800
X-Gm-Features: AaiRm53oYnNJ13pPYwBxjbvQcsIicGI5cpjaxTq7RmFZBNQScvLsj-YfhPsJ9GQ
Message-ID: <CAADnVQLTwLSWaN8arz5NmCwqJxd3DPhtKn2is5AgrQ0AwYFi7A@mail.gmail.com>
Subject: Re: [PATCH v10 bpf-next 08/10] bpftool: add BTF dump "format meta" to
 dump header/metadata
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, dwarves <dwarves@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 2:05=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> Provide a way to dump BTF metadata info via bpftool; this
> consists of BTF size, header fields and layout info
> (if available); for example
>
> $ bpftool btf dump file vmlinux format meta
> size 6516862
> magic 0xeb9f
> version 1
> flags 0x0
> hdr_len 32
> type_len 3929096
> type_off 0
> str_len 2587654
> str_off 3929176
> layout_len 80
> layout_off 3929096
> kind 0    UNKNOWN    info_sz 0    elem_sz 0    flags 0
> kind 1    INT        info_sz 4    elem_sz 0    flags 0
> kind 2    PTR        info_sz 0    elem_sz 0    flags 0
> kind 3    ARRAY      info_sz 12   elem_sz 0    flags 0
> kind 4    STRUCT     info_sz 0    elem_sz 12   flags 0
> kind 5    UNION      info_sz 0    elem_sz 12   flags 0
> kind 6    ENUM       info_sz 0    elem_sz 8    flags 0
> kind 7    FWD        info_sz 0    elem_sz 0    flags 0
> kind 8    TYPEDEF    info_sz 0    elem_sz 0    flags 0
> kind 9    VOLATILE   info_sz 0    elem_sz 0    flags 0
> kind 10   CONST      info_sz 0    elem_sz 0    flags 0
> kind 11   RESTRICT   info_sz 0    elem_sz 0    flags 0
> kind 12   FUNC       info_sz 0    elem_sz 0    flags 0
> kind 13   FUNC_PROTO info_sz 0    elem_sz 8    flags 0
> kind 14   VAR        info_sz 4    elem_sz 0    flags 0
> kind 15   DATASEC    info_sz 0    elem_sz 12   flags 0
> kind 16   FLOAT      info_sz 0    elem_sz 0    flags 0
> kind 17   DECL_TAG   info_sz 4    elem_sz 0    flags 0
> kind 18   TYPE_TAG   info_sz 0    elem_sz 0    flags 0
> kind 19   ENUM64     info_sz 0    elem_sz 12   flags 0
>
> JSON output is also supported:
>
> $ bpftool -p btf dump file /var/tmp/vmlinux.kind_layout format meta
> {
>     "size": 6516862,
>     "header": {
>         "magic": 60319,
>         "version": 1,
>         "flags": 0,
>         "hdr_len": 32,
>         "type_len": 3929096,
>         "type_off": 0,
>         "str_len": 2587654,
>         "str_off": 3929176,
>         "layout_len": 80,
>         "layout_off": 3929096
>     },
>     "layouts": [{
>             "kind": 0,
>             "name": "UNKNOWN",
>             "info_sz": 0,
>             "elem_sz": 0,
>             "flags": 0
>         },{
>             "kind": 1,
>             "name": "INT",
>             "info_sz": 4,
>             "elem_sz": 0,
>             "flags": 0
>         },{
>             "kind": 2,
>             "name": "PTR",
>             "info_sz": 0,
>             "elem_sz": 0,
>             "flags": 0
>         },{
> ...
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/bpf/bpftool/bash-completion/bpftool |  2 +-
>  tools/bpf/bpftool/btf.c                   | 91 ++++++++++++++++++++++-
>  2 files changed, 89 insertions(+), 4 deletions(-)
>
> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftoo=
l/bash-completion/bpftool
> index a28f0cc522e4..d49d6a70cb74 100644
> --- a/tools/bpf/bpftool/bash-completion/bpftool
> +++ b/tools/bpf/bpftool/bash-completion/bpftool
> @@ -950,7 +950,7 @@ _bpftool()
>                              return 0
>                              ;;
>                          format)
> -                            COMPREPLY=3D( $( compgen -W "c raw" -- "$cur=
" ) )
> +                            COMPREPLY=3D( $( compgen -W "c raw meta" -- =
"$cur" ) )
>                              ;;
>                          root_id)
>                              return 0;
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 946612029dee..08dc6a86bc85 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -835,6 +835,87 @@ static int dump_btf_c(const struct btf *btf,
>         return err;
>  }
>
> +static int dump_btf_meta(const struct btf *btf)
> +{
> +       __u32 layout_off =3D 0, layout_len =3D 0;
> +       __u32 data_sz, i, nr_kinds =3D 0;
> +       const struct btf_header *hdr;
> +       const struct btf_layout *l;
> +       const void *data;
> +
> +       data =3D btf__raw_data(btf, &data_sz);
> +       if (!data)
> +               return -ENOMEM;
> +       hdr =3D data;
> +       if (json_output) {
> +               jsonw_start_object(json_wtr);           /* metadata objec=
t */
> +               jsonw_uint_field(json_wtr, "size", data_sz);
> +               jsonw_name(json_wtr, "header");
> +               jsonw_start_object(json_wtr);           /* header object =
*/
> +               jsonw_uint_field(json_wtr, "magic", hdr->magic);
> +               jsonw_uint_field(json_wtr, "version", hdr->version);
> +               jsonw_uint_field(json_wtr, "flags", hdr->flags);
> +               jsonw_uint_field(json_wtr, "hdr_len", hdr->hdr_len);
> +               jsonw_uint_field(json_wtr, "type_len", hdr->type_len);
> +               jsonw_uint_field(json_wtr, "type_off", hdr->type_off);
> +               jsonw_uint_field(json_wtr, "str_len", hdr->str_len);
> +               jsonw_uint_field(json_wtr, "str_off", hdr->str_off);

I don't think this part is useful.
People can hex dump it if they really want to.

> +       } else {
> +               printf("size %-10u\n", data_sz);
> +               printf("magic 0x%-10x\nversion %-10d\nflags 0x%-10x\nhdr_=
len %-10u\n",
> +                      hdr->magic, hdr->version, hdr->flags, hdr->hdr_len=
);
> +               printf("type_len %-10u\ntype_off %-10u\n", hdr->type_len,=
 hdr->type_off);
> +               printf("str_len %-10u\nstr_off %-10u\n", hdr->str_len, hd=
r->str_off);
> +       }
> +
> +       if (data_sz >=3D hdr->hdr_len && hdr->hdr_len >=3D sizeof(struct =
btf_header)) {
> +               layout_off =3D hdr->layout_off;
> +               layout_len =3D hdr->layout_len;
> +               if (layout_len > 0 &&
> +                   (long long)layout_off + layout_len + hdr->hdr_len <=
=3D data_sz) {
> +                       l =3D (void *)hdr + hdr->hdr_len + layout_off;
> +                       nr_kinds =3D layout_len / sizeof(*l);
> +               }
> +       } else {
> +               if (!json_output)
> +                       return 0;
> +       }
> +
> +       /* unconditionally display (possibly empty) layout info for json =
only */
> +       if (json_output) {
> +               jsonw_uint_field(json_wtr, "layout_len", layout_len);
> +               jsonw_uint_field(json_wtr, "layout_off", layout_off);
> +               jsonw_end_object(json_wtr);             /* end header obj=
ect */
> +
> +               jsonw_name(json_wtr, "layouts");
> +               jsonw_start_array(json_wtr);
> +               for (i =3D 0; i < nr_kinds; i++) {
> +                       jsonw_start_object(json_wtr);
> +                       jsonw_uint_field(json_wtr, "kind", i);
> +                       if (i < NR_BTF_KINDS)
> +                               jsonw_string_field(json_wtr, "name", btf_=
kind_str[i]);
> +                       else
> +                               jsonw_null_field(json_wtr, "name");
> +                       jsonw_uint_field(json_wtr, "info_sz", l[i].info_s=
z);
> +                       jsonw_uint_field(json_wtr, "elem_sz", l[i].elem_s=
z);
> +                       jsonw_uint_field(json_wtr, "flags", l[i].flags);
> +                       jsonw_end_object(json_wtr);
> +               }

This part, I guess, is ok-ish.
I wouldn't do it either though. Feels like a debug feature.
