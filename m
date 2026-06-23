Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9402C32B13D
	for <dwarves@vger.kernel.org>; Tue, 23 Jun 2026 16:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782233909; cv=none; b=RC3REvIE/2vjkuj4lf+snSZo45uEz/vERQy/iU38mvYEGDPtlEF4pYIS/uWDvoHTiJFIg0EKsQIODxt54G1P+BeJC2AYfJYESY5+cWmjNVvUpj5r94jaFOalNcqCP8VBwyC2K4sEC2XFo15YCreF/DtdXCyPjZ9x7Tm2FCsokBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782233909; c=relaxed/simple;
	bh=zbihmV5fN6T4FGaMdZgH9ffanOLhmr6LKZsXgivivqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=izS/8Yu6b/0Lx2p2K4/YL3NL+8ADfuBT6KaWlxlv5bVLje1SvpczSquxBs3nLwjxQb2r6hZJv1Hy8x7zM62QbSrFzgIcvB1Y2+4H6RvHpwd+vq6FdZpK7/s34esHIMYwN8XRCYTqobggxybjXb65UiGtL2Hihutj/4/sC3La58M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eN0lJ5L5; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eN0lJ5L5"
Message-ID: <16c3840e-80e1-44ba-9415-fa4ec9ca5785@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782233895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1mVuApoJqVlXdBFnkM86bPf6Noqutb0vDxs2yW0qefI=;
	b=eN0lJ5L5goL+49Ur6QrX3h5aJ3OZ1JWVqzvONcXBVWnCe2so5JrlJqReu8dWX34E8t5pdy
	ILfizv0nITXScXcLYg8dCnwaOXdp63+0TPNHo+sljtI5KmDqn6HH2AKBjWaewKiVTgY/4a
	1jivx4sv8bwwEwir3/GFVEqJrYyN7ic=
Date: Tue, 23 Jun 2026 09:58:09 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves v7 0/5] pahole: Encode true signatures in kernel
 BTF
Content-Language: en-GB
To: Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <olsajiri@gmail.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
 dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, kernel-team@fb.com
References: <20260623040704.2732530-1-yonghong.song@linux.dev>
 <ajp70MRjHvCJNeyv@krava> <d270a215-264f-4c5c-9d7f-0b1568815e31@oracle.com>
 <b1b73cef-f25a-443d-8557-4cfe92938b46@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <b1b73cef-f25a-443d-8557-4cfe92938b46@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/23/26 9:02 AM, Alan Maguire wrote:
> On 23/06/2026 14:11, Alan Maguire wrote:
>> On 23/06/2026 13:28, Jiri Olsa wrote:
>>> On Mon, Jun 22, 2026 at 09:07:04PM -0700, Yonghong Song wrote:
>>>> Current vmlinux BTF encoding is based on the source level signatures.
>>>> But the compiler may do some optimization and changed the signature.
>>>> If the user tried with source level signature, their initial implementation
>>>> may have wrong results and then the user need to check what is the
>>>> problem and work around it, e.g. through kprobe since kprobe does not
>>>> need vmlinux BTF.
>>>>
>>>> Majority of changed signatures are due to dead argument elimination.
>>>> The following is a more complex one. The original source signature:
>>>>    typedef struct {
>>>>          union {
>>>>                  void            *kernel;
>>>>                  void __user     *user;
>>>>          };
>>>>          bool            is_kernel : 1;
>>>>    } sockptr_t;
>>>>    typedef sockptr_t bpfptr_t;
>>>>    static int map_create(union bpf_attr *attr, bpfptr_t uattr) { ... }
>>>> After compiler optimization, the signature becomes:
>>>>    static int map_create(union bpf_attr *attr, bool uattr__is_kernel) { ... }
>>>> In the above, uattr__is_kernel corresponds to 'is_kernel' field in sockptr_t.
>>>> This makes it easier for developers to understand what changed.
>>>>
>>>> The new signature needs to properly follow ABI specification based on
>>>> locations. Otherwise, that signature should be discarded. For example,
>>>>
>>>>      0x0242f1f7:   DW_TAG_subprogram
>>>>                      DW_AT_name      ("memblock_find_in_range")
>>>>                      DW_AT_calling_convention        (DW_CC_nocall)
>>>>                      DW_AT_type      (0x0242decc "phys_addr_t")
>>>>                      ...
>>>>      0x0242f22e:     DW_TAG_formal_parameter
>>>>                        DW_AT_location        (indexed (0x14a) loclist = 0x005595bc:
>>>>                           [0xffffffff87a000f9, 0xffffffff87a00178): DW_OP_reg5 RDI
>>>>                           [0xffffffff87a00178, 0xffffffff87a001be): DW_OP_reg14 R14
>>>>                           [0xffffffff87a001be, 0xffffffff87a001c7): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
>>>>                           [0xffffffff87a001c7, 0xffffffff87a00214): DW_OP_reg14 R14)
>>>>                        DW_AT_name    ("start")
>>>>                        DW_AT_type    (0x0242decc "phys_addr_t")
>>>>                        ...
>>>>      0x0242f239:     DW_TAG_formal_parameter
>>>>                        DW_AT_location        (indexed (0x14b) loclist = 0x005595e6:
>>>>                           [0xffffffff87a000f9, 0xffffffff87a00175): DW_OP_reg4 RSI
>>>>                           [0xffffffff87a00175, 0xffffffff87a001b8): DW_OP_reg3 RBX
>>>>                           [0xffffffff87a001b8, 0xffffffff87a001c7): DW_OP_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value
>>>>                           [0xffffffff87a001c7, 0xffffffff87a00214): DW_OP_reg3 RBX)
>>>>                        DW_AT_name    ("end")
>>>>                        DW_AT_type    (0x0242decc "phys_addr_t")
>>>>                        ...
>>>>      0x0242f245:     DW_TAG_formal_parameter
>>>>                        DW_AT_location        (indexed (0x14c) loclist = 0x00559610:
>>>>                           [0xffffffff87a001e3, 0xffffffff87a001ef): DW_OP_breg4 RSI+0)
>>>>                        DW_AT_name    ("size")
>>>>                        DW_AT_type    (0x0242decc "phys_addr_t")
>>>>                        ...
>>>>      0x0242f250:     DW_TAG_formal_parameter
>>>>                        DW_AT_const_value     (4096)
>>>>                        DW_AT_name    ("align")
>>>>                        DW_AT_type    (0x0242decc "phys_addr_t")
>>>>                        ...
>>>>
>>>> The third argument should correspond to RDX for x86_64. But the location suggests that
>>>> the parameter value is stored in the address with 'RSI + 0'. It is not clear whether
>>>> the parameter value is stored in RDX or not. So we have to discard this funciton in
>>>> vmlinux BTF to avoid incorrect true signatures.
>>>>
>>>> For llvm, any function having
>>>>    DW_AT_calling_convention        (DW_CC_nocall)
>>>> in dwarf DW_TAG_subprogram will indicate that this function has signature changed.
>>>> I did experiment with latest bpf-next. For x86_64, there are 69103 kernel functions
>>>> and 875 kernel functions having signature changed. A series of patches are intended
>>>> to ensure true signatures are properly represented. Eventually, only 20 functions
>>>> cannot have true signatures due to locations.
>>> hi,
>>> I tried to get the numbers from my setup and noticed that some new
>>> functions were included in BTF compared to the current version
>>> (functions diff attached below)
>>>
>>> like for "arp_process" function the current pahole gives me:
>>>
>>>    arp_process : skipping BTF encoding of function due to unexpected register usage for parameter
>>>
>>> but it's included in BTF generated with the new pahole.
>>>
>>> in addition to your explanation above also one of the commit says:
>>>
>>>       - a parameter with no location, a constant value, or (for non-clang) no
>>>         register found is marked optimized out
>>>
>>> please check below, it seems like 2nd argument of arp_process has no location,
>>> so iiuc it should not be included in BTF, right?
>>>
>>> thanks,
>>> jirka
>>>
>>>
>> thanks for catching this; it looks like we return a bit early before detecting
>> missing locations in the non-true-signature code. If you get a chance, would you
>> mind trying the attached patch to see if it fixes the problem?
>>
>> If the fix works and Yonghong is happy with it we can add it as a followup
>> and land the true signature series to save another round.
> actually sorry that patch leaked true signature partial names for gcc; updated
> patch attached.

The whole clang signature_changed thing can be removed.

I want to see whether cu->producer_clang can be removed in

                 } else if (pos->has_const_value && !cu->producer_clang) {
                         pos->optimized = 1;
                 } else if (true_sig_enabled) {
                         if (regs_available &&
                             ftype__next_parameter_preserves_slots(ftype, pos, reg_idx, slots, cu)) {
                                 reg_idx += slots;
                                 continue;
                         }
                         
                         pos->optimized = 1;
                         consumes_register = false;
                 }


For clang, we cannot just do pos->optimized = 1 just due to pos->has_const_value though.


