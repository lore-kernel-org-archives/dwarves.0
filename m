Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6118489
	for <dwarves@vger.kernel.org>; Sat, 20 Jul 2024 19:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721504728; cv=none; b=HLferuMTtoaKFH0eYAKGv3sIsGlm/ruSw1/ruWMn2Pregfjs6HcNTiV6dR2RGbcTA/0VfE8a5ABVM1gX/T3a2TDMsRwccCfdocNSTcer52oyE6c7Htlfrng19UIaA59FX5AGr8JMhdw9QNXXmm0+cRFQ+xMX1sbUyWDQ+GgjDvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721504728; c=relaxed/simple;
	bh=kLuokYtSoW6fyvW3cCRuBlWcJZl4gU5NW/9G6O2UA+Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lXwOkH35wkCbZCOTMAhK/8xcS59nSk1NhajXAxIYrPM6b4wnF7w1mekp4n2jLj8qwky/xfd35DsKjJb91iwE3PSXwCNzOGNNhTbgcrmsyNPj6QFm3k1J0C4zz2D2jR5cYXFYwhqJNxgxkiCMjQ3ddI5hSMc/iNFNns/2sFdZPHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=XcGkHnPc; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="XcGkHnPc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=L4schTQjWMj+ILX5i1IE+Ia8RW3t3BmktamcFeMrctE=; t=1721504725; x=1722109525; 
	b=XcGkHnPc8KCZ2kIc5axH/MO68j7q+FgMMKB1w7unWkXGUImZakqE5Qv+uOAOGzd2hyBr9/2wXuh
	y0Onuei5xlV7GVF7Nmhi/exoJI0Suzuv36eOWH75ZN0evdRnwL0okbU0xPWtLAHAKyKUkVRNQaxij
	69QV26IA9Dtll6rapWiMqKsQzsaRaJTHiSVcA5EvAxQfRkDlOMdUg1JjGHoBtmqRuIzlQyew8Rzgo
	aQngsWKdbkpJ8iFCrvKksIkW1XizfYvJEOssVDuBsbh2Hw4Tt7+yzxXpDVFHHCA7X0JzLEkvpP3lB
	91zgRwE3BRNWem1cz5ngQQ1zVKsjW3xGXjxg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1sVG18-00000001oiQ-37Lf; Sat, 20 Jul 2024 21:45:18 +0200
Received: from p5b13a2bf.dip0.t-ipconnect.de ([91.19.162.191] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1sVG18-00000000Qmy-2AFp; Sat, 20 Jul 2024 21:45:18 +0200
Message-ID: <eef5c683d04b9497440a59eda4aa141a7a63a56b.camel@physik.fu-berlin.de>
Subject: Re: Bug#1076564: pahole BTF processing seems flaky on powerpc
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Ben Hutchings <ben@decadent.org.uk>, Domenico Andreoli
 <cavok@debian.org>,  Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: debian-kernel@lists.debian.org, debian-powerpc@lists.debian.org, Alan
 Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>,
 1076564@bugs.debian.org,  dwarves@vger.kernel.org
Date: Sat, 20 Jul 2024 21:45:17 +0200
In-Reply-To: <29e9f0c18895cd881a239aa5791bee5a74c2d31e.camel@decadent.org.uk>
References: 
	<172133976964.70930.13662511677581571913.reportbug@deadeye.wl.decadent.org.uk>
	 <ZpoNZHIYuERg49N1@localhost> <Zpq6vEB3G1UlAeGR@x1>
	 <ZprYtq5UQ1KDMw_v@localhost>
	 <9bbcd88a1a0ae844d546468a3d68d3d60b9e3b13.camel@physik.fu-berlin.de>
	 <29e9f0c18895cd881a239aa5791bee5a74c2d31e.camel@decadent.org.uk>
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

On Sat, 2024-07-20 at 21:17 +0200, Ben Hutchings wrote:
> I had a go yesterday and ran into the same problem.  I couldn't
> reproduce with a small kernel config (allnoconfig + BPF + DEBUG_INFO +
> DEBUG_INFO_BTF) and there wasn't enough disk space to build even one of
> the Debian kernel flavours.
>=20
> > Will take care of it and let you know when it's (some hours).
>=20
> Thank you!

There are now 120 GB of free disk space. Let me know if that's sufficient
or whether I need to clean up more, probably asking others to clean up
their home directories.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
