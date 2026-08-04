Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE88D1AAE17
	for <dwarves@vger.kernel.org>; Tue,  4 Aug 2026 22:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785884274; cv=none; b=CsV2kB/aXC2kChHogFU/RGz5yjw0GXb5JSahWvQGbe/MLL+8E3JooxhnoxBOVAkwN2j/XAo/0yRim7NEtHlJ9+xJsKCLhwQ/vZYGAYiZhUgWNuG13H/xgnZlltk4Naq2nG2vHGycqvQIubs46+YLDm98rlKHtAH5Xr2eB/t3WvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785884274; c=relaxed/simple;
	bh=Nt9L6HzleHAgmdpZdE3mGaBZ1PSV9W/9OEYajfhDhP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q2t16liLQzrFiJZ/81wMmqWv/klfrpRzMf+YneaMQtnnWqbAPLlYrLGSCEMv5jHasy9agaMnYSpwHJeT/Emlb0NIdlQyT90CHbIpy93NvHhtKcAhoRa9W+K4pLmUt9SG/ITWk9KfwH1aPSR0WA9aAo86/h2kgthEVfMK3zb5BNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lHRmWX5f; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lHRmWX5f"
Message-ID: <7c5a6e06-87e3-4025-8243-b8d08d785ce6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785884269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ny+bH7BgHwa4opCHgWajXNY0dMtmwMlJMkIQrZAm/o=;
	b=lHRmWX5fbsc17tZ0PqAfbNgsVwljM5oCNRkM4q40HZGJ3I7+qMT/nkza8o6EzJPygWtlIe
	3EuNvsWTQ3nwdG0In/+Qt+YT7ppvHev1736Qkgb3NsxVoMPJfGO9VQU2j/qpmBjbsy4DoM
	S1ld+/IPJ97B9Kk4ozwE+XGFEMub4YI=
Date: Tue, 4 Aug 2026 15:57:28 -0700
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
 <DKGHMNV38DFI.1RZJ281XECD14@gmail.com>
 <56590122d4901653aa2827088b9a83447ee745e0.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <56590122d4901653aa2827088b9a83447ee745e0.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 8/4/26 2:51 PM, Eduard Zingerman wrote:
> On Tue, 2026-08-04 at 23:46 +0200, Kumar Kartikeya Dwivedi wrote:
>> On Tue Aug 4, 2026 at 11:34 PM CEST, Eduard Zingerman wrote:
>>> On Tue, 2026-08-04 at 14:19 -0700, Ihor Solodrai wrote:
>>>> On 8/4/26 1:22 PM, Eduard Zingerman wrote:
>>>> [...]
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
>>
>> I don't think it's useless work, they translate manually because the actual page
>> table operations happen using the kernel address anyway. IMO they probably need
>> access to both, and having one gives other, but kaddr is more important for them
>> to actually carry out the page table manipulation.
> 
> From what I see these function compute the page number by subtracting
> user vm start from the pointer. So, if switched to a kernel pointer
> that would uaddr -> kaddr -> (kaddr - start) / page_size.
> Compared to current (uaddr - ustart) / page_size.
> But we can live with that.
> 
> What's an overall conclusion? A single __arena suffix and modified
> existing consumers? What would be the semantics for __nullable?

Apparently, we also have btf_decl_tag("arg:arena") and a type tag.

So that's three different arena annotations already:
- decl tag for PTR_TO_ARENA for global funcs [1]
- type tags for BPF declarations [2]
- KF_ARENA_* flags to pass through the address_space(1)

and now we are adding __arena suffix for auto-rebasing

It's a mess, gentlemen.

Since the verifier already recognizes the type tags, shouldn't we
be using them?..

[1] https://lore.kernel.org/bpf/20240209040608.98927-11-alexei.starovoitov@gmail.com/
[2] https://lore.kernel.org/bpf/20260602004120.17087-1-emil@etsalapatis.com/


