Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED873E3DB3
	for <dwarves@vger.kernel.org>; Mon, 30 Mar 2026 22:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774910388; cv=none; b=SRIq11YD8BLuxk/ZQvSCGyTjPZ2Zej+AEM5nug8SzFEIkavPvY9DdTZNNi0LDd1xM2Pw/e5xxnN2U6gXM2fmioXv84vUG97dwtkthf2RYHs7ihwjk1qv9MvD+VccBTUgD7VJXUv3zpRuLrehiNEGUIddHWyZtr3DCZ/BowyoVJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774910388; c=relaxed/simple;
	bh=vTYC52JVOJksADFJ/jMv4RBIGDfRTcygY5cDKw8Ptp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwJAKGjOkKiBNcGArn4/kz0HSBzclmWetCWPjaKqg6aMcVCnMIq/z4NK/rJkE7yYBA2WXuDJ/g6Z+6rFjGfF4c95xH5OJUzJR245a4IWKxO5P6/IX5NUPHAhozWVLmCgHusHCwaOTDpGGFolzaBWSnI7CY8cvQ2mOp/9R+1/9xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ic1xsZIO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ic1xsZIO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2442C4CEF7;
	Mon, 30 Mar 2026 22:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774910387;
	bh=vTYC52JVOJksADFJ/jMv4RBIGDfRTcygY5cDKw8Ptp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ic1xsZIO1onaHLJe0QYhVNWSY1B5PbJaQ2sT6jxNs1qrr9IGCWbSFMwQQjBQKcIrh
	 EqsBszDKK6UALvWhwhN0mb6SRwOmxJ+GnVmFIGITYq3PODQQ8AoWwTNsRIkwbLaFZl
	 mlEpMasAfaZPJeETzFil4mNr8TS9PR8IX9GAdmfn45b3RKHVXyufYktzXYDBIiadap
	 Np1l/1uRqF+tP6fgmPeSxKdtKl+uKxwM/4GuryG9rm+0fs75gq0FhQ9pyJo0bHv5MV
	 pRICoREyRPAA9BHUHHI3I9TthfDEsTOae3uGMlWcsqRVbd9rn4+rSwugN/fhGc7t5K
	 7sya3mKRf+4pw==
Date: Mon, 30 Mar 2026 19:39:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>, dwarves@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH 2/3] dwarf_loader: Initial support for DW_TAG_subprogram
 in DW_TAG_enumeration
Message-ID: <acr7r1IoGSaBuLF9@x1>
References: <20260323211533.1909029-1-acme@kernel.org>
 <20260323211533.1909029-3-acme@kernel.org>
 <741f21ad-5b95-4028-9f0f-4818f00428ef@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <741f21ad-5b95-4028-9f0f-4818f00428ef@oracle.com>

On Mon, Mar 30, 2026 at 10:05:26AM +0100, Alan Maguire wrote:
> On 23/03/2026 21:15, Arnaldo Carvalho de Melo wrote:
> > In Rust enums can have subprograms, add initial support for it.
 
> I guess we'd need some form of enhanced enumerator kind to support this in BTF,
> since I don't see any means to enhance the existing enumerator kind info to
> support references to other type ids like functions.

Right, the internal representation for the DWARF tags should cover all
languages aspects, be it Rust, C, C++, Go, etc.

But BTF is about being compact, so no forward thinking about supporting
other languages, Like Rust, that is for DWARF, that ends up being not
compact.

I think the best we can do at this point is to support as many aspects
of Rust as can be encoded in BTF and that may end up being enough for a
subset of Rust to be used to generate BTF bytecode CO-RE able.

I'll do some more work on checking how much of Rust we can encode in BTF
as it is possible right now.

Also I want to have a way to output rust code from DWARF/BTF/whatever,
as we have now for C and C++ in pahole :-)

- Arnaldo

> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> 
> > ---
> >  dwarf_loader.c | 38 ++++++++++++++++++++++++++++++--------
> >  1 file changed, 30 insertions(+), 8 deletions(-)
> > 
> > diff --git a/dwarf_loader.c b/dwarf_loader.c
> > index f0833e8c44a944a8..b5a92160ecf82f74 100644
> > --- a/dwarf_loader.c
> > +++ b/dwarf_loader.c
> > @@ -1943,6 +1943,8 @@ out_delete:
> >  	return NULL;
> >  }
> >  
> > +static struct tag *die__create_new_function(Dwarf_Die *die, struct cu *cu, struct conf_load *conf);
> > +
> >  static struct tag *die__create_new_enumeration(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
> >  {
> >  	Dwarf_Die child;
> > @@ -1964,18 +1966,38 @@ static struct tag *die__create_new_enumeration(Dwarf_Die *die, struct cu *cu, st
> >  
> >  	die = &child;
> >  	do {
> > -		struct enumerator *enumerator;
> > +		switch (dwarf_tag(die)) {
> > +		case DW_TAG_enumerator: {
> > +			struct enumerator *enumerator = enumerator__new(die, cu, conf);
> > +
> > +			if (enumerator == NULL)
> > +				goto out_delete;
> > +
> > +			enumeration__add(enumeration, enumerator);
> > +			cu__hash(cu, &enumerator->tag);
> > +		}
> > +			continue;
> > +		case DW_TAG_subprogram: {
> > +			struct tag *tag = die__create_new_function(die, cu, conf);
> > +			uint32_t id;
> > +
> > +			if (tag == NULL)
> > +				goto out_delete;
> >  
> > -		if (dwarf_tag(die) != DW_TAG_enumerator) {
> > +			if (cu__add_tag(cu, tag, &id) < 0) {
> > +				tag__delete(tag, cu);
> > +				goto out_delete;
> > +			}
> > +
> > +			cu__hash(cu, tag);
> > +			struct dwarf_tag *dtag = tag__dwarf(tag);
> > +			dtag->small_id = id;
> > +			break;
> > +		}
> > +		default:
> >  			cu__tag_not_handled(cu, die);
> >  			continue;
> >  		}
> > -		enumerator = enumerator__new(die, cu, conf);
> > -		if (enumerator == NULL)
> > -			goto out_delete;
> > -
> > -		enumeration__add(enumeration, enumerator);
> > -		cu__hash(cu, &enumerator->tag);
> >  	} while (dwarf_siblingof(die, die) == 0);
> >  out:
> >  	return &enumeration->namespace.tag;
