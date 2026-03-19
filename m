Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8254D3D3009;
	Thu, 19 Mar 2026 16:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773937399; cv=none; b=ow+aF75MyCxy6LulYjpzbRPQOJ+gXlNqDcTBKqgRlEqi/kIvgjzCKJ9x5rtSIZaQm5/v47VPqYKjE5KmjwPb88Xi2KiX6GSqhJXkAk00aKxS8GfkaYAjWgMtFtny+SasXTcF7OIcGS7DbV4BqR8w53pisVzQrKXNPxMGgdzgb7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773937399; c=relaxed/simple;
	bh=70bUYwbaaJ9p6utY8MdZKgKx7ImSoxmOzTovx8XajVY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=F6otgrUl4nDU+rRfL4Hi5Oe2DjotBJ/LSAiG3+maTRwBHiS+RJYjxxpZQvMEj2ZPX5Zn9B2ce/jkDEMkl63a5sOGQCovgrC4jMslIv95WIeVBC/RJgB45Tj6xvIPNQZDjrw+kTQ9bqsDrxFbtl5bwgCpCbeka+8YT/bSf0OaorA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cmmrMF2n; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cmmrMF2n"
Message-ID: <c7abb3d6-d1d0-4970-88c8-4b6afa2dc399@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773937395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nn/s8BUc2tFo9k2gjZqMpf6WdJVGJ+Vpz/+b+ulpCpE=;
	b=cmmrMF2nu8UYjnHxKrJlBMgIlundraRFQH52WTguulc050voelTYTbj/8tT0Dy71RUDSz8
	mqKOoHrBMBx6qToeYJHWgqREo0q4W8papHCJN9g7EAFZaoYRhhS4rkSow+Hf6xBrq2aAIn
	dLJ92+DdF6uiMT2zHQX88O1y4DTn1QA=
Date: Thu, 19 Mar 2026 09:23:11 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves v2 0/9] pahole: Encode true signatures in kernel
 BTF
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
 Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, kernel-team@fb.com
References: <20260309153215.1917033-1-yonghong.song@linux.dev>
 <976a9e56-a221-4f63-8f10-caf2a3c8fa4f@oracle.com>
 <caa6ac68-9702-43fb-87cc-7393fb44c176@linux.dev>
In-Reply-To: <caa6ac68-9702-43fb-87cc-7393fb44c176@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 3/9/26 12:25 PM, Yonghong Song wrote:
>
>
> On 3/9/26 11:39 AM, Alan Maguire wrote:
>> On 09/03/2026 15:32, Yonghong Song wrote:
>>> Current vmlinux BTF encoding is based on the source level signatures.
>>> But the compiler may do some optimization and changed the signature.
>>> If the user tried with source level signature, their initial 
>>> implementation
>>> may have wrong results and then the user need to check what is the
>>> problem and work around it, e.g. through kprobe since kprobe does not
>>> need vmlinux BTF.
>>>
>>> Majority of changed signatures are due to dead argument elimination.
>>> The following is a more complex one. The original source signature:
>>>    typedef struct {
>>>          union {
>>>                  void            *kernel;
>>>                  void __user     *user;
>>>          };
>>>          bool            is_kernel : 1;
>>>    } sockptr_t;
>>>    typedef sockptr_t bpfptr_t;
>>>    static int map_create(union bpf_attr *attr, bpfptr_t uattr) { ... }
>>> After compiler optimization, the signature becomes:
>>>    static int map_create(union bpf_attr *attr, bool 
>>> uattr__is_kernel) { ... }
>>> In the above, uattr__is_kernel corresponds to 'is_kernel' field in 
>>> sockptr_t.
>>> This makes it easier for developers to understand what changed.
>>>
>>> The new signature needs to properly follow ABI specification based on
>>> locations. Otherwise, that signature should be discarded. For example,
>>>
>>>      0x0242f1f7:   DW_TAG_subprogram
>>>                      DW_AT_name ("memblock_find_in_range")
>>>                      DW_AT_calling_convention (DW_CC_nocall)
>>>                      DW_AT_type      (0x0242decc "phys_addr_t")
>>>                      ...
>>>      0x0242f22e:     DW_TAG_formal_parameter
>>>                        DW_AT_location        (indexed (0x14a) 
>>> loclist = 0x005595bc:
>>>                           [0xffffffff87a000f9, 0xffffffff87a00178): 
>>> DW_OP_reg5 RDI
>>>                           [0xffffffff87a00178, 0xffffffff87a001be): 
>>> DW_OP_reg14 R14
>>>                           [0xffffffff87a001be, 0xffffffff87a001c7): 
>>> DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
>>>                           [0xffffffff87a001c7, 0xffffffff87a00214): 
>>> DW_OP_reg14 R14)
>>>                        DW_AT_name    ("start")
>>>                        DW_AT_type    (0x0242decc "phys_addr_t")
>>>                        ...
>>>      0x0242f239:     DW_TAG_formal_parameter
>>>                        DW_AT_location        (indexed (0x14b) 
>>> loclist = 0x005595e6:
>>>                           [0xffffffff87a000f9, 0xffffffff87a00175): 
>>> DW_OP_reg4 RSI
>>>                           [0xffffffff87a00175, 0xffffffff87a001b8): 
>>> DW_OP_reg3 RBX
>>>                           [0xffffffff87a001b8, 0xffffffff87a001c7): 
>>> DW_OP_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value
>>>                           [0xffffffff87a001c7, 0xffffffff87a00214): 
>>> DW_OP_reg3 RBX)
>>>                        DW_AT_name    ("end")
>>>                        DW_AT_type    (0x0242decc "phys_addr_t")
>>>                        ...
>>>      0x0242f245:     DW_TAG_formal_parameter
>>>                        DW_AT_location        (indexed (0x14c) 
>>> loclist = 0x00559610:
>>>                           [0xffffffff87a001e3, 0xffffffff87a001ef): 
>>> DW_OP_breg4 RSI+0)
>>>                        DW_AT_name    ("size")
>>>                        DW_AT_type    (0x0242decc "phys_addr_t")
>>>                        ...
>>>      0x0242f250:     DW_TAG_formal_parameter
>>>                        DW_AT_const_value     (4096)
>>>                        DW_AT_name    ("align")
>>>                        DW_AT_type    (0x0242decc "phys_addr_t")
>>>                        ...
>>>
>>> The third argument should correspond to RDX for x86_64. But the 
>>> location suggests that
>>> the parameter value is stored in the address with 'RSI + 0'. It is 
>>> not clear whether
>>> the parameter value is stored in RDX or not. So we have to discard 
>>> this funciton in
>>> vmlinux BTF to avoid incorrect true signatures.
>>>
>>> For llvm, any function having
>>>    DW_AT_calling_convention        (DW_CC_nocall)
>>> in dwarf DW_TAG_subprogram will indicate that this function has 
>>> signature changed.
>>> I did experiment with latest bpf-next. For x86_64, there are 69103 
>>> kernel functions
>>> and 875 kernel functions having signature changed. A series of 
>>> patches are intended
>>> to ensure true signatures are properly represented. Eventually, only 
>>> 17 functions
>>> cannot have true signatures due to locations.
>>>
>> hi Yonghong, one high-level question before I start digging into this 
>> further.
>> Are there any minimum requirements on LLVM/clang version for this 
>> support? Thanks!
>
> This featureDW_AT_calling_convention is introduced into llvm on June 
> 2022: https://reviews.llvm.org/D127134
> The release is llvm15. From Documentation/process/changes.rst, we have
>     Clang/LLVM (optional)  15.0.0           clang --version
> So we should be okay.
>
> But if the kernel is built with -O3 or FullLTO, there will be some
> additional signature changed functions and they will be checked
> only available at >= llvm23 (see 
> https://github.com/llvm/llvm-project/pull/178973).
> But the number of those additional signature changed functions should 
> not be that many.
> Also typical kernel build is -O2 so we are not missing signature changed
> functions in most cases.
>
>>
>> Alan
>>> For arm64, there are 863 kernel functions having signature changed, and
>>> 79 functions cannot have true signatures due to locations. I checked 
>>> those
>>> functions and look like llvm arm64 backend more relaxed to compute 
>>> parameter
>>> values.
>>>
>>> For the patch set, Patch 1 introduced usage of 
>>> DW_AT_calling_convention, which
>>> can precisely identify which function has signature changed. This 
>>> can filter
>>> majority of functions where their signature won't change.
>>> Patches 2 to 7 tried to find functions with true signature.
>>> Patch 8 enables to btf encoder to properly generate BTF.
>>> Patch 9 includes a few tests.
>>>
>>> Changelog:
>>>    v1 -> v2:
>>>      - v1: 
>>> https://lore.kernel.org/bpf/20260305225455.1151066-1-yonghong.song@linux.dev/
>>>      - Added producer_clang guarding in btf_encoder. Otherwise, gcc 
>>> kernel build
>>>        will crash pahole.
>>>      - Fix an early return in parameter__reg() which didn't do 
>>> pthread_mutex_unlock()
>>>        which caused the deadlock for arm64.
>>>      - Add a few more places to guard with producer_clang and 
>>> conf->true_signature
>>>        to maintain the previous behavior if not clang or 
>>> conf->true_signature is false.
>>>
>>> Yonghong Song (9):
>>>    dwarf_loader: Reduce parameter checking with clang
>>>      DW_AT_calling_convention attr
>>>    dwarf_loader: Handle signatures with dead arguments
>>>    dwarf_loader: Refactor initial ret -1 to be macro PARM_DEFAULT_FAIL
>>>    dwarf_laoder: Handle locations with DW_OP_fbreg
>>>    dwarf_loader: Change exprlen checking condition in parameter__reg()
>>>    dwarf_loader: Detect optimized parameters with locations having
>>>      constant values
>>>    dwarf_loader: Handle expression lists
>>>    btf_encoder: Handle optimized parameter properly
>>>    tests: Add a few clang true signature tests
>>>
>>>   btf_encoder.c                                 |  13 +-
>>>   dwarf_loader.c                                | 397 
>>> +++++++++++++++++-
>>>   dwarves.h                                     |   3 +
>>>   tests/true_signatures/clang_parm_aggregate.sh |  83 ++++
>>>   tests/true_signatures/clang_parm_optimized.sh |  95 +++++
>>>   .../clang_parm_optimized_stack.sh             |  95 +++++
>>>   .../gcc_true_signatures.sh                    |   0
>>>   7 files changed, 662 insertions(+), 24 deletions(-)
>>>   create mode 100755 tests/true_signatures/clang_parm_aggregate.sh
>>>   create mode 100755 tests/true_signatures/clang_parm_optimized.sh
>>>   create mode 100755 
>>> tests/true_signatures/clang_parm_optimized_stack.sh
>>>   rename tests/{ => true_signatures}/gcc_true_signatures.sh (100%)
>>>
Ping. Alan, have you got some chances to review this patch set?

