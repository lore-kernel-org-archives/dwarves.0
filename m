Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862692D594B
	for <dwarves@vger.kernel.org>; Tue,  4 Nov 2025 22:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295617; cv=none; b=YxnrZoFRQYY7HndjpWT6Abyf/Bh+HdfoWZfIWmjYsDWrbIYNX9EYj1v1lXG3/0ZjJ2lb+dp2TB5Gu5E0hEIBYK+MtU4iDtgIqGpbo5LWz5fitEObhc19jbwG75ms1jZM5Uohn5DgBqk20mzSRAYJp9LxEEXq7jEv+/L2AT1rTgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295617; c=relaxed/simple;
	bh=FRnWerClYIwqEx17QaxJKbmTiw3v1soLimY2Go3cX68=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GzheMyvK0c6WGfTUO3M8PPraH1qofkiuO1xL3btnDzPh3V51UABdmZiahYxtylPBrqPK1rp5W6wyqFKHs5FCOA2EwqwTwZZPLQNN+kLYrjNkV9gNQBKyMchQEvQQXl2xQo2noGGbdeomkqDcAb6dSPxEuDqx1DJi1x4SzeGgYik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQkwgmbc; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQkwgmbc"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-340c39ee02dso3387423a91.1
        for <dwarves@vger.kernel.org>; Tue, 04 Nov 2025 14:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762295615; x=1762900415; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=diKAflDlKJLf1i+XaTUPP475ifJSxJp0FfAdOW4GUlc=;
        b=ZQkwgmbcD0puTyUll331Zzuz/6vJ3Zl8claDfXvRI8S7pr8YwLX7KFJhnsq18dnxWe
         cL6Jkih0Oh4cQjSWTK+hdANpIKVnbdIe0yWhUXGk+EqoJKfi5bRwUHZ4y0zs9OYMoNRo
         k6mltmL8C2ekFTm1irD+F5SooTtN6vBtovFYForOtc5RQus2gEUN9fiH5Vs13GNOfEez
         6PmNngPsoAxAp4r6En2sBpqwnVByJzcj+m94DZP2BUoUq4wOLlxGiKw5Q+QmeoyW8aQe
         0Bp1M1sweaT8clHWlvFtcCIp9RCtNrw7gsX80KIUjAIf1qLa/eADXvgW5qa5zlEUItTO
         xJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295615; x=1762900415;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=diKAflDlKJLf1i+XaTUPP475ifJSxJp0FfAdOW4GUlc=;
        b=mRdXsl0u6GKFAL1WaqKdM2k/uGnWo12rVryX1T9zHuh39lV4CdDYm7F2sSXM8wjBJf
         te/BQQv29Tym23aFyEsgCkw4lutXpsFjU6KBzaSXJpJ/p7610IzWYJ0ZKOUUAR9OVL9x
         aoNRMU4nP/4lFtzYapitD8eebVSvr5RFIDcRixnlPLiBagUECh2xq45rCp3rxbhpf6pF
         uJMiFgiZxjiRBy5almiRHki6vNY+nrJPtM4w6zmEvDCbaLSwKYdisrJpaAu3aI7xwRDj
         rGzCZwNpkgupJyMDepjolRGiWlMJg3zMlwcgcMXznsBC4iFNfsGi93YsmPbyhxchXq5M
         kFig==
X-Forwarded-Encrypted: i=1; AJvYcCU9RrNh/j60yy14GSY546sWCE0Lx0055SyZ1u6XqQYPDrjTZ27tIJElG1OenXMTIJM135ZVz+f9@vger.kernel.org
X-Gm-Message-State: AOJu0YzL96yRBIhKIZIVuRJOW9z5IDJXcPvMliZdOhWEIK73wu5fzRhu
	F88aJJg8xA/0KhbBOMwIwGZzFqFP1s8UElDd4U6QpT3jJfjCHzgSxhOb
X-Gm-Gg: ASbGncufcr/8rO3izpN9RCYFjh8POOdSs5PJDbTdXuqPynVNZSq+WOh4SBboi7B6Z47
	HMXNgj5H5kh0n8hEfmbCuSUXDeqJR2516PSIQMIut+vk8wwf7J8Hk+7KDFsJqsuqsjrhp8Dy7Pw
	ovAexEjqp1gBwVSbR7B1kaVG0demZGmvaX9fnN9Gz5x4aoAf5tw7EMNAa0QIAtHvLeWT1IuSqmI
	N4WGAMIe7ujKI+o8LZqd2GTZNHFZC9xyRPbt3mMaavzA6hXoLHhKrT6xAudXC+XgGtr8PBA+1Dd
	y9Wsp6vENCiv9G4TWWKuw/mEjLJa9TKgNwXEF/SYjG8x5xqhWDQLUpLQGeDmMzPm1kMMuzv9Fnn
	82A5BUwaHQS369J6qjHRk/A4bbJHmAIwDa+ypFDFYBEusvquVAc2ZGJadS0zp571Mbv+h6uX2wF
	1LB+oQbipJIKDconKVtrssVXQ=
X-Google-Smtp-Source: AGHT+IE4/DZslLby00wsG5LRpFicwNO4x+L9rLiwQAAo34IsnBsAaNmsDe8qntcxyhOvcoXoo6RwlQ==
X-Received: by 2002:a17:90b:3512:b0:340:299f:130d with SMTP id 98e67ed59e1d1-341a6c4496amr1046617a91.13.1762295614721;
        Tue, 04 Nov 2025 14:33:34 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:a643:22b:eb9:c921? ([2620:10d:c090:500::5:99aa])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a6993b43sm603806a91.15.2025.11.04.14.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:33:34 -0800 (PST)
Message-ID: <0db4e51eed95f9d4616ff5936d335ae71ac2a016.camel@gmail.com>
Subject: Re: [PATCH dwarves v1 0/3] btf_encoder: support for BPF magic
 kernel functions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alan Maguire
	 <alan.maguire@oracle.com>, andrii@kernel.org, dwarves@vger.kernel.org, 
	acme@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, tj@kernel.org, kernel-team@meta.com
Date: Tue, 04 Nov 2025 14:33:32 -0800
In-Reply-To: <ba1650aa-fafd-49a8-bea4-bdddee7c38c9@linux.dev>
References: <20251029190249.3323752-1-ihor.solodrai@linux.dev>
	 <517837f0-127e-42bc-83f4-2c85203ef468@oracle.com>
	 <ba1650aa-fafd-49a8-bea4-bdddee7c38c9@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-11-04 at 14:25 -0800, Ihor Solodrai wrote:
> On 11/4/25 12:59 PM, Alan Maguire wrote:
> > On 29/10/2025 19:02, Ihor Solodrai wrote:
> > > This series implements BTF encoding of BPF kernel functions marked
> > > with KF_MAGIC_ARGS flag in pahole.
> > >=20
> > > The kfunc flag indicates that the arguments of a kfunc with __magic
> > > suffix are implicitly set by the verifier, and so pahole must emit tw=
o
> > > functions to BTF:
> > >   * kfunc_impl() with the arguments matching kernel declaration
> > >   * kfunc() with __magic arguments omitted
> > >=20
> > > For more details see relevant patch series for BPF:
> > > "bpf: magic kernel functions"
> > >=20
> > > This series is built upon KF_IMPLICIT_PROG_AUX_ARG support [1],
> > > although the approach changed signifcantly to call it a v2.
> > >=20
> > > [1] https://lore.kernel.org/dwarves/20250924211512.1287298-1-ihor.sol=
odrai@linux.dev/
> > >=20
> > > Ihor Solodrai (3):
> > >   btf_encoder: refactor btf_encoder__add_func_proto
> > >   btf_encoder: factor out btf_encoder__add_bpf_kfunc()
> > >   btf_encoder: support kfuncs with KF_MAGIC_ARGS flag
> > >=20
> > >  btf_encoder.c | 292 ++++++++++++++++++++++++++++++++++++++----------=
--
> > >  1 file changed, 222 insertions(+), 70 deletions(-)
> > >=20
> >=20
> > seems like we could potentially pull in patches 1 and 2 as cleanups
> > prior to handling the KF_MAGIC/IMPLICIT change; would that be worthwhil=
e?
> >=20
>=20
> Hi Alan.
>=20
> Feel free to merge in the refactoring patches if you think they are
> useful. No objections.

Hi Alan, Ihor,

If you thinking about merging patch #1, please consider my comment:

  > > +static int32_t btf_encoder__add_func_proto_for_state(struct btf_enco=
der *encoder, struct btf_encoder_func_state *state)

  > You can get rid of the `encoder` parameter here.
  > See https://github.com/acmel/dwarves/commit/080d1f27ae71e30c269a1e26e85=
bb86c3683f195 .

I sound a bit like a broken record, sorry.

[...]
