Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1789735963
	for <dwarves@vger.kernel.org>; Sat,  1 Feb 2025 14:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738418629; cv=none; b=o66YrOu32SYiJ23yG2M7wcnih+iWZbMYIO1W+jvjU7FjyBaQ5Wn+RpGTbS6TdCG/Ww0skGxwPP8RSKwPJG+Sxwa45Fb+fpqPrZL81Lx6djEGyBTYThTIUy97Nsq4aIL+oeFa7gncZ5lPue6cGzmZFYPUz2yUamOaQBPn/3BP0a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738418629; c=relaxed/simple;
	bh=GMQueMiey9rdTFf7UBKNwhn3faIEOvC6NrVmVt0a1rw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IqtdB4owF1nnFhE4psVMFLEHaS68+ACDjY8+DIJ0aA9WWZ9HmLD7HVZ0sP66c+nAWeBDhP85qz6DQE0DJ03EKNx52lkoQVyUU8oKHbFxxTjMl5z07YH/g5aKvYwFfApyXkxJgUKeybMPRvdDXXitPM7tnxe51ko1gB2mp1aLW5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oxuj8jYa; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oxuj8jYa"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab7157cf352so55839366b.0
        for <dwarves@vger.kernel.org>; Sat, 01 Feb 2025 06:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738418626; x=1739023426; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=UKzKbKOLRC9RhqSGLAXcDyUNqT8hccv/kIrHRutN2xg=;
        b=Oxuj8jYaxLwKMlNLojMPEIyNLBHrwz5zQyHzmt2ucT9g2l8CnEuwngUjySvnPjR4gf
         X2QQMInkVZrW9GqwAICDoIxtBQAO47xUmvlYtoQVTDHfCDULYhjv+17szrWDdjV9dKej
         qm5rSmnOo4C8z6ajN3TyNOicrIOsUtyC5zoWOaVqWF5pHMZcmcvQif1NphmjeL9F2gYg
         fQrn74zIQwXETjrdZyTr4RvG+TNIjqW2lmfAc2u2Mi7ZT8L3CF1yLrC0o5ymoRxmAk8N
         dcueEH3anwm8EPO2e/Hus6T3nlp37DJETWqI5+Y3eg86Y4xVSxMHtlfjqw9HRyaQLjZz
         hjEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738418626; x=1739023426;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UKzKbKOLRC9RhqSGLAXcDyUNqT8hccv/kIrHRutN2xg=;
        b=OK78+SCihJuVMs0SdslxQAczoNYqOIsp2UHwTtP15nwIhtPNtNKNwp0iJ3YpggPntD
         /5cW1GR8bOPHTWJI2nkVsRCYgcghHMpSPmx3VCDADu+KIDOhZ1cH7QJK6DxKN5OiVt8x
         xdZJlF0Frc2D9K82UAFt+M8HBrnrdg/wDd9ItJP2L8NLm8Ve6KLKZ/HYHgp71VS6Uy5X
         UIMT/hteBPPiO4aF6K+oNpr7IhxoH4eqDYunTLsGYfkgo0tetdftpWu1WKZBmKIBOpaS
         UVrNAAS5doasO8uM8Nvkl7xJVNDtKyLruN9Z70zMqxYCM/udiiZr9i6kmbLT0+FR1gWu
         9/jg==
X-Gm-Message-State: AOJu0YwyATH+zeKMSMJrokWSkAlPjT+NlIFx9SWJvw0yRO5QCCBzilVI
	ZBRhe3R3kxScz4FjlA0OUvilNsygYGkREeqk1Uys/NVBPXTFplm11hveNdqttU5Sww==
X-Gm-Gg: ASbGncsCCwQQjwoK2JHL2i0nMtdeSuT3OgzREOw+pSumWemLTy2PppBvn/DRJFX0xjI
	/K3Phrq6pu+/oIEKeNsWzSfYq5Dctn0mR3kt1WpWFbtdEZRayKZKJBOgZTD5K6ZjEycIMMxUk2w
	TmYbfySQ0olWFJHSp7Py5DwgnyUcOIJOnvsRVWJ1D7BOswiD86vFgBn8SccdopjT7WzvvMpjPV7
	RVhXp4xrGGS4R8bRSknzu7RTurW4hzlSx5GkKyu3DZQ/eXw+kO1yU/+G6V3kHzbfgFyaeLOkNbs
	gwubeL12lWH9
X-Google-Smtp-Source: AGHT+IGbX6C7S6nwT5q+luMNYDcQLhJTggHo7JRhh3SiLyG7Pk23oMr9OdcUx2Ldz5H74tBpUMZUZw==
X-Received: by 2002:a17:907:6d22:b0:aa6:8764:8738 with SMTP id a640c23a62f3a-ab6e0cab185mr1060098566b.23.1738418625857;
        Sat, 01 Feb 2025 06:03:45 -0800 (PST)
Received: from m4.lan (tor-exit-1.zbau.f3netze.de. [2a0b:f4c0:16c:1::1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6ffc9eb9dsm246812266b.27.2025.02.01.06.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 06:03:45 -0800 (PST)
Sender: Domenico Andreoli <domenico.andreoli.it@gmail.com>
Received: from cavok by m4.lan with local (Exim 4.96)
	(envelope-from <cavok@localhost>)
	id 1teE5y-000tJV-1k;
	Sat, 01 Feb 2025 15:03:38 +0100
Date: Sat, 1 Feb 2025 15:03:38 +0100
From: Domenico Andreoli <cavok@debian.org>
To: dwarves@vger.kernel.org
Cc: 1037132@bugs.debian.org
Subject: pahole missing final "cacheline boundary" message
Message-ID: <Z54pul7P6-Gkc9PU@localhost>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IDh5eg/OwCY1Arc6"
Content-Disposition: inline


--IDh5eg/OwCY1Arc6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

We have an enhancement request from a Debian user [0]:

> It would be useful to emit a final a final "cacheline boundary" message
> when a structure ends on a cacheline, and emit a final "cacheline
> boundary was NN bytes ago" message when the last member overruns into a
> new cache line.

Is anybody willing to implement it?

Dom

[0] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1037132

--=20
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05

--IDh5eg/OwCY1Arc6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEGSWGdoKrcEzTtUezikr1XMf+zOIFAmeeKbkACgkQikr1XMf+
zOIv8Q/8Cl+oEuEDfbgDU0WAxPNzD6CVM3GGh2NkiYXkLLwlzNZLE9pU8J/TIQCx
MoAuyEyVWFaTZwD53AbRvWMNfxFctMa/Tm0KH1w6ZR+unYne/DH2y85RkilEDOC6
+b/qxDgsstTxkDH5mQ4Y21sI9WNBdnR86VUxhQJ9fB/2MfGIYmbkAAxibbGnL8Sv
d7aYf06Sbu19jxwfcTEpb7GniszsFsPWu4g6ZdA/d+ZV/muQ9sNNdF5+qE56QpaP
h/Kp4y8oQ1H23xU2xvDLnixxPbTJsHfIaWVMMEqlVo+O3oSiGRtKzSxbBWAU8f/n
6OXOSBqDeX/SOjsSzq1/fmYf08QvW5NrN+graZYT4jOwLSTEZKi2sWIvETTGZcRh
W+LiITpBIbFogujBWPOQe7VjNklRVwMFSKr2IyGBVHRHrqQKoRLXICi81mVial0x
rOHBfyJXkrY9jLmvSt5kdPw3sQ7Lg8D/NyEvnvb3Fxnb/YlJJrcTQdJSFOES926j
64BBgfnWXydPCg9dpabOUCkq8sJhm5NL9Q+vFBjidBmLvbQUkf2rg5gW6sy53RRU
rIWH122Ut0+p0YIwPMAxwo9uRd+nzFLpm71BJx8VVJ5YGZgZv4NbbThr9HdPYtnm
b1QrDPCUWrOMYbYKZe+GfoFpn2PsRywnj1CJfppUqLnv0zkp+9M=
=oi/I
-----END PGP SIGNATURE-----

--IDh5eg/OwCY1Arc6--
