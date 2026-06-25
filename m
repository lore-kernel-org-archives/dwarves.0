Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DA53E7164
	for <dwarves@vger.kernel.org>; Thu, 25 Jun 2026 17:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782406803; cv=none; b=AOQQ+xAcrNnTTSFB0aL1o6smmbJmalsAvWniyW4RAuoVfcsVpxSwvWPyD8msAbxM49ZXViASjmtexsaL3TS+DRycAxzrCSdbkkutrtAM8N9kTaS1j/byIC0z4OgYkhqrO46nLNZ3brzOrXq2V/2XhcfioqX4h1O4gMfPnfVJi50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782406803; c=relaxed/simple;
	bh=hI6afDcN3uImdVb7J+at1rYPtofw2XIek++OLKQGlgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PfNbeVEmGC6HHqND/2y2LpJuFiTJpyo4ZdaUnouoU0nd24xhObli1VIWXycpYYngXJEtt2fNv/bU3M+PGM85u0m4uhgAp83aDUcwUeV/yiuYw1p6n2M/mx5WBE/3FFXF9r4z39K2/bGdpRPBkOK2lmVBoMInbqo9eWZrBal94c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LebcXyiT; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LebcXyiT"
Message-ID: <fd9ebc32-1d31-4f85-9c39-c1e4100d985a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782406789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LlTeYZ/7wBvBIqprf7XZ3sj7cme/8ojhsxcxkhsBq90=;
	b=LebcXyiT0BkVl8rNTR3idFuAOMXy9lnE58+IcJZgfZ++csoHzBtr1HRWzIPmnDQ3BbAIlj
	7XMhkGBVTbn2SRAOl8175m5wzZBIMy7yQrpQTsaFdHRxVTufRvhrBAyWucs0AETmrv7nqK
	MjOyYltyntVDD4SFpUi6qVb0NQpfyNc=
Date: Thu, 25 Jun 2026 09:59:42 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves v10 0/5] pahole: Encode true signatures in kernel
 BTF
Content-Language: en-GB
To: Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <olsajiri@gmail.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
 dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, kernel-team@fb.com
References: <20260625020148.1883082-1-yonghong.song@linux.dev>
 <aj0KGx-5FwUbwGHc@krava> <1d7828aa-164f-4c36-9d5e-2eb2088ce5b4@oracle.com>
 <906ec2c1-e62b-47d8-a0bd-4d88df26c0c3@linux.dev>
 <3bdacbc7-8385-452a-9443-ee9cc03abd10@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <3bdacbc7-8385-452a-9443-ee9cc03abd10@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/25/26 9:17 AM, Alan Maguire wrote:
> On 25/06/2026 16:26, Yonghong Song wrote:
>>
>> On 6/25/26 6:22 AM, Alan Maguire wrote:
>>> On 25/06/2026 11:59, Jiri Olsa wrote:
>>>> On Wed, Jun 24, 2026 at 07:01:48PM -0700, Yonghong Song wrote:
>>>>> Current vmlinux BTF encoding is based on the source level signatures.
>>>>> But the compiler may do some optimization and changed the signature.
>>>>> If the user tried with source level signature, their initial implementation
>>>>> may have wrong results and then the user need to check what is the
>>>>> problem and work around it, e.g. through kprobe since kprobe does not
>>>>> need vmlinux BTF.
>>>>>
>>>>> Majority of changed signatures are due to dead argument elimination.
>>>>> The following is a more complex one. The original source signature:
>>>>>     typedef struct {
>>>>>           union {
>>>>>                   void            *kernel;
>>>>>                   void __user     *user;
>>>>>           };
>>>>>           bool            is_kernel : 1;
>>>>>     } sockptr_t;
>>>>>     typedef sockptr_t bpfptr_t;
>>>>>     static int map_create(union bpf_attr *attr, bpfptr_t uattr) { ... }
>>>>> After compiler optimization, the signature becomes:
>>>>>     static int map_create(union bpf_attr *attr, bool uattr__is_kernel) { ... }
>>>>> In the above, uattr__is_kernel corresponds to 'is_kernel' field in sockptr_t.
>>>>> This makes it easier for developers to understand what changed.
>>>>>
>>>>> The new signature needs to properly follow ABI specification based on
>>>>> locations. Otherwise, that signature should be discarded. For example,
>>>>>
>>>>>       0x0242f1f7:   DW_TAG_subprogram
>>>>>                       DW_AT_name      ("memblock_find_in_range")
>>>>>                       DW_AT_calling_convention        (DW_CC_nocall)
>>>>>                       DW_AT_type      (0x0242decc "phys_addr_t")
>>>>>                       ...
>>>>>       0x0242f22e:     DW_TAG_formal_parameter
>>>>>                         DW_AT_location        (indexed (0x14a) loclist = 0x005595bc:
>>>>>                            [0xffffffff87a000f9, 0xffffffff87a00178): DW_OP_reg5 RDI
>>>>>                            [0xffffffff87a00178, 0xffffffff87a001be): DW_OP_reg14 R14
>>>>>                            [0xffffffff87a001be, 0xffffffff87a001c7): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
>>>>>                            [0xffffffff87a001c7, 0xffffffff87a00214): DW_OP_reg14 R14)
>>>>>                         DW_AT_name    ("start")
>>>>>                         DW_AT_type    (0x0242decc "phys_addr_t")
>>>>>                         ...
>>>>>       0x0242f239:     DW_TAG_formal_parameter
>>>>>                         DW_AT_location        (indexed (0x14b) loclist = 0x005595e6:
>>>>>                            [0xffffffff87a000f9, 0xffffffff87a00175): DW_OP_reg4 RSI
>>>>>                            [0xffffffff87a00175, 0xffffffff87a001b8): DW_OP_reg3 RBX
>>>>>                            [0xffffffff87a001b8, 0xffffffff87a001c7): DW_OP_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value
>>>>>                            [0xffffffff87a001c7, 0xffffffff87a00214): DW_OP_reg3 RBX)
>>>>>                         DW_AT_name    ("end")
>>>>>                         DW_AT_type    (0x0242decc "phys_addr_t")
>>>>>                         ...
>>>>>       0x0242f245:     DW_TAG_formal_parameter
>>>>>                         DW_AT_location        (indexed (0x14c) loclist = 0x00559610:
>>>>>                            [0xffffffff87a001e3, 0xffffffff87a001ef): DW_OP_breg4 RSI+0)
>>>>>                         DW_AT_name    ("size")
>>>>>                         DW_AT_type    (0x0242decc "phys_addr_t")
>>>>>                         ...
>>>>>       0x0242f250:     DW_TAG_formal_parameter
>>>>>                         DW_AT_const_value     (4096)
>>>>>                         DW_AT_name    ("align")
>>>>>                         DW_AT_type    (0x0242decc "phys_addr_t")
>>>>>                         ...
>>>>>
>>>>> The third argument should correspond to RDX for x86_64. But the location suggests that
>>>>> the parameter value is stored in the address with 'RSI + 0'. It is not clear whether
>>>>> the parameter value is stored in RDX or not. So we have to discard this funciton in
>>>>> vmlinux BTF to avoid incorrect true signatures.
>>>>>
>>>>> For llvm, any function having
>>>>>     DW_AT_calling_convention        (DW_CC_nocall)
>>>>> in dwarf DW_TAG_subprogram will indicate that this function has signature changed.
>>>>> But for non DW_CC_nocall functions, it is possible that true signature still not
>>>>> available due to locations. So every functions will be checked.
>>>>>
>>>>> I did experiment with latest bpf-next. For x86_64, there are 69103 kernel functions
>>>>> and 875 kernel functions having signature changed. A series of patches are intended
>>>>> to ensure true signatures are properly represented. Eventually, only 20 functions
>>>>> cannot have true signatures due to locations.
>>>>>
>>>>> For arm64, there are 863 kernel functions having signature changed, and
>>>>> 108 functions cannot have true signatures due to locations. I checked those
>>>>> functions and look like llvm arm64 backend more relaxed to compute parameter
>>>>> values.
>>>>>
>>>>> For full testing, I enabled true signature support in kernel scripts/Makefile.btf like below:
>>>>>     -pahole-flags-$(call test-ge, $(pahole-ver), 131) += --btf_features=attributes
>>>>>     +pahole-flags-$(call test-ge, $(pahole-ver), 131) += --btf_features=attributes --btf_features=+true_signature
>>>>>
>>>>> See individual patches for details.
>>>> hi,
>>>> I tried this version and had to choose another function, because "arp_process"
>>>> suddenly started to show args registers in proper order ;-)
>>>>
>>>> now I checked "stop_cpus" function which is added to btf after this change,
>>>> I attached the dwarf dump below
>>>>
>>>> "stop_cpus" has DW_CC_nocall set, so it has signature_changed=true and I see the
>>>> function ends up in the btf_encoder with optimized_parms=1
>>>>
>>>> but we do not skip such functions now, it seems like we should?
>>>>
>>>> I tried the attached change below and it removes all the extra functions
>>>> that were added in the btf with this change
>>>>
>>>> btw I can't see any other use for optimized_parms flag, it seems to be
>>>> just set and never used.. so I wonder I'm missing something
>>>>
>>> Thanks for looking at this!
>>>
>>> Yonghong can correct me if I have this wrong, but I think optimized parameters
>>> are okay, but only if true signature is enabled, so omitting functions with
>>> optimized parameters should probably only happen if !true_signature. so for
>>> the change below, the modification to btf_encoder__add_saved_funcs() is right
>>> but I don't think the modification to btf_encoder__add_true_signature() is needed.
>> I agree with Alan in the above.
>>
>> There is no need to make change in btf_encoder__add_true_signature().
>> This is for true_signature, optimized parameters have been removed:
>>
>> +               /* No location info/optimized + reordered means optimized out. */
>> +               if (ftype->reordered_parm && (!param->has_loc || param->optimized)) {
>> +                       state->nr_parms--;
>> +                       continue;
>> +               }
>>
>> so we should not add true_state->optimized_parms checking in btf_encoder__add_true_signature().
>>
>> For adding state->optimized_parms in btf_encoder__add_saved_funcs(), with true_signature disabled,
>> we already have a failure message:
>>     stop_cpus : skipping BTF encoding of function due to unexpected register usage for parameter
>> The expectation is for three parameters, the register usage should be
>>     cpumask: RDI, fn: RSI, arg: RDX
>> but since 'fn' is optimized away, the expected reg usage does not match the actual reg usage.
>>
>> We could add:
>>    +        if (state->optimized_parms)
>>    +            skip_reason = "optimized parms\n";
>> to have another message to indicate possible reason is due to optimized parms.
>> But it is not critical as we already have one message.
>>
>> I can have a follow up for this.
>>
> I tried pushing just the btf_encoder__add_saved_funcs() hunk from Jiri's diff to CI [1];
> it looks like we end up omitting a lot more functions than before for aarch64 (including
> some kfuncs) for both gcc and clang kernel builds, and we see an x86_64 test failure:
>
> 5: clang_parm_memory.sh
> Validation of BTF encoding of true_signatures.
>     BTF for foo missing; the stack-passed aggregate was likely rejected
> Test ./clang_parm_memory.sh failed
> Test data is in /tmp/clang_parm_memory.sh.DV7PyO

I actually tried clang_parm_memory.sh with clang22 and clang23. Both of them
passed in my local run. Not exactly sure what is the issue. Let me debug this.

Could you share how to test with pahole CI? So I can resolve all issues in CI
before submit another revision if needed.

>
> The optimized_parms flag is a bit too broad I think; it is set whenever we are
> missing location info for _any_ parameter; this may be overly aggressive for clang in
> particular which seems to have more missing location info.
>
> [1] https://github.com/alan-maguire/dwarves/actions/runs/28173261168
>   
>>>   
>>>> jirka
>>>>
>>>>
>>>> dwarfdump:
>>>>
>>>> 0x016f4b1b:   DW_TAG_subprogram
>>>>                   DW_AT_low_pc    (0xffffffff813e0fc0)
>>>>                   DW_AT_high_pc   (0xffffffff813e1133)
>>>>                   DW_AT_frame_base        (DW_OP_reg7 RSP)
>>>>                   DW_AT_GNU_all_call_sites        (true)
>>>>                   DW_AT_name      ("stop_cpus")
>>>>                   DW_AT_decl_file ("/home/jolsa/kernel/linux-qemu-2/kernel/stop_machine.c")
>>>>                   DW_AT_decl_line (464)
>>>>                   DW_AT_prototyped        (true)
>>>>                   DW_AT_calling_convention        (DW_CC_nocall)
>>>>                   DW_AT_type      (0x016e94c5 "int")
>>>>
>>>> 0x016f4b36:     DW_TAG_formal_parameter
>>>>                     DW_AT_location        (0x0065ad9e:
>>>>                        [0xffffffff813e0fc5, 0xffffffff813e0fed): DW_OP_reg5 RDI
>>>>                        [0xffffffff813e0fed, 0xffffffff813e111e): DW_OP_reg14 R14
>>>>                        [0xffffffff813e111e, 0xffffffff813e1127): DW_OP_GNU_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
>>>>                        [0xffffffff813e1127, 0xffffffff813e1133): DW_OP_reg14 R14)
>>>>                     DW_AT_name    ("cpumask")
>>>>                     DW_AT_decl_file       ("/home/jolsa/kernel/linux-qemu-2/kernel/stop_machine.c")
>>>>                     DW_AT_decl_line       (464)
>>>>                     DW_AT_type    (0x016f3242 "const cpumask *")
>>>>
>>>> 0x016f4b46:     DW_TAG_formal_parameter
>>>>                     DW_AT_name    ("fn")
>>>>                     DW_AT_decl_file       ("/home/jolsa/kernel/linux-qemu-2/kernel/stop_machine.c")
>>>>                     DW_AT_decl_line       (464)
>>>>                     DW_AT_type    (0x016f2ca5 "cpu_stop_fn_t")
>>>>
>>>> 0x016f4b52:     DW_TAG_formal_parameter
>>>>                     DW_AT_location        (0x0065ae0d:
>>>>                        [0xffffffff813e0fc5, 0xffffffff813e0ff2): DW_OP_reg4 RSI
>>>>                        [0xffffffff813e0ff2, 0xffffffff813e10e4): DW_OP_reg3 RBX
>>>>                        [0xffffffff813e10e4, 0xffffffff813e1127): DW_OP_GNU_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value
>>>>                        [0xffffffff813e1127, 0xffffffff813e112e): DW_OP_reg3 RBX
>>>>                        [0xffffffff813e112e, 0xffffffff813e1133): DW_OP_GNU_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value)
>>>>                     DW_AT_name    ("arg")
>>>>                     DW_AT_decl_file       ("/home/jolsa/kernel/linux-qemu-2/kernel/stop_machine.c")
>>>>                     DW_AT_decl_line       (464)
>>>>                     DW_AT_type    (0x016e858f "void *")
>>>>
>>>>
>>>>
>>>>
>>>> ---
>>>> diff --git a/btf_encoder.c b/btf_encoder.c
>>>> index 38455a4c6b6b..cbc5063a6280 100644
>>>> --- a/btf_encoder.c
>>>> +++ b/btf_encoder.c
>>>> @@ -1564,7 +1564,8 @@ static int btf_encoder__add_true_signature(struct btf_encoder *encoder,
>>>>             */
>>>>            if (true_state->unexpected_reg ||
>>>>                true_state->uncertain_parm_loc ||
>>>> -            true_state->ambiguous_addr)
>>>> +            true_state->ambiguous_addr ||
>>>> +            true_state->optimized_parms)
>>>>                continue;
>>>>            err = btf_encoder__add_func(encoder, true_state);
>>>>            if (err < 0)
>>>> @@ -1656,6 +1657,8 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
>>>>                skip_reason = "reordered parameters\n";
>>>>            if (state->elf->ambiguous_addr)
>>>>                skip_reason = "ambiguous address\n";
>>>> +        if (state->optimized_parms)
>>>> +            skip_reason = "optimized parms\n";
>>>>              if (skip_reason) {
>>>>                btf_encoder__log_func_skip(encoder, saved_fns[i].elf,

