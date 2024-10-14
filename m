Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40A122318
	for <dwarves@vger.kernel.org>; Mon, 14 Oct 2024 23:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728948735; cv=none; b=ebAUuFTPJtFZSE0POlF5VuIW+Yi1N8cM29m3obTOgETypyr7/mjN0ALV3EkD/EJZqU7jlILf8v9mUKNu8JV9wze0c256tl/whq8L9qreKdsJJqIPZu4rZp6EwZdORZLRfS9X9I9IQbyYJE4k15hzNWq1ZAGzbHjg6IdduPxTccg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728948735; c=relaxed/simple;
	bh=/dz/aDtP/Mwj5q2SUfN75yeKy3/Va7vZ7nC4rtbBFg4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QysGQhNssJf8EoAWiIifI8ISoJtKNoitI4baRcL0ug+L7y6xUKReI9rlkBrUQBwPjcyWOHAoOm+A7IqfQLeuYzTC6lx5sAIe0kb5ISeY7wbXiBfA26o9aJHYcTw0LecigLknoF+4NtrevMS50ieMeB0auWtNlzo8CCwYVRxR/o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJzNtNOu; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJzNtNOu"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20c8b557f91so37179055ad.2
        for <dwarves@vger.kernel.org>; Mon, 14 Oct 2024 16:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728948733; x=1729553533; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pwbSPpo2A8k0B91c4XNHi44lm1Du1iObCNlm8Nw8Sno=;
        b=SJzNtNOuQyYsQUbpDXkfLbyN+mnAaRiiX5eRjA5KhngXCh1YIB5PM72gl6l/m9XXFX
         GRbS7B4ESkunql6iki4Hf1H7+v2pamTbyEJk2ZrslqKvLu0llbvnFh7vLMqNtMvARcy+
         ZUpIW9u2/i7KYKJxnGnfxWFirEcL8aIJ/6J1BF/Q63JCq2uupjD3VsKT6V1N1i1rR9yk
         ngKMiyGzRtG3ddsJyYyqrQS3JE8hZ4VwPNoPSMEr+dyfSAPs7RkLmvlsWkdjpHP2julD
         y0dHAXjhpZ2xmmY4uENq3ZTFjUe3QmIh8kGP+ulRm5zYUAcLprw26PLuSxdSxsCMjcoT
         2DKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728948733; x=1729553533;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pwbSPpo2A8k0B91c4XNHi44lm1Du1iObCNlm8Nw8Sno=;
        b=QtZwuGqJex03+lU0Cva8HDyWaOCudUPU6KU74/m7ygn2aPVX2cx5MWDPTbNNs6V86V
         0wx3BkfW3OU5WhMlLGlzETZVy9uLgVIN5hDhsjn9xqWq0sHu5j7oiLeFkKA0HQ5DREBj
         kWINeb2SQjVlg/gH3DwgfPRmeZkLbl7+Cu8Z1jHwWHN9vyhh8nyt1Gh8Bm9eUE6Yj97m
         c80Onbc3hqvwdL29tZbTChyTaJKLfzaA35x01DtrdJaemBiZN41ERzrGInbGJ/CeXE+z
         nJX5+HyDx/OABsP6DsjvpcpktjC4GvItZ71pSpDtu12NWkP1JqocBJDE3lDpM+c+lzoP
         OKtA==
X-Gm-Message-State: AOJu0YyNAvVv14yxiK1fjMc+wovm39FmtlfZaceRvU9vGu2W7e1qzw/8
	gV4nENfOEWB6fhKIVWFzNyc+fbTs5MgfQfjgViKcy0WH6aQNr/vGAczxCw==
X-Google-Smtp-Source: AGHT+IEFTycUIu5yJUIOFi4ourLYV3Vm4iKqz1qlG9m+dWuOaIIL787gb8YHmQABnyOq0gcDyZ7UBQ==
X-Received: by 2002:a17:902:d552:b0:20b:38fe:60d7 with SMTP id d9443c01a7336-20ca1465d34mr223599325ad.22.1728948733205;
        Mon, 14 Oct 2024 16:32:13 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d18036293sm765855ad.179.2024.10.14.16.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 16:32:12 -0700 (PDT)
Message-ID: <f5b660f7fc027e83957a0cba47f2038d46b37881.camel@gmail.com>
Subject: Re: [PATCH v2 dwarves 3/5] btf_encoder: collect elf_functions in
 pre_cus__load_module
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, acme@kernel.org, alan.maguire@oracle.com, 
	andrii@kernel.org
Date: Mon, 14 Oct 2024 16:32:08 -0700
In-Reply-To: <5BZh41mSYjQZMCaMwVmgId6qPAAI1LpidzKcJYqw5Pkj94jYwwuW5jGoZDwxmPkDHE6PXE_pAumBHmjmTqGuK4MEL3xTU_xAcw5xa9vCIlQ=@pm.me>
References: <20241009233520.989453-1-ihor.solodrai@pm.me>
	 <20241009233520.989453-4-ihor.solodrai@pm.me>
	 <268884d44497f30e561609ff982cfa87c1c24bb6.camel@gmail.com>
	 <wh8Ne88FhIBrRfmV5_-tXL_BILUEFXXb6WONJvvucTJOwM56meP3VgKHyiE9qg-DIRQuR3lcmOmwGT53Xa9qBqwBkbDavDf_yCkOmJ5yXiA=@pm.me>
	 <7d6631c07df523103ae3a89ebeedf296074d6967.camel@gmail.com>
	 <hrfEwQ1OldXwSegRIZ9XpD6t7pJZJ6sMz7duwiE0dbi_lFlnjEphjTsjxJiakceGnR2_dNfhUp2oJrS2uShN9qHK2tf-32cFVWQS1r-eDds=@pm.me>
	 <19a0e258889f09feb27f6bff6965edee83c2fa16.camel@gmail.com>
	 <5BZh41mSYjQZMCaMwVmgId6qPAAI1LpidzKcJYqw5Pkj94jYwwuW5jGoZDwxmPkDHE6PXE_pAumBHmjmTqGuK4MEL3xTU_xAcw5xa9vCIlQ=@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-10-14 at 23:08 +0000, Ihor Solodrai wrote:

[...]

> +static inline void elf_functions__delete_all()
> +{
> +	struct list_head *pos, *tmp;
> +
> +	list_for_each_safe(pos, tmp, &elf_functions_list) {
> +		struct elf_functions *funcs =3D list_entry(pos, struct elf_functions, =
node);
> +		elf_functions__delete(funcs);
> +	}
> +}
> +
>  static int elf_functions__collect(struct elf_functions *functions);
> =20
>  int btf_encoder__pre_load_module(Dwfl_Module *mod, Elf *elf)
> @@ -2136,8 +2146,7 @@ int btf_encoder__encode(struct btf_encoder *encoder=
)
>  		err =3D btf_encoder__write_elf(encoder, encoder->btf, BTF_ELF_SEC);
>  	}
> =20
> -	elf_functions__delete(elf_functions__get(encoder->functions.elf));
> +	elf_functions__delete_all();
>=20
>         return err;
>  }

Right, this should work.

> Can't think of a better place to call elf_functions__delete_all(). On
> this patch, btf_encoder__add_saved_funcs() is still called at the
> entry into btf_encoder__encode().

This is a bit ugly, tbh, as it makes the lifespan of this global data
not really obvious. I'd put a call to elf_functions__delete_all()
somewhere at the 'out' label of the pahole.c:main(), but I do not insist.

[...]

