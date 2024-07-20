Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CC617FD
	for <dwarves@vger.kernel.org>; Sat, 20 Jul 2024 19:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721504464; cv=none; b=VW/kqQCvt3VN8Iv8dXiBIrRuc9riuhyMQRLXa4rEePBMvKu0eWPslSjIKqRP0YoeICntDTG+dHiOoSjtuANiDoyYvhW63HuCBLv7xXDoFrkNec54JGTEcHI82dxyjz8dcTItugQFONxbQoJdmzd+jk33GAupVnmcC0bz/cenSto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721504464; c=relaxed/simple;
	bh=6OokwOB0KZEjLGWK5b5EJ6UD1y5PVXG12su13OGSgSM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rhpdz77g6woYTy5QhgRSnZO92eKtJaBUo0HjQNjtGcTgujUfMEkYa0tgGHCQNhFkFHSVXEAK+RtqBcvcsjLesyFy9UkC33d/RMCOISV4Ijx+S8vhEchDSEDS30ESyAy2wOKuBfK/+hmcU5v1fWvI2jyYkOosz4zTlnZB1Lh6gOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from 213.219.177.86.adsl.dyn.edpnet.net ([213.219.177.86] helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1sVFcS-0004uX-3C;
	Sat, 20 Jul 2024 19:19:48 +0000
Received: from ben by deadeye with local (Exim 4.98)
	(envelope-from <ben@decadent.org.uk>)
	id 1sVFaI-00000000bxy-0Cwl;
	Sat, 20 Jul 2024 21:17:34 +0200
Message-ID: <29e9f0c18895cd881a239aa5791bee5a74c2d31e.camel@decadent.org.uk>
Subject: Re: Bug#1076564: pahole BTF processing seems flaky on powerpc
From: Ben Hutchings <ben@decadent.org.uk>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Domenico
 Andreoli <cavok@debian.org>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: debian-kernel@lists.debian.org, debian-powerpc@lists.debian.org, Alan
 Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>,
 1076564@bugs.debian.org,  dwarves@vger.kernel.org
Date: Sat, 20 Jul 2024 21:17:25 +0200
In-Reply-To: <9bbcd88a1a0ae844d546468a3d68d3d60b9e3b13.camel@physik.fu-berlin.de>
References: 
	<172133976964.70930.13662511677581571913.reportbug@deadeye.wl.decadent.org.uk>
	 <ZpoNZHIYuERg49N1@localhost> <Zpq6vEB3G1UlAeGR@x1>
	 <ZprYtq5UQ1KDMw_v@localhost>
	 <9bbcd88a1a0ae844d546468a3d68d3d60b9e3b13.camel@physik.fu-berlin.de>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-ADHgBYldkGpImOCBWOBx"
User-Agent: Evolution 3.52.3-1 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 213.219.177.86
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--=-ADHgBYldkGpImOCBWOBx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2024-07-20 at 09:16 +0200, John Paul Adrian Glaubitz wrote:
> Hi Domenico,
>=20
> On Fri, 2024-07-19 at 23:20 +0200, Domenico Andreoli wrote:
> > > > Is there anything I can do to help?
> > >=20
> > > From the 6.10-1~exp1:
> > > https://buildd.debian.org/status/fetch.php?pkg=3Dlinux&arch=3Dpowerpc=
&ver=3D6.10-1%7Eexp1&stamp=3D1721287862&raw=3D1
> > > file:
> > >=20
> > > + LLVM_OBJCOPY=3Dpowerpc-linux-gnu-objcopy pahole -J -j --btf_feature=
s=3Dencode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consiste=
nt_func --lang_exclude=3Drust .tmp_vmlinux.btf
> > >=20
> > > Can I have access to that .tmp_vmlinux.btf file so that I can try to
> > > reproduce it here?
> >=20
> > I don't have access to the build host (blaauw2) and I've some doubts
> > it would still have that file.
> >=20
> > Maybe our kernel team and powerpc porters have suggestions?
>=20
> I have root access to all powerpc/ppc64 machines (buildds and porterbox).
>=20
> I'm cleaning up the porterbox now, disk is quite full, then you can try
> to build the kernel package on perotto.debian.net or I can try it myself.
>=20
> I have seen the bug myself and I wanted to debug it, but the attempt was
> foiled by the fact that the disk on perotto is full (again).

I had a go yesterday and ran into the same problem.  I couldn't
reproduce with a small kernel config (allnoconfig + BPF + DEBUG_INFO +
DEBUG_INFO_BTF) and there wasn't enough disk space to build even one of
the Debian kernel flavours.

> Will take care of it and let you know when it's (some hours).

Thank you!

Ben.

--=20
Ben Hutchings
This sentence contradicts itself - no actually it doesn't.


--=-ADHgBYldkGpImOCBWOBx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmacDUUACgkQ57/I7JWG
EQm5qxAAuaQNjxh62uvDriYEEgLNDeWTlAuTb9MST2d1CnxHw0aMiD4B9R+zXR+W
3fbPhv0hRuOolB3tGz/nHzuqtRZscelYXEO7J9nXiS+zrNfeP/sobFHStSm+ChBC
xW+Zo8Sxm/2CEwhBgq3PNpC/vkX6MeF4Ng/0WkQskYuopyfbi7nvNMmA+pJLiV/k
gntKZXK6eoIjtIA2WqIV0vVPaGAiodlz5s37GPLVaokAYgmUiyK7uzqE9VMMCyWZ
uATK9MGKJ0xGZUoyPXW4IyPJgfaLgwjmaIspDHdSHKZOnZZEhXZ5gipKVUGixKBa
uHlyF/MkWdUKkasgS/Z0YSg5NCUWs/hH84UQDRTnTnUWGEAC0rbox8X/AIdW0IoQ
/qA82f1EZ2oO5hy5gb09yPAxT5bH2HWLFurL14pRfp5japk0t+QmbyCTqf5MLSme
HY21/Z8SgigJM46nr9dnqA1PPZHdpNJucsamv/kMROhNayp034xmk84opEurJbhd
vrjJpcxzNyWAQ2cYCkxF/d+p9G6GOyfkLs7cvz+onXzxbLS1xOZ4w0san1m1wxd4
klbhnroIGi97GqHpozwKIQ7C4fmhHiJpuZy/TXNKMi7jeIv3pkr50z5LVTkpqyuJ
9SGuGMGRULT+aA8M/p8roxIhUJ5aa0Fl0qctXnOq4sCeUZh7MiU=
=GXpj
-----END PGP SIGNATURE-----

--=-ADHgBYldkGpImOCBWOBx--
