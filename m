Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA732A8CD
	for <dwarves@vger.kernel.org>; Sun, 21 Jul 2024 22:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721599666; cv=none; b=UYNDMmuwpNXdeJ3sPybFvh+SUJfbdBnVyjyUYnUVyV7KYo3ijMBsAtZh3+oxTuuv3Z2OctYChHKMH5DNWMBy9TuDhrFtoXDG5/JH18/lWJ61Cp98HHmSO6MO9lLWztowaDFPen8Rr8f+p30stCyne8AiPNcDlJkEnYdsP2s8Slg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721599666; c=relaxed/simple;
	bh=+PfBohX/c9j1eV6l7ELomn3vdwxdf4aXkvJwLns1qJY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CZs6LSKbndrt5x8IpWxyZYye2NeDBDBjc/sRafNKHGOLTjhQsU91DYEInKBC2A6Bzc41Gx2zabqsUFL2hrgrnmiuelNszx+1ckwqw3VdofBiMeYKKhl1Nq4VMMjB1nnt1Z8H7N60g72cizsZngqkFgoypqFOeHFR5OTAQ7zNwTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1sVei8-0009Yk-33;
	Sun, 21 Jul 2024 22:07:20 +0000
Received: from ben by deadeye with local (Exim 4.98)
	(envelope-from <ben@decadent.org.uk>)
	id 1sVei7-00000005Nh9-2MnW;
	Mon, 22 Jul 2024 00:07:19 +0200
Message-ID: <f20cb01fd774776a3c05bde21a5a408b8a50ef66.camel@decadent.org.uk>
Subject: Re: Bug#1076564: pahole BTF processing seems flaky on powerpc
From: Ben Hutchings <ben@decadent.org.uk>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Domenico
 Andreoli <cavok@debian.org>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: debian-kernel@lists.debian.org, debian-powerpc@lists.debian.org, Alan
 Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>,
 1076564@bugs.debian.org,  dwarves@vger.kernel.org
Date: Mon, 22 Jul 2024 00:07:06 +0200
In-Reply-To: <eef5c683d04b9497440a59eda4aa141a7a63a56b.camel@physik.fu-berlin.de>
References: 
	<172133976964.70930.13662511677581571913.reportbug@deadeye.wl.decadent.org.uk>
	 <ZpoNZHIYuERg49N1@localhost> <Zpq6vEB3G1UlAeGR@x1>
	 <ZprYtq5UQ1KDMw_v@localhost>
	 <9bbcd88a1a0ae844d546468a3d68d3d60b9e3b13.camel@physik.fu-berlin.de>
	 <29e9f0c18895cd881a239aa5791bee5a74c2d31e.camel@decadent.org.uk>
	 <eef5c683d04b9497440a59eda4aa141a7a63a56b.camel@physik.fu-berlin.de>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-eAwPzTpeJGZE44aSyRob"
User-Agent: Evolution 3.52.3-1 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--=-eAwPzTpeJGZE44aSyRob
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2024-07-20 at 21:45 +0200, John Paul Adrian Glaubitz wrote:
> On Sat, 2024-07-20 at 21:17 +0200, Ben Hutchings wrote:
> > I had a go yesterday and ran into the same problem.  I couldn't
> > reproduce with a small kernel config (allnoconfig + BPF + DEBUG_INFO +
> > DEBUG_INFO_BTF) and there wasn't enough disk space to build even one of
> > the Debian kernel flavours.
> >=20
> > > Will take care of it and let you know when it's (some hours).
> >=20
> > Thank you!
>=20
> There are now 120 GB of free disk space. Let me know if that's sufficient
> or whether I need to clean up more, probably asking others to clean up
> their home directories.

I've now done 10 kernel builds on perotto (4 builds of just the
"powerpc" flavour and then 2 builds of all 3 flavours) and not
reproduced this.  I'm thinking this may be machine-dependent in some
way.

Looking again at all the build logs since DEBUG_INFO_BTF was enabled
for powerpc, we have:

Successes:

Version        Builder
----------------------------------
6.9.10-1       debian-project-be-2
6.9.7-1        debian-project-be-1
6.8.12-1       debian-project-be-2
6.8.11-1       blaauw
6.8.9-1        debian-project-be-2
6.7.12-1       blaauw
6.7.9-2        debian-project-be-2
6.7.4-1~exp1   blaauw
6.7.1-1~exp1   debian-project-be-2
6.6.15-1       blaauw
6.6.13-1       blaauw
6.6.11-1       debian-project-be-1
6.6.9-1+b1     debian-project-be-1
6.6.8-1        debian-project-be-2
6.6.4-1~exp1   blaauw
6.5.13-1       debian-project-be-1
6.5.10-1       debian-project-be-2
6.5.8-1        blaauw
6.5.6-1        debian-project-be-2
6.5.3-1        blaauw
6.5~rc7-1~exp1 debian-project-be-1
6.5~rc6-1~exp1 blaauw
6.4.13-1       blaauw
6.4.11-1       blaauw
6.4.4-3        blaauw

Failures:

Version        Builder             Failure mode
---------------------------------------------------------------------------=
-
6.10-1~exp1    blaauw              this bug
6.9.9-1        blaauw              this bug
6.9.8-1        kapitsa             this bug
6.9.2-1~exp1   blaauw              this bug
6.8.12-1       kapitsa             this bug
6.7-1~exp1     debian-project-be-2 compiler OOM; not powerpc-specific
6.6.3-1~exp1   blaauw              kernel-wedge failed; not powerpc-specifi=
c
6.4.4-2        blaauw              out of disk space

Ignoring the unrelated failures, kapitsa has a 0% success rate (but
with only 2 attempts), blaauw an 80% success rate, and debian-project-
be-{1,2} have 100% success rates.

I don't know what differences there are between these builders that
might be relevant.

Ben.

--=20
Ben Hutchings
One of the nice things about standards is that
there are so many of them.


--=-eAwPzTpeJGZE44aSyRob
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmadhooACgkQ57/I7JWG
EQnOiQ/7B3ZSSNKgAfclzx+md96ouck7XKrUlXfgtLURU74GW4/K7FXk7RqXFHP9
Bmes8U89qoa8VPvOi9j5p+GW5GqqRQtYi7Y21kYRUo81iM9H0yykKrWz4+txYECb
FE4YYEbjPIoznXlTsQVeTFlhOqedi6x0LW5TGtALrzQJs1KyQrvfOvswjnUzpcwT
mPfMYg0U1nbqF1e7sMaRuuf979V6OvsTCQJTt53BL3bMwiOss83C+dnFgrBLQlcq
Y9tbhpWD/djZHfdh6K4E3typiXUx2vKOGJ6yVKWYefDK8RjP0LQPf9Uw5vhhFy5A
XGjCZZnxKG4foW1MUAsuwjeuwedGic09Sux/NGSL+9jUeYQxvRKYMwFFzkwmBdb3
HRZBVi82/RxrZFTu9ImxQWJy+oIUTGgafB49Sy2s20XhwG6SgG6zZqfF3+MU9+jJ
EjvJmELVpIp2PR1xyWO40/+Z9ZN+R0ZpLpgXQNk411Ek6sB7Hl5GAqpql4gl95/s
IBGDZ7QsJDDhPJXp6HJcvwjharJqjpZgIly2V57ZeQC+WLjQhVhAatao1DaYbjKO
voJfhM7A51HPDODfX01yuuV+InA+A50Z2p/mNrxm7AAAuRolNGXECxxGJvvWmjhx
VtT12MjZj2scum1XkXtwoVuoIMc2Bat5TcnPBSIQkbaNu5tESuM=
=0edV
-----END PGP SIGNATURE-----

--=-eAwPzTpeJGZE44aSyRob--
