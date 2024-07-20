Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7A61803D
	for <dwarves@vger.kernel.org>; Sat, 20 Jul 2024 07:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721461686; cv=none; b=pXFJCn/YweG1BLnpzwL47cpSVG1UqcgQU1UsJybYCJueruQGxQpMmQkup72YjOu/V7fM+D/qY+fFgn6dA1G+jpPjz0RBo7QX55ThOq+96CBjZEN5dGrf7pJtHVQn1wbIbefuLEaBxYbe3rORulD0e7Vl5b6inzL3vJUcO21N+V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721461686; c=relaxed/simple;
	bh=smGmlUND38rtjYwyfn5ims6qt/SlEk7JiVoF9F+sSOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csgWiOiDs+2WxVvEt4q6k7OmqlJ05O4FOP6pX5B3rPAqz7LA0kLqE4YYfdbyHmLhnr2xrnZKz+ppTELygFPTuSL6TIOGn+1v4fZ3V1oxTSv6kg7g2xyKr9rzs1EKDoEx4j8fYNsL2FD0T97CJ6hDOF9EKu8mfsipnjw/NPEgdWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKws4qGe; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKws4qGe"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a77c25beae1so230561466b.2
        for <dwarves@vger.kernel.org>; Sat, 20 Jul 2024 00:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721461683; x=1722066483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ckhLCqtsXhfpSx4MQggebOAn/oSN1vgSwziib3tpzp0=;
        b=BKws4qGe61S910I3Ai5Nl9Nr+jBu9j6tjKMplsV0ggsxda3GsRVk8Jm+UzzcJfNgau
         Wo+Q2163kUUOu1osT3CSLEEp3qg+bcK+afV9bAmQaj0P+maKGKBclmT8TWhp96YpmhG+
         IaeU6ovDhswtlau1YWoNToEjCi2zt8/PbywkKIE3IYZEkKvyseDVnBie0oNy29GD+4PN
         9VNS4MaTFRr9gEp6rw2MOzt/6axIDmvvmk0Tdi5cKZ0Im5Fqv9NkRLrc35BY+kYaQdtJ
         +MJgizUQ3siHgiqEgj+SwlzdXGWSe5UaBOmW2H0tjePe1xEnjVWKtvYEFts5lqpTl+Q6
         qWuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721461683; x=1722066483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ckhLCqtsXhfpSx4MQggebOAn/oSN1vgSwziib3tpzp0=;
        b=FU7dxkzGcl4mn3z3PEGNpOEO6N6vSLWwZTEzjUQmK33hhzeL45nUk3wR9zEiow6o6A
         amzCnUK+S3GxCnGYvGCpBs6oHwaqV62T30UG7NyOF3clTZHsGMzbyT5+uDRg2g8mBFlv
         T7DVHIEELUJgyFMVIWzHewj13rTrYw1TbJ4Vjg+8ARP8/CwO/HO2lTac7JFwHU4e2mIm
         99C1m+DyoxmTIN2nGJCDXknLMUfobSk1UwLVHD9QcFVCD5fzOSZWqvt13Pr/y/JNh67n
         9jCD6sprmDKCQZ3gOB4muf52F4KEFFtSHjmW9Etpl7gW+KI/UB/+to1ZSODyJsbtkI7S
         XqJw==
X-Forwarded-Encrypted: i=1; AJvYcCVhoH24j3kydkB1Ic7nkKpTKIzmtf2i5T6PuwjR2y3VswYrASL7FeuUn9mBx/KhnoL9yAFqk95rNMalmZdqmNrhVcmK1uoiTw==
X-Gm-Message-State: AOJu0Yy3Syq9lvWjHjSpNW+/4i99VhIJlw/+bsVRhhl+1k0oDQ9JmsPT
	9Io2H0YsG8/S6RRP4j35HA2Es8GfhTh9QvdzoHMK3VU7LemQQt/F0D59f2P4E+Gt3g==
X-Google-Smtp-Source: AGHT+IG/jqG427HFJMA9eZgfpG+AED7Ungemnxwcqa2T7KQBEVkdmg4slXknNttPNhyXy8GPvwOGwg==
X-Received: by 2002:a17:907:869f:b0:a6f:b11b:8ac5 with SMTP id a640c23a62f3a-a7a4c01c13cmr48905666b.30.1721461682420;
        Sat, 20 Jul 2024 00:48:02 -0700 (PDT)
Received: from macchia.lan (77-162-229-73.fixed.kpn.net. [77.162.229.73])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c8bebd6sm123815166b.138.2024.07.20.00.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jul 2024 00:48:01 -0700 (PDT)
Sender: Domenico Andreoli <domenico.andreoli.it@gmail.com>
Date: Sat, 20 Jul 2024 09:47:59 +0200
From: Domenico Andreoli <cavok@debian.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Domenico Andreoli <cavok@debian.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	debian-kernel@lists.debian.org, debian-powerpc@lists.debian.org,
	Alan Maguire <alan.maguire@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>, Ben Hutchings <ben@decadent.org.uk>,
	1076564@bugs.debian.org, dwarves@vger.kernel.org
Subject: Re: Bug#1076564: pahole BTF processing seems flaky on powerpc
Message-ID: <Zptrr4YbzLQ7rk4b@macchia.lan>
References: <172133976964.70930.13662511677581571913.reportbug@deadeye.wl.decadent.org.uk>
 <ZpoNZHIYuERg49N1@localhost>
 <Zpq6vEB3G1UlAeGR@x1>
 <ZprYtq5UQ1KDMw_v@localhost>
 <9bbcd88a1a0ae844d546468a3d68d3d60b9e3b13.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h+63LGDZRa1hEPrt"
Content-Disposition: inline
In-Reply-To: <9bbcd88a1a0ae844d546468a3d68d3d60b9e3b13.camel@physik.fu-berlin.de>


--h+63LGDZRa1hEPrt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 20, 2024 at 09:16:24AM +0200, John Paul Adrian Glaubitz wrote:
> Hi Domenico,

Hi!

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
>=20
> Will take care of it and let you know when it's (some hours).

That's great, thank you.

>=20
> Adrian
>=20
> --=20
>  .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer
> `. `'   Physicist
>   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

--=20
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05

--h+63LGDZRa1hEPrt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEXyHpY5ym8Wu46kuocP5AkLatxCcFAmaba68ACgkQcP5AkLat
xCc10g/9FEXJvxGdhM0ThTj2+p9002npnN+s9CaQSLGSBNOwB74J/3g+Y9OuTkzy
47PnkmWxCP7BvDGuxLPBcCV/K4LWe3qRKfDyUepFeSlo7ch/T5GJlroIpnH/qRNA
LuNJGmLHBn8b66kD5R0VkAehCIGab8UBYL+QVEegWmIqWiPf0id7mvp/nikb/OTo
LNudOdwv7lYMbIkasfJ8hyGurKlOJRC9gZSc2s7XNY+38cNFM4YzDogMP4aQ/46c
gLuMq8Oze9PrHTWcRkV0NqblbXVHWqvU48BjuOK/UhxVgASSXnamZWPvfcNJ2oiK
6NgRpU0Ntv+38Gtb8DuC++RECVyrFVZatvhQq65Jxj+usDbmTeKCYfNAaxct/+RQ
t5w3EYeZfzODRn+afrJE2HZ9nnQZImKL8y29sFePMFvjAYvim8PRSnwsGbrQlvP/
xMcg+PzoMOWjIFvn5Gl/WETiTA3AfqDaRhy2pqNzBBPV0nkqTaN1UdHb6AY2JFbb
lt7kbXD9MyhHElP2zaDtgahjADondaEeBHEm8ytj5Sx1Wi/lFyW43M41JQSjcRDk
tvqhd6LKP8pyOBAUaDm/IBKlnR8jDyibTzSgfvOMoePq+nBsd7Yc97Vy0lFJxCPi
vM4XkcdCa/BW6K7X+jYmmE++ncyRgbYw5HUN4D3w/7PwuEuFuFM=
=vyDN
-----END PGP SIGNATURE-----

--h+63LGDZRa1hEPrt--
