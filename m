Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FDA2BE7AB
	for <dwarves@vger.kernel.org>; Fri,  7 Aug 2026 17:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786124065; cv=pass; b=pdqW03bzUPC6BQ1dBB229qZj/njqq01rgpyk0LByH/kdK0GYtKv6dhCzqBM87y0hLhAbOq6c2ZBHDWRMsQUfs8ttQu7Yi5Pt7sZya69Q/M+HqDOu5djPNnnyomJLTF2FbmfA9SgItUDfKWg25m66JUexuddSRsKfkESUcUf8khM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786124065; c=relaxed/simple;
	bh=Xj42kzvtY7hVZXpL84O/HcqpcwKY6/OAxbNIO5KfMOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K7v3SM6YgQjqsG8yo5hJjyl75UCqE+eH9MSrQ1WwpgmXkW2sAeTxADy1C51b16Hom4GBF1gm3rmtiP3sw1j7/DwVt1C/+5X+t/rBeCrXUrZXANE+IgJp6H4ILSlmc2hmM/fxZaXMvZYqsOvuYbgBGtOGPQIYab4katRpSgINpJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Try16zb0; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Try16zb0"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cecdc24b1cso4471795ad.1
        for <dwarves@vger.kernel.org>; Fri, 07 Aug 2026 10:34:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786124063; cv=none;
        d=google.com; s=arc-20260327;
        b=Hb86mnjwrAIsUui2Ol2wtsERnSM0Qf2Q6gUtm8VDMMe+tnWV2Mf+wwk3wdO+K8TaCc
         93baKl7CcVLHzfWTB6vWOMjKE9EHzGF7oX8KuhtVuEMG6ukLrFCM929Oi3whzoCU2FrG
         Px3GyQmDok55OO5IdNwNb7AGVbqvGOCgdt6jUkb3sV98f49f8oUrp+PmLh2MfQ/hMr3W
         bGCuR+pzGv355bMXGxkD6jNh+60k0TBsuwD6sg67BPwgnw8PZJ7E9x0Qgp1qsQuCQ1pK
         Y7aHZgy/msc+Z6xykRxgtE/NqJccwQar2CFZdCWYWzIQar/p00DVFTeH66X89pqJG6B1
         QcGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6kvT16JAmy75WGpIzBN7wM7HnztOWxyNPMwrylGyhI0=;
        fh=pPlYdUBpnOhCVrtIYcKtTccz9chnAj8ETSfV1ckr9WM=;
        b=J/yRWBHm24gDU6gUK3lUp3IQ2tLT+0WiAMnhrXjteG7ooQK8po2wpftCv6MDMGvvjW
         ApVz3St2Fz93tsowHnR2hG9Ug/6kvslo3mJ59v5n6YnTtmVm32ZSqSKmPWOj7XefMeyv
         C8putvDQT0bOAjGszm2/pxnLIavX6QC5HzAYNcZ/Jdwu0e25XITw133FIkbSe0DJKKmZ
         97Z82z9P9unTfL2GkxX2Uv3oI06Yeu+WktXx6buWzyqKpGN349Csi605OMuZzOOXfGeW
         cILZCU5mZvr4FHp0GNHZXfdwlkGXaGFVQvrDy4KNaXPXwUJg2tI6DE+vBRcnwEKhIPbF
         nkEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786124063; x=1786728863; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6kvT16JAmy75WGpIzBN7wM7HnztOWxyNPMwrylGyhI0=;
        b=Try16zb0Y+SEXPUVlMMTVAFb3+FjmEJlwOdQKXRsjpsRu4/0vx0PwfQYg3WVJbqVi2
         Bj1ycxJV0mTuL121CGOQ1E3VJybp8UVqFnfTqQYvNmhsnJNenZFMfd0jkBL2KDDBLsJD
         01qUFoyI5p2Pc5zd2DwKCXTsyNe0YymhJKuBoqb+H9ZRBfx47ARGd+Ru2mtRx9bH2avX
         bbSh9s56rDVCT62yGURt2enRg1g5Df0pcFgcIJaLkSVvblaO4yshlh86PfIAROt2MsQw
         r4HryHQkqc9utLSgfHZVn10OrZEFIMqx6AUaOxqweRL9dlfkosTgyxInIxWImbHvB+fo
         OQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786124063; x=1786728863;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6kvT16JAmy75WGpIzBN7wM7HnztOWxyNPMwrylGyhI0=;
        b=jmS9aLE0bOAbwNKDeUy8lHdU4XaD2fL7e7CkAQSIugx+Wu/1p4RZ9RFjY3UwwqflPc
         sp83YVPVkI89d1Rzt3XlovCPv3/JfDje0XNcowZf/Ecj7wFfZnPgUsS0Wp99+g+4FeYP
         jqmL9h5JmbsbCNqb7dwrFz0y6h9VEVOjXk9goTbKG2uOdgr8bq0xV0EXehl7kA7VbvrB
         ckmi6WazFqFXNZ2DL3DMtOdkgEbeW4fXdwlJ0VQzQkMO1QTK9dlg+doefxiw94+kjjYR
         p0wwlH+JYFT9ApS64yQaJ+yG8rkg1q7rQTaAtGElWFqi2HlmDwTbrsECrPMc7g8MqYa/
         yjoQ==
X-Forwarded-Encrypted: i=1; AHgh+RqSOwkr0zxuDiWQd+rnaneINeVmR7zVNThtBQugd7ZTiTMS7S0+2ohvMxARfuhdO5AOVz9LqR7W@vger.kernel.org
X-Gm-Message-State: AOJu0Yy39ZwXhcbySOpxXjVrnuFcH/sPZI4Uhfqz0Q/rO9Gmveyf4oQq
	BEoZ//hn/Dec/PPPJGaX12JAOrndP4+piV2nOVQ6AWlN22suQYc6ZprbsuphWiGosj9+e8EggQC
	aiglW/IOjyp3y23DexMIZ76cbF3qkBYM=
X-Gm-Gg: AR+sD10qdwfv5toig3R9OWDCEhz6tYqDJQpZo0q1xf45cvpCD8ocX/9XcI4ibziRcJX
	46sVp0rWQIy4eeBOxlRQrMZoAwh4blK9h8EpS0UxCg4U/SzWW7IuRXqclHwEtPNv+px4IUqcXOh
	vctu3Msly8q3PeLlPffNt/bQb/DgTrfF/8WP67cxrSF8+gp9kzRdBFxJ2fyyq3RgDdkWCNRBUsQ
	GN3Twh6qiAgzbaRGVtFJRlneDHJbFrxPvuY/mtPPqhbcX33DGSDytzPVRD5xx4FyqCqMj4kCmHG
	IFrAdy6E2UgFPuB6+BFs0MXIqdSJ+2UwkJUyaIOzSWLNFrzAXP6Lqs3wNTfZLS0RuSYqrpHh4r/
	TunhbEbYiGGQMD/MLcIWx/Mq+Ekqka16ylgPFl4KcFcWh1eygkZmtkymXxqjC
X-Received: by 2002:a17:903:2c0c:b0:2cc:d6de:d58e with SMTP id
 d9443c01a7336-2d0cab4cf8bmr196602745ad.4.1786124063116; Fri, 07 Aug 2026
 10:34:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731193102.110693-1-acme@kernel.org> <18b557a8-e1ca-46cf-b03f-5e68490c9229@oracle.com>
 <anXTAComw6XAvnXU@x1>
In-Reply-To: <anXTAComw6XAvnXU@x1>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 7 Aug 2026 19:34:10 +0200
X-Gm-Features: AUfX_mzzvBqFiv6OKNhMJZDHG6Wjkrtx0DJ0DXR2V4K4yDYcAFM1opjoNTiHmlY
Message-ID: <CANiq72nHWY638h4mxJCfh_HFtzhwFEPyo6a-7k_3CxZsRV+Jiw@mail.gmail.com>
Subject: Re: [PATCHES 00/12] pahole: Support more rust tags and references to
 dwz alternate debug files
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>, 
	Clark Williams <williams@redhat.com>, dwarves@vger.kernel.org, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Mark Wieelard <mjw@redhat.com>, rust-for-linux <rust-for-linux@vger.kernel.org>, 
	Gary Guo <gary@garyguo.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 2:43=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> Adding Miguel to the CC list, Miguel we're trying to improve BTF support
> for Rust, this series handles multiple enabling fixes/improvements that
> gets us to the next level, i.e. we can load everything from DWARF, now

Thanks for the Cc! Cc'ing rust-for-linux and Gary.

> its time to try to map it to existing BTF kinds and propose BTF
> extensions when we can't use existing encodings.

Sounds cool :)

> Inferring from "does any member have a niche layout" means
> reverse-engineering rustc's layout algorithm, which is explicitly
> unstable and unspecified. It'd break silently on a compiler bump, with
> no way to tell from the DWARF that you got it wrong.

Yeah, the LLM is correct here: the Rust compiler gives very few
guarantees for the default `repr`, i.e. in common cases it has the
freedom to use whatever layout it wants (i.e. even for essentially
equivalent types in the same compilation unit) -- the official docs
are at:

  https://doc.rust-lang.org/reference/type-layout.html

>     u8                  __discriminant;      /*  0  1 */

For the niche cases like `Option<NonZero<u32>>`, what would be printed?

Cheers,
Miguel
