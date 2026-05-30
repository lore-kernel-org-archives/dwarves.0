Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DE021A92F
	for <dwarves@vger.kernel.org>; Sat, 30 May 2026 01:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780104693; cv=none; b=plNPIrb1gThMuSJ7WnI4J5LAiQd2FvqhPH6RET5bRldRPz/F/+I6W20wrkQqbXfd9R09LamUU/H11Ph7v9w2gOb7BPGuD/vC5/TRL6NHbqHa3ZErihNVjpj2uXFn9cCY8OZHlfzX056mOH/Cv8OWy9wyOoR9iWZ74HpK9fZktAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780104693; c=relaxed/simple;
	bh=P9/zA6W/1qq90V9pGmd1lTXgpbs/FReaY88kd1Zdyoo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=A9FivTG/hK0vCkWxT0AsK0qgwPrNqyfjtLieetF/njOA57kkSHCyoM6CWl5X05A8z/+gUMCQu3zuF4DBh1tGzSoiJSLHvaN9v3XQznPnMXC/YVHK1/cQ9Xe3musEXg20JdwFrco9fYqtcw7Yxve4pucZ0DyYvU2RJPt+NBAi4jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZRsqAACs; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZRsqAACs"
Message-ID: <767b89e4-baba-459d-80d2-2b6dd0c01a1b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780104679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7SmJJUrMunxKqPLHQAkFQDZXKDNgg5kmEcOvfW8xdbU=;
	b=ZRsqAACslmL1f3NXOIHEfgP38DE6VLl6K2AJdlh+Nt7hNKOu77bDn5Ooo7X+KpHlY5NlsT
	NnyUCu5v/tmFiJOtBlVg8YCkUluNMfaHvU2vb33IIev6OdFtSst+I9SXpIkRzBuzj/nOU1
	01PzNLbblRfkagTYtc3T8uWjCzEZBAY=
Date: Fri, 29 May 2026 18:31:10 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PAHOLE Patch v2 2/2] Add support for DW_TAG_GNU_annotation
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vineet Gupta <vineet.gupta@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>, dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 acme@kernel.org, jose.marchesi@oracle.com,
 David Faust <david.faust@oracle.com>
References: <20260528223616.2035618-1-vineet.gupta@linux.dev>
 <20260528223616.2035618-2-vineet.gupta@linux.dev>
 <81094fe9-c77e-4f84-9449-e7c9bb29fad6@oracle.com>
 <7497e2f5-024b-41ff-8d9b-6e26bd46d954@linux.dev>
Content-Language: en-US
In-Reply-To: <7497e2f5-024b-41ff-8d9b-6e26bd46d954@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 5/29/26 16:32, Vineet Gupta wrote:
> On 5/29/26 06:37, Alan Maguire wrote:
>> thanks for this Vineet! I'm building gcc-16 to manually test now but 
>> I have a few
>> suggestions below in the meantime. Changes look good in CI [1]
>>
>> [1] https://github.com/alan-maguire/dwarves/actions/runs/26632028538
>
> Cool.
>>> +static int add_gnu_annotation_chain(Dwarf_Die *die, int component_idx,
>>> +                    struct conf_load *conf, struct list_head *head)
>>> +{
>>> +    Dwarf_Attribute attr;
>>> +    Dwarf_Die annot_die;
>>> +
>>> +    if (dwarf_attr(die, DW_AT_GNU_annotation, &attr) == NULL ||
>>> +        dwarf_formref_die(&attr, &annot_die) == NULL)
>>> +        return 0;
>>> +
>>> +    for (;;) {
>>> +        if (dwarf_tag(&annot_die) != DW_TAG_GNU_annotation)
>>> +            break;
>>> +
>>> +        int ret = add_llvm_annotation(&annot_die, component_idx, 
>>> conf, head);
>>> +        if (ret)
>>> +            return ret;
>>> +
>>> +        if (dwarf_attr(&annot_die, DW_AT_GNU_annotation, &attr) == 
>>> NULL ||
>>> +            dwarf_formref_die(&attr, &annot_die) == NULL)
>>> +            break;
>>> +    }
>> the pointer tag handling below uses bookkeeping to track visited 
>> dies; is there a need
>> for that here too? maybe a bit paranoid but perhaps we could haul the 
>> loop detection
>> logic out and reuse in both places?
>
> Looking back now, the loop detection seems excessive. It was from the 
> initial attempt to triage what seemed like an infinite loop in pahole 
> but just turned out to be excessive match failures and bails and 
> retries due to the gcc bug [1] which was generating variants of same 
> core struct, causing failures pretty much everywhere due to the core 
> struct being embedded all over. If we want to add loop detection that 
> should be addon as it unconditional additional processing. I agree 
> that even with that out of picture this function and the opencoded 
> check_gnu_attr code seem to share a lot of structure - but they have 
> their own *thing* to do and it would be unwieldy and awkward to factor 
> out into a shared loop body with a call back or an additional arg to 
> call add_llvm_annotation or die__add_btf_type_tag for either of those 
> cases.
>
> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=125421 
> <https://gcc.gnu.org/bugzilla/show_bug.cgi?id=125421>
>
>>> +check_gnu_attr:
>>> +    /* Check for GCC-style DW_AT_GNU_annotation attribute */
>>> +    if (tag != NULL ||
>>> +        dwarf_attr(die, DW_AT_GNU_annotation, &attr) == NULL ||
>>> +        dwarf_formref_die(&attr, &annot_die) == NULL)
>>> +        goto out;
>>> +
>>> +    Dwarf_Off visited[256];
>>> +    int nr_visited = 0;
>>> +
>>> +    for (;;) {
>>> +        Dwarf_Off off = dwarf_dieoffset(&annot_die);
>>> +        bool cycle = false;
>>> +        int i;
>>> +
>>> +        for (i = 0; i < nr_visited; i++) {
>>> +            if (visited[i] == off) {
>>> +                cycle = true;
>>> +                break;
>>> +            }
>>> +        }
>>> +        if (cycle || nr_visited >= (int)ARRAY_SIZE(visited))
>>> +            break;
>>> +        visited[nr_visited++] = off;
>
> I'm thinking of ripping this all out. Rest of dwarf machinery feels 
> robust enough.
>
>>> +
>>> +        if (dwarf_tag(&annot_die) != DW_TAG_GNU_annotation)
>>> +            break;
>>> +
>>> +        name = attr_string(&annot_die, DW_AT_name, conf);
>>> +        if (strcmp(name, "btf_type_tag") != 0)
>>> +            break;
>> should we "continue;" here instead; if we encounter a non-type tag 
>> annotation
>> might we miss subsequent btf type tag annotations? might not be an 
>> issue today
>> but might be more future-proof to continue here maybe?
>
> Good point. Will do.

Claude suggests break is the right thing to do for precisely the reason 
you mention.
This code only handles DW_TAG_pointer_type DIEs which currently don't 
expect non-type tag, and this pertains to a single chain it could point 
to a potential issue as of now.
But up to you what you feel is better.

Thx,
-Vineet
