Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC572EE5FE
	for <dwarves@vger.kernel.org>; Wed,  5 Nov 2025 22:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762380543; cv=none; b=o4iKSr4RA3ioYkH2WZGKyJMtpllBG7nTxn8KL+IAXKzmei4KLaW4g+Coribb+SS61p9+cbM0q4sYibQgixSbguWjzffYDvj552NDp0w/Gr+mKV+07YsF8bIvwPl5yErfzUOxDqB7oMQf2xdrxWdyc4Ugcd0bbeJYXEoEj6emY0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762380543; c=relaxed/simple;
	bh=KgXp3nCnzWJkka6TIDbKkxCGzc5iLi6go3oc5VGCLSc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kTsrhT+Px3rts+q9J52cB8MtAbIheIfH5Fc1kd/p5UJYY5L9d/b9wMBlGlKKrX/D4MrOH5ti2NGvn8zlZmJcyPAOpb/oL7ySRBT3QQqnxoQHWckjltbGlZIsF4bj2p+xFaeDCi8oj8148sw1c9BKALfWasgUhDgCF5VCNB+8SF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1ks+Q7t; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1ks+Q7t"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-ba599137cf8so295229a12.0
        for <dwarves@vger.kernel.org>; Wed, 05 Nov 2025 14:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762380541; x=1762985341; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8+4iq6Nh86L1GZyal89LrHUzhbwe/7RnJqO8ZvkHHtE=;
        b=m1ks+Q7tcLohYFK1Dzo+hWdx5CmHrHwbBoqjjhsgJRTaWmtdiTCZChkUrbaWpneBtv
         eJXmAJLuVOYwh0+4LO34KowNDrReoK37Tg3l6ea/KJPKVwbcMkYBej4ol9zL3iSWF28S
         i2IAm5NkcX3grf/41Jx6a4EheZLnMvrnHBMopbgq8a67tH7smqqCNOMLQ1Hp5bO+gCC5
         Bfhfn8+a5JVgit3WBiezQACOfIsVDX94j1LHrPoXSz8R6+V1KGONOH8JQnMW+/5looJN
         FwUIgU/3I/ULSOuCtHWAfg8yarPGFTIGO+MdP43GiOpdrCoqwFn2Mn361il5x7VOW9Ci
         GzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762380541; x=1762985341;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8+4iq6Nh86L1GZyal89LrHUzhbwe/7RnJqO8ZvkHHtE=;
        b=ZwGFkdNPxefmt04DGG2gTokmNmC/ZIea/34F/CEndrOSrAAAbm1fGahvkbBCKCiljt
         IcpgdEAHk80ahFixeB5JJjDVy+jo2O83hmTSVDJP9I1J0mO1O30EJMZh0F9+OemkIX/Y
         k8xsDMquliA7SdDbw/GyrUg3v1dalpCpq2JNSl2yFZRdIvlEIoISpqIMEhrhFE5plszI
         WuJzzz3QZW5kr7QXe9zhvv11/5uGK0YBHnJ2unK7iaLdAcy7PqA3J340FoE3ZXk/20hM
         p/ybV1+GapJWnRB7nQTPFVbFOP1d4bUci9bfEDRfYavsniHUkM/8MwQ4Zu9tDYxvh08c
         JvNA==
X-Forwarded-Encrypted: i=1; AJvYcCWwPPJ0+bp2o5Z/dx7fV/8gleKKv2Z4CxojjxdesrpXW8oBl+bUqRBTsvPJ03cMNPiL5oXwTDXD@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq2425lXdxoQx7rJU2wUUYFLwfXNvc2xuD5dHUhVz12hdDFmB3
	V9Pgsnda9Oj7OL9+lzL5haDLCACQx48NYp8IjDqrdZ6tJHlAft45w6pd
X-Gm-Gg: ASbGnctBaiMWDrhJYNjOuuWGYhoqC5S5xymveFHj36FWDurqTJ36YigDscKtSrfB+bS
	kUtnOX4cX5b4vBWt8Kujakd+OajwxuOtlTHqLfQPO3SFBeoMB7+HkDzqOexPJLujFlZ+zAF02s0
	uIiSVF6U2SmXLSBpmUo6lHkcbUrfXaXyr0aCT9DHHzOUDUn8SvCHLGrVWwDLo+5SwaDf6zBzzIW
	l+e61LqXFppC3W3QDCNC0dUqvWC6dI7t5hzBtirpGKAZfxPWRqsVDLTM1mMQCR0ZfFRAw++nkSo
	yDYH0FezEQX+BkQaRHyss0tPtrhn75cW4Q5/kjU4IgPo0sg2HWUAbRd6J6PL6fB0p12eElbziQO
	bErvhQIwj7ahYk82CcuwVQhHLy5nHSe7Y4C4IrfJwrbo2GxUFuvM2FQckroTX3s0ngpprh9cheM
	O4D9KXXbeLESxEDhSa1RlG2Qt7LbmWkBkHF60=
X-Google-Smtp-Source: AGHT+IENaFQ323oqHXktoW9GYmrBP/FWVmxzB76vnO2zIMZUBVCvou6g2s32dv+DxPvmfdHEzD56lg==
X-Received: by 2002:a05:6a21:3e07:b0:2cf:afc1:cc3c with SMTP id adf61e73a8af0-350de314257mr966411637.16.1762380541043;
        Wed, 05 Nov 2025 14:09:01 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:cdf2:29c1:f331:3e1? ([2620:10d:c090:500::6:8aee])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d11e2336sm84997a91.1.2025.11.05.14.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 14:09:00 -0800 (PST)
Message-ID: <c251bcb61fb1ed225d2ad1b0d865f4b4bb7ffb5c.camel@gmail.com>
Subject: Re: [PATCH dwarves v3 0/3] btf_encoder: refactor emission of BTF
 funcs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves@vger.kernel.org, 
	alan.maguire@oracle.com, acme@kernel.org
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
 kernel-team@meta.com
Date: Wed, 05 Nov 2025 14:08:59 -0800
In-Reply-To: <20251105185926.296539-1-ihor.solodrai@linux.dev>
References: <20251105185926.296539-1-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-05 at 10:59 -0800, Ihor Solodrai wrote:
> This series refactors a few functions that handle how BTF functions
> are emitted.
>=20
> While addressing comments from Eduard, I noticed that we don't
> actually need to carry the encoder in btf_encoder_func_state, because
> only one encoder exists at all times. So in v3 I added a patch
> removing encoder from the state struct, which resolves the ambiguity
> of where state->encoder should be used.
>=20
> v2: https://lore.kernel.org/dwarves/20251104233532.196287-1-ihor.solodrai=
@linux.dev/
> v1: https://lore.kernel.org/dwarves/20251029190249.3323752-2-ihor.solodra=
i@linux.dev/
>=20
> Ihor Solodrai (3):
>   btf_encoder: Remove encoder pointer from btf_encoder_func_state
>   btf_encoder: Refactor btf_encoder__add_func_proto
>   btf_encoder: Factor out BPF kfunc emission
>=20
>  btf_encoder.c | 204 +++++++++++++++++++++++++++++---------------------
>  1 file changed, 117 insertions(+), 87 deletions(-)

No difference in generated BTF with my test kernel config.

Tested-by: Eduard Zingerman <eddyz87@gmail.com>
