Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3522141A2
	for <dwarves@vger.kernel.org>; Fri,  4 Oct 2024 15:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728055736; cv=none; b=tNS2kblqSGcRHiQ9fsyoY+ixeugsbSXgtU3kNdfFdqGK2/X1VA31Sf5Yx97q7XPMTcPn9xtgfwepGZVQl31M59zsLxNXcfgfo+zvfBTHvrzw2ZWB8he9GADUsbWwLO3N6qfbxI2TN5bDeX08DTe9d9LKffW8CrojB2kbIfVAATA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728055736; c=relaxed/simple;
	bh=iX4EU1x80p+IkCZwVQEil3ngTIFac8Us8PtjxjUcu5Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OOIFKLV6F7PQ+vrOkERosxjReCiQ9c5K/qagokRmEv5Rjg94PJRJdwqiJJ8CRMv4THd7pLJLRsnI03mYZ8SVWl0PvFAGG2yrx+D8vg3Z9bGq1Za/9MC/4X+JFK+GH5XqlcH8US7Ss11ufSDU2pIKe2W3GKmVPfjvfQkYM+fSdd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=jYFF1p14; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="jYFF1p14"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728055732; x=1728314932;
	bh=iX4EU1x80p+IkCZwVQEil3ngTIFac8Us8PtjxjUcu5Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=jYFF1p14BvOfWVVvhqF2iROABoKE1YcMdRrwZi3tQ0Ih2FbaQPZ0oHfDPvIurzvUI
	 2cej9V/pzAqv4Sqs4O9zTExoVG40L3hgx1XRbMYNDTuy1YSrdvhl51ce2XDqXlRKnE
	 UOvTeIpTNYBSGAB64RbWcR+73YMx/YV/EH+vla4xFlYURqrTTl64KdXPs1yZ0jXeGh
	 tv/3+ltWkCjbrq1vBfQXiHJAy7kI0c+D/Nyy7/DPom4DWG0BGavZfkPQZkhdbUzvjm
	 I1syUsRWi5a+UmxNJSiEXZBpSmce7LPWGnLSJPFHodu2QE4i5ArfRJK01nisWkY82O
	 Gzu4NBzE5qx3Q==
Date: Fri, 04 Oct 2024 15:28:49 +0000
To: Alan Maguire <alan.maguire@oracle.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, acme@kernel.org, andrii@kernel.org, eddyz87@gmail.com
Subject: Re: [PATCH dwarves 0/6] btf_encoder: implement shared elf_functions table
Message-ID: <GpnFTITOVPIKrdi75gJNf_VUqajWA_XKkpz9M7vzr30XF4mGV5BPLVQVFFPiTFN29t7DUiXCrQwna3NqT0pqq9DaHEOGUDNWp2_lB453xZA=@pm.me>
In-Reply-To: <4d50db76-dd41-4855-977e-1e2a722b73b2@oracle.com>
References: <20241004051347.41143-1-ihor.solodrai@pm.me> <4d50db76-dd41-4855-977e-1e2a722b73b2@oracle.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: f8613bbcafe5e03dcccab8350450012b28180c27
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Friday, October 4th, 2024 at 2:15 AM, Alan Maguire <alan.maguire@oracle.=
com> wrote:

>=20
> On 04/10/2024 06:13, Ihor Solodrai wrote:
>=20
> > This patchset changes how BTF encoders collect and store function
> > information in a table searcheable by name, where their
> > btf_encoder_function_state is maintained.
>=20
>=20
> hi Ihor
>=20
> I'll take a more detailed look shortly, but I'd suggest respinning the
> series against the updated "next" branch shortly as there are changes in
> flight that Stephen is working on to encode variables; they
> significantly change the processing of variables, see [1] for details.
> They have partly landed and the rest will likely land soon. It might
> make things easier to wait until those changes land and respin, and I
> don't think they invalidate the approach you suggest, just will require
> some merging around variable handling I think.
>=20
> [1] https://lore.kernel.org/dwarves/8734ldm72u.fsf@oracle.com/

Hi Alan.

Yes, I am aware of the pending changes. This is a reason I was a bit
in a hurry, because I already had experience re-doing this from scratch :)

This patchset was done on top of next (2b35957). I don't expect this
version to be merged, but I wanted to get feedback from you and
Arnaldo, so decided to submit.

After Stephen's changes are applied to next, I'll submit v2 of the
patch.

Thanks!

[...]
