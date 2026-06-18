Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C3639C632;
	Thu, 18 Jun 2026 13:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781789238; cv=none; b=A8H6yadcH0656r5JSTv/uQ44qH3ayl87QCqLyG2t/he+H6ZOYuaPDTUq/qtX6X2hbR7yWfwi3g16zCL+y0115YHeV+ftDMAlf7xzQX/N4C0DM78+rxeC9DB5mGoFNR/+qg30U2MgrSyPNAX9FtxT1ON8SicMdS2zKwBYRaFIPeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781789238; c=relaxed/simple;
	bh=SaJtqV0AzwlEVl47xQ6E2Qi20F3bu8NjtqvkKeSOSHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjCAkCyzYPYzGxtoXOu5R0XSLWx4qznX/zB60p4mL1pt/np0wqC461EskI2z6nRYcq/9Z/leOpel8VXWs3lCiXesg4ahwYlQ8a4+F/g54cOPhJ8pqWX/VRrYFGsif08D5xYRHiACA6log7sW2JCzG4I17y2kKf+XNjTml8Hmm2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJgUZUHy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJgUZUHy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489751F00A3D;
	Thu, 18 Jun 2026 13:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781789236;
	bh=FESEJllRYY09nAjHr8rHQy/1qeYV8JGtImoKxrP/q4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EJgUZUHyf+tJY40qAYGBhf89IyKSjNaeDKI+L2ZXuqyW/tyId1shUJefbq9MJ6fWj
	 uazLD38YAnbizjUFzBLO4IHJUKYxzp3KvS9xaAZweqL+CFNMYugVwYkduSwqTZI1mL
	 3Uf4SZ6KJzxtYgRm0mNOnd7Vrp2aKRYiCh8L7eXX9Rh1JhoxNhaxODHsZRg5bxFCev
	 /5ZIVZAqUTCDLQ/dDV4Fk0xsClfiMaBC1jJqOOgl6H74qItxRqscfmJrT5tctiwkYM
	 ndhSnIFGgwp4a0KvHov4FFiqPv2Ufr3u9uftExLXKU1GW9dWeu39otV0FrgQqLlM9l
	 gZmiJyEZ7wx8w==
Date: Thu, 18 Jun 2026 10:27:14 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Vineet Gupta <vineet.gupta@linux.dev>, dwarves@vger.kernel.org,
	bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>, jose.marchesi@oracle.com,
	David Faust <david.faust@oracle.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PAHOLE v5 1/5] btf_loader: Handle decl tag component_idx for
 parameters
Message-ID: <ajPyMp4sz8-sms76@x1>
References: <20260618005731.273181-1-vineet.gupta@linux.dev>
 <20260618005731.273181-2-vineet.gupta@linux.dev>
 <DJBWI249TH74.C8BAB4SRRTXB@etsalapatis.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJBWI249TH74.C8BAB4SRRTXB@etsalapatis.com>

On Thu, Jun 18, 2026 at 12:46:50AM -0400, Emil Tsalapatis wrote:
> On Wed Jun 17, 2026 at 8:57 PM EDT, Vineet Gupta wrote:
> > From: Alan Maguire <alan.maguire@oracle.com>
> >
> > A BTF_KIND_DECL_TAG with a non-negative component_idx applies to a
> > specific function parameter (or struct/union member), not to the
> > function itself. btf_loader.c however attached every decl tag to the
> > type named by btf_type->type, so parameter decl tags were recorded on
> > the function rather than on the parameter, and pfunct never printed
> > them with the parameter.
> >
> > Resolve a non-negative component_idx to the corresponding parameter via
> > new helpers ftype__parameter()/function__parameter(), and attach the
> > tag there. Teach the pretty printer to emit a parameter's attributes by
> > factoring the function-level attribute loop into tag__attributes_fprintf()
> > and calling it from ftype__fprintf_parms() for each parameter.
> >
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
> 
> With one nit:
> 
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> 
> (Also feel free to keep the tags for the other 3 patches since the 
> changes are minimal).
> 
> </SNIP>
> 
> > +	if (component_idx >= 0) {
> > +		struct tag *func_tag = cu__function(cu, tp->type);
> > +
> > +		if (func_tag != NULL) {
> > +			tag = function__parameter(tag__function(func_tag), cu,
> > +						  component_idx);
> > +			if (tag == NULL) {
> > +				fprintf(stderr, "WARNING: BTF_KIND_DECL_TAG for unknown parameter %d in BTF id %d\n",
> > +					component_idx, tp->type);
> > +				return 0;
> > +			}
> > +		}
> > +	}
> > +
> > +	if (tag == NULL && component_idx < 0)
> >  		tag = cu__function(cu, tp->type);
> 
> Nit, I think this can be simplified as follows:
> 
> tag = cu__function(cu, tp->type);
> if (component_idx >= 0 && tag != NULL) {
> 	tag = function__parameter(tag__function(tag), cu, component_idx);
> 	if (tag == NULL) {
> 		fprintf(stderr, "WARNING: BTF_KIND_DECL_TAG for unknown parameter %d in BTF id %d\n",
> 			component_idx, tp->type);
> 		return 0;
> 	}
> }

Agreed, and with that:

Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
