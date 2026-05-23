Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C119234964
	for <dwarves@vger.kernel.org>; Sat, 23 May 2026 16:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779553388; cv=none; b=EXkRjZFqjoXTAaAJBEejBdw36jXiRG2r6ZAekEqX3MiaI+mDMXvdqlbVRqntFVX7PJRFCTyXOlF0G70EySLjtRU/K5/EwCsd72jSfgtJrDrFwJ/Uj3HTuj9pwdIQXmzdGOlS02YlHPwPgXW3EIGApkh04Qci/uj7I71HEvrrCxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779553388; c=relaxed/simple;
	bh=ppMz9A7CnCHocITTpRSkg+GjAVosAqCxaQ9PqDSw0/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kP+W4LDyh3CExueeaJO2xrtawV3/Gp/G7lgmjRWJduNTKjcqPBUDZ9IuE3Pu3QB09o8wgf2cNzAXZonFuVRrFPOzX0MqcfQz5ByFBpytXVsIYkfsfykthQ9j5Gj3NyjaA72dUWzswmS3DAGxe/l8MiB0m+NRpqLWjO5O/kFNaiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DdZfdyQC; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DdZfdyQC"
Message-ID: <71ef8e07-832a-4508-8fd6-bab919271117@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779553374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7kLLr6flveYuO3dIYueme63KjGn82ZZR1ll8+Op8OJo=;
	b=DdZfdyQCZ8RXm2oOfY+KL3F1CYxNvpwe8OD99wO5yGNwkW0J4wf8FmN+Ua6DVjuxLevNeq
	GepURhSEXRcp3HF0B/EXZqGocJPI+yMV6m9FQ+waGfu5+V245uTHDh84dc0LuTKbn22xhe
	nYPjQGNXYNoADyVwj94ret3Oa3RQ6J0=
Date: Sat, 23 May 2026 09:22:46 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves v4 01/11] dwarf_loader: Reduce parameter checking
 with clang DW_AT_calling_convention attr
Content-Language: en-GB
To: Alan Maguire <alan.maguire@oracle.com>,
 Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, kernel-team@fb.com
References: <20260326013144.2901265-1-yonghong.song@linux.dev>
 <20260326013149.2902251-1-yonghong.song@linux.dev>
 <b90f8fb7-539c-468f-a6e5-56cd8687896f@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <b90f8fb7-539c-468f-a6e5-56cd8687896f@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 3/30/26 1:31 AM, Alan Maguire wrote:
> On 26/03/2026 01:31, Yonghong Song wrote:
>> Currently every function is checked for its parameters to identify whether
>> the signature changed or not. If signature indeed changed, pahole may do
>> some adjustment for parameters for true signatures.
>>
>> In clang, any function with the following attribute
>>        DW_AT_calling_convention        (DW_CC_nocall)
>> indicates this function having signature changed.
>> pahole can take advantage of this to avoid parameter checking if
>> DW_AT_calling_convention is not DW_CC_nocall.
>>
>> But more importantly, DW_CC_nocall can identify signature-changed functions
>> and parameters can be checked one-after-another to create the true
>> signatures. Otherwise, it takes more effort to identify whether a
>> function has signature changed or not. For example, for funciton
>>    __bpf_kfunc static void bbr_main(struct sock *sk, u32 ack, int flag,
>>       const struct rate_sample *rs) { ... }
>> and bbr_main() is a callback function in
>>    .cong_control   = bbr_main
>> in 'struct tcp_congestion_ops tcp_bbr_cong_ops'.
>> In the above bbr_main(...), parameter 'ack' and 'flag' are not used.
>> The following are some details:
>>
>> 0x0a713b8d:     DW_TAG_formal_parameter
>>                    DW_AT_location        (indexed (0x28) loclist = 0x0166d452:
>>                       [0xffffffff83e77fd9, 0xffffffff83e78016): DW_OP_reg5 RDI
>>                       ...
>>                    DW_AT_name    ("sk")
>>                    DW_AT_type    (0x0a6f5b2b "sock *")
>>                    ...
>>
>> 0x0a713b98:     DW_TAG_formal_parameter
>>                    DW_AT_name    ("ack")
>>                    DW_AT_type    (0x0a6f58fd "u32")
>>                    ...
>>
>> 0x0a713ba2:     DW_TAG_formal_parameter
>>                    DW_AT_name    ("flag")
>>                    DW_AT_type    (0x0a6f57d1 "int")
>>                    ...
>>
>> 0x0a713bac:     DW_TAG_formal_parameter
>>                    DW_AT_location        (indexed (0x29) loclist = 0x0166d4a8:
>>                       [0xffffffff83e77fd9, 0xffffffff83e78016): DW_OP_reg2 RCX
>>                       ...
>>                    DW_AT_name    ("rs")
>>                    DW_AT_type    (0x0a710da5 "const rate_sample *")
>>
>> Some analysis for the above dwarf can conclude that the 'ark' and 'flag'
>> may be related to RSI and RDX, considering the last one is RCX. Basically this
>> requires all parameters are available to collectively decide whether the
>> true signature can be found or not. In such case, DW_CC_nocall can make things
>> easier as parameter can be checked one after another.
>>
>> For a clang built bpf-next kernel with x86_64, in non-LTO setup,
>> the number of kernel functions is 69103 and the number of signature changed
>> functions is 875, based on
>>        DW_AT_calling_convention        (DW_CC_nocall)
>> indication.
>>
>> Among 875 signature changed functions, after this patch, 343 functions
>> can have proper true signatures, mostly due to simple dead argument
>> elimination. The number of remaining functions, which cannot get the
>> true signature, is 532 due to dead or additional-checked parameters.
>>
>> They will be addressed in the subsequent commits.
>>
>> In llvm23, I implemented [1] which added DW_CC_nocall for ArgumentPromotion pass.
>> This compiler pass can add additional DW_CC_nocall cases for the following
>> compilation:
>>        - Flag -O3 or FullLTO
>> So once llvm23 available, we may have more DW_CC_nocall cases, hence more
>> potential true signatures if the kernel is built with -O3 or
>> with FullLTO (CONFIG_LTO_CLANG_FULL).
>>
>>    [1] https://github.com/llvm/llvm-project/pull/178973
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   dwarf_loader.c | 82 +++++++++++++++++++++++++++++++++++++++++---------
>>   dwarves.h      |  1 +
>>   2 files changed, 69 insertions(+), 14 deletions(-)
>>
>> diff --git a/dwarf_loader.c b/dwarf_loader.c
>> index 16fb7be..c569002 100644
>> --- a/dwarf_loader.c
>> +++ b/dwarf_loader.c
>> @@ -1190,6 +1190,10 @@ static ptrdiff_t __dwarf_getlocations(Dwarf_Attribute *attr,
>>   	return ret;
>>   }
>>   
>> +struct func_info {
>> +	bool signature_changed;
>> +};
>> +
>>   /* For DW_AT_location 'attr':
>>    * - if first location is DW_OP_regXX with expected number, return the register;
>>    *   otherwise save the register for later return
>> @@ -1252,7 +1256,8 @@ out:
>>   }
>>   
>>   static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
>> -					struct conf_load *conf, int param_idx)
>> +					struct conf_load *conf, int param_idx,
>> +					struct func_info *info)
>>   {
>>   	struct parameter *parm = tag__alloc(cu, sizeof(*parm));
>>   
>> @@ -1263,8 +1268,15 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
>>   		tag__init(&parm->tag, cu, die);
>>   		parm->name = attr_string(die, DW_AT_name, conf);
>>   		parm->idx = param_idx;
>> -		if (param_idx >= cu->nr_register_params || param_idx < 0)
>> +		if (param_idx < 0)
>> +			return parm;
>> +		if (!info->signature_changed) {
>> +			if (cu->producer_clang || param_idx >= cu->nr_register_params)
>> +				return parm;
>> +		} else if (param_idx >= cu->nr_register_params) {
>>   			return parm;
>> +		}
>> +
> logic here is confusing. why not just retain
>
>
> 		if (param_idx >= cu->nr_register_params || param_idx < 0)
> 			return parm;
>
> and add
> 		if (cu->producer_clang && !info->signature_changed)
> 			return parm;

The code
+		if (param_idx < 0)
+			return parm;
+		if (!info->signature_changed) {
+			if (cu->producer_clang || param_idx >= cu->nr_register_params)
+				return parm;
+		} else if (param_idx >= cu->nr_register_params) {
  			return parm;
+		}
is written in a way to have minimum change later on.

For example,
	if (param_idx >= cu->nr_register_params || param_idx < 0)
		return parm;
works for this patch.
But consider parameters after cu->nr_register_params, e.g., 7th parameter
for x86_64. We cannot just return parm since it is possible the 7th
parameter may be dead or may have some other changes. We will go back
to
	if (param_idx < 0)
		return parm;

So I prefer to keep the current implementation.

>
> but given that info can be NULL, isn't it safer to have
>
> 		if (cu->producer_clang && info && !info->signature_changed)
> 			return parm;

'info' will not be NULL as this pointer. 'info' could be NULL if param_idx < 0.
But for param_idx >= 0 case, info is not NULL. I have audited it.

>
> Technically we could drop the cu->producer_clang clause since info->signature changed
> will only be true for clang functions with DW_CC_nocall.

cu->producer_clang is needed. Otherwise, for gcc, info->signature is false and
the original parm will be returned which is incorrect.

>
>
>>   		/* Parameters which use DW_AT_abstract_origin to point at
>>   		 * the original parameter definition (with no name in the DIE)
>>   		 * are the result of later DWARF generation during compilation
>> @@ -1337,7 +1349,7 @@ static int formal_parameter_pack__load_params(struct formal_parameter_pack *pack
>>   			continue;
>>   		}
>>   
>> -		struct parameter *param = parameter__new(die, cu, conf, -1);
>> +		struct parameter *param = parameter__new(die, cu, conf, -1, NULL);
>>   
>>   		if (param == NULL)
>>   			return -1;
>> @@ -1502,6 +1514,29 @@ static struct ftype *ftype__new(Dwarf_Die *die, struct cu *cu)
>>   	return ftype;
>>   }
>>   
>> +static bool function__signature_changed(struct function *func, Dwarf_Die *die)
>> +{
>
> given that AFAIK DW_CC_nocall is only used in clang currently, why not short-circuit
> the logic here and return false if (cu->producer_clang) ? Logical place to do this
> would be in die__create_new_function().

Yes, I can do this. I see your suggested code below with cu->producer_clang
as part of condition. It does make sense.

>
>> +	/* The inlined DW_TAG_subprogram typically has the original source type for
>> +	 * abstract origin of a concrete function with address range, inlined subroutine,
>> +	 * or call site.
>> +	 */
>> +	if (func->inlined)
>> +		return false;
>> +
>> +	if (!func->abstract_origin)
>> +		return attr_numeric(die, DW_AT_calling_convention) == DW_CC_nocall;
>> +
>> +	Dwarf_Attribute attr;
>> +	if (dwarf_attr(die, DW_AT_abstract_origin, &attr)) {
>> +		Dwarf_Die origin;
>> +		if (dwarf_formref_die(&attr, &origin))
>> +			return attr_numeric(&origin, DW_AT_calling_convention) == DW_CC_nocall;
>> +	}
>> +
>> +	/* This should not happen */
>> +	return false;
>> +}
>> +
>>   static struct function *function__new(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
>>   {
>>   	struct function *func = tag__alloc(cu, sizeof(*func));
>> @@ -1800,9 +1835,9 @@ static struct tag *die__create_new_parameter(Dwarf_Die *die,
>>   					     struct ftype *ftype,
>>   					     struct lexblock *lexblock,
>>   					     struct cu *cu, struct conf_load *conf,
>> -					     int param_idx)
>> +					     int param_idx, struct func_info *info)
>>   {
>> -	struct parameter *parm = parameter__new(die, cu, conf, param_idx);
>> +	struct parameter *parm = parameter__new(die, cu, conf, param_idx, info);
>>   
>>   	if (parm == NULL)
>>   		return NULL;
>> @@ -1889,7 +1924,7 @@ static struct tag *die__create_new_subroutine_type(Dwarf_Die *die,
>>   			tag__print_not_supported(die);
>>   			continue;
>>   		case DW_TAG_formal_parameter:
>> -			tag = die__create_new_parameter(die, ftype, NULL, cu, conf, -1);
>> +			tag = die__create_new_parameter(die, ftype, NULL, cu, conf, -1, NULL);
>>   			break;
>>   		case DW_TAG_unspecified_parameters:
>>   			ftype->unspec_parms = 1;
>> @@ -2118,7 +2153,8 @@ out_enomem:
>>   }
>>   
>>   static int die__process_function(Dwarf_Die *die, struct ftype *ftype,
>> -				  struct lexblock *lexblock, struct cu *cu, struct conf_load *conf);
>> +				 struct lexblock *lexblock, struct cu *cu, struct conf_load *conf,
>> +				 struct func_info *info);
>>   
>>   static int die__create_new_lexblock(Dwarf_Die *die,
>>   				    struct cu *cu, struct lexblock *father, struct conf_load *conf)
>> @@ -2126,7 +2162,7 @@ static int die__create_new_lexblock(Dwarf_Die *die,
>>   	struct lexblock *lexblock = lexblock__new(die, cu);
>>   
>>   	if (lexblock != NULL) {
>> -		if (die__process_function(die, NULL, lexblock, cu, conf) != 0)
>> +		if (die__process_function(die, NULL, lexblock, cu, conf, NULL) != 0)
>>   			goto out_delete;
>>   	}
>>   	if (father != NULL)
>> @@ -2246,7 +2282,8 @@ static struct tag *die__create_new_inline_expansion(Dwarf_Die *die,
>>   }
>>   
>>   static int die__process_function(Dwarf_Die *die, struct ftype *ftype,
>> -				 struct lexblock *lexblock, struct cu *cu, struct conf_load *conf)
>> +				 struct lexblock *lexblock, struct cu *cu, struct conf_load *conf,
>> +				 struct func_info *info)
>>   {
>>   	int param_idx = 0;
>>   	Dwarf_Die child;
>> @@ -2320,7 +2357,7 @@ static int die__process_function(Dwarf_Die *die, struct ftype *ftype,
>>   			continue;
>>   		}
>>   		case DW_TAG_formal_parameter:
>> -			tag = die__create_new_parameter(die, ftype, lexblock, cu, conf, param_idx++);
>> +			tag = die__create_new_parameter(die, ftype, lexblock, cu, conf, param_idx++, info);
>>   			break;
>>   		case DW_TAG_variable:
>>   			tag = die__create_new_variable(die, cu, conf, 0);
>> @@ -2391,11 +2428,15 @@ out_enomem:
>>   static struct tag *die__create_new_function(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
>>   {
>>   	struct function *function = function__new(die, cu, conf);
>> +	struct func_info info = {};
>> +
>> +	if (function != NULL) {
>> +		info.signature_changed = function__signature_changed(function, die);
>>
> i'd suggest adding a coment and a predicate here, something like
>
> 	/* For clang, we determine if function signature changes via DW_AT_calling_convention
> 	 * set to DW_CC_nocall.
> 	 */
> 	if (cu->producer_clang)
> 		info.signature_changed = function__signature_changed(function, die);

I will do
	if (cu->pruducer_clang && funciton != NULL)
		info.signature_changed = function__signature_changed(function, die);

>    
>> -	if (function != NULL &&
>> -	    die__process_function(die, &function->proto, &function->lexblock, cu, conf) != 0) {
>> -		function__delete(function, cu);
>> -		function = NULL;
>> +		if (die__process_function(die, &function->proto, &function->lexblock, cu, conf, &info) != 0) {
>> +			function__delete(function, cu);
>> +			function = NULL;
>> +		}
>>   	}
>>   
>>   	return function ? &function->proto.tag : NULL;
>> @@ -3045,6 +3086,17 @@ static unsigned long long dwarf_tag__orig_id(const struct tag *tag,
>>   	return cu->extra_dbg_info ? dtag->id : 0;
>>   }
>>   
>> +static bool attr_producer_clang(Dwarf_Die *die)
>> +{
>> +	const char *producer;
>> +
>> +	producer = attr_string(die, DW_AT_producer, NULL);
>> +	if (!producer)
>> +		return false;
>> +
>> +	return !!strstr(producer, "clang");
>> +}
>> +
>>   struct debug_fmt_ops dwarf__ops;
>>   
>>   static int die__process(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
>> @@ -3082,6 +3134,7 @@ static int die__process(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
>>   	}
>>   
>>   	cu->language = attr_numeric(die, DW_AT_language);
>> +	cu->producer_clang = attr_producer_clang(die);
>>   
>>   	if (conf->early_cu_filter)
>>   		cu = conf->early_cu_filter(cu);
>> @@ -3841,6 +3894,7 @@ static int cus__merge_and_process_cu(struct cus *cus, struct conf_load *conf,
>>   			cu->priv = dcu;
>>   			cu->dfops = &dwarf__ops;
>>   			cu->language = attr_numeric(cu_die, DW_AT_language);
>> +			cu->producer_clang = attr_producer_clang(cu_die);
>>   			cus__add(cus, cu);
>>   		}
>>   
>> diff --git a/dwarves.h b/dwarves.h
>> index d7c6474..4cabab0 100644
>> --- a/dwarves.h
>> +++ b/dwarves.h
>> @@ -302,6 +302,7 @@ struct cu {
>>   	uint8_t		 has_addr_info:1;
>>   	uint8_t		 uses_global_strings:1;
>>   	uint8_t		 little_endian:1;
>> +	uint8_t		 producer_clang:1;
>>   	uint8_t		 nr_register_params;
>>   	int		 register_params[ARCH_MAX_REGISTER_PARAMS];
>>   	int		 functions_saved;

