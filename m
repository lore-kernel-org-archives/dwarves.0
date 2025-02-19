Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C11261371;
	Wed, 19 Feb 2025 23:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740009127; cv=none; b=EMOxIPFWUvjfCOgbFAQWTEk8UufpHPWUQVG94QgbIEKhzDhcsvq6qSqqfzeFrXFZ+iHn/iT1yivF4d9Tfw6h5dEZ+lVdS+fqVsxEuv322xUdMeRT143KlnAuPTAEjHQSoRhozqSKT9qqZRrJkinDLC34/MssKmbBqzGY8IbJFeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740009127; c=relaxed/simple;
	bh=3WrERtGIJP7HuqDE7m/PhvhsILGXTiVnsd7meHy6oqY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kIguw99bIS0EbfW6AlX/NsXrFh3GTfuqOP6jYwgTPkSr1D3gEtHp1xPTFljKIFE9y1ojwaQiLcTl8L1YjjpZags+S3C/x0vrv0fddwiJG5sLRtzHedUaWbiSRpld/5wBkuNd7F6cPMebPoCC9Iyf9fly8+rrz+FXkhYBiNBuRzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHdb2M8N; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHdb2M8N"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220c8cf98bbso6265975ad.1;
        Wed, 19 Feb 2025 15:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740009125; x=1740613925; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bd4fqW0Y9aovkQIqemtB+wexTdz5vJayZK3C44sxP34=;
        b=CHdb2M8NsWpQvi3p9KAl7R/LpiKoLUIlkuPSbc+AZ184KpfWuTsaCj48CQIaEtmPd1
         qnse7wN8le3akgPRg8/YubKYd374pt3AF+wTS81QcpaoDlyleXv7q6woQ0PDQyQakdFi
         VCuYl5Z05N0oGCcmkaXI3z6XVPKl7qtXiDXV92kf0fi8ja31bX05gNltzc40vSBR0wgP
         uoPBgUpKXxQdMP7wbHE6C4YP7IW2cV5mqwqQbYe7JosATQAl/5kq2XFBmZPAnHaC5yYL
         gOno8ayA6r7953Yc50wbPVDJvZfZK3LDr5HeGZ6qqgzbo9gce7LYukQVqxIzM9meMR7B
         TqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740009125; x=1740613925;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bd4fqW0Y9aovkQIqemtB+wexTdz5vJayZK3C44sxP34=;
        b=CjJZ5+pZipG5WwefUyK2U2vlTUllo4q+UzffXN0Gpv/NzbIfxgKM7hESN5PO8TPQo8
         puLO1nN0qVRnF4UZOdnOe5uyYvOz4Qr1VJG97hO1xVCS1FXPF1W3X3/xh5oNrNHpAgdX
         dVrDKjagL0AkszOT3Oz5sRp15Kh7wEy+A4w+vUG0eDHTO6kkX/xhgM0YxtLdPSSWmUOv
         xf2Al0AU0oASRHl9dmosdsv3AFN7Zi+s/A5ZcNlLK6NMoGaiiPy4EkAYQsTS6i5h/MYb
         ozEQsESg7sjdTXbRdlXUH0J2kn3fjNJRVc4MCjjMhRvrAGm+lx4y1/PEQplfc3IUKBn4
         NQMg==
X-Forwarded-Encrypted: i=1; AJvYcCUd31RUfUQp/K5fzdrmgXKzn77bchkHnGZuJufoABoysnIsKu+AEjYuGCTbJQdWfj2DaFmiZE8geKKdVjYEOQ5d@vger.kernel.org, AJvYcCVLtGNkFrMRZXLsOMf8Qv/xxz56iwvjIZK9PhVUnRfD7DLoJ406ReoAfuh502bff2Toz3Cd4eH9@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh4B5Gw4TkEc6u6wGJN1/OovUPhLFLYEzhqGU50JAdXp7iFRak
	ChFai6sQfRfQUOjnMv2nFgcgSyHLy/uH8YdFkxZeVjaA8usPe5Zd
X-Gm-Gg: ASbGncujivdICiDc5bGUWXl+OSF5LViRE9ViyJ8BEB/P0ZSwKL90SyfYG7i6n2/vdR/
	0g/cH6VY5I80L0Jx1sWn2Q+h/mCI07azItzgAfV/IDbkXqaB4k5C9JwP0BXmhx0G08ZcU2vFcYv
	319ik+9wBVeM3zdxdANr2xECpRwvjYIfCw0SvCATg1qTDJNBI8C1M7bytJuXGlEo9f/SrUYFaBC
	u7V7BbeyTlHJV3KYiYymJij4xo5Z1U0L1StZbz9KJm6aOXDwVpCtkVfKS1fk0sLkTsIjhydLJuh
	V0ChF23WBYrQ
X-Google-Smtp-Source: AGHT+IH0saCaS9DVJKGT8tidZgwKNQpiLkd1EK6or+7/HnzZe0EgZ8/ARDvqEz5/L5L4JwmCxHkCkw==
X-Received: by 2002:a05:6a21:6d9c:b0:1ee:d6ff:5abd with SMTP id adf61e73a8af0-1eed6ff5f5emr6576503637.14.1740009124867;
        Wed, 19 Feb 2025 15:52:04 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242544c8asm12491668b3a.28.2025.02.19.15.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 15:52:04 -0800 (PST)
Message-ID: <1386be66981c3ff2b6c4e177433056ceae40a181.camel@gmail.com>
Subject: Re: [PATCH 2/3] btf_encoder: postpone VARs until encoding DATASEC
From: Eduard Zingerman <eddyz87@gmail.com>
To: Stephen Brennan <stephen.s.brennan@oracle.com>, Arnaldo Carvalho de Melo
	 <acme@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>, dwarves@vger.kernel.org, 
	linux-debuggers@vger.kernel.org
Date: Wed, 19 Feb 2025 15:51:59 -0800
In-Reply-To: <20250212005003.1413091-3-stephen.s.brennan@oracle.com>
References: <20250212005003.1413091-1-stephen.s.brennan@oracle.com>
	 <20250212005003.1413091-3-stephen.s.brennan@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-02-11 at 16:49 -0800, Stephen Brennan wrote:
> In order to handle duplicate variables in a data section, we'll need to
> compare variables against the others in their data section. To do this,
> we'll need to postpone adding the variables until they have all been
> identified and collected.  Store all the necessary data to encode the
> VARs (and their DECL_TAGs) and then encode them just before the DATASEC
> containing them. No meaningful change in the output is intended, though
> the ordering of type IDs generated will likely differ.
>=20
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> ---

I think this patch looks good,
but annotation index handling needs a small a fix,
see below.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> @@ -109,6 +109,20 @@ struct elf_functions {
>  	int suffix_cnt; /* number of .isra, .part etc */
>  };
> =20
> +struct saved_annot {
> +	const char *value;
> +	int component_idx;
> +};
> +
> +struct saved_var {
> +	const char *name;
> +	uint32_t type;

Nit: maybe name this 'id' or 'var_id'?

> +	struct saved_annot *annots;
> +	uint32_t linkage;
> +	uint32_t offset;
> +	uint32_t size;
> +};
> +

[...]

> @@ -2359,30 +2428,34 @@ static int btf_encoder__encode_cu_variables(struc=
t btf_encoder *encoder)
>  			       name, cu->name, addr);
>  		}
> =20
> -		/* add a BTF_KIND_VAR in encoder->types */
> -		id =3D btf_encoder__add_var(encoder, type, name, linkage);
> -		if (id < 0) {
> -			fprintf(stderr, "error: failed to encode variable '%s' at addr 0x%" P=
RIx64 "\n",
> -			        name, addr);
> -			goto out;
> +		/* Save the annotations */
> +		annot_count =3D 0;
> +		annots =3D NULL;
> +		list_for_each_entry(annot, &var->annots, node) {
> +			annot_count +=3D 1;
>  		}
> +		if (annot_count) {
> +			int idx =3D 0;
> =20
> -		list_for_each_entry(annot, &var->annots, node) {
> -			int tag_type_id =3D btf_encoder__add_decl_tag(encoder, annot->value, =
id, annot->component_idx);
> -			if (tag_type_id < 0) {
> -				fprintf(stderr, "error: failed to encode tag '%s' to variable '%s' w=
ith component_idx %d\n",
> -					annot->value, name, annot->component_idx);
> +			annots =3D calloc(annot_count + 1, sizeof(*annots));
> +			if (!annots) {
> +				fprintf(stderr, "error: allocation failure\n");
> +				err =3D -ENOMEM;
>  				goto out;
>  			}
> +			list_for_each_entry(annot, &var->annots, node) {
> +				annots[idx].value =3D annot->value;
> +				annots[idx].component_idx =3D annot->component_idx;
> +			}

I think 'idx++' is missing here.

>  		}
> =20
>  		/*
> -		 * Add the variable to the secinfo for the section it appears in.
> -		 * Later we will generate a BTF_VAR_DATASEC for all any section with
> -		 * an encoded variable.
> +		 * Store all the collected information for the variable. Later,
> +		 * we will deduplicate and output all.
>  		 */
> -		id =3D btf_encoder__add_var_secinfo(encoder, shndx, id, (uint32_t)addr=
, (uint32_t)size);
> -		if (id < 0) {
> +		err =3D btf_encoder__store_var(encoder, shndx, name, type, linkage,
> +					    (uint32_t)addr, (uint32_t)size, annots);
> +		if (err < 0) {
>  			fprintf(stderr, "error: failed to encode section info for variable '%=
s' at addr 0x%" PRIx64 "\n",
>  				name, addr);

Free 'annots' in case of an error?

>  			goto out;

[...]

