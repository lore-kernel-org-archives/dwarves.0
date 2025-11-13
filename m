Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8551633556C
	for <dwarves@vger.kernel.org>; Thu, 13 Nov 2025 17:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763054461; cv=none; b=Jw7/WeaESjk7+5KqTaMBE0moeyFgeA4wJTHeiuFFZxXgPABXlL6t1q9d7VuEs1XbeFah8BLt+fg5hrl4z1VUTkSE9tZIh3ycixrINfm4CB37QfG7zWBLfkLloHmBUCRFxEU4aJkLjSYptZbeMTMzHXTeL7qxsKxLqTyDrdJ6yU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763054461; c=relaxed/simple;
	bh=ztuiaKnD+yWEMM5b9BFNroowD4ifQN+vT3IcDBlsurA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tbxcHGNop/St6tizUgiHkK4Rc1l6kOn7QtFjFJy4jM3u8aNwg7nwrhtRmTdI8OHzDF7QZTL4jVAEaXLnhP7NCMABT9f3r+oSQKt+8OVf9MKvV4xRJBo/kbZawVGfwE1vplyB0CO+faKO7C9Cs9JzNcOXIkUrmfvWedCWLukh+7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a70/uYfQ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a70/uYfQ"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42b3669ca3dso647780f8f.0
        for <dwarves@vger.kernel.org>; Thu, 13 Nov 2025 09:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763054458; x=1763659258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztuiaKnD+yWEMM5b9BFNroowD4ifQN+vT3IcDBlsurA=;
        b=a70/uYfQuTgr3k2xxALfpdE+QRYDRDG+ZiUFDfexK4i1vPMjSizPrsckDusIlSM2NG
         T7qAMg7PPMCxqq7a+aXY5ieyiNlfovDQTxd9UidCc1aYqUdlgIcUCyhtxFnmmcxK+pNx
         WQdaaReNYvBh6B5K1sM0xF07zKpLnKnOlXn5S3CbeZK1VXEZmkVUP6yhC0KLMBtVvh/D
         T4Zk7m2JYWjRSDZz6ikVZQAOyqhd6od2U+NvqurxXGEwUV+Qi8LNxWavyY5Wa2tSWBwx
         HHw9oKNuG/DpTQnCyGAxnRsxXhfnklfz/6OuCU7k1Iz0+/N94YNyNmtZN/5/THOnGJDH
         YVpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763054458; x=1763659258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ztuiaKnD+yWEMM5b9BFNroowD4ifQN+vT3IcDBlsurA=;
        b=DHxjKOJjpJQwGTcfAx/57v8o1GwlQ4B7fCLe5pj0xhRGXpVgpLPgqE/YMSc0DfMAUv
         9ZlYrvVSGUOX80uwBClUY/q3jSkkOcxZkmmH6QgBHuToXKnzFiDPs2zM+taXIVjUx0K0
         CGKKJlOpjuJd4CPoy9GGNyw0b0uhRrWMo5K6YCWUfsIzSeb62AAzH9ifn9JxM2D8T6Jm
         QvCvU9JYcWHq6DpPzSLuaASMt5mx23tuRhuQjZYizpWBZ7KMiKuy0o4uukbiGtzKPnRz
         W/HU0yXDpWHuXN2FFrDjP+j3bbtuoHTsMaa43udUeDBjlBviJhifd381LA2Y8ri6Ukfo
         p6NA==
X-Forwarded-Encrypted: i=1; AJvYcCVT2ZBlV3SbyuIcnGXor3MpBKaAqiEUvihz8QNoiNHfTQUI/C/AbBDsHIs95OzEpe3nm+8zAw9m@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhoqy7muJ9nALNutWvXdhXRIkUgTkaIWv4rGpLvXEOs9YdKpdQ
	beUUFZ6nUpl56FA/V4GfDWE4U22yzB6/hdQ/AEBrb4hVfoFW3GKU0QhiU10IlNBfH8C8v2W6D16
	y1H9daRAtCCYMbNa/GWHRdh2x5zYun0A=
X-Gm-Gg: ASbGncu77DPDo29eIEQZAr4szaQw5kSUovLQoMoZXWVKdpZVe7Ej8t705YDu86614v9
	RCp6Sz5WzgO1I4Q2NFnm5doJnr3sZBLvkQBB4lZlQTJ/XRWfmVxsVtFazgP1gJVgW5k6FPit/xT
	DcGbHQqkVhyfkwN9XLXtZXf45VYAO4bVcqhc+k3qztskhb6lp0UI0WyApbrB5BWyWQvWIF6Nv8P
	CKEMCXbvcS4IRb0jtQBmCAnm7Ey469PkUvVf7VxeD3ToQfC/HoYPHTILcsh64FDyxdmdBzQLesG
	Xon4cVse2MM=
X-Google-Smtp-Source: AGHT+IFexBzERRqEOeduYo/jq8Gjn9rqtZFbfZHoVzMREkhVjwVRm9s8zp4/bVSVMyhcijrbYEejga9scygQSLJEjjQ=
X-Received: by 2002:a05:6000:651:b0:429:66bf:1475 with SMTP id
 ffacd0b85a97d-42b5935df1dmr187498f8f.3.1763054457715; Thu, 13 Nov 2025
 09:20:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106012835.260373-1-ihor.solodrai@linux.dev> <520bd6d8-b0a1-40f2-a674-b4c6ed02e254@oracle.com>
In-Reply-To: <520bd6d8-b0a1-40f2-a674-b4c6ed02e254@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 13 Nov 2025 09:20:44 -0800
X-Gm-Features: AWmQ_bkdhBLkmzEsx2PBtYFukuxhtCYUyvi6M7hnPybNPl0_2PlSHrkAKxPSNTg
Message-ID: <CAADnVQJj6EcntgiAm6Kv8FJvP3tQcG=EzWt-uFuzszHtcw4gmg@mail.gmail.com>
Subject: Re: [PATCH dwarves v4 0/3] btf_encoder: refactor emission of BTF funcs
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves <dwarves@vger.kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Eduard <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 8:37=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 06/11/2025 01:28, Ihor Solodrai wrote:
> > This series refactors a few functions that handle how BTF functions
> > are emitted.
> >
> > v3->v4: Error handling nit from Eduard
> > v2->v3: Add patch removing encoder from btf_encoder_func_state
> >
> > v3: https://lore.kernel.org/dwarves/20251105185926.296539-1-ihor.solodr=
ai@linux.dev/
> > v2: https://lore.kernel.org/dwarves/20251104233532.196287-1-ihor.solodr=
ai@linux.dev/
> > v1: https://lore.kernel.org/dwarves/20251029190249.3323752-2-ihor.solod=
rai@linux.dev/
> >
>
> series applied to the next branch of
> https://git.kernel.org/pub/scm/devel/pahole/pahole.git/

Same rant as before...
Can we please keep it normal with all changes going to master ?
This 'next' branch confused people in the past.
I see no value in this 'next' thing.
All development should happen in master and every developer
should base their changes on top of it.
Eventually the release happens out of master too when it's deemed stable.
