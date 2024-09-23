Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7D419CC1F
	for <dwarves@vger.kernel.org>; Mon, 23 Sep 2024 14:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727101191; cv=none; b=Ox6wRvc5VNNa+K5VvEd9k1xg8Di+oA0hlIqZreWQd74sbbNZxiVj6yQxdOoxv5n0wWMFnBjVpZ8kJ6gXa7pc7iEWrm1hqv88nH8hLaao3MVca5p9XcH1ztzVmIbwHL+kIfPZSfEc+LyoXhXI44oC+o1xqWXnOTeVq21+xfALzic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727101191; c=relaxed/simple;
	bh=0f7sXQlef7ITCHZxlE9hpcVlcWqlEMGi96qHvaLIPCA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcWwoTDRXx6/mWx2vtEGwrMD3PjMXnqTaN7kquC3NAtrhP5/AxXFOE0F0jR03cvSxQLNCbdQmCNDquKKb+UATgtjJmLVu2gYFPP6OHpg8Yaa7JT74G8B2dqA7MvIFSy+ksNBuB4h1LYErAsoPA9Z9JqE8P4M9vDPiTEuQdQHs6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kb+oUtv+; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kb+oUtv+"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-374b25263a3so2626973f8f.0
        for <dwarves@vger.kernel.org>; Mon, 23 Sep 2024 07:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727101188; x=1727705988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5CZ+mURIur8fBCpcUzk/px0Uir9T085KeZXSUR+KxBU=;
        b=Kb+oUtv+VnoNwyYMrn6pyIT3GRff8eg+UWN2yyhJYZZLFqZ9yMGTy8Q4WEzMz6jqv6
         +eA1DtcDbnzv6gWe03jkP5quBet1ekSKs4O2sQUuvhU4gfwe8aoGgMLXu3NFm+xgkWYy
         PLgJIP65umUvGiAHY18qe7l3VvTu8PRvlwdGw0OY09IbEz1NfjTBCA999pkAlOUqZ9IO
         XTf+NQ5nyLVHAyzlFyXFm7QnK2WthI91yTFPfkzxMzQbdX213jC6GsWbo0lbT1uKORzJ
         jqv3C2oBrLL/E/vx7JxJWoLex1NaM8i5R8fC6358HlULdIuUUFrpTxX7xHXxRR/UQEOP
         HV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727101188; x=1727705988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CZ+mURIur8fBCpcUzk/px0Uir9T085KeZXSUR+KxBU=;
        b=o+z++2tLd6SALNiT2WvJy/8dhPSsDk1pIT2UUFEmb1VpgNqeLOl1rpORFxQIsYY+Ns
         CbkSXWnxDDeeBV/jwi+P0BaA82BsPeiu806UH8FLYLVBsL2Z5LBjG977nL60EO1On2m+
         9tvC4WWzJl5ecgSJb3aw9fEa/9LlEuZqq2hCMFZ0HFXp4vjG2rk1jkkQpyR/zXjyZNU4
         o5Bpb45y9nmlBvKUpvcykWxn1qy43TJFDV7QsSto8XFjH3aXCL++DOvkSOkYzBOlz1uR
         dwqEdlLSbSAX9Vv6Xh6CL6tmND71gmbaZ1ZaoKZhI7ebV9WfIEGs/mUhc/bUuJvCr5ug
         itgQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7/5r1GcHrWH/SH8k/Jh4mnopCX6nXlxVabkXNA+Wnuy5MBEr2pVWaKAY5J84ZNLALChwXOxmF@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ414mBRDp1HMwKIJG/v/Wk+0vHA0UBjUSXNhDU91SKiB6jjAy
	ZUTH11vPdgkHHdiDAr9X7hS7V0sq6jVIAmK4ENO7mSNC2k+tRRK5
X-Google-Smtp-Source: AGHT+IGSu8uj2clefrFKgRO62F0foxDnC2lOxuvgMq74t9RPaozI2aMUwqrU54t2MJ/cqE6GDtMNmA==
X-Received: by 2002:a05:6000:1544:b0:374:cd96:f73 with SMTP id ffacd0b85a97d-37a4223e127mr7194958f8f.3.1727101187857;
        Mon, 23 Sep 2024 07:19:47 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb5f48bsm10389928a12.54.2024.09.23.07.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 07:19:47 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 23 Sep 2024 16:19:45 +0200
To: Alan Maguire <alan.maguire@oracle.com>
Cc: acme@kernel.org, dwarves@vger.kernel.org, eddyz87@gmail.com,
	olsajiri@gmail.com, shung-hsi.yu@suse.com, jirislaby@kernel.org
Subject: Re: [PATCH v2 dwarves 1/3] btf_encoder: record BTF-centric function
 state instead of DWARF-centric
Message-ID: <ZvF5AdxV-8chJXgp@krava>
References: <20240916134946.3893204-1-alan.maguire@oracle.com>
 <20240916134946.3893204-2-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916134946.3893204-2-alan.maguire@oracle.com>

On Mon, Sep 16, 2024 at 02:49:44PM +0100, Alan Maguire wrote:

SNIP

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
> BTF due to the different approach in consistency checking, but after
> examining these cases, they do appear to be legitimately inconsistent
> functions where the optimized versions have parameter mismatches
> with the non-optimized expectations.
> 
> Mileage may vary of course, and any testing folks could do would
> be greatly appreciated!

looks good, some comments below.. I was hoping to find some way
to split the change, but can't think of any ;-)

thanks,
jirka


SNIP

> -static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct ftype *ftype)
> +static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct ftype *ftype, struct elf_function *func)
>  {
>  	struct btf *btf = encoder->btf;
>  	const struct btf_type *t;
>  	struct parameter *param;
>  	uint16_t nr_params, param_idx;
>  	int32_t id, type_id;
> +	char tmp_name[KSYM_NAME_LEN];
> +	const char *name;
> +	struct btf_encoder_func_state *state = &func->state;

func could be NULL right?

SNIP

>  static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct function *fn, struct elf_function *func)
>  {
> -	fn->priv = encoder->cu;
> -	if (func->function) {
> -		struct function *existing = func->function;
> -
> -		/* If saving and we find an existing entry, we want to merge
> -		 * observations across both functions, checking that the
> -		 * "seen optimized parameters", "inconsistent prototype"
> -		 * and "unexpected register" status is reflected in the
> -		 * the func entry.
> -		 * If the entry is new, record encoder state required
> -		 * to add the local function later (encoder + type_id_off)
> -		 * such that we can add the function later.
> -		 */
> -		existing->proto.optimized_parms |= fn->proto.optimized_parms;
> -		existing->proto.unexpected_reg |= fn->proto.unexpected_reg;
> -		if (!existing->proto.unexpected_reg && !existing->proto.inconsistent_proto &&
> -		     !funcs__match(encoder, func, fn))
> -			existing->proto.inconsistent_proto = 1;
> -	} else {
> -		func->state.type_id_off = encoder->type_id_off;
> -		func->function = fn;
> -		encoder->cu->functions_saved++;

we could remove functions_saved from cu now?

SNIP

> -static int32_t btf_encoder__add_func(struct btf_encoder *encoder, struct function *fn)
> +static int32_t btf_encoder__add_func(struct btf_encoder *encoder, struct function *fn, struct elf_function *func)
>  {
> -	int btf_fnproto_id, btf_fn_id, tag_type_id;
> -	struct llvm_annotation *annot;
> +	int btf_fnproto_id, btf_fn_id, tag_type_id = 0;
> +	int16_t component_idx = -1;
>  	const char *name;
> +	const char *value;
> +	char tmp_value[KSYM_NAME_LEN];
>  
> -	btf_fnproto_id = btf_encoder__add_func_proto(encoder, &fn->proto);
> -	name = function__name(fn);
> -	btf_fn_id = btf_encoder__add_ref_type(encoder, BTF_KIND_FUNC, btf_fnproto_id, name, false);
> +	btf_fnproto_id = btf_encoder__add_func_proto(encoder, fn ? &fn->proto : NULL, func);
> +	name = func->alias ?: func->name;
> +	if (btf_fnproto_id >= 0)
> +		btf_fn_id = btf_encoder__add_ref_type(encoder, BTF_KIND_FUNC, btf_fnproto_id, name, false);
>  	if (btf_fnproto_id < 0 || btf_fn_id < 0) {
> -		printf("error: failed to encode function '%s'\n", function__name(fn));
> +		printf("error: failed to encode function '%s': invalid %s\n", name, btf_fnproto_id < 0 ? "proto" : "func");
>  		return -1;
>  	}
> -	list_for_each_entry(annot, &fn->annots, node) {
> -		tag_type_id = btf_encoder__add_decl_tag(encoder, annot->value, btf_fn_id,
> -							annot->component_idx);
> -		if (tag_type_id < 0) {
> -			fprintf(stderr, "error: failed to encode tag '%s' to func %s with component_idx %d\n",
> -				annot->value, name, annot->component_idx);
> -			return -1;
> +	if (!fn) {
> +		struct btf_encoder_func_state *state = &func->state;
> +		uint16_t idx;
> +
> +		if (!state || state->nr_annots == 0)

it probably can't happen, but state will be allways != NULL in here.. should it be:

		if (!func || state->nr_annots == 0)


> +			return 0;
> +
> +		for (idx = 0; idx < state->nr_annots; idx++) {
> +			struct btf_encoder_func_annot *a = &state->annots[idx];
> +
> +			value = btf__str_by_offset(encoder->btf, a->value);
> +			/* adding BTF data may result in a mode of the
> +			 * value string memory, so make a temporary copy.
> +			 */
> +			strncpy(tmp_value, value, sizeof(tmp_value));
> +			component_idx = a->component_idx;
> +
> +			tag_type_id = btf_encoder__add_decl_tag(encoder, tmp_value, btf_fn_id, component_idx);
> +			if (tag_type_id < 0)
> +				break;
> +		}
> +	} else {
> +		struct llvm_annotation *annot;
> +
> +		list_for_each_entry(annot, &fn->annots, node) {
> +			value = annot->value;
> +			component_idx = annot->component_idx;
> +
> +			tag_type_id = btf_encoder__add_decl_tag(encoder, value, btf_fn_id,
> +								component_idx);
> +			if (tag_type_id < 0)
> +				break;
>  		}
>  	}
> +	if (tag_type_id < 0) {
> +		fprintf(stderr, "error: failed to encode tag '%s' to func %s with component_idx %d\n",
> +			value, name, component_idx);
> +		return -1;
> +	}
> +
>  	return 0;
>  }
>  
> -static void btf_encoder__add_saved_funcs(struct btf_encoder *encoder)
> +static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder)
>  {
>  	int i;
>  
>  	for (i = 0; i < encoder->functions.cnt; i++) {
>  		struct elf_function *func = &encoder->functions.entries[i];
> -		struct function *fn = func->function;
> -		struct btf_encoder *other_encoder;
> +		struct btf_encoder_func_state *state = &func->state;
> +		struct btf_encoder *other_encoder = NULL;
>  
> -		if (!fn || fn->proto.processed)
> +		if (!state || !state->initialized || state->processed)
>  			continue;

state is now placed directly in elf_function so will allways be state != NULL

> -
>  		/* merge optimized-out status across encoders; since each
>  		 * encoder has the same elf symbol table we can use the
>  		 * same index to access the same elf symbol.
>  		 */
>  		btf_encoders__for_each_encoder(other_encoder) {
> -			struct function *other_fn;
> +			struct elf_function *other_func;
> +			struct btf_encoder_func_state *other_state;
> +			uint8_t optimized, unexpected, inconsistent;
>  
>  			if (other_encoder == encoder)
>  				continue;
>  
> -			other_fn = other_encoder->functions.entries[i].function;
> -			if (!other_fn)
> +			other_func = &other_encoder->functions.entries[i];
> +			other_state = &other_func->state;
> +			if (!other_state)
>  				continue;

same as above it will allways be other_state != NULL

> -			fn->proto.optimized_parms |= other_fn->proto.optimized_parms;
> -			fn->proto.unexpected_reg |= other_fn->proto.unexpected_reg;
> -			if (other_fn->proto.inconsistent_proto)
> -				fn->proto.inconsistent_proto = 1;
> -			if (!fn->proto.unexpected_reg && !fn->proto.inconsistent_proto &&
> -			    !funcs__match(encoder, func, other_fn))
> -				fn->proto.inconsistent_proto = 1;
> -			other_fn->proto.processed = 1;
> +			optimized = state->optimized_parms | other_state->optimized_parms;
> +			unexpected = state->unexpected_reg | other_state->unexpected_reg;
> +			inconsistent = state->inconsistent_proto | other_state->inconsistent_proto;
> +			if (!unexpected && !inconsistent &&
> +			    !funcs__match(encoder, func,
> +					  encoder->btf, state,
> +					  other_encoder->btf, other_state))
> +				inconsistent = 1;
> +			state->optimized_parms = other_state->optimized_parms = optimized;
> +			state->unexpected_reg = other_state->unexpected_reg = unexpected;
> +			state->inconsistent_proto = other_state->inconsistent_proto = inconsistent;
> +
> +			other_state->processed = 1;

SNIP
