Received: from mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A7D49B1EE
	for <dwarves@vger.kernel.org>; Fri, 11 Sep 2026 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789142563; cv=none; b=QZcsR1nenKBhUToe39O90gLNnMvlVfGJLZ8oUXj0R/FK1nNli74PeNF+krppjqDsPrmbuTmH4jIxJj03jJatVpijlxVGGeH2ANl4fh3ke09tYbhRNZnNtYtkLy50B9QGf7Ls+k4qm3G9mPBcUXzoV9tJamdez1w/rnnptbHUN1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789142563; c=relaxed/simple;
	bh=Yzu4lELF2/wu31YhDvHBWMP/NO98sJKx0FXvxqvX1/s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=O8oOnKcwbE+PKbS241XPpLW/DWj6h/hq6cQdsQJHnDSYmDAJQ4ZyWA1I6ayTTW+OZsT89WqLOMaVvsl3cpfw50oRLBzh5jDmcmQL/4rFhmbeW1N3zaaIK0T0oa4iVgj1JzRegCRv6fa6d+pVkE1P/rCTTRcfo6fWuPqKpyRJ9L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TTbAZpgc; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TTbAZpgc"
X-Envelope-To: dwarves@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Yzu4lELF2/wu31YhDvHBWMP/NO98sJKx0FXvxqvX1/s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789142557; v=1; x=1789747357;
 b=TTbAZpgcyN6lkRhV5JixIyiD9ibsNvaJ+YKYK7uBI5X8RiDF8xkfrfhNQxiUdUZwSIAI5a/H
 QGgoveLxQbyHf2UXUxVJ7k5dWETa+iqsRdjgQTqk6tskoogr5Hg82frdWTCFE082FvskyM8ToAz
 L6FUR4aKVTrm3xFfKdf8vgVo=
X-Envelope-To: dwarves@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 49b2b93d59cf757f;
	Fri, 11 Sep 2026 16:02:27 +0000
X-Mizu-Trace-ID: 49b2b93d59cf757f
X-Migadu-Flow: FLOW_OUT
Message-ID: <9ab375a7-be14-4479-80cd-41735539e8ef@linux.dev>
Date: Fri, 11 Sep 2026 09:02:23 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves 1/2] dwarf_loader: Skip the argument register the
 arm64 ABI leaves as a hole
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
 Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, kernel-team@fb.com
References: <20260911040955.339939-1-yonghong.song@linux.dev>
In-Reply-To: <20260911040955.339939-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/10/26 9:09 PM, Yonghong Song wrote:
> arm64 requires an argument whose alignment is twice the register size to
> start on an even-numbered argument register, so such an argument arriving
> when the next free register is an odd one leaves that register unused:
>
>    u64 f_odd(u64 a, __int128 v, u64 b);
>
> passes a in x0, v in x2:x3 -- skipping x1 -- and b in x4.  The x86-64 ABI
> has no such rule and packs v into rsi:rdx instead.

The kernel patch (bpf: Support by-value struct and __int128 arguments)
   https://lore.kernel.org/bpf/20260911154914.2004336-1-yonghong.song@linux.dev/
depends on this pahole patch. See kernel patch 15.

It would be great if this patch can be reviewed soon.

>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>   dwarf_loader.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++---
>   dwarves.h      |  1 +
>   2 files changed, 51 insertions(+), 3 deletions(-)
>
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 61ef52f..81c2076 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -1501,6 +1501,23 @@ static bool arch__agg_use_two_regs(const GElf_Ehdr *ehdr)
>   	}
>   }
>   
> +/*
> + * Some ABIs require an argument whose alignment is twice the register size to
> + * start on an even-numbered argument register, leaving a hole when the next
> + * free register is an odd one. For example, on arm64,
> + *	u64 f(u64 a, __int128 v, u64 b)
> + * passes a in x0, v in x2:x3 -- skipping x1 -- and b in x4.
> + */
> +static bool arch__arg_align_two_regs(const GElf_Ehdr *ehdr)
> +{
> +	switch (ehdr->e_machine) {
> +	case EM_AARCH64:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>   static struct template_type_param *template_type_param__new(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
>   {
>   	struct template_type_param *ttparm = tag__alloc(cu, sizeof(*ttparm));
> @@ -3634,6 +3651,28 @@ static int parameter__abi_slots(const struct parameter *parm, const struct cu *c
>   	return slots > 0 ? slots : 1;
>   }
>   
> +static int parameter__abi_reg_align(const struct parameter *parm, const struct cu *cu)
> +{
> +	struct tag *type;
> +
> +	if (!cu->arg_align_two_regs || parm->type_byte_size <= cu->addr_size)
> +		return 1;
> +
> +	type = tag__strip_typedefs_and_modifiers(&parm->tag, cu);
> +	if (type == NULL)
> +		return 1;
> +
> +	return tag__natural_alignment(type, cu) > cu->addr_size ? 2 : 1;
> +}
> +
> +static int parameter__align_reg_idx(const struct parameter *parm, int reg_idx,
> +				    const struct cu *cu)
> +{
> +	int align = parameter__abi_reg_align(parm, cu);
> +
> +	return (reg_idx + align - 1) & ~(align - 1);
> +}
> +
>   static bool parameter__has_piece_info(const struct parameter *parm)
>   {
>   	return parm->first_reg_fields || parm->second_reg_fields;
> @@ -3653,7 +3692,7 @@ static bool ftype__next_parameter_preserves_slots(struct ftype *ftype, struct pa
>   	if (!next || next->loc_reg == PARAMETER_UNKNOWN_REG)
>   		return false;
>   
> -	next_reg_idx = reg_idx + slots;
> +	next_reg_idx = parameter__align_reg_idx(next, reg_idx + slots, cu);
>   	return next_reg_idx < cu->nr_register_params &&
>   	       next->loc_reg == cu->register_params[next_reg_idx];
>   }
> @@ -3702,6 +3741,7 @@ static void function__match_clang_parameter_locations(struct ftype *ftype, struc
>   		if (pos->passed_in_memory)
>   			continue;
>   
> +		reg_idx = parameter__align_reg_idx(pos, reg_idx, cu);
>   		if (reg_idx >= cu->nr_register_params)
>   			break;
>   
> @@ -3732,11 +3772,17 @@ static void function__analyze_parameter_locations(struct function *fn, struct cu
>   
>   	ftype__for_each_parameter(ftype, pos) {
>   		bool consumes_register = true;
> -		bool regs_available = reg_idx < cu->nr_register_params;
> +		bool regs_available;
>   		int slots = parameter__abi_slots(pos, cu);
> -		int expected_reg = regs_available ? cu->register_params[reg_idx] : -1;
> +		int expected_reg;
>   		int reg_slots = pos->passed_in_memory ? 1 : slots;
>   
> +		if (!pos->passed_in_memory)
> +			reg_idx = parameter__align_reg_idx(pos, reg_idx, cu);
> +
> +		regs_available = reg_idx < cu->nr_register_params;
> +		expected_reg = regs_available ? cu->register_params[reg_idx] : -1;
> +
>   		if (pos->has_loc) {
>   			if (true_sig_enabled && pos->loc_const_value) {
>   				pos->optimized = 1;
> @@ -4467,6 +4513,7 @@ static int cu__set_common(struct cu *cu, struct conf_load *conf,
>   	cu->little_endian = ehdr.e_ident[EI_DATA] == ELFDATA2LSB;
>   	cu->nr_register_params = arch__nr_register_params(&ehdr);
>   	cu->agg_use_two_regs = arch__agg_use_two_regs(&ehdr);
> +	cu->arg_align_two_regs = arch__arg_align_two_regs(&ehdr);
>   	arch__set_register_params(&ehdr, cu);
>   	return 0;
>   }
> diff --git a/dwarves.h b/dwarves.h
> index df77f1e..70adbbf 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -304,6 +304,7 @@ struct cu {
>   	uint8_t		 little_endian:1;
>   	uint8_t		 producer_clang:1;
>   	uint8_t		 agg_use_two_regs:1;	/* An aggregate like {long a; long b;} */
> +	uint8_t		 arg_align_two_regs:1;	/* An over-aligned arg starts on an even register */
>   	uint8_t		 nr_register_params;
>   	int		 register_params[ARCH_MAX_REGISTER_PARAMS];
>   	int		 functions_saved;

