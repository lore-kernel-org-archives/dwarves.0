Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048555CB8
	for <dwarves@vger.kernel.org>; Fri, 19 Jul 2024 09:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721380093; cv=none; b=i8UN54Ho6QcttKv2PnDFHa3SF1FaWhyJeCudjlrEhrRyX+wXC63bRHNZ0AtiK7v1UWL2Eshiy5bboTMwBMR5OcCgxYq5v56lIRGrAWFy6erSdkgEbzdh2GaZxUcCqZopGr3EyCte8GE9Vmeo6DO5J6biu+gbVRcxqs/ur8OK6/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721380093; c=relaxed/simple;
	bh=wEqPuiV6MS37IJvwIDSB47Ub6/+CqUuhcLUVky1SFdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dc9OSohWTtK0mkCz6LXnNzA25++Z5Pl6+aILbzo0k1pBr2WkS7YCiHFiI5K7R7+Eh0yw12CTbgcwwZvAJ4ZCCbO3t2K52Bu4HthK0wcgAAczWziFukzW6SFwtieFp7ijRQ/uEPTgc/9h2f5qFcYif+lyGsIw6GaUb7udWKmB2Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JsSIoGG+; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsSIoGG+"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2eec7e43229so23781661fa.3
        for <dwarves@vger.kernel.org>; Fri, 19 Jul 2024 02:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721380090; x=1721984890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PiW4cUA9gJ/kTc/e+uqB6ozcbwQV2y6qZyM5mV2iu0s=;
        b=JsSIoGG+x1zerSUVA1bJTm8RG2LxAYAjwnNM2XlzNAnudtyPFe3PrXbX7+QfDUK+Hc
         dzBMbLZanyygMFSPIUXE8LBJDeFmuZPagOh6rlCyl7V0zuP0bd+XGTOMNX8+56tCHySv
         5I5I1EWfsTHUg3Ja71+6d3d7u9JD38HCJR37cI/zyso9KTnAvqI1n37ALOdsks/u3rv2
         yPVKgXDo5WzWEx4SzeoWNLB7sXSmmggowIgB/PK+aA1wHakn2lPA4LmvwF2wqsy54P2+
         5xWXCR3S648+kTLSRUMlq2aJG8WleBmekcjOPNq6wwvjZN8s2xqYginbVdOQ7WNJ4TdI
         Na8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721380090; x=1721984890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PiW4cUA9gJ/kTc/e+uqB6ozcbwQV2y6qZyM5mV2iu0s=;
        b=ta11qZVyegGVEZTkcU5SSlf/CGi9Zm9nV5sbFRiMYyNswRGWuVysZgDjDC7eaHgWie
         fGaFS9z3ez5Nh3Qko3sh+kPycN4QwUrqxzux3S4vOOrq5nx0NbDg9O0cmndsc32zJhIJ
         HNlKebHkdlU9BU1yIq+EK4NfLkUb5i6Oeu+6M5ZBaGP7GNCV5UuVx0oyVyWPrJ37EHIJ
         ZmnujkfjVBuBofKL/baRCUPJeG7J31ZYHcTQ1kirFdoz6fkkxlrtnnknQLrxIvaIm3KY
         +Q1dqavW27FANzd2ovX+vwh6OTB+sGNfJZWz/J2y85Bgf+C62TZdq1vnw+w4Fqg5PQiX
         MY7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUxgCZKPNx2ukq+UKuN+t+b9JxGT/HOOeAzcBNEcjyn6MzCJ6g6gY+kejyN1OBOMqfAPepK4+k0aDBLeHowXBTMl9GbfJRb5A==
X-Gm-Message-State: AOJu0YyKGva+hr8FAqBOII5K59Bws+9iG+VvHVCw/Eov22hyl9Jlp9aw
	sjVCafIe+On7J4AUY/YRR8r/iNpUzupmliS1Uvq8EBRo9LPqIfQU
X-Google-Smtp-Source: AGHT+IFJbEok5JTQlq9YB5vL18tJw0N9mpfkvwQuZOj2v5+fIUZlAsjZRyClV5RsnH7Z2Y2HjiWhJw==
X-Received: by 2002:a2e:879a:0:b0:2eb:e258:717f with SMTP id 38308e7fff4ca-2ef05d43a2fmr31773311fa.42.1721380089752;
        Fri, 19 Jul 2024 02:08:09 -0700 (PDT)
Received: from localhost (77-162-229-73.fixed.kpn.net. [77.162.229.73])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30c7d30a0sm831930a12.83.2024.07.19.02.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 02:08:09 -0700 (PDT)
Sender: Domenico Andreoli <domenico.andreoli.it@gmail.com>
Date: Fri, 19 Jul 2024 11:08:07 +0200
From: Domenico Andreoli <cavok@debian.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ben Hutchings <ben@decadent.org.uk>, 1076564@bugs.debian.org,
	dwarves@vger.kernel.org
Subject: Re: Bug#1076564: pahole BTF processing seems flaky on powerpc
Message-ID: <Zpos9040E8538d2Q@localhost>
References: <172133976964.70930.13662511677581571913.reportbug@deadeye.wl.decadent.org.uk>
 <ZpoNZHIYuERg49N1@localhost>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i/lJM+UCayrje36j"
Content-Disposition: inline
In-Reply-To: <ZpoNZHIYuERg49N1@localhost>


--i/lJM+UCayrje36j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 08:53:24AM +0200, Domenico Andreoli wrote:
> Hi Arnaldo,
>=20
> On Thu, Jul 18, 2024 at 11:56:09PM +0200, Ben Hutchings wrote:
> > Package: pahole
> > Version: 1.27-1
> > Severity: normal
> > X-Debbugs-Cc: debian-kernel@lists.debian.org
> >=20
> > Several kernel builds on powerpc have failed recently:
> >=20
> > 6.8.12-1:    https://buildd.debian.org/status/fetch.php?pkg=3Dlinux&arc=
h=3Dpowerpc&ver=3D6.8.12-1&stamp=3D1717234422&raw=3D1
> > 6.9.9-1:     https://buildd.debian.org/status/fetch.php?pkg=3Dlinux&arc=
h=3Dpowerpc&ver=3D6.9.9-1&stamp=3D1720906547&raw=3D1
> > 6.10-1~exp1: https://buildd.debian.org/status/fetch.php?pkg=3Dlinux&arc=
h=3Dpowerpc&ver=3D6.10-1%7Eexp1&stamp=3D1721287862&raw=3D1
> >=20
> > Note, these log files are up to 270 MB in size and should be
> > downloaded; at least Firefox becomes unresponsive when trying to
> > display them.
> >=20
> > For each of these, the failure seems to start with an error from
> > pahole such as:
> >=20
> >     [102044] ARRAY (anon) type_id=3D99491 index_type_id=3D14 nr_elems=
=3D12 Error emitting BTF type
> >     Encountered error while encoding BTF.
>=20
> Does the above error ring any bell?
>=20
> Is there anything I can do to help?
>=20

Additional info

Debian package 1.26-1 has no patches applied, 1.27-1 instead has the
following backports:

https://salsa.debian.org/debian/dwarves/-/blob/debian/1.27-1/debian/patches=
/00-core-Initialize-cu_node-with-INIT_LIST_HEAD.patch

https://salsa.debian.org/debian/dwarves/-/blob/debian/1.27-1/debian/patches=
/01-dwarf_loader-Add-missing-cus__add-to-cus__merge_and_process_cu.patch

Dom

--=20
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05

--i/lJM+UCayrje36j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIhioiE2Z74CX+BiELwJgSGECT1EFAmaaLPMACgkQLwJgSGEC
T1GZkRAAglSnS25SL4G4Hd9m0dcW81mjxMQzF+0ri2u20iFCK5StAPRsuiInhDRT
o7sp1205KzUanbWAiNFHeOsHudseLr5QhTJfqJMh2O4q9wxe6M1e8BX6XAHsAJ3r
IxLTK7FBY9NfUOH1lLJ6bZSOsiU79x0TouYGmOIN1RInzwtGIbLCoGoW6bF71Xaq
AehBGZMT6Sx7WxWX9A/H6s7BfsCqi8OqSBj2KjxwWZ4wt82GypBbtg8aehY6O6hd
831wthlwjciUHMxf2VHfzGs8UZZ+CwkqomPWhwIjxf4bMqKA8lHbWJ3snJVLtD/b
TqQNd5aU/BY7oc+dIruXD9yyPl4fSj5Eio2Kp1lC+zXvHULiuXGWMKkIzS1OLj8p
ulS18nXqsHvPQG+HzqHamxRGfGiuiGk4Edf/MITAU4nwt8dK/j6gaDy8Cnlc1RJM
C0QXX3aX8xxLeGkBN/wMAOfiXOx5N3LShKAnBXI/WEamobjs2h6/Yf+vXjjMnuPx
tDfFganQzzKHVZeGk5F6akkhy1IXp4Fi2g90lJJsZ2LAO68RazxIpYNjJ6Kb37U+
PiJKR3BxzDfQf8BRUiRMEPzJGDOcAGfsuEE2I182CKPb8z5oBUj0h5L9LM71N16n
nszGa+A7RnaFUymuuN5NoIFOd6l1SYLRfC2Mvz/cfQ11xvUVCgY=
=/n7+
-----END PGP SIGNATURE-----

--i/lJM+UCayrje36j--
