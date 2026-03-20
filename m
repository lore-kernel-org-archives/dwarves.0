Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9B6286430
	for <dwarves@vger.kernel.org>; Fri, 20 Mar 2026 05:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773982857; cv=none; b=oP2N8mevLSf6bH9j9ONkeOijfLbHszzOfYRMKM7aFswiSm7F90krTudBTgBuLS7PJy9kHZgUnpSZ4t8kF+fqAoH8nriDt454Did3T29stN+hJp6QlV+FY7hFgiWmr273qYyibSB+bjSbZ5SwvySIv/9mGQdGeNxV3d4mndEcwlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773982857; c=relaxed/simple;
	bh=7Bvryjb3U5dYWwyP2CW7U0e5Npac4SyEbRAbfk85H1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X0yPum9tiWs1K4HLusjT0o6v9tTT+8ngNS9oa84xpLLxhhpIQ3hXdiNDvZ4VTR/f76QbtkJf70ftYp5vdEsjChqdTQOV+zzH5G/nIajOow3Z9XrL6D3NsUCX/WSgpT4xyBeLndDLHF1wU5oHYXZadrwtrDsMt1ERQKZF7RTeOns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iDvZ9Pvv; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iDvZ9Pvv"
Message-ID: <cc592002-b65b-4ec2-bc99-8a53ca221bbd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773982844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0GzKbEyEB0l+ERcDP9flzcM6p5rpgvZQkAd7pS4hnCo=;
	b=iDvZ9PvvW+a0/fN7iTKnY1M8cbuH+M5nZ7tKcSr7Ixx6k1oGW92E3Xr9cUlvnUzOGG0lXm
	19izLy65NOC4XXfk1pCuw/z83bYiYnkSzm1/wU4JQqX6qEoj1cfhdmojgmzukkYEp+bodn
	pTUnFWn3BD5XuyLkuw5eI3dr9H1x7I8=
Date: Thu, 19 Mar 2026 22:00:28 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves 2/9] dwarf_loader: Handle signatures with dead
 arguments
Content-Language: en-GB
To: Alan Maguire <alan.maguire@oracle.com>,
 Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, kernel-team@fb.com
References: <20260305225455.1151066-1-yonghong.song@linux.dev>
 <20260305225506.1153181-1-yonghong.song@linux.dev>
 <b20663a4-957d-4bb0-bf2c-4921da446514@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <b20663a4-957d-4bb0-bf2c-4921da446514@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 3/19/26 11:55 AM, Alan Maguire wrote:
> On 05/03/2026 22:55, Yonghong Song wrote:
>> For llvm dwarf, the dead argument may be in the middle of
>> DW_TAG_subprogram. So we introduce skip_idx in order to
>> match expected registers properly.
>>
>> For example:
>>    0x00042897:   DW_TAG_subprogram
>>                    DW_AT_name      ("create_dev")
>>                    DW_AT_calling_convention        (DW_CC_nocall)
>>                    DW_AT_type      (0x0002429a "int")
>>                    ...
>>
>>    0x000428ab:     DW_TAG_formal_parameter
>>                      DW_AT_name    ("name")
>>                      DW_AT_type    (0x000242ed "char *")
>>                      ...
>>
>>    0x000428b5:     DW_TAG_formal_parameter
>>                      DW_AT_location        (indexed (0x3f) loclist = 0x000027f8:
>>                         [0xffffffff87681370, 0xffffffff8768137a): DW_OP_reg5 RDI
>>                         [0xffffffff8768137a, 0xffffffff87681392): DW_OP_reg3 RBX
>>                         [0xffffffff87681392, 0xffffffff876813ae): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value)
>>                      DW_AT_name    ("dev")
>>                      DW_AT_type    (0x00026859 "dev_t")
>>                      ...
>>
>> With skip_idx, we can identify that the second original argument
>> 'dev' becomes the first one after optimization.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   dwarf_loader.c | 27 +++++++++++++++++++++++----
>>   1 file changed, 23 insertions(+), 4 deletions(-)
>>
>> diff --git a/dwarf_loader.c b/dwarf_loader.c
>> index 610b69e..1ced5e2 100644
>> --- a/dwarf_loader.c
>> +++ b/dwarf_loader.c
>> @@ -1192,6 +1192,7 @@ static ptrdiff_t __dwarf_getlocations(Dwarf_Attribute *attr,
>>   
>>   struct func_info {
>>   	bool signature_changed;
>> +	int skip_idx;
>>   };
>>   
>>   /* For DW_AT_location 'attr':
>> @@ -1264,13 +1265,28 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
>>   	if (parm != NULL) {
>>   		bool has_const_value;
>>   		Dwarf_Attribute attr;
>> +		int reg_idx;
>>   
>>   		tag__init(&parm->tag, cu, die);
>>   		parm->name = attr_string(die, DW_AT_name, conf);
>>   		parm->idx = param_idx;
>> -		if (param_idx >= cu->nr_register_params || param_idx < 0)
>> +		if (param_idx < 0)
>>   			return parm;
>> -		if (cu->producer_clang && !info->signature_changed)
>> +		if (!cu->producer_clang && param_idx >= cu->nr_register_params)
>> +			return parm;
>> +		if (cu->producer_clang) {
>> +			if (!info->signature_changed)
>> +				return parm;
>> +			/* if true_signature is not enabled, mark parameter as
>> +			 * unexpected_reg since there is a skipped parameter before.
>> +			 */
>> +			if (!conf->true_signature && info->skip_idx) {
>> +				parm->unexpected_reg = 1;
>> +				return parm;
>> +			}
>> +		}
>> +		reg_idx = param_idx - info->skip_idx;
>> +		if (reg_idx >= cu->nr_register_params)
>>   			return parm;
>>   		/* Parameters which use DW_AT_abstract_origin to point at
>>   		 * the original parameter definition (with no name in the DIE)
>> @@ -1309,7 +1325,7 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
>>   		parm->has_loc = dwarf_attr(die, DW_AT_location, &attr) != NULL;
>>   
>>   		if (parm->has_loc) {
>> -			int expected_reg = cu->register_params[param_idx];
>> +			int expected_reg = cu->register_params[reg_idx];
>>   			int actual_reg = parameter__reg(&attr, expected_reg);
>>   
>>   			if (actual_reg < 0)
>> @@ -1322,8 +1338,11 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
>>   				 * contents.
>>   				 */
>>   				parm->unexpected_reg = 1;
>> -		} else if (has_const_value) {
>> +		} else if (!cu->producer_clang && has_const_value) {
>> +			parm->optimized = 1;
>> +		} else if (cu->producer_clang) {
>>   			parm->optimized = 1;
>> +			info->skip_idx++;
>>   		}
>>   	}
>>   
> In [1]  (dwarf_loader/btf_encoder: Detect reordered parameters)
>
> we detect reordered/missing parameters for gcc by comparing abstract origin to concrete representation
> and mark any such functions by setting the reordered_parm bitfield in the encoder func state. In this
> approach reordered encompasses both missing and actual reordering; in practice it's always the former, but
> the DWARF representation was confusing because it had the actually-used parameters (with location info)
> followed by the unused ones (without location info). Before the above commit we were treating these
> function signatures incorrectly as valid leading to wrong functions signatures.
>
> All of this is to say: should we mark with reordered_parm instead? The reason I suggest this is that
> btf_encoder__save_func() has handling for skipping functions without locations with reordered_parm set;
> maybe we could find a way to unify that across clang/gcc cases?

For v2, I focused on clang side. I have not studied such unification yet. I think it is possible
since ultimately both clang and gcc tries to skip some parameters.

>
> Now in the clang case, I guess reordered is a poor description; for gcc it really means "reordered as
> compared to abstract origin". If we could find a better way to describe/encompass both cases that would
> be ideal I think. The terminology used in the gcc true signature code isn't great today.

Agree that we want *common* names to represent both gcc and clang for skipped parameters.
BTW, please review v2 instead:
    https://lore.kernel.org/bpf/20260309153215.1917033-1-yonghong.song@linux.dev/

Thanks!

>
> [1] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=109e5e4554f663e5f12fb634bc54cceb710aec61

