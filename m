Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854C327453
	for <dwarves@vger.kernel.org>; Wed,  5 Nov 2025 01:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762307120; cv=none; b=hO402PF0H2fXD/mn3ZY/1Iw2XplsqlVXZUNg9/utM/iBCf0iKMW0i0F4CJKXhJZil5+IOwiXV4mblSbtDJnryHsv0peN3OA+/zugGaHM6qvFYwrbVK/m3Ds3GocWYG1tZXeRTKz2f6B4vBQA9z5bNAKasVWFOJCDgosQtTTjWrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762307120; c=relaxed/simple;
	bh=+fMeu6S6+hdh2AO7AJ7kBbTO3lR3XOXXCyxIrAl2zvo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dl+fKcf4/jvC/zF4CGBNYUFdYMkIpOQj170Bj6tuDLdUqXMAKQPgbp2y51Y6lvllfhp96WjgyYg3txWUATIGsqCyOx3r69aniQHQIdmwfiUa2nSJwDi765+d2zVm5LqC88MakSuAHj1WtEN33ntxUeD4P1wH/CqHlmaUoqNDL98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmiXKcbl; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmiXKcbl"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b9a5b5b47bfso2056347a12.1
        for <dwarves@vger.kernel.org>; Tue, 04 Nov 2025 17:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762307119; x=1762911919; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KxZDxh7I7x4eGax46NKR/v6t63M0OZYsUiQcPaev0EI=;
        b=DmiXKcblimxTQf1teNsOcDPLWpN8uP9El5v3YEBXwYyflNk61fi8iu4OpQDGQw7y1Q
         sn1anS0BDr2mEQ7RGAw0jzMCQ9h32CMFgkQVTtkJcN1sRC2nnoxy7Hsn/YOqDSA02ISq
         pOLvOiATnrCp27sWcgXfB5l+bkWl4d/VBx99ID3+CSn7fYkTCgebBOvZG+CAqQdjuHoT
         XkSPbrq2fTrgvNNom5mkhiIJ4RExQMl98oXIsJqPwwh8mMYl0YnDXYC7LqYgxCIdCl51
         8PC23yHDNKJm5o+qdOR1EMcGcHu7veDYf2lW/YB7nB+5dBTe42Tt8H/i1wTRmYRGfsCs
         f0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762307119; x=1762911919;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KxZDxh7I7x4eGax46NKR/v6t63M0OZYsUiQcPaev0EI=;
        b=CyWr2o/UdkOIighJlYwPyZEW2J25EpLB4TmoxsLEfBfDPKCYNKccgDfkxYOxWS9BBB
         xBq15y15dAIKIDsVNurStJFkAAUm6kQx0DScv2mCZL2nl+sb9sn3DRKrOGCBpuyGvPs0
         sOZpi9T7Lf2Cpz58w+nCVmZE53aHSkm164tSPAgyguA8u+u4CeZkDb6902RhamJFvYWc
         z7/04YmVG1vyP+pWHWHOzpiKkkACMoO0DDURmoIijf3kVtZCo7T+1obM9TCYYoWRfdh7
         DvCwgXRWcDGHwJ+/qdQBWe1Ug6iexr9W9bVnY4AdlE9SRqWOMY24vJsRRagi6CjVbqV9
         C3DQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwWddsEUzJBgbvWNhWU+Ti7+imdKn3tu34v/wb2f/wqMKqkX7As6Q9J2nzUjpu+aycuSELx1wy@vger.kernel.org
X-Gm-Message-State: AOJu0YyVvIrc3E9vk1ooGGWPWBBuiXoVQjXzYPQzmHoQNadN4A1JLDjW
	Ei6oDY0tiWL0BHMgf4Ij6X+sRDy8g5c7J5Pi826IrsnIRn8FZ6lDZ+ar
X-Gm-Gg: ASbGncvu5Gq+1rX7kYnioMcujFXslATxCB4L0ju37qjeWq4xsxSadCk+tlgt1Dd4sQR
	zP/Nf2+kh67UI8fvdbdDJz9LqmRdf4OCnKcTcb80aFDkcG7+gV6wdWqLF2M1tlXvMYmo9fghjhJ
	Nf1yD0WYlWTJL3CUasRrHabW1e6wnhVvE7d1WCepvUTt7NuaZupIpfIIzEkmdTZ3fa4HRPZy/MC
	+5DhZwERnvRkewbeDOX5QyODR01rrq8DPXOPAB0Kqbsknoso7ziuFRvNUQnAOw2E/oadYXnmi9P
	5e7JBlvS4zS4YK7FrBUKJqoWvjF8LPfZinx2mYs+XT6TW1kRYkeofq+pjj2GlW6P0VYBfzLGGfM
	xaRAKPLyL3KMEK86Fc6+4dqb393rvMA/xqadokvg/91omYXHrDf5v9dzEIjQMrS2cHoOvdvTiG7
	srZHww3laXESXeMj/4M6GjOgKl6OHeIruwJg==
X-Google-Smtp-Source: AGHT+IHeEavZBNwuat1kGcSsAB0eRT2oAHDkUWWx0WOQQf7szc8HSJbJ/29q+YDY7xjS5ULKOclaog==
X-Received: by 2002:a17:902:f644:b0:295:5945:2920 with SMTP id d9443c01a7336-2962ada6848mr20749405ad.34.1762307118679;
        Tue, 04 Nov 2025 17:45:18 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:a643:22b:eb9:c921? ([2620:10d:c090:500::5:99aa])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a61418sm41376615ad.96.2025.11.04.17.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 17:45:18 -0800 (PST)
Message-ID: <09e212d8cec59ed6de637b62dd974c88fd33a3b0.camel@gmail.com>
Subject: Re: [PATCH dwarves v2 1/2] btf_encoder: refactor
 btf_encoder__add_func_proto
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves@vger.kernel.org, 
	alan.maguire@oracle.com, acme@kernel.org
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
 kernel-team@meta.com
Date: Tue, 04 Nov 2025 17:45:16 -0800
In-Reply-To: <20251104233532.196287-2-ihor.solodrai@linux.dev>
References: <20251104233532.196287-1-ihor.solodrai@linux.dev>
	 <20251104233532.196287-2-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-11-04 at 15:35 -0800, Ihor Solodrai wrote:
> btf_encoder__add_func_proto() essentially implements two independent
> code paths depending on input arguments: one for struct ftype and the
> other for struct btf_encoder_func_state.
>=20
> Split btf_encoder__add_func_proto() into two variants:
>   * btf_encoder__add_func_proto_for_ftype()
>   * func_state__add_func_proto()
>=20
> And factor out common btf_encoder__emit_func_proto() subroutine.
>=20
> No functional changes.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

No changes in generated BTF for my test kernel.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
