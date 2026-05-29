Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03A32DA749
	for <dwarves@vger.kernel.org>; Fri, 29 May 2026 23:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780097564; cv=none; b=k1CZjhgmcSEtJ5nTx3z4vOn+V1y8opfkmG6YVcqNt5VYrnfQQr1mhbUyghHhtoezLKvRbrAxjhovUsH1MEMy8tqs5uCUrwEOgaYN1NFcXe6/c1/9NANx9lIILagd1nGUV2Jsob3+FinqnPIl9MxEQSz1WFuB4h/+NaQvqJjJxa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780097564; c=relaxed/simple;
	bh=EKUG5FaKEPTtW0ZCzGlbL5bRZQ+vKQfC2Pr6OAlvMYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SDoJu+xFlSiwOWXIMKs9U/2/00K41zEzkCZ+JRdjCEgY9nyli6jncLoYDipFY/QBCkuRKO/zod5KMtY6dn/sT0mDJWo67zT5von0It5acBQEUUOXYU/dhAOYQam3kjTeORQnTKtO9qKsf1i/J2mezbeA21005RAxFVsIYZF3kok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hQrC5H0K; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hQrC5H0K"
Message-ID: <7497e2f5-024b-41ff-8d9b-6e26bd46d954@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780097550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fq1pM4jaE1+5/YLEsuNROiVdiip51uo7jUA93DBpQDA=;
	b=hQrC5H0KDAVIstHxFNDalmYIC68hHgGPnOlDb6OYocOPqTL1p7VYc+nMhzcM9FYjZolD0a
	/feEeG+iqii/ImOdzPCwoE5vX4E3sHfq1ya9R+BT/FwCjV3Ne23Olsfkon2ai0jIT5Kp+Z
	1NL/8ya5aDvY9P006OdhaviBJlAGoHM=
Date: Fri, 29 May 2026 16:32:21 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PAHOLE Patch v2 2/2] Add support for DW_TAG_GNU_annotation
To: Alan Maguire <alan.maguire@oracle.com>, dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 acme@kernel.org, jose.marchesi@oracle.com,
 David Faust <david.faust@oracle.com>
References: <20260528223616.2035618-1-vineet.gupta@linux.dev>
 <20260528223616.2035618-2-vineet.gupta@linux.dev>
 <81094fe9-c77e-4f84-9449-e7c9bb29fad6@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <81094fe9-c77e-4f84-9449-e7c9bb29fad6@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/29/26 06:37, Alan Maguire wrote:
> thanks for this Vineet! I'm building gcc-16 to manually test now but I have a few
> suggestions below in the meantime. Changes look good in CI [1]
>
> [1] https://github.com/alan-maguire/dwarves/actions/runs/26632028538

Cool.
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
>> +	}
> the pointer tag handling below uses bookkeeping to track visited dies; is there a need
> for that here too? maybe a bit paranoid but perhaps we could haul the loop detection
> logic out and reuse in both places?

Looking back now, the loop detection seems excessive. It was from the 
initial attempt to triage what seemed like an infinite loop in pahole 
but just turned out to be excessive match failures and bails and retries 
due to the gcc bug [1] which was generating variants of same core 
struct, causing failures pretty much everywhere due to the core struct 
being embedded all over. If we want to add loop detection that should be 
addon as it unconditional additional processing. I agree that even with 
that out of picture this function and the opencoded check_gnu_attr code 
seem to share a lot of structure - but they have their own *thing* to do 
and it would be unwieldy and awkward to factor out into a shared loop 
body with a call back or an additional arg to call add_llvm_annotation 
or die__add_btf_type_tag for either of those cases.

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=125421 
<https://gcc.gnu.org/bugzilla/show_bug.cgi?id=125421>

>> +check_gnu_attr:
>> +	/* Check for GCC-style DW_AT_GNU_annotation attribute */
>> +	if (tag != NULL ||
>> +	    dwarf_attr(die, DW_AT_GNU_annotation, &attr) == NULL ||
>> +	    dwarf_formref_die(&attr, &annot_die) == NULL)
>> +		goto out;
>> +
>> +	Dwarf_Off visited[256];
>> +	int nr_visited = 0;
>> +
>> +	for (;;) {
>> +		Dwarf_Off off = dwarf_dieoffset(&annot_die);
>> +		bool cycle = false;
>> +		int i;
>> +
>> +		for (i = 0; i < nr_visited; i++) {
>> +			if (visited[i] == off) {
>> +				cycle = true;
>> +				break;
>> +			}
>> +		}
>> +		if (cycle || nr_visited >= (int)ARRAY_SIZE(visited))
>> +			break;
>> +		visited[nr_visited++] = off;

I'm thinking of ripping this all out. Rest of dwarf machinery feels 
robust enough.

>> +
>> +		if (dwarf_tag(&annot_die) != DW_TAG_GNU_annotation)
>> +			break;
>> +
>> +		name = attr_string(&annot_die, DW_AT_name, conf);
>> +		if (strcmp(name, "btf_type_tag") != 0)
>> +			break;
> should we "continue;" here instead; if we encounter a non-type tag annotation
> might we miss subsequent btf type tag annotations? might not be an issue today
> but might be more future-proof to continue here maybe?

Good point. Will do.

>
>> +
>> +		if (die__add_btf_type_tag(&tag, die, &annot_die, cu, conf))
>> +			return NULL;
>> +
>> +		if (dwarf_attr(&annot_die, DW_AT_GNU_annotation, &attr) == NULL ||
>> +		    dwarf_formref_die(&attr, &annot_die) == NULL)
>> +			break;
>> +	}
>> +
>> +out:
>>   	return tag ? &tag->tag : tag__new(die, cu);
>>   }

[snip]

>>   
>>
>> diff --git a/tests/pfunct-btf-decl-tags.sh b/tests/pfunct-btf-decl-tags.sh
>> index 35884b4e8687..5fdddc09f179 100755
>> --- a/tests/pfunct-btf-decl-tags.sh
>> +++ b/tests/pfunct-btf-decl-tags.sh
>> @@ -13,17 +13,21 @@ trap cleanup EXIT
>>   
>>   title_log "Check that pfunct can print btf_decl_tags read from BTF."
>>   
>> -# gcc now also supports decl tags as of gcc commit 43dcea48b8c,
>> -# in upstream version 16.
>> -# UPTODO: add a check here for that.
>> +# gcc 16+ supports decl tags via DW_TAG_GNU_annotation (gcc commit ac7027f180b).
>> +# Use gcc if available and version >= 16, otherwise fall back to clang.
>>   
> Is there a reason why we couldn't do both? We'd ideally have CI test both clang
> and gcc so wouldn't want to skip one or the other really. I'd suggest we lose
> the elif logic below and test with whatever is available gcc, clang or both
> ideally. We can fix up CI to install gcc 16 later.

OK.

> Also I'd suggest move the test to a separate patch. Thanks!

The test was already there, just not wired up for gcc. So it seems the 
ask is to leave it disabled here do a separate patch for enabling. Sure 
that works too.

Thx,
-Vineet
