Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86740946C
	for <dwarves@vger.kernel.org>; Mon, 22 Jul 2024 04:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721624294; cv=none; b=TPn9tnxuqo563+FG89mm+QoCCkASjI2rVyamrp8qa24tysYjtUwDlHXY0Zxlbt21mZi1fbUvpilTv+nn5xg4o5YgOYxsqPdA9N4f1FI0nq9Q7h7RtXkWprHUg1Dq7K4EFxitRH1ISTy/PAWtJgQRGfsIEcu6ZZCpBhStXvgxkpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721624294; c=relaxed/simple;
	bh=HeTSn6FrxW8MWUIiVjDFvElcbeRd8zAvK/smejaJPc0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eCqwk1MSpA6XGD83r2lIf8kF4lyNfj5DWBwW4oN+iT5f0adhwULiIZSsHNXlsMDwuhL+d605QHJ8otPwpbTMdWmFlpntfC9Sb1XEAxqjoaokfxOdQXfkMRzw5iV6dBfbSGDfClqCu9keNi0iO50CLwTGAAc2RQplduiNDU8ZeN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=OzdBigzW; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="OzdBigzW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=O3OD0yJGzKkVemq5rPV956sh5EKc2h5C6wTsmO6MDio=; t=1721624290; x=1722229090; 
	b=OzdBigzWeT88G9QJdjwsz59u0Dd0c0re97TUisq8oE3FKEP4VhFIezhTYvwNlaG0eUerDoLeauQ
	4z8G1gSildTqjycFksol+WL8uX2Xj7H4iqlxn7lpWM2lnjW8/Mme1Eaj8vatwbsRp52A6mV6IIq/e
	c4KLuDggnILJxcFO4PbNh+72h71S2sisvvFr2WUXKilyQby3yTZOAixsktlFB18F3JvTspWDkJzWB
	OvAZCWM23SfWsDlqmBV6dI4rLQvHT2NTOq9hgo4Gftm431OR8Rv0LnoDjwVig7oJc7ADSUTedIoR6
	KEi3Aub8FLYuIev5VZOHKQGn56J4Nvq+6w3A==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1sVl7V-00000003RgR-2hSH; Mon, 22 Jul 2024 06:57:57 +0200
Received: from dynamic-089-014-121-120.89.14.pool.telefonica.de ([89.14.121.120] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1sVl7V-000000046EC-1n5M; Mon, 22 Jul 2024 06:57:57 +0200
Message-ID: <44424fa6ab0ad43d0e434e828cad691efa130f04.camel@physik.fu-berlin.de>
Subject: Re: Bug#1076564: pahole BTF processing seems flaky on powerpc
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Ben Hutchings <ben@decadent.org.uk>, Domenico Andreoli
 <cavok@debian.org>,  Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: debian-kernel@lists.debian.org, debian-powerpc@lists.debian.org, Alan
 Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>,
 1076564@bugs.debian.org,  dwarves@vger.kernel.org
Date: Mon, 22 Jul 2024 06:57:56 +0200
In-Reply-To: <f20cb01fd774776a3c05bde21a5a408b8a50ef66.camel@decadent.org.uk>
References: 
	<172133976964.70930.13662511677581571913.reportbug@deadeye.wl.decadent.org.uk>
	 <ZpoNZHIYuERg49N1@localhost> <Zpq6vEB3G1UlAeGR@x1>
	 <ZprYtq5UQ1KDMw_v@localhost>
	 <9bbcd88a1a0ae844d546468a3d68d3d60b9e3b13.camel@physik.fu-berlin.de>
	 <29e9f0c18895cd881a239aa5791bee5a74c2d31e.camel@decadent.org.uk>
	 <eef5c683d04b9497440a59eda4aa141a7a63a56b.camel@physik.fu-berlin.de>
	 <f20cb01fd774776a3c05bde21a5a408b8a50ef66.camel@decadent.org.uk>
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

Hi Ben,

On Mon, 2024-07-22 at 00:07 +0200, Ben Hutchings wrote:
> I don't know what differences there are between these builders that
> might be relevant.

For kapitsa, the installed host system is powerpc while all the others
run the ppc64 port.

As for the hardware:

kapitsa runs bare-metal (inside an LPAR) on a POWER8 machine:

root@kapitsa:~# grep model /proc/cpuinfo=20
model           : IBM,8284-22A
root@kapitsa:~#

Both blaauw and perotto are KVMs running on watson which runs
Debian's ppc64el port (little-endian):

root@watson:~# grep model /proc/cpuinfo=20
model           : 8247-42L
root@watson:~#

root@blaauw:~# grep model /proc/cpuinfo=20
model           : IBM pSeries (emulated by qemu)
root@blaauw:~#

root@perotto:~# grep model /proc/cpuinfo=20
model           : IBM pSeries (emulated by qemu)
root@perotto:~#

Both debian-project-be-01 and debian-project-be-02 are KVMs running
on OpenStack at OSUOSL's OpenPOWER platform:

root@debian-project-be-1:~# grep model /proc/cpuinfo=20
model           : IBM pSeries (emulated by qemu)
root@debian-project-be-1:~#

root@debian-project-be-2:~# grep model /proc/cpuinfo=20
model           : IBM pSeries (emulated by qemu)
root@debian-project-be-2:~#

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
