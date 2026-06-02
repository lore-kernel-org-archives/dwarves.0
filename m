Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4768937C0E3;
	Tue,  2 Jun 2026 18:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424092; cv=none; b=oVEwoVF2E3zWVgDdCtBjNTaqGV0UBeZwmUFN2mB1R/vSDWLTCZrJp/a6MjfkwtyBvv+XgItEBms8EavGRJ1NW03Q4KMXE1bWhp5DxnP072G5K/tkxHmTUT+XVUR9h4vVhnfbid+rw1Bxfi+OXso24ZCnKO8r20zEqV63tEBqSjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424092; c=relaxed/simple;
	bh=YmWRG+cDTWhJ5SCI3D0fI4vPJ7luNXKxUaLyWZgh+jQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgC0mNYlQSHZbc6ijkx361pT3io8oMHXCgZHs/9rTfPCBIFKC6CkiNhtzRaVMbNZBrWsMytbxPIZEvAYfnxF+vrJjnU4ysGi+ryAV0Li7gTAgJiLm2yhhwx/LVGEhiyRz+LNwsebRHy1KXiPVQ8RSE/u+MMSA9IoV2uf0fMBD9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0AR5yja; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0AR5yja"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45AAE1F00893;
	Tue,  2 Jun 2026 18:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780424090;
	bh=TUN7lnLd/zH7x+2mD9IYGErZQ43x0pjC/KUS+ntYZ4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D0AR5yjajMxOITtIPL56Cu4gDLqbZ3PDv9euXpcspGhcfgrr4PcJz8zjyxwIuRq1p
	 Zh+FbLWRBv+idy1oY7j+3xxjmbsfeS2L7HJDheRflLzyncqME6/Ph2RKzeTTNRG5SL
	 osY/ET2Fz6Xl5llv8rvPmoJmkHiXQzuzgedPQTzoXr9/rcjIZ+WW/jhkayBxxFNyMq
	 FgRM1EjbRsFyMPE3qqWHtjnWYjvfqm/9hPrLUuSVsu2n0AwVnTxY2bNMihjbKVQyku
	 BfyCN32bT38kgx3qObYcWil4e3hCbb8tTq1SZqi8OyBSteM0mx78QfklnjQ5nb5Eit
	 14DBzQxoxxLWA==
Date: Tue, 2 Jun 2026 15:14:47 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Vineet Gupta <vineet.gupta@linux.dev>, dwarves@vger.kernel.org,
	bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>, jose.marchesi@oracle.com,
	David Faust <david.faust@oracle.com>
Subject: Re: [PAHOLE v3 1/3] dwarf_loader: Extract die__add_btf_type_tag()
 helper
Message-ID: <ah8dl-yaSPm64GhP@x1>
References: <20260601183511.594100-1-vineet.gupta@linux.dev>
 <DIXYL7ZGEO7C.3HN24VDJYZQOR@etsalapatis.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DIXYL7ZGEO7C.3HN24VDJYZQOR@etsalapatis.com>

On Mon, Jun 01, 2026 at 03:27:41PM -0400, Emil Tsalapatis wrote:
> On Mon Jun 1, 2026 at 2:35 PM EDT, Vineet Gupta wrote:
> > NFC change preparing for DW_TAG_GNU_annotation support.
> > Extract the btf_type_tag annotation creation logic from into a helper
> > die__add_btf_type_tag().
> >
> > Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
> > ---
> > Changes since v2 [2]
> >  - die__add_btf_type_tag() returns pointer not error code.
> >
> > Changes since v1 [1]
> >  - NFC reinstate some original comments
> 
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
 
> Minor nit/question below.

Some more nits below :-)
 
> > +++ b/dwarf_loader.c
> > @@ -1600,14 +1600,43 @@ static struct btf_type_tag_type *die__create_new_btf_type_tag_type(Dwarf_Die *di
> >  	return tag;
> >  }
> >  
> > +static struct btf_type_tag_ptr_type *die__add_btf_type_tag(struct btf_type_tag_ptr_type *tag,
> > +							    Dwarf_Die *die, Dwarf_Die *adie,
> > +							    struct cu *cu, struct conf_load *conf)
> > +{
> > +	struct btf_type_tag_type *annot;
> > +	uint32_t id;
> > +
> > +	if (tag == NULL) {
> > +		tag = die__create_new_btf_type_tag_ptr_type(die, cu);
> > +		if (!tag)
> > +			return NULL;

There was an inconsistency on the code you moved here, namely first tag
is tested against NULL then it is negated, equivalent, but since we're
moving it, lets make it consistent, in the kernel it is most common to
use !ptr as it is more compact, so please make the first test !tag, just
like the second.

> > +	}
> > +
> > +	annot = die__create_new_btf_type_tag_type(adie, cu, conf);
> > +	if (annot == NULL)
> > +		return NULL;
> > +
> > +	if (cu__table_add_tag(cu, &annot->tag, &id) < 0)
> > +		return NULL;
> > +
> > +	struct dwarf_tag *dtag = tag__dwarf(&annot->tag);
> > +	dtag->small_id = id;
> > +	cu__hash(cu, &annot->tag);
> > +
> > +	/* Prepends: for annotations tag1 -> tag2 -> tag3,
 
> Not familiar with pahole's coding style, do we want to adjust the
> comments?

Not that important, but we try to follow kernel style, so yeah that
would be:

	/*
	 * Prepends: for annotations tag1 -> tag2 -> tag3,

But by now I don't dwell that much on these minor details :)

> > +	 * the tag->tags list ends up as tag3 -> tag2 -> tag1.
> > +	 */
> > +	list_add(&annot->node, &tag->tags);
> > +	return tag;
> > +}
> > +
> >  static struct tag *die__create_new_pointer_tag(Dwarf_Die *die, struct cu *cu,
> >  					       struct conf_load *conf)
> >  {
> >  	struct btf_type_tag_ptr_type *tag = NULL;
> > -	struct btf_type_tag_type *annot;
> >  	Dwarf_Die *cdie, child;
> >  	const char *name;
> > -	uint32_t id;
> >  
> >  	/* If no child tags or skipping btf_type_tag encoding, just create a new tag
> >  	 * and return
> > @@ -1627,29 +1656,9 @@ static struct tag *die__create_new_pointer_tag(Dwarf_Die *die, struct cu *cu,
> >  		if (strcmp(name, "btf_type_tag") != 0)
> >  			continue;
> >  
> > -		if (tag == NULL) {
> > -			/* Create a btf_type_tag_ptr type. */
> > -			tag = die__create_new_btf_type_tag_ptr_type(die, cu);
> > -			if (!tag)
> > -				return NULL;
> > -		}
> > -
> > -		/* Create a btf_type_tag type for this annotation. */
> > -		annot = die__create_new_btf_type_tag_type(cdie, cu, conf);
> > -		if (annot == NULL)
> > -			return NULL;
> > -
> > -		if (cu__table_add_tag(cu, &annot->tag, &id) < 0)
> > +		tag = die__add_btf_type_tag(tag, die, cdie, cu, conf);
> > +		if (tag == NULL)
> >  			return NULL;
> > -
> > -		struct dwarf_tag *dtag = tag__dwarf(&annot->tag);
> > -		dtag->small_id = id;
> > -		cu__hash(cu, &annot->tag);
> > -
> > -		/* For a list of DW_TAG_LLVM_annotation like tag1 -> tag2 -> tag3,
> > -		 * the tag->tags contains tag3 -> tag2 -> tag1.
> > -		 */
> > -		list_add(&annot->node, &tag->tags);
> >  	} while (dwarf_siblingof(cdie, cdie) == 0);
> >  
> >  	return tag ? &tag->tag : tag__new(die, cu);
