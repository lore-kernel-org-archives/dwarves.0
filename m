Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AD539AEB
	for <dwarves@vger.kernel.org>; Thu,  9 Jan 2025 16:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736438525; cv=none; b=RrtklhV927Oy6ZxQXiCbsFxGybU7zK9KneASu3NWvwbdH+AE54uBv03YD/HWJreZ42AIelXpXytXAmaDCiP5TBq7h6iDWw0b/FkYaPx5pOcpmgLyNvzd3OkFHvEhUpoOQlV6SllsE/uqK2TMoI354ZujXysvBAZysziT5hozXHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736438525; c=relaxed/simple;
	bh=FZc93scrpjUfkxD4/ZDkKTT9PK2CO4OGAlRJNOVqyy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mb9PelTW9b+9VgvpBoeP+9dmXeRpd71TV5R02gB1mhvbFX7z4MP3vOyVIAjX/7tWDDbeDYDu0x1DLeROTc8y3S4ZDPNBTF6V3MMIqidJHYr5BjDoK8jhJzNnjmE14xO8wu8E5rGH3ephDBOe/Muzhn92rBwRQc7Tx45i2bMCRLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNOu7I5v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNOu7I5v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A9EC4CED2;
	Thu,  9 Jan 2025 16:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736438525;
	bh=FZc93scrpjUfkxD4/ZDkKTT9PK2CO4OGAlRJNOVqyy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HNOu7I5vJ54Gi4X5W7jsdkU9hcbL+5zjYYeNe7lWD+pnzqsyjhnAJHwlGwm+a6Zk6
	 JYbGm59mO1W2yLYaeePA6baVoV2OnwWtPVJUvRNKcsBsaPHW1natvpsk5EUa7ANRjg
	 cjhKppqC5s2ynalBkbSjQJXAZ5FStHvhD1jMH5NYk6Cfui+bgEt/6GZH9NUFias+W9
	 a7032y5q+wbJGT+ukXbEMhfLbXhgWdoyxrBQhaEAnigeHm1kunaoG2DimmpJLLfNGy
	 ZC7FlI7gwwxK7q9qHcjYcjEB72a1QwuQth22CS68owqu+sBZW6GPt06AC9DC9uZuSR
	 ya9uT/CXXuFxA==
Date: Thu, 9 Jan 2025 13:02:02 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>, dwarves@vger.kernel.org
Subject: Re: [PATCH 1/1] pfunct: Don't print functions twice when using -f
Message-ID: <Z3_y-pCUnFKKwNWe@x1>
References: <Z3L2I_7Dzob9W0fs@x1>
 <pSXsKeRFQiU9meWBswxgbd5xph4-MORqQqpkutS0ywR3o90CG7umoIishI_WkHfFt2US_290bg023MV2MCn3abx9ytVoyLA95E_Dq8k6T2I=@pm.me>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pSXsKeRFQiU9meWBswxgbd5xph4-MORqQqpkutS0ywR3o90CG7umoIishI_WkHfFt2US_290bg023MV2MCn3abx9ytVoyLA95E_Dq8k6T2I=@pm.me>

On Thu, Jan 02, 2025 at 11:21:16PM +0000, Ihor Solodrai wrote:
> On Monday, December 30th, 2024 at 11:36 AM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> 
> > 
> > 
> > We print it in the pfunct_stealer, i.e. as soon as we load the CU
> > containing the function information, and then, later, we were iterating
> > all cus and printing the functions that matched.
> > 
> > Do it just at the stealer.
> > 
> > Cc: Alan Maguire alan.maguire@oracle.com
> > 
> > Cc: Andrii Nakryiko andrii@kernel.org
> > 
> > Cc: Eduard Zingerman eddyz87@gmail.com
> > 
> > Cc: Ihor Solodrai ihor.solodrai@pm.me
> > 
> > Cc: Mykola Lysenko mykolal@fb.com
> > 
> > Link: https://lore.kernel.org/all/Z3LoTvt7PtUAbh5K@x1
> > Signed-off-by: Arnaldo Carvalho de Melo acme@redhat.com
> 
> Can confirm this fixes double-printing of some functions when
> running pfunct -F dwarf
> 
> Tested-by: Ihor Solodrai <ihor.solodrai@pm.me>

Thanks, added to the cset.

- Arnaldo
 
> > 
> > ---
> > pfunct.c | 11 ++++-------
> > 1 file changed, 4 insertions(+), 7 deletions(-)
> > 
> > diff --git a/pfunct.c b/pfunct.c
> > index 55eafe8a8e790dcb..5a6dd59a1c7a30b1 100644
> > --- a/pfunct.c
> > +++ b/pfunct.c
> > @@ -415,14 +415,12 @@ static void function__show(struct function *func, struct cu *cu)
> > fstats->printed = true;
> > 
> > }
> > 
> > -static int cu_function_iterator(struct cu *cu, void *cookie)
> > +static int cu_function_iterator(struct cu *cu, void *cookie __maybe_unused)
> > {
> > struct function *function;
> > uint32_t id;
> > 
> > cu__for_each_function(cu, id, function) {
> > - if (cookie && strcmp(function__name(function), cookie) != 0)
> > - continue;
> > function__show(function, cu);
> > }
> > return 0;
> > @@ -816,10 +814,9 @@ try_sole_arg_as_function_name:
> > function__show(f, cu);
> > } else if (show_total_inline_expansion_stats)
> > print_total_inline_stats();
> > - else if (function_name != NULL || expand_types)
> > - cus__for_each_cu(cus, cu_function_iterator,
> > - function_name, NULL);
> > - else
> > + else if (expand_types)
> > + cus__for_each_cu(cus, cu_function_iterator, NULL, NULL);
> > + else if (function_name == NULL)
> > print_fn_stats(formatter);
> > 
> > rc = EXIT_SUCCESS;
> > --
> > 2.46.2
