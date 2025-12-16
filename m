Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F4D31CA7B
	for <dwarves@vger.kernel.org>; Tue, 16 Dec 2025 19:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765913849; cv=none; b=Xvcmhm/wnNOuhETPA23x5V8CeGKrEFD41mV7Xs7220pJtSHeUwzKnLP3tsZre9NoNzQG/ZRusO87+Ps/9o8InZo2DvGAwCO9HH/pd7Pi8jNvwgq8zmokaBzS3cfHE+9roGZc/PPXUmwUhi65M0VRMyKEeU/NUgKpGPWs+K33Cyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765913849; c=relaxed/simple;
	bh=4T87opl1MhUsqElKkPBN1qdTf4dvDuH6O9SZ0RiiiaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iJwP+65htWnGmz5OUTo4fTSbg/W6b7CTsG1adVSePGZHHfqGXna7VNkvI7zQZo/BBuXPbv7UuFBQJsf8cp91HqHRew0ikFySoalS6kTlJm1pvbmSglf8TtQfO800CPkRWUCd82SRaIooCvP9PzXr1pcmfxa/Z1X4LjywF8iz7eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SilsQ5LJ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SilsQ5LJ"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34c21417781so4238218a91.3
        for <dwarves@vger.kernel.org>; Tue, 16 Dec 2025 11:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765913847; x=1766518647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OV/pHipMQLh0hDMe1/upHJtQtKiIxsYJe6Wq15q0SJU=;
        b=SilsQ5LJ1Z/2cUi6T34a3VDv1IcGLY0W7KK8B5veXkzmngnv0jUscRvo/yosMB5/zF
         ziOcdk21eRzbO1oDJcXpKNuBy3pDiLQwN+tpcJzfmKToAJtk00HPEBpAviFBEW8QYkBz
         PN2tfqYc5BbBdRAbn30HEaoSf2NNkLCWeHO1eR9CeSUMR94LwgQ53Dktxqd1cDAPwA01
         aWuxK1hKQN/jH4I3zVnjyhQ3u46nRf5V+qUPFgnnsKMSBcHFvlfb+u9c5DlbxTp3Lxdc
         fIx5h6Xuyz/xO01GwYVhxuwY5fJ5NNRPmwah/m9BzrDNjeMs+pbrbtLlQ2muizZycHG7
         LBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765913847; x=1766518647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OV/pHipMQLh0hDMe1/upHJtQtKiIxsYJe6Wq15q0SJU=;
        b=fGI44ZneqCy235hHAVprdIvjkRnFMGJhQRJdEkYTX3HEqJY4kg5xTGnO//0Znb/koz
         x3kRO5PVsy4jHerE6jnL9wENdDOIOA6r8boBGVjAXWGKtws7dOkE/Z/BjHa1fK9d4ZfQ
         l3sEhQBofca/+/AERsp2Z49CjuJgKXLrmJ3jFtDqRlcLE1gJs4B4ElIsZRyCA6hIKUIp
         gTOLw9PuJxhCRMG25AwkAsmw50/gyEJMfUUF8LunTWtA6eQTsPib6YntsggaUiOLy0rz
         asqAFS3owbncH9bD5vBj1/15kchm8NCjFnLQLcu2Nw845QxO89RuJzoRPDSttThB3vB1
         kNtg==
X-Forwarded-Encrypted: i=1; AJvYcCUpNhI6HT/d9aPHdjZdmfP5InnbA0QEop6ijLL2sbU1CyNrTwbiBzRKirsF4enb5+E8nNvBNj5Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7GX3exsDEz+0dDBKsGatRRxKU1ZmBd1KkfKwupBmY1r4HrLqz
	ha+G23hdJFwalErEfEspKM/oHcGtg/CaBBjh2pN5cT219RtpIQU3EKfSESm7d7tdjtfzMuqV5GK
	1EWYnfM1L/SBzOzN7Iy7HvE/djy0N2kE=
X-Gm-Gg: AY/fxX7WY59ebMR14xSZWcDtL6Svf/j9zLihM5lAED6Dgp6sLUnyo6rvr9H59T+1b5F
	qjArJPXQmwqUDgtUFIpi2GmU9Bt9QPc2MhdywqyFW8X7dPVYfHv2Fd1rSyZ0+FwnJVLNPU3BYln
	3ho/4s38vOguGulHUaHtoqnEbACh7I2F/oqMFDdiqpNoVeS/fO9z+XTcU5cPieiXxZHV5btJP5v
	aX3KfdlraGd8DEozcMgjanLxAGQ3GGdaMvcSUM3LaZ0mHX35WuXIdeNU7Mw2+ta6qAnlSXlsu7p
	MEcuzuazeYA=
X-Google-Smtp-Source: AGHT+IH4+VPbnc+Q69iIjOdzqoJhOjlzXEjC1IbbYnKAb7DLXDcS7MZtD66nNclFkwVmOAo2VEquHf7Lwyt4D4MRjZU=
X-Received: by 2002:a17:90b:3f85:b0:341:a9e7:e5f9 with SMTP id
 98e67ed59e1d1-34abd5dc26emr14755404a91.0.1765913847131; Tue, 16 Dec 2025
 11:37:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215091730.1188790-1-alan.maguire@oracle.com> <20251215091730.1188790-4-alan.maguire@oracle.com>
In-Reply-To: <20251215091730.1188790-4-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 16 Dec 2025 11:37:14 -0800
X-Gm-Features: AQt7F2pcpQIXGIt4MZQ1hdQibCI191OMDvdx_dZEMA0OsU3STCe9YwzYn4HroBk
Message-ID: <CAEf4BzbsLMgRuJz0PGDojZG32G0GQcSKnt4F9CVVROLPXHY+TA@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 03/10] libbpf: use kind layout to compute an
 unknown kind size
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
> This allows BTF parsing to proceed even if we do not know the
> kind.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/btf.c | 34 +++++++++++++++++++++++++++-------
>  1 file changed, 27 insertions(+), 7 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 8835aee6ee84..3936ee04a46a 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -359,7 +359,28 @@ static int btf_parse_kind_layout_sec(struct btf *btf=
)
>         return 0;
>  }
>
> -static int btf_type_size(const struct btf_type *t)
> +/* for unknown kinds, consult kind layout. */
> +static int btf_type_size_unknown(const struct btf *btf, const struct btf=
_type *t)
> +{
> +       int size =3D sizeof(struct btf_type);
> +       struct btf_kind_layout *k =3D NULL;
> +       __u16 vlen =3D btf_vlen(t);
> +       __u8 kind =3D btf_kind(t);
> +       __u32 off =3D kind * sizeof(struct btf_kind_layout);
> +
> +       if (!btf->kind_layout || off >=3D btf->hdr->kind_layout_len) {
> +               pr_debug("Unsupported BTF_KIND: %u\n", btf_kind(t));
> +               return -EINVAL;
> +       }
> +       k =3D btf->kind_layout + off;
> +
> +       size +=3D k->info_sz;
> +       size +=3D vlen * k->elem_sz;
> +
> +       return size;

return sizeof(struct btf_type) + k->info_sz + vlen * k->elem_sz;

Stateless, explicit, single line. All good properties.

> +}
> +
> +static int btf_type_size(const struct btf *btf, const struct btf_type *t=
)
>  {
>         const int base_size =3D sizeof(struct btf_type);
>         __u16 vlen =3D btf_vlen(t);
> @@ -395,8 +416,7 @@ static int btf_type_size(const struct btf_type *t)
>         case BTF_KIND_DECL_TAG:
>                 return base_size + sizeof(struct btf_decl_tag);
>         default:
> -               pr_debug("Unsupported BTF_KIND:%u\n", btf_kind(t));
> -               return -EINVAL;
> +               return btf_type_size_unknown(btf, t);
>         }
>  }
>

[...]
