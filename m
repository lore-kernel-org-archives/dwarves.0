Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2562A1FFC45
	for <dwarves@vger.kernel.org>; Fri,  1 Aug 2025 20:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754081477; cv=none; b=f5TCTRsZvlkKbIzQS4fp7o2go2W0ybje4IQNm4zkUd7/cBRd9aHv/sqoKIIk6TM+5gFxMhxY0Cn+aka+I3HEf4y1FNgkPYuP/x7zwl1DbgVMjxE8K2p/+yhrxlA9AAqc3UKbYkSaCpeszgZNDrA2H8/8OA5M+ynFWDET/z+/Sf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754081477; c=relaxed/simple;
	bh=xZY6tZ/JyKDsNBQGe75fO8GtzU+6bYkqRIj9ncMVh/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gFMmmUms+vsdSKM1oJVWV+n06e9NiGVcraATjBw7IPkCrWM02BZLJP6qkUQxY0BC6n6DGOD2wD+VY/PeAdoo/UELfNu+CvPXzKMmeH2YTHvqgZ+myjkijs5rGgbeu1ZUb7ZNui78srnVX4AkfK6nMVoXPVfIsx4+LNDSFr4PV9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vCGIGBaL; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vCGIGBaL"
Message-ID: <3dcf7a0d-4a65-43d9-8fe8-34c7e0e20d62@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754081473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m+9hVMDZmK83QyLC/NMYHf69dl60DSRclAxc+B/DOOw=;
	b=vCGIGBaLufM1ORltm6UV0QOakyJyKdwMXieFD/FxFUZEDxnV4xBivpR9iHMoqm+cK8ZbfH
	tJaaBSEHu15znf4CUXBjmwOhGHZgPDSJZYeuBiwweZNH50zK0iBxikr4lyr0iplQAZIxZU
	YLr9Eoc0EVcJ60S2yfCNIQGw2b/X7Ck=
Date: Fri, 1 Aug 2025 13:51:06 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves v2] btf_encoder: group all function ELF syms by
 function name
To: Alan Maguire <alan.maguire@oracle.com>, olsajiri@gmail.com,
 dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, acme@kernel.org, andrii@kernel.org, ast@kernel.org,
 eddyz87@gmail.com, menglong8.dong@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kernel-team@meta.com
References: <20250729020308.103139-1-isolodrai@meta.com>
 <79a329ef-9bb3-454e-9135-731f2fd51951@oracle.com>
 <647eb60a-c8f2-4ad3-ad98-b49b6e713402@oracle.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <647eb60a-c8f2-4ad3-ad98-b49b6e713402@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/31/25 11:57 AM, Alan Maguire wrote:
> On 31/07/2025 15:16, Alan Maguire wrote:
>> On 29/07/2025 03:03, Ihor Solodrai wrote:
>>> btf_encoder collects function ELF symbols into a table, which is later
>>> used for processing DWARF data and determining whether a function can
>>> be added to BTF.
>>>
>>> So far the ELF symbol name was used as a key for search in this table,
>>> and a search by prefix match was attempted in cases when ELF symbol
>>> name has a compiler-generated suffix.
>>>
>>> This implementation has bugs [1][2], causing some functions to be
>>> inappropriately excluded from (or included into) BTF.
>>>
>>> Rework the implementation of the ELF functions table. Use a name of a
>>> function without any suffix - symbol name before the first occurrence
>>> of '.' - as a key. This way btf_encoder__find_function() always
>>> returns a valid elf_function object (or NULL).
>>>
>>> Collect an array of symbol name + address pairs from GElf_Sym for each
>>> elf_function when building the elf_functions table.
>>>
>>> Introduce ambiguous_addr flag to the btf_encoder_func_state. It is set
>>> when the function is saved by examining the array of ELF symbols in
>>> elf_function__has_ambiguous_address(). It tests whether there is only
>>> one unique address for this function name, taking into account that
>>> some addresses associated with it are not relevant:
>>>    * ".cold" suffix indicates a piece of hot/cold split
>>>    * ".part" suffix indicates a piece of partial inline
>>>
>>> When inspecting symbol name we have to search for any occurrence of
>>> the target suffix, as opposed to testing the entire suffix, or the end
>>> of a string. This is because suffixes may be combined by the compiler,
>>> for example producing ".isra0.cold", and the conclusion will be
>>> incorrect.
>>>
>>> In saved_functions_combine() check ambiguous_addr when deciding
>>> whether a function should be included in BTF.
>>>
>>> Successful CI run: https://github.com/acmel/dwarves/pull/68/checks
>>>
>>> I manually spot checked some of the ~200 functions from vmlinux (BPF
>>> CI-like kconfig) that are now excluded: all of those that I checked
>>> had multiple addresses, and some where static functions from different
>>> files with the same name.
>>>
>>> [1] https://lore.kernel.org/bpf/2f8c792e-9675-4385-b1cb-10266c72bd45@linux.dev/
>>> [2] https://lore.kernel.org/dwarves/6b4fda90fbf8f6aeeb2732bbfb6e81ba5669e2f3@linux.dev/
>>>
>>> v1: https://lore.kernel.org/dwarves/98f41eaf6dd364745013650d58c5f254a592221c@linux.dev/
>>> Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
>>
>> Thanks for doing this Ihor! Apologies for just thinking of this now, but
>> why don't we filter out the .cold and .part functions earlier, not even
>> adding them to the ELF functions list? Something like this on top of
>> your patch:
>>
>> $ git diff
>> diff --git a/btf_encoder.c b/btf_encoder.c
>> index 0aa94ae..f61db0f 100644
>> --- a/btf_encoder.c
>> +++ b/btf_encoder.c
>> @@ -1188,27 +1188,6 @@ static struct btf_encoder_func_state
>> *btf_encoder__alloc_func_state(struct btf_e
>>          return state;
>>   }
>>
>> -/* some "." suffixes do not correspond to real functions;
>> - * - .part for partial inline
>> - * - .cold for rarely-used codepath extracted for better code locality
>> - */
>> -static bool str_contains_non_fn_suffix(const char *str) {
>> -       static const char *skip[] = {
>> -               ".cold",
>> -               ".part"
>> -       };
>> -       char *suffix = strchr(str, '.');
>> -       int i;
>> -
>> -       if (!suffix)
>> -               return false;
>> -       for (i = 0; i < ARRAY_SIZE(skip); i++) {
>> -               if (strstr(suffix, skip[i]))
>> -                       return true;
>> -       }
>> -       return false;
>> -}
>> -
>>   static bool elf_function__has_ambiguous_address(struct elf_function
>> *func) {
>>          struct elf_function_sym *sym;
>>          uint64_t addr;
>> @@ -1219,12 +1198,10 @@ static bool
>> elf_function__has_ambiguous_address(struct elf_function *func) {
>>          addr = 0;
>>          for (int i = 0; i < func->sym_cnt; i++) {
>>                  sym = &func->syms[i];
>> -               if (!str_contains_non_fn_suffix(sym->name)) {
>> -                       if (addr && addr != sym->addr)
>> -                               return true;
>> -                       else
>> +               if (addr && addr != sym->addr)
>> +                       return true;
>> +               else
>>                                  addr = sym->addr;
>> -               }
>>          }
>>
>>
>>          return false;
>> @@ -2208,9 +2185,12 @@ static int elf_functions__collect(struct
>> elf_functions *functions)
>>                  func = &functions->entries[functions->cnt];
>>
>>                  suffix = strchr(sym_name, '.');
>> -               if (suffix)
>> +               if (suffix) {
>> +                       if (strstr(suffix, ".part") ||
>> +                           strstr(suffix, ".cold"))
>> +                               continue;
>>                          func->name = strndup(sym_name, suffix - sym_name);
>> -               else
>> +               } else
>>                          func->name = strdup(sym_name);
>>
>>                  if (!func->name) {
>>
>> I think that would work and saves later string comparisons, what do you
>> think?
>>
> 
> Apologies, this isn't sufficient. Considering cases like objpool_free(),
> the problem is it has two entries in ELF for objpool_free and
> objpool_free.part.0. So let's say we exclude objpool_free.part.0 from
> the ELF representation, then we could potentially end up excluding
> objpool_free as inconsistent if the DWARF for objpool_free.part.0
> doesn't match that of objpool_free. It would appear to be inconsistent
> but isn't really.

Alan, as far as I can tell, in your example the function would be
considered inconsistent independent of whether .part is included in
elf_function->syms or not. We determine argument inconsistency based
on DWARF data (struct function) passed into btf_encoder__save_func().

So if there is a difference in arguments between objpool_free.part.0
and objpool_free, it will be detected anyways.

A significant difference between v2 and v3 (just sent [1]) is in that
if there is *only* "foo.part.0" symbol but no "foo", then it will not
be included in v3 (because it's not in the elf_functions table), but
would be in v2 (because there is only one address). And the correct
behavior from the BTF encoding point of view is v3.

[1] 
https://lore.kernel.org/dwarves/20250801202009.3942492-1-ihor.solodrai@linux.dev/


> 
> I think the best thing might be to retain the .part/.cold repesentations
> in the ELF table but perhaps mark them with a flag (non_fn for
> non-function or similar?) at creation time to avoid expensive string
> comparisons later.

That's a good point. In v3 I exclude .part and .cold from the table,
and store ambiguous_addr flag in elf_function. If anything, we should
be doing less string comparisons now.

> 
> On the subject of improving matching, we do have address info for DWARF
> functions in many cases like this, and that can help guide DWARF->ELF
> mapping. I have a patch that helps collect function address info in
> dwarf_loader.c; perhaps we could make use of it in doing more accurate
> matching? In the above case for example, we actually have DWARF function
> addresses for both objpool_free and objpool_free.part.0 so we could in
> that case figure out the DWARF-ELF mapping even though there are
> multiple ELF addresses and multiple DWARF representations.
> 
> Haven't thought it through fully to be honest, but I think we want to
> avoid edge cases like the above where we either label a function as
> inconsistent or ambiguous unnecessarily. I'll try to come up with a
> rough proof-of-concept that weaves address-based matching into the
> approach you have here, since what you've done is a huge improvement.
> Again sorry for the noise here, I struggle to think through all the
> permutations we have to consider here to be honest.
> 
> Thanks!
> 
> Alan
> 
> 
> [...]
> 

