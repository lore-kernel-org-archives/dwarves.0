Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521A32AF1D
	for <dwarves@vger.kernel.org>; Wed,  9 Oct 2024 23:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728517411; cv=none; b=bct9tvt7efLlg4esOFVVHOKyfepmz0xArgz4XkWD/6b+l8Ncy+3rriTUTLiu/5LxpJER3mXF6cdsfw81i8T8PXbqM55i6xJBhgH4NGvMWjNoWBaY69zTPQ7yog/mSC90afoC3wiXKV3cGJIupY3upw0qzcJ7WvXdjBInDNNnjZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728517411; c=relaxed/simple;
	bh=3e+VpLGC6IKgbzcERGG49uqVdF/HxsvaKkDQmJhoaLo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=glgHJ6HhzTM8GJ0NU1UGusw9VrrQIht5AxwDtJJTljypxeRNAww8qr0M6mRe5RQ762uJ0eqmbGSiyN+7ayQu98CFj+DUc2WUQKbPe4hlS0kniKnwzZIHRbsEZJDCMaetlHQ92k3F8OSW4DEP2FDcyN/WH2yRpFg6tTY+yMf78Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9Y6W3nV; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9Y6W3nV"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20c714cd9c8so2212615ad.0
        for <dwarves@vger.kernel.org>; Wed, 09 Oct 2024 16:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728517409; x=1729122209; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RY6USLZ1cfhEKmm9Azhr6NQAxQiU+k0fwPUH7efSNRk=;
        b=D9Y6W3nVhYKTvDZQIiPKelIAKfUWHVb3SrYlyLuHNmp64iO3i9zHyc1FYJgtEj5qsF
         Uqx7e4IR9Wdht++ey+4XNCfBhJh3p0htnAJAwTOY12jOsRWqAEHhuTdZLKsOMczfWlfj
         uYtqxnrR3/2c1+0Fx69zuXX8uZoJ3OmU6XaxqUcpmkAnS4TC2PHhKxirFhpxGw4crEN2
         hghQfu9T/YRNfmOge2SwnP1/Ewozmg6Qv07YiCw5LWbG5JKx2SDW1k7TBgs5fERBlVkk
         AB6HYw54/OAgYbe3nvx5K2Uo2vxtchVHYZSMJW1rBbac5KYgUa8s3dWdeXwQzNA5vQbw
         RgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728517409; x=1729122209;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RY6USLZ1cfhEKmm9Azhr6NQAxQiU+k0fwPUH7efSNRk=;
        b=rWfAC9NoXvdvTZQ0DMJZw7ZKB5jxGy7k6n5IQOvcDszd0Kw8MHz+fHU3jHbP2Yiube
         z8BlZxsFcf6SFIli3iDvNd0pHpGgsGEQXokCpdfh9BG1yJ2+TxeqBsilDS3aXAEifX5W
         MUmRVSHgeFdsEUQ7dyKpeykx5gPOHl7FmnbNOKHNY2CfrYymGZ51Q8o1ThM/hzjFc7ZF
         Jd0hnnQkN72E4tpbuuKKHOz7w/W5+qgmrkPajbzm9x96ibjes99xmNsPJvOEycMufBoU
         Y1ewBVRcodamgGIDV0PSU6aH3Y2PkNcjiTuzXhwqFKiNdrT875zh4CPtCuvIhnG16axw
         GyWg==
X-Forwarded-Encrypted: i=1; AJvYcCUm1UhkePBa/ljo8UitatmWCnw5vPPXD2EvkEDAinfkDJzBJOpv7bfkM7GevrqOW0Hrj60P3IUA@vger.kernel.org
X-Gm-Message-State: AOJu0YxbiCyervppWfn9xR4b3EM284mrE0VpNchV3Gwri1A56MlDTCXn
	iTaTrh2Gr28YT+aCd1kkFqTedcMStlRJ2Gakhy6iCLJSl91bJ+6EqCkrIw==
X-Google-Smtp-Source: AGHT+IHx3TssTUkjoUs+a92ZVLDMNp/9sMp2gX4336O+UAyxl4ie42N6v1eD/SMh8XYnwoU8jXSztA==
X-Received: by 2002:a17:903:230c:b0:20c:5909:cc30 with SMTP id d9443c01a7336-20c636eb1c0mr65870045ad.10.1728517409590;
        Wed, 09 Oct 2024 16:43:29 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c62af2f7bsm17808865ad.61.2024.10.09.16.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 16:43:29 -0700 (PDT)
Message-ID: <60b79369e829b33c577fe285b6597894e72b7042.camel@gmail.com>
Subject: Re: [PATCH v2 dwarves 0/5] btf_encoder: implement shared
 elf_functions table
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>, dwarves@vger.kernel.org
Cc: acme@kernel.org, alan.maguire@oracle.com, andrii@kernel.org
Date: Wed, 09 Oct 2024 16:43:24 -0700
In-Reply-To: <20241009233520.989453-1-ihor.solodrai@pm.me>
References: <20241009233520.989453-1-ihor.solodrai@pm.me>
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
> This version of the patchset rebases the changes on top of next
> (a1241b0).
>=20
> In comparison to v1, elf_functions_entry struct and related code is
> removed.
>=20
> Originally (even before I submitted v1) I used gobuffer to store a
> collection of elf_function-s. But that used too much memory, because
> gobuffer allocates big chunks, and these lists mostly contain just a
> few elements.  This prompted me to switch to a list in v1.
>=20
> While rebasing I realized that we may avoid maintaining a mutex for
> each elf_functions_entry if list updates are made atomically. With
> that change it became obvious that elf_functions_entry abstraction is
> unnecessary, so I removed it.
>=20
> Also I removed reallocarray_grow logic, which was used for
> elf_functions->entries. I noticed that the number of functions (at
> least in vmlinux) is almost as big as the number of ELF symbols, and
> we can use this to pre-allocate the entire table and then adjust after
> function collection is complete.
>=20
> A patch splitting btf_encoder__collect_symbols became unnecessary and
> is removed.

Do you have the performance / memory usage stats for next vs this patch-set=
?

[...]
