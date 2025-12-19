Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D8A33F375
	for <dwarves@vger.kernel.org>; Fri, 19 Dec 2025 18:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766169885; cv=none; b=OgcxTh9dlrXvVSQM48UeEonBSO2H6cSYFL7cTwbz/ZuzTLIRqWqyhjl/fv4Cl7AJpwsmHMhuS0eJcr4SubHuXBvXAKJilBA7kx0qkGg4dw/HOoj5f6Y/2BzSef947nt5F7NKtghp/lvYchW49hIPY7GMohJ552IRFBiNEMuc6/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766169885; c=relaxed/simple;
	bh=qUIbJz4v0Rubf3X8GDdYbaOS1mdha3XyVNbYZgSaA2w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QKHsL2RK++AdQFlIYA+DZ7U+as8emP8Tqu3HsVdB2F3yRsWHWRMCi5x8kAZpL9CWEQPpkVDw4GrurlWT2WQlM05+1jcabkmqkFt/V1449X7FcqOmNmyEZ+CVjWcmIX0RW4sv0PScUFKYGccRve0YlwvXWHjU6/hry4tEfUn6oB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLTVGQFO; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLTVGQFO"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-bfb84c2fe5eso876651a12.1
        for <dwarves@vger.kernel.org>; Fri, 19 Dec 2025 10:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766169882; x=1766774682; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qUIbJz4v0Rubf3X8GDdYbaOS1mdha3XyVNbYZgSaA2w=;
        b=eLTVGQFOzm5xYs/oOJBZEUEfMtz4C/cClPhCnkB1LQ7F1FZ2epst6goqVyorHscKA8
         0/RxHrU0w8afpP1kDBWuYeXR6UR/Kxy5oMTQGlXuncSMMQkQ0jeuawe7Mnq+69xNUM/h
         5tCcZUcRzrhAMEb6brjcE+pf6brIBGqJVjDvE6j1Pyuf6WSgfaxc5eLRbJz4A+MKUFmc
         +lSb4048Qg6Cpwx79oPhARzOZ3VHwyuTk9Zh7248ya6npu3TGG4fwiFxqTk2fD4fh7W5
         azn1IhpQqZ0H7taq+vn4uYoONFsFY3G+Lh9SFyecpdTj8R1kfPzy6KaobAQzaFi58cNk
         1nPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766169882; x=1766774682;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qUIbJz4v0Rubf3X8GDdYbaOS1mdha3XyVNbYZgSaA2w=;
        b=SYsRxyWGIQvv6+CdncnXN4ItUUThb5FfGy4jjwYPfUjn4ROBCL0sV0az6wCR6dhMp1
         LxJSlnHXAqwb1A6bVK4OD78x+nvG7xaf7zMQz55M7kIxW8kU1g/jJzwlcksx/gjKRj4R
         EQWcvmDzID5vEF47nwBq9O+Z8sod82lM7gP3AEQxNl0wJR4y3xi3es39xIbyRLzawIZB
         jZ//UlpD9Jgcl88tSDY0cXp2rUZbUndOF9OYvQSz7Hd5kXsnbrilz9GvvAFWtsaLpkVi
         GCOuDgdhItN7En/kB2u2yDuHdei499mWRDcLAQ1Z4TJN1DGn8JWiisRhHcIVd6t/5HCw
         6Muw==
X-Forwarded-Encrypted: i=1; AJvYcCUgHlJKlJZmJLwPwYXZrePPt6vDPzy0v9NELmYW+UaijFb0koxXWp5/hMRxiJjvWsbqDupDDnZQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxDpazVADSv99v6/0o/17LW1JpweSMyy+gyY6EEFsp5yIUzAQU3
	RPTaYMj9/eA9UC9RpCdviqocYuTrUiyuqX16bTfM8xP8IJghwZ9YQ9/S
X-Gm-Gg: AY/fxX5cZNnemarv0AG4DO7RSvLovzAzcqnPiNYJTyFi+dY8eN0p1/ArGEdsuC/PApA
	UfzlDDegXZTAxsoJ+Biu4vR66JTHqZmYmIf4LJxFH8u4L82lrxmt0fwWeRqo19R0+9zhl9BAqMm
	kOmPoWv8UCtt0K9L1+XbfFtKixZgIWAQ7QmYqmO8vDjW2WXe5ArVZ2f8c1q5R3zS+FJO1EbT9tk
	G9rYe3mi4L2bL/f7OAnMi32DI+o3LM08Mjy+FOjKt3b0s/8Nr1a4w7qs52tdI+AuydSZ97qzcdZ
	gFXO/JHWj6ilbcDiexn7e2icxpsdqFqdNxIzhVkMAS6MivywPGKY3eXpFOfTYXhwNRFf+vxMHtD
	4PVsCTX+1RHqoNVkl5vEh8/AmOxzaCW3uyURXa5tBnqZj3ggKJTKwD11FtDYVmMnNhCamM/8m6d
	fWl2vR7es=
X-Google-Smtp-Source: AGHT+IG31t9E+qtbzvlggQ58tNUpirdrVXwoq5p8e1XvpatVKwcKANPdBsUzaj3dxq8sc9z2zdP7qg==
X-Received: by 2002:a17:90b:1d0d:b0:32e:23c9:6f41 with SMTP id 98e67ed59e1d1-34e90d6980bmr3302082a91.5.1766169881612;
        Fri, 19 Dec 2025 10:44:41 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e76ce0c8asm2156786a91.2.2025.12.19.10.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 10:44:40 -0800 (PST)
Message-ID: <aaeacdd937e2d0b04959c009bc9ebdd18497865b.camel@gmail.com>
Subject: Re: [PATCH v8 bpf-next 02/10] libbpf: Support kind layout section
 handling in BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org,
 ast@kernel.org, 	daniel@iogearbox.net, martin.lau@linux.dev,
 song@kernel.org, 	yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, 	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 qmo@kernel.org, 	ihor.solodrai@linux.dev, dwarves@vger.kernel.org,
 bpf@vger.kernel.org, 	ttreyer@meta.com, mykyta.yatsenko5@gmail.com
Date: Fri, 19 Dec 2025 10:44:37 -0800
In-Reply-To: <CAEf4BzaS9xoFaTF7LEyjYg9iPZZGn3=UhDVXAv9AuuMz1wFoZg@mail.gmail.com>
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
	 <20251215091730.1188790-3-alan.maguire@oracle.com>
	 <CAEf4Bza+C7nRxFDHS0dNDk5XF79nE6y4GqEu0bmtJPTMoFrNvQ@mail.gmail.com>
	 <db38bb39-7d16-41b6-968d-61e3b7681440@oracle.com>
	 <CAEf4Bzbn_eWC8W8+so-BgkzNOxx8jgEysU3kTzBCW1jwXPEfnQ@mail.gmail.com>
	 <ccafde20-3ea5-458a-b2e7-219aaa9a7ff0@oracle.com>
	 <CAEf4BzZ+iH1XvaYOjE==GPJ6wFo14_QtrFYvyvWa=ebc6UKPbA@mail.gmail.com>
	 <a99c8b9148a71c7827b00be5c793bfe8379de1de.camel@gmail.com>
	 <CAEf4BzaS9xoFaTF7LEyjYg9iPZZGn3=UhDVXAv9AuuMz1wFoZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-12-19 at 10:41 -0800, Andrii Nakryiko wrote:
> On Fri, Dec 19, 2025 at 10:36=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> >=20
> > On Fri, 2025-12-19 at 10:21 -0800, Andrii Nakryiko wrote:
> >=20
> > [...]
> >=20
> > > > The sanitization for user-space consumption is doable alright, I wa=
s thinking
> > > > of the case where the kernel itself reads in BTF for vmlinux/module=
s on boot,
> > > > and that BTF was generated by newer pahole so has unexpected layout=
 info.
> > > > If we just emitted layout info unconditionally that would mean newe=
r pahole might
> > > > generate BTf for a kernel that it could not read. If however we rel=
axed the
> > > > constraints a bit I think we could get the validation to succeed fo=
r older
> > > > kernels while ignoring the bits of the BTF they don't care about. F=
ix that would
> > > > also potentially future-proof addition of other sections to the BTF=
 header without
> > > > requiring options.
> > >=20
> > > No, let's forget about allowing the kernel to let through some
> > > unrecognized parts of BTF. Pahole will keep introducing feature flags
> > > that we need to enable (like layout stuff, for example), so old
> > > kernels built with new pahole will be just fine. And any
> > > kernel-specific modifications will be moved to resolve_btfids and wil=
l
> > > be in-sync with kernel logic. I think we are all good and we don't
> > > have to invent new things on this front, potentially opening us up to
> > > some unforeseen attacks through BTF injection.
> >=20
> > That would mean that the flag to generate or not layout information
> > should remain, right?
>=20
> Yeah, unfortunately, as there will be no libbpf to sanitize that. But
> that brings the layout question for Clang/GCC, are we adding that?
> That should be emitted unconditionally, IMO.

I don't think we have layout generation in the current roadmap.
I'll add it to the plan.
