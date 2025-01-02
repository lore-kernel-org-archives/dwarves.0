Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A740BC13D
	for <dwarves@vger.kernel.org>; Thu,  2 Jan 2025 23:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735860098; cv=none; b=hKZlS38XA+mQv/3tQdEnzgKf68mWgTmggI3VIWvI6Fmf/uJ1tHHZlSLzOvmwLMfpCBEBUd6FeLs96kGMRR3OimG3Pli1//sx2Hr0qwB2JuVa6qv+oY9a410xDaURAari4Dy3FuUpvv4YGeIgEvi49qz7VlhKndrmYETZ3jULIPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735860098; c=relaxed/simple;
	bh=Hszf4d8EbkshEM7qkgQ2N3EXfm5NOK/dTBsYo3FnPPg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uwrb4RfAc+PGit/kOP3gD9juWEAG0n5tD6Epzr9Vllp+teIIVYLq7y1TyLjVHKFnxzZTKEGMMFrtnZcZUsCTJS+KJxY3c6xjdHObJN0Ood1vRvChV9eKj2brUjcGEw8ImYAthpQ0KqT0j703G5gWRcoF4EyBGCASsTo/6F9v0xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=I2G5pnYf; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="I2G5pnYf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1735860081; x=1736119281;
	bh=Hszf4d8EbkshEM7qkgQ2N3EXfm5NOK/dTBsYo3FnPPg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=I2G5pnYfrmCXmcGQJiEiGLd7hqss4cAa86Bs6Xf1Sc4GKOu4yARef067CKALAM6xV
	 0sNbVnTzRVFEiPHoMszbSe8L6aefX9wLlEYlnySARxQq/COrNQ+Dli6eYpwNTMZ7w/
	 ZzcqGWZSXvELQ/YBUUyvqsjcI+N3nive/uHrMYBeY9PvORL2ixHHb5YqA+RkFe/tPZ
	 9Dx9JlRzm9ZFwdo8gXGriNwv3rPZJgfAs09it4PjheDPm6fN1TdMMXNkQZz/K3amnt
	 DT/zCV/EyhiRtjc+A0AeI6CPnee5O848Tt4yK6M1/gnl5bnO2yx13yjcJlYVRVenML
	 pYkj+GF7K/1lw==
Date: Thu, 02 Jan 2025 23:21:16 +0000
To: Arnaldo Carvalho de Melo <acme@kernel.org>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Alan Maguire <alan.maguire@oracle.com>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, dwarves@vger.kernel.org
Subject: Re: [PATCH 1/1] pfunct: Don't print functions twice when using -f
Message-ID: <pSXsKeRFQiU9meWBswxgbd5xph4-MORqQqpkutS0ywR3o90CG7umoIishI_WkHfFt2US_290bg023MV2MCn3abx9ytVoyLA95E_Dq8k6T2I=@pm.me>
In-Reply-To: <Z3L2I_7Dzob9W0fs@x1>
References: <Z3L2I_7Dzob9W0fs@x1>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 5728867e5556038277f825c4e497279136098b5a
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, December 30th, 2024 at 11:36 AM, Arnaldo Carvalho de Melo <acme@=
kernel.org> wrote:

>=20
>=20
> We print it in the pfunct_stealer, i.e. as soon as we load the CU
> containing the function information, and then, later, we were iterating
> all cus and printing the functions that matched.
>=20
> Do it just at the stealer.
>=20
> Cc: Alan Maguire alan.maguire@oracle.com
>=20
> Cc: Andrii Nakryiko andrii@kernel.org
>=20
> Cc: Eduard Zingerman eddyz87@gmail.com
>=20
> Cc: Ihor Solodrai ihor.solodrai@pm.me
>=20
> Cc: Mykola Lysenko mykolal@fb.com
>=20
> Link: https://lore.kernel.org/all/Z3LoTvt7PtUAbh5K@x1
> Signed-off-by: Arnaldo Carvalho de Melo acme@redhat.com

Can confirm this fixes double-printing of some functions when
running pfunct -F dwarf

Tested-by: Ihor Solodrai <ihor.solodrai@pm.me>

>=20
> ---
> pfunct.c | 11 ++++-------
> 1 file changed, 4 insertions(+), 7 deletions(-)
>=20
> diff --git a/pfunct.c b/pfunct.c
> index 55eafe8a8e790dcb..5a6dd59a1c7a30b1 100644
> --- a/pfunct.c
> +++ b/pfunct.c
> @@ -415,14 +415,12 @@ static void function__show(struct function *func, s=
truct cu *cu)
> fstats->printed =3D true;
>=20
> }
>=20
> -static int cu_function_iterator(struct cu *cu, void *cookie)
> +static int cu_function_iterator(struct cu *cu, void *cookie __maybe_unus=
ed)
> {
> struct function *function;
> uint32_t id;
>=20
> cu__for_each_function(cu, id, function) {
> - if (cookie && strcmp(function__name(function), cookie) !=3D 0)
> - continue;
> function__show(function, cu);
> }
> return 0;
> @@ -816,10 +814,9 @@ try_sole_arg_as_function_name:
> function__show(f, cu);
> } else if (show_total_inline_expansion_stats)
> print_total_inline_stats();
> - else if (function_name !=3D NULL || expand_types)
> - cus__for_each_cu(cus, cu_function_iterator,
> - function_name, NULL);
> - else
> + else if (expand_types)
> + cus__for_each_cu(cus, cu_function_iterator, NULL, NULL);
> + else if (function_name =3D=3D NULL)
> print_fn_stats(formatter);
>=20
> rc =3D EXIT_SUCCESS;
> --
> 2.46.2
