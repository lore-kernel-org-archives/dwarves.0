Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794673526;
	b=M4+05tnxN60mc6qaUrzEztIOh8ccBOLM+bBa7zldJ6wCt0IFrNszB+Z31S0aVyo/rYkQ
	 B4/ZYtlsTDw4oi+dl6GcXNz72hRuG3mCzYyYKKzrU1RbrouQYu7qQM0mbxNAcUj2ojQdr
	 wqZvQbWEOPd4usYv08YjInPkMx9LRav0JrP0X+kJA4askV9k1U5mhbSS2lW4UUD/gNTLa
	 wDpexeOMM4V6LuTxihmB0otYBPtmp7rz/Gz9uLpKY0XDxiEcNnaAnJiNvn8/olOYG2rQD
	 KBGuVXOVz6ARoKysc8k2tFBN90hrzOpEO8xKEqGV3FB2eyngg8mvdjUdhTzNNyS3SHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794673526;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=SqQMxeEG/rV3oOFhBA4WNyw3pi2YPDOttfW60TkJK8g=;
	b=SBERa0YtmK3oxk59hW/xab7xIEPM2ELHbZK1O6M7LF9loC7hwl3BuMWRRurebAEVa8vo
	 6CXBhTwiBqBqpFBwEftW+WFkLNiUqhUUVrmGd8V5U/lVWrTLf4w4lbo3llyKbXj5+d97L
	 FC5OnrPVkJ9dDLeI9DNFH9Yb+o08fhx4X7NHZb3YbduvE9jbMOEYCt3HerzTn64YZgxsr
	 cloc9ssGNcr0iWUr9wtlMNbPhPhK44GJ00xK8XazuuNfVowePZjNNAnrfakJ1k4HyXsWV
	 NrRSY+rrHNIzEoiA/U5OnnS+JrDSkJlsHwY7bd0AOeJT3SwDQg/Mmgy2lWcJLy7af0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IKzVTdBA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47362606A323;
	Sat, 14 Nov 2026 16:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IKzVTdBA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2FE1F000C8;
	Sat, 14 Nov 2026 16:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794673525;
	bh=SqQMxeEG/rV3oOFhBA4WNyw3pi2YPDOttfW60TkJK8g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=IKzVTdBA5GhsDqOGj5/JgPLtTAeeQAoS1iNi5qTYlFaymdTUg4EoBmT8bk5L/7ly8
	 PpTU7PlC94F5dtD6fR9DuYigP+UtWRkspm+m4dpgz41gs0gd0ei61FRmed8SuaNmAx
	 +o7HpgmRX2gEmGNAxA9q5UOz7Kx9jwch1837JE3i8r7kc7jRQwu4wq0gADyS8dPi3K
	 Juqt6AQIaqx5wkDTJke6yvHUv1xYNE2kjJSMc4mRV9OQTYlq5fClD7nzEXJN2GBf3z
	 iBxbFO2WxB5wCRfIwBbk/P4xqI1y025wvR75KrdKp43Rhw0QEBE7Nl5pwlws6QFrkm
	 HmCHVqZWc1XCQ==
Message-ID: <31d0e915-8a6c-475f-9208-5622cf0a81d7@kernel.org>
Date: Sat, 14 Nov 2026 16:25:22 +0000
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
Subject: Re: [PATCH dwarves v2] btf_encoder: Keep the source prototype of
 kfuncs
To: Yonghong Song <yonghong.song@linux.dev>,
 Alan Maguire <alan.maguire@oracle.com>,
 Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, kernel-team@fb.com, Breno Leitao <leitao@debian.org>
References: <20261112161129.1903805-1-yonghong.song@linux.dev>
Content-Language: en-GB
From: Alan Maguire <almagui@kernel.org>
In-Reply-To: <20261112161129.1903805-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/26 4:11 PM, Yonghong Song wrote:
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
> For kfuncs, do not set the flags when saving the state,
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
> Closes: https://lore.kernel.org/all/au27Y9m78_3EH2v1@gmail.com/
> Tested-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

Applied, thanks all!

Alan

> ---
>  btf_encoder.c | 71 +++++++++++++++++++++++++++++++--------------------
>  1 file changed, 44 insertions(+), 27 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 05ffe82..8537628 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -1405,32 +1405,42 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
>  			break;
>  		}
>  	}
> -	state->inconsistent_proto = ftype->inconsistent_proto;
> -	state->unexpected_reg = ftype->unexpected_reg;
> -	state->optimized_parms = ftype->optimized_parms;
> -	state->uncertain_parm_loc = ftype->uncertain_parm_loc;
> -	state->reordered_parm = ftype->reordered_parm;
> -	state->signature_changed = ftype->signature_changed;
> -	if (state->addr && func) {
> -		for (int i = 0; i < func->sym_cnt; i++) {
> -			if (state->addr != func->syms[i].addr)
> -				continue;
> -			if (str_contains_optimized_fn_suffix(func->syms[i].name)) {
> -				state->optimized_symbol = 1;
> -				break;
> +	/*
> +	 * A kfunc keeps the ABI of its C prototype, so avoid setting
> +	 * state flags, otherwise the kfunc may be treated as
> +	 * optimized and skipped, or lose parameters in BTF.  For other
> +	 * cases, ensure the optimizations/uncertainties are reflected
> +	 * in state flags.
> +	 */
> +	if (loc || !is_kfunc_state(state)) {
> +		state->inconsistent_proto = ftype->inconsistent_proto;
> +		state->unexpected_reg = ftype->unexpected_reg;
> +		state->optimized_parms = ftype->optimized_parms;
> +		state->uncertain_parm_loc = ftype->uncertain_parm_loc;
> +		state->reordered_parm = ftype->reordered_parm;
> +		state->signature_changed = ftype->signature_changed;
> +		if (state->addr && func) {
> +			for (int i = 0; i < func->sym_cnt; i++) {
> +				if (state->addr != func->syms[i].addr)
> +					continue;
> +				if (str_contains_optimized_fn_suffix(func->syms[i].name)) {
> +					state->optimized_symbol = 1;
> +					break;
> +				}
>  			}
>  		}
>  	}
> +
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
> @@ -1797,17 +1807,20 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
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
> @@ -3056,10 +3069,14 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
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

