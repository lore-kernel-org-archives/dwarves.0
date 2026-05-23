Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9289E1096F
	for <dwarves@vger.kernel.org>; Sat, 23 May 2026 16:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779553986; cv=none; b=pMdU28HAVWj8KJo4tYH1oGR3rn0LopzaJuO/lkIV/OXH1q28PtmyAEvuBKQ0dTTXr9I2qeZAiqE8MmavEKJzQxLlpWyWpHwy3qJ139wShJhw7Bzh0KXPMUQVaZB80pFwgevjUnPgY2VR5lLXmDrBNRYkuk7ProCccGD3SCDBndM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779553986; c=relaxed/simple;
	bh=60RJeEoh81YQksQyLPlk3cUsNn6psgS3qupwOkkdAvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fV212nuBakoTstC3yN9VqkPteVtcdalpEK4UfKitF8qCdRYn2/XV7bOJAg9DipnrQI9edaAq1X6efrMg+ZZAth+k8ZQQNRIw1XXk+KCT/2vu9IZ0Lj2UKJ9+yCvS23a1baUCz1UACa40R2FFmVd7Ywf7V/Qoppmqrv8qhfrqmeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WatNWvdL; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WatNWvdL"
Message-ID: <0adac56b-d6b6-44d6-b531-e1827498cd19@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779553982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EFf0K4xqkT8w6tF/CVNvJLRBkBooDaajTliYmA2vFzM=;
	b=WatNWvdLVC1MrZ3lu6NiYmeRp0jU13Vo7H8wkhWdfkt6Qa9waGWakRrg/JP1qBJQ7MnkfV
	Mco6QWrIvdG9pEKjjB7MwitNE0aR1JZjqt4Q+DrLfU3l2oVhoN19EVKF9aVzENhhrAT77X
	aGBKLdzU30MzdgIFp+mpu9ZgMFncIsk=
Date: Sat, 23 May 2026 09:32:47 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves v4 09/11] dwarf_loader: Handle expression lists
Content-Language: en-GB
To: Alan Maguire <alan.maguire@oracle.com>,
 Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, kernel-team@fb.com
References: <20260326013144.2901265-1-yonghong.song@linux.dev>
 <20260326013307.2907768-1-yonghong.song@linux.dev>
 <d8eec3f5-6d6d-4fb7-8a51-c0732b9d880a@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <d8eec3f5-6d6d-4fb7-8a51-c0732b9d880a@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 3/31/26 1:04 AM, Alan Maguire wrote:
> On 26/03/2026 01:32, Yonghong Song wrote:
>> Location lists having more than one op's are checked.
>> If the parameter size is less or equal to size of long,
>> the argument should match the corresponding ABI register.
>> For example:
>>
>> 0x0aba0808:   DW_TAG_subprogram
>>                  DW_AT_name      ("addrconf_ifdown")
>>                  DW_AT_calling_convention        (DW_CC_nocall)
>>                  DW_AT_type      (0x0ab7d8e9 "int")
>> 		...
>>
>> 0x0aba082b:     DW_TAG_formal_parameter
>>                    DW_AT_location        (indexed (0x32b) loclist = 0x016eabcd:
>>                       [0xffffffff83f6fef9, 0xffffffff83f6ff98): DW_OP_reg5 RDI
>>                       [0xffffffff83f6ff98, 0xffffffff83f70080): DW_OP_reg12 R12
>>                       [0xffffffff83f70080, 0xffffffff83f70111): DW_OP_breg7 RSP+112
>>                       [0xffffffff83f70111, 0xffffffff83f7014f): DW_OP_reg12 R12
>>                       [0xffffffff83f7014f, 0xffffffff83f7123c): DW_OP_breg7 RSP+112
>>                       [0xffffffff83f7123c, 0xffffffff83f7128c): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
>>                       [0xffffffff83f7128c, 0xffffffff83f712a9): DW_OP_reg12 R12
>>                       [0xffffffff83f712a9, 0xffffffff83f712cd): DW_OP_breg7 RSP+112
>>                       [0xffffffff83f712cd, 0xffffffff83f712d2): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
>>                       [0xffffffff83f712d2, 0xffffffff83f713dd): DW_OP_breg7 RSP+112)
>>                    DW_AT_name    ("dev")
>>                    DW_AT_type    (0x0ab7cb7d "net_device *")
>> 		  ...
>>
>> 0x0aba0836:     DW_TAG_formal_parameter
>>                    DW_AT_location        (indexed (0x32c) loclist = 0x016eac39:
>>                       [0xffffffff83f6fef9, 0xffffffff83f6ff15): DW_OP_breg4 RSI+0, DW_OP_constu 0xffffffff, DW_OP_and, DW_OP_convert (0x0ab7b571) "DW_ATE_unsigned_1", DW_OP_convert (0x0ab7b576) "DW_ATE_unsigned_8", DW_OP_stack_value
>>                       [0xffffffff83f6ff15, 0xffffffff83f7127c): DW_OP_breg7 RSP+36, DW_OP_deref_size 0x4, DW_OP_convert (0x0ab7b571) "DW_ATE_unsigned_1", DW_OP_convert (0x0ab7b576) "DW_ATE_unsigned_8", DW_OP_stack_value
>>                       [0xffffffff83f7128c, 0xffffffff83f713dd): DW_OP_breg7 RSP+36, DW_OP_deref_size 0x4, DW_OP_convert (0x0ab7b571) "DW_ATE_unsigned_1", DW_OP_convert (0x0ab7b576) "DW_ATE_unsigned_8", DW_OP_stack_value)
>>                    DW_AT_name    ("unregister")
>>                    DW_AT_type    (0x0ab7c933 "bool")
>> 		  ...
>>
>> The parameter 'unregister' is the second argument which matches ABI register RSI.
>> So the function "addrconf_ifdown" signature is valid.
>>
>> If the parameter size is '2 x size_of_long', more handling is necessary, e.g., below:
>>
>> 0x0a01e174:   DW_TAG_subprogram
>>                  DW_AT_name      ("check_zeroed_sockptr")
>>                  DW_AT_calling_convention        (DW_CC_nocall)
>>                  DW_AT_type      (0x09fead35 "int")
>> 		...
>>
>> 0x0a01e187:     DW_TAG_formal_parameter
>>                    DW_AT_location        (indexed (0x5b6) loclist = 0x0157f03f:
>>                       [0xffffffff83c941c0, 0xffffffff83c941c4): DW_OP_reg5 RDI, DW_OP_piece 0x8, DW_OP_reg4 RSI, DW_OP_piece 0x1
>>                       [0xffffffff83c941c4, 0xffffffff83c941cc): DW_OP_piece 0x8, DW_OP_reg4 RSI, DW_OP_piece 0x1
>>                       [0xffffffff83c941e1, 0xffffffff83c941e4): DW_OP_piece 0x8, DW_OP_reg4 RSI, DW_OP_piece 0x1)
>>                    DW_AT_name    ("src")
>>                    DW_AT_type    (0x09ff832d "sockptr_t")
>> 		  ...
>>
>> 0x0a01e193:     DW_TAG_formal_parameter
>>                    DW_AT_const_value     (64)
>>                    DW_AT_name    ("offset")
>>                    DW_AT_type    (0x09fee984 "size_t")
>> 		  ...
>>
>> 0x0a01e19e:     DW_TAG_formal_parameter
>>                    DW_AT_location        (indexed (0x5b7) loclist = 0x0157f06b:
>>                       [0xffffffff83c941c0, 0xffffffff83c941d1): DW_OP_reg1 RDX
>>                       [0xffffffff83c941d1, 0xffffffff83c941e1): DW_OP_entry_value(DW_OP_reg1 RDX), DW_OP_stack_value
>>                       [0xffffffff83c941e1, 0xffffffff83c941e9): DW_OP_reg1 RDX)
>>                    DW_AT_name    ("size")
>>                    DW_AT_type    (0x09fee984 "size_t")
>> 		  ...
>>
>> The first parameter 'src' will take two ABI registers. This patch correctly detects such a pattern
>> to construct the true signature.
>>
>> However, it is possible that only one 'size_of_long' is used from '2 x size_of_long'. For example
>>
>> 0x019520c6:   DW_TAG_subprogram
>>                  DW_AT_name      ("map_create")
>>                  DW_AT_calling_convention        (DW_CC_nocall)
>>                  DW_AT_type      (0x01934b29 "int")
>> 		...
>>
>> 0x01952111:     DW_TAG_formal_parameter
>>                    DW_AT_location        (indexed (0x31b) loclist = 0x0034fa0f:
>>                       [0xffffffff81892345, 0xffffffff8189237c): DW_OP_reg5 RDI
>>                       [0xffffffff8189237c, 0xffffffff818923bd): DW_OP_reg3 RBX
>>                       [0xffffffff818923bd, 0xffffffff818923d4): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
>>                       [0xffffffff818923d4, 0xffffffff81892dcb): DW_OP_reg3 RBX
>>                       [0xffffffff81892df3, 0xffffffff81892e01): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
>>                       [0xffffffff81892e01, 0xffffffff818932a9): DW_OP_reg3 RBX)
>>                    DW_AT_name    ("attr")
>>                    DW_AT_type    (0x01934d17 "bpf_attr *")
>> 		  ...
>>
>> 0x0195211d:     DW_TAG_formal_parameter
>>                    DW_AT_location        (indexed (0x31a) loclist = 0x0034f9dc:
>>                       [0xffffffff81892345, 0xffffffff81892357): DW_OP_piece 0x8, DW_OP_reg4 RSI, DW_OP_piece 0x1
>>                       [0xffffffff81892357, 0xffffffff81892f02): DW_OP_piece 0x8, DW_OP_breg7 RSP+20, DW_OP_deref_size 0x4, DW_OP_stack_value, DW_OP_piece 0x1
>>                       [0xffffffff81892f07, 0xffffffff818932a9): DW_OP_piece 0x8, DW_OP_breg7 RSP+20, DW_OP_deref_size 0x4, DW_OP_stack_value, DW_OP_piece 0x1)
>>                    DW_AT_name    ("uattr")
>>                    DW_AT_type    (0x019512ab "bpfptr_t")
>> 		  ...
>>
>> For parameter 'uattr', only second half of parameter is used. For such cases,
>> the name and the type is changed in pahole and eventually going to vmlinux btf.
>>    [55697] FUNC_PROTO '(anon)' ret_type_id=106780 vlen=2
>>            'attr' type_id=455
>>            'uattr__is_kernel' type_id=82014
>>    [82014] TYPEDEF 'bool' type_id=67434
>>    [113251] FUNC 'map_create' type_id=55697 linkage=static
>> You can see the new parameter name is 'uattr__is_kernel' and the type is 'bool'.
>>
>> With this patch, the number of invalid true signatures is reduced from 83 to 18.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   dwarf_loader.c | 239 +++++++++++++++++++++++++++++++++++++++++++++++--
>>   dwarves.h      |   1 +
>>   2 files changed, 233 insertions(+), 7 deletions(-)
>>
>> diff --git a/dwarf_loader.c b/dwarf_loader.c
>> index d538e97..4e6e042 100644
>> --- a/dwarf_loader.c
>> +++ b/dwarf_loader.c
>> @@ -1204,6 +1204,8 @@ static ptrdiff_t __dwarf_getlocations(Dwarf_Attribute *attr,
>>   #define	PARM_UNEXPECTED		-2
>>   #define	PARM_OPTIMIZED_OUT	-3
>>   #define	PARM_CONTINUE		-4
>> +#define	PARM_TWO_ADDR_LEN	-5
>> +#define	PARM_TO_BE_IMPROVED	-6
>>   
>>   /* Max 20 register parameters, considering some parameters may be optimized out.  */
>>   #define	MAX_PRESCAN_PARAMS	20
>> @@ -1291,7 +1293,47 @@ static int parameter__peek_first_reg(Dwarf_Die *die)
>>   	return -1;
>>   }
>>   

[...]

>>   /* For DW_AT_location 'attr':
>>    * - if first location is DW_OP_regXX with expected number, return the register;
>>    *   otherwise save the register for later return
>> @@ -1313,15 +1515,18 @@ static int parameter__multi_exprs(Dwarf_Op *expr, int loc_num)
>>    * - otherwise if no register was found for locations, return PARM_DEFAULT_FAIL.
>>    */
>>   static int parameter__reg(Dwarf_Attribute *attr, int expected_reg, struct conf_load *conf,
>> -			  struct func_info *info)
>> +			  struct func_info *info, struct cu *cu, Dwarf_Die *die,
>> +			  struct parameter *parm, int param_idx, int reg_idx)
>>   {
>>   	Dwarf_Addr base, start, end;
>>   	Dwarf_Op *expr, *entry_ops;
>>   	Dwarf_Attribute entry_attr;
>>   	size_t exprlen, entry_len;
>>   	ptrdiff_t offset = 0;
>> +	int byte_size = 0;
>>   	int loc_num = -1;
>>   	int ret = PARM_DEFAULT_FAIL;
>> +	unsigned long first_half = 0, second_half = 0;
>>   
>>   	/* use libdw__lock as dwarf_getlocation(s) has concurrency issues
>>   	 * when libdw is not compiled with experimental --enable-thread-safety
>> @@ -1341,8 +1546,17 @@ static int parameter__reg(Dwarf_Attribute *attr, int expected_reg, struct conf_l
>>   			if (!info->signature_changed || !conf->true_signature)
>>   				continue;
>>   
>> +			if (!byte_size)
>> +				byte_size = get_type_byte_size(die, cu);
>> +			/* This should not happen. */
>> +			if (!byte_size) {
>> +				ret = PARM_UNEXPECTED;
>> +				goto out;
>> +			}
>> +
>>   			int res;
>> -			res = parameter__multi_exprs(expr, loc_num);
>> +			res = parameter__multi_exprs(expr, loc_num, cu, exprlen, die, expected_reg,
>> +						     byte_size, &first_half, &second_half, &ret);
>>   			if (res == PARM_CONTINUE)
>>   				continue;
>>   			ret = res;
>> @@ -1391,6 +1605,11 @@ static int parameter__reg(Dwarf_Attribute *attr, int expected_reg, struct conf_l
>>   			break;
>>   		}
>>   	}
>> +
>> +	ret = parameter__handle_two_addr_len(expected_reg, first_half, second_half,
>> +					     ret, die, conf, cu, parm, param_idx, reg_idx,
>> +					     byte_size, info);
>> +
>>   out:
>>   	pthread_mutex_unlock(&libdw__lock);
>>   	return ret;
>> @@ -1417,8 +1636,6 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
>>   				return parm;
>>   		} else {
>>   			reg_idx = param_idx - info->skip_idx;
>> -			if (reg_idx >= cu->nr_register_params)
>> -				return parm;
>>   		}
>>   
>>   		/* Parameters which use DW_AT_abstract_origin to point at
>> @@ -1459,15 +1676,23 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
>>   		true_sig_enabled = conf->true_signature && info->signature_changed;
>>   
>>   		if (parm->has_loc) {
>> +			if (reg_idx >= cu->nr_register_params)
> it looks like we only assign reg_idx in the else (signature_changed) branch above;
> we should make sure we don't wind up using an uninitialized value here

You are right. clang works but gcc will have some issues.
The following is the fix:

                 if (param_idx < 0)
                         return parm;
                 if (!info->signature_changed) {
                         if (cu->producer_clang || param_idx >= cu->nr_register_params)
                                 return parm;
=== change ===:         reg_idx = param_idx;
                 } else {
                         reg_idx = param_idx - info->skip_idx;
                 }

>
>
>> +				return parm;
>> +
>>   			int expected_reg = cu->register_params[reg_idx];
>> -			int actual_reg = parameter__reg(&attr, expected_reg, conf, info);
>> +			int actual_reg = parameter__reg(&attr, expected_reg, conf, info, cu, die,
>> +							parm, param_idx, reg_idx);
>>   
>>   			if (actual_reg == PARM_DEFAULT_FAIL) {
>>   				parm->optimized = 1;
>>   			} else if (actual_reg == PARM_OPTIMIZED_OUT) {
>>   				parm->optimized = 1;
>>   				info->skip_idx++;
>> -			} else if (actual_reg == PARM_UNEXPECTED || (expected_reg >= 0 && expected_reg != actual_reg)) {
>> +			} else if (actual_reg == PARM_TWO_ADDR_LEN) {
>> +				/* account for parameter with two registers */
>> +				info->skip_idx--;
>> +			} else if (actual_reg == PARM_UNEXPECTED || actual_reg == PARM_TO_BE_IMPROVED ||
>> +				   (expected_reg >= 0 && expected_reg != actual_reg)) {
>>   				/* mark parameters that use an unexpected
>>   				 * register to hold a parameter; these will
>>   				 * be problematic for users of BTF as they
>> diff --git a/dwarves.h b/dwarves.h
>> index 164bd3b..7f818d8 100644
>> --- a/dwarves.h
>> +++ b/dwarves.h
>> @@ -944,6 +944,7 @@ size_t lexblock__fprintf(const struct lexblock *lexblock, const struct cu *cu,
>>   struct parameter {
>>   	struct tag tag;
>>   	const char *name;
>> +	const char *true_sig_member_name;
>>   	uint8_t optimized:1;
>>   	uint8_t unexpected_reg:1;
>>   	uint8_t has_loc:1;

