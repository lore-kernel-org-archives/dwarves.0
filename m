Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F14B3A1C9
	for <dwarves@vger.kernel.org>; Thu, 30 Oct 2025 00:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761784480; cv=none; b=jCMLFtau0Job2uh6ZDqB1OSvdMuSL4pDfaKqZtOmMMHaK/MTjcnwRP2rTQOXG4qWpmGpk74qaI6gu+u6sybe6kGfYssA8QjF2pQNxWJqALCGQAIuXs5rTEhcA2kXFjsqutaUCuELdmitQDqyRDTsjmMED08hBCauHAZCgts4WTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761784480; c=relaxed/simple;
	bh=1qxVsSAIwaVyOEGI2OzLBsOB6lwwmuHHlXNB1Q2DNOA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=to1lWATv0W6wVDd9/3FiTRa4beKkDYpCHzghBomQDL5bYAlTvDzaxcGMV8oLFRal0E5lgom9uwWuOBMDGiEjJzYBUijN3HiscW1Wpv9DGkh4sc9hIzq3KOZ5fXkAe0O24O8fMkNJNqOgEf19o4PuBycLVdd7/PjAlYETfcb5Q0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ReVLycyQ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReVLycyQ"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7930132f59aso737655b3a.0
        for <dwarves@vger.kernel.org>; Wed, 29 Oct 2025 17:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761784479; x=1762389279; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kAeb6/jvvRZTFeWvAwgm6jZ0gcxQ5BaYTvlVtG3eXaM=;
        b=ReVLycyQBj6D8hsbrstid2X9PI3m1JvcBkOgknj6aGsbArHndzEUkYaHVLidHVOOsJ
         4I60E65Xf+9Vv/y92CWrtYzA7sBMIqpnUIuO4o1/wFuHw/O2xmDG+8v8qzXlvlSoW4RQ
         bSpAeiUAnYSOFVOFLEBR9mDpT3pyDWiYCaXaBkOe58Y3IgpHTZlhZDsy9T/OO38Nd+aK
         /WuSWoUx4oCaGdJOp4UXX82d5XH/spcRhPB3bEQ5L4tEuVTVanLUVQZCadKGEpUp3jQv
         mLAbzVyiM0TMfj5cmJvBsTL3o6xIXAEekAFvBEAB7YkAcJpL+nFDtd+UiOOvTupEMaG3
         jRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761784479; x=1762389279;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kAeb6/jvvRZTFeWvAwgm6jZ0gcxQ5BaYTvlVtG3eXaM=;
        b=aMD/vl7T7/8ZIFc9Syy0wgONmwrjRPiT3KgWPLGRdyKnH479/O+3xiyBosxJN/zCvT
         zjo3FAHL857zoswZBm9HdybehoBv9dIkeJNMsDXPV7G1wY6c5b6xIx6z8nqtv6n2glnj
         AQFkK1ei//omDwvNQ/zmcyYDP1giNDe2EhFDdJbA5fxlG2SxvNfW89SM+CnMrD+ZS0uM
         /HtKZ2ju7lozeO8xDZcUvcm6Jk+51huwzD4F9UGqtcLySMQMYMPJlGjQTc2Qch4xebH5
         wwiYD9dHBjJFfAy6mSHo02qRZag2W8t6fcb1zHkKmrJIHHvS9WS8eDC0BwOOQjj2M9E4
         uMiA==
X-Forwarded-Encrypted: i=1; AJvYcCVDyVOrp6ySKmPDWIPjAl1qibhsouuYPmPyGm/GmlXXFIrs1oqblgLDtedcUHh/llKFcBP03Tay@vger.kernel.org
X-Gm-Message-State: AOJu0YyAfN1VULE9LRPpLrII3eHaDoWOGoD2MVtdFUrGe5oWCfUNmcFu
	/HAWQWzw1/VI+acZou69TSz7T92xS6SN3pdgbCk8Svp8+5EcAypFuf/9
X-Gm-Gg: ASbGnct0gNH1u9kaiAuWwJfYCe/I/F0qzUOuXkEwBNmN5/FFwSwqWIwWgMGwRdyk4Wb
	b0RaVDy0Ha9Cfsn82iB6cAALeXv0poXsv+eJae/X1b4pEzNtN8X2x13UmsPGwdJOC6CSeqavzQp
	GIA2SXGeN3z0tjdjKk+WxKIUF5a4i7Znq6ZCoeDVsiYc0onJXpgESq01bE42s0dKFB1ONdEXY7Z
	3bRL85O6HrdLsBeGZFUg6xUWATDC3UUiQfoRjmryYeAFRdgTKSEc4ZGw1CvSYb3JHz2U/FCa6UF
	v30KXf5QakT7MBvEIvvDKbFXY6A5fSDpeBz5s97H3X0TcXP9bSUNVH/neOGj/rjA4kjJN38YP9J
	BUJyl7FzbLh7NPTeZtgCeNeyL2IpMMemrhBtp1N4gQXTp5cFx+Syv/Hi2q6vTfty2TNwDfU0VjK
	MFAN/rGSw8JTAO+CKOSeKH+o43GA==
X-Google-Smtp-Source: AGHT+IEF9TKCc2e0ZQgR3jSC3BE4yFhJUMwpQPTJSa/qncQWobsemJejfV6zQ1oz6uG9JsEIyMI1TQ==
X-Received: by 2002:a05:6a00:14c7:b0:7a2:8111:7807 with SMTP id d2e1a72fcca58-7a4e2cf5221mr5924534b3a.5.1761784478761;
        Wed, 29 Oct 2025 17:34:38 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:3086:7e8a:8b32:fa24? ([2620:10d:c090:500::5:6b34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414068f0fsm16848252b3a.46.2025.10.29.17.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 17:34:38 -0700 (PDT)
Message-ID: <ae1669b250a3e5532741e18f70f73e4e98a3bb48.camel@gmail.com>
Subject: Re: [PATCH dwarves v1 1/3] btf_encoder: refactor
 btf_encoder__add_func_proto
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves@vger.kernel.org, 
	alan.maguire@oracle.com, acme@kernel.org
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, tj@kernel.org, 
	kernel-team@meta.com
Date: Wed, 29 Oct 2025 17:34:37 -0700
In-Reply-To: <20251029190249.3323752-2-ihor.solodrai@linux.dev>
References: <20251029190249.3323752-1-ihor.solodrai@linux.dev>
	 <20251029190249.3323752-2-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-29 at 12:02 -0700, Ihor Solodrai wrote:
> btf_encoder__add_func_proto() essentially implements two independent
> code paths depending on input arguments: one for struct ftype and the
> other for struct btf_encoder_func_state.
>=20
> Split btf_encoder__add_func_proto() into two variants:
>   * btf_encoder__add_func_proto_for_ftype()
>   * btf_encoder__add_func_proto_for_state()
>=20
> And factor out common btf_encoder__emit_func_proto() subroutine.
>=20
> No functional changes.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

Ha, check this out:
https://lore.kernel.org/bpf/18bee370c4804e666eb7d5360c47439c246e1cb7.camel@=
gmail.com/
Wrote same thing to Alan on Friday :)

> ---
>  btf_encoder.c | 135 +++++++++++++++++++++++++++++---------------------
>  1 file changed, 79 insertions(+), 56 deletions(-)
>=20
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 03bc3c7..0416824 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c

[...]

> +static int32_t btf_encoder__add_func_proto_for_state(struct btf_encoder =
*encoder, struct btf_encoder_func_state *state)

You can get rid of the `encoder` parameter here.
See https://github.com/acmel/dwarves/commit/080d1f27ae71e30c269a1e26e85bb86=
c3683f195 .

[...]
