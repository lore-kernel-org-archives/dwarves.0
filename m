Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB55539E6F8
	for <dwarves@vger.kernel.org>; Tue,  2 Jun 2026 18:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780426473; cv=none; b=VQIwLegmkgVyouefQ2BgONnRFlDtrAhRvK+0pxqpfEK0chi5G1WpUwsezv77Vw9Aj1L7NKRuwHszLjnbCc0lrl4k5Igy3bfJgGBYliYeVPvstLPp3XrMlfLyvdKa8hV+CuR35cCiaeQbTIUMfT64KggW/ZfifHrSpV7SpoLut+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780426473; c=relaxed/simple;
	bh=cKPNcXHdC1j74KMh1wcdH6FjcKxiPPvCXPyV8TcXfo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hP7io7gHVtokA0GYRrpid0as4tzZabww9kBxM4q6tSEygq5roXf1+eZ54X9L2x/1MJeVRQC3o8DIgX/u4pMzlEpQNIAAabMAg+B1pvssprrcIif3k/wRyvuZ77xA0l7TELULz9jaCbRbPN8//t4X6MPagDTwTjDSLirWUiONKbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y9FvsLdd; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y9FvsLdd"
Message-ID: <edad0f67-07f6-44df-b6da-4e4c3660e937@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780426467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hp0qpPB48gWeC90+YVeXK/R2N/pxJbKSzL/GewP1mAc=;
	b=Y9FvsLddDqYtEjb1dukP/i7ecNoPH3ZB9JI6tk3gk529Fom2vpook+A3B3hZS1iduDhpS+
	qG5VbhHGXEU+vq/i6IuupLifg85HTytZ3yXBLuGly5oXpVo47mbdJYZkImWXLpSMG6fiLz
	SAlIGfJYBmo6pn4sts5JWMIg+QVPfS0=
Date: Tue, 2 Jun 2026 11:54:17 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PAHOLE v3 2/3] dwarf_loader: Add support for
 DW_TAG_GNU_annotation
To: Emil Tsalapatis <emil@etsalapatis.com>, dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 acme@kernel.org, Alan Maguire <alan.maguire@oracle.com>,
 jose.marchesi@oracle.com, David Faust <david.faust@oracle.com>
References: <20260601183511.594100-1-vineet.gupta@linux.dev>
 <20260601183511.594100-2-vineet.gupta@linux.dev>
 <DIY5R0P9CJKJ.3S0RU6SR33V49@etsalapatis.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <DIY5R0P9CJKJ.3S0RU6SR33V49@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Emil,

On 6/1/26 6:04 PM, Emil Tsalapatis wrote:
>>   }
>>   
>> +static bool die__tag_is_annotation(Dwarf_Die *die)
>> +{
>> +	unsigned int tag = dwarf_tag(die);
>> +	return tag == DW_TAG_LLVM_annotation || tag == DW_TAG_GNU_annotation;
> Can we also have a shorthand static inline for
>
> tag == DW_TAG_LLVM_annotation || tag == DW_TAG_GNU_annotation
>
> ? Would be nice in a bunch of places.

OK.
>
>> +}
>> +
>>   static int add_llvm_annotation(Dwarf_Die *die, int component_idx, struct conf_load *conf,
>>   			       struct list_head *head)

This one is used by both so I renamed it to add_tag_annotation.

>>   {
>> @@ -943,7 +949,7 @@ static int add_child_llvm_annotations(Dwarf_Die *die, int component_idx,
> Since this is not just LLVM annotations can we rename it to
> *_tag_annotations or something similar? Same for all other llvm-named
> fucntions we are explicitly handling GCC tags in.

This is llvm specific, since the child style annotations are generated 
by llvm only. So the current name makes sense.

>>   	die = &child;
>>   	do {
>> -		if (dwarf_tag(die) == DW_TAG_LLVM_annotation) {
>> +		if (die__tag_is_annotation(die)) {
>>   			ret = add_llvm_annotation(die, component_idx, conf, head);
>>   			if (ret)
>>   				return ret;
>> @@ -953,6 +959,35 @@ static int add_child_llvm_annotations(Dwarf_Die *die, int component_idx,
>>   	return 0;
>>   }
>>   
>> +/* Handle gcc sytle btf_decl_tag annotations for functions/struct/member tags
> Typo: sytle -> style

Fixed.

>> + * Pointers are handled seperately, inline in die__create_new_pointer_tag ()
> Typo: seperately -> separately, also maybe remove the space before the ()

Fixed.

>> + */
>> +static int add_gnu_annotation_chain(Dwarf_Die *die, int component_idx,
>> +				    struct conf_load *conf, struct list_head *head)
>> +{
>> +	Dwarf_Attribute attr;
>> +	Dwarf_Die annot_die;
>> +
>> +	if (dwarf_attr(die, DW_AT_GNU_annotation, &attr) == NULL ||
>> +	    dwarf_formref_die(&attr, &annot_die) == NULL)
>> +		return 0;
>> +
>> +	for (;;) {
>> +		if (dwarf_tag(&annot_die) != DW_TAG_GNU_annotation)
>> +			break;
>> +
>> +		int ret = add_llvm_annotation(&annot_die, component_idx, conf, head);
> E.g., here imo it makes sense to keep the llvm name since AFAICT this is
> one of the places where we normalize the GCC tags.

Normalization is just an internal detail, this is actually using the 
common functionality which we already renamed above to the agnostic name 
add_tag_annotation.

>> -	/* If no child tags or skipping btf_type_tag encoding, just create a new tag
>> -	 * and return
>> -	 */
>> -	if (!dwarf_haschildren(die) || dwarf_child(die, &child) != 0 ||
>> -	    conf->skip_encoding_btf_type_tag)
>> +	/* If skipping btf_type_tag encoding, just create a new tag, return */
>> +	if (conf->skip_encoding_btf_type_tag)
>>   		return tag__new(die, cu);
>>   
>> -	/* Otherwise, check DW_TAG_LLVM_annotation child tags */
>> +	/* Handle LLVM style annotation tags if present */
> Can we move this comment to right below the goto? It's slightly
> confusing here.

Yep makes sense. Also for consistency did the same for the GNU comment.

> For that matter, why are we processing LLVM and GNU tags in succession?
> Could we just turn check_gnu_attr into a separate function and instead
> of a goto do
>
> return check_gnu_attr();
>
> ?
>
> Then again mixing the two types of tags seems theoretically possible
> and the least surprising thing to do is handle both.

Code to handle both needs to exist in some shape and form, we just do it 
one after other, rather then in an if .. else.
If LLVM style handling happens, @tag at the end of llvm loop will be non 
null and it won't enter the gnu block, its clear enough from looking at 
the code IMO.
Carving out another function feels a bit excessive.

>>   		}
>> diff --git a/dwarves.h b/dwarves.h
>> index 5ec16e750e83..42b8e39aa2dd 100644
>> --- a/dwarves.h
>> +++ b/dwarves.h
>> @@ -670,7 +670,8 @@ static inline int tag__is_tag_type(const struct tag *tag)
>>   	       tag->tag == DW_TAG_volatile_type ||
>>   	       tag->tag == DW_TAG_atomic_type ||
>>   	       tag->tag == DW_TAG_unspecified_type ||
>> -	       tag->tag == DW_TAG_LLVM_annotation;
>> +	       tag->tag == DW_TAG_LLVM_annotation ||
>> +	       tag->tag == DW_TAG_GNU_annotation;
> Another place where we can just have an "is annotation tag" predicate.

Fixed.

>
>> @@ -731,7 +734,7 @@ static type_id_t skip_llvm_annotations(const struct cu *cu, type_id_t id)
> Rename this function to not be llvm-specific anymore?

OK.

>
>>   		if (id == 0)
>>   			break;
>>   		type = cu__type(cu, id);
>> -		if (type == NULL || type->tag != DW_TAG_LLVM_annotation || type->type == id)
>> +		if (type == NULL || (type->tag != DW_TAG_LLVM_annotation && type->tag != DW_TAG_GNU_annotation) || type->type == id)
> Same as before wrt predicate

OK.

Thx for the good feedback.
-Vineet
