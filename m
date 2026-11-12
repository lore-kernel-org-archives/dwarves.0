Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794497196;
	b=3qrUNEiRDRprQcDk6YynV6IerlI00eqO+jvjMpyFAUZj9gg1efLq+tTLV6sRk7R5VMj9
	 LxXrOH/uHQFByIKHdikUxEDTmLffeddRkfCQPLJ1lMx7Mw/xhBhoTaGAJRq+mZ4Q5rmWJ
	 gP8VkovJosweccdpv9ShH9Fjq7M2J81cRl4nq8WM5qL8zavPqpKP6TqW33/twd5ztSwLp
	 5AvZfgRNTiL+si6yA/pS96sljF1I3rDa4adzQFni8aIz+bEtNp3bW63Z4z8i3mVS4rFIZ
	 5/yGxXL+R9s4469KZVE1idokU2xACEgXamA/VxZCXppa5jS7Pw8S5g6PdkHESdyU6IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794497196;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=D7K+gjYPU1+zc1Ew28qYuvbBMXEHVNChCyc/MmpO1Wk=;
	b=AcdWT3xKEst5+/03LsH5fVhM9F9+qmTNh6C9PvmWbprNly+MKsq9sKNZmE3mvMYH1/L5
	 hScRtMBEXRXYEyuzVmozexwvgAhBqqSLN+GOSa2cXaR77gbhNc1za3BXI0ApjIk3SSA0r
	 7vISGW6jIb89wPaQtt5+VqI6aMGZG3RwjCpdKOXDAHTtTVcUamspkF50iwFuWwHbFymvC
	 9iU7Z5eMmujdSjDOhKFJpCTLrqRtR8SXfUr91IpOD9utsG2uWYpzfMqT+io+XAD5XeOf9
	 7qkd2OMrIk0HA6Kh+XaXk4oU6891C0eLu6My32eLddpIgABv8EJRDlGEDBa3HBIy9iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=W6FsuYQU;
	arc=none smtp.remote-ip=91.218.175.172
Received: from mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FC9606A32E
	for <dwarves@vger.kernel.org>; Thu, 12 Nov 2026 15:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2FC9606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=W6FsuYQU
X-Envelope-To: dwarves@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Z3txQ2yt8kFeDJmHwbwGZDt+fjjN/wHa2N2LH+Xhsvo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794497193; v=1; x=1795101993;
 b=W6FsuYQUUxP7Kp378VPU2ATSmWT7IYRiOu6KPrfWnKcrNwE4TA5IsI6JYw9O1gLEgA0XcPRP
 /3IPOxJBDrANFU0Z3oLXK6TohLqXarzbMxZgbioxpzhv+nzI+UQsLYXRGDajPf4vbTm4mnyow7r
 QMQbTo124JzW/Gj4OQB2QdG4=
X-Envelope-To: dwarves@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id eba51540c4148465;
	Thu, 12 Nov 2026 15:26:32 +0000
X-Mizu-Trace-ID: eba51540c4148465
X-Migadu-Flow: FLOW_OUT
Message-ID: <f6f8e159-f0a3-45a4-b29c-093c45900949@linux.dev>
Date: Thu, 12 Nov 2026 07:26:29 -0800
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
To: Alan Maguire <almagui@kernel.org>, Alan Maguire
 <alan.maguire@oracle.com>, Arnaldo Carvalho de Melo
 <arnaldo.melo@gmail.com>, dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, kernel-team@fb.com, Breno Leitao <leitao@debian.org>
References: <20261111222447.322978-1-yonghong.song@linux.dev>
 <ffd8e847-6a3f-4403-a33c-1b3804e1c039@kernel.org>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <ffd8e847-6a3f-4403-a33c-1b3804e1c039@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/12/26 4:36 AM, Alan Maguire wrote:
> On 11/11/26 10:24 PM, Yonghong Song wrote:
>> The location based checks can drop kfuncs from BTF even though their ABI
>> did not change. With the arm64 KCSAN setup in the report, resolve_btfids
>> fails with:
>>
>>    WARN: resolve_btfids: no BTF func for kfunc bpf_tcp_ops_set_rcvlowat in bpf_tcp_ops_set_rcvlowat_kfunc_set
>>    WARN: resolve_btfids: unresolved symbol bpf_tcp_ops_set_rcvlowat
>>
>> The location list of 'rcvlowat' starts after the function entry, in a
>> callee-saved register, so the function is marked unexpected_reg and
>> skipped. scx_bpf_tid_to_task() hits the same skip through a
>> different DWARF pattern.
>>
>> Kfuncs are defined with __bpf_kfunc ("__used __retain __noclone
>> noinline"), so the compiler keeps the calling convention of the C
>> prototype. Odd parameter locations of a kfunc are debug info artifacts,
>> not ABI changes.
>>
>> For kfuncs, clear the location derived flags when saving the state,
>> keep all source parameters, and skip the location based checks, also in
>> btf_encoder__add_saved_funcs() where saved_functions_combine() can merge
>> the flags back in. The inconsistent prototype and ambiguous address
>> checks still apply.
>>
>> Kfuncs were only collected with decl_tag_kfuncs, which the kernel no
>> longer passes since commit 692393104909 ("resolve_btfids: Emit bpf_kfunc
>> and bpf_fastcall decl tags"). Collect them whenever BTF is encoded; the
>> decl tags are still only emitted with decl_tag_kfuncs.
>>
>> With this change, bpf_tcp_ops_set_rcvlowat() and scx_bpf_tid_to_task()
>> are encoded again, and no other function in vmlinux BTF changes.
>>
>> Reported-by: Breno Leitao <leitao@debian.org>
> I'm having trouble reproducing the original failure; would you mind sharing
> the config that reproduces it? I tried with clang 22, but no luck so far.
>
>> Closes: https://lore.kernel.org/all/au27Y9m78_3EH2v1@gmail.com/
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   btf_encoder.c | 49 +++++++++++++++++++++++++++++++++++--------------
>>   1 file changed, 35 insertions(+), 14 deletions(-)
>>
>> diff --git a/btf_encoder.c b/btf_encoder.c
>> index 05ffe82..4269467 100644
>> --- a/btf_encoder.c
>> +++ b/btf_encoder.c
>> @@ -1421,16 +1421,30 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
>>   			}
>>   		}
>>   	}
>> +
>> +	/*
>> +	 * A kfunc keeps the ABI of its C prototype, so reset the DWARF
>> +	 * location based flags: otherwise the kfunc may be treated as
>> +	 * optimized and skipped, or lose parameters in BTF.
>> +	 */
>> +	if (!loc && is_kfunc_state(state)) {
>> +		state->unexpected_reg = 0;
>> +		state->optimized_parms = 0;
>> +		state->uncertain_parm_loc = 0;
>> +		state->reordered_parm = 0;
>> +		state->signature_changed = 0;
>> +	}
>> +
> a nit I know, but to me this would read better if we did it above, i.e where we
> set these values to non-zero, and avoided doing so for the kfunc case, something like:
>
> 	/*
> 	 * A kfunc keeps the ABI of its C prototype, so avoid setting
> 	 * state flags, otherwise the kfunc may be treated as
> 	 * optimized and skipped, or lose parameters in BTF.  For other
> 	 * cases, ensure the optimizations/uncertainties are reflected
> 	 * in state flags.
> 	 */
> 	if (loc || !is_kfunc_state(state)) {
> 		state->inconsistent_proto = ftype->inconsistent_proto;
>          	state->unexpected_reg = ftype->unexpected_reg;
>          	state->optimized_parms = ftype->optimized_parms;
>          	state->uncertain_parm_loc = ftype->uncertain_parm_loc;
>          	state->reordered_parm = ftype->reordered_parm;
>          	state->signature_changed = ftype->signature_changed;
>          	if (state->addr && func) {
>                  	for (int i = 0; i < func->sym_cnt; i++) {
>                          	if (state->addr != func->syms[i].addr)
>                                  	continue;
>                          	if (str_contains_optimized_fn_suffix(func->syms[i].name)) {
>                                  	state->optimized_symbol = 1;
>                                  	break;
>                          	}
>                  	}
>          	}
> 	}
>
> Better to not set these values in the first place for kfuncs since we start
> with a zeroed out state.

Okay, Will send v2 with the above suggestion!

>
>
>>   	ftype__for_each_parameter(ftype, param) {
>>   		const char *name;
>>   		char *final_name = NULL;
>>   
>>   		/* No location info/optimized + reordered means optimized out. */
>> -		if (!loc && ftype->reordered_parm && (!param->has_loc || param->optimized)) {
>> +		if (!loc && state->reordered_parm && (!param->has_loc || param->optimized)) {
>>   			state->nr_parms--;
>>   			continue;
>>   		}
>> -		if (!loc && encoder->true_signature && ftype->signature_changed &&
>> +		if (!loc && encoder->true_signature && state->signature_changed &&
>>   		    param->optimized) {
>>   			state->nr_parms--;
>>   			continue;
>> @@ -1797,17 +1811,20 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
>>   		 * signature; true_signature can rewrite those signatures.
>>   		 * Also exclude functions with unexpected register use, multiple
>>   		 * inconsistent prototypes or uncertain parameter locations.
>> +		 * The location based checks do not apply to kfuncs.
>>   		 */
>> -		if (state->unexpected_reg)
>> -			skip_reason = "unexpected register usage for parameter\n";
>> +		if (!is_kfunc_state(state)) {
>> +			if (state->unexpected_reg)
>> +				skip_reason = "unexpected register usage for parameter\n";
>> +			if (state->uncertain_parm_loc)
>> +				skip_reason = "uncertain parameter location\n";
>> +			if (state->reordered_parm)
>> +				skip_reason = "reordered parameters\n";
>> +			if (btf_encoder_func_state__skip_optimized_parms(encoder, canonical_state))
>> +				skip_reason = "optimized parameters\n";
>> +		}
>>   		if (skip_encoding_inconsistent_proto && state->inconsistent_proto)
>>   			skip_reason = "inconsistet prototype\n";
>> -		if (state->uncertain_parm_loc)
>> -			skip_reason = "uncertain parameter location\n";
>> -		if (state->reordered_parm)
>> -			skip_reason = "reordered parameters\n";
>> -		if (btf_encoder_func_state__skip_optimized_parms(encoder, canonical_state))
>> -			skip_reason = "optimized parameters\n";
>>   		if (state->elf->ambiguous_addr)
>>   			skip_reason = "ambiguous address\n";
>>   
>> @@ -3056,10 +3073,14 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>>   		if (!found_percpu && encoder->verbose)
>>   			printf("%s: '%s' doesn't have '%s' section\n", __func__, cu->filename, PERCPU_SECTION);
>>   
>> -		if (encoder->tag_kfuncs) {
>> -			if (btf_encoder__collect_kfuncs(encoder))
>> -				goto out_delete;
>> -		}
>> +		/*
>> +		 * Mark kfuncs before any function state is saved, so
>> +		 * btf_encoder__save_func() keeps their source prototypes.
>> +		 * Needed even without decl_tag_kfuncs, which only controls
>> +		 * the decl tags.
>> +		 */
>> +		if (btf_encoder__collect_kfuncs(encoder))
>> +			goto out_delete;
>>   
>>   		if (encoder->verbose)
>>   			printf("File %s:\n", cu->filename);

