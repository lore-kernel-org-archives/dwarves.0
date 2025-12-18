Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4893321D7
	for <dwarves@vger.kernel.org>; Thu, 18 Dec 2025 20:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766091453; cv=none; b=eyapvGXuh+p6OunDuRDMUtiDEf7aFos5e4Tzs/vowEiPL1XSCfbJ4p1sLeifSZIjvTmXMbS6q+hKLQWPhKEufF9X/AMLwfT9G1c44OswbLfarXMMyW/ARbwb9q3Biv2GItrTBjUSY0X0EEq4TRdw0DH33pylpOfXGyP3NfIPzVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766091453; c=relaxed/simple;
	bh=Wk9qv34inWutk0debgHw5c52MI0wE6RiXjFrTeu/W50=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MBcILxaUKWeX6qdsotR2k5cjLf4QN2sIT8lf2pMWW1lmN7U3mJTi7eu4ZE1/Ry+Wx+5+t/VYsBDMkOCLDrDmtSkCKXC4XJgh7r/7n95rLcg1G2vrbo+ZScXMmnAv4rfKeYEA7KH5z0nAZ53PQBVJIxyLjosFxL9eqjpSRJcidQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FaV8xYao; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FaV8xYao"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7f0db5700b2so1010510b3a.0
        for <dwarves@vger.kernel.org>; Thu, 18 Dec 2025 12:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766091451; x=1766696251; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wk9qv34inWutk0debgHw5c52MI0wE6RiXjFrTeu/W50=;
        b=FaV8xYaoL/pd46fC66fgHn0FIjdbefEapfZ3o1xxFYGp+hsRVKKv55c+hDDMhJt2+s
         xQ2eadFG5n1IFkuIpsdzaxCwhxe89Vjv4JjbJnm2b0HLtDfgy4OV2IAaWGHdSqf5Xw72
         aRzxuMKFAa0+tzTYeYhWeavR4n2fSiaKCo6d3b81jigRFXKu5uzzUGZG5CjlGfCeihMN
         WWEL666dh39RYJJaNzXHGpzWgf5I1OpUh0w3Iz1uwomsIkYwckNvOvlfCZIe19g+EOyk
         7zsyLxzUq0FfvwoZrZC7nD8z2/796wWC1/rXlQfIc2Q7Dw/IOy/lyUxrYkBjhrOVuSoh
         X7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766091451; x=1766696251;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wk9qv34inWutk0debgHw5c52MI0wE6RiXjFrTeu/W50=;
        b=ANpDNX4SW4kTWyP6SDUuobPg8hcU9h0zisdy8p/GgKTLlxZmZAVjLiUOYW4NANLQl2
         ZNCX/UuWLcm+hYFamtuAvLfRCkqgbpFGwtP0vm6mSvs2Y19rJ8dDhYb7SDhxtQiOq0oo
         36syq+tn+tTSK+DXytLgqHx0yYfyV9mwgNjE93QtOUungSvnewlhxkQA8R7klfZO+idp
         Gd2iMEIzUQ1PoGqNpvewBj92ii7Q0vVtV5FS+Ebf1yu8PHnnIPzqzue5dvbq3cutlCoB
         t1Ax3DebnHDfzZdAUqXg3iRYct73L7Tjriy7dpVSK0BRMTFkiVdTLAM3O9NtRVx7NYg/
         jZaA==
X-Forwarded-Encrypted: i=1; AJvYcCXrZc0owDLY9GGb4bvQ5Y/R3J6XQabPNMI+7Z7+0PexCy9nBNB80hTp+GEQNCC+yskDM3/LDAHa@vger.kernel.org
X-Gm-Message-State: AOJu0YxDIp+vbf+b5BMzFNy5yyMXzErvUbh+qFCaoa+Ex6G1hwsXdCyH
	9HOBfnRtgv0vMOmWIV3mAF5HlyOvXO0Hb1+PPRpH/nnjiec3lQPAXAB+vniS07MMuVo=
X-Gm-Gg: AY/fxX63IwH7Dx8Koz7e+T9X1RX4Qm3q4jFzFLlJf/MD24goLhEX3BOczT14eQaZIXn
	UHk+v7ytufX5XZgCYG689W1KQRNYskBBcSRgbmNbXe4wWVpYoWB0a2OXS7J5Io9J/QPC2pj6wxC
	39g/nXm/tmd5+hkb5TDddtCYupjc6dMwecOx7mSz4M5VKy3HFqKyZYJ0Vu9Q4DbCnUrQQP9JCQ3
	soOmbUU1bV8d0chwLk2JSWEhMeGvLOxgGG2RZsCoAh2ybMAYRgzJJhmYf05NEbbM1oxZc8QM8NI
	SDr8Fi7A+Ch3HMg4hC0MWqqdEr9OSZbePHH8nkLZYaZPjeDu2EVVQr4UwfnWgzPZKzp/lN7kfVx
	nVj15McIVnbLxOfDQVKkkfAb01HRH8wlgs4oDfMj0ZTMDDMKe6oe5qjDeUNDQh7XWbjt8T/q2X8
	2MMkmeOqjAbdes0KTa/clOf6ZMsqTxAafYNmr1YMq768pnpA4=
X-Google-Smtp-Source: AGHT+IE5wqF1Ur/4n0bAKqhUgwQpIAW7BXffJ7Vx2YXELxiT7ohVhw05y1v6Iu0zG3ReeHlWkO5oUA==
X-Received: by 2002:a05:6a00:4006:b0:7e8:4398:b362 with SMTP id d2e1a72fcca58-7ff6667949dmr378405b3a.53.1766085763362;
        Thu, 18 Dec 2025 11:22:43 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:d912:2088:c593:6daa? ([2620:10d:c090:500::7:e642])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7b127b00sm99807b3a.21.2025.12.18.11.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 11:22:43 -0800 (PST)
Message-ID: <0be0a3b4d39e31653ce38c16b413d717921f2ced.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 7/8] selftests/bpf: Run resolve_btfids only
 for relevant .test.o objects
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alan Maguire	
 <alan.maguire@oracle.com>, Alexei Starovoitov <ast@kernel.org>, Andrea
 Righi	 <arighi@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
 Andrii Nakryiko	 <andrii@kernel.org>, Bill Wendling <morbo@google.com>,
 Changwoo Min	 <changwoo@igalia.com>, Daniel Borkmann
 <daniel@iogearbox.net>, David Vernet	 <void@manifault.com>, Donglin Peng
 <dolinux.peng@gmail.com>, Hao Luo	 <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, John Fastabend	 <john.fastabend@gmail.com>, Jonathan
 Corbet <corbet@lwn.net>, Justin Stitt	 <justinstitt@google.com>, KP Singh
 <kpsingh@kernel.org>, Martin KaFai Lau	 <martin.lau@linux.dev>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers	
 <nick.desaulniers+lkml@gmail.com>, Nicolas Schier <nsc@kernel.org>, Shuah
 Khan	 <shuah@kernel.org>, Song Liu <song@kernel.org>, Stanislav Fomichev	
 <sdf@fomichev.me>, Tejun Heo <tj@kernel.org>, Yonghong Song	
 <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
 linux-kbuild@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev
Date: Thu, 18 Dec 2025 11:22:40 -0800
In-Reply-To: <20251218003314.260269-8-ihor.solodrai@linux.dev>
References: <20251218003314.260269-1-ihor.solodrai@linux.dev>
	 <20251218003314.260269-8-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-12-17 at 16:33 -0800, Ihor Solodrai wrote:
> A selftest targeting resolve_btfids functionality relies on a resolved
> .BTF_ids section to be available in the TRUNNER_BINARY. The underlying
> BTF data is taken from a special BPF program (btf_data.c), and so
> resolve_btfids is executed as a part of a TRUNNER_BINARY build recipe
> on the final binary.
>=20
> Subsequent patches in this series allow resolve_btfids to modify BTF
> before resolving the symbols, which means that the test needs access
> to that modified BTF [1]. Currently the test simply reads in
> btf_data.bpf.o on the assumption that BTF hasn't changed.
>=20
> Implement resolve_btfids call only for particular test objects (just
> resolve_btfids.test.o for now). The test objects are linked into the
> TRUNNER_BINARY, and so .BTF_ids section will be available there.
>=20
> This will make it trivial for the resolve_btfids test to access BTF
> modified by resolve_btfids.
>=20
> [1] https://lore.kernel.org/bpf/CAErzpmvsgSDe-QcWH8SFFErL6y3p3zrqNri5-UHJ=
9iK2ChyiBw@mail.gmail.com/
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
