Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB1C1BC9F6
	for <dwarves@vger.kernel.org>; Thu, 10 Oct 2024 08:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728550640; cv=none; b=Ap8XIOewK6X7A4xPczU2b/v3SYKTzCFlvxiybnEAFM3Iz953Irf+FGUf13QCREhn/kTWM2BWzi8cLZo6AmbpcgTPZDATB1/HBd3Lj9AMyH6PBZhMtwFi+zo1ER2XdyO+xuTuSHT0ygaOZWNrAIKPsyagPEbI/ImpR9uVZGFKN8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728550640; c=relaxed/simple;
	bh=LvGbM4ZJc/AQ3lmA4OvmtNnzfNJq0ZPPhnHXAbgDqxA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mYy6OoCuyfVa2iWHQfSm+2s7PmJ32AYXIT1AY6SRvmYrfUSuAIiUGVd9WogxMHMWi9jj3ltWBiunWtJrXQVzZx4xfR1ilOSriIdVD9QvdXHxd3h8ZMR44L79UWJ8pQtLvS7ppra9aAKIwFAaUvobSM59cIGpAdx7r0QUCVksb0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcY1wbC5; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcY1wbC5"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71e02249621so557224b3a.1
        for <dwarves@vger.kernel.org>; Thu, 10 Oct 2024 01:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728550638; x=1729155438; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rVxaNZh88PVxItfdVRVBGOnwBZPub/uCLmTp9jNxuH4=;
        b=TcY1wbC5dEha+Ejd3VvL7dzDwDNUTeWjGLvigIsEdg6bBWzsLWuu88wBflqf9KEOrh
         Ol8Uy1apGrq1X8QUh6voYRMbSaHEqtceu3Df0unoOvFQ6M9C/Tl1rYpIePlQacjLOHNP
         JXa1Kd2pHazlfmUX3KeiVigjFxvfRxqAtMCYWUbhfXXUNhDADN1Y8gbLH6FU5Flnjbqn
         hzQEgFVNSxnpg3ALAsOzZlu3Gjyh/OuBaVZA/BwoQLoM/N5H30VmxUl75mss61KjcH8S
         ur/LTaHQ+aYmkNpt7z3kSxKdx7y5GyCKiEI77HcYj62Tt/f3Ae26A3kOUIywO0n+fjvr
         t8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728550638; x=1729155438;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rVxaNZh88PVxItfdVRVBGOnwBZPub/uCLmTp9jNxuH4=;
        b=RqBZ9rSJzFFeuj3ck9GyCdeXlS+YKkmV3Spjxext2pK19/y/tejT6IYJwzK3yZy4Gi
         jCB6omy/iGi+tOZ8HBTBC36cyFvuF4HpOkUvNlxBpwVcl4AYsIH6+t70Y2e3mt6bRH64
         V0QIc6UZVRE0f0FOrl4JzsaPzMTwR3AKslKoGdKUCIIYWP39UzX3DnuHEv1/eH8E7g1L
         Xie+47rHQlCQ7SICtRbsozAcPhW0NE1wZvppgX/qtaIFSykYhBUDIxBWXVncDErfQrie
         rx+KxQeg6sUQjBds7HWWUImGjFu6cWvLd1k7gKGZXrKwsjU1iVscJm2tpJn0nt6yOHrG
         n/XQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6VeHfG1AMwoYTnatrXL7aVwDg3ZLnoetDH1UoRuDO3+r9N6LyGgHspG/BlkltqUGsAUeWH/1c@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc6mVtNhByvEpNp2jzeOlXO6C7DbIZDvsszrEnu3jt8RciADW4
	ad9ulq0E/x4umr+L+1kA47Eeq6LieTCjFGBnN/12gX5i66i5vBoK
X-Google-Smtp-Source: AGHT+IEHfygV2lO5FFEuiFJu858xPrvvo7M3di5X03IwY+MN5I2TAo/qg23AAFxV4BhvkVmDXmtDMw==
X-Received: by 2002:a05:6a20:2d0e:b0:1c4:9ef6:499b with SMTP id adf61e73a8af0-1d8a3c1e4a1mr9863967637.29.1728550638003;
        Thu, 10 Oct 2024 01:57:18 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2aaba17dsm616572b3a.155.2024.10.10.01.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 01:57:17 -0700 (PDT)
Message-ID: <268884d44497f30e561609ff982cfa87c1c24bb6.camel@gmail.com>
Subject: Re: [PATCH v2 dwarves 3/5] btf_encoder: collect elf_functions in
 pre_cus__load_module
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>, dwarves@vger.kernel.org
Cc: acme@kernel.org, alan.maguire@oracle.com, andrii@kernel.org
Date: Thu, 10 Oct 2024 01:57:13 -0700
In-Reply-To: <20241009233520.989453-4-ihor.solodrai@pm.me>
References: <20241009233520.989453-1-ihor.solodrai@pm.me>
	 <20241009233520.989453-4-ihor.solodrai@pm.me>
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

[...]

> diff --git a/btf_encoder.c b/btf_encoder.c

[...]

> +static struct elf_functions *elf_functions__new(Elf *elf)
> +{

I think this function should be renamed to elf_functions_list_init()
and it should return int.

[...]

> @@ -2071,6 +2139,13 @@ int btf_encoder__encode(struct btf_encoder *encode=
r)
>  #endif
>  		err =3D btf_encoder__write_elf(encoder, encoder->btf, BTF_ELF_SEC);
>  	}
> +
> +	// TODO: after moving encoders to shared elf_functions,
> +	// replace elf_functions__get(encoder->functions.elf) here
> +	// with encoder->functions
> +	// The pointer to shared elf_functions will be set in btf_encoder__new

Nit: the TODO comment is not necessary here, as described change is
     done later in the patch.

> +	elf_functions__delete(elf_functions__get(encoder->functions.elf));
> +
>  	return err;
>  }
> =20
> @@ -2369,6 +2444,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu,=
 const char *detached_filenam
>  			goto out;
>  		}
>  		encoder->functions.symtab =3D encoder->symtab;
> +		encoder->functions.elf =3D cu->elf;

This line is removed in a subsequent patches, is it needed because of
the __delete call in the hunk above? Note, that if you want to account
for situation when multiple ELFs are processed the cu->elf might
change, so that __delete call would only delete elf_functions for the
last processed cu->elf.

I think that elf_functions should be deleted in main() at the same
level where btf_encoder__add_saved_funcs() is called.

> =20
>  		/* index the ELF sections for later lookup */
> =20

[...]

