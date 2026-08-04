Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5776A305691
	for <dwarves@vger.kernel.org>; Tue,  4 Aug 2026 21:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785878380; cv=none; b=GOAECtpVkZR/rvlVCEt5L+DhET0xlPHM9aLZXmUHlfDE4phTHwX28ApmuINRbRw5msgzr2uZZQD9JX4susW0H/wKWe/VzqXfUZjvCIKu+1fYnAuTaSGeMUPFHSykdR6eJzX3PYqO3niRI9dOAKXlporrYWiw0iZx5adYd5UXSOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785878380; c=relaxed/simple;
	bh=AkgyGrX3XEqgQGFPpmTNH3hOyuYKh1UX/MQKCu3sQzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K3WaNai1X0q6/F+TBR7lCL0pIbPImFODvLWSEb7t0Hd1dRzT1qwtWXUO9oaYKBjLe8DsMazyRcQ3pDSQZDx5AFDacCCkYKtcqBGZM+CHh4+W9l+JWYYMlQGKIq7crOZbcdjP9oXnQWoedtBxudOxwrmrB8TGFkzdFnBhuInh6cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hkp64Rm8; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hkp64Rm8"
Message-ID: <6c9500d4-7401-44f0-93a6-88a827026ae0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785878376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vz5KvMKHl+IVx7jZXATmIkaoAJEIKPeHkqmEstCHKt4=;
	b=Hkp64Rm8ms+6MSOx2XwkNqecZh/UCYquFzp0nVdGjhriNJnJaN49sVdri91A6NgKJwvZJy
	rJ6ulEBveblhyXgZhTvFDpcZ96qHl+aTp/sJ/XhNGFJneGGEwN1Fc0oFuVI7SoqYoMZlB6
	RKaSY5mTH049u4CGQlinQR9M2e+4iS8=
Date: Tue, 4 Aug 2026 14:19:05 -0700
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <8dc173dc3d051d338916c72cae070238718fd196.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/4/26 1:22 PM, Eduard Zingerman wrote:
> On Tue, 2026-08-04 at 21:27 +0200, Kumar Kartikeya Dwivedi wrote:
>> On Tue Aug 4, 2026 at 8:43 PM CEST, Ihor Solodrai wrote:
>>> On 8/3/26 5:55 AM, Kumar Kartikeya Dwivedi wrote:
>>>> [...]
>>
>>>
>>> So while I understand the reluctance to add KF_ARENA_ARG3..N, I don't
>>> think we want to introduce and support yet another mechanism for arena
>>> argument annotations. If we do, we'll be stuck with a mess of
>>> supporting two/three ways of doing the same thing for the foreseeable future.
>>
>> I think one major difference is that KF_ARENA_ARG* things were mostly for
>> annotating the vmlinux.h with the right address space label before, but didn't
>> carry any semantic meaning for the kfunc's type checks.
>>
>> That changes with these suffixes though. The pointer will be translated when
>> passed into the kfunc. IMO it would be odd to diverge for this particular case,
>> since we use suffixes for every other case where we constrain the input type of
>> the kfunc argument or give it special meaning.
>>
>> We also want to have similar annotation on struct_ops callbacks, where we also
>> use suffixes, so it seemed better to keep it consistent.
> 
> I agree that we should follow the principle of least surprise here and
> use suffixes, as everything else uses suffixes as well.

Ok, I understand the motivation. Let's say we use the suffixes.

Should this enable getting rid of KF_ARENA* flags then? For the
purposes of generating address_space(1), we can also just check the
name suffix, no?

> 
> And yes, the __arena and KF_ARENA_ARG* annotations have different
> semantics:
> - __arena means that user space arena address is passed as is
> - KF_ARENA_ARG* means that a user space address is converted
>   to a kernel space address before passing.

Also I am a little confused about whether we *need* to be able to
express two distinct meanings of "arena pointer" or not?

My understanding is that "arena pointer" is a feature of an arg type
that has a single meaning: the pointer has one base in BPF world, and
a different base when executed in the kernel.

The things that are missing is auto-conversion (Tejun's RFC [1]) and more
comprehensive support of PTR_TO_ARENA in the verifier.

This is still only one "arena" annotation per arg. Do we actually need
the proliferation of __arena, __arena__nullable and/or __arena_kern,
__arena_user? Can't we have a single defined semantics of how arena
pointers are supposed to work?

I can imagine something like follows:
  * arena pointers can not be null, check for nulls
    before passing from BPF prog to the kernel
  * arena pointers are converted to the kernel space for
    kfunc/struct_ops callback by the verifier

With the documented and enforced semantics like this one way of
annotating and one annotation should be enough.

What am I missing?

[1] https://lore.kernel.org/bpf/20260713024414.3759854-1-tj@kernel.org/

> 
> It appears, though, that from the BPF program side having an address
> space annotation on the kfunc parameter would be helpful, as it avoids
> an additional cast.
> > Tbh, it sounds like we want __arena_user and __arena_kern suffixes.
> 
>> I agree that all of these should be using type tags, but we're not there yet.
> 
> Let's put aside the type tags discussion for the time being.
> 
> ...

