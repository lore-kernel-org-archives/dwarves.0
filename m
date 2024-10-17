Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E22D219CAF
	for <dwarves@vger.kernel.org>; Thu, 17 Oct 2024 20:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729196007; cv=none; b=KXbNhCQv4/TkUkZ0izkb34Idn7nDv3pMfljibN3WX8lyTOIWq6nyIxtJePmNDNDAeFBBuPsSzDa+cfbQUyra6GcjSKVx5cf7cwHuPoTebUThzVyI2rW5zB63XmQWrUW/8I3HOg8T6V7qI17OhJoM6LNRRVpBprfjYSIsxzB4atk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729196007; c=relaxed/simple;
	bh=mq0xSU1wbhIdQu7U9m0dWEgWSh/ymuimUZoLOPQEIkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aN88avXOrS8j0PPEpDMy0EiZEdCx3d3gfYO8mF9UxOMmd6Jnd/r6JzSCl5u24II1X9e0MKAZSkLlGB7Mem2Ao4lN9muZ1A+ZfH2BAKF5JB/zsGMF9CW7R0q/A0oo9ZrKX2tlzTBmxBQAbSg0bhHOA/gC+yRrKPeKyqgk1BW3ids=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orpeSLaF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orpeSLaF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D47C4CEC3;
	Thu, 17 Oct 2024 20:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729196006;
	bh=mq0xSU1wbhIdQu7U9m0dWEgWSh/ymuimUZoLOPQEIkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=orpeSLaFUdRzRv+ZwESeEni2vhio8IrspOPMPR+GkLqKV3QnHW8Pi7AhBDzkigXjx
	 BOcPuNSSigFQ8Rr/CMgEN9t/WTETDfhdu0hWIu8Kd8M83IdQfLhNz1V4S0QM5asjLC
	 FI9W3oyEWNSsGoPka9NZTmLEQpzdHhMS2+VvVG2Sr58xQr0D9kfThsMBVIX0pOnVzF
	 6hXNhJGRbvMpnp9GgqIbDgVTGGNY80bYQukwkwDMuBH0FhfpvcAnmshB7KSzlHcZNB
	 owOWmqQmsT+/qBGmL0xsdHVRVU3hw8Y54JXm3tzQaelrx8bK8V7hu8CbqteB5luj2u
	 atmnZdPNUIeYQ==
Date: Thu, 17 Oct 2024 17:13:23 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Ihor Solodrai <ihor.solodrai@pm.me>, dwarves@vger.kernel.org,
	andrii@kernel.org, eddyz87@gmail.com
Subject: Re: [PATCH v3 dwarves 3/5] btf_encoder: collect elf_functions in
 btf_encoder__pre_load_module
Message-ID: <ZxFv46O6UPnqbzGF@x1>
References: <20241016001025.857970-1-ihor.solodrai@pm.me>
 <20241016001025.857970-4-ihor.solodrai@pm.me>
 <05bd8cbb-9e6d-479a-abf6-51e7eb5e67f7@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05bd8cbb-9e6d-479a-abf6-51e7eb5e67f7@oracle.com>

On Thu, Oct 17, 2024 at 11:56:04AM +0100, Alan Maguire wrote:
> On 16/10/2024 01:10, Ihor Solodrai wrote:
> > Introduce a global elf_functions_list variable in btf_encoder.c that
> > contains an elf_functions per ELF.
> >
> 
> Arnaldo can help provide context here, but at least notionally I think
> the idea of maintaining libdwarves as a library has value. In that

Yeah, but in all these years I'm not aware of any user, I even need to
do some testing on building pahole statically with libdwarves to see if
we get performance improvements...

> context, avoiding global lists where possible is a good thing I think,

Even without a library :-)

> since if it was used as a library, multiple invokations could confuse
> the elf_functions list. To that end, can we make the elf_functions_list
> a field in the conf_load perhaps? It already contains base_btf so there

conf_load looks with the structs we have now, so I would try to start
there.

- Arnaldo

> is a precedent for storing data relevant to all encoders there, and
> btf_encoder__new() has conf_load as a parameter, so the elf functions
> list can still always be retrieved on encoder creation. In addition the
> parameter to cus__process_dwflmod() has the parms structure which
> contains the conf_load; you'd just need to pass that through to your
> pre_load_module() callback I think.
> 
> It shouldn't be a massive change but I think it would be worthwhile.
> 
> Thanks!
> 
> > An elf_functions structure is allocated and filled out by
> > btf_encoder__pre_load_module() hook, and the list is cleared after
> > btf_encoder__encode() is done.
> > 
> > At this point btf_encoders don't use shared elf_functions yet (each
> > maintains their own copy as before), but it is built before encoders
> > are initialized.
> > 
> > Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
> > ---
> >  btf_encoder.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  btf_encoder.h |  2 ++
> >  pahole.c      |  3 +++
> >  3 files changed, 71 insertions(+)
> > 
> > diff --git a/btf_encoder.c b/btf_encoder.c
> > index 9c840fa..8e8fd05 100644
> > --- a/btf_encoder.c
> > +++ b/btf_encoder.c
> > @@ -103,6 +103,8 @@ struct elf_secinfo {
> >  };
> >  
> >  struct elf_functions {
> > +	struct list_head node; /* for elf_functions_list */
> > +	Elf *elf; /* source ELF */
> >  	struct elf_symtab *symtab;
> >  	struct elf_function *entries;
> >  	int cnt;
> > @@ -147,6 +149,67 @@ struct btf_kfunc_set_range {
> >  	uint64_t end;
> >  };
> >  
> > +
> > +/* In principle, multiple ELFs can be processed in one pahole run,
> > + * so we have to store elf_functions table per ELF.
> > + * An element is added to the list on btf_encoder__pre_load_module,
> > + * and removed after btf_encoder__encode is done.
> > + */
> > +static LIST_HEAD(elf_functions_list);
> > +
> > +static inline void elf_functions__delete(struct elf_functions *funcs)
> > +{
> > +	free(funcs->entries);
> > +	elf_symtab__delete(funcs->symtab);
> > +	list_del(&funcs->node);
> > +	free(funcs);
> > +}
> > +
> > +static inline void elf_functions__delete_all(void)
> > +{
> > +	struct list_head *pos, *tmp;
> > +
> > +	list_for_each_safe(pos, tmp, &elf_functions_list) {
> > +		struct elf_functions *funcs = list_entry(pos, struct elf_functions, node);
> > +
> > +		elf_functions__delete(funcs);
> > +	}
> > +}
> > +
> > +static int elf_functions__collect(struct elf_functions *functions);
> > +
> > +int btf_encoder__pre_load_module(Dwfl_Module *mod, Elf *elf)
> > +{
> > +	struct elf_functions *funcs;
> > +	int err;
> > +
> > +	funcs = calloc(1, sizeof(*funcs));
> > +	if (!funcs) {
> > +		err = -ENOMEM;
> > +		goto out_delete;
> > +	}
> > +
> > +	funcs->symtab = elf_symtab__new(NULL, elf);
> > +	if (!funcs->symtab) {
> > +		err = -1;
> > +		goto out_delete;
> > +	}
> > +
> > +	funcs->elf = elf;
> > +	err = elf_functions__collect(funcs);
> > +	if (err)
> > +		goto out_delete;
> > +
> > +	list_add_tail(&funcs->node, &elf_functions_list);
> > +
> > +	return 0;
> > +
> > +out_delete:
> > +	elf_functions__delete(funcs);
> > +	return err;
> > +}
> > +
> > +
> >  static LIST_HEAD(encoders);
> >  static pthread_mutex_t encoders__lock = PTHREAD_MUTEX_INITIALIZER;
> >  
> > @@ -2071,6 +2134,8 @@ int btf_encoder__encode(struct btf_encoder *encoder)
> >  #endif
> >  		err = btf_encoder__write_elf(encoder, encoder->btf, BTF_ELF_SEC);
> >  	}
> > +
> > +	elf_functions__delete_all();
> >  	return err;
> >  }
> >  
> > @@ -2387,6 +2452,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
> >  			goto out;
> >  		}
> >  		encoder->functions.symtab = encoder->symtab;
> > +		encoder->functions.elf = cu->elf;
> >  
> >  		/* index the ELF sections for later lookup */
> >  
> > diff --git a/btf_encoder.h b/btf_encoder.h
> > index 824963b..7debd67 100644
> > --- a/btf_encoder.h
> > +++ b/btf_encoder.h
> > @@ -34,4 +34,6 @@ struct btf *btf_encoder__btf(struct btf_encoder *encoder);
> >  
> >  int btf_encoder__add_encoder(struct btf_encoder *encoder, struct btf_encoder *other);
> >  
> > +int btf_encoder__pre_load_module(Dwfl_Module *mod, Elf *elf);
> > +
> >  #endif /* _BTF_ENCODER_H_ */
> > diff --git a/pahole.c b/pahole.c
> > index b9e97ef..891af3a 100644
> > --- a/pahole.c
> > +++ b/pahole.c
> > @@ -3814,6 +3814,9 @@ int main(int argc, char *argv[])
> >  		conf_load.threads_collect = pahole_threads_collect;
> >  	}
> >  
> > +	if (btf_encode)
> > +		conf_load.pre_load_module = btf_encoder__pre_load_module;
> > +
> >  	// Make 'pahole --header type < file' a shorter form of 'pahole -C type --count 1 < file'
> >  	if (conf.header_type && !class_name && prettify_input) {
> >  		conf.count = 1;
