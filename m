Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AB318A6A8
	for <dwarves@vger.kernel.org>; Mon,  9 Sep 2024 20:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725912111; cv=none; b=eXdZNHSUHMWT4xwbd2J9fhy2lC0LN3IlSOfXUkJs/jqVmm40tBG+EOvEGd0ma0KNHi3raN0hN7estYedVVDOh5f5GR0mHsD4POPBLda1X45xkJcxQIjzmLu9XJPnw2B9gXN9GhgS91pqSF5YoAsgI3117rPhXipOJVonErMY5VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725912111; c=relaxed/simple;
	bh=agXfx/tAN0OY4rKPbEJqhnjph0z94Y3TFd+cMXTEEzU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GTIgM1qiZtGlHz6hJ7R93elY00gFG3a5RUagUfmTMKSkB204W91qnbaaFnnHIjXCnsYumDjcrc1pYH/7p43B1doV1CmWCuzcFqN2fQrYCMeZ+XHX8pSVcCMwvv3/ozIBguxEbG9vkexv3+yscr6+ziSR5M8ZHNdkc7mrGwFGUiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQXpgR0+; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQXpgR0+"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so20448505e9.0
        for <dwarves@vger.kernel.org>; Mon, 09 Sep 2024 13:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725912108; x=1726516908; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xrlFySLOdoI5c8/JMlo4t7JTfO0PN75okz4JLX/txqk=;
        b=aQXpgR0+nuaGJW1NTXhgvlByFmRc2vDBLfOg6Yqqi/hElDIzwTE/qm8MVUhl0Bw3+y
         sGoVm+KeZ9idrEke9aN/H3OPeGYexhyzLgAZIsDY3LWLHEI4e0kF1bv6Y+Vi7sbYqDDD
         qDNEr0a2omLYJnHxALd99D6sc/OGqPG7UbhDCCwFOO9dVZozTSk4sSlQLgTOQPQG7KZc
         Ly52TZT5FC10u5PWJLwJdJr2SZ1y/Oz3Ylr4fLvyz68D5tMcAQZG2RYffqB65B1IU1El
         MXnZ+U6AYkQbkbrXzzWodzX7RuL8kHsUoxyozdOTG+8S7Amgj+ic5vlamN/Bda2HIn4s
         9kkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725912108; x=1726516908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xrlFySLOdoI5c8/JMlo4t7JTfO0PN75okz4JLX/txqk=;
        b=tffd3f63rDzZfUtEtVCxjxTBP+8WgE58oLo9uhDZC7PlM9FZUmt1xtvfVcy5P+SII8
         k4xZJJjkFGDtFCW7MIC353s4W2wq5YUYqCRHQb7KXK1a+yww9+5iRRQpwUDRBokmaygZ
         bP2woy0OK1OO/20lnWOseVgUAdllJVtdixIblfSf83PlsfNcYibkMgte2lkAWPaGgSSl
         /xbzJh3RtoyDSha0YP3irVRHebJdZsEYe+R07dJe1i9eC/JtlsqpUfr52ndgVzcbL0/6
         9HDEwBnzm0JhFl3P60rz9PaPI1kWuOY0aHf6eVVErhNNHddwHWNuNfao9bNFsxTmKPN+
         cMfg==
X-Forwarded-Encrypted: i=1; AJvYcCXKsobUmRf3zVEr/O5A8hfW2F/2paS7KlyzgoYwbMHtPpcq6qjW4Cu7DuE4ws7oA3DbqfkXcBxg@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh5bpqPbT8AZfwWnp9R7X6gCN8rHqCuyoK5KSQffKfl8CT+dX8
	CMyJAFC+KO3y6nCyklv8hcY9tnJjdgewW8tTsP60ix47sT8Elv4X
X-Google-Smtp-Source: AGHT+IFtqt1qKK9we8v73n0bUKDdE6rCDvMVhGq+9eWiz3i4VEpzR8zeYNI88CdPKOCUnwJvyLNAyw==
X-Received: by 2002:a05:600c:3508:b0:42c:bd4d:e8ab with SMTP id 5b1f17b1804b1-42cbd4ebf4cmr13156245e9.10.1725912107601;
        Mon, 09 Sep 2024 13:01:47 -0700 (PDT)
Received: from krava (85-193-35-130.rib.o2.cz. [85.193.35.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cbc419014sm14108285e9.36.2024.09.09.13.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 13:01:47 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 9 Sep 2024 22:01:45 +0200
To: Alan Maguire <alan.maguire@oracle.com>
Cc: acme@kernel.org, dwarves@vger.kernel.org, eddyz87@gmail.com,
	olsajiri@gmail.com, shung-hsi.yu@suse.com, jirislaby@kernel.org
Subject: Re: [RFC dwarves] btf_encoder: record BTF-centric function state
 instead of DWARF-centric
Message-ID: <Zt9UKWn2u6ovBI4o@krava>
References: <20240909155031.1596249-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909155031.1596249-1-alan.maguire@oracle.com>

On Mon, Sep 09, 2024 at 04:50:31PM +0100, Alan Maguire wrote:
> When recording function information for later comparison (as we
> do when skipping inconsistent function descriptions), we utilize
> DWARF-based representations because we do not want to jump the
> gun and add BTF representations for functions that have inconsistent
> representations across CUs (and across encoders in parallel mode).
> 
> So to handle this, we save info about functions, and we can then add
> them later once we have ensured their various representations are
> in fact consistent.  However to ensure that the function info
> is still valid, we need to specify LSK__KEEPIT for CUs, which
> bloats memory usage (in some cases to ~4Gb).  This is not a good
> approach, mea culpa.
> 
> Instead, store a BTF-centric representation where we
> 
> - store the number of parameters
> - store the BTF ids of return type and parameters
> - store the name of the parameters where present
> - store any LLVM annotation values, component idxs if present
> 
> So in summary, store everything we need to add the BTF_KIND_FUNC
> and BTF_KIND_FUNC_PROTO and any associated annotations.  This will
> allow us to free CUs as we go but make it possible to add functions
> later.
> 
> For name storage we can take advantage of the fact that
> BTF will avoid re-adding a name string so we btf__add_str()
> to add the parameter name and store the string offset instead;
> this prevents duplicate name storage while ensuring the parameter
> name is in BTF.
> 
> When we cross-compare functions for consistency, do a shallow
> analysis akin to what was done with DWARF prototype comparisons;
> compare base types by name, reference types by target type,
> match loosely between fwds, structs and unions etc.
> 
> When this is done, memory consumption peaks at 1Gb rather than
> ~4Gb for vmlinux generation.  Time taken appears to be approximately
> the same for -j1, but slightly faster for multiple threads;
> for example:

nice! did not realize LSK__KEEPIT was that bad..

> 
> Baseline
> 
> $ time pahole -J vmlinux -j1 --btf_features=default
> 
> real	0m17.268s
> user	0m15.808s
> sys	0m1.415s
> 
> $ time pahole -J vmlinux -j8 --btf_features=default
> 
> real	0m10.768s
> user	0m30.793s
> sys	0m4.199s
> 
> With these changes:
> 
> $ time pahole -J vmlinux -j1 --btf_features=default
> 
> real	0m16.564s
> user	0m16.029s
> sys	0m0.492s
> 
> $ time pahole -J vmlinux -j8 --btf_features=default
> 
> real	0m8.332s
> user	0m30.627s
> sys	0m0.714s
> 
> In terms of functions encoded, 360 fewer functions make it into

on my setup I'm getting 386 fewer fcuntions

> BTF due to the different approach in consistency checking, but after
> examining these cases, they do appear to be legitimately inconsistent
> functions where the optimized versions have parameter mismatches
> with the non-optimized expectations.

I checked on one case and it seems like obvious inconsistency:

  static void io_serial_out(unsigned long addr, int offset, int value)
  static void io_serial_out(struct uart_port *p, int offset, int value)

not sure how we could missed that before

> 
> Mileage may vary of course, and any testing folks could do would
> be greatly appreciated!

would be nice to have some test for before/after vmlinux images,
that would compare generated BTF functions

thanks,
jirka


SNIP

>  static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct function *fn, struct elf_function *func)
>  {
> -	fn->priv = encoder->cu;
> -	if (func->function) {
> -		struct function *existing = func->function;
> +	struct btf_encoder_func_state *state = zalloc(sizeof(*state));
> +	struct ftype *ftype = &fn->proto;
> +	struct btf *btf = encoder->btf;
> +	struct llvm_annotation *annot;
> +	struct parameter *param;
> +	uint8_t param_idx = 0;
> +
> +	if (!state)
> +		return -ENOMEM;
> +	state->nr_parms = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
> +	state->ret_type_id = ftype->tag.type == 0 ? 0 : encoder->type_id_off + ftype->tag.type;
> +	if (state->nr_parms > 0) {
> +		state->parms = zalloc(state->nr_parms * sizeof(*state->parms));
> +		if (!state->parms)
> +			return -ENOMEM;
> +	}
> +	state->inconsistent_proto = ftype->inconsistent_proto;
> +	state->unexpected_reg = ftype->unexpected_reg;
> +	state->optimized_parms = ftype->optimized_parms;
> +	ftype__for_each_parameter(ftype, param) {
> +		const char *name = parameter__name(param) ?: "";
> +
> +		state->parms[param_idx].name_off = btf__add_str(btf, name);
> +		if (state->parms[param_idx].name_off < 0)
> +			return state->parms[param_idx].name_off;
> +		state->parms[param_idx].type_id = param->tag.type == 0 ? 0 : encoder->type_id_off + param->tag.type;

so IIUC because functions are added as last we're sure all the used types
for arguments are stored in encoder's BTF already.. for funcs__match later ?

> +		param_idx++;
> +	}
> +	if (ftype->unspec_parms)
> +		state->parms[param_idx].type_id = 0;
> +
> +	list_for_each_entry(annot, &fn->annots, node)
> +		state->nr_annots++;
> +	if (state->nr_annots) {
> +		uint8_t idx = 0;
> +
> +		state->annots = zalloc(sizeof(*state->annots));

zalloc needs sizeof(..) * state->nr_annots ?

> +		if (!state->annots)
> +			return -ENOMEM;
> +		list_for_each_entry(annot, &fn->annots, node) {
> +			state->annots[idx].value = btf__add_str(encoder->btf, annot->value);
> +			if (state->annots[idx].value < 0)
> +				return state->annots[idx].value;
> +			state->annots[idx].component_idx = annot->component_idx;
> +			idx++;
> +		}
> +	}
> +
> +	if (func->state) {
> +		struct btf_encoder_func_state *existing = func->state;
>  
>  		/* If saving and we find an existing entry, we want to merge
>  		 * observations across both functions, checking that the
> @@ -899,98 +1097,136 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
>  		 * to add the local function later (encoder + type_id_off)
>  		 * such that we can add the function later.
>  		 */
> -		existing->proto.optimized_parms |= fn->proto.optimized_parms;
> -		existing->proto.unexpected_reg |= fn->proto.unexpected_reg;
> -		if (!existing->proto.unexpected_reg && !existing->proto.inconsistent_proto &&
> -		     !funcs__match(encoder, func, fn))
> -			existing->proto.inconsistent_proto = 1;
> +		existing->optimized_parms |= state->optimized_parms;
> +		existing->unexpected_reg |= state->unexpected_reg;
> +		if (!existing->unexpected_reg && !state->inconsistent_proto &&
> +		     !funcs__match(encoder, func, encoder->btf, state,
> +				   encoder->btf, existing))
> +			existing->inconsistent_proto = 1;
> +		zfree(&state->annots);
> +		zfree(&state->parms);
> +		free(state);

some error returns above are missing whole state cleanup

>  	} else {
> -		func->state.type_id_off = encoder->type_id_off;
> -		func->function = fn;
> -		encoder->cu->functions_saved++;
> +		func->state = state;
>  	}
>  	return 0;
>  }
>  

SNIP
