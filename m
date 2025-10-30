Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3508F6F
	for <dwarves@vger.kernel.org>; Thu, 30 Oct 2025 00:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761782619; cv=none; b=m1lOuxjN4xR/n2XN7hGtjz90uCPmzysoUKBKLe7yZuL6kZ/1iV+GuXNawwWwwtdrwxY4Fpk591WQPDke/9tXiSfEHpr7TZxQEJookH8FX4VseOCvImTHhXL3yIMGitzbwcLG96ZAnMyV4kaaC+ubtx/ky7R5BHGamGrmGbuHVlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761782619; c=relaxed/simple;
	bh=IQdAVekv4irRGgMMfp/PjHkXohbkVOvsM/8HtebJv/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h7mxed3T/dFZmbFOinxPTTAuFE/zsgbiye2OFBwWKI3GsMdQei2sTx3D43wivYm6eycdB2kcBBNHBAdUqIqPIrdTf6QH2H4JboB6rPU43EA/VbQtnNDDb2eS511WnPlJfY0IT1MMLVfiQa6Dn2NtdEwS4VSk5bFZmwNrVChtMqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mGkWCGQL; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGkWCGQL"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-475dd54d7cdso1494855e9.1
        for <dwarves@vger.kernel.org>; Wed, 29 Oct 2025 17:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761782616; x=1762387416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=El4J/tPU5GVXHSLQfOqUzKCRr5OClPDUdxz6lfYkO5M=;
        b=mGkWCGQLgx5y1ztnWdRLWrFPG2DE/dwLk3NSXZ1ocEQlwZEmwWQL7fT/ds1dDS4gKX
         gyi9cgN52qiO+lvSHVLBx+v21aubhfwHJxmnXm3ZKTDbW/uAfDqfWa36Jol1HvljrAZe
         HKN4ctxFAvkpu/rMsY4woNp2TCU3gW0VHngAKGc+cib3AITXZRZBmyoQ2Ql+ySku2M9A
         rWh4TWVOpW8tYYzz/qpiyVtCQk/d6Q07o4cpRBE4+VePUUuROAxZ+4j6s9dnqgcgW1nJ
         cQQkDp9Obv64O5VN3IfvIy3KZ4A7mxxXcJBCe3yTE9h+SFszAiYkcbB/P8ahMeHIgl9N
         /2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761782616; x=1762387416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=El4J/tPU5GVXHSLQfOqUzKCRr5OClPDUdxz6lfYkO5M=;
        b=u9LiJZFRQWIhsAPrRqXwJcoYMSeDGl2snPBl6i4TlPMbtTdTR4B5PepWc/cuhlL16u
         o/8FruuuRfOl4SKZHv8jkEYqHUipjTvRyNIg2V11E3hp3tvSPl89F0pLAxzWOOD6YXV5
         iOzSf/g+nIMU4vW2t7aGnM8o3CCSVBZa9UuPSqSq5RN354YBZVvD1hs6IdabACr5rCR6
         PHwO/me52cG4Ys/nK/tsew16kPoZrC6zk+wMANkvgU9HTZenPZ6crmstalthMOl3z4hG
         AJJePKjEDGt7Wf83n9YTtnptu3yGB7mTMMmFbK1w4hGXAyjx3wQUUKbagIUNPmROF8im
         N/hw==
X-Forwarded-Encrypted: i=1; AJvYcCU0wRaMCslNcFm4ARS2F0M6dAFsXojSn+Bjr/hD4RAwO0/HxsxWOfJe+01YOD1olSHzQzUuOxR9@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjgsx1HDj/lgUQgVDdbClFimxlxrf8aDHIzSN/oay2wv9qKq5p
	BEXeS8BkSY+3gMNa72MsfgZhUUZ4WzHJ8PH01K/llf98HrfOZmCH33r1DFVGuQJV6Ek9QozCGIw
	IZ/jEYZHvSxk5FD9gT1dU1nRYPOfzSig=
X-Gm-Gg: ASbGncu0985sBA+DZvEBquXmhM0TPF1o5xzG8WCGQiiiGFXYN3F6fTmw1G1Z+oJdRxu
	1wa1DixWWECEfPJOCY9rfITafFDoyW5rtI5U4zHUxmaMIR4kic/idI1fE9ZA8C1JrrxzEKJychX
	CdomvW+lxppmiP6wz4BNbtrMCpARpxJemIi2VosiMMIpTmtjFX5NVWQTkivEWoVsLit4G5Fg7pB
	NLJSHfaJ73FZ/WJ8a5/jD2CkrtddC3J58jtJd+5o/d1xxXDjQ3E7cAYP9LNU1icaTtgB7wuBMQP
	PkQSLMHJRyffJ8Oc6g==
X-Google-Smtp-Source: AGHT+IFh+W6qz2ceIUI2QhqYoE/268h3PX3Rtjarak7sWgQhdPAZITWiUaam+JJ2eaaDJjXrqjrqy4uREJVwVsVFhj8=
X-Received: by 2002:a5d:5c89:0:b0:3e7:68b2:c556 with SMTP id
 ffacd0b85a97d-429aef84080mr4043118f8f.26.1761782615888; Wed, 29 Oct 2025
 17:03:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029190113.3323406-1-ihor.solodrai@linux.dev>
 <20251029190113.3323406-4-ihor.solodrai@linux.dev> <b667472aeb77ac63a3de82dae77012c0285e0286.camel@gmail.com>
In-Reply-To: <b667472aeb77ac63a3de82dae77012c0285e0286.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 29 Oct 2025 17:03:24 -0700
X-Gm-Features: AWmQ_blixd95JW4fMfByV1IsDwwur7m8Z0T058Ir4uDIHps2me8sOhgRz7Ob68I
Message-ID: <CAADnVQJPevofLp0B0h40t0X1gj_032kw42K0ykHW4BqdmY0eNw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/8] bpf: Support for kfuncs with KF_MAGIC_ARGS
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, dwarves <dwarves@vger.kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 4:54=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2025-10-29 at 12:01 -0700, Ihor Solodrai wrote:
> > A kernel function bpf_foo with KF_MAGIC_ARGS flag is expected to have
>                                  ^^^^^^^^^^^^^
>                 I don't like this name very much.
>                 It bears very little context.
>                 Imo, KF_IMPLICIT_ARGS fits the use case much better.

+1
I hate the name as well.
KF_IMPLICIT_ARGS sounds much better and can be abbreviated
to "__impl" in arg names.
That way it will accidentally match our existing _impl() kfuncs
though there _impl meant "implementation".

I think this double meaning of "impl" as "implementation specific"
and "implicit" actually fits.
