Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3FC1A9F97
	for <dwarves@vger.kernel.org>; Fri, 27 Feb 2026 18:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772215883; cv=pass; b=B58wuY50fbvAfIt4GYPW5ppFd3+K5l8VKrN2wiLKAsAwaKGq5wnRfYvXqk5YsYLY5J4BvCVp8WvCBy4ppaCXvDupRUkqN7pRqtKeT80/qWDEOqHVTMErgzta/IrrZnn/lGnvZLP/Zr1Ruf1GMOLLR64Xmti8HyD8N2wBv7pNQZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772215883; c=relaxed/simple;
	bh=wdakXhTE/ogi8ijyaLkYysyGo71cf8GUPfVOPD2oObY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cX4kjomFwrVs40NabSWxRDD1F4wW8+tPcDxNHpncBbuijmr6fqWhJBSAZNIZTXPdmFUZ9KJLBaSHyd3m3uIXTq42/Twatgp55m3npPsEGw9jRDDfTrtYlHJSmwROEPM4mZjjzTzZy+BLTIvPchyBrpKDRgefSPcZz3IY3c7DVoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QT5q3bDX; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QT5q3bDX"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4806f3fc50bso25072565e9.0
        for <dwarves@vger.kernel.org>; Fri, 27 Feb 2026 10:11:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772215880; cv=none;
        d=google.com; s=arc-20240605;
        b=KPOCXTkCfJjSzKNq/3xnFtpwcvy2NBNXot697UHvlsGvUsQgCwbmfnSZI3rdEqCXZZ
         PYYBFtmdoGJdXfDkKRUZ+1qbr9OxlKDuTiBWk51yYqEcfb8h+OqKXtrK/K02pfiuUhSj
         aWyNXWQKqBwj7NVmpEfFVCS5CIlYVC81lr+O/xbvCQDLtHCS9ZrTyX6tuilOojxkGdsB
         kxCr8if417NoOJW0gG0FL19+IbmA6r13f1G0XoPDo/cKz4yoZZCJF2TSMPermbpMGbIi
         twpKqmvvx/3xfJWvuPMahU4EDMI12uSCNkAfiiyi6/jApqkGgJ4JTQ/vVFFy0iUmsaqq
         plhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+8qtYhzK2HJw+M3axTP4HBzYda2KcRmLQCXZ1Yhozeg=;
        fh=NwuV/k2IJ5BauNaM6LJkvC45yJNwxyThBORcwLw8GXQ=;
        b=XO7oiDhXgLXosgJaFmdI2YKgVjbM3DFp4YiQ3Xv2U6iwxGrsDna8Q8ICTVS2yAowbT
         hLpUX0dZTXpe91Ee6OuaHOt20yB4PCmOS6D3EWIwkx/9tCdtIwCjQFKNNOVwz3IJbHxu
         BmlbsjLh22t+81Y4w9Ba0PtbUM1B2I8Vjr/uxrZwDuyK/LooNiO16hETdlXOPd7u++7O
         r8R/ub1aXq2Ny+NVl1B24qvPfMg7WsE3gbydypLbksHy7Na0LFtqFHWIYmqAvewfAScm
         eL6xu8qMYdfQy+sb5CS0qbzWCJFw5XIKF+0HVQD8IYfiaaiMB3GPwgmwOa5EqO7sadEz
         oQFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772215880; x=1772820680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8qtYhzK2HJw+M3axTP4HBzYda2KcRmLQCXZ1Yhozeg=;
        b=QT5q3bDXwS8b6LMn4w5JFPH3fnRA66y13wAo3/j/nLIAkIhi8QUWoDqwuVwyDsePyr
         SfAjWN89SozUeV9zdwwRTqPJq/bqW8bCfTdMK58yL8u36RAnn8BGTWXA25ueo4YxQCxl
         KUMsphp2ruO8zErLBL2ECk7tAd8LM15MBGp9AcuVKe1gGi1oMBshTtfVfMZPWKoXrjYt
         KXWnAjyiMgxKWgJb9SPYoEnah6l2XySB+s8Kkwz+2bL9lmjuuD0Jtn8/zwv/DEf5aSHK
         zTr/jUTDF20slEIBwwOJuOqTLT13Iw/v5Na60ooZmNi/UMp3DOkIlWANBJ/hm8zv58mS
         gZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772215880; x=1772820680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+8qtYhzK2HJw+M3axTP4HBzYda2KcRmLQCXZ1Yhozeg=;
        b=mtmiyhFXzm+gdzVYrQs++7YSCigZ54+oH68VxY0bw8KPFKscKkYevJEfZRFwoDl6Fc
         Z/6IE0vH8a+4ysJCDR4uqfyqTQx2IyunaC+Ge9UTHfFZOuxCPGiBDtGII8Wkd2x9e0AQ
         PUHDYO35mmD/glUaosQFSpmfkRmigw4dm2fdfinrfIvO0PFvsvV2lJyuqkBaPLFTvXHy
         vTvAYPfqp2Iu2ROxTWeq8OCUH+yHLHEFiJjlK/+21UXgR9KO1FZQweu6K06rjmf1kJTS
         x4OwFbmDFxR5jtgYc5XMuJ7XOHK6NDv6MtHh/KMCtmLlpTZmuq8OhIr1b0EjGCkO6Cyk
         E2ng==
X-Forwarded-Encrypted: i=1; AJvYcCWxnKVjxvdkJQuxCMfxGD6kyxJQEO9mxddPB1wIhBuR/+HgpZ4aGhAXuk2yLn/SesDOlDwT/xI4@vger.kernel.org
X-Gm-Message-State: AOJu0YyfZC9aQFEzKAzUu190sXXJ9EVYAPMac5wfTFxHPv4C+gla2/lE
	QuQW6k0j/I3VXN7Ym919B8W/emh55uZ6QrBBRwJ2h0gJFXcGvfFOFWDItXBztsPoTmT3RaLGNgU
	g5T1B8DwFQlCkNwsQftxPxMM8E5y7Bd0=
X-Gm-Gg: ATEYQzxBcwiFwtYdX0EtaqTwxk1jLRjJfcgZONZOb9CXxiAqXVDBQ56MILpB32As/nU
	GhJ7IykVujH/Gaa3AI0uooLNXjap4O2z8vAfgSZ6bBlQ0swyrK91i/LJuFEqTQ/RmSTA31wRer2
	12sswJs8oAEjtSO4rBBoB7qyXqs0/ytu6n86QsLeKb1kk+Xts6VQGnxLLDvOFx8caN/dcFZ4e0b
	4kCHG+OlNcnIWuioFctCaxX8ndCnBeIMFXLcxiByeV5kjQsoCUyp2Oi5hzOH6t3Jq6CyHdNHbI3
	3VLOLxSYND3tmYOpywvncjYyyTqR+gd9Icd+Et/nKR+9SbgYOdQpkw3lBsQwC1mwETpg37LDpfI
	yjJoSJmVtbtRDlPi6kRkKU4cgn6qhJUCprmlS
X-Received: by 2002:a05:600c:154b:b0:477:b734:8c53 with SMTP id
 5b1f17b1804b1-483c9b9ebd0mr61439745e9.12.1772215880344; Fri, 27 Feb 2026
 10:11:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227100426.2585191-2-alan.maguire@oracle.com>
 <df00956ee63256fa4f1cd7d847797e49362aee2963cfc771a05e9c4ef640e781@mail.kernel.org>
 <a83ddc02-d601-4a0f-b5bc-9dd359d7a2b8@oracle.com>
In-Reply-To: <a83ddc02-d601-4a0f-b5bc-9dd359d7a2b8@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 27 Feb 2026 10:11:09 -0800
X-Gm-Features: AaiRm53KFYJJkK96psoiXrRYKDLay40iG1pxMCZZGfqkqIO28QFRXcK6z2zB_D8
Message-ID: <CAADnVQ+2hrYuZoG-s-Luscoza99tR29jgqh138LT=JbHmPwnOQ@mail.gmail.com>
Subject: Re: [PATCH v10 bpf-next 01/10] btf: add BTF kind layout encoding to UAPI
To: Alan Maguire <alan.maguire@oracle.com>
Cc: bot+bpf-ci@kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Quentin Monnet <qmo@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	dwarves <dwarves@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 5:36=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 27/02/2026 10:52, bot+bpf-ci@kernel.org wrote:
> >> diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux=
/btf.h
> >> index 266d4ffa6c07..638615ebddc2 100644
> >> --- a/tools/include/uapi/linux/btf.h
> >> +++ b/tools/include/uapi/linux/btf.h
> >
> > [ ... ]
> >
> >> @@ -19,6 +29,8 @@ struct btf_header {
> >>      __u32   type_len;       /* length of type section       */
> >>      __u32   str_off;        /* offset of string section     */
> >>      __u32   str_len;        /* length of string section     */
> >> +    __u32   layout_off;     /* offset of layout section     */
> >> +    __u32   layout_len;     /* length of layout section     */
> >>  };
> >
> > Adding these two fields changes sizeof(struct btf_header) from 24
> > to 32 bytes. In libbpf's btf_parse_hdr(), the non-native endian
> > path has a strict equality check:
> >
> > tools/lib/bpf/btf.c:btf_parse_hdr() {
> >     if (hdr->magic =3D=3D bswap_16(BTF_MAGIC)) {
> >         btf->swapped_endian =3D true;
> >         if (bswap_32(hdr->hdr_len) !=3D sizeof(struct btf_header)) {
> >             pr_warn("Can't load BTF with non-native endianness "
> >                     "due to unsupported header length %u\n",
> >                     bswap_32(hdr->hdr_len));
> >             return -ENOTSUP;
> >         }
> >     ...
> > }
> >
> > All existing cross-endian BTF has hdr_len=3D24. After this UAPI
> > change, sizeof(struct btf_header) becomes 32, so bswap_32(24)
> > !=3D 32 and the check rejects them.
> >
> > Would it make sense to update this check in the same patch as
> > the header change? As-is, recompiling libbpf with the new
> > header breaks loading of any pre-existing non-native-endian
> > BTF data.
> >
> > This appears to be addressed in the next patch in the series,
> > aa01655822a6 ("libbpf: Support layout section handling in BTF"),
> > which relaxes the check to a minimum size comparison.
> >
>
> In order to handle all the fallout of the header size change
> in a 100% bisect-friendly way it would be necessary to squash patches
> 1,2 and 6 in this series into a single patch dealing with the UAPI,
> libbpf and kernel handling of same. I'm open to doing this,
> but am conscious of the fact the larger patch might make it harder to
> review (for a human at least). We used to explicitly separate UAPI from
> other changes for BPF, not sure if that's as much of a concern any more..

Yeah. Ignore the bot. No need to squash things.
