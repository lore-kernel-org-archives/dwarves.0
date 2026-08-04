Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8576235675A
	for <dwarves@vger.kernel.org>; Tue,  4 Aug 2026 23:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785885454; cv=none; b=qyGNvrXYelSBUz5FZr4Qr/Be7JOA8K/A79B5RxlKm0vqSGIqVEr+HdlkVoHUUkRXmkWbkFA8TcD7rWI8OeMD7CdpK57W+u4/GrKXCNVRvEyodX1qur7cBV0zD4tV1R+mKAZJGeOrIHQapI7DNmJNyGulQQ8FAB04nMM7fxeM0xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785885454; c=relaxed/simple;
	bh=BDETBFOwIwsh+byhbzblZyCYRy+jFPPsjNH0XT4A/NI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=a5+SehMa0ywVAafSEqNOZ1L0kDCkTeOvB9VG97VIg0P0DDp8uYKR+LJby6B0I7ekDOobLiI16+3oFrUT5magkQfjkDwvpgWm3lrdlEuK9qCGZ94DGnVgOFKfInIA7KJLMnV1W5IOWTAdtS99aCjNdqsMB6bptSuCW0SgfTXUa0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKrNiXNA; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKrNiXNA"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49553da76dcso991255e9.1
        for <dwarves@vger.kernel.org>; Tue, 04 Aug 2026 16:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785885451; x=1786490251; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BDETBFOwIwsh+byhbzblZyCYRy+jFPPsjNH0XT4A/NI=;
        b=TKrNiXNAJH975eZTaTA3iNvrY2MijfL08mYMXChemlQAbvcZXAg+s412L6cL2b3353
         vjxSx4gLagFC69i6oT9+YX3bse8EqmJTDHKH1WENfzVFjK/z/+3sS91UQkvY4aik/kIJ
         FQazGLQOXCVA56R1cl0DWHnACzdAS5ksgHDhFYpYixjj8ysvPmcsfANDiNKEu9Wz8EV6
         Ybq5Migw5gBB7MNv52Ub7q1ux+Lqe5NGMKenKCJ1T5tHEDQR+pKETYraSIJ25LSQJuC9
         7NcYD7Xe/bc4k3V4+71ldPq/7hpNTszeu/Sa5GE0c8euP2zMme0TgqhPsCVEoSKAwfgS
         qA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785885451; x=1786490251;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BDETBFOwIwsh+byhbzblZyCYRy+jFPPsjNH0XT4A/NI=;
        b=lX9OHqd5SH/Jj3tIDHbnvZ7E+VyxbwVlkzezbdTFM5pQ8yy63DbpOcbiun3w7PH3dD
         XCuB0nvjrU6rGCjhk/AGv7JG45fk9Pzdn9FhKOfrOjGLxDNZmqUA8fxRf+7WngL64zQK
         nK04kPneZEaLHcWwRbiVTI/Uu2cznYOW0MtIqmUK2GDb/hniuI+C11wzvbu6mQ9pydBk
         2M+yVoGSdWPitz1G3ZdjD0shdKdqTMlXgK4WlkCeYohKCIUVQoQWVst6Lq1onGExpX3I
         RtPqT7m3RbhuFQUJAIROXT5SUa1PX+/BvkMRey3j4ymsGU07dC8G2Z6A/KSL7ZY/NkFd
         35Ag==
X-Forwarded-Encrypted: i=1; AHgh+RohFnjVs1M2+5KqAqTHkVxf3bAzJkdDJwx9hkAnpw05CeTh4kt5BbCSIM3X0fgxUrwsjHWvtNUA@vger.kernel.org
X-Gm-Message-State: AOJu0YziWWAnrW9Tjx5fzXXTuApV+DGVWZEv1q/UBayTNXmuNXmE/4M+
	C0IKRv1186uhFYTzMBUd6x7IIs4d2H5oAVLY+1UmC8aHYOza+0Gu2xly
X-Gm-Gg: AR+sD10bRG20i8CWRiKOR+tuPRc9GmWi+ImNpdFm/oiACsTxZD0RdCGawHF9XgboUH1
	srw3cr53IG7CxX18sq5hXUIOkxJj7ziwL1HG1YkdBh/tAqSVGPfHY6TriN7g7TnWrhwsbQhcRnT
	i+xRe8ohrXUoGIEAzXrDm4Ry6mzsxrZicBFaYhsv2PYPKzbeYMdTY70FLztDzqj3cJRXNA+fGMz
	oqPoV23ec+r+DC9GrbgE2zZchRtsRkPjo9BcBQ5ru1ahn0+GERlnOnzbY/mRniMgPT8H16awDEG
	YgjnTidziDq7wgAgAuOkywlM5I+uT4Ngn2mRcQ1fk5AlK3Qoe3PABTcmC5EVYNjqFobeHZtYmkd
	o33gTYvAVKtiOtJNfYQVB0ANlemXUAfaifcVDOkUqD7nlG1eGwlxgDtHzpmTnjuI4KazywUp0rt
	OGRXqUGF/JwVHfh2lZqxVrhk7bnK92TjChQJX8msxbcmBB4ZDeqrd+oqhVfeMjAFNIGJmP8Y3F8
	xdy7dYKS/3BTIAJ5qCuKYfZJ2MAbmi6jjLPpAm/2R8LJdDrO7ay+xG8iGaEvPTRIKuEs/NsJvfP
	qHMQ4RAWXauLC7qLUbFCLcfxxts70/Dy2QRPvA==
X-Received: by 2002:a05:600c:5791:b0:498:11b5:3ff7 with SMTP id 5b1f17b1804b1-4994e7d8a85mr15226145e9.18.1785885450678;
        Tue, 04 Aug 2026 16:17:30 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e5192c5sm22320335e9.1.2026.08.04.16.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 16:17:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Aug 2026 01:17:29 +0200
Message-Id: <DKGJK1DE7NME.2666KVAI27JXJ@gmail.com>
Cc: <bpf@vger.kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, "Tejun Heo" <tj@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>
Subject: Re: [PATCH dwarves] btf_encoder: Infer arena kfunc arguments from
 suffixes
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Alan Maguire" <alan.maguire@oracle.com>, "Arnaldo
 Carvalho de Melo" <acme@kernel.org>, <dwarves@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260803125518.2279340-1-memxor@gmail.com>
 <4cb8bb30-1f01-4b78-a6b1-4ade3b965039@linux.dev>
 <DKGENYO9FITK.1M51V4BULBSYT@gmail.com>
 <8dc173dc3d051d338916c72cae070238718fd196.camel@gmail.com>
 <6c9500d4-7401-44f0-93a6-88a827026ae0@linux.dev>
 <4d20aecf677f4aec3e8e70106d4bdbcb01902e69.camel@gmail.com>
 <DKGHMNV38DFI.1RZJ281XECD14@gmail.com>
 <56590122d4901653aa2827088b9a83447ee745e0.camel@gmail.com>
 <7c5a6e06-87e3-4025-8243-b8d08d785ce6@linux.dev>
In-Reply-To: <7c5a6e06-87e3-4025-8243-b8d08d785ce6@linux.dev>

On Wed Aug 5, 2026 at 12:57 AM CEST, Ihor Solodrai wrote:
> On 8/4/26 2:51 PM, Eduard Zingerman wrote:
>> On Tue, 2026-08-04 at 23:46 +0200, Kumar Kartikeya Dwivedi wrote:
>>> On Tue Aug 4, 2026 at 11:34 PM CEST, Eduard Zingerman wrote:
>>>> On Tue, 2026-08-04 at 14:19 -0700, Ihor Solodrai wrote:
>>>>> On 8/4/26 1:22 PM, Eduard Zingerman wrote:
>>>>> [...]
>>>>> What am I missing?
>>>>
>>>> At the moment we have two consumers:
>>>> - Planned sched_ext related kfuncs that need kernel space pointers.
>>>> - Existing kfuncs with KF_ARENA_ARG:
>>>> =C2=A0 - bpf_arena_alloc_pages
>>>> =C2=A0 - bpf_arena_free_pages
>>>> =C2=A0 - bpf_arena_reserve_pages
>>>> =C2=A0 They, take a user space address. Looking at the code is appears=
 that
>>>> =C2=A0 all three can be changed to handle kernel space address.
>>>> =C2=A0 On the other hand, neither of these *needs* the passed pointer =
to be
>>>> =C2=A0 converted to a kernel side arena pointer. So that would be just=
 some
>>>> =C2=A0 useless work.
>>>
>>> I don't think it's useless work, they translate manually because the ac=
tual page
>>> table operations happen using the kernel address anyway. IMO they proba=
bly need
>>> access to both, and having one gives other, but kaddr is more important=
 for them
>>> to actually carry out the page table manipulation.
>>
>> From what I see these function compute the page number by subtracting
>> user vm start from the pointer. So, if switched to a kernel pointer
>> that would uaddr -> kaddr -> (kaddr - start) / page_size.
>> Compared to current (uaddr - ustart) / page_size.
>> But we can live with that.
>>
>> What's an overall conclusion? A single __arena suffix and modified
>> existing consumers? What would be the semantics for __nullable?
>
> Apparently, we also have btf_decl_tag("arg:arena") and a type tag.
>
> So that's three different arena annotations already:
> - decl tag for PTR_TO_ARENA for global funcs [1]
> - type tags for BPF declarations [2]

I think both serve different purposes. It makes sense for it to be type tag=
,
e.g. for it to be able to go into typedefs, etc. All suffixes we have on ke=
rnel
side will probably otherwise be declaration tags excluding other similar ca=
ses
to arena (like __rcu).

> - KF_ARENA_* flags to pass through the address_space(1)
>
> and now we are adding __arena suffix for auto-rebasing

This would be a type tag if we could do it that way, unfortunately since it=
 gets
applied on the kernel side, we have to use a suffix. __arena tag used in pr=
ogram
BTF for kfunc or struct_ops is not authoritative, it needs to come from the
kernel.

>
> It's a mess, gentlemen.
>
> Since the verifier already recognizes the type tags, shouldn't we
> be using them?..
>
> [1] https://lore.kernel.org/bpf/20240209040608.98927-11-alexei.starovoito=
v@gmail.com/
> [2] https://lore.kernel.org/bpf/20260602004120.17087-1-emil@etsalapatis.c=
om/

