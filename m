Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C97D1CACE0
	for <dwarves@vger.kernel.org>; Mon, 14 Oct 2024 20:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728937227; cv=none; b=H2nsQPLeOCEQA1rGDqGYFTtNQQ9R+iw/vpyi9m4Xe6RfIPt0E1IpnGW1NqkVv2j6Sn7RG6CeZjjzev52FNcyp6apJzntxUR7hMpT79Oixl0Kd4AoPY50saGyFgofgj3i8/R9x7rwJkPRV36ZjRZRRC5DC/t/MzRf4g7dMxil99E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728937227; c=relaxed/simple;
	bh=bJTpy2Ri12QoNrfa763MCHyKldG02aqGBJCHTdugNdw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q26i6MEiVXuHU5an38fd4gnhfTNKlcuWiBHrduWnzkpwtykmammXXc46r8IPGpY5niNBKtxAsp/U69QIEt6EHelnBF/3xpxG7+dOkvHv1xFnFKcdNMjD7RO95jtw2XHpQj6Pg8Ijs0C0M6WaWzBXyVj+hkQLcB02KPB2/d0XZjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XB2oQs1f; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XB2oQs1f"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71e52582cf8so1415004b3a.2
        for <dwarves@vger.kernel.org>; Mon, 14 Oct 2024 13:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728937225; x=1729542025; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZkgcfhUxjoClOjZ08BzXuzPGb88MqoGKDa6ekWtgIdU=;
        b=XB2oQs1fxYHpV0H//uDywUN3JuE9sVVGCIHPi0AUGLHZdfMaJX+iv+VIqSqCujDEOu
         yMIKwj6TeP+1J3eE8tGt2O6tUTUalqsN3RC63CA7AoRU9vqwyZ4mJ/aE00M/FMASkptS
         Ez3A75kIIzwwE00IQWczI+NgKMZLff9h211G9JuUjBSDpE0Rfx6qoZPRnMhi2sCpa5em
         SuEQEXdkvaI2+/L44/86WwHu10pnDQ+7R5FEGsLI6X7R378I+ui9K0m3KM/XCnMV9tm9
         qfOfgLLqlD6s556tyfMYVgLdCMM0CjILHiJsqVgjW9fJgWTlxJfAEPyJ0LxJxFnApfif
         L4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728937225; x=1729542025;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZkgcfhUxjoClOjZ08BzXuzPGb88MqoGKDa6ekWtgIdU=;
        b=cVszFGF82Q9lxeCgioxdnqVbn9r5KBqwK3apYal7jz61Uc49WyQkOx4tRFxn4ckfEM
         9je5qUAz5huRKvI9lq5WV5onipeHqqWhaiLgUMWCOYMzILQ6xEv67Xx+HXllYp64mKjp
         p26kHcZw9n5B+UFWFLX7WLCMNsMSPV61hbDlqliPELEKPQQP9B/pZw7qKugbqtbrWi7v
         JmzIoRymv09x4QoqqqlSZgvHwlXcQtG+CL+fRElNPBjVnjMGBCxaWvT0iXI4bnZreSvb
         D6dQjAYhQqHXeiXekurUzMJEj7zEquTynRN9T2ZPtWadhDoTVBe7UxCPOABSyxUFc8E2
         Fz2w==
X-Gm-Message-State: AOJu0YxU077EC40bLLirNDKa+zmztkUU8BIZ5pmdS9frwBfDsKBKO54f
	uvcsgbx6IP1pAgYtDD4bA8MZqsTkxPFpivTVtVMFJcr9yH79ExqP
X-Google-Smtp-Source: AGHT+IHn3wqkMsyuzO4wmVWdf7RcEz278cFitonIAWl6obGbKbCuJbi4Ityw1Fnz/TTYtgjZc77v1A==
X-Received: by 2002:a05:6a00:3d53:b0:71e:1722:d019 with SMTP id d2e1a72fcca58-71e4c1bfaf0mr15249267b3a.22.1728937224925;
        Mon, 14 Oct 2024 13:20:24 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e4a2c9767sm5434021b3a.85.2024.10.14.13.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 13:20:24 -0700 (PDT)
Message-ID: <079a99a2e5207d824ef69ba1d11a530d403711f1.camel@gmail.com>
Subject: Re: [PATCH v2 dwarves 4/5] btf_encoder: make elf_functions.entry an
 elf_function list
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, acme@kernel.org, alan.maguire@oracle.com, 
	andrii@kernel.org
Date: Mon, 14 Oct 2024 13:20:20 -0700
In-Reply-To: <ccbd5bd24ef1f68b6310434a55752cba961ed20d.camel@gmail.com>
References: <20241009233520.989453-1-ihor.solodrai@pm.me>
	 <20241009233520.989453-5-ihor.solodrai@pm.me>
	 <9f0b3a85b37d10bff446a43b2c154b1abd723d5f.camel@gmail.com>
	 <lVQ48eIOm008BvczqG7o2mjZ7Ofw8u22LnM4gT4L1BGn8yBaE5sZm0TeYi4dBZ6LXGGm0b7l7g-1wtpH2rQoG7AC2LyjdsqP5oK-r5r4ka4=@pm.me>
	 <ccbd5bd24ef1f68b6310434a55752cba961ed20d.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-10-14 at 13:08 -0700, Eduard Zingerman wrote:
> On Mon, 2024-10-14 at 19:39 +0000, Ihor Solodrai wrote:
>=20
> [...]
>=20
> > Ok, I'll try making the explanation better.
> >=20
> > Just so it's clear, in this patchset there are no changes to
> > btf_encoder__save_func() at all.
>=20
> [...]
>=20
> > I remember we discussed off-list simple accumulation of elf_function
> > structs, and removing merge logic from btf_encoder__save_func(). I am
> > hesitant to switch to that, because this would mean that multiple
> > elf_function objects for the same encoder might be stored in
> > elf_functions table. This in turn would require more changes. For
> > example, how btf_encoder__find_function() should behave then?
>=20
> Then I don't understand how elf_function objects are protected against
> concurrent update, btf_encoder__save_func():
> - mutates elf_function instance;
> - is called from btf_encoder__encode_cu(), called from pahole_stealer(),
>   executed concurrently;
>=20
> Here is a fragment of the btf_encoder__save_func():
>=20
> 	existing->optimized_parms |=3D state.optimized_parms;
> 	existing->unexpected_reg |=3D state.unexpected_reg;
> 	if (!existing->unexpected_reg &&
> 	    !funcs__match(encoder, func, encoder->btf, &state,
> 			   encoder->btf, existing))
> 		existing->inconsistent_proto =3D 1;
>=20
> If concurrent access to elf_function instance is allowed,
> '|=3D' operations need to be atomic and funcs_match() needs some mutex to
> prevent BTF update (as you point out in the commit message).
> What do I miss?

Ok, I forgot about the implementation of the find_elf_function_in_list().
Please ignore my previous comment and sorry for the noise.

