Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1998B1FDA9E
	for <dwarves@vger.kernel.org>; Thu, 25 Sep 2025 13:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758806916; cv=none; b=eQc7p0hdr7/vgY4vHPxCxbX8ZgJ6Lk7/1LEX8oaS7Eh7HOq/HpGT4WuQ0rrNzHRVxqLeia/dArsvB6lH6wgpuz0aR4mgR9+oqUJWhoHObkqc+5NSX2VUox4Q/ZBToBO+88Swvs7Wh1JJxWL5PHMFcBbQ7pFgSOSNLx2GA2QUczc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758806916; c=relaxed/simple;
	bh=Wtr4343jRw+x6tvTLVc6oPOqmQwis8WJiaqbBbi9p1M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I2blBSXUKfoGr0+XWWROnc2gAks37WkbDuJLdhFE0lTYyxpgGtNGhkEhkYJAQsVg4QZtPSTV3TJlB5fiHk5CrviL/5YozjIW7aBpEJWL507fr1Ys/KPWHb6ecKCc3klFl6DPACYWc/B7awoY9C5IKv/xOK9JRxLIzbddK7h6+5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=McRjYv7P; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McRjYv7P"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3322e63602eso1276822a91.0
        for <dwarves@vger.kernel.org>; Thu, 25 Sep 2025 06:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758806914; x=1759411714; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nKSNE7rQEgC3Vt/685jIbcjO6yNnx0GPMdfTZMEBO/0=;
        b=McRjYv7PQuAuJIgp1WkTzaUIConLHmqsNPAGPzUnwHpZ7iuxrHu+e3L+Fmsk5Y9ENh
         xm06uFEdzjUAs0Ego6AyErXmy3OsQdDOLVhEhxWl5y1nlLnizk+DmbUqqV8a+Cs5rweT
         EjVGlGDUBMlshJSIbk0Y1neGKLwPm0deamKo5RFZAafZ9M6rV30mxFWVt5f5G9koQnRb
         4ghEnDp12xDtNxtasiERCFOPaEHUUGaRTzbgAncilj3KIQbYe72B3iekPEKWnXK3Hmyc
         f+r+kb5RexANLtom0R7tuH0Cp8/JepZZQBiZHf85VAPzrtORbxs4CrDjFsIyHDkJCn2f
         r/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758806914; x=1759411714;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nKSNE7rQEgC3Vt/685jIbcjO6yNnx0GPMdfTZMEBO/0=;
        b=E6gPmPPwiMzf3s1cu7qdeUuGnXS5C0YqHzRhxGafJLXESXRHq0Tj/jK9HY3I0tAPOm
         U9LcES7eSE57DJ2MJwpk87aBrV/06rJ3zi4BELpviHHR7h8np3FWBC92+H05IMeAix7a
         vdZD/EKTasjLJDsNjb/n0983p+rh4GFxRRzmB0o8DUW/HMyufcUmxokwmwblbedWd+2Y
         HRNZOapHogG+EGAjP2MohXDeXmoSI62/uSdsDNYL0mLlSz3p2EgOdfjGa1Ym0SBT+Yq7
         HVXfND4dLupto8tofSiDDjquG9MjJwhOw1eEc9Kql4PbNj/m7NHtUgcdLB4P2or9QEOe
         5z0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU2HiOkjfBchtaaKqc0vl6EV39u8o754xC0HaYTiErLj/TTTNGK+ePFlFSCyQhFxa3g11F3Q43c@vger.kernel.org
X-Gm-Message-State: AOJu0YylLw+M47tmXjLCgWLWBD3Zk+QLK95bjhNrUGH58qr6wsI0ld9g
	sWHlZaON5VYqR33HolOsNAd4PcIEAULUDCUmcNIToz5iAwA/SZYLmDkZ
X-Gm-Gg: ASbGnctlJztPg/gqEXD91CIg58B6O3YahYmm2GWUz9foJUdO1XuP3kJN1ASjKY0TEeS
	mflvOAXkRN8TZjRXnop3dH83N8muyJrDcNX4Ig4h7rWlVnardt7k0HugRJ8uxGIDQV/+jFT6nPd
	+sHeAXxWEmRklt8dwyOCVVogFJiF1TUdtu5B4vT8e8kLJLmbd8Lo7T8hxs5bPlqP8pcGX6C//Uo
	Z36XPbr2bycWHmsgj60hHcgYIbST/qv+keOk+Pgxq+LkYZ3kaqD4JPHx8TKnVbp2mW1PRAG8vAN
	iHaQy5VUC1RxDl+wx2G6bwY0xbSFULDSgGtS9qPpW08ecHNxvD0yPuBcG0PdZpksnExwCd7R8ez
	2jq+HeEUVfTPyMWx3jwLr1ss=
X-Google-Smtp-Source: AGHT+IG+2OXHAZ/OOB6tGx4st9SdDqsB343hU2yAeiB/tTlQmrBbTF+J4DCQGTWAHYW4xflyZuXd/A==
X-Received: by 2002:a17:90b:314c:b0:32e:5cba:ae26 with SMTP id 98e67ed59e1d1-3342a2ae68cmr3654294a91.23.1758806914245;
        Thu, 25 Sep 2025 06:28:34 -0700 (PDT)
Received: from [192.168.33.19] ([24.114.36.201])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33471d71199sm2396108a91.5.2025.09.25.06.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:28:33 -0700 (PDT)
Message-ID: <b92d892f6a09fc7a411838ccf03dfebbba96384b.camel@gmail.com>
Subject: Re: [PATCH dwarves v1 2/2] btf_encoder: implement
 KF_IMPLICIT_PROG_AUX_ARG kfunc flag handling
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves@vger.kernel.org, 
 alan.maguire@oracle.com, acme@kernel.org, andrii <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>
Cc: bpf@vger.kernel.org, tj@kernel.org, kernel-team@meta.com
Date: Thu, 25 Sep 2025 06:28:26 -0700
In-Reply-To: <a7f28918-7eda-42e9-ae41-446b7a2d9759@linux.dev>
References: <20250924211512.1287298-1-ihor.solodrai@linux.dev>
	 <20250924211512.1287298-3-ihor.solodrai@linux.dev>
	 <4fb8a812fdd01f115a99317c8e46ad055b5bf102.camel@gmail.com>
	 <a7f28918-7eda-42e9-ae41-446b7a2d9759@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-09-24 at 20:59 -0700, Ihor Solodrai wrote:

[...]

> I'm not sure how generic KF_IMPLICIT_ARG would even work.
> Any *implicit* parameter requires a very concrete implementation in
> the verifier: an actual pointer of a particular type is injected after
> the verification.

Does not seem complicated:

- In pahole generate a special decl_tag for bpftool.
- In bpftool, don't emit last argument to vmlinux.h, if that flag is presen=
t.
- on kernel side, when checking kfunc args, also check for the flag
  and switch over types recorded for last function parameter in BTF.
  If kernel knows how to handle it, great, if it does not, emit
  verifier error.
- Not sure, but likely, the change on the libbpf side will be needed,
  as it compares function prototypes between program and kernel BTFs.

E.g., for bpf_wq_set_callback keep the definition as is:

__bpf_kfunc int bpf_wq_set_callback(struct bpf_wq *wq,
				    int (callback_fn)(void *map, int *key, void *value),
				    unsigned int flags,
				    struct bpf_prog_aux *aux)
                   =20
Kernel BTF will have it with full set of parameters.
But because of the flag, it will be printed w/o last parameter in
vmlinux.h:

extern int bpf_wq_set_callback(struct bpf_wq *wq,
				    int (callback_fn)(void *map, int *key, void *value),
				    unsigned int flags) __weak __ksym

On kernel side check_kfunc_args() will have access to complete BTF
declaration, so it can:
- check presence of the flag
- lookup bpf_prog_aux from the kernel side BTF
- call set_kfunc_arg_prog_regno.

> So we have to do a type check on pahole side to catch invalid kfunc
> declarations. And the verifier of course must be very strict about
> where it can pass pointers to kernel objects.

Type checks on pahole side will require upgrades to both kernel and
pahole, when new implicit parameter types are added. I'd try to avoid
that.

Also, do we plan to have several implicit parameters passed to a same
function?
