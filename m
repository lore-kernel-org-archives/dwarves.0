Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FB512E1F9
	for <dwarves@vger.kernel.org>; Sat, 20 Jul 2024 07:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721459803; cv=none; b=NFnYgsRxSAO7O564mijVfjlJQhMPlSlOE0XCfST9+zUC+LdbSlOOiwwdqr296WOX56IOlJJUDqUZN4fWRDnx1q36wsURCixzubCvNXCL67loo+LA7vS/3DED76TfAfjhJfRcoeOWPzWA8OUbYxJUAzTpxfLDlxfq6q9yh+Kly3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721459803; c=relaxed/simple;
	bh=7znKU6d3t/Kwla/UuJ/yvfYyTKtX6nj/bvSFa5HbUOs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cSiULd0Wvd/3BR6Oef4cA6P6lF8H0Hc24QfWCIPGP8ModhYFw3f6aJqXVZg9Bxib8lqRXSWPE1PaDzE7g2SqzsLC09mSj/tzwm6wZFZYJ65/mCdxcy8Iz6oOlgzkDLa3RY7F5vNV3KtJ7WXG3Y6SIc3+1jZZCobiOGO6tw44qlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=FTIMxR97; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="FTIMxR97"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9cKbJJfjbd2p8ws1AyfxR9c7O+cT+sGiL7vZ8uHJCb0=; t=1721459799; x=1722064599; 
	b=FTIMxR97dNeniQheyrTYco5OyjE6sysFfyR3AY7QYnpYkX4E1+c8d0T2H0hWo2GMdhIBSMZwd+A
	eGwq3qYj7TnQLpmLE8pFOq01Inmv4ZaFlpF3hLqmDYEZi2w81ouJnH/EFY5T5TyFgqFr5ZrP+x7ED
	rtw2GExJouDqOW+BGr0eYV5EU9/3x5IGqkYSXohVaoVpwIh/9WoQ8JwEJu4deB1FR3JRczh7w7JPH
	UHCzgjgC9m+CYQSvYc4P0Tpnk7gxLD0s2S4K+FYVR0+1BpxSriWDTseudhuKsK3ZFrkMx8IHP0XKv
	Dtv4adQH4WsFqfxHJBd3RL5rhTgLVq2eW+IA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1sV4KP-000000037qC-0Lqp; Sat, 20 Jul 2024 09:16:25 +0200
Received: from p5b13a475.dip0.t-ipconnect.de ([91.19.164.117] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1sV4KO-00000003Ggm-3bp6; Sat, 20 Jul 2024 09:16:25 +0200
Message-ID: <9bbcd88a1a0ae844d546468a3d68d3d60b9e3b13.camel@physik.fu-berlin.de>
Subject: Re: Bug#1076564: pahole BTF processing seems flaky on powerpc
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Domenico Andreoli <cavok@debian.org>, Arnaldo Carvalho de Melo
	 <acme@kernel.org>
Cc: debian-kernel@lists.debian.org, debian-powerpc@lists.debian.org, Alan
 Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>, Ben
 Hutchings <ben@decadent.org.uk>,  1076564@bugs.debian.org,
 dwarves@vger.kernel.org
Date: Sat, 20 Jul 2024 09:16:24 +0200
In-Reply-To: <ZprYtq5UQ1KDMw_v@localhost>
References: 
	<172133976964.70930.13662511677581571913.reportbug@deadeye.wl.decadent.org.uk>
	 <ZpoNZHIYuERg49N1@localhost> <Zpq6vEB3G1UlAeGR@x1>
	 <ZprYtq5UQ1KDMw_v@localhost>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Domenico,

On Fri, 2024-07-19 at 23:20 +0200, Domenico Andreoli wrote:
> > > Is there anything I can do to help?
> >=20
> > From the 6.10-1~exp1:
> > https://buildd.debian.org/status/fetch.php?pkg=3Dlinux&arch=3Dpowerpc&v=
er=3D6.10-1%7Eexp1&stamp=3D1721287862&raw=3D1
> > file:
> >=20
> > + LLVM_OBJCOPY=3Dpowerpc-linux-gnu-objcopy pahole -J -j --btf_features=
=3Dencode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consisten=
t_func --lang_exclude=3Drust .tmp_vmlinux.btf
> >=20
> > Can I have access to that .tmp_vmlinux.btf file so that I can try to
> > reproduce it here?
>=20
> I don't have access to the build host (blaauw2) and I've some doubts
> it would still have that file.
>=20
> Maybe our kernel team and powerpc porters have suggestions?

I have root access to all powerpc/ppc64 machines (buildds and porterbox).

I'm cleaning up the porterbox now, disk is quite full, then you can try
to build the kernel package on perotto.debian.net or I can try it myself.

I have seen the bug myself and I wanted to debug it, but the attempt was
foiled by the fact that the disk on perotto is full (again).

Will take care of it and let you know when it's (some hours).

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
