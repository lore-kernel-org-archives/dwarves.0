Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95829283FE6
	for <dwarves@vger.kernel.org>; Mon, 22 Jun 2026 19:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782155917; cv=none; b=Qgo/kGtutiag9F2Ylss3fVsyzwk2K5McM1DP4cCiyOhnwzfFhbB2FBPJtOM6xA2af7LhpFGQ4JQXXE1bJhpnYHGGBJG7N6dhy2S3wQ3Pgq+6wcqoBVCOKhXATkVbJQhPRes037p78BIZDTlRdwaKrVZdXV8GNlMld14cXfcKZQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782155917; c=relaxed/simple;
	bh=QgsrGsw0tZ/j+IZn0h6YHP6qQ8IjufSFPGfGAXynawI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Q5waqvnBH3KhC8cY6sEAc6kuT/vnsUPVu6xrv2mJxlw7Ibm6w0VvSx9ojHgEHAbDNeFbXB4qrzvQNGH11I62ieXhHCtqcx+SxGDQBkoDSO1cS5T6MJztqxSd2roivmc0tK3WGSg6rEYpT5Efanq0gVOaPB8ezdFgu1GWtvRLGMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L7M1eC/t; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L7M1eC/t"
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782155903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gPNPMT9TSJEhy6qZReod/8w0NCSasDc9ygJVdzBjhcA=;
	b=L7M1eC/tQhsfkogbAfWbxHh4n6i7io1qusLL9I7Ds6F72VisiEwJtvxSDFLwm4wJGGwjhG
	cFY800yincQMboiqo4kf2/e01lYpBMlpJ1+xb+pYnakYWWk+/oDKJy0FMVaJJVv8kf+H1S
	KjhkVegjek4iJtWt0cdUZWKRulZgMb4=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: Sashiko reviews for pahole: missing custom_remotes
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
In-Reply-To: <ajWY48GyZXw0aMDx@x1>
Date: Mon, 22 Jun 2026 12:18:10 -0700
Cc: Alan Maguire <alan.maguire@oracle.com>, sashiko@lists.linux.dev,
 dwarves@vger.kernel.org
Message-Id: <02DBCD93-1189-4EFE-875D-25B22EF1657A@linux.dev>
References: <ajWY48GyZXw0aMDx@x1>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
X-Migadu-Flow: FLOW_OUT

Hi Arnaldo,

Sashiko is not really officially supporting a non-kernel code yet. It might w=
ork occasionally,
but I can=E2=80=99t guarantee anything and results might be pathetic.
We might explore adding support for more project going forward, but we=E2=80=
=99re not there yet.

Thanks

> On Jun 19, 2026, at 12:30=E2=80=AFPM, Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>=20
> =EF=BB=BFHi Roman,
>=20
>    The dwarves@vger.kernel.org mailing list is being tracked:
>=20
> https://sashiko.dev/#/?list=3Dorg.kernel.vger.dwarves
>=20
>    But all the patches for pahole are failing to apply, I think we
> need to have the second hunk applied, the first should be there as it is
> being tracked, can you please take a look and fix this?
>=20
> Thanks,
>=20
> - Arnaldo
>=20
> diff --git a/Settings.toml b/Settings.toml
> index 61978b51f89a0d86..666b4e8f1b7a76f3 100644
> --- a/Settings.toml
> +++ b/Settings.toml
> @@ -5,7 +5,7 @@ url =3D "sashiko.db"
> token =3D ""
>=20
> [mailing_lists]
> -track =3D ["linux-kernel"]
> +track =3D ["linux-kernel", "dwarves"]
>=20
> [nntp]
> server =3D "nntp.lore.kernel.org"
> @@ -104,6 +104,12 @@ port =3D 8080
> repository_path =3D "third_party/linux"
>=20
> # Track custom remotes and attempt to apply patches on their branches
> +[[git.custom_remotes]]
> +name =3D "pahole"
> +url =3D "git://git.kernel.org/pub/scm/devel/pahole/pahole.git"
> +check_all_branches =3D false
> +only_branches =3D ["next", "master"]
> +
> # [[git.custom_remotes]]
> # name =3D "remote-name"
> # url =3D "git://my-custom.com/remote"
