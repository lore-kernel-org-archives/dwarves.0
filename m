Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B831272E45
	for <dwarves@vger.kernel.org>; Thu, 30 Oct 2025 06:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761804678; cv=none; b=CdiffeMK7EhhICZlk1NdIeLiq6uiCECpdtwOVnOZP8BkJv32Lvxxr4zEcU23KmyazrUxAomnJ5GnexDZ2Xyg15XBikK2gbUs5HqFr7OpIl0shzdxS831TqZ1pmivPevGrTA4GjYZDbtzl/7iBvwh1ZSF0tRwErsG6v/YYHMLqD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761804678; c=relaxed/simple;
	bh=QdocTsWwqPCC5vykodfn2Jg1rhZ+qrsFLU9vZrTMO4g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VlkB2gQu5pQqvEpaGKcCifUpzfrM6caZCIWfMTWqBT6aV9zr20nvpX6crcX7LrLP/M0muVP9c2tgydWvftrCVCKoLcHbnWsx8i1ZAjqiSkpMPc6XtYX3nLfVXCtBo5SyM/O0TDWtm6xinX67r17lfegk+1ubjwTxJGVaq1yHxMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VgZtj77E; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgZtj77E"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-294fac2d438so2574535ad.1
        for <dwarves@vger.kernel.org>; Wed, 29 Oct 2025 23:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761804677; x=1762409477; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vv+R4seUJBTjEv+BqyOlH6zqbBwjHB8AuHYCdt9SuRs=;
        b=VgZtj77ErQL+6zNoowb12SE7PvYl3KQxHsSSTP1y+Q0JXfxSyCr4BFOUkGBJGZFbDx
         V6lmhHOxE+UggdPHmkSxKER12x+PcAmXkuFDTL+c2Tn8rXSPLgBIfgyhJxJ4BXYelhLJ
         GW8dgRZIi7qoDd5iop4PLuAmwS18E0Od9vevy8MPFk6HNmY7B5R3yU4Pnkz4x2mGJwQL
         Rq6Xah/Oqk/IKiWLLtsaey5fLCRyLpD45tAXL0t40rwltFiPO7AuvTqvUCKOupnzvfvF
         9K6Qu6+1O3V9tMeQISLjM5RSL4UG6pf1u865KP3Zn6qltpRgy0ZAmlm2TwR5N+2mcnZv
         68cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761804677; x=1762409477;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vv+R4seUJBTjEv+BqyOlH6zqbBwjHB8AuHYCdt9SuRs=;
        b=trArNWzCbhoMAB25Cv7ax8xZ5hFgMxpParRHqnuABVGOZQyNfNVvz8/RNQcYwg3Mta
         EcA1/8+Y1BdSKgaXW2GWiOO3Svb8EjuQtc/rCHLhOa7ntHSY6S+29ETinCCPpkKpkSUy
         xkGDzn01o3Us4CNk+kQc95BTMghoiuE04OGKzCxeOZgqC68E+W5NHmqr7PHPWr9z5LMt
         ChV/qYL3yqj4pvRVuutI9PUkDUkfa4GxftY7l1ha6gg1kuKW6UIVVjDU1HGVtUkxnOCn
         o5fdTtM4qTyeAsl0JJ2yPsvjTV1bNn9h2K3N8g878X3OgPvplhCRUuXBitAi9343yq2A
         uOwQ==
X-Gm-Message-State: AOJu0Yy2JM7RTQ+Tz8golnXiK1JJ3/WB3SFtgLfM9uk+1NUOjoDZV5/R
	3Z365bbBzf+oBMfGWqL0Yp0EuA4yu0TLmFfDagnclG+Jv/X97tekZcuk
X-Gm-Gg: ASbGncsQshNPKAxVOsJe9S/VMUm7BJ1v1u7WcrTRpC2RiYez4e8fUP3SBKPjvwzD/Mv
	ipFsisIOisDnSQf9hqbfVPCFSM4HYA3Pq4sforLE/E9rXiw4Z11A11kcis8FzwvD3I0sXLn1ghG
	ADgPW8CR+8fwWRcQnzh83GZOqBhfrT0D2PJB8MjhGve4/6q6oEZ2PNZEBhPP70xXtRQcKE8O8dy
	Y2ZKWDHoKXx27LVkRr4s7rg9OggDeH9zZdvAAjPEJldgbL2S8yPO3dYPhfX8iBwPcJdwlIdSsGD
	yYU96GYcueFaJKYT1U7LCUn0dVxx4i5/rvDFL115TAztL6eFR2f5HHHHqt4I+tulp5CBSnlS54F
	QCbzM0mXiNZkSRJUexVDxGl1g8A0OTTSsGkRU1e0fhYxAVh63lYmaBGfahG32wDtHzKPz5di4
X-Google-Smtp-Source: AGHT+IGhxbWGxhv6KUnbxh+gMC2+wpZQA0QpDLgXpYFd/fAjDIGtYUlATrOKNxCSXndkFI1uBcfksQ==
X-Received: by 2002:a17:902:c94d:b0:24b:164d:4e61 with SMTP id d9443c01a7336-294edb9f7f0mr25199185ad.13.1761804676701;
        Wed, 29 Oct 2025 23:11:16 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0acecsm171394115ad.38.2025.10.29.23.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 23:11:16 -0700 (PDT)
Message-ID: <99115d79a7808ca1290726561e36b64ec56e2a1e.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 0/8] bpf: magic kernel functions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org, 
	andrii@kernel.org, ast@kernel.org
Cc: dwarves@vger.kernel.org, alan.maguire@oracle.com, acme@kernel.org, 
	tj@kernel.org, kernel-team@meta.com
Date: Wed, 29 Oct 2025 23:11:13 -0700
In-Reply-To: <50ddff79d33d6e2d57e104f610273d647530ddbc.camel@gmail.com>
References: <20251029190113.3323406-1-ihor.solodrai@linux.dev>
	 <50ddff79d33d6e2d57e104f610273d647530ddbc.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-29 at 17:44 -0700, Eduard Zingerman wrote:
> On Wed, 2025-10-29 at 12:01 -0700, Ihor Solodrai wrote:
>=20
> Do we break compatibility with old pahole versions after this
> patch-set? Old paholes won't synthesize the _impl kfuncs, so:
> - binary compatibility between new-kernel/old-pahole + old-bpf
> =C2=A0 will be broken, as there would be no _impl kfuncs;
> - new-kernel/old-pahole + new-bpf won't work either, as kernel will
> be
> =C2=A0 unable to find non-_impl function names for existing kfuncs.
>=20
> [...]

Point being, if we are going to break backwards compatibility the
following things need an update:
- Documentation/process/changes.rst
  minimal pahole version has to be bumped
- scripts/Makefile.btf
  All the different flags and options for different pahole
  versions can be dropped.

---

On the other hand, I'm not sure this useful but relatively obscure
feature grants such a compatibility break. Some time ago Ihor
advocated for just having two functions in the kernel, so that BTF
will be generated for both. And I think that someone suggested putting
the fake function to a discard-able section.
This way the whole thing can be done in kernel only.
E.g. it will look like so:

  __bpf_kfunc void btf_foo_impl(struct bpf_prog_aux p__implicit)
  { /* real impl here */ }

  __bpf_kfunc_proto void btf_foo(void) {}

Assuming that __bpf_kfunc_proto hides all the necessary attributes.
Not much boilerplate, and a tad easier to understand where second
prototype comes from, no need to read pahole.
