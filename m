Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBFD1BC077
	for <dwarves@vger.kernel.org>; Thu, 10 Oct 2024 08:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728550607; cv=none; b=BiiRD7Y0Aa6kEMsS5Bp4OjBBIt99FWVxWepwuN3gQ1OQSDx62JeKQzAB3RmaInqjy46geQuWmjUEmXb4a2sXI1dvpuMKEZqwZ3ooehpbeRL1iks4DvXnXfIbnFTqG11XNPw9AXSGSZuh46iC1UUMJNWvxm7ZOfXSV/6/zIKG3wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728550607; c=relaxed/simple;
	bh=sOayZrvHTaGR7mH9Bhy0/dbyNToBzzUUWLkISD4DJQg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aCKtdt7wvYoLIDKhNTF++uPzZBvVfzN7bI8GuMqjdxqUSjjcLbvrn6GiBOo/8ufSRCoVCKbM3Kb/j1DsXApLloKysBQOH2yNYWgwUTOcWA5GBZe7wDjotwjFg74D/IfW1B8GhHJtMQJ3BtzL3pXS5Cm2doLlSYU/Am2W7B3IPDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2Kmh7U6; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2Kmh7U6"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20c805a0753so5454365ad.0
        for <dwarves@vger.kernel.org>; Thu, 10 Oct 2024 01:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728550606; x=1729155406; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iJzizbhEb2y3je/jucPGRD63zrZr862B1ISrQ/WF4tA=;
        b=D2Kmh7U69uJHxXHa6tMPx7YKRegIE+smcTH7w8TIIvwRHKzoNLXiM9dLX73hqM19CF
         KSe+1PvCeIbaI72nhQIlW69LR3AIYhUazCWXk6CFfv1O43X4JR46dYasY0GTRCYyZ7mZ
         KIKeR4am/si263xWwq/RVdlXZNeKctLU4L+j46hPtEkQZE+IZOlaPiXFdvQClIul8zkj
         x0a4b+E4rzI733XynssKa/rYcTbVouPYCcpwfsS4rbkQP5TdIYHdN3fEwRezebP8akV3
         djtogxzScnUvY2maFCGTK/WZclTSpOEjsKt1elatj22zXyTLZnlEnjNQ+g595dhwbLiN
         hL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728550606; x=1729155406;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iJzizbhEb2y3je/jucPGRD63zrZr862B1ISrQ/WF4tA=;
        b=QXOboj6VDbgyX/WXdNI7Ojph6DmS4x+yxnOLp8nQAdjy7PigFYA9bWtUAUeZoLwqam
         A4J/xA990l0+Zla0vG8BP0VvKQFL4TyzHHucIImzRJXjza0YIEqN8Pqy5hfMi9iWMdV2
         kA6U2NXVfhLcJUR1yjGogkPQ9gHVwwgdZCf055g0swiYIfw68jdwomNWzduG3wHYnaVl
         pWWrTmcKGCUbVERXgqwOWjTddSTNrChk9pVDm+ccUFFCpREhifpHRJEo3b/Bfr2cvzju
         3RXNh4pY1xEPILwazD6cVNVca6fusvRBlDX4dPLZogOKLUZtj4M0+LXtTs4TN8FnwBPX
         KxAA==
X-Forwarded-Encrypted: i=1; AJvYcCWYKy3J38v/lNZ60xazo+fdl+4IROM7Zr/rBoW/gdnrTWokZTki7kIXLx0K72KrwD89TLq0iKcv@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq5zd8UEulsFV6yPy+Kqivptova96tmV3ULcgjO5qU29qePsOY
	YO5fVtB6nayn+yYLYdXaH7bs45SRuoR4K2zh7tDEszgbS0jtwnAYg8RCcQ==
X-Google-Smtp-Source: AGHT+IENADgkBJNtN/FrZPJotVmddSBFIrxS9KZ3Ju6QxjOtrdUGUmQEX8T27SY5+7ggCoe2ZfVc4g==
X-Received: by 2002:a17:902:d511:b0:20b:4f95:9339 with SMTP id d9443c01a7336-20c6395b0dfmr72719785ad.60.1728550605761;
        Thu, 10 Oct 2024 01:56:45 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c216156sm5832195ad.193.2024.10.10.01.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 01:56:45 -0700 (PDT)
Message-ID: <cb5084defae910442d1dc959d8c642b82ee76744.camel@gmail.com>
Subject: Re: [PATCH v2 dwarves 1/5] dwarf_loader: introduce pre/post
 cus__load_module hooks to conf_load
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>, dwarves@vger.kernel.org
Cc: acme@kernel.org, alan.maguire@oracle.com, andrii@kernel.org
Date: Thu, 10 Oct 2024 01:56:40 -0700
In-Reply-To: <20241009233520.989453-2-ihor.solodrai@pm.me>
References: <20241009233520.989453-1-ihor.solodrai@pm.me>
	 <20241009233520.989453-2-ihor.solodrai@pm.me>
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

> @@ -106,6 +114,14 @@ struct conf_load {
>  	struct conf_fprintf	*conf_fprintf;
>  	int			(*threads_prepare)(struct conf_load *conf, int nr_threads, void *=
*thr_data);
>  	int			(*threads_collect)(struct conf_load *conf, int nr_threads, void *=
*thr_data, int error);
> +	int			(*pre_cus__load_module)(struct process_dwflmod_parms *parms,
> +							Dwfl_Module *mod,
> +							Dwarf *dw,
> +							Elf *elf);
> +	int			(*post_cus__load_module)(struct process_dwflmod_parms *parms,
> +							 Dwfl_Module *mod,
> +							 Dwarf *dw,
> +							 Elf *elf);
>  };

I'd name these `module_pre_load` and `module_post_load`.
The `post_cus__load_module` does not seem to be used in this
patch-set, so I'd exclude it for now.

I'd also keep the number of parameters to the minimum,
this patch-set defines only btf_encoder__pre_cus__load_module and it
only uses `elf` parameter. But since the hook goal is to operate on
modules I'd pass only Dwfl_Module and use dwfl_module_getelf to get
a link to Elf instance.

> =20
>  /** struct conf_fprintf - hints to the __fprintf routines

[...]

