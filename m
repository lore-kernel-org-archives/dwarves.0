Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882EC346E69
	for <dwarves@vger.kernel.org>; Fri, 24 Oct 2025 18:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329063; cv=none; b=iZe8hd3ZxVdv8uG2tJdWsBs0zkTXrQx5pljonK9unWKCY5zWZz0urdQ4fgEGRJ8uAvfhl0p2qboV9+hOQktxr2Lww31ffJ/idI7fMATuJAwTZKX6ExVGznE+UgLT8/ALtI+CO3w1Nds4Rll4HVuZKI2YtfSEesrk912p+daIuCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329063; c=relaxed/simple;
	bh=0aXwfreW00qqegLYVnsodvroBi8vtCBLrEadWdIaZ4k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O/2oBpZbf3wLlSe4ckAGymGNeAmezvOnUBYZNQFDE2IiQzIRC97n3du+XIfVpI6q5V5N5+TBVB/FzVF+jWkxjGoxsyZ3YrdDYdHGLsQh9lr9shHab+M68QjQEp+InfUJ+drIunN7ezQsb9WqeDoLWt7R86bo1vUKQ4m/2Njh/AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1jlIRd3; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1jlIRd3"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29470bc80ceso26173665ad.1
        for <dwarves@vger.kernel.org>; Fri, 24 Oct 2025 11:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761329061; x=1761933861; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S2mPecITudGEHD9RRX13zhOsRqqQMp77PbhpvYwFYEM=;
        b=d1jlIRd3SDeTbvzBeQYJPg7adC+P80Xp1f8PT5LX7FE5B245ZxSDrroY5FyjuGXCft
         BQ472gODVzTrfNLeA3tP2QR3H8BtRhGMrNEx2ByBj7/KNd+cODHL2Jy9f4uLSP5VTh1+
         xtj+26Q5Wd4rHPrpKb8+8EwB+WCFpE8KT2O2iOkTIrAUFHP8y0TzxowPUcuvV2qUIcYi
         HkgsNgTGvPX1yk2oI/9w4WDx+uN5sY7aakz1NjANGTqdpdD4JuLtCDvEuGT9fm2mPhrR
         yDP0ZfNYRqORYakHQqwig7MqpcVsMBpQrlY+ST7R8hmug4Ox0XSiS2hmAvx0RwzhRcp0
         hLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761329061; x=1761933861;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S2mPecITudGEHD9RRX13zhOsRqqQMp77PbhpvYwFYEM=;
        b=haQO2iu23jZLNJ4SJzOsuFhpt/VvVUFZ21EcNuhuSXyvynbTfCyvvSmKusGKUaUppK
         3Mr6h/c2HhFcLhI2bgySqEDdYzUK6JFXOzW8Up/pBtLMxtUIHaM3v0+MJwxotNxPWI9W
         CDhPFWr8ECJ6dfBL3itRp5LM/vfuplNPSve5hvTcYXhajMZRfLJU8lX2q5XMWSjvz4d8
         GpOEglVE6Yn1iV3X5wKWZlPweNz302pOzn1/fFaZy1r58guiLaUz1TO5Qtsc1+++ArdL
         6ZhZ1GMSx2rzxJGwGf+jStpT+KFVIw1lcPVKf/CiBkTA43UteOBebsQUKuzSgTsEMR+r
         H7IA==
X-Forwarded-Encrypted: i=1; AJvYcCWFTPopsEHqNEBl7esZRMfdClZP1VXCwNSzkvkCpHT+6boFxnMeRFiUwhiL8RQSoDJZ7KVACGlL@vger.kernel.org
X-Gm-Message-State: AOJu0Yycceb9fj7HlhpbeUWEkA+JX60VomYs7NcYmg0A6CKNzipXkURw
	Ms2zv0TGeeW/KR4RqzJcnRxJ6XfM4ulm0AD5ZaxQwHfqQGLlSUi61827
X-Gm-Gg: ASbGncvgaPwEZsnm8GT0vETNmRnv0mdcGh5TvVhaDfJoMkucGDCCS5h4QIKhlyGblmY
	Dn0s7iqbQl3BDLouCRkgiftUT1OOo0ngLYiEGAFyzKqH9o1edTaM21lomAx1zC2JfvHvwNRFjjP
	6Eselc4FRTdqoSzBYMT60l+5AknxoDli2ClM55GOPAZDZiKkFlICuA2Ok2CEi6YDp4dYald1IcG
	tPUgHVhdt4Il0H0XCtYbYCV3ASzPt000hjtjDxr/WR8q6OsiU4IuBVXBZm4m+c+OLjNSKKgAjgN
	HEhd09bQCf8c6SsLxLrAH1OjhTufAX8ATewIu1dxZs5Z4htRh16yJEtLYmxFIHbWo4rCh9m/m8v
	1AkCTj7e91EU1To+k3qEZZNRe1kJVUnKzQx2OHExWrss2ECFE5zqs7IS2J6yEgwPkmyM3ZrFekA
	==
X-Google-Smtp-Source: AGHT+IGkCRXr3yvEzhHl7cHzC4V9C6dn0wOqTQhbbV9nWX7e2tcIH4tWVIPO6X4385s5hJyJED+qLg==
X-Received: by 2002:a17:903:187:b0:27d:6cb6:f7c2 with SMTP id d9443c01a7336-29489e050e4mr45217505ad.17.1761329060577;
        Fri, 24 Oct 2025 11:04:20 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e2579e2sm62151625ad.111.2025.10.24.11.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 11:04:20 -0700 (PDT)
Message-ID: <18bee370c4804e666eb7d5360c47439c246e1cb7.camel@gmail.com>
Subject: Re: [RFC dwarves 4/5] btf_encoder: Support encoding of inline
 location information
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, dwarves@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, 	acme@kernel.org, ttreyer@meta.com,
 yonghong.song@linux.dev, song@kernel.org, 	john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 	jolsa@kernel.org,
 qmo@kernel.org, ihor.solodrai@linux.dev, david.faust@oracle.com, 
	jose.marchesi@oracle.com, bpf@vger.kernel.org
Date: Fri, 24 Oct 2025 11:04:17 -0700
In-Reply-To: <20251024073328.370457-5-alan.maguire@oracle.com>
References: <20251024073328.370457-1-alan.maguire@oracle.com>
	 <20251024073328.370457-5-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-24 at 08:33 +0100, Alan Maguire wrote:
> This patch requires updated libbpf with APIs to add location
> information.  Iterate over inline expansions saving prototype
> and associated location info for later addition.  Location
> info can either be added to .BTF or a new .BTF.extra section
> which is split BTF relative to .BTF; this helps when size of
> location info makes adding it to .BTF prohibitive.  To support
> this we need to dedup .BTF first, then access the mappings of
> types to ensure the types of the parameters and return values
> of the functions associated with the inline sites get post-dedup
> updates.  Finally the .BTF.extra section itself is deduplicated
> allowing for FUNC_PROTO, LOC_PARAM and LOC_PROTO deduplication.
>=20
> Multiple BTF_KIND_LOCSECs are added if there are more then
> 65535 (max value vlen can support).
>=20
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---

At first it appears that encoding abstract origin of the inlined
functions and relying on dedup is a bit wasteful. But given that
abstract origin might not even exist in the main functions list,
it appears that attempts to track function states more precisely would
be more convoluted.

After sleeping on this patch, I think that having two separate
function state lists (as is done here) is indeed a simplest approach
to take.

[...]

> @@ -812,14 +864,16 @@ static int btf__add_bpf_arena_type_tags(struct btf =
*btf, struct btf_encoder_func
> =20
>  static inline bool is_kfunc_state(struct btf_encoder_func_state *state)
>  {
> -	return state && state->elf && state->elf->kfunc;
> +	if (!state || !state->elf)
> +		return false;
> +	return state->elf->kfunc;
>  }
> =20
>  static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, =
struct ftype *ftype,
>  					   struct btf_encoder_func_state *state)
>  {
> +	struct btf *btf =3D encoder->btf;

I was confused by this change, as previously btf was either a
state->encoder->btf of encoder->btf. But it turns out that
__add_func_proto() callsites guarantee that encoder =3D=3D state->encoder
when state is present.

Wdyt about a change [1], that splits __add_func_proto() in two in
order to avoid confusion regarding encoders being in sync?

[1] https://github.com/acmel/dwarves/commit/080d1f27ae71e30c269a1e26e85bb86=
c3683f195

>  	const struct btf_type *t;
> -	struct btf *btf;
>  	struct parameter *param;
>  	uint16_t nr_params, param_idx;
>  	int32_t id, type_id;

[...]
