Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2968C155C82
	for <dwarves@vger.kernel.org>; Wed, 24 Jun 2026 01:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782264101; cv=none; b=RUc0Zl2s3S1L3e2yGwZ4okEb8j3GD+Oz5nslENmE6f47OdpQRs3HbqCf+ezmLpc3n7qgImvq5dOKgonCne8wkL2vMHLNmdja9AbsZglaj9sTvgMiFKaxeMDe9f/WX2d94AwEHQEU+bqHTZF3fi5nQN9JT7zKrSa+5v2MUdrg2k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782264101; c=relaxed/simple;
	bh=OE3fSHufB/LuEgmF/EsVYwiZMhTsMj64DJi1OHdsRis=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XLaa3hfJ6luIbb02a4Bm0Jg21g1ixrPdrNC7LHvMuSBonbGZP/8kEHxQSrrlYOnDwcpjlg1+3x0WgbWbJ0WOZoaZOaJU2rdEG+SrezZF6m7SL1RY7xTqLOzwn70+vRjDEcnoESF54WPDvL9bTIXA+DckL0QmKOd8i4X/p3GWqKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DIrh1rnV; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DIrh1rnV"
Message-ID: <7e2960f3-cad7-46a5-a691-29228fb696c6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782264096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f/QG5bAo3i7DHmVc1k0D7c5ENPcyHrpmZqoruK2f0jA=;
	b=DIrh1rnVmXjCLJRMlXl4ZBHifdfRPyYo6n3aBipvJTixr/cm/bCeAzTAGC5qVGGqD2gKcg
	DGtl3J4EEerJh5RvP7ucE+Mk2hpI1hqeY+OkX0d7JPHQsKALed7C8wtbVG3zMoGPTV5m6S
	OeExji84K8N1I+XRgAUSw+X5YMWF/uk=
Date: Tue, 23 Jun 2026 18:21:16 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves v8 3/5] dwarf_loader: Analyze per-parameter
 information for true signatures
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
 Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, kernel-team@fb.com
References: <20260623222850.3290612-1-yonghong.song@linux.dev>
 <20260623222906.3293063-1-yonghong.song@linux.dev>
In-Reply-To: <20260623222906.3293063-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/23/26 3:29 PM, Yonghong Song wrote:
> Add a function-level pass, function__analyze_parameter_locations(), run
> from cu__resolve_func_ret_types_optimized() which walks a function's
> parameters in ABI argument-register order and consumes the location state
> decoded by parameter__decode_location() in the previous commit. Each
> parameter advances the expected-register index by the number of argument
> registers it occupies (parameter__abi_slots(), e.g. a two-eightbyte
> aggregate consumes two registers).
>
> For every producer it keeps the existing bookkeeping, now driven by the
> decoded fields:
>   - a parameter with no location, a constant value, or (for non-clang) no
>     register found is marked optimized out
>   - a parameter found in a register other than the expected one is marked
>     unexpected_reg
>
> When true_signature is enabled it reconstructs the real register-level
> signature:
>   - parameters that were optimized out are dropped from the signature
>   - a parameter whose location cannot be tied to its expected register,
>     wrong register, no register found, or a non-aggregate sitting on the
>     stack - marks the function unexpected_reg so no untrustworthy signature
>     is emitted;
>   - an aggregate genuinely passed on the stack (passed_in_memory) is kept;
>   - an aggregate split across registers via DW_OP_piece is kept whole when
>     it is fully used or the next parameter still lands on its expected
>     register, otherwise it is rewritten to the single member actually passed
>     in a register (true_sig_*).
>
> Together with the decoding commit this replaces the previous inline,
> per-parameter register check in parameter__new().
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>   dwarf_loader.c | 152 ++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 149 insertions(+), 3 deletions(-)
>
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 01954c6..7ccad93 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -3013,6 +3013,150 @@ static void ftype__recode_dwarf_types(struct tag *tag, struct cu *cu)
>   	}
>   }
>   
> +static struct parameter *ftype__next_parameter(struct ftype *ftype, struct parameter *parm)
> +{
> +	if (parm->tag.node.next == &ftype->parms)
> +		return NULL;
> +	return list_entry(parm->tag.node.next, struct parameter, tag.node);
> +}
> +
> +static int parameter__abi_slots(const struct parameter *parm, const struct cu *cu)
> +{
> +	int slots;
> +
> +	if (!cu->agg_use_two_regs || parm->type_byte_size <= cu->addr_size)
> +		return 1;
> +
> +	slots = (parm->type_byte_size + cu->addr_size - 1) / cu->addr_size;
> +	return slots > 0 ? slots : 1;
> +}
> +
> +static bool parameter__has_piece_info(const struct parameter *parm)
> +{
> +	return parm->first_reg_fields || parm->second_reg_fields;
> +}
> +
> +static bool parameter__uses_full_aggregate(const struct parameter *parm)
> +{
> +	return parm->first_reg_fields && parm->second_reg_fields;
> +}
> +
> +static bool ftype__next_parameter_preserves_slots(struct ftype *ftype, struct parameter *parm,
> +						  int reg_idx, int slots, struct cu *cu)
> +{
> +	struct parameter *next = ftype__next_parameter(ftype, parm);
> +	int next_reg_idx;
> +
> +	if (!next || next->loc_reg == PARAMETER_UNKNOWN_REG)
> +		return false;
> +
> +	next_reg_idx = reg_idx + slots;
> +	return next_reg_idx < cu->nr_register_params &&
> +	       next->loc_reg == cu->register_params[next_reg_idx];
> +}
> +
> +static bool parameter__apply_true_sig_member(struct parameter *parm, struct cu *cu)
> +{
> +	struct dwarf_tag tmp = {};
> +	struct dwarf_tag *dtype;
> +
> +	if (!parm->true_sig_member_name || parm->true_sig_type == 0)
> +		return false;
> +
> +	tmp.type = parm->true_sig_type;
> +	tmp.from_types_section.type = parm->true_sig_type_from_types;
> +	dtype = __dwarf_cu__find_type_by_ref(cu->priv, tmp.type, tmp.from_types_section.type);
> +	if (!dtype)
> +		return false;
> +
> +	parm->tag.type = dtype->small_id;
> +	return true;
> +}
> +
> +static void function__analyze_parameter_locations(struct function *fn, struct cu *cu,
> +						  struct conf_load *conf)
> +{
> +	struct ftype *ftype = &fn->proto;
> +	struct parameter *pos;
> +	bool true_sig_enabled = conf->true_signature;
> +	int reg_idx = 0;
> +
> +	ftype__for_each_parameter(ftype, pos) {
> +		bool consumes_register = true;
> +		bool regs_available = reg_idx < cu->nr_register_params;
> +		int slots = parameter__abi_slots(pos, cu);
> +		int expected_reg = regs_available ? cu->register_params[reg_idx] : -1;
> +		int reg_slots = pos->passed_in_memory ? 1 : slots;
> +
> +		if (pos->has_loc) {
> +			if (true_sig_enabled && pos->loc_const_value) {
> +				pos->optimized = 1;
> +				consumes_register = false;
> +				goto next;
> +			}
> +
> +			if (!regs_available) {
> +				consumes_register = false;
> +				goto next;
> +			}
> +
> +			if (true_sig_enabled && pos->loc_stack) {
> +				if (pos->passed_in_memory)
> +					consumes_register = false;
> +				else
> +					pos->unexpected_reg = 1;
> +				goto next;
> +			}
> +
> +			if (pos->loc_reg == PARAMETER_UNKNOWN_REG) {
> +				if (true_sig_enabled)
> +					pos->unexpected_reg = 1;
> +				else
> +					pos->optimized = 1;
> +				goto next;
> +			}
> +
> +			if (expected_reg >= 0 && expected_reg != pos->loc_reg) {
> +				pos->unexpected_reg = 1;
> +				goto next;
> +			}
> +
> +			if (true_sig_enabled && parameter__has_piece_info(pos)) {
> +				if (parameter__uses_full_aggregate(pos)) {
> +					reg_idx += slots;
> +					continue;
> +				}
> +
> +				if (ftype__next_parameter_preserves_slots(ftype, pos, reg_idx, slots, cu)) {
> +					pos->true_sig_member_name = 0;
> +					reg_idx += slots;
> +					continue;
> +				}
> +
> +				if (parameter__apply_true_sig_member(pos, cu)) {
> +					reg_idx++;
> +					continue;
> +				}
> +			}
> +		} else if (pos->has_const_value && !cu->producer_clang) {
> +			pos->optimized = 1;
> +		} else if (true_sig_enabled) {
> +			if (regs_available &&
> +			    ftype__next_parameter_preserves_slots(ftype, pos, reg_idx, slots, cu)) {
> +				reg_idx += slots;
> +				continue;
> +			}
> +
> +			pos->optimized = 1;
> +			consumes_register = false;
> +		}
> +
> +next:
> +		if (consumes_register)
> +			reg_idx += reg_slots;
> +	}
> +}
> +
>   static void lexblock__recode_dwarf_types(struct lexblock *tag, struct cu *cu)
>   {
>   	struct tag *pos;
> @@ -3288,7 +3432,7 @@ static bool param__is_struct(struct cu *cu, struct tag *tag)
>   	}
>   }
>   
> -static int cu__resolve_func_ret_types_optimized(struct cu *cu)
> +static int cu__resolve_func_ret_types_optimized(struct cu *cu, struct conf_load *conf)
>   {
>   	struct ptr_table *pt = &cu->functions_table;
>   	uint32_t i;
> @@ -3299,6 +3443,8 @@ static int cu__resolve_func_ret_types_optimized(struct cu *cu)
>   		struct function *fn = tag__function(tag);
>   		bool has_unexpected_reg = false, has_struct_param = false;
>   
> +		function__analyze_parameter_locations(fn, cu, conf);
> +
>   		/* mark function as optimized if parameter is, or
>   		 * if parameter does not have a location; at this
>   		 * point location presence has been marked in
> @@ -3477,7 +3623,7 @@ static int die__process_and_recode(Dwarf_Die *die, struct cu *cu, struct conf_lo
>   	if (ret != 0)
>   		return ret;
>   
> -	return cu__resolve_func_ret_types_optimized(cu);
> +	return cu__resolve_func_ret_types_optimized(cu, conf);
>   }
>   
>   static int class_member__cache_byte_size(struct tag *tag, struct cu *cu,
> @@ -4240,7 +4386,7 @@ static int cus__merge_and_process_cu(struct cus *cus, struct conf_load *conf,
>   	 * encoded in another subprogram through abstract_origin
>   	 * tag. Let us visit all subprograms again to resolve this.
>   	 */
> -	if (cu__resolve_func_ret_types_optimized(cu) != LSK__KEEPIT)
> +	if (cu__resolve_func_ret_types_optimized(cu, conf) != LSK__KEEPIT)
>   		goto out_abort;
>   
>   	cu__finalize(cu, cus, conf);

Okay, I think there exists a problem here.
For example, if there is function without nocall:
      foo(a, b, c, d)
where a: RDI, b/c: no locations, d: RCX

of another function with nocall:
      bar(a, b, c, d)
where a: RDI, b/c: no locations, d: RSI

Without nocall, we expect the next argument e.g. 'b' will stay.
Here, no-nocall means source signatures are not changed (although locations may differ from ABI).

With nocall, we expect the next argument e.g., 'b' will be optimized.

I will fix it in the next revision.

