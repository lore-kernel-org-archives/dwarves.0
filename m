Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0722937104A
	for <dwarves@vger.kernel.org>; Tue,  2 Jun 2026 19:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780426865; cv=none; b=ASag+epyE4HphDl/Uuf2OSbItflFocMYWCziUWiPfEvry/Ey42UNA9dW1P81TbtnKHOwDX7a603wPM3ZriUOXntzFtZOz5qb3ONVtvXUoaMt7orFKeSvHEFEvJi9wCWWKZrK/rXcgX30qeiCpzbGXjJqlVuqX+HkMfuzVolL/r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780426865; c=relaxed/simple;
	bh=gkezloQysMAda+AQ+wh5iiMxSXZ738y2rEQK0MShuLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hbr7n+p5bqKZRn5w661ZEBPQkVGJp16jp+ql/qveB1H80kom06+AJA+DTrQ+aVIcnCxbYAIBpo4U5WSZWfn2JRlsbK2o4RbZ/PoyPbUlZiL9gJowA0+HLg5hkiq1RYZOM4/LjQdvN4R2muF0sCa3u4a6hZa/8oWY6nceKtGso/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HP0tYsNh; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HP0tYsNh"
Message-ID: <e3cd95d7-88bd-4db3-b5d3-a3d5e293958f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780426852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dY8dw7ojl3hnIYlPOQfrEe8slON93spQR00/JQTCnN0=;
	b=HP0tYsNh9lP1X3x/h2WqeChOTHM5esBgGs6/KrlYzCi0zVNeS71fLzTTVQA3E3mvvKftkJ
	IAvzwkblCxX8tuV7p9akXMQLe3/z7XpuV0r2cP6dVwo6zBe3XkBe6/LGxiqIxNWR38XPs/
	G5fM1Yu2alwZpKVrdlbqVa8JPGR7qWs=
Date: Tue, 2 Jun 2026 12:00:45 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PAHOLE v3 1/3] dwarf_loader: Extract die__add_btf_type_tag()
 helper
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>
Cc: dwarves@vger.kernel.org, bpf@vger.kernel.org,
 Andrii Nakryiko <andrii@kernel.org>, Alan Maguire <alan.maguire@oracle.com>,
 jose.marchesi@oracle.com, David Faust <david.faust@oracle.com>
References: <20260601183511.594100-1-vineet.gupta@linux.dev>
 <DIXYL7ZGEO7C.3HN24VDJYZQOR@etsalapatis.com> <ah8dl-yaSPm64GhP@x1>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <ah8dl-yaSPm64GhP@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/2/26 11:14 AM, Arnaldo Carvalho de Melo wrote:
> On Mon, Jun 01, 2026 at 03:27:41PM -0400, Emil Tsalapatis wrote:
>> On Mon Jun 1, 2026 at 2:35 PM EDT, Vineet Gupta wrote:
>>> NFC change preparing for DW_TAG_GNU_annotation support.
>>> Extract the btf_type_tag annotation creation logic from into a helper
>>> die__add_btf_type_tag().
>>>
>>> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
>>> ---
>>> Changes since v2 [2]
>>>   - die__add_btf_type_tag() returns pointer not error code.
>>>
>>> Changes since v1 [1]
>>>   - NFC reinstate some original comments
>> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>   
>> Minor nit/question below.
> Some more nits below :-)
>   
>>> +++ b/dwarf_loader.c
>>> @@ -1600,14 +1600,43 @@ static struct btf_type_tag_type *die__create_new_btf_type_tag_type(Dwarf_Die *di
>>>   	return tag;
>>>   }
>>>   
>>> +static struct btf_type_tag_ptr_type *die__add_btf_type_tag(struct btf_type_tag_ptr_type *tag,
>>> +							    Dwarf_Die *die, Dwarf_Die *adie,
>>> +							    struct cu *cu, struct conf_load *conf)
>>> +{
>>> +	struct btf_type_tag_type *annot;
>>> +	uint32_t id;
>>> +
>>> +	if (tag == NULL) {
>>> +		tag = die__create_new_btf_type_tag_ptr_type(die, cu);
>>> +		if (!tag)
>>> +			return NULL;
> There was an inconsistency on the code you moved here, namely first tag
> is tested against NULL then it is negated, equivalent, but since we're
> moving it, lets make it consistent, in the kernel it is most common to
> use !ptr as it is more compact, so please make the first test !tag, just
> like the second.

Thx, I already spotted that and fixed for v4.

>
>>> +	}
>>> +
>>> +	annot = die__create_new_btf_type_tag_type(adie, cu, conf);
>>> +	if (annot == NULL)
>>> +		return NULL;
>>> +
>>> +	if (cu__table_add_tag(cu, &annot->tag, &id) < 0)
>>> +		return NULL;
>>> +
>>> +	struct dwarf_tag *dtag = tag__dwarf(&annot->tag);
>>> +	dtag->small_id = id;
>>> +	cu__hash(cu, &annot->tag);
>>> +
>>> +	/* Prepends: for annotations tag1 -> tag2 -> tag3,
>   
>> Not familiar with pahole's coding style, do we want to adjust the
>> comments?
> Not that important, but we try to follow kernel style, so yeah that
> would be:
>
> 	/*
> 	 * Prepends: for annotations tag1 -> tag2 -> tag3,
>
> But by now I don't dwell that much on these minor details :)

Ok will fix it.

Thx,
-Vineet
