Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794486993;
	b=exo5uTR1Pc2KCJz/6Xn8kaPQXtTXK2piMRlj5qLSsnxIAEkPU8TWasBnGxRleffmWLil
	 pIijuVDmCaYuivqlmIG/8Sgyq6LHzvZpCwbwy5C1ZupRUjO7YOUzSO4fhGgGoREHC5Wfs
	 o6VAyMRJ8tRpEYU2cKkY58Qiwnhx3mD0Iapo0QqcX2CEkOBLs8E/Dkfly0jK7O7PkYQHB
	 Jacn5b8Q71GU4FiHxR50h/ANZajH+T61P2jkKF21RJMhpVnOFcFsXSxEx/OW/IMGxAqmh
	 VCqe2j9CpS1P5FGn4XIwZYxC1F3yL618K2jNngf7hjfRdS6hPiAVvPIzrWiULy0IfYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486993;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=b2yab4TmlDdnm6ekFumnPwh9ELMK/czvlj78R1kvZx4=;
	b=lqKVLz2NCyPDbuWhbDEWM8tkwda6eithg31pBU8RgoNcHUeTDsW8+QOFPWQKXnbzTj2/
	 VYyvOy+SlZC2h/AieSVy2EGgZ5OL53nRq2Ig1Bu7s3AX9jCNhNORg2ywoobYAZp32X/vh
	 DmgQsMMfVA2daBwJceOonVR648zONtUt0XEMJO+ZhyrG2rtgNWVDrO3wWfad2xakSX7YZ
	 7BtVF/EI3b9mOnMgUYeAieRfoAdpKkYGt6eksS22me7FbwnhJVldhCagKixtlcWN0WLIw
	 ZjWZMCrJGQ067+dFsjuw13wkSqmM8+dph+pinOV5fERLdgxp/0npY56iwGrpI9lSQuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="C0/owBmu";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6818606A327;
	Thu, 12 Nov 2026 12:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C0/owBmu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533B11F00A08;
	Thu, 12 Nov 2026 12:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794486993;
	bh=b2yab4TmlDdnm6ekFumnPwh9ELMK/czvlj78R1kvZx4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=C0/owBmu6K+sD3BHBpFB9JjT6CnKW8eYgbxFj24OGOi2Rh76jHAWuxVNuyJjDCDtf
	 9GKZA5Bru6GsQyMrd20cVm+W7YfC1Bn6HYA8uat1Sap4wbXUbu/BJ+9V6ERhk7fgrH
	 UFPg4ebHnyPW9KLThB5PEA7RTSxOrsQP67v8LNKaQsn6Nqcx2kfoOrGmYuphU08m5w
	 EjPkgAznraIENkAW5cH4TQb3oouHbQeubrj4IyId9BS4OC58Mk+2R7DnqoJ3S2v+77
	 jU2dxg5TIxiZ9iAV763uUtzs9UOXr5vnYIYaC6x8UleVEus0g6V2P5+iAj8JypVUQU
	 NER2S5mjJld3Q==
Message-ID: <ffd8e847-6a3f-4403-a33c-1b3804e1c039@kernel.org>
Date: Thu, 12 Nov 2026 12:36:29 +0000
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Post: <mailto:dwarves@vger.kernel.org>
List-Help: <mailto:dwarves+help@vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
List-Owner: <mailto:dwarves+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves] btf_encoder: Keep the source prototype of kfuncs
To: Yonghong Song <yonghong.song@linux.dev>,
 Alan Maguire <alan.maguire@oracle.com>,
 Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, kernel-team@fb.com, Breno Leitao <leitao@debian.org>
References: <20261111222447.322978-1-yonghong.song@linux.dev>
Content-Language: en-GB
From: Alan Maguire <almagui@kernel.org>
In-Reply-To: <20261111222447.322978-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/26 10:24 PM, Yonghong Song wrote:
> The location based checks can drop kfuncs from BTF even though their ABI
> did not change. With the arm64 KCSAN setup in the report, resolve_btfids
> fails with:
> 
>   WARN: resolve_btfids: no BTF func for kfunc bpf_tcp_ops_set_rcvlowat in bpf_tcp_ops_set_rcvlowat_kfunc_set
>   WARN: resolve_btfids: unresolved symbol bpf_tcp_ops_set_rcvlowat
> 
> The location list of 'rcvlowat' starts after the function entry, in a
> callee-saved register, so the function is marked unexpected_reg and
> skipped. scx_bpf_tid_to_task() hits the same skip through a
> different DWARF pattern.
> 
> Kfuncs are defined with __bpf_kfunc ("__used __retain __noclone
> noinline"), so the compiler keeps the calling convention of the C
> prototype. Odd parameter locations of a kfunc are debug info artifacts,
> not ABI changes.
> 
> For kfuncs, clear the location derived flags when saving the state,
> keep all source parameters, and skip the location based checks, also in
> btf_encoder__add_saved_funcs() where saved_functions_combine() can merge
> the flags back in. The inconsistent prototype and ambiguous address
> checks still apply.
> 
> Kfuncs were only collected with decl_tag_kfuncs, which the kernel no
> longer passes since commit 692393104909 ("resolve_btfids: Emit bpf_kfunc
> and bpf_fastcall decl tags"). Collect them whenever BTF is encoded; the
> decl tags are still only emitted with decl_tag_kfuncs.
> 
> With this change, bpf_tcp_ops_set_rcvlowat() and scx_bpf_tid_to_task()
> are encoded again, and no other function in vmlinux BTF changes.
> 
> Reported-by: Breno Leitao <leitao@debian.org>

I'm having trouble reproducing the original failure; would you mind sharing
the config that reproduces it? I tried with clang 22, but no luck so far.

> Closes: https://lore.kernel.org/all/au27Y9m78_3EH2v1@gmail.com/
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  btf_encoder.c | 49 +++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 35 insertions(+), 14 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 05ffe82..4269467 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -1421,16 +1421,30 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
>  			}
>  		}
>  	}
> +
> +	/*
> +	 * A kfunc keeps the ABI of its C prototype, so reset the DWARF
> +	 * location based flags: otherwise the kfunc may be treated as
> +	 * optimized and skipped, or lose parameters in BTF.
> +	 */
> +	if (!loc && is_kfunc_state(state)) {
> +		state->unexpected_reg = 0;
> +		state->optimized_parms = 0;
> +		state->uncertain_parm_loc = 0;
> +		state->reordered_parm = 0;
> +		state->signature_changed = 0;
> +	}
> +

a nit I know, but to me this would read better if we did it above, i.e where we
set these values to non-zero, and avoided doing so for the kfunc case, something like:

	/*
	 * A kfunc keeps the ABI of its C prototype, so avoid setting
	 * state flags, otherwise the kfunc may be treated as
	 * optimized and skipped, or lose parameters in BTF.  For other
	 * cases, ensure the optimizations/uncertainties are reflected
	 * in state flags.
	 */
	if (loc || !is_kfunc_state(state)) {
		state->inconsistent_proto = ftype->inconsistent_proto;
        	state->unexpected_reg = ftype->unexpected_reg;
        	state->optimized_parms = ftype->optimized_parms;
        	state->uncertain_parm_loc = ftype->uncertain_parm_loc;
        	state->reordered_parm = ftype->reordered_parm;
        	state->signature_changed = ftype->signature_changed;
        	if (state->addr && func) {
                	for (int i = 0; i < func->sym_cnt; i++) {
                        	if (state->addr != func->syms[i].addr)
                                	continue;
                        	if (str_contains_optimized_fn_suffix(func->syms[i].name)) {
                                	state->optimized_symbol = 1;
                                	break;
                        	}
                	}
        	}
	}

Better to not set these values in the first place for kfuncs since we start
with a zeroed out state.


>  	ftype__for_each_parameter(ftype, param) {
>  		const char *name;
>  		char *final_name = NULL;
>  
>  		/* No location info/optimized + reordered means optimized out. */
> -		if (!loc && ftype->reordered_parm && (!param->has_loc || param->optimized)) {
> +		if (!loc && state->reordered_parm && (!param->has_loc || param->optimized)) {
>  			state->nr_parms--;
>  			continue;
>  		}
> -		if (!loc && encoder->true_signature && ftype->signature_changed &&
> +		if (!loc && encoder->true_signature && state->signature_changed &&
>  		    param->optimized) {
>  			state->nr_parms--;
>  			continue;
> @@ -1797,17 +1811,20 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
>  		 * signature; true_signature can rewrite those signatures.
>  		 * Also exclude functions with unexpected register use, multiple
>  		 * inconsistent prototypes or uncertain parameter locations.
> +		 * The location based checks do not apply to kfuncs.
>  		 */
> -		if (state->unexpected_reg)
> -			skip_reason = "unexpected register usage for parameter\n";
> +		if (!is_kfunc_state(state)) {
> +			if (state->unexpected_reg)
> +				skip_reason = "unexpected register usage for parameter\n";
> +			if (state->uncertain_parm_loc)
> +				skip_reason = "uncertain parameter location\n";
> +			if (state->reordered_parm)
> +				skip_reason = "reordered parameters\n";
> +			if (btf_encoder_func_state__skip_optimized_parms(encoder, canonical_state))
> +				skip_reason = "optimized parameters\n";
> +		}
>  		if (skip_encoding_inconsistent_proto && state->inconsistent_proto)
>  			skip_reason = "inconsistet prototype\n";
> -		if (state->uncertain_parm_loc)
> -			skip_reason = "uncertain parameter location\n";
> -		if (state->reordered_parm)
> -			skip_reason = "reordered parameters\n";
> -		if (btf_encoder_func_state__skip_optimized_parms(encoder, canonical_state))
> -			skip_reason = "optimized parameters\n";
>  		if (state->elf->ambiguous_addr)
>  			skip_reason = "ambiguous address\n";
>  
> @@ -3056,10 +3073,14 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>  		if (!found_percpu && encoder->verbose)
>  			printf("%s: '%s' doesn't have '%s' section\n", __func__, cu->filename, PERCPU_SECTION);
>  
> -		if (encoder->tag_kfuncs) {
> -			if (btf_encoder__collect_kfuncs(encoder))
> -				goto out_delete;
> -		}
> +		/*
> +		 * Mark kfuncs before any function state is saved, so
> +		 * btf_encoder__save_func() keeps their source prototypes.
> +		 * Needed even without decl_tag_kfuncs, which only controls
> +		 * the decl tags.
> +		 */
> +		if (btf_encoder__collect_kfuncs(encoder))
> +			goto out_delete;
>  
>  		if (encoder->verbose)
>  			printf("File %s:\n", cu->filename);

