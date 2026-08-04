Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66AB3C1419
	for <dwarves@vger.kernel.org>; Tue,  4 Aug 2026 21:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785880533; cv=none; b=tiJhOm6yUV+M4axUT+n9ufDxAHIQw/wZ69wZTE6ZWgiG11xCpmnSlla0x+ESxcs4GK0Sh/T28u8570oa5EEcpcJQ8fQWWQ0FEevpBp6oS5u8BaYCbvSn1mn+omTT0foFXlKSuF1YYUTXFHdnPe/zVIeFKyZjBWfgT+veP0DyydM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785880533; c=relaxed/simple;
	bh=0ybiM/2djnfugrk31flrKTk2gU7/8lQuRy06B13jr0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tdS/Rlezqi/btjn9NEiiU6BDZz+pzyjcXW3Is3YJGuoq/3ix4QwpBcqLq9LmE78mq97S6BjIuUz9CrhEkzejpgDdNAwzU8wgRbF4RTfwSkgRr40gPEIvNoIEmECA2o+NmM5y/lQiKrDBqdExh49P2xDbKd8V6HqZqA9taA9jDhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UPedAgwv; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UPedAgwv"
Message-ID: <4fefc832-b9b8-48d4-b472-82d6dea48354@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785880519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cryV3omF+m4pJNR6JVJTT39bkDuxoNs7bCmXz8MlJuI=;
	b=UPedAgwvSrG3ikzAs9X8f+m02BSpOnlatapM+ZIIT6nO6KpycTDsn68gJlhsrCU1VFmg9D
	RAGJUTbQ/JokBy2gwXmNMzBYu2Zg8LsLdGb9xX9BI5esNR9pLx3IKC45MtDFR321e8SEAO
	vvfa1Nah+Fjt37fFRt0a+gdSMfLmjns=
Date: Tue, 4 Aug 2026 14:55:12 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves] btf_encoder: Infer arena kfunc arguments from
 suffixes
To: Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Alan Maguire <alan.maguire@oracle.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Tejun Heo <tj@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>
References: <20260803125518.2279340-1-memxor@gmail.com>
 <4cb8bb30-1f01-4b78-a6b1-4ade3b965039@linux.dev>
 <DKGENYO9FITK.1M51V4BULBSYT@gmail.com>
 <8dc173dc3d051d338916c72cae070238718fd196.camel@gmail.com>
 <6c9500d4-7401-44f0-93a6-88a827026ae0@linux.dev>
 <4d20aecf677f4aec3e8e70106d4bdbcb01902e69.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <4d20aecf677f4aec3e8e70106d4bdbcb01902e69.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 8/4/26 2:34 PM, Eduard Zingerman wrote:
> On Tue, 2026-08-04 at 14:19 -0700, Ihor Solodrai wrote:
>> On 8/4/26 1:22 PM, Eduard Zingerman wrote:
>>> On Tue, 2026-08-04 at 21:27 +0200, Kumar Kartikeya Dwivedi wrote:
>>>> On Tue Aug 4, 2026 at 8:43 PM CEST, Ihor Solodrai wrote:
>>>>> On 8/3/26 5:55 AM, Kumar Kartikeya Dwivedi wrote:
>>>>>> [...]
>>>>
>>>>>
>>>>> So while I understand the reluctance to add KF_ARENA_ARG3..N, I don't
>>>>> think we want to introduce and support yet another mechanism for arena
>>>>> argument annotations. If we do, we'll be stuck with a mess of
>>>>> supporting two/three ways of doing the same thing for the foreseeable future.
>>>>
>>>> I think one major difference is that KF_ARENA_ARG* things were mostly for
>>>> annotating the vmlinux.h with the right address space label before, but didn't
>>>> carry any semantic meaning for the kfunc's type checks.
>>>>
>>>> That changes with these suffixes though. The pointer will be translated when
>>>> passed into the kfunc. IMO it would be odd to diverge for this particular case,
>>>> since we use suffixes for every other case where we constrain the input type of
>>>> the kfunc argument or give it special meaning.
>>>>
>>>> We also want to have similar annotation on struct_ops callbacks, where we also
>>>> use suffixes, so it seemed better to keep it consistent.
>>>
>>> I agree that we should follow the principle of least surprise here and
>>> use suffixes, as everything else uses suffixes as well.
>>
>> Ok, I understand the motivation. Let's say we use the suffixes.
>>
>> Should this enable getting rid of KF_ARENA* flags then? For the
>> purposes of generating address_space(1), we can also just check the
>> name suffix, no?
> 
> That would be ideal, yes.
> 
>>>
>>> And yes, the __arena and KF_ARENA_ARG* annotations have different
>>> semantics:
>>> - __arena means that user space arena address is passed as is
>>> - KF_ARENA_ARG* means that a user space address is converted
>>>   to a kernel space address before passing.
>>
>> Also I am a little confused about whether we *need* to be able to
>> express two distinct meanings of "arena pointer" or not?
>>
>> My understanding is that "arena pointer" is a feature of an arg type
>> that has a single meaning: the pointer has one base in BPF world, and
>> a different base when executed in the kernel.
>>
>> The things that are missing is auto-conversion (Tejun's RFC [1]) and more
>> comprehensive support of PTR_TO_ARENA in the verifier.
>>
>> This is still only one "arena" annotation per arg. Do we actually need
>> the proliferation of __arena, __arena__nullable and/or __arena_kern,
>> __arena_user? Can't we have a single defined semantics of how arena
>> pointers are supposed to work?
>>
>> I can imagine something like follows:
>>   * arena pointers can not be null, check for nulls
>>     before passing from BPF prog to the kernel
> 
> We are deliberately lax when handling arena and don't do any kind of
> value tracking there. So e.g. the following won't work:
> 
>   if (foo->ptr) {
>     ...
>     kfunc(foo->ptr);
>   }
> 
> Unless compiler decides to keep foo->ptr in a register. I'm not sure
> whether enforcing non-null here from the verifier side is the right
> call.

I don't argue for this particular semantics, it's just an example.

My point is to have unified defined rules for arena pointers, to allow
making safe assumptions everywhere when working with them. Both as a user
and in the kernel.

> 
>>   * arena pointers are converted to the kernel space for
>>     kfunc/struct_ops callback by the verifier
>>
>> With the documented and enforced semantics like this one way of
>> annotating and one annotation should be enough.
>>
>> What am I missing?
> 
> At the moment we have two consumers:
> - Planned sched_ext related kfuncs that need kernel space pointers.
> - Existing kfuncs with KF_ARENA_ARG:
>   - bpf_arena_alloc_pages
>   - bpf_arena_free_pages
>   - bpf_arena_reserve_pages
>   They, take a user space address. Looking at the code is appears that
>   all three can be changed to handle kernel space address.
>   On the other hand, neither of these *needs* the passed pointer to be
>   converted to a kernel side arena pointer. So that would be just some
>   useless work.
> 
> So there are two valid use cases.

I think having more than one way of how to pass an arena pointer to
the kernel will create more confusion than bring value.

It seems to me the existing bpf_arena_* kfuncs accept user space
address for historical reasons (we just tried something that worked),
not by design exactly.

btw, Eduard, I get very confused by how you say "user space".. you
mean the 32bit value representing the BPF arena pointer, right?

Anyways, I think we should converge on the approach to arena pointers
handling before landing anything.

Let's use __arena suffix as annotation mechanism, fine. But
I really wouldn't like to end up with N annotations for each
permutation of (non-)nullable and kern/user...

I'll submit the resolve_btfids patches asap to not block on that.


> 
> ...

