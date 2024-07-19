Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF11145B34
	for <dwarves@vger.kernel.org>; Fri, 19 Jul 2024 21:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721424061; cv=none; b=FD0w3rPfQledvyLqmtxBpvrIF8MAgVVK7zs2Ln1MpYQqR2Y+6hOCsAOWg/+q3fYDtK9RQpefTkSnciMjiVqk9fQ+gqCzGJx2Jm42dzAZaCp9D8mFknLwkLcxINai/gpppJK8iLrBHSvnG29dkvNwMH2NHfTiNPQfF99vTYBMRJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721424061; c=relaxed/simple;
	bh=s2KDtIbz3CBmRZZX4n5hN7JEpP044j8aIuH4vCtCbQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBdbW4DcRWxvFv+b2Nfhp5B+WpyrOvg359WSSeoV57U4oEQzVb7asdV5+7joowk+4lam3agDoMbzanqDtQ1XH6wJpKxnrPleAPCU0TxMt87YSiyYtKqjxFjfhMy/yRJZwY+uWFjDEtSvz1d6dw94hBoUH5wlXSlnUEPXnr82r48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGUWmKew; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGUWmKew"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5a1fcb611d9so1497147a12.1
        for <dwarves@vger.kernel.org>; Fri, 19 Jul 2024 14:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721424057; x=1722028857; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EU89TQY7ZIqEniDHrPFCKZSJrkozEzc6jpLTHPuVNmk=;
        b=KGUWmKewLJac1V6YrRzL50Ybcsfx+nVyvTjqRNVDg0PgXO+cv/hjWla9n7FRQTS8q6
         FuFDSyerIJqA8nhjuv7B8vGTPFV3tgY03gOloSIVS0GKOAI6UPc24fQ0rl5ds8BptRyq
         LPL/5kQNoF2Kj/fvB3YZaIwLu/vwItTZtzNHTdymA4MKcwP8gQjDmMTQ/pdSRMyGwKle
         sjJumcZwme1pS27STzumhtGi0TWWFYY+unft8/XQz8WiTd2c3524PJAhoJ671v9/j7tN
         wQNssShbWH5ZGGrxmp5Lxjt208YFAUS/G+KerT8a0Ql3FSstWPO//4FIpsdWrCn6fsyw
         Ex3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721424057; x=1722028857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EU89TQY7ZIqEniDHrPFCKZSJrkozEzc6jpLTHPuVNmk=;
        b=HBMvDpLqLPHZemZrJagPDivKtfBg32yGBDmqhS8XtPm6BFpheXt6NCAWzvkcTo8S2B
         r/yKFv1WQovAtpXILDZm0+iVTv2jpOOnl2IoEgv/a4hzPJKsGpFqarHkcNDUC9m5Ox90
         SKytPSHF9/p1bzRk/xzVlV3opd5+RXsut7LRk9K6Z1C60wkTgDzTogtvDSvn8AMSFwpA
         TiL8F7g93Ks89I0toSS0kYMOO8hmwqRhDq3mnkTsTLsza6m+Wf9utrjzwSARF+TXoaGL
         zIPZEdNbgZUJOou8pOk3Q6AVn1xuFPYbIj/hO8USWLaLBmgaoRTl3R7fwfrdqeTeEaW7
         BRAw==
X-Forwarded-Encrypted: i=1; AJvYcCVvc/9XbzempYKnUQXYtw9Vqy4odngHOLbitRIbL2tZ86urLL8oqi3kTRjpOo7N2kVDTdlGRH0b9SbNSYY8zsn8hylSXoN9YQ==
X-Gm-Message-State: AOJu0YxXc554waM77L3+EXk5UKwbAdMtRKieULgUOfDl+MbFdZsZw/De
	s3Q97/ykeb4OF57hf9YV9pHu6ZEbJ47+gAjwYwj1ZsW9f8/PpMnu
X-Google-Smtp-Source: AGHT+IFlsOwBq2u1klHSBUIZmS1C1dg4MzieZ9tQ0i53NOvon+jfYwtO/ngBYO48zKUGUELto3DD+Q==
X-Received: by 2002:a50:cddb:0:b0:5a3:b64:3b98 with SMTP id 4fb4d7f45d1cf-5a30b643c4amr1767712a12.19.1721424057152;
        Fri, 19 Jul 2024 14:20:57 -0700 (PDT)
Received: from localhost (77-162-229-73.fixed.kpn.net. [77.162.229.73])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30c2f8c10sm1760067a12.76.2024.07.19.14.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 14:20:56 -0700 (PDT)
Sender: Domenico Andreoli <domenico.andreoli.it@gmail.com>
Date: Fri, 19 Jul 2024 23:20:54 +0200
From: Domenico Andreoli <cavok@debian.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: debian-kernel@lists.debian.org, debian-powerpc@lists.debian.org,
	Alan Maguire <alan.maguire@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>, Ben Hutchings <ben@decadent.org.uk>,
	1076564@bugs.debian.org, dwarves@vger.kernel.org
Subject: Re: Bug#1076564: pahole BTF processing seems flaky on powerpc
Message-ID: <ZprYtq5UQ1KDMw_v@localhost>
References: <172133976964.70930.13662511677581571913.reportbug@deadeye.wl.decadent.org.uk>
 <ZpoNZHIYuERg49N1@localhost>
 <Zpq6vEB3G1UlAeGR@x1>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iywd2SPOB9vh9eZs"
Content-Disposition: inline
In-Reply-To: <Zpq6vEB3G1UlAeGR@x1>


--iywd2SPOB9vh9eZs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

CCing debian-kernel and debian-powerpc

On Fri, Jul 19, 2024 at 04:13:00PM -0300, Arnaldo Carvalho de Melo wrote:
> Adding Alan and Jiri to the CC list.
>=20
> On Fri, Jul 19, 2024 at 08:53:24AM +0200, Domenico Andreoli wrote:
> > Hi Arnaldo,
> >=20
> > On Thu, Jul 18, 2024 at 11:56:09PM +0200, Ben Hutchings wrote:
> > > Package: pahole
> > > Version: 1.27-1
> > > Severity: normal
> > > X-Debbugs-Cc: debian-kernel@lists.debian.org
> > >=20
> > > Several kernel builds on powerpc have failed recently:
> > >=20
> > > 6.8.12-1:    https://buildd.debian.org/status/fetch.php?pkg=3Dlinux&a=
rch=3Dpowerpc&ver=3D6.8.12-1&stamp=3D1717234422&raw=3D1
> > > 6.9.9-1:     https://buildd.debian.org/status/fetch.php?pkg=3Dlinux&a=
rch=3Dpowerpc&ver=3D6.9.9-1&stamp=3D1720906547&raw=3D1
> > > 6.10-1~exp1: https://buildd.debian.org/status/fetch.php?pkg=3Dlinux&a=
rch=3Dpowerpc&ver=3D6.10-1%7Eexp1&stamp=3D1721287862&raw=3D1
> > >=20
> > > Note, these log files are up to 270 MB in size and should be
> > > downloaded; at least Firefox becomes unresponsive when trying to
> > > display them.
> > >=20
> > > For each of these, the failure seems to start with an error from
> > > pahole such as:
> > >=20
> > >     [102044] ARRAY (anon) type_id=3D99491 index_type_id=3D14 nr_elems=
=3D12 Error emitting BTF type
> > >     Encountered error while encoding BTF.
> >=20
> > Does the above error ring any bell?
>=20
> Nope
> =20
> > Is there anything I can do to help?
>=20
> From the 6.10-1~exp1:
> https://buildd.debian.org/status/fetch.php?pkg=3Dlinux&arch=3Dpowerpc&ver=
=3D6.10-1%7Eexp1&stamp=3D1721287862&raw=3D1
> file:
>=20
> + LLVM_OBJCOPY=3Dpowerpc-linux-gnu-objcopy pahole -J -j --btf_features=3D=
encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_f=
unc --lang_exclude=3Drust .tmp_vmlinux.btf
>=20
> Can I have access to that .tmp_vmlinux.btf file so that I can try to
> reproduce it here?

I don't have access to the build host (blaauw2) and I've some doubts
it would still have that file.

Maybe our kernel team and powerpc porters have suggestions?

Dom

--=20
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05

--iywd2SPOB9vh9eZs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIhioiE2Z74CX+BiELwJgSGECT1EFAmaa2LMACgkQLwJgSGEC
T1GzNA/7BalASyrMuqnzqdX6blFOsNawhxG4EE5M5wouQfLKNqx8BLEHhLB3uBYO
bOos2rlyPLusomuyNIG5nXX2s0ikYib+B6SmbzEok2MtoGX1UwqgYudhQBoLCha9
lHlM8wuP+AnWnfEzhEpUNZTCXC32XZJI5Xm2CVsnSX36YsI+8J7Ew14Jls5D11Ru
8LUvGHWVVAjJX4vaAbz5oB/G/zRfPFY7XRcaRr5T7tuw66AcIByxXPUeNarYAOOc
jQrGuKth7Mrn2kI3Xe23/2RBU9PPtDFub2QqxOjIfbBGD2RxiZLO0wB2bq1r/cPY
qxIem0SrCodjCfwESwqWAvQ9Jw5Ww9e56KHppgLN2pndrzDs9QeODEV0cjxYIMMr
pmbqzyfJriVvyCH1rnuwyd/w/plDISDLCPXlC/UJnC1W7v4tdCUKsRNBImy6iEtc
Q9BwdAB4py3YP7q7GCyn+ialfGBeHpI3QzwcAm11Wue+Ha8x4tyuCyiuG+2YAxUq
HG+ei4jCoLFKExRwECIq5O4GxiQudFruq6JEpS6l9ZN/9WfZRQ6G6sSEOxxLP9+n
fMP0sc0TVmx7GZ40bfQ2XGvNSVSIDUx+H28AIuEwSctYOvFQfAzV0kySGI1r+mKJ
AZsnriKHUkcJ2d9P2aotwznPE9eHHxI8NFw1DIsae/cVKzvd8P0=
=ewTP
-----END PGP SIGNATURE-----

--iywd2SPOB9vh9eZs--
