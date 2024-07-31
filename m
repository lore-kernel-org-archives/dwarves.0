Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A801DA32;
	Wed, 31 Jul 2024 13:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722432411; cv=none; b=qWy53TNW+OfuOVPTgtUm0WRktF4VJkua+JaBsg/B7ePMULvkJV2DuEgWN5K6RvPv0VhpUoVLgYK9RKfOD9d3I12sQ7KzRyYWY2+7tNoDUN58S7/RItnlQ1demrhLONwnigYBOxHfDKWr4ob0hyEEfS8YsXGZsOfQCG9qaTd7wnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722432411; c=relaxed/simple;
	bh=9uXypEqxAUTLJyGDeqcsSj54KvBpMVmlCUOaJvrDkBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvvNf+fygg0yxI6HKSfDPWUOKVzdUUZSZ1wvvp615JwzHEuowCTYWa6QJ9oZ6tXKUCJSqYJ7pHVyg7cGYEvx+tnKdYWoOem82tiKzv63Og7c+EqKZ7CxMy0Dn7w58gXjPdbiNiW4qM0+H4umZqxIgYTMGJukpwiH0de1nuPwEJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMyFmVs5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMyFmVs5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5478EC116B1;
	Wed, 31 Jul 2024 13:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722432411;
	bh=9uXypEqxAUTLJyGDeqcsSj54KvBpMVmlCUOaJvrDkBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RMyFmVs5x8U3C6fjpFKKApHqaSeEcLs7xyhhm0+Ws6NHDm6Kx/pd1+Up0k2qdFfV5
	 +WAuWHJNzEX+/A/RUyGoAb6H+QhcBrWrytdTiWbx0HUmRcgsx+nk2tiQF16pa0IyhD
	 5DXvbPUEGXviSHhAEigCpN7sceJZO7nDfxWkVLuIMXkPmFfS59QFmGRq5byVgI8Mkl
	 K4ZeIldb0JP2Qw2G/8I3ZaXq2WDJ/g7oOGsPDKQrZywjcfLHKE2MBP4Jn/lpZrfN0I
	 uj9NBheWjPGFUpvLD3n1rTeY4hvvXZjtfzQYgMCzHVqpIY0L+6pLiSm5C21dcZFtRq
	 5Mes+gb5sTHDQ==
Date: Wed, 31 Jul 2024 10:26:49 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Matthew Maurer <mmaurer@google.com>, rust-for-linux@vger.kernel.org,
	dwarves@vger.kernel.org, aliceryhl@google.com
Subject: Re: [PATCH] pahole: Apply CU-level filters early in loading
Message-ID: <Zqo7mW3brA09hA8b@x1>
References: <20240730224350.4039790-1-mmaurer@google.com>
 <0c0031f6-7f5b-4ec2-9804-c9d576c8302b@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c0031f6-7f5b-4ec2-9804-c9d576c8302b@oracle.com>

On Wed, Jul 31, 2024 at 09:57:25AM +0100, Alan Maguire wrote:
> On 30/07/2024 23:43, Matthew Maurer wrote:
> > Without this, even with `--lang_exclude=rust` set, running on `vmlinux`
> > with `CONFIG_RUST` enabled will lead to errors like:
> > die__process_function: tag not supported 0x2f (template_type_parameter)!
> > because the filtering doesn't happen until finalization, but unsupported
> > tags are reported during loading.
> > 
> > As an added bonus, this should speed up processing of large objects with
> > filtered CUs, as their details will no longer be walked.
> >
> 
> One question on this; if we are always doing early filtering like this,
> should the explicit cu__filter() call be removed from pahole_stealer()?

When I saw the introduction of an extra callback to be used inside the
dwarf_loader I thought that it would be used only for this specific
language filtering feature, i.e. a defensive approach at implementing
this to avoid unintended side effects of doing all filtering at that
point, maybe some other feature somehow depends on the cu__filter()
being called where it was so far.

But then it is being used for all filtering, so it seems just a way to
reduce the patch size...

So I'd keep the cu->early_cu_filter() but would use it only for the
language filtering feature, wdyt?

- Arnaldo
 
> > Signed-off-by: Matthew Maurer <mmaurer@google.com>
> > ---
> >  dwarf_loader.c | 10 ++++++++++
> >  dwarves.h      |  1 +
> >  pahole.c       |  1 +
> >  3 files changed, 12 insertions(+)
> > 
> > diff --git a/dwarf_loader.c b/dwarf_loader.c
> > index b832c93..c48dfef 100644
> > --- a/dwarf_loader.c
> > +++ b/dwarf_loader.c
> > @@ -2854,6 +2854,16 @@ static int die__process(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
> >  
> >  	cu->language = attr_numeric(die, DW_AT_language);
> >  
> > +	if (conf->early_cu_filter)
> > +		cu = (conf->early_cu_filter)(cu);

Also we can have it more compactly as:

+	if (conf->early_cu_filter)
+		cu = conf->early_cu_filter(cu);

No?

> > +
> > +	/*
> > +	 * If we filtered this CU out, we still want to keep iterating, but
> > +	 * there's no need to walk the rest of the CU info.
> > +	 */
> > +	if (cu == NULL)
> > +		return DWARF_CB_OK;
> > +
> >  	if (dwarf_child(die, &child) == 0) {
> >  		int err = die__process_unit(&child, cu, conf);
> >  		if (err)
> > diff --git a/dwarves.h b/dwarves.h
> > index f5ae79f..92d102b 100644
> > --- a/dwarves.h
> > +++ b/dwarves.h
> > @@ -72,6 +72,7 @@ struct conf_load {
> >  	enum load_steal_kind	(*steal)(struct cu *cu,
> >  					 struct conf_load *conf,
> >  					 void *thr_data);
> > +	struct cu *		(*early_cu_filter)(struct cu *cu);
> >  	int			(*thread_exit)(struct conf_load *conf, void *thr_data);
> >  	void			*cookie;
> >  	char			*format_path;
> > diff --git a/pahole.c b/pahole.c
> > index 954498d..937b0a1 100644
> > --- a/pahole.c
> > +++ b/pahole.c
> > @@ -3765,6 +3765,7 @@ int main(int argc, char *argv[])
> >  	memset(tab, ' ', sizeof(tab) - 1);
> >  
> >  	conf_load.steal = pahole_stealer;
> > +	conf_load.early_cu_filter = cu__filter;
> >  	conf_load.thread_exit = pahole_thread_exit;
> >  
> >  	if (conf_load.reproducible_build) {
