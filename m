Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23D71C6F51
	for <dwarves@vger.kernel.org>; Tue,  1 Oct 2024 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727797151; cv=none; b=MerbRApwYOFa5ZcfVkhuHPmAiqD2qL6QmfAYhYMyABLn2Yi/xCzsFD1+t3xgrbkyEfMkottimTMxOtzJKkIg8tU4kLqXAS2c3A4i85l/lvg49JxiGCJEIv+vNhgGDXhf+KWwXxEywATKSK+hfxPi8+HrW3I9KQAUYOpB6p3z4Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727797151; c=relaxed/simple;
	bh=cs/JKfRI/5PScmdobAGbAWNnpxvxIFRQ05u4llVkfDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fy4wpTn4+wsHhay3LSKdZwgaXsdG5uDRkOGVwBA21t9P96ezpDArEmrDgvQ+39mA3IQ7P6of9sWIcQqqpk0UytC2Y1DAhNMXxH+42GACbeJjfM2/79zsmnfY4cX/O5XW9YEXkl87pCG9kLv9G0ieuUh7wzDwjlxx9kh21RDtHew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTs6F0mn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTs6F0mn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C30C4CEC6;
	Tue,  1 Oct 2024 15:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727797150;
	bh=cs/JKfRI/5PScmdobAGbAWNnpxvxIFRQ05u4llVkfDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GTs6F0mnFhV9vk+bcsc/yepy9N4dRDcphULT+pA8o8YCQQmId5kfWufa+r0Tm7UIu
	 fR3gktkk7K7yZCPzxUz3W/WzDSlKkwJbTxL6H7gD3KvUhPciNhSOFJVSo1DFgvs9KX
	 DaVurnbiyKycvT2tPaaZoJuJJicWhC3fb31eADM6jaPI59usjyUGL92eJXevRx19Y5
	 6FJHg6+Wi3ALa8Iu7TBKXUQa8hQGb0Jh0RxQgDz8JHTgVNttrcsHD6unSTqB17CRYw
	 F/BBXd6e2nHsxZB1xiVvbceYNPuw8OM0aCj2cerK6KLQ3o9CS92LQtSR5MUpRnWu67
	 g5EFC+7RRYjSA==
Date: Tue, 1 Oct 2024 12:39:04 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: dwarves@vger.kernel.org, eddyz87@gmail.com, olsajiri@gmail.com,
	shung-hsi.yu@suse.com, jirislaby@kernel.org
Subject: Re: [RFC dwarves] btf_encoder: record BTF-centric function state
 instead of DWARF-centric
Message-ID: <ZvwXmH1IR9gWQ1wZ@x1>
References: <20240909155031.1596249-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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
> BTF due to the different approach in consistency checking, but after
> examining these cases, they do appear to be legitimately inconsistent
> functions where the optimized versions have parameter mismatches
> with the non-optimized expectations.
> 
> Mileage may vary of course, and any testing folks could do would
> be greatly appreciated!

So this is what I'm getting here:

  acme@x1:~/git/pahole$ pahole --running_kernel_vmlinux
  /usr/lib/debug/lib/modules/6.10.11-200.fc40.x86_64/vmlinux
  acme@x1:~/git/pahole$
  
  acme@x1:~/git/pahole$ time tests/tests 
    1: Validation of BTF encoding of functions; this may take some time...
  Matched 60956 functions exactly.
  Matched 205 functions with inlines.
  Matched 127 functions with multiple const/non-const instances.
  Ok
  Validation of skipped function logic...
  Validating skipped functions are absent from BTF...
  Skipped encoding 709 functions in BTF.
  Ok
  Validating skipped functions have incompatible return values...
  Found 14 functions with multiple incompatible return values.
  Ok
  Validating skipped functions have incompatible params/counts...
  WARN: 'irq_domain_alloc_descs()' has only one prototype; if it was subject to late optimization, pfunct may not reflect inconsistencies pahole found.
  Full skip message from pahole: irq_domain_alloc_descs (irq_domain_alloc_descs): skipping BTF encoding of function due to param type mismatch for param#1 cnt != virq

Humm:

acme@x1:~/git/pahole$ time pfunct --prototypes irq_domain_alloc_descs -F btf
int irq_domain_alloc_descs(int virq, unsigned int cnt, irq_hw_number_t hwirq, int node, const struct irq_affinity_desc  * affinity);

real	0m0.128s
user	0m0.073s
sys	0m0.053s
acme@x1:~/git/pahole$

acme@x1:~/git/pahole$ time pfunct --prototypes irq_domain_alloc_descs -F dwarf `pahole --running_kernel_vmlinux`
int irq_domain_alloc_descs(int virq, unsigned int cnt, irq_hw_number_t hwirq, int node, const struct irq_affinity_desc  * affinity);

real	0m1.783s
user	0m1.577s
sys	0m0.199s
acme@x1:~/git/pahole$ 

⬢[acme@toolbox pahole]$ grep irq_domain_alloc_descs /proc/kallsyms 
0000000000000000 t __pfx_irq_domain_alloc_descs.part.0
0000000000000000 t irq_domain_alloc_descs.part.0
0000000000000000 T __pfx_irq_domain_alloc_descs
0000000000000000 T irq_domain_alloc_descs
⬢[acme@toolbox pahole]$

So it is inlined:

 <1><1c21f2f>: Abbrev Number: 100 (DW_TAG_subprogram)
    <1c21f30>   DW_AT_external    : 1
    <1c21f30>   DW_AT_name        : (indirect string, offset: 0x3ac7ae): irq_domain_alloc_descs
    <1c21f34>   DW_AT_decl_file   : 1
    <1c21f34>   DW_AT_decl_line   : 1086
    <1c21f36>   DW_AT_decl_column : 5
    <1c21f37>   DW_AT_prototyped  : 1
    <1c21f37>   DW_AT_type        : <0x1c110b2>
    <1c21f3b>   DW_AT_inline      : 1   (inlined)
    <1c21f3b>   DW_AT_sibling     : <0x1c21f8e>
 <2><1c21f3f>: Abbrev Number: 14 (DW_TAG_formal_parameter)
    <1c21f40>   DW_AT_name        : (indirect string, offset: 0x36eaef): virq
    <1c21f44>   DW_AT_decl_file   : 1
    <1c21f45>   DW_AT_decl_line   : 1086
    <1c21f47>   DW_AT_decl_column : 32
    <1c21f48>   DW_AT_type        : <0x1c110b2>
 <2><1c21f4c>: Abbrev Number: 43 (DW_TAG_formal_parameter)
    <1c21f4d>   DW_AT_name        : cnt
    <1c21f51>   DW_AT_decl_file   : 1
    <1c21f52>   DW_AT_decl_line   : 1086
    <1c21f54>   DW_AT_decl_column : 51
    <1c21f55>   DW_AT_type        : <0x1c11049>

And then we have inlined subroutines pointing back (abstract origin) to
0x1c21f2f (DW_TAG_subprogram)

 <2><1c236f2>: Abbrev Number: 29 (DW_TAG_inlined_subroutine)
    <1c236f3>   DW_AT_abstract_origin: <0x1c21f2f>
    <1c236f7>   DW_AT_entry_pc    : 0xffffffff811d3a56
    <1c236ff>   DW_AT_GNU_entry_view: 3
    <1c23701>   DW_AT_low_pc      : 0xffffffff811d3a56
    <1c23709>   DW_AT_high_pc     : 0x17
    <1c23711>   DW_AT_call_file   : 1
    <1c23712>   DW_AT_call_line   : 698
    <1c23714>   DW_AT_call_column : 9
    <1c23715>   DW_AT_sibling     : <0x1c2378e>
 <3><1c23719>: Abbrev Number: 8 (DW_TAG_formal_parameter)
    <1c2371a>   DW_AT_abstract_origin: <0x1c21f3f>
    <1c2371e>   DW_AT_location    : 0x36add1 (location list)
    <1c23722>   DW_AT_GNU_locviews: 0x36adcd
 <3><1c23726>: Abbrev Number: 8 (DW_TAG_formal_parameter)
    <1c23727>   DW_AT_abstract_origin: <0x1c21f4c>
    <1c2372b>   DW_AT_location    : 0x36adee (location list)
    <1c2372f>   DW_AT_GNU_locviews: 0x36adec

But then the first arg points back to the right place, no?

 <2><1c21f3f>: Abbrev Number: 14 (DW_TAG_formal_parameter)
    <1c21f40>   DW_AT_name        : (indirect string, offset: 0x36eaef): virq
    <1c21f44>   DW_AT_decl_file   : 1
    <1c21f45>   DW_AT_decl_line   : 1086
    <1c21f47>   DW_AT_decl_column : 32
    <1c21f48>   DW_AT_type        : <0x1c110b2>
 <2><1c21f4c>: Abbrev Number: 43 (DW_TAG_formal_parameter)
    <1c21f4d>   DW_AT_name        : cnt
    <1c21f51>   DW_AT_decl_file   : 1
    <1c21f52>   DW_AT_decl_line   : 1086
    <1c21f54>   DW_AT_decl_column : 51
    <1c21f55>   DW_AT_type        : <0x1c11049>

I.e. can you please elaborate a bit here on this test/WARN as I am
missing something... :-\

  WARN: 'rcu_nocb_unlock_irqrestore()' has only one prototype; if it was subject to late optimization, pfunct may not reflect inconsistencies pahole found.
  Full skip message from pahole: rcu_nocb_unlock_irqrestore (rcu_nocb_unlock_irqrestore): skipping BTF encoding of function due to param type mismatch for param#1 flags != rdp
  WARN: 'validate_device_path()' has only one prototype; if it was subject to late optimization, pfunct may not reflect inconsistencies pahole found.
  Full skip message from pahole: validate_device_path (validate_device_path): skipping BTF encoding of function due to param type mismatch for param#1 buffer != var_name
  WARN: 'blk_rq_map_user_io()' has only one prototype; if it was subject to late optimization, pfunct may not reflect inconsistencies pahole found.
  Full skip message from pahole: blk_rq_map_user_io (blk_rq_map_user_io): skipping BTF encoding of function due to param type mismatch for param#6 iov_count != vec
  WARN: 'acpi_ec_setup()' has only one prototype; if it was subject to late optimization, pfunct may not reflect inconsistencies pahole found.
  Full skip message from pahole: acpi_ec_setup (acpi_ec_setup): skipping BTF encoding of function due to param type mismatch for param#2 call_reg != device
  WARN: 'acpi_button_notify()' has only one prototype; if it was subject to late optimization, pfunct may not reflect inconsistencies pahole found.
  Full skip message from pahole: acpi_button_notify (acpi_button_notify): skipping BTF encoding of function due to param type mismatch for param#1 data != handle
  WARN: 'bpf_sock_is_valid_access()' has only one prototype; if it was subject to late optimization, pfunct may not reflect inconsistencies pahole found.
  Full skip message from pahole: bpf_sock_is_valid_access (bpf_sock_is_valid_access): skipping BTF encoding of function due to param type mismatch for param#3 info != type
  Found 118 instances with multiple instances with incompatible parameters.
  Found 1 instances where inline functions were not inlined and had incompatible parameters.
  Found 295 instances where the function name suggests optimizations led to inconsistent parameters.
  Found 7 instances where pfunct did not notice inconsistencies.
  Ok
    2: Pretty printing of files using DWARF type information: pahole: type 'perf_event_type' not found
  skip: /home/acme/bin/perf doesn't have 'enum perf_event_type' type info
  skipping...
    3: 1 file not available, please specify another
  skipping...
  /home/acme/git/pahole
  
  real	7m46.729s
  user	4m21.097s
  sys	3m27.223s
  acme@x1:~/git/pahole$ 


Test #2 needs a perf binary with debugging info, if I provide one:

acme@x1:~/git/pahole$ time tests/prettify_perf.data.sh 
Pretty printing of files using DWARF type information: Ok

real	0m1.705s
user	0m1.083s
sys	0m0.595s
acme@x1:~/git/pahole$

I'll try to improve that message...

- Arnaldo

 
> More future work would involve sharing the ELF representation
> across encoders; this is the logical next step and judging by
> single-threaded performance should get us down to ~500Mb peak memory
> utilization; however it is better to approach this by taking
> smaller steps (we would also need to think about handling synchronous
> read/writes from multiple threads of function state).
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  btf_encoder.c | 471 ++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 359 insertions(+), 112 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 8a2d92e..369a7e9 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -50,19 +50,36 @@ struct btf_id_set8 {
>          } pairs[];
>  };
>  
> +struct btf_encoder_func_parm {
> +	int name_off;
> +	uint32_t type_id;
> +};
> +
> +struct btf_encoder_func_annot {
> +	uint32_t value;
> +	int16_t component_idx;
> +};
> +
>  /* state used to do later encoding of saved functions */
> -struct btf_encoder_state {
> +struct btf_encoder_func_state {
>  	uint32_t type_id_off;
> -	bool got_proto;
> -	char proto[BTF_ENCODER_MAX_PROTO];
> +	uint16_t nr_parms;
> +	uint16_t nr_annots;
> +	uint8_t optimized_parms:1;
> +	uint8_t unexpected_reg:1;
> +	uint8_t inconsistent_proto:1;
> +	uint8_t processed:1;
> +	int ret_type_id;
> +	struct btf_encoder_func_parm *parms;
> +	struct btf_encoder_func_annot *annots;
>  };
>  
>  struct elf_function {
>  	const char	*name;
> +	char		*alias;
>  	bool		 generated;
>  	size_t		prefixlen;
> -	struct function	*function;
> -	struct btf_encoder_state state;
> +	struct btf_encoder_func_state *state;
>  };
>  
>  struct var_info {
> @@ -125,7 +142,7 @@ struct btf_kfunc_set_range {
>  static LIST_HEAD(encoders);
>  static pthread_mutex_t encoders__lock = PTHREAD_MUTEX_INITIALIZER;
>  
> -static void btf_encoder__add_saved_funcs(struct btf_encoder *encoder);
> +static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder);
>  
>  /* mutex only needed for add/delete, as this can happen in multiple encoding
>   * threads.  Traversal of the list is currently confined to thread collection.
> @@ -669,18 +686,24 @@ static int32_t btf_encoder__tag_type(struct btf_encoder *encoder, uint32_t tag_t
>  	return encoder->type_id_off + tag_type;
>  }
>  
> -static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct ftype *ftype)
> +static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct ftype *ftype, struct elf_function *func)
>  {
>  	struct btf *btf = encoder->btf;
>  	const struct btf_type *t;
>  	struct parameter *param;
>  	uint16_t nr_params, param_idx;
>  	int32_t id, type_id;
> +	struct btf_encoder_func_state *state;
>  
>  	/* add btf_type for func_proto */
> -	nr_params = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
> -	type_id = btf_encoder__tag_type(encoder, ftype->tag.type);
> -
> +	if (ftype) {
> +		nr_params = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
> +		type_id = btf_encoder__tag_type(encoder, ftype->tag.type);
> +	} else {
> +		state = func->state;
> +		nr_params = state->nr_parms;
> +		type_id = state->ret_type_id;
> +	}
>  	id = btf__add_func_proto(btf, type_id);
>  	if (id > 0) {
>  		t = btf__type_by_id(btf, id);
> @@ -694,20 +717,29 @@ static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct f
>  
>  	/* add parameters */
>  	param_idx = 0;
> -	ftype__for_each_parameter(ftype, param) {
> -		const char *name = parameter__name(param);
> +	if (ftype) {
> +		ftype__for_each_parameter(ftype, param) {
> +			const char *name = parameter__name(param);
>  
> -		type_id = param->tag.type == 0 ? 0 : encoder->type_id_off + param->tag.type;
> -		++param_idx;
> -		if (btf_encoder__add_func_param(encoder, name, type_id, param_idx == nr_params))
> -			return -1;
> -	}
> +			type_id = param->tag.type == 0 ? 0 : encoder->type_id_off + param->tag.type;
> +			++param_idx;
> +			if (btf_encoder__add_func_param(encoder, name, type_id, param_idx == nr_params))
> +				return -1;
> +		}
>  
> -	++param_idx;
> -	if (ftype->unspec_parms)
> -		if (btf_encoder__add_func_param(encoder, NULL, 0, param_idx == nr_params))
> -			return -1;
> +		++param_idx;
> +		if (ftype->unspec_parms)
> +			if (btf_encoder__add_func_param(encoder, NULL, 0, param_idx == nr_params))
> +				return -1;
> +	} else {
> +		for (param_idx = 0; param_idx < nr_params; param_idx++) {
> +			struct btf_encoder_func_parm *p = &state->parms[param_idx];
> +			const char *name = btf__name_by_offset(btf, p->name_off);
>  
> +			if (btf_encoder__add_func_param(encoder, name, p->type_id, param_idx == nr_params))
> +				return -1;
> +		}
> +	}
>  	return id;
>  }
>  
> @@ -831,53 +863,172 @@ static int32_t btf_encoder__add_decl_tag(struct btf_encoder *encoder, const char
>  	return id;
>  }
>  
> -static bool proto__get(struct function *func, char *proto, size_t len)
> +static bool names__match(struct btf_encoder *encoder,
> +			struct btf *btf1, const struct btf_type *t1,
> +			struct btf *btf2, const struct btf_type *t2)
>  {
> -	const struct conf_fprintf conf = {
> -						.name_spacing = 23,
> -						.type_spacing = 26,
> -						.emit_stats = 0,
> -						.no_parm_names = 1,
> -						.skip_emitting_errors = 1,
> -						.skip_emitting_modifier = 1,
> -					};
> +	const char *str1;
> +	const char *str2;
> +	int ret;
> +
> +	if ((btf1 == btf2) && (t1->name_off == t2->name_off))
> +		return true;
> +
> +	str1 = btf__name_by_offset(btf1, t1->name_off);
> +	str2 = btf__name_by_offset(btf2, t2->name_off);
>  
> -	return function__prototype_conf(func, func->priv, &conf, proto, len) != NULL;
> +	ret = strcmp(str1, str2);
> +	if (ret && encoder->verbose)
> +		printf("'%s' != '%s'\n", str1, str2);
> +	return ret == 0;
>  }
>  
> -static bool funcs__match(struct btf_encoder *encoder, struct elf_function *func, struct function *f2)
> +static int fwd__kind(const struct btf_type *t)
>  {
> -	char proto[BTF_ENCODER_MAX_PROTO];
> -	struct function *f1 = func->function;
> -	const char *name;
> +	if (btf_kind(t) == BTF_KIND_FWD)
> +		return btf_kflag(t) ? BTF_KIND_UNION : BTF_KIND_STRUCT;
> +	return btf_kind(t);
> +}
> +
> +static bool types__match(struct btf_encoder *encoder,
> +			 struct btf *btf1, int type_id1,
> +			 struct btf *btf2, int type_id2)
> +{
> +	uint32_t id1 = type_id1;
> +	uint32_t id2 = type_id2;
> +
> +	do {
> +		const struct btf_type *t1;
> +		const struct btf_type *t2;
> +		int k1;
> +		int k2;
> +
> +		if ((btf1 == btf2) && (id1 == id2))
> +			return true;
> +		if (!id1 || !id2) {
> +			if (encoder->verbose && id1 != id2)
> +				printf("%s != %s\n", id1 ? "non-void" : "void",
> +				       id2 ? "non-void" : "void");
> +			return id1 == id2;
> +		}
> +
> +		t1 = btf__type_by_id(btf1, id1);
> +		t2 = btf__type_by_id(btf2, id2);
> +
> +		k1 = fwd__kind(t1);
> +		k2 = fwd__kind(t2);
> +
> +		if (k1 != k2) {
> +			/* loose matching allows us to match const/non-const
> +			 * parameters.
> +			 */
> +			if (k1 == BTF_KIND_CONST) {
> +				id1 = t1->type;
> +				continue;
> +			}
> +			if (k2 == BTF_KIND_CONST) {
> +				id2 = t2->type;
> +				continue;
> +			}
> +			if (encoder->verbose)
> +				printf("kind mismatch [%u] != [%u]\n", k1, k2);
> +			return false;
> +		}
> +
> +		switch (btf_kind(t1)) {
> +		case BTF_KIND_INT:
> +		case BTF_KIND_FLOAT:
> +		case BTF_KIND_FWD:
> +		case BTF_KIND_TYPEDEF:
> +		case BTF_KIND_STRUCT:
> +		case BTF_KIND_UNION:
> +		case BTF_KIND_ENUM:
> +		case BTF_KIND_ENUM64:
> +			return names__match(encoder, btf1, t1, btf2, t2);
> +		case BTF_KIND_PTR:
> +		case BTF_KIND_VOLATILE:
> +		case BTF_KIND_CONST:
> +		case BTF_KIND_RESTRICT:
> +		case BTF_KIND_TYPE_TAG:
> +			id1 = t1->type;
> +			id2 = t2->type;
> +			break;
> +		case BTF_KIND_ARRAY: {
> +			const struct btf_array *a1 = btf_array(t1);
> +			const struct btf_array *a2 = btf_array(t2);
> +
> +			if (a1->nelems != a2->nelems)
> +				return false;
> +			id1 = a1->type;
> +			id2 = a2->type;
> +			break;
> +		}
> +		case BTF_KIND_FUNC_PROTO: {
> +			const struct btf_param *p1 = btf_params(t1);
> +			const struct btf_param *p2 = btf_params(t2);
> +			int i, vlen = btf_vlen(t1);
> +
> +			if (vlen != btf_vlen(t2))
> +				return false;
> +			if (!types__match(encoder, btf1, t1->type,
> +					  btf2, t2->type))
> +				return false;
> +			for (i = 0; i < vlen; i++, p1++, p2++) {
> +				if (!types__match(encoder, btf1, t1->type,
> +						  btf2, t2->type))
> +					return false;
> +			}
> +			return true;
> +		}
> +		default:
> +			if (encoder->verbose)
> +				printf("got unexpected kind [%u]\n", btf_kind(t1));
> +			return false;
> +		}
> +	} while (1);
> +
> +	return false;
> +}
>  
> -	if (!f1)
> +static bool funcs__match(struct btf_encoder *encoder, struct elf_function *func,
> +			 struct btf *btf1, struct btf_encoder_func_state *s1,
> +			 struct btf *btf2, struct btf_encoder_func_state *s2)
> +{
> +	const char *name, *other_name;
> +	uint8_t i;
> +
> +	if (!s1 || !s2)
>  		return false;
>  
> -	name = function__name(f1);
> +	name = func->alias ?: func->name;
> +	other_name = func->name;
>  
> -	if (f1->proto.nr_parms != f2->proto.nr_parms) {
> +	if (s1->nr_parms != s2->nr_parms) {
>  		if (encoder->verbose)
>  			printf("function mismatch for '%s'(%s): %d params != %d params\n",
> -			       name, f1->alias ?: name,
> -			       f1->proto.nr_parms, f2->proto.nr_parms);
> +			       name, other_name, s1->nr_parms, s2->nr_parms);
>  		return false;
>  	}
> -	if (f1->proto.nr_parms == 0)
> -		return true;
> -
> -	if (f1->proto.tag.type == f2->proto.tag.type)
> +	if (!types__match(encoder, btf1, s1->ret_type_id, btf2, s2->ret_type_id)) {
> +		if (encoder->verbose)
> +			printf("function mismatch for '%s'(%s): return type mismatch\n",
> +			       name, other_name);
> +		return false;
> +	}
> +	if (s1->nr_parms == 0)
>  		return true;
>  
> -	if (!func->state.got_proto)
> -		func->state.got_proto = proto__get(f1, func->state.proto, sizeof(func->state.proto));
> +	for (i = 0; i < s1->nr_parms; i++) {
> +		if (!types__match(encoder, btf1, s1->parms[i].type_id,
> +				  btf2, s2->parms[i].type_id)) {
> +			if (encoder->verbose) {
> +				const char *p1 = btf__name_by_offset(btf1, s1->parms[i].name_off);
> +				const char *p2 = btf__name_by_offset(btf2, s2->parms[i].name_off);
>  
> -	if (proto__get(f2, proto, sizeof(proto))) {
> -		if (strcmp(func->state.proto, proto) != 0) {
> -			if (encoder->verbose)
> -				printf("function mismatch for '%s'('%s'): '%s' != '%s'\n",
> -				       name, f1->alias ?: name,
> -				       func->state.proto, proto);
> +				printf("function mismatch for '%s'(%s): param#%d type mismatch %s %s %s\n",
> +				       name, other_name, i + 1,
> +				       p1 ?: "", p1 && p2 ? "!=" : "", p2 ?: "");
> +			}
>  			return false;
>  		}
>  	}
> @@ -886,9 +1037,56 @@ static bool funcs__match(struct btf_encoder *encoder, struct elf_function *func,
>  
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
>  	} else {
> -		func->state.type_id_off = encoder->type_id_off;
> -		func->function = fn;
> -		encoder->cu->functions_saved++;
> +		func->state = state;
>  	}
>  	return 0;
>  }
>  
> -static int32_t btf_encoder__add_func(struct btf_encoder *encoder, struct function *fn)
> +static int32_t btf_encoder__add_func(struct btf_encoder *encoder, struct function *fn, struct elf_function *func)
>  {
> -	int btf_fnproto_id, btf_fn_id, tag_type_id;
> -	struct llvm_annotation *annot;
> +	int btf_fnproto_id, btf_fn_id, tag_type_id = 0;
> +	int16_t component_idx = -1;
>  	const char *name;
> +	const char *value;
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
> +		struct btf_encoder_func_state *state = func->state;
> +		uint16_t idx;
> +
> +		if (!state || state->nr_annots == 0)
> +			return 0;
> +
> +		for (idx = 0; idx < state->nr_annots; idx++) {
> +			struct btf_encoder_func_annot *a = &state->annots[idx];
> +
> +			value = btf__str_by_offset(encoder->btf, a->value);
> +			component_idx = a->component_idx;
> +
> +			tag_type_id = btf_encoder__add_decl_tag(encoder, value, btf_fn_id, component_idx);
> +			if (tag_type_id < 0)
> +				break;
>  		}
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
> +		}
> +	}
> +	if (tag_type_id < 0) {
> +		fprintf(stderr, "error: failed to encode tag '%s' to func %s with component_idx %d\n",
> +			value, name, component_idx);
> +		return -1;
>  	}
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
> +		struct btf_encoder_func_state *state = func->state;
> +		struct btf_encoder *other_encoder = NULL;
>  
> -		if (!fn || fn->proto.processed)
> +		if (!state || state->processed)
>  			continue;
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
> +			other_state = other_func->state;
> +			if (!other_state)
>  				continue;
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
>  		}
>  		/* do not exclude functions with optimized-out parameters; they
>  		 * may still be _called_ with the right parameter values, they
>  		 * just do not _use_ them.  Only exclude functions with
>  		 * unexpected register use or multiple inconsistent prototypes.
>  		 */
> -		if (fn->proto.unexpected_reg || fn->proto.inconsistent_proto) {
> +		if (state->unexpected_reg || state->inconsistent_proto) {
>  			if (encoder->verbose) {
> -				const char *name = function__name(fn);
> -
>  				printf("skipping addition of '%s'(%s) due to %s\n",
> -				       name, fn->alias ?: name,
> -				       fn->proto.unexpected_reg ? "unexpected register used for parameter" :
> +				       func->alias ?: func->name,
> +				       func->alias ? func->name : func->alias,
> +				       state->unexpected_reg ? "unexpected register used for parameter" :
>  								   "multiple inconsistent function prototypes");
>  			}
>  		} else {
> -			encoder->type_id_off = func->state.type_id_off;
> -			btf_encoder__add_func(encoder, fn);
> +			if (btf_encoder__add_func(encoder, NULL, func))
> +				return -1;
>  		}
> -		fn->proto.processed = 1;
> +		state->processed = 1;
>  	}
> +	return 0;
>  }
>  
>  /*
> @@ -1058,11 +1294,9 @@ static int btf_encoder__collect_function(struct btf_encoder *encoder, GElf_Sym *
>  		encoder->functions.suffix_cnt++;
>  		encoder->functions.entries[encoder->functions.cnt].prefixlen = suffix - name;
>  	}
> +	encoder->functions.entries[encoder->functions.cnt].alias = NULL;
>  	encoder->functions.entries[encoder->functions.cnt].generated = false;
> -	encoder->functions.entries[encoder->functions.cnt].function = NULL;
> -	encoder->functions.entries[encoder->functions.cnt].state.got_proto = false;
> -	encoder->functions.entries[encoder->functions.cnt].state.proto[0] = '\0';
> -	encoder->functions.entries[encoder->functions.cnt].state.type_id_off = 0;
> +	encoder->functions.entries[encoder->functions.cnt].state = NULL;
>  	encoder->functions.cnt++;
>  	return 0;
>  }
> @@ -1236,7 +1470,7 @@ static int btf_encoder__encode_tag(struct btf_encoder *encoder, struct tag *tag,
>  	case DW_TAG_enumeration_type:
>  		return btf_encoder__add_enum_type(encoder, tag, conf_load);
>  	case DW_TAG_subroutine_type:
> -		return btf_encoder__add_func_proto(encoder, tag__ftype(tag));
> +		return btf_encoder__add_func_proto(encoder, tag__ftype(tag), NULL);
>          case DW_TAG_unspecified_type:
>  		/* Just don't encode this for now, converting anything with this type to void (0) instead.
>  		 *
> @@ -2128,8 +2362,22 @@ out_delete:
>  	return NULL;
>  }
>  
> +void btf_encoder__delete_func(struct elf_function *func)
> +{
> +	struct btf_encoder_func_state *state = func->state;
> +
> +	free(func->alias);
> +	if (state) {
> +		zfree(&state->annots);
> +		zfree(&state->parms);
> +		zfree(&func->state);
> +	}
> +}
> +
>  void btf_encoder__delete(struct btf_encoder *encoder)
>  {
> +	int i;
> +
>  	if (encoder == NULL)
>  		return;
>  
> @@ -2141,6 +2389,8 @@ void btf_encoder__delete(struct btf_encoder *encoder)
>  	encoder->btf = NULL;
>  	elf_symtab__delete(encoder->symtab);
>  
> +	for (i = 0; i < encoder->functions.cnt; i++)
> +		btf_encoder__delete_func(&encoder->functions.entries[i]);
>  	encoder->functions.allocated = encoder->functions.cnt = 0;
>  	free(encoder->functions.entries);
>  	encoder->functions.entries = NULL;
> @@ -2281,7 +2531,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
>  						       ", has optimized-out parameters" :
>  						       fn->proto.unexpected_reg ? ", has unexpected register use by params" :
>  						       "");
> -					fn->alias = func->name;
> +					func->alias = strdup(name);
>  				}
>  			}
>  			if (!func)
> @@ -2294,7 +2544,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
>  		if (save)
>  			err = btf_encoder__save_func(encoder, fn, func);
>  		else
> -			err = btf_encoder__add_func(encoder, fn);
> +			err = btf_encoder__add_func(encoder, fn, func);
>  		if (err)
>  			goto out;
>  	}
> @@ -2302,11 +2552,8 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
>  	if (!encoder->skip_encoding_vars)
>  		err = btf_encoder__encode_cu_variables(encoder);
>  
> -	/* It is only safe to delete this CU if we have not stashed any static
> -	 * functions for later addition.
> -	 */
>  	if (!err)
> -		err = encoder->cu->functions_saved > 0 ? LSK__KEEPIT : LSK__DELETE;
> +		err = LSK__DELETE;
>  out:
>  	encoder->cu = NULL;
>  	return err;
> -- 
> 2.43.5
