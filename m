Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198173D984
	for <dwarves@vger.kernel.org>; Fri, 19 Jul 2024 06:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721372011; cv=none; b=mo/huYGsrChO1kgr5Ur4E79NrL/ogPevAfx3NE5mFJa/PIbs5xJj9BUaMRj6cL3gM04Yk9K1tQCz+nqVo9wRIL/yL2nWsalOZklUH0g9qL6Ntfkmd2nivO/07HDn7Imc44s6FYgNjWsj23jptDNCamaUyeOSVT3HoW8km7owSm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721372011; c=relaxed/simple;
	bh=+NF7lyH6wzQHAgYPTJuoRRZkoilrPFhxIn+M1yX/YSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAWk91cAm2OnOQ8aePSH2NGlr7S1fq3H3XUFKBy/rGFeol1FvHHUtM1B/olo/DpsJwViuxFuDArFnPtPtqyFX4OtvCKOz7q6kWkEYg5l01INZnvPRGMIGh5SwBcO8zNoyWmQkdsaB6dLcvb8QFfbqPuhHIZrngxry4d48lIRuo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dI82V3TT; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dI82V3TT"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5a3458bf7cfso184359a12.0
        for <dwarves@vger.kernel.org>; Thu, 18 Jul 2024 23:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721372007; x=1721976807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ve2zmDgR8NqDN9e/0nEF/Sc7kafzlKzWUbA59XmkcFU=;
        b=dI82V3TTEwfjDvw0m6KaV+jEuaJ32CN/MxFqCdnHbfCwVtF/5Jp5rCiB/l+QY5Q8Sw
         18XiAWfXTKuq1h5P4lmrqHXMIA+kalk0DaXvAzF3aFH+3bw2kleXcU94/EBj5MTi2IIu
         dH7V6lpjsAfwnd7yDMsWmqYeUUHtfIW87M/6de5AN6xxAxjFvwVsVX840S/RU/fzB3V4
         j1sxrUOgPEExHuTlTcjsxvYO59Vi3n1s40xUUmEPdyFxrvm19cT7/szPbgW7ZkMdyaT5
         SC5F+98xwZxlLa9EcP2uK4btr9OkkT9ewXC2PIGm1qGp+PRSB/0jqj42y2dJfbWtmrxN
         BKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721372007; x=1721976807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ve2zmDgR8NqDN9e/0nEF/Sc7kafzlKzWUbA59XmkcFU=;
        b=vh1EylA+cnNQzV/NFE7mMt7j0RICXBdW7jSkdDPsgTd4bI1U4EESfP+vouuSnnrum8
         KUMvnsyzPVo1R5tWXETo3jbk8Gk0kjKffI51cN1KBqCHRSxIHBZ85VcnOGOyuvnbeBmi
         Ew9xTjwlX4ooKaEffjVg5Xvamp48rpATSmwCVvIWjQN19fAkH7mK5ND19FIwqcaWcsd2
         m690Ranyw+lb+Rs+L0hnWpKcbiKdZmjnoiawJdg8nL02UVmo8qzrZmnQMAZe4GptmJNg
         JhekVTmqbD2xYkcsS+8Uh0XgBKPcqogHnxEgt7Hp3GYw36E0xZD9PLovF1nKeMgfNUHm
         2eCg==
X-Forwarded-Encrypted: i=1; AJvYcCWKIc4G5+qZAtKrsBnqSYxKjTSNhBBX3i+HT27zi3VXnRZNKSPzwBAe2VhP3x96+eLgxvu0SwjDk7E+bYaaIygqEiIeVfzxZA==
X-Gm-Message-State: AOJu0Yykt7zbjTQIFBPo3HuANeDVmuQnRnjOd+378MahrU7Y3RVpyQCd
	VIiiCk/kgrJVef8Rg8/r/vuL07eGHLoenT/jfX+WFgqjg16szDFEDLqanAxnthY=
X-Google-Smtp-Source: AGHT+IHfV51FEzaN/N7wfsyhrdDnsDkNtP/HLl7ERic9qJsJk8WJJ/GjiHcurcwosIaFrCzvWUX9Pw==
X-Received: by 2002:a50:cd19:0:b0:5a0:f8a2:9cf4 with SMTP id 4fb4d7f45d1cf-5a0f8b1dfadmr3243276a12.25.1721372006995;
        Thu, 18 Jul 2024 23:53:26 -0700 (PDT)
Received: from localhost (77-162-229-73.fixed.kpn.net. [77.162.229.73])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30a4d6fadsm630749a12.6.2024.07.18.23.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 23:53:26 -0700 (PDT)
Sender: Domenico Andreoli <domenico.andreoli.it@gmail.com>
Date: Fri, 19 Jul 2024 08:53:24 +0200
From: Domenico Andreoli <cavok@debian.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ben Hutchings <ben@decadent.org.uk>, 1076564@bugs.debian.org,
	dwarves@vger.kernel.org
Subject: Re: Bug#1076564: pahole BTF processing seems flaky on powerpc
Message-ID: <ZpoNZHIYuERg49N1@localhost>
References: <172133976964.70930.13662511677581571913.reportbug@deadeye.wl.decadent.org.uk>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/5XBgT0oFmGrBoLE"
Content-Disposition: inline
In-Reply-To: <172133976964.70930.13662511677581571913.reportbug@deadeye.wl.decadent.org.uk>


--/5XBgT0oFmGrBoLE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Arnaldo,

On Thu, Jul 18, 2024 at 11:56:09PM +0200, Ben Hutchings wrote:
> Package: pahole
> Version: 1.27-1
> Severity: normal
> X-Debbugs-Cc: debian-kernel@lists.debian.org
>=20
> Several kernel builds on powerpc have failed recently:
>=20
> 6.8.12-1:    https://buildd.debian.org/status/fetch.php?pkg=3Dlinux&arch=
=3Dpowerpc&ver=3D6.8.12-1&stamp=3D1717234422&raw=3D1
> 6.9.9-1:     https://buildd.debian.org/status/fetch.php?pkg=3Dlinux&arch=
=3Dpowerpc&ver=3D6.9.9-1&stamp=3D1720906547&raw=3D1
> 6.10-1~exp1: https://buildd.debian.org/status/fetch.php?pkg=3Dlinux&arch=
=3Dpowerpc&ver=3D6.10-1%7Eexp1&stamp=3D1721287862&raw=3D1
>=20
> Note, these log files are up to 270 MB in size and should be
> downloaded; at least Firefox becomes unresponsive when trying to
> display them.
>=20
> For each of these, the failure seems to start with an error from
> pahole such as:
>=20
>     [102044] ARRAY (anon) type_id=3D99491 index_type_id=3D14 nr_elems=3D1=
2 Error emitting BTF type
>     Encountered error while encoding BTF.

Does the above error ring any bell?

Is there anything I can do to help?

>=20
> This does *not* happen consistently.  Compare these successful
> builds:
>=20
> 6.8.12-1:    https://buildd.debian.org/status/fetch.php?pkg=3Dlinux&arch=
=3Dpowerpc&ver=3D6.8.12-1&stamp=3D1717278092&raw=3D1
> - This same version failed to build on the first try.
> 6.9.7-1:     https://buildd.debian.org/status/fetch.php?pkg=3Dlinux&arch=
=3Dpowerpc&ver=3D6.9.7-1&stamp=3D1719538806&raw=3D1
> - Earlier and later 6.9.x versions failed to build.
>=20
> Both pahole versions 1.26-1 and 1.27-1 have been used in both
> successful and failing builds.
>=20
> Ben.
>=20
> -- System Information:
> Debian Release: trixie/sid
>   APT prefers unstable-debug
>   APT policy: (500, 'unstable-debug'), (500, 'stable-updates'), (500, 'st=
able-security'), (500, 'oldstable-updates'), (500, 'oldstable-security'), (=
500, 'oldoldstable-updates'), (500, 'oldoldstable'), (500, 'unstable'), (50=
0, 'stable'), (500, 'oldstable'), (1, 'experimental')
> Architecture: amd64 (x86_64)
> Foreign Architectures: i386
>=20
> Kernel: Linux 6.9.9-amd64 (SMP w/12 CPU threads; PREEMPT)
> Locale: LANG=3Den_GB.UTF-8, LC_CTYPE=3Den_GB.UTF-8 (charmap=3DUTF-8), LAN=
GUAGE not set
> Shell: /bin/sh linked to /usr/bin/dash
> Init: systemd (via /run/systemd/system)
> LSM: AppArmor: enabled
>=20
> Versions of packages pahole depends on:
> ii  libbpf1     1:1.4.3-1
> ii  libc6       2.39-4
> ii  libdw1t64   0.191-2
> ii  libelf1t64  0.191-2
> ii  zlib1g      1:1.3.dfsg+really1.3.1-1
>=20
> pahole recommends no packages.
>=20
> pahole suggests no packages.
>=20
> -- debconf-show failed

--=20
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05

--/5XBgT0oFmGrBoLE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIhioiE2Z74CX+BiELwJgSGECT1EFAmaaDWAACgkQLwJgSGEC
T1G1+Q/+LcDGT/BEDOp/47JrvMrbEGXxr3YNXneBWeB62FoHCDtRjTCNkJh4Ml4M
3PJSovR5Lw4qHlNbPgmadZ9T06MPTKXkr7m5tTiHQssKEzCFyXHwF/IG1oo4Kjpa
sfHfs8n6mo6pB88Z0ygC43oRhhiXkQdEMpwYvo/Iqd3tLEQpwFosvBwhvFNAgWa/
S5+PQUpLnlTtSEeYlPE7+HTSmqy7iutwzxrWE53vLsE22dYRWNRCN7IZqop3Fv+1
90l9XFXuct/uR0hzFutFY8yAyDSHRSnctMNtp5m8uXb3RF5PhBPFrBjLbVy+HWKE
miW7bm8L3KiNUvrRY+g82mlpqaXicYTKCGFty40Qa2Sy7pim2WzUj8pual1uHfP6
bx1w6W70LaZ5XGIjJgSGJhkOt7doURgso/U56F02R/cc5E2Y/eio5Usr2oj6cHPg
PtxrHsVsH3pBclKJ+wWU3i3Qf4Ml1nvo96eSY32M2PEP37bLxhzZ36Qv26PGhznU
gdw2z04gqVneCz2Hy74jXeNjU7GTGmAUtrDMtmd55yHymByFkmQIgOn+w26+NcZg
uMJ9VXADI+8EwX23Wh+z8K7Ao32S06x7ul6WWfFqImNoEAILfZWuzMouj9fZzIWd
SWwsguY0qPfr8FnHRCD7WJgJHqWsHku3jLjRJrZIP+Bh7Y05/vI=
=7d7f
-----END PGP SIGNATURE-----

--/5XBgT0oFmGrBoLE--
