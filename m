Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C741F29B204
	for <dwarves@vger.kernel.org>; Thu, 18 Dec 2025 19:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766087902; cv=none; b=tZMN4ggJqqVVsEdkjCnQiZODRvvalos0r9ctUwlAVXxBlUU7IBgDj4fnAHQhpC/Y2yZMzJr0XO5178Iu1JBBg79urOekPmQqtSrmW3ltxTjnVTtbniAKtQ7Ga6Sz/F+qh5/3M0HH1oNkSmWpuXNK2DBPlk5LDp44WqnwFTkQqwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766087902; c=relaxed/simple;
	bh=VeM3OJs75KWSs1s7ckUiCSzaCdotFMQP1yTobcW6rlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MR6ZoEUDBqyisq15qcXm3ZA4taUeoVuLNZaXWvZilJPlsFQFZa6cyyrU0180zlxLclpgKLyZvJG3pICRG7zNXd3qNlMpauThzHf/uHl3vseNdsk7UbxrF+MCyQ27+Q/LYzw18peD7HZJ80w4DV8pjb6y8uzRv8zeiViFB8QaiWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KdarAu+E; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdarAu+E"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34ccdcbe520so481627a91.1
        for <dwarves@vger.kernel.org>; Thu, 18 Dec 2025 11:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766087900; x=1766692700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jnOcnFnpSPGhMG5nqqe5zyzdTWJk6oajdNhIdN6DrQ=;
        b=KdarAu+ECkXqxH2RsPSLEoggyJk9slNgUTLk5tFVr6k3s6XxzDZlwQmICW192usR2F
         ULagLXWu2iAZdYHBHuNMA1evXyS8j/x8g+eoeY5ja6EBz1/myVtJspaVAZ2j1AfDhuhw
         Kats1sainWSA9KYt3Djf7qEbZ5C1tRaae5Y925QAx2dF+w/BRqwjXZTojQjNINIHbyYO
         fXfViQNbwyIKyEQYPue4KAAfNoKnQKeaYjuAc9+C46XIESNWu3kqXrWkFXZsj0uvNQHc
         pli3TO4E11qR7hg/Yg/6pOFPmwZks+nhA6Z9hwgWX5kQQNHpp007jkROI2PYNcq882I1
         bnuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766087900; x=1766692700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0jnOcnFnpSPGhMG5nqqe5zyzdTWJk6oajdNhIdN6DrQ=;
        b=X+kBus1ZJj6P4ZInaNjMhkHEXJJtjuYvp4BX7JLeZ3dyHjQnF9h52Bb6iOPrTOmMtq
         bdUgzJ0aRJrX7b+9FH2YUytr5cOqm1zjeYe00jh/8D5dByseB26wTTJmLiM8FlJooKPm
         7DfKRhAwYf052Obj9VLSmJi3wVmPDsjJmKfCK/wkhLV1TOREAg8kwCUK7w6pEuHKlzwa
         e73q2uR5GkzZyKS9r1+d8ejKHmweeqQOv4tcZ+qO6FOwdU27pp0Rqdo7Wgpu3oDsDzpv
         Qpr2M46vWrJhfgcqt4Aa82YVBsI+xF4xL9GvDuhzs6/FsWrMoZSU1+GPkb6hCmrtDm9t
         619w==
X-Forwarded-Encrypted: i=1; AJvYcCWGEmQHCrtHpucM4b1KcZjCP88iWo33U2EMlxAA2H6XRn41QQD9ecL9gflPnquP+1aapz9CFo79@vger.kernel.org
X-Gm-Message-State: AOJu0YzGSxUbummRoRqxEO8mx8TJ+MNnUvYo0ps7Mb5sdv3MGDXiKtY5
	zM7q27udqbkMqitjXdtpgSFiHRixU0fBJI5GJO7HKU4e9/Ctu68CrQ/bp+Gqj7XKLln/vocWq7z
	WCHN/A4ebOwrkyjvD17O1Nlfcw9UfrIk=
X-Gm-Gg: AY/fxX7LoQEh0CbvEyOOcQYzh2z5eUBGr2FA5EgxJ/AJEXEzpXqQt7pfBXSuMLWIVL5
	DcVgKcxJ0lYPXOX8qiPohjNfwTdFS1RPmVsgerdJY+IMszeMiUSpeCcyn58e4LJyhkci5SmqEFv
	6NTtPDUhdgKfVsgne9QyjhkCo7VclrW6mz8MF3jgDIHvMat83nLo2Rdl/D9PnAvxw60mMV7e/rm
	ByXOAZm+5Culkvp9qamUNrHkHj82PvOLFjN0V0GGrl5cRtjzHWlVBdy+crFDCv7EwaRNxGYlQz/
	XINWAtsvLas=
X-Google-Smtp-Source: AGHT+IFHsN1ggcHGGK017zsJZDYebTkWT4IUvNBSnL0IZX0twQMbqEdMVRFFDZiQhKCRPXJgR7+UNOnrSfcaOKCpzKE=
X-Received: by 2002:a17:90b:28cc:b0:34c:6a13:c3bc with SMTP id
 98e67ed59e1d1-34e71e0a19dmr3339305a91.9.1766087899778; Thu, 18 Dec 2025
 11:58:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218003314.260269-4-ihor.solodrai@linux.dev>
 <106b6e71bce75b8f12a85f2f99e75129e67af7287f6d81fa912589ece14044f9@mail.kernel.org>
 <d9b9e129-349b-4510-bf33-01b831c2174b@linux.dev>
In-Reply-To: <d9b9e129-349b-4510-bf33-01b831c2174b@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 18 Dec 2025 11:58:07 -0800
X-Gm-Features: AQt7F2p48Gmilc3nV7XwZv5cvWFMLs7_EpbDLoqocIvuXu77FjccU8vvsXHjSr4
Message-ID: <CAEf4BzZXzQ6fZetTA8Trwa_pu7o1AJuMyUuHbW9YXHYGQL-_HA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/8] resolve_btfids: Introduce enum btf_id_kind
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bot+bpf-ci@kernel.org, alan.maguire@oracle.com, ast@kernel.org, 
	arighi@nvidia.com, akpm@linux-foundation.org, andrii@kernel.org, 
	morbo@google.com, changwoo@igalia.com, daniel@iogearbox.net, 
	void@manifault.com, dolinux.peng@gmail.com, eddyz87@gmail.com, 
	haoluo@google.com, jolsa@kernel.org, john.fastabend@gmail.com, corbet@lwn.net, 
	justinstitt@google.com, kpsingh@kernel.org, martin.lau@linux.dev, 
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com, nsc@kernel.org, 
	shuah@kernel.org, song@kernel.org, sdf@fomichev.me, tj@kernel.org, 
	yonghong.song@linux.dev, bpf@vger.kernel.org, dwarves@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sched-ext@lists.linux.dev, martin.lau@kernel.org, clm@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 9:47=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> On 12/17/25 4:47 PM, bot+bpf-ci@kernel.org wrote:
> >> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfid=
s/main.c
> >> index b4caae1170dd..da8c7d127632 100644
> >> --- a/tools/bpf/resolve_btfids/main.c
> >> +++ b/tools/bpf/resolve_btfids/main.c
> >
> > [ ... ]
> >
> >> @@ -260,22 +279,36 @@ static char *get_id(const char *prefix_end)
> >>      return id;
> >>  }
> >>
> >> -static struct btf_id *add_set(struct object *obj, char *name, bool is=
_set8)
> >> +static struct btf_id *add_set(struct object *obj, char *name, enum bt=
f_id_kind kind)
> >>  {
> >> +    int len =3D strlen(name);
> >> +    int prefixlen;
> >> +    char *id;
> >> +
> >>      /*
> >>       * __BTF_ID__set__name
> >>       * name =3D    ^
> >>       * id   =3D         ^
> >>       */
> >> -    char *id =3D name + (is_set8 ? sizeof(BTF_SET8 "__") : sizeof(BTF=
_SET "__")) - 1;
> >> -    int len =3D strlen(name);
> >> +    switch (kind) {
> >> +    case BTF_ID_KIND_SET:
> >> +            prefixlen =3D sizeof(BTF_SET "__") - 1;
> >> +            break;
> >> +    case BTF_ID_KIND_SET8:
> >> +            prefixlen =3D sizeof(BTF_SET8 "__") - 1;
> >> +            break;
> >> +    default:
> >> +            pr_err("Unexpected kind %d passed to %s() for symbol %s\n=
", kind, __func__, name);
> >> +            return NULL;
> >> +    }
> >> +
> >> +    id =3D name + prefixlen - 1;
> >
> > Is this off by one? The original code computed:
> >
> >     id =3D name + sizeof(BTF_SET "__") - 1
> >
> > For BTF_SET ("set"), this gives: name + sizeof("set__") - 1 =3D name + =
6 - 1 =3D name + 5
> >
> > The new code computes:
> >
> >     prefixlen =3D sizeof(BTF_SET "__") - 1 =3D 6 - 1 =3D 5
> >     id =3D name + prefixlen - 1 =3D name + 5 - 1 =3D name + 4
> >
> > The -1 appears to be applied twice now, once in the prefixlen assignmen=
t and
> > again when computing id. Should this line be:
> >
> >     id =3D name + prefixlen;
>
> Yes, this is an off-by-one bug.
>
> Good catch, Opus 4.5. Sonnet 4.5 missed this in v3.
>
> This was "harmless", since the names stored in the trees don't affect
> the output.  The comparison between the names still works, as they all
> simply got a "_" prefix.  But this only makes the bug sneaky, which is
> very bad.
>
> The suggested fix is meh though, IMO a better one is:

the bug is not in determining prefix length, but in using it to find
where id starts in the string, so the fix should be

id =3D name + prefixlen;

prefixlen is calculated correctly, IMO

>
> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/m=
ain.c
> index 3e88dc862d87..ffc15c249ed4 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -295,10 +295,10 @@ static struct btf_id *add_set(struct object *obj, c=
har *name, enum btf_id_kind k
>          */
>         switch (kind) {
>         case BTF_ID_KIND_SET:
> -               prefixlen =3D sizeof(BTF_SET "__") - 1;
> +               prefixlen =3D sizeof(BTF_SET "__");
>                 break;
>         case BTF_ID_KIND_SET8:
> -               prefixlen =3D sizeof(BTF_SET8 "__") - 1;
> +               prefixlen =3D sizeof(BTF_SET8 "__");
>                 break;
>         default:
>                 pr_err("Unexpected kind %d passed to %s() for symbol %s\n=
", kind, __func__, name);
>
> >
> >>      if (id >=3D name + len) {
> >>              pr_err("FAILED to parse set name: %s\n", name);
> >>              return NULL;
> >>      }
> >>
> >> -    return btf_id__add(&obj->sets, id, true);
> >> +    return btf_id__add_unique(&obj->sets, id, kind);
> >>  }
> >
> >
> > ---
> > AI reviewed your patch. Please fix the bug or email reply why it's not =
a bug.
> > See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/REA=
DME.md
> >
> > CI run summary: https://github.com/kernel-patches/bpf/actions/runs/2032=
1956014
>
