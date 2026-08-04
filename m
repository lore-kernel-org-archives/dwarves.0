Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C89305678;
	Tue,  4 Aug 2026 22:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785881631; cv=none; b=dSiOUCxvNnG11Cv3TC1a+BLtIUWYU8xiHQ9pOE798g4yCbQZVHOfykBdxU8UAH2IJL4x9fi5MDcvUrjfXkBYEwq2HJADJ2FmVO39oB9W3KyIpzPd/9YcWCg2Utb60TzhTmqoszUr44UVRhNV2lNQrdMTv110fPhocvFjqM9s6Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785881631; c=relaxed/simple;
	bh=Ck2XZ/QW4/F8azPrrNsAlLLS6/JSn8RXQp1I4VJo+uQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JtvAYCdYiFYtOvRJDKf/XZY/O8qkLL2xWXtjBujG1VzqoJ38UtPL4nNjRpxaBV6gn290cKOadUFlRWlIGJHifmv6G2L9c/acGWfAYvCn4D5/CvikAkz+FhJ6D0yRnk/709qAj70zSwmiDFh6IzhqlAl8YU7+mSLSZodXmJjRtBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D4caiSl5; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D4caiSl5"
Message-ID: <26e0c308-e510-4050-a1c8-97d2c121b66b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785881625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FrT7zDCKkGS19sexayXLOnKUHs6ib8GG6BIoHD4Cnws=;
	b=D4caiSl5zJcW72CoeeHpmYKPPt/c5VUyOZZUtDhT7n7EM3XOqGQkjg2vMw9U/rC89QAxLc
	OhJXC8qEqPf4cvpme933gPkv9QSAaBd3BGsLeKLiifEIdaClGgAzouLFbouncBuO3XU/jT
	kyDyqditRRqrFuuNY2+Pw4LYCLsszQY=
Date: Tue, 4 Aug 2026 15:13:25 -0700
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
 <4fefc832-b9b8-48d4-b472-82d6dea48354@linux.dev>
 <18a824b20c21a186687948133dc436f2852ce5f2.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <18a824b20c21a186687948133dc436f2852ce5f2.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 8/4/26 3:05 PM, Eduard Zingerman wrote:
> On Tue, 2026-08-04 at 14:55 -0700, Ihor Solodrai wrote:
>> On 8/4/26 2:34 PM, Eduard Zingerman wrote:
>>> On Tue, 2026-08-04 at 14:19 -0700, Ihor Solodrai wrote:
>>>> On 8/4/26 1:22 PM, Eduard Zingerman wrote:
>>>>> On Tue, 2026-08-04 at 21:27 +0200, Kumar Kartikeya Dwivedi wrote:
>>>>>> On Tue Aug 4, 2026 at 8:43 PM CEST, Ihor Solodrai wrote:
>>>>>>> On 8/3/26 5:55 AM, Kumar Kartikeya Dwivedi wrote:
>>>>>>>> [...]
>>>>>>
>>>>
>>>> What am I missing?
>>>
>>> At the moment we have two consumers:
>>> - Planned sched_ext related kfuncs that need kernel space pointers.
>>> - Existing kfuncs with KF_ARENA_ARG:
>>>   - bpf_arena_alloc_pages
>>>   - bpf_arena_free_pages
>>>   - bpf_arena_reserve_pages
>>>   They, take a user space address. Looking at the code is appears that
>>>   all three can be changed to handle kernel space address.
>>>   On the other hand, neither of these *needs* the passed pointer to be
>>>   converted to a kernel side arena pointer. So that would be just some
>>>   useless work.
>>>
>>> So there are two valid use cases.
>>
>> I think having more than one way of how to pass an arena pointer to
>> the kernel will create more confusion than bring value.
> 
> That might be the case.
> 
>> It seems to me the existing bpf_arena_* kfuncs accept user space
>> address for historical reasons (we just tried something that worked),
>> not by design exactly.
> 
> What makes you think so?

The fact that sched_ext needs to use a different way, which is why
this thread exists.  But you may be right that these are just two
different use-cases, and each does what makes sense for it.

> 
>> btw, Eduard, I get very confused by how you say "user space".. you
>> mean the 32bit value representing the BPF arena pointer, right?
> 
> Nope:
> 
>   static long compute_pgoff(struct bpf_arena *arena, long uaddr)
>   {
> 	return (u32)(uaddr - (u32)arena->user_vm_start) >> PAGE_SHIFT;
>   }
> 
>   static int arena_reserve_pages(struct bpf_arena *arena, long uaddr, u32 page_cnt)
>   {
> 	...
> 	if (uaddr & ~PAGE_MASK)
> 		return 0;
> 
> 	pgoff = compute_pgoff(arena, uaddr);
> 	if (pgoff + page_cnt > page_cnt_max)
> 		return -EINVAL;
> 	...
>    }
> 
>   __bpf_kfunc int bpf_arena_reserve_pages(void *p__map, void *ptr__ign, u32 page_cnt)
>   {
> 	...
> 	return arena_reserve_pages(arena, (long)ptr__ign, page_cnt);
>   }
> 
> ptr__ign/uaddr is a 64-bit user space address.

I see, thanks for the explanation.

> 
>>
>> Anyways, I think we should converge on the approach to arena pointers
>> handling before landing anything.
>>
>> Let's use __arena suffix as annotation mechanism, fine. But
>> I really wouldn't like to end up with N annotations for each
>> permutation of (non-)nullable and kern/user...
>>
>> I'll submit the resolve_btfids patches asap to not block on that.
>>
>>
>>>
>>> ...

