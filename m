Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDF02905
	for <dwarves@vger.kernel.org>; Tue, 28 Jan 2025 00:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738022595; cv=none; b=LeD+S5M//uWnpR0EtXfsEju4VhDLiH6vupCDWPawlVLY7tzn1vhvcLD+egZF2wPj0BRFIy66VRoZkb2lvEo4PNzFegjOnDJ3Zq+5xYRGEC0ViJjm10TT+skGd04+9dhJSi2Hh3uBnDAz/lSR2hQZwVZX73KRzo38wT9ZEn0K9gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738022595; c=relaxed/simple;
	bh=OY4JGWDbVjv6gQRTu+PfiqfThf0rSLEXTdIcrjJRLNs=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=OEU5uZ/HY7Tnym1vVXo9iMUSh1rDeX8ToAVSEI4q0yJ7IW2pDDW/CbrqLfeZ+6hFjLMDPrkwdHp0Sgs52c8DF6lTTzUXOe/JoLAsk1n/eVC3QBnR1icnHPFraiCAiCtoBFBj1eMmKvDgVSnLkkIzEBzz0neEM2SPqYNqxV5Prtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fh/bfofd; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fh/bfofd"
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738022587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OY4JGWDbVjv6gQRTu+PfiqfThf0rSLEXTdIcrjJRLNs=;
	b=fh/bfofdfxJekh7YMUBk4kKj10BPVedAZPd1erXavfBurDs9B9DKXxO6d8E+qE+3v9Ncum
	Egw75DMDJEFWaErEmiRHYVcwEYln2LFR3UdgD+wplXi6cHTffnish//jhdUBSKdQCAxr4A
	6yzSN+Nf0bHpeCDiiwLclm/OuiA9opo=
Date: Tue, 28 Jan 2025 00:03:05 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ihor.solodrai@linux.dev
Message-ID: <8bb182c6a5f7a7ac3668297bca5a31467fac93de@linux.dev>
TLS-Required: No
Subject: Re: [PATCH dwarves v2] btf_encoder: fix memory access bugs
To: alan.maguire@oracle.com, acme@kernel.org
Cc: eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com,
 bpf@vger.kernel.org, dwarves@vger.kernel.org
In-Reply-To: <20241216183112.206072-1-ihor.solodrai@pm.me>
References: <20241216183112.206072-1-ihor.solodrai@pm.me>
X-Migadu-Flow: FLOW_OUT

December 16, 2024 at 10:31 AM, "Ihor Solodrai" <ihor.solodrai@pm.me> wrot=
e:

>=20
>=20When compiled with address sanitizer, a couple of errors were reporte=
d
>=20
>=20on pahole BTF encoding:
>=20
>=20 * A memory leak of strdup(func->alias), due to unchecked
>=20
>=20 reassignment.
>=20
>=20 * A read of uninitialized memory in gobuffer__sort or bsearch in
>=20
>=20 case btf_funcs gobuffer is empty.
>=20
>=20Used compiler flags:
>=20
>=20 -fsanitize=3Dundefined,address
>=20
>=20 -fsanitize-recover=3Daddress
>=20
>=20 -fno-omit-frame-pointer
>=20
>=20v1: https://lore.kernel.org/dwarves/20241213233205.633927-1-ihor.solo=
drai@pm.me/
>=20
>=20Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
>=20
>=20Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
>=20
>=20---
>=20
>=20 btf_encoder.c | 11 +++++++++--
>=20
>=20 1 file changed, 9 insertions(+), 2 deletions(-)
>=20

Alan,=20Arnaldo,

This patch hasn't been applied.
Just a reminder in case it fell off the radar.

Thanks.
