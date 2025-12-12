Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A14430F526
	for <dwarves@vger.kernel.org>; Fri, 12 Dec 2025 07:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765523428; cv=none; b=BltrfjTE3j5F3R1Anmv750BB9QdA9i6XTXwUqKcKyZp/oXipQv4LhARFoHHvnK3HL5gjF+w54JcgxcTLLeA9TTkh2WQCb2AiluM+3Iu0S3B5eLc91+B5e1kt75/bsQRVFR3oPG3JQcHwko9WQaU6ufjDeA2ppQYSpgWCbn5Zjbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765523428; c=relaxed/simple;
	bh=W7uppCv7V1iw0fcoFOO1Ov19o0BqWyomQuPZ+QZwW24=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ASHWO979BoznBa9EtQmmzA4W6u8FFwkA6dXPO0Mruwg2Ha0jVY6JFSlGpMbtGvIxSzV2c8Z9rPVtJtQaB+Bv+AKAQ2+vTV99LpOackRvgFpzznkAPxywoh1lru4Z6e+aBQ9XrwRMarS0VCyB/KOlT2KMSKkLv69/2cr8lK63zR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdYVYhXq; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdYVYhXq"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3436d6bdce8so984023a91.3
        for <dwarves@vger.kernel.org>; Thu, 11 Dec 2025 23:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765523426; x=1766128226; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W7uppCv7V1iw0fcoFOO1Ov19o0BqWyomQuPZ+QZwW24=;
        b=kdYVYhXqwt4Vp7WzR2Q3Ynwt+4xcxM1ONflrrKsrY9nMGzVZdCkhv2dfB2w8mRsLID
         9DuTzfN8qEdSvSjMfhTr0SBGj797Lw6iCvZL3HCY9Wi+0eYyP4m8tahPt2etrSpnY+Ff
         gpz5kuONXKwpSsW13HeIkzbqyUNkpHZqBnBkvhtdwgSFmMX6ClB7RLMMs5eTQjpi3qBa
         zBRFKybMsPpTRMKSZ/TCHmEnAM9Ft+EggdE04lSqtrOk2LNufzQkhpwuhYj4b/n53GZp
         iYplcDZWs1xOcuzBlq9UtMcx25iGatvbMu1ubh+4gTDKxXFLNKj4mJ4a/AzFkheZCnxq
         oRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765523426; x=1766128226;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W7uppCv7V1iw0fcoFOO1Ov19o0BqWyomQuPZ+QZwW24=;
        b=YMI6lS7ForEn8wQhFGtcZ19EjGnb5+a1GZ62xf15T1ZsL6xSVNlHZPGodE9xp5vxhy
         nTghU/lZEMJCxdv69WZO25HOy8/nt0wDmIaN90UUvh59jrdBwm9HljemLiKP05zoj6fb
         75+64gzC/Z0zmF3fuEHMlJj8FLWDFpiiSJPgQ/eXT+UO/hOAecf/Yy1RcYAFuUhUzNgU
         6Oh2P+vDOrpoME/KUwJf/egEBUZxHxQ6XeV/Ezfp+fqVx+TzHvccQ0QxIypZ5K3G6A+g
         BnV7T9j3pEXE17Xk4CWlESbSCQX7nLtQVY6IhXnWX8i2/jy+YyoR8PAV/TolQ9PndXph
         giYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWklokSRcmpFaHtViJ4ZlGjiWBhsKareK1MRCU6ZU2SF6S8LcfwmLwFtgHFB9ytmBPb13mGxPu@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ+0tO/e+rTWCVpAAu7dJmx83p2/qsMRYoHfu5nsf7Q0e46z2L
	E1IRJcBJJIJ0Dcj15F6oDbhwQl/IZRWZNcseFXtHRuRxZ3Ai5fu1F6b0
X-Gm-Gg: AY/fxX4ON4R15uqEHWWwbpkt5mfCI81ckhIj0o7mRFrxoDfYobXydcO7gzkQ+b3B+0o
	dChxV0ANeMM4rnjvklblxb3KA4xoRqC+2Dokz5H0rgk7upeVzq5rlh+UHoYCio8qKU14GeeVLD8
	6OVQjIzMMB55kW09aFmpXQPAVIQbJ1GMZ5Pac2ztl3guqptWGsT7wVVTB2DQiC3RHAL4AI7rEHL
	EBaUKX7HLXHBYfFe8xvjQVI7P7PWNKz7Za609OHXTrFCt+NpsXOpWJlpepn3OtZ1F7Ko2qRYXK1
	4n3otU60Poe1ZmteWEYYddhjHrn1+FHc7yfNq82HhMqzS1LQVyyXyAylInA3AW3Mjyg0OHufYn7
	zKjivQu0gdklSxFsH40zVPQzk03daufgNXau8TqW2pl7oK7T8Pg5b4bcdx+Gig+gMOrMH+SveHP
	ZDgNLKuTRhafCFgAgufHG87VvwiaUfTg8+slU+zroPybQ=
X-Google-Smtp-Source: AGHT+IFABMRkw8oyKCgA0tVnnLIaZDoEoQW4VZmuiRYNtTWUY/AN8gGPDAFTfjKFmICcMWMfhDD3Cw==
X-Received: by 2002:a17:90b:3b50:b0:341:88c9:6eb2 with SMTP id 98e67ed59e1d1-34abd6b5d46mr1284217a91.1.1765523426298;
        Thu, 11 Dec 2025 23:10:26 -0800 (PST)
Received: from [10.200.2.32] (fs98a57d9c.tkyc007.ap.nuro.jp. [152.165.125.156])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe2aa5c8sm976435a91.15.2025.12.11.23.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 23:10:25 -0800 (PST)
Message-ID: <bf7ed4cf0254fb3fa707ad49f3b2ed0be6b500c2.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/6] resolve_btfids: Factor out load_btf()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend	
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev	 <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>, Nathan
 Chancellor <nathan@kernel.org>, Nicolas Schier	 <nsc@kernel.org>, Tejun Heo
 <tj@kernel.org>, David Vernet <void@manifault.com>,  Andrea Righi
 <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Shuah Khan
 <shuah@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt	 <justinstitt@google.com>,
 Alan Maguire <alan.maguire@oracle.com>, Donglin Peng	
 <dolinux.peng@gmail.com>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-kbuild@vger.kernel.org
Date: Fri, 12 Dec 2025 16:10:19 +0900
In-Reply-To: <20251205223046.4155870-3-ihor.solodrai@linux.dev>
References: <20251205223046.4155870-1-ihor.solodrai@linux.dev>
		 <20251205223046.4155870-3-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-12-05 at 14:30 -0800, Ihor Solodrai wrote:
> Increase the lifetime of parsed BTF in resolve_btfids by factoring
> load_btf() routine out of symbols_resolve() and storing the base_btf
> and btf pointers in the struct object.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

