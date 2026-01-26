Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E562C08D5
	for <dwarves@vger.kernel.org>; Mon, 26 Jan 2026 09:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769421157; cv=none; b=XjDg9kWlBa0NLIdMpzRK6bywft8vIC2h/Pj6mH5elsZ+yOiWBEiTq2xHRlym2KtTMZS8PLEkhUIq3LFWPSk1eBEGq8AeqR3u4fBL+n21iO6+0U8N/X+3Z1rNx501ZKvVIjpG01rLIXoJNVb7lE/5z4V1ab7BrunBIycHrAGcoGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769421157; c=relaxed/simple;
	bh=Q5myWOyMpoAeFKc1mk6sxi8Euw6/bcVY7uAnXcaAhmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/WUn45dUqLtpIoubBJEYdgFeiVN5KMRPbaangF4VDCJ0sFFzZXG9oXmi/pB1qkNFZRVOuU5MdxM+F2blLfW62lTW8P+nkqzwYx5hWhyHNEPwoqfMBO/Pn2vDQoo/7b4Xsr68wAiNHpXf6qS/YCpl1IHe/YK1BeRS5gTuOgdp3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aBZ6hxW2; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aBZ6hxW2"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-65819e75691so7452010a12.3
        for <dwarves@vger.kernel.org>; Mon, 26 Jan 2026 01:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769421153; x=1770025953; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4lYmLeleFe/R1XkIODSLHvXUdVIiw8+IXXD13ipBbso=;
        b=aBZ6hxW2GHw1M7go7r/byEhjj/K1jPw/GhCXOJUADZozNGwuTdv55/v7LURZvAGOsU
         ST/REkKUz2skTHveEWkPRPuYpDeTBIusnJCdloNoTdWNhaPewylXWqHz6sVOHl1Xt5QM
         80YSI3vW+V8l+M3YClPy01RsyF6JFyfL+ZheU8YnBjzZJ9J425WEwBlTbuOow6c176bo
         aFqqou1mlLK2hxAEnzqizIfZcTSESIeK/js54+xEEWMiOdj5kPdpQgPBL+8c9s2QfoHB
         LC3PUut9lpADAzP8PgxQvz9pF46GWNNecRWJYCzFBkUDQv4bH5C/fpsBWEmtFNiF+ipA
         Lnzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769421153; x=1770025953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4lYmLeleFe/R1XkIODSLHvXUdVIiw8+IXXD13ipBbso=;
        b=uSgMiPVP6vWtOsETKxPS4lUg4F7F1kIloUJGZUmIxQgonV922qMPxmfWwa/30oW7Cv
         CTWBpVlUiiGswD4rfGkYbE0+U8VXcPs+TzNaGa4wOz3QVr5ajINfTLR7O0+1lzLSwGrQ
         ja6dp4wnDM+pgVCqbrrc32AkIaxCH60Ac+cnQFcx8u0ZnJztmnhu78CeCbMjt6a06c2F
         zgpeaGn/n3O4dJgU4ciNon2d8gCWCFhFblb/q9Q0busrNCVpORAbWlzWuTz7klwGwtoJ
         PBVaDBwchgGmueyOpZOk7ft5fXfRDg9aMEOB3qu7pIk0Ng7mDUTvsr/zAx9Jtj4w4bfV
         FKPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVULfaOv01+TEYDNwhWp1GjYNH+PoV9z0956+tAxUKncCJaBF8uKZT4GBWr1fmR5YWabX47bFN2@vger.kernel.org
X-Gm-Message-State: AOJu0YzCpgdsnXrBRI9BGk7ldKJx5AbYRyYD++YajPxp5YFJbl9xe2nX
	4cxP+WjoDmjUQ0RjnNuYN/e0r62s7m1VQz1RY1uajCC5qZdyp/y/JJL8ynjmDfW51w==
X-Gm-Gg: AZuq6aJz/RPYJvRNv6SGUShje8XM4Cyqd7jcFRv69/D9dWCd4s2/lROHBqgZngW2axI
	FyQU9VWV4aPssoVEkTAbFhngJhkU94vqdhu1OHzJMkWaiO5F59Llu2sX5Sq1at1SD9ZS/6Z9E35
	1adm7tyvyuaHB8xYAgtVkbWMSD1br8rSSa63L5ILsKQAhIjaGRS6EMv86JZKmnjSguZ1c5pNfp7
	WlIsTBV4/01XJbTuSgYDTHGHHOMJ+Qbr8LeQB5HTBmfxiZAkKS9ZfEmkdbJyz9Lx4ShZiyn5b8T
	qYvtQI90s2WbMus3VrU3b5KHt+BrXgvzdH6ylgufMmiLHzGzHKSZiUYxORRgTs9Zcqxj6h/XUmy
	4A6buiIZ64snBk2DIuPFAwUl6/kLznJBJsb6CcMC3hVJdYBxdOU/IRKHfn1r3P5icHZsdO1Ctb3
	g0T0wFHzBwz6PVSBOlfnJU85v1ycP3WFo6TfwCuHTeQcibiAwiWIc=
X-Received: by 2002:a05:6402:3492:b0:658:eca:1fa5 with SMTP id 4fb4d7f45d1cf-658706d6446mr2380883a12.20.1769421153104;
        Mon, 26 Jan 2026 01:52:33 -0800 (PST)
Received: from google.com (93.50.90.34.bc.googleusercontent.com. [34.90.50.93])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6584b3ea234sm4751563a12.8.2026.01.26.01.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 01:52:32 -0800 (PST)
Date: Mon, 26 Jan 2026 09:52:29 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: yonghong.song@linux.dev, ihor.solodrai@linux.dev, eddyz87@gmail.com,
	jolsa@kernel.org, andrii@kernel.org, ast@kernel.org,
	david.faust@oracle.com, dwarves@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v2 dwarves 2/5] btf_encoder: Add true_signature feature
 support for "."-suffixed functions
Message-ID: <aXc5XXZvgJAHMf6v@google.com>
References: <20260123172650.4062362-1-alan.maguire@oracle.com>
 <20260123172650.4062362-3-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123172650.4062362-3-alan.maguire@oracle.com>

On Fri, Jan 23, 2026 at 05:26:47PM +0000, Alan Maguire wrote:
> Currently we collate function information by name and add functions
> provided there are no inconsistencies across various representations.
> 
> For true_signature support - where we wish to add the real signature
> of a function even if it differs from source level - we need to do
> a few things:
> 
> 1. For "."-suffixed functions, we need to match from DWARF->ELF;
>    we can do this via the address associated with the function.
>    In doing this, we can then be confident that the debug info
>    for foo.isra.0 is the right info for the function at that
>    address.
> 
> 2. When adding saved functions we need to look for such cases
>    and provided they do not violate other constraints around BTF
>    representation - unexpected reg usage for function, uncertain
>    parameter location or ambiguous address - we add them with
>    their "."-suffixed name.  The latter can be used as a signal
>    that the function is transformed from the original.
> 
> Doing this adds 500 functions to BTF.  These are traceable with
> their "."-suffix names and because we have excluded ambiguous
> address cases we know exactly which function address they refer
> to.
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Some minor nits, but apart from that it looks OK to me.

Acked-by: Matt Bobrowski <mattbobrowski@google.com>

> ---
>  btf_encoder.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++-----
>  dwarves.h     |  1 +
>  pahole.c      |  1 +
>  3 files changed, 71 insertions(+), 7 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 9a567e4..c1002c3 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -77,9 +77,16 @@ struct btf_encoder_func_annot {
>  	int16_t component_idx;
>  };
>  
> +struct elf_function_sym {
> +	const char *name;
> +	uint64_t addr;
> +};
> +
>  /* state used to do later encoding of saved functions */
>  struct btf_encoder_func_state {
>  	struct elf_function *elf;
> +	struct elf_function_sym *sym;
> +	uint64_t addr;
  		 ^
		 This appears to have leaked into wrong commit?
		 This member should've been introduced within patch
		 5/5.
		 
>  	uint32_t type_id_off;
>  	uint16_t nr_parms;
>  	uint16_t nr_annots;
> @@ -94,11 +101,6 @@ struct btf_encoder_func_state {
>  	struct btf_encoder_func_annot *annots;
>  };
>  
> -struct elf_function_sym {
> -	const char *name;
> -	uint64_t addr;
> -};
> -
>  struct elf_function {
>  	char		*name;
>  	struct elf_function_sym *syms;
> @@ -145,7 +147,8 @@ struct btf_encoder {
>  			  skip_encoding_decl_tag,
>  			  tag_kfuncs,
>  			  gen_distilled_base,
> -			  encode_attributes;
> +			  encode_attributes,
> +			  true_signature;
>  	uint32_t	  array_index_id;
>  	struct elf_secinfo *secinfo;
>  	size_t             seccnt;
> @@ -1270,14 +1273,36 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
>  			goto out;
>  		}
>  	}
> +	if (encoder->true_signature && fn->lexblock.ip.addr) {
> +		int i;
> +
> +		for (i = 0; i < func->sym_cnt; i++) {
> +			if (fn->lexblock.ip.addr != func->syms[i].addr)
> +				continue;
> +			/* Only need to record address for '.'-suffixed
> +			 * functions, since we only currently need true
> +			 * signatures for them.
> +			 */
> +			if (!strchr(func->syms[i].name, '.'))
> +				continue;
> +			state->sym = &func->syms[i];
> +			break;
> +		}
> +	}
>  	state->inconsistent_proto = ftype->inconsistent_proto;
>  	state->unexpected_reg = ftype->unexpected_reg;
>  	state->optimized_parms = ftype->optimized_parms;
>  	state->uncertain_parm_loc = ftype->uncertain_parm_loc;
>  	state->reordered_parm = ftype->reordered_parm;
>  	ftype__for_each_parameter(ftype, param) {
> -		const char *name = parameter__name(param) ?: "";
> +		const char *name;
>  
> +		/* No location info/optimized + reordered means optimized out. */
> +		if (ftype->reordered_parm && (!param->has_loc || param->optimized)) {
> +			state->nr_parms--;
> +			continue;
> +		}
> +		name = parameter__name(param) ?: "";
>  		str_off = btf__add_str(btf, name);
>  		if (str_off < 0) {
>  			err = str_off;
> @@ -1366,6 +1391,9 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder,
>  
>  	btf_fnproto_id = btf_encoder__add_func_proto_for_state(encoder, state);
>  	name = func->name;
> +	if (encoder->true_signature && state->sym)
> +		name = state->sym->name;
> +
>  	if (btf_fnproto_id >= 0)
>  		btf_fn_id = btf_encoder__add_ref_type(encoder, BTF_KIND_FUNC, btf_fnproto_id,
>  						      name, false);
> @@ -1508,6 +1536,39 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
>  		while (j < nr_saved_fns && saved_functions_combine(encoder, &saved_fns[i], &saved_fns[j]) == 0)
>  			j++;
>  
> +		/* Add true signatures for case where we have an exact
> +		 * symbol match by address from DWARF->ELF and have a
> +		 * "." suffixed name.
> +		 */
> +		if (encoder->true_signature) {
> +			bool true_added = false;
> +			int k;
> +
> +			for (k = i; k < nr_saved_fns; k++) {
> +				struct btf_encoder_func_state *true_state = &saved_fns[k];
> +
> +				if (state->elf != true_state->elf)
> +					break;
> +				if (!true_state->sym)
> +					continue;
> +				/* Unexpected reg, uncertain parm loc and
> +				 * ambiguous address mean we cannot trust fentry.
> +				 */
> +				if (true_state->unexpected_reg ||
> +				    true_state->uncertain_parm_loc ||
> +				    true_state->ambiguous_addr)
> +					continue;
> +				err = btf_encoder__add_func(encoder, true_state);
> +				if (err < 0)
> +					goto out;
> +				true_added = true;
> +				break;
> +			}
> +			/* If true symbol was added, skip the below. */
> +			if (true_added)
> +				continue;
> +		}
> +

I think this hunk should be factored out into a
helper. btf_encoder__add_saved_funcs() is starting to get hairy IMO.

>  		/* do not exclude functions with optimized-out parameters; they
>  		 * may still be _called_ with the right parameter values, they
>  		 * just do not _use_ them.  Only exclude functions with
> @@ -2584,6 +2645,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>  		encoder->tag_kfuncs	 = conf_load->btf_decl_tag_kfuncs;
>  		encoder->gen_distilled_base = conf_load->btf_gen_distilled_base;
>  		encoder->encode_attributes = conf_load->btf_attributes;
> +		encoder->true_signature = conf_load->true_signature;
>  		encoder->verbose	 = verbose;
>  		encoder->has_index_type  = false;
>  		encoder->need_index_type = false;
> diff --git a/dwarves.h b/dwarves.h
> index 78bedf5..d7c6474 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -101,6 +101,7 @@ struct conf_load {
>  	bool			btf_decl_tag_kfuncs;
>  	bool			btf_gen_distilled_base;
>  	bool			btf_attributes;
> +	bool			true_signature;
>  	uint8_t			hashtable_bits;
>  	uint8_t			max_hashtable_bits;
>  	uint16_t		kabi_prefix_len;
> diff --git a/pahole.c b/pahole.c
> index ef01e58..02a0d19 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -1234,6 +1234,7 @@ struct btf_feature {
>  	BTF_NON_DEFAULT_FEATURE(global_var, encode_btf_global_vars, false),
>  	BTF_NON_DEFAULT_FEATURE_CHECK(attributes, btf_attributes, false,
>  				      attributes_check),
> +	BTF_NON_DEFAULT_FEATURE(true_signature, true_signature, false),
>  };
>  
>  #define BTF_MAX_FEATURE_STR	1024
> -- 
> 2.43.5
> 
