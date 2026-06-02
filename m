Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4EE3A759D
	for <dwarves@vger.kernel.org>; Tue,  2 Jun 2026 19:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780428244; cv=none; b=XNn6F/+1RqtWiIworJHQmn7tIOWB7hGnyO1fWomWQG9gBhkv6x+dXqR76mu0aJVYHx0SboIsZr2AEgyKKUNxli3WkObIC/i4NkiltHsCcYy26rNFrpCnPU2oN2/HOIO3xnmsweJW/RpaQRPIi1VJ0HWLtI+5KqbnejLVhcc4vHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780428244; c=relaxed/simple;
	bh=OoJ/z3veT4ZIrbJH377j1oTUckRwJWOW10IOrPSRtfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IuIseNdOHnP5UD3W4MoWrhUkcp8xkQ0VBUtcYdVIMJt3giuB+JixGFYxECRLEKGeTEWucoxjxq6tYNuDX1xi8zP5rcB4zRs5yhe8ke9SVmJXy06HRWdxyyI+YnU8kk+iU6GAZXdcBeea3KdU010fbgHnzdR6yqIDY4LbLNYfpXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VVVBtp2W; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VVVBtp2W"
Message-ID: <10970aec-9e78-4c0b-85d0-e04e863a0662@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780428230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CBrkwsUFXieCOUvxcufFnNgiZKGphLZwMZDX/XJNwpk=;
	b=VVVBtp2WL1Xq+WC/kIYal8/a0ixh45FsSpfsnRgmsCpQdmJyL/pZ+vaZXoa5JE3bYC6zP2
	GGYFimrnzG2VGDR+8Td1JxPfojRmsdK4URkmZsmShywhXtVBX/tZfmS63wsiT8vS+chJyA
	u09kSPlLCVjRZhLDYqoEswveHOFhbW0=
Date: Tue, 2 Jun 2026 12:23:45 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PAHOLE v3 2/3] dwarf_loader: Add support for
 DW_TAG_GNU_annotation
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org, bpf@vger.kernel.org,
 Andrii Nakryiko <andrii@kernel.org>, Alan Maguire <alan.maguire@oracle.com>,
 jose.marchesi@oracle.com, David Faust <david.faust@oracle.com>
References: <20260601183511.594100-1-vineet.gupta@linux.dev>
 <20260601183511.594100-2-vineet.gupta@linux.dev> <ah8f-dkC9AQiIPxR@x1>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <ah8f-dkC9AQiIPxR@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 6/2/26 11:24 AM, Arnaldo Carvalho de Melo wrote:
> On Mon, Jun 01, 2026 at 11:35:10AM -0700, Vineet Gupta wrote:
>> gcc 16 was first release to support DW_TAG_GNU_annotation and this patch
>> enables the same in pahole. Bulk of changes are in dwarf_loader but
>> btf_encoder also gains support with minimal changes.
>>
>> GCC encodes btf_type_tag and btf_decl_tag annotations differently from
>> LLVM. While LLVM uses DW_TAG_LLVM_annotation (0x6000) as child DIEs,
>> GCC uses DW_TAG_GNU_annotation (0x6001) as standalone sibling DIEs
>> referenced via DW_AT_GNU_annotation (0x2139) attributes, with chaining
>> through the same attribute on annotation DIEs themselves.
>>
>> Handle both encoding styles:
>>
>> For btf_type_tag (pointer annotations):
>> - Recognize DW_TAG_GNU_annotation alongside DW_TAG_LLVM_annotation in
>>    child annotation scanning.
>> - Follow DW_AT_GNU_annotation attribute chains on pointer types for
>>    GCC-style btf_type_tag resolution, with cycle detection.
>> - Normalize DW_TAG_GNU_annotation to DW_TAG_LLVM_annotation in the
>>    internal representation so downstream code works unchanged.
>>
>> For btf_decl_tag (function/struct/member annotations):
>> - Add add_gnu_annotation_chain() to follow DW_AT_GNU_annotation
>>    attribute chains on function, struct, and member DIEs.
>> - GCC puts DW_AT_GNU_annotation on the function/struct DIE itself
>>    (not as child DIEs), referencing sibling annotation DIEs that chain
>>    via the same attribute.
>>
>> Also:
>> - Silently skip standalone DW_TAG_GNU_annotation DIEs at CU level.
>> - Update pfunct-btf-decl-tags.sh test to use GCC 16+ when available and
>>    now passes.
>>
>> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
>> ---
>> Changes since v2 [2]
>>   - Removed loop detection logic
>>   - Move test changes to different patch
>>
>> Changes since v1 [1]
>>   - NFC Reduce indentation with early exits (Alexei offlist)
>>
>> [2] https://lore.kernel.org/bpf/20260528223616.2035618-2-vineet.gupta@linux.dev/
>> [1] https://lore.kernel.org/bpf/20260526181818.4159927-2-vineet.gupta@linux.dev/
>> ---
>>
>>   btf_encoder.c     |   1 +
>>   dutil.h           |   8 ++++
>>   dwarf_loader.c    | 102 ++++++++++++++++++++++++++++++++++++++++++----
>>   dwarves.h         |   3 +-
>>   dwarves_fprintf.c |   8 +++-
>>   5 files changed, 110 insertions(+), 12 deletions(-)
>>
>> diff --git a/btf_encoder.c b/btf_encoder.c
>> index 633bc6162ce0..d5af706d7638 100644
>> --- a/btf_encoder.c
>> +++ b/btf_encoder.c
>> @@ -1831,6 +1831,7 @@ static int btf_encoder__encode_tag(struct btf_encoder *encoder, struct tag *tag,
>>   		name = namespace__name(tag__namespace(tag));
>>   		return btf_encoder__add_ref_type(encoder, BTF_KIND_TYPEDEF, ref_type_id, name, false);
>>   	case DW_TAG_LLVM_annotation:
>> +	case DW_TAG_GNU_annotation:
>>   		name = tag__btf_type_tag(tag)->value;
>>   		return btf_encoder__add_ref_type(encoder, BTF_KIND_TYPE_TAG, ref_type_id, name, false);
>>   	case DW_TAG_structure_type:
>> diff --git a/dutil.h b/dutil.h
>> index ff78aa6dfd10..abe0e62b412f 100644
>> --- a/dutil.h
>> +++ b/dutil.h
>> @@ -35,6 +35,14 @@
>>   #define DW_TAG_LLVM_annotation 0x6000
>>   #endif
>>   
>> +#ifndef DW_TAG_GNU_annotation
>> +#define DW_TAG_GNU_annotation 0x6001
>> +#endif
>> +
>> +#ifndef DW_AT_GNU_annotation
>> +#define DW_AT_GNU_annotation 0x2139
>> +#endif
>> +
>>   static inline __attribute__((const)) bool is_power_of_2(unsigned long n)
>>   {
>>           return (n != 0 && ((n & (n - 1)) == 0));
>> diff --git a/dwarf_loader.c b/dwarf_loader.c
>> index 8b5b526299b5..878565884f85 100644
>> --- a/dwarf_loader.c
>> +++ b/dwarf_loader.c
>> @@ -908,6 +908,12 @@ static int tag__recode_dwarf_bitfield(struct tag *tag, struct cu *cu, uint16_t b
>>   	return -ENOMEM;
>>   }
>>   
>> +static bool die__tag_is_annotation(Dwarf_Die *die)
>> +{
>> +	unsigned int tag = dwarf_tag(die);
>> +	return tag == DW_TAG_LLVM_annotation || tag == DW_TAG_GNU_annotation;
>> +}
>> +
>>   static int add_llvm_annotation(Dwarf_Die *die, int component_idx, struct conf_load *conf,
>>   			       struct list_head *head)
>>   {
>> @@ -943,7 +949,7 @@ static int add_child_llvm_annotations(Dwarf_Die *die, int component_idx,
>>   
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
>> + * Pointers are handled seperately, inline in die__create_new_pointer_tag ()
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
>> +		if (ret)
>> +			return ret;
>> +
>> +		if (dwarf_attr(&annot_die, DW_AT_GNU_annotation, &attr) == NULL ||
>> +		    dwarf_formref_die(&attr, &annot_die) == NULL)
>> +			break;
> Make this more compact, no need to have these two if blocks, one
> suffices:
>
> static int add_gnu_annotation_chain(Dwarf_Die *die, int component_idx,
> 				    struct conf_load *conf, struct list_head *head)
>
> 	Dwarf_Attribute attr;
> 	Dwarf_Die annot_die;
> 	int ret = 0;
>
> 	while (dwarf_attr(die, DW_AT_GNU_annotation, &attr) != NULL &&
> 	       dwarf_formref_die(&attr, &annot_die) != NULL &&
> 	       dwarf_tag(&annot_die) == DW_TAG_GNU_annotation) {
> 		if ((ret = add_llvm_annotation(&annot_die, component_idx, conf, head)) != 0)
> 			break;
> 	}
>
> 	return ret;
> }

OK.
That duplication indeed was standing out, and while this seems denser to 
read, it feels like an improvement.

FWIW it does need an additional following line right before loop end 
since they were different in the orig version.
     die = &annot_die



>> +check_gnu_attr:
>> +	/* Check for GCC-style DW_AT_GNU_annotation attribute */
>> +	if (tag != NULL ||
>> +	    dwarf_attr(die, DW_AT_GNU_annotation, &attr) == NULL ||
>> +	    dwarf_formref_die(&attr, &annot_die) == NULL)
>> +		goto out;
>> +
>> +	for (;;) {
>> +		if (dwarf_tag(&annot_die) != DW_TAG_GNU_annotation)
>> +			break;
>> +
>> +		name = attr_string(&annot_die, DW_AT_name, conf);
>> +		if (strcmp(name, "btf_type_tag") != 0)
>> +			break;
>> +
>> +		tag = die__add_btf_type_tag(tag, die, &annot_die, cu, conf);
>> +		if (tag == NULL)
>> +			return NULL;
>> +
>> +		if (dwarf_attr(&annot_die, DW_AT_GNU_annotation, &attr) == NULL ||
>> +		    dwarf_formref_die(&attr, &annot_die) == NULL)
>> +			break;
>> +	}
> The loop above probably can get some simplification?

Yep nice and similar to above, with same adjustment to @die.

Thx for the review.
-Vineet
