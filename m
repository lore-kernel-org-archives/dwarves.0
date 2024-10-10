Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121A7193062
	for <dwarves@vger.kernel.org>; Thu, 10 Oct 2024 08:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728550628; cv=none; b=HoxtMZlICi6b7GdJDK/FQ03r2xOg5Cjm6CK4NQNnQXCGuRULyMadulqc07HycTlCo0+4/ONaPNgIVZ21JpYp6Y1gqvSKg6nMYgCOgae+U4vAhW05CSUdhri/e7Z910MTM6rC6uBRq98I81c08bShSPvUpMuApxecdj+yHF1OdAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728550628; c=relaxed/simple;
	bh=3WcxmyPG0qTRDFE9sH2nuH2fovqYRtFmPL1nI8tEaRA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hn0GTJiFO6Trm4b9mXXkun51xi3Tnl6n0K4fcrNiFMFGcBnNUUDxMomlakGENPKzKriSR+rsEHdmxXFP/I6LHmC1mfENqSA8tOlHf28aAu4nhX0JGqqakVQoDRu7U4BRaHOED+q4/X5jcgXHxQMChdy8gdVucb+tZQEV0i2RTl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbQIgx3k; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbQIgx3k"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71def8abc2fso562459b3a.1
        for <dwarves@vger.kernel.org>; Thu, 10 Oct 2024 01:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728550626; x=1729155426; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MnrX3WmlXEnJx7W9ITgRwHjSyQEOX+8LMRp/BBSATx0=;
        b=HbQIgx3khIsQktqSy+KxD+u3nOZoz7bR92U1xl6M6ejCH00TLh+E4BO3dgy+qyxHbF
         vkD3oDdnh1VICcrIBodSWxN0Rtf+XQ5X/TjS2IE7CkJWShY13uouz9Z0y8jJd1E+Rj7P
         W51tPBwkjfD7iICpwF8acVRP49yBmdC/vP4yQKh84GBs+djsiO5DH2oj4rwU7Ji5pCW5
         DJ75fcEE4fSK1xdionG++pcKm0soe+qY33dK96p0PogxooQcc5dCekmrloEg25kMkRC6
         TFqnCZ/b19Nr/FY88rgXWZpAm+MpMnWeAXYyh8w9p6+VUzX6zatGKuRVOxdfgmEp8syK
         MH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728550626; x=1729155426;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MnrX3WmlXEnJx7W9ITgRwHjSyQEOX+8LMRp/BBSATx0=;
        b=xLHf7pC4L+P9fY/wXS5IKtwA19aqdWckWeQWWvAsWwW+KUta6ahW9pQooUF+Okes3O
         NIb/uHTquKMvzYsD5QFapbMjDmiQEKJ4lsFl0G7ftyzhzcv9T3AbQ/MUDLRyyEpUUDd2
         0ut9mBLOtWnsKFVfec9danggYNxR7hvox9cO5pGQH5+/FBFMmdhjZo2UDh/sXPRs+rbY
         TGyzWYo9buggNkDg1GvB1rz+6+nPsj+0z11G1wmwV1XbxTXWfLDnDjP7OtTmP0nyacvk
         nr/RkwXC9QMVGhyNHzdAz25EiCS6YU/bVfoZsxNnQP0Fle5WUquPxq9dtHPYQ9I2Mf0y
         DFDw==
X-Forwarded-Encrypted: i=1; AJvYcCVgSZdFEktxj5aqc8z2nnoS63/t19TZGZDDhE8WZUDXLA4JCv9yBnk1NOXaOb+RkdiHm76Vx+ew@vger.kernel.org
X-Gm-Message-State: AOJu0YwKH3+188T8BEVouWIIFAxxfoLc4kBprsSVWMxg3Eyqhj194dZB
	ztIL43jE8ihbM4rUTngnis80+32oXaI7waA/VvOjU9iA9aZXagjd
X-Google-Smtp-Source: AGHT+IFuZdKG9M86rvp/GujFYK5m60WkITZ+nhMucfHlyaapEUvVu9xzcUZ4q6KCveJnkOwUsLaDCw==
X-Received: by 2002:a05:6a00:2e9e:b0:71d:fad0:df28 with SMTP id d2e1a72fcca58-71e1db77239mr8425361b3a.8.1728550626105;
        Thu, 10 Oct 2024 01:57:06 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2aaf25c8sm617860b3a.188.2024.10.10.01.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 01:57:05 -0700 (PDT)
Message-ID: <94c828d87e3ae213526f1b403bdff4ad6d6f6a54.camel@gmail.com>
Subject: Re: [PATCH v2 dwarves 2/5] btf_encoder: introduce elf_functions
 struct type
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>, dwarves@vger.kernel.org
Cc: acme@kernel.org, alan.maguire@oracle.com, andrii@kernel.org
Date: Thu, 10 Oct 2024 01:57:01 -0700
In-Reply-To: <20241009233520.989453-3-ihor.solodrai@pm.me>
References: <20241009233520.989453-1-ihor.solodrai@pm.me>
	 <20241009233520.989453-3-ihor.solodrai@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-09 at 23:35 +0000, Ihor Solodrai wrote:
> Extract elf_functions struct type from btf_encoder.
>=20
> Rewrite btf_encoder__collect_function() into
> elf_functions__collect_function(), and btf_encoder__collect_symbols()
> into elf_functions__collect().

Nit:

the sentence above is somewhat cryptic. I think it's better to say
something like:

Extract struct elf_functions from btf_encoder.
Replace methods operating functions table in btf_encoder by methods
operating on elf_functions:
- btf_encoder__collect_function -> elf_functions__collect_function;
- btf_encoder__collect_symbols  -> elf_functions__collect.

>=20
> Now these functions do not depend on btf_encoder being passed to them
> as a parameter.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
> ---

Modulo a few nitpicks this patch looks ok to me.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> @@ -2100,22 +2075,38 @@ int btf_encoder__encode(struct btf_encoder *encod=
er)
>  }
> =20
> =20
> -static int btf_encoder__collect_symbols(struct btf_encoder *encoder)
> +static int elf_functions__collect(struct elf_functions *functions)
>  {
> -	uint32_t sym_sec_idx;
> +	uint32_t nr_symbols =3D elf_symtab__nr_symbols(functions->symtab);
> +	Elf32_Word sym_sec_idx;
>  	uint32_t core_id;
>  	GElf_Sym sym;
> =20
> -	elf_symtab__for_each_symbol_index(encoder->symtab, core_id, sym, sym_se=
c_idx) {
> -		if (btf_encoder__collect_function(encoder, &sym))
> +	// We know that number of functions is less than number of symbols,
> +	// so we can overallocate temporarily.
> +	functions->entries =3D calloc(nr_symbols, sizeof(struct elf_function));
> +	if (!functions->entries) {
> +		fprintf(stderr, "could not allocate memory for elf_functions table\n")=
;
> +		return -ENOMEM;
> +	}
> +
> +	functions->cnt =3D 0;
> +	elf_symtab__for_each_symbol_index(functions->symtab, core_id, sym, sym_=
sec_idx) {;
> +		if (elf_functions__collect_function(functions, &sym))
>  			return -1;
>  	}
> =20
> -	if (encoder->functions.cnt) {
> -		qsort(encoder->functions.entries, encoder->functions.cnt, sizeof(encod=
er->functions.entries[0]),
> +	if (functions->cnt)
> +		qsort(functions->entries,
> +		      functions->cnt,
> +		      sizeof(functions->entries[0]),
>  		      functions_cmp);
> -		if (encoder->verbose)
> -			printf("Found %d functions!\n", encoder->functions.cnt);
> +
> +	// Reallocate to the exact size
> +	functions->entries =3D realloc(functions->entries, functions->cnt * siz=
eof(struct elf_function));

You need to store realloc result to a temporary, otherwise pointer to
previously allocated memory in functions->entries is lost.
(Although idk if such realloc could fail).

> +	if (!functions->entries) {
> +		fprintf(stderr, "could not reallocate memory for elf_functions table\n=
");
> +		return -ENOMEM;
>  	}
> =20
>  	return 0;

[...]

