Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E322329C5F
	for <dwarves@vger.kernel.org>; Mon, 26 Jan 2026 09:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769419854; cv=none; b=sg2+oQqeo1DmG1KbfynWZ+u+YAJ7xVP1ruOCDsqCCwiVct3oC5+O9Rt0eAd+YhuGuFbH5Whcuu7J648kETl2KBcqJrOEvfvJ9+OfVL+TT2EhtgFXi4YioVjFhCAbAGn1XEp5JRO5hRHoZu65iLujLYPArxzhKk5B04m1q5KgSsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769419854; c=relaxed/simple;
	bh=MGgNur5h7++ktQU5Kp4fTDZwjgThM+94UC4kxs8EbZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FlVEYGe3Zheh8touUlQZPTPE1l5W6frutsTCwnVX8RBLbDa0hqtnf71DIjaVKOp4EGhLwqdS403Cv2MUUU5Zfz5x5xefYhiE8XEz98Ikd3NRG01RvXlyiXdbAlBTWjuVtzPUFy2Jph3HYtXYerEmoCQ4VMVcuPV8w6GcR+UzO1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dwKvzG80; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dwKvzG80"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64b9cb94ff5so5894140a12.2
        for <dwarves@vger.kernel.org>; Mon, 26 Jan 2026 01:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769419850; x=1770024650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B9VY60TiX+0sdvRJe5MkdWUBfabKNTnZ4k32eg02uwY=;
        b=dwKvzG80pmWA14w/dbHcmEGJ/kli+dcWXFesETN8eNTRiKwKkMOZcwLCVLx1AzNclE
         oVG59DI19ui625SVo4XTWwhBHtiZN3cUNVoUFZUdB0oYtSwASAtd2zoRjbqyIqNMiq4V
         aA8ixUnCsl0b4rsqjczCp5JFaz/B70nbiVvF0gzON/Zmm7Ba/dauXofKPZ/V7jXDysMu
         DV5v54BBeH/uaJD8+H0buMhpgiMl0PSbTClzpDoWqK0B8nK2qWGM4WtpPGa04k/L2OuH
         /OfQk+LBamrBn67NNTcgGy5YKHo44BzENHRcK93h71Hvilxk/gj/sFY0BHg6aFp9tCrJ
         Ldgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769419850; x=1770024650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B9VY60TiX+0sdvRJe5MkdWUBfabKNTnZ4k32eg02uwY=;
        b=dS7q8Usq9J+DYB7KfXnUnYvkC04XLH58WOerdyKsLajBSDh+iJ+pvNx/1Z1rHhvFD7
         QJ0MsH2tY0zr5r6JI/QA0A2C+O5lKuR6NJLiIJy1RZVCfdnsLmhRxVsLVdA024ie3KJ6
         hJFz6b+289Ss10Y9BIaamWCEZEEzValTWl2zcRG7OCRDUMJnHIJeja83U1lyXB11xmMg
         /XTDnakXXqKrZ1MbbCIEIsXh2elE9YEdwycykXU3NRghKHahlOg9r82XcswIEt2L0aAS
         hJU1hBCA7GLPgYOAOjZzkk4SveBU9uWn8Wr/1wsoG1+PEnvqobH13URBMlfYoTvMi+CI
         QjKg==
X-Forwarded-Encrypted: i=1; AJvYcCUpnzppLPMcYgwte712odFPur2jAv0UvKgLSe0oCLrS5886W0JQLR9MOSR3PAsvmVJf1wq9cjEU@vger.kernel.org
X-Gm-Message-State: AOJu0YzzUGGBDMXVzd1/9odlwUsjCgcSUsnO4jZtMS/dIO7WiBIg3jLt
	4kJQV9v5rHWuNnjOU1xnBtLuhml6+E7DZZhxBQWR3eji1lUF/e2UQS3V3jQHZyOxig==
X-Gm-Gg: AZuq6aKpCAI6duZRpPThACSl5kNYSlRiK95dpguf2UL13tbVtZaEMyg3f8TC20GvQ5G
	G2wRwhsReV2L1WxCqBfu/BKBiXNV7/sszj4SKucDluyfTlIw7N7SCqLgBAX7X9+ujbNLS0wiE1h
	PqOPl8r+C0LcR2u8eEzvrLloqp28xcNSGRaBxOUPPW+lYZVSOfMcxxj5Yd1VUmF+9WujpeAcdlt
	zQoZhWx4FLsQlG2LIYT6kE0MgLjOGRv62kd3Au25bTNNtheSudPfMhVl9hqWPIEyEC2WTF9jl55
	HhyLmvaq7nZRFLbZxIFtXymCx0NUl+8bhSH9OyDQjLghvQhd1LOt2eKigvhLW2nj6nb6O/7m5yF
	bgcXX88kvMwNFyA7YYGFbm1Idbji/o2FwmXJlxZyLfrfSrwxTXQSlH838kCYa/3UfeZ4L/2k8GP
	kz+ds1zrkP3NnCnfTJgMikopjb7l6/nqV5j3p4Auvbvxs6w5C4c3eLmU7K6MHDIw==
X-Received: by 2002:a17:907:3ea7:b0:b87:d3af:de68 with SMTP id a640c23a62f3a-b8cfedfbaefmr235746166b.7.1769419849468;
        Mon, 26 Jan 2026 01:30:49 -0800 (PST)
Received: from google.com (93.50.90.34.bc.googleusercontent.com. [34.90.50.93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b3dbbd1sm614004066b.2.2026.01.26.01.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 01:30:49 -0800 (PST)
Date: Mon, 26 Jan 2026 09:30:45 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: yonghong.song@linux.dev, ihor.solodrai@linux.dev, eddyz87@gmail.com,
	jolsa@kernel.org, andrii@kernel.org, ast@kernel.org,
	david.faust@oracle.com, dwarves@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v2 dwarves 1/5] dwarf_loader/btf_encoder: Detect
 reordered parameters
Message-ID: <aXc0RdcUFM-UMSNZ@google.com>
References: <20260123172650.4062362-1-alan.maguire@oracle.com>
 <20260123172650.4062362-2-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123172650.4062362-2-alan.maguire@oracle.com>

On Fri, Jan 23, 2026 at 05:26:46PM +0000, Alan Maguire wrote:
> When encoding concrete instances of optimized functions it is possible
> parameters get reordered, often due to a parameter being optimized out;
> in such cases the order of abstract origin references to the abstract
> function is different, and the parameters that are optimized out
> usually appear after all the non-optimized parameters with no
> DW_AT_location information [1].
> 
> As an example consider
> 
> static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu);
> 
> It has - as expected - an abstract representation as follows:
> 
>  <1><6392a2d>: Abbrev Number: 47 (DW_TAG_subprogram)
>     <6392a2e>   DW_AT_name        : (indirect string, offset: 0x261e25): __blkcg_rstat_flush
>     <6392a32>   DW_AT_decl_file   : 1
>     <6392a33>   DW_AT_decl_line   : 1043
>     <6392a35>   DW_AT_decl_column : 13
>     <6392a36>   DW_AT_prototyped  : 1
>     <6392a36>   DW_AT_inline      : 1   (inlined)
>     <6392a37>   DW_AT_sibling     : <0x6392bac>
>  <2><6392a3b>: Abbrev Number: 38 (DW_TAG_formal_parameter)
>     <6392a3c>   DW_AT_name        : (indirect string, offset: 0xa7a9f): blkcg
>     <6392a40>   DW_AT_decl_file   : 1
>     <6392a41>   DW_AT_decl_line   : 1043
>     <6392a43>   DW_AT_decl_column : 47
>     <6392a44>   DW_AT_type        : <0x638b611>
>  <2><6392a48>: Abbrev Number: 20 (DW_TAG_formal_parameter)
>     <6392a49>   DW_AT_name        : cpu
>     <6392a4d>   DW_AT_decl_file   : 1
>     <6392a4e>   DW_AT_decl_line   : 1043
>     <6392a50>   DW_AT_decl_column : 58
>     <6392a51>   DW_AT_type        : <0x6377f8f>
> 
> However the concrete representation after optimization becomes:
> 
> ffffffff8186d180 t __blkcg_rstat_flush.isra.0
> 
> and has a concrete representation with parameter order switched:
> 
> <1><6399661>: Abbrev Number: 110 (DW_TAG_subprogram)
>     <6399662>   DW_AT_abstract_origin: <0x6392a2d>
>     <6399666>   DW_AT_low_pc      : 0xffffffff8186d180
>     <639966e>   DW_AT_high_pc     : 0x169
>     <6399676>   DW_AT_frame_base  : 1 byte block: 9c    (DW_OP_call_frame_cfa)
>     <6399678>   DW_AT_GNU_all_call_sites: 1
>     <6399678>   DW_AT_sibling     : <0x6399a8a>
>  <2><639967c>: Abbrev Number: 4 (DW_TAG_formal_parameter)
>     <639967d>   DW_AT_abstract_origin: <0x6392a48>
>     <6399681>   DW_AT_location    : 0x1fe21fb (location list)
>     <6399685>   DW_AT_GNU_locviews: 0x1fe21f5
>  <2><63996e4>: Abbrev Number: 4 (DW_TAG_formal_parameter)
>     <63996e5>   DW_AT_abstract_origin: <0x6392a3b>
>     <63996e9>   DW_AT_location    : 0x1fe2387 (location list)
>     <63996ed>   DW_AT_GNU_locviews: 0x1fe2385
> 
> In other words we end up with
> 
> static void __blkcg_rstat_flush.isra(int cpu, struct blkcg *blkcg);
> 
> We are not detecting cases like this in pahole, so we need to
> catch it to exclude such cases since they could lead to incorrect
> fentry attachment.
> 
> Future work around true function signatures will allow such functions
> with their "." suffixes, but even for such cases it is good to
> detect the reordering.
> 
> In practice we just end up excluding a few more .isra/.constprop
> functions which we cannot fentry-attach by name anyway; see [2] for an
> example list from CI.
> 
> [1] https://lore.kernel.org/bpf/101b74c9-949a-4bf4-a766-a5343b70bdd2@oracle.com/
> [2] https://github.com/alan-maguire/dwarves/actions/runs/20031993822
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>

Looks good.

Acked-by: Matt Bobrowski <mattbobrowski@google.com>

> ---
>  btf_encoder.c  | 29 ++++++++++++++++++++---------
>  dwarf_loader.c |  5 +++--
>  dwarves.h      |  2 ++
>  3 files changed, 25 insertions(+), 11 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index ec6933e..9a567e4 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -87,6 +87,7 @@ struct btf_encoder_func_state {
>  	uint8_t unexpected_reg:1;
>  	uint8_t inconsistent_proto:1;
>  	uint8_t uncertain_parm_loc:1;
> +	uint8_t reordered_parm:1;
>  	uint8_t ambiguous_addr:1;
>  	int ret_type_id;
>  	struct btf_encoder_func_parm *parms;
> @@ -1273,6 +1274,7 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
>  	state->unexpected_reg = ftype->unexpected_reg;
>  	state->optimized_parms = ftype->optimized_parms;
>  	state->uncertain_parm_loc = ftype->uncertain_parm_loc;
> +	state->reordered_parm = ftype->reordered_parm;
>  	ftype__for_each_parameter(ftype, param) {
>  		const char *name = parameter__name(param) ?: "";
>  
> @@ -1442,7 +1444,7 @@ static int saved_functions_combine(struct btf_encoder *encoder,
>  				   struct btf_encoder_func_state *a,
>  				   struct btf_encoder_func_state *b)
>  {
> -	uint8_t optimized, unexpected, inconsistent, uncertain_parm_loc;
> +	uint8_t optimized, unexpected, inconsistent, uncertain_parm_loc, reordered_parm;
>  
>  	if (a->elf != b->elf)
>  		return 1;
> @@ -1451,12 +1453,14 @@ static int saved_functions_combine(struct btf_encoder *encoder,
>  	unexpected = a->unexpected_reg | b->unexpected_reg;
>  	inconsistent = a->inconsistent_proto | b->inconsistent_proto;
>  	uncertain_parm_loc = a->uncertain_parm_loc | b->uncertain_parm_loc;
> -	if (!unexpected && !inconsistent && !funcs__match(encoder, a, b))
> +	reordered_parm = a->reordered_parm | b->reordered_parm;
> +	if (!unexpected && !inconsistent && !reordered_parm && !funcs__match(encoder, a, b))
>  		inconsistent = 1;
>  	a->optimized_parms = b->optimized_parms = optimized;
>  	a->unexpected_reg = b->unexpected_reg = unexpected;
>  	a->inconsistent_proto = b->inconsistent_proto = inconsistent;
>  	a->uncertain_parm_loc = b->uncertain_parm_loc = uncertain_parm_loc;
> +	a->reordered_parm = b->reordered_parm = reordered_parm;
>  
>  	return 0;
>  }
> @@ -1494,7 +1498,7 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
>  
>  	for (i = 0; i < nr_saved_fns; i = j) {
>  		struct btf_encoder_func_state *state = &saved_fns[i];
> -		bool add_to_btf = !skip_encoding_inconsistent_proto;
> +		char *skip_reason = NULL;
>  
>  		/* Compare across sorted functions that match by name/prefix;
>  		 * share inconsistent/unexpected reg state between them.
> @@ -1510,14 +1514,21 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
>  		 * unexpected register use, multiple inconsistent prototypes or
>  		 * uncertain parameters location
>  		 */
> -		add_to_btf |= !state->unexpected_reg && !state->inconsistent_proto && !state->uncertain_parm_loc && !state->elf->ambiguous_addr;
> -
> +		if (state->unexpected_reg)
> +			skip_reason = "unexpected register usage for parameter\n";
> +		if (skip_encoding_inconsistent_proto && state->inconsistent_proto)
> +			skip_reason = "inconsistet prototype\n";
>  		if (state->uncertain_parm_loc)
> -			btf_encoder__log_func_skip(encoder, saved_fns[i].elf,
> -					"uncertain parameter location\n",
> -					0, 0);
> +			skip_reason = "uncertain parameter location\n";
> +		if (state->reordered_parm)
> +			skip_reason = "reordered parameters\n";
> +		if (state->elf->ambiguous_addr)
> +			skip_reason = "ambiguous address\n";
>  
> -		if (add_to_btf) {
> +		if (skip_reason) {
> +			btf_encoder__log_func_skip(encoder, saved_fns[i].elf,
> +						   skip_reason, 0, 0);
> +		} else {
>  			if (is_kfunc_state(state))
>  				err = btf_encoder__add_bpf_kfunc(encoder, state);
>  			else

Oh, I like how you've split up the various skip reasonings.

> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 77aab8a..16fb7be 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -1262,7 +1262,7 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
>  
>  		tag__init(&parm->tag, cu, die);
>  		parm->name = attr_string(die, DW_AT_name, conf);
> -
> +		parm->idx = param_idx;
>  		if (param_idx >= cu->nr_register_params || param_idx < 0)
>  			return parm;
>  		/* Parameters which use DW_AT_abstract_origin to point at
> @@ -2636,6 +2636,8 @@ static void ftype__recode_dwarf_types(struct tag *tag, struct cu *cu)
>  			}
>  			opos = tag__parameter(dtag__tag(dtype));
>  			pos->name = opos->name;
> +			if (pos->idx != opos->idx)
> +				type->reordered_parm = 1;
>  			pos->tag.type = dtag__tag(dtype)->type;
>  			/* share location information between parameter and
>  			 * abstract origin; if neither have location, we will
> @@ -2838,7 +2840,6 @@ static int tag__recode_dwarf_type(struct tag *tag, struct cu *cu)
>  		lexblock__recode_dwarf_types(&fn->lexblock, cu);
>  	}
>  		/* Fall thru */
> -
>  	case DW_TAG_subroutine_type:
>  		ftype__recode_dwarf_types(tag, cu);
>  		/* Fall thru, for the function return type */
> diff --git a/dwarves.h b/dwarves.h
> index 21d4166..78bedf5 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -944,6 +944,7 @@ struct parameter {
>  	uint8_t optimized:1;
>  	uint8_t unexpected_reg:1;
>  	uint8_t has_loc:1;
> +	uint8_t idx;
>  };
>  
>  static inline struct parameter *tag__parameter(const struct tag *tag)
> @@ -1023,6 +1024,7 @@ struct ftype {
>  	uint8_t		 processed:1;
>  	uint8_t		 inconsistent_proto:1;
>  	uint8_t		 uncertain_parm_loc:1;
> +	uint8_t		 reordered_parm:1;
>  	struct list_head template_type_params;
>  	struct list_head template_value_params;
>  	struct template_parameter_pack *template_parameter_pack;
> -- 
> 2.43.5
> 
