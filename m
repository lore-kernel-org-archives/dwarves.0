Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC7F376481
	for <dwarves@vger.kernel.org>; Thu, 19 Mar 2026 17:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773941542; cv=none; b=DJuCrgfkDnFn8urKcB7jXnCxS0hULIUPtHjF1wOGf6l27MCxgh36QZiEDJ+L/Ja5Gx4XI7mE0yCRcCJh4xyiYDV3ZBtLPPiNDWMmXiuSAGBguzZlT5hsbyAGhd76vq406uX6eYWKVEErNPa8jGqyF0V4paUzCWMeDi2LZdvmFLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773941542; c=relaxed/simple;
	bh=bpqvR8J6/QG/+CtU1wW/hVktCz6ZD7fFdAxHTYrBc2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mNYwGdklDDe6/FhVCiIqFqCEdAK1W3CkKLAC+VOqoalb6zqM7x2Mfk/d5ICNPc5zL6gCuLgkJrrpODlG/yb2FfvvKd+5njJiTz0TSwvLo3RjOQY3nxx6ollSaHHmogFK3C5LseoQo3zdCa5QG14ZVrxgd/Ks+4aF1C8chbNKqM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GYOCa+MO; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GYOCa+MO"
Message-ID: <4e6b366f-eaea-4cc1-b9c2-629c8089967e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773941527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YWDwFX7RDlzg//VzZrJ7A37vtyfA4VbBikusGF6Mh3g=;
	b=GYOCa+MOdBygqHs9YnzKQS3lZcPIU+5RffiahGa5mBZ575dVQ01BYVI9zf1/OUBFmmQOD6
	YzNlIDo9XT8cc0g6guzmNkL+dDoJ95SnIHoJdRFL8yX90qB5iNkC3LxhGZ++LIBur5H56L
	UUBwGYqzv5slx3iyUEZyMSs/kXwXe6M=
Date: Thu, 19 Mar 2026 10:31:41 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves 1/9] dwarf_loader: Reduce parameter checking with
 clang DW_AT_calling_convention attr
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
 Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, dwarves@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, kernel-team@fb.com
References: <20260305225455.1151066-1-yonghong.song@linux.dev>
 <20260305225500.1151338-1-yonghong.song@linux.dev> <abvs73VjXf_1byN6@krava>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <abvs73VjXf_1byN6@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 3/19/26 5:32 AM, Jiri Olsa wrote:
> On Thu, Mar 05, 2026 at 02:55:00PM -0800, Yonghong Song wrote:
>
> SNIP
>
>> ---
>>   dwarf_loader.c | 71 +++++++++++++++++++++++++++++++++++++++++++-------
>>   dwarves.h      |  2 ++
>>   2 files changed, 63 insertions(+), 10 deletions(-)
>>
>> diff --git a/dwarf_loader.c b/dwarf_loader.c
>> index 16fb7be..610b69e 100644
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
>> @@ -1265,6 +1270,8 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
>>   		parm->idx = param_idx;
>>   		if (param_idx >= cu->nr_register_params || param_idx < 0)
>>   			return parm;
>> +		if (cu->producer_clang && !info->signature_changed)
>> +			return parm;
> should you check for info != NULL?

We should be okay. I audited that if info is NULL, then param_idx must be < 0.

>
>>   		/* Parameters which use DW_AT_abstract_origin to point at
>>   		 * the original parameter definition (with no name in the DIE)
>>   		 * are the result of later DWARF generation during compilation
>> @@ -1337,7 +1344,7 @@ static int formal_parameter_pack__load_params(struct formal_parameter_pack *pack
>>   			continue;
>>   		}
>>   
>> -		struct parameter *param = parameter__new(die, cu, conf, -1);
>> +		struct parameter *param = parameter__new(die, cu, conf, -1, NULL);
>>   
>>   		if (param == NULL)
>>   			return -1;
>> @@ -1502,6 +1509,29 @@ static struct ftype *ftype__new(Dwarf_Die *die, struct cu *cu)
>>   	return ftype;
>>   }
>>   
> SNIP
>
>>   	int param_idx = 0;
>>   	Dwarf_Die child;
>> @@ -2320,7 +2353,7 @@ static int die__process_function(Dwarf_Die *die, struct ftype *ftype,
>>   			continue;
>>   		}
>>   		case DW_TAG_formal_parameter:
>> -			tag = die__create_new_parameter(die, ftype, lexblock, cu, conf, param_idx++);
>> +			tag = die__create_new_parameter(die, ftype, lexblock, cu, conf, param_idx++, info);
>>   			break;
>>   		case DW_TAG_variable:
>>   			tag = die__create_new_variable(die, cu, conf, 0);
>> @@ -2391,9 +2424,10 @@ out_enomem:
>>   static struct tag *die__create_new_function(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
>>   {
>>   	struct function *function = function__new(die, cu, conf);
>> +	struct func_info info = { function->signature_changed };
> would it be easier to add signature_changed to struct ftype or pass
> function pointer directly to die__process_function ?
>
> (after reading the rest of the patches, seems like func_info is needed
> anyway, so maybe not worth it)

Right, there are additional fields in func_info struct.

>
>>   
>>   	if (function != NULL &&
>> -	    die__process_function(die, &function->proto, &function->lexblock, cu, conf) != 0) {
>> +	    die__process_function(die, &function->proto, &function->lexblock, cu, conf, &info) != 0) {
>>   		function__delete(function, cu);
>>   		function = NULL;
>>   	}
>> @@ -3045,6 +3079,21 @@ static unsigned long long dwarf_tag__orig_id(const struct tag *tag,
>>   	return cu->extra_dbg_info ? dtag->id : 0;
>>   }
>>   
>> +static bool attr_producer_clang(Dwarf_Die *die)
>> +{
>> +	Dwarf_Attribute attr;
>> +	const char *producer;
>> +
>> +	if (dwarf_attr(die, DW_AT_producer, &attr) == NULL)
>> +		return false;
>> +
>> +	producer = dwarf_formstring(&attr);
>> +	if (!producer)
>> +		return false;
>> +
> nit you could call attr_string(die, DW_AT_producer, NULL) to get the string

Good point. Will fix it in the next revision.

>
> jirka
>
>> +	return !!strstr(producer, "clang");
>> +}
>> +
> SNIP
>

