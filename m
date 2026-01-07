Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C0331AAA7
	for <dwarves@vger.kernel.org>; Wed,  7 Jan 2026 13:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767791962; cv=none; b=skWKyVe3Qm6pzb6hBRyltMfzMF6PfKEbwrqR9BZgSCQHhFVWAuF0Sm99Jisv+vlwq1JVMXh1oRw5CZ4IB80Biu0bW0FVDZuFn2kkQ7+7fy6fiTKyz6QCAYQ6bahMDKOXpRIzXG64ayFV4aXif+mt8OludBi64ny2jSndnIDhMWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767791962; c=relaxed/simple;
	bh=Uq9yk0pqa6CErpXggBXldsd56C2yDeubsuwraPJTXIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwOWdgJ9d3V3ZhG3DXHL2s0BIiSp0hYvELKCRkMPbwnSopehnUH0fT2lS0SoliQ+hrbuDK2T0gcrYm+lS7EbMabRJQU1xybMyvF/uZJD0BtRAwsuRO/uDeORKGIV/uVTdkgKP5f+8Dqwiyq+VCL55JurkLZ1RvVXT5m5CFNtU5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jO3uMlOk; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jO3uMlOk"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34c1d84781bso1422295a91.2
        for <dwarves@vger.kernel.org>; Wed, 07 Jan 2026 05:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767791959; x=1768396759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uq9yk0pqa6CErpXggBXldsd56C2yDeubsuwraPJTXIY=;
        b=jO3uMlOkn7Q1U7WAYSmSF+h4UHxzHCjXoM9YQYfh31SgWg4/O64bKtrzm4ysa79yCB
         zDcw3rBQjRUg8J3hUyFFtvDaHWpnD4jW+iPYrEYNHW8LgR0sYA/IGOkmFRkzMbTx0wCQ
         b5PxwfAx0FR8i3TUsR6UhrzXoLh3bfcjYYONgI/mVj/pRxeuT5wTHIJHNaRbHZOIT8sM
         K70G+heh/FW18t9GMf8euH4nOyuBPQ0PJhVCJ0Ke856bDIsD7NKrLwyGoX+xsN3C3Q1F
         KWJssgDISlbJHQ/QmrziWud4bGOOuwIRwS6XMAyqKa66U6f0VaTfN3YRh8RTT/qX1wbq
         B+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767791959; x=1768396759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uq9yk0pqa6CErpXggBXldsd56C2yDeubsuwraPJTXIY=;
        b=KBXQWawZ/0ZYDYk+8fm4jh5PYRoeeU2tRHt9uwEcfVilE0GBxDI3kDtNr+GRZMhhQd
         Y8iCJ7oIWj9dLrASfUM/rHJzhNqqNb0UoQncX1LFKPjlp1tV6i92IQZa24bJCwJKcmYh
         EtDxANOLes13agBURfxeDmH+z8uSFV6uuURCk+87009PUpBizpgCX9p3zkyZ7hflPGON
         qvvvI6bd0p2Auuk7m3erRVatWX9zdK1L0gQrI4GJKDXftawDZv/1XLcDSJ5BM9oM0Y8x
         nBfIpomwmzlivA8F5TY2ULsF4mpr6J3Vtj6T2PTqbGQWSOu+aP43qtF1VlTjM2BPg1EC
         /c8g==
X-Forwarded-Encrypted: i=1; AJvYcCXdMTFhdYfAe1nar7npI+e5jG72WmZ53lMu3pgHKLLJ/BBw2QZaz7/0SeGfcBp9FYbpRAnyFIUF@vger.kernel.org
X-Gm-Message-State: AOJu0YxNhh3BptogHyOc6G1NCtR7vlQRfBjsN5fivMK4oUOcsupOlC6w
	J0oqU/hI4Rwn0NSZICk2njJolqU1Mq23s4NedLDIYxkrv4HaEtqQn14L
X-Gm-Gg: AY/fxX6lcv8tYhCnUgl5agLudwOiGLFxPfbBpp1fssQieIl3ldrMSW1MEpefbTPwmJR
	VlCRr68nTlt1wn4bs3FbDVNgczVY2/y7lURvbJssnspkLpbrg8B09aAJuOX3uRdVxrYbikJ8nV3
	saK+sLPikyhdNVVDgkVQnBuGdxAcR6dFW7pOh7bHj8C+0XnwpMwHdx6zAECJrtfpKCgPXUHFH3H
	ob6PayfGlh1RPY9hSBupW1fX5lmGNwLpsiUD6x0QYSqG7svCvPC1I6VYVTNfJO+ahfxoDOMS3PX
	G/eaCzE5BgQ4P8SDrQVmGc2g51Z+1uN8+EwxJmwzfRWdzyMdQzayevUfhpjB/gl+w3sSv7dqDGG
	TXjgt0zpb2Q11HZ48W0IDbXeLBYVPKDQr9J0Ua8BYFAA7hRkr2Uk4XecUFtbWulKfxdmYyaK9PW
	IqFhhPXtPbpqw=
X-Google-Smtp-Source: AGHT+IFeDRL/b8QepEuqdVndH+CCmCN1ugMAXxIErciQBd/TK/BwskXiSKTpfxPKZ00Mm2Wqq53x8Q==
X-Received: by 2002:a17:90b:4acf:b0:32e:749d:fcb7 with SMTP id 98e67ed59e1d1-34f68c28379mr2157102a91.13.1767791958715;
        Wed, 07 Jan 2026 05:19:18 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5fb74435sm5150241a91.14.2026.01.07.05.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 05:19:14 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 211B1415FEEC; Wed, 07 Jan 2026 20:19:11 +0700 (WIB)
Date: Wed, 7 Jan 2026 20:19:10 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>,
	Hemanth Malla <vmalla@linux.microsoft.com>, bpf@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, vmalla@microsoft.com, corbet@lwn.net,
	Alan Maguire <alan.maguire@oracle.com>,
	dwarves <dwarves@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf, docs: Update pahole to 1.28 for selftests
Message-ID: <aV5dToFzshRdIjgS@archie.me>
References: <1767352415-24862-1-git-send-email-vmalla@linux.microsoft.com>
 <bcd23277-a18e-4bb5-ba76-3416c84511c2@linux.dev>
 <aVjdUjai0lzpMeHv@archie.me>
 <CAEf4BzbAKGJsWov1udk+f5jS-qKSLMY+j76FP-JuWuxjhc0h-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8GbvbpBfl39DdqHx"
Content-Disposition: inline
In-Reply-To: <CAEf4BzbAKGJsWov1udk+f5jS-qKSLMY+j76FP-JuWuxjhc0h-A@mail.gmail.com>


--8GbvbpBfl39DdqHx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 05, 2026 at 01:46:52PM -0800, Andrii Nakryiko wrote:
> On Sat, Jan 3, 2026 at 1:11=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.co=
m> wrote:
> >
> > On Fri, Jan 02, 2026 at 07:33:50AM -0800, Ihor Solodrai wrote:
> > > Not sure if it's worth it to add this nuance to the QA doc, although
> > > in general we should recommend people running the selftests to use the
> > > latest pahole release. Maybe add a comment?
> >
> > I guess minimum pahole version can be added to
> > Documentation/process/changes.rst.
>=20
> pahole 1.22 is already specified in Documentation/process/changes.rst

Oops, I didn't see that pointer.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--8GbvbpBfl39DdqHx
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaV5dTgAKCRD2uYlJVVFO
o1kXAP9UlgleGCs3hp35KABPfg2p2+nPRBacjHknZrtTwIG/GgEAyfGQ4DIno+uM
KJeAT/uGjeN9Vkfg3/yhXRR9UYN3CAs=
=SAY7
-----END PGP SIGNATURE-----

--8GbvbpBfl39DdqHx--
