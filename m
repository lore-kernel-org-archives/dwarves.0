Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEB62116F9
	for <dwarves@vger.kernel.org>; Wed, 19 Feb 2025 18:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739988188; cv=none; b=FeAHwApZ+ShJfaxF3UnoH5Tn+o1j45Vyw2KCH2Vy4d6yB5Nr43bek7tUJMawRrkE7f0++WaVBcaYsNBwYjK3bL9EKp6ro4yW0vJl3zQFURZQ9A3pIUuxcPZyLcwnKUMsgvDk8IZcpJGzFW76ZgJHYF8UbRbCN/2f691nIxmgE30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739988188; c=relaxed/simple;
	bh=xAclfaeUyhpDx3nrIPKGTVcNFvUJht6e7NL+FkN71CY=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=FMIeNEVMgYOEnCOqxJyBpK+rFZUnPQ0Q57PeQlhwr29ksWh0Wi90wXx95NQXmhWQO1uXJHIWaKZo5mVVwm7A0JXm+YnuGWUveIY3GV5ul1FLGXVqZJROlARzKUThOsuwpg41q43YjkV3N4kRHNVh9qDKAUn+Xoh7QueCBW4X4Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T+le5hsb; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T+le5hsb"
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739988182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P9P36S9nIyxnWpqmgfC5N+Lk6itq2kDM7Sl63r4jGrg=;
	b=T+le5hsbbVHUEY9E0EK6UYe4dcLkqO/n7N1Gea4cMfDqdiniH/RGeT4Y5RTHFtOUS/g0ZT
	6RtnIabCOjy1EL4RbOcprRiNmfHgjne6s8bbChAcVD/bQTf5eUStz4wtNnoKuz8RugQ8mI
	N7P86WheZEhZx0rXmUU9iuTUK6g/10k=
Date: Wed, 19 Feb 2025 18:03:01 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <4189ba95819b60fea70eb1771c6c50d0a409d53d@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v2 dwarves 2/4] btf_encoder: emit type tags for bpf_arena
 pointers
To: "Eduard Zingerman" <eddyz87@gmail.com>, dwarves@vger.kernel.org,
 bpf@vger.kernel.org
Cc: acme@kernel.org, alan.maguire@oracle.com, ast@kernel.org,
 andrii@kernel.org, mykolal@fb.com, kernel-team@meta.com
In-Reply-To: <a1ab7ec2ca121105065e84ad0b7b0f58cf1f6fe3.camel@gmail.com>
References: <20250212201552.1431219-1-ihor.solodrai@linux.dev>
 <20250212201552.1431219-3-ihor.solodrai@linux.dev>
 <8d222fd0f26fdce0193047074e660abab19ffc32.camel@gmail.com>
 <a1ab7ec2ca121105065e84ad0b7b0f58cf1f6fe3.camel@gmail.com>
X-Migadu-Flow: FLOW_OUT

On 2/18/25 9:45 PM, Eduard Zingerman wrote:
> On Tue, 2025-02-18 at 20:36 -0800, Eduard Zingerman wrote:
>> On Wed, 2025-02-12 at 12:15 -0800, Ihor Solodrai wrote:
>>
>> [...]
>>
>>> diff --git a/btf_encoder.c b/btf_encoder.c
>>> index 965e8f0..3cec106 100644
>>> --- a/btf_encoder.c
>>> +++ b/btf_encoder.c
>>
>> [...]
>>
>>> +static int btf__tag_bpf_arena_ptr(struct btf *btf, int ptr_id)
>>> +{
>>> +	const struct btf_type *ptr;
>>> +	int tagged_type_id;
>>> +
>>> +	ptr =3D btf__type_by_id(btf, ptr_id);
>>> +	if (!btf_is_ptr(ptr))
>>> +		return -EINVAL;
>>> +
>>> +	tagged_type_id =3D btf__add_type_attr(btf, BPF_ARENA_ATTR, ptr->typ=
e);
>>> +	if (tagged_type_id < 0)
>>> +		return tagged_type_id;
>>> +
>>> +	return btf__add_ptr(btf, tagged_type_id);
>>> +}
>>
>> I might be confused, but this is a bit strange.
>> The type constructed here is: ptr -> type_tag -> t.
>> However, address_space is an attribute of a pointer, not a pointed typ=
e.
>> I think that correct sequence should be: type_tag -> ptr -> t.
>> This would make libbpf emit C declaration as follows:
>>
>>   void * __attribute__((address_space(1))) ptr;
>>
>> Instead of current:
>>
>>   void __attribute__((address_space(1))) * ptr;

I was also confused about this.

The goal I had in mind is reproducing bpf_arena_* function
declarations, which are:

    void __arena* bpf_arena_alloc_pages(void *map, void __arena *addr, __=
u32 page_cnt,
    				    int node_id, __u64 flags) __ksym __weak;
    void bpf_arena_free_pages(void *map, void __arena *ptr, __u32 page_cn=
t) __ksym __weak;

AFAIU this is by design. From BTF documentation[1]:

    Currently, BTF_KIND_TYPE_TAG is only emitted for pointer types. It ha=
s
    the following btf type chain:

    ptr -> [type_tag]*
        -> [const | volatile | restrict | typedef]*
        -> base_type

    Basically, a pointer type points to zero or more type_tag, then zero
    or more const/volatile/restrict/typedef and finally the base type. Th=
e
    base type is one of int, ptr, array, struct, union, enum, func_proto
    and float types.

So yeah, unintuitively a tagged pointer in BTF is actually a pointer
to a tagged type. My guess is, it is so because of how C compilers
interpret type attributes, as evident by an example you've tested.

[1] https://docs.kernel.org/bpf/btf.html#btf-kind-type-tag

>>
>> clang generates identical IR for both declarations:
>>
>>   @ptr =3D dso_local global ptr addrspace(1) null, align 8
>>
>> Thus, imo, this function should be simplified as below:
>>
>>   static int btf__tag_bpf_arena_ptr(struct btf *btf, int ptr_id)
>>   {
>> 	const struct btf_type *ptr;
>>
>> 	ptr =3D btf__type_by_id(btf, ptr_id);
>> 	if (!btf_is_ptr(ptr))
>> 		return -EINVAL;
>>
>> 	return btf__add_type_attr(btf, BPF_ARENA_ATTR, ptr_id);
>>   }
>>
>> [...]
>>
>
> Ok, this comment can be ignored.
> The following C code:
>
> int foo(void * __attribute__((address_space(1))) ptr) {
>   return ptr !=3D 0;
> }
>
> does not compile, with the following error reported:
>
> test3.c:1:49: error: parameter may not be qualified with an address spa=
ce
>     1 | int foo(void *__attribute__((address_space(1))) ptr) {
>       |
>
> While the following works:
>
> int foo(void __attribute__((address_space(1))) *ptr) {
>   return ptr !=3D 0;
> }
>
> With the following IR generated:
>
> define dso_local i32 @foo(ptr addrspace(1) noundef %0) #0 { ... }
>
> Strange.
>
