Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D9723BD1B
	for <dwarves@vger.kernel.org>; Thu, 25 Jun 2026 17:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782410393; cv=none; b=fIaBy+Vx+J+GPG58Vqy5Xle9OAYVFUbQxOmPiYrm6WazeLlrnqziZUbafCiz0bRZXG1jgcH9d2vsCy26FPMvk1LoOwaf1jq2ACjYqO20ddDblvCW9W3yIAidk5tY7DDR2UKv7BETs2LEeW1Pw0dXQs9HoTk/ltauuWlJIVQSx6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782410393; c=relaxed/simple;
	bh=9ieAEmsE4F+TTxRX3UXBvd11KxPm9KeJLSxiuMEzLl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QOLVS2PXF97r47D8TJz2yM6y5vEvg8UB2DiAZMY9WJRS+yxh776AlSCUetHRQ8UBW6u1FbcAq/lruAhsi0Iq2CunudBHD6DMhLm4ll76zNStEkUdzWwI0lIiSTNwLVBmLAJlID7sQBQlatcGUsqKFu0c+ab3olF7oX/MqUxsFBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sTBmefPi; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sTBmefPi"
Message-ID: <dd556546-23f4-43c0-b502-ec818afc7b3b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782410388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=slb7AKQlNLrcLwwsv70TJ8r+7Ia0z99x6w95rtvJbXo=;
	b=sTBmefPiOAN+QkasoKBLnLRI0wSjp76O5Jfd3k+DMi4aIVnRsHn9skq1bg8EV2XxKX9EWe
	aUbS3bIR35auSRYv0ogmzQHRWeEsYhoVWtOT/Hpmdvb0Pz2GAWZFlLVIitPn2vp/ud7BK1
	muhWGxIUQYMmhty3pPKlyF1N7ija2wg=
Date: Thu, 25 Jun 2026 10:59:41 -0700
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

For clang, aarch64 has more werid locaitons compared to x86.
Not sure whether this could be part of readon which will cause more failures.

>
> 5: clang_parm_memory.sh
> Validation of BTF encoding of true_signatures.
>     BTF for foo missing; the stack-passed aggregate was likely rejected
> Test ./clang_parm_memory.sh failed
> Test data is in /tmp/clang_parm_memory.sh.DV7PyO

The above claims the BTF encoding is missing even with true signature.

The following is what I have in my local run with llvm22:

$ cat t.c
union big { long a; char buf[24]; };
__attribute__((noinline)) static long foo(union big u, int dead, int x)
{
         return u.a + x;
}

union big g;
int dead, x;
int main()
{
         return (int)foo(g, dead, x);
}

$ /bin/clang --version
clang version 22.1.3 (CentOS 22.1.3-1.el9)
Target: x86_64-redhat-linux-gnu
Thread model: posix
InstalledDir: /usr/bin
Configuration file: /etc/clang/x86_64-redhat-linux-gnu-clang.cfg

$ /bin/clang -O2 -g -c t.c

$ /bin/llvm-dwarfdump t.o
t.o:    file format elf64-x86-64
                                                                                                                                  
.debug_info contents:
0x00000000: Compile Unit: length = 0x00000117, format = DWARF32, version = 0x0004, abbr_offset = 0x0000, addr_size = 0x08 (next u
nit at 0x0000011b)
                                                                                                                                  
0x0000000b: DW_TAG_compile_unit
               DW_AT_producer    ("clang version 22.1.3 (CentOS 22.1.3-1.el9)")
               DW_AT_language    (DW_LANG_C11)
               DW_AT_name        ("t.c")
               DW_AT_stmt_list   (0x00000000)
               DW_AT_comp_dir    ("/home/yhs/tmp")
               DW_AT_low_pc      (0x0000000000000000)
               DW_AT_high_pc     (0x0000000000000039)
                                                                                                                                  
0x0000002a:   DW_TAG_variable
                 DW_AT_name      ("g")
                 DW_AT_type      (0x0000003f "big")
                 DW_AT_external  (true)
                 DW_AT_decl_file ("/home/yhs/tmp/t.c")
                 DW_AT_decl_line (7)
                 DW_AT_location  (DW_OP_addr 0x0)
                                                                                                                                  
0x0000003f:   DW_TAG_union_type
                 DW_AT_name      ("big")
                 DW_AT_byte_size (0x18)
                 DW_AT_decl_file ("/home/yhs/tmp/t.c")
                 DW_AT_decl_line (1)
                                                                                                                                  
0x00000047:     DW_TAG_member
                   DW_AT_name    ("a")
                   DW_AT_type    (0x00000060 "long")
                   DW_AT_decl_file       ("/home/yhs/tmp/t.c")
                   DW_AT_decl_line       (1)
                   DW_AT_data_member_location    (0x00)
                                                                                                                                  
0x00000053:     DW_TAG_member
                   DW_AT_name    ("buf")
                   DW_AT_type    (0x00000067 "char[24]")
                   DW_AT_decl_file       ("/home/yhs/tmp/t.c")
                   DW_AT_decl_line       (1)
                   DW_AT_data_member_location    (0x00)

0x0000005f:     NULL

0x00000060:   DW_TAG_base_type
                 DW_AT_name      ("long")
                 DW_AT_encoding  (DW_ATE_signed)
                 DW_AT_byte_size (0x08)

0x00000067:   DW_TAG_array_type
                 DW_AT_type      (0x00000073 "char")

0x0000006c:     DW_TAG_subrange_type
                   DW_AT_type    (0x0000007a "__ARRAY_SIZE_TYPE__")
                   DW_AT_count   (0x18)

0x00000072:     NULL

0x00000073:   DW_TAG_base_type
                 DW_AT_name      ("char")
                 DW_AT_encoding  (DW_ATE_signed_char)
                 DW_AT_byte_size (0x01)

0x0000007a:   DW_TAG_base_type
                 DW_AT_name      ("__ARRAY_SIZE_TYPE__")
                 DW_AT_byte_size (0x08)
                 DW_AT_encoding  (DW_ATE_unsigned)

0x00000081:   DW_TAG_variable
                 DW_AT_name      ("dead")
                 DW_AT_type      (0x00000096 "int")
                 DW_AT_external  (true)
                 DW_AT_decl_file ("/home/yhs/tmp/t.c")
                 DW_AT_decl_line (8)
                 DW_AT_location  (DW_OP_addr 0x0)

0x00000096:   DW_TAG_base_type
                 DW_AT_name      ("int")
                 DW_AT_encoding  (DW_ATE_signed)
                 DW_AT_byte_size (0x04)

0x0000009d:   DW_TAG_variable
                 DW_AT_name      ("x")
                 DW_AT_type      (0x00000096 "int")
                 DW_AT_external  (true)
                 DW_AT_decl_file ("/home/yhs/tmp/t.c")
                 DW_AT_decl_line (8)
                 DW_AT_location  (DW_OP_addr 0x0)

0x000000b2:   DW_TAG_subprogram
                 DW_AT_low_pc    (0x0000000000000000)
                 DW_AT_high_pc   (0x000000000000002b)
                 DW_AT_frame_base        (DW_OP_reg7 RSP)
                 DW_AT_GNU_all_call_sites        (true)
                 DW_AT_name      ("main")
                 DW_AT_decl_file ("/home/yhs/tmp/t.c")
                 DW_AT_decl_line (9)
                 DW_AT_type      (0x00000096 "int")
                 DW_AT_external  (true)

0x000000cb:     DW_TAG_GNU_call_site
                   DW_AT_abstract_origin (0x000000d9 "foo")
                   DW_AT_low_pc  (0x0000000000000026)

0x000000d8:     NULL

0x000000d9:   DW_TAG_subprogram
                 DW_AT_low_pc    (0x0000000000000030)
                 DW_AT_high_pc   (0x0000000000000039)
                 DW_AT_frame_base        (DW_OP_reg7 RSP)
                 DW_AT_GNU_all_call_sites        (true)
                 DW_AT_name      ("foo")
                 DW_AT_decl_file ("/home/yhs/tmp/t.c")
                 DW_AT_decl_line (2)
                 DW_AT_prototyped        (true)
                 DW_AT_calling_convention        (DW_CC_nocall)
                 DW_AT_type      (0x00000060 "long")

0x000000f3:     DW_TAG_formal_parameter
                   DW_AT_location        (DW_OP_fbreg +8)
                   DW_AT_name    ("u")
                   DW_AT_decl_file       ("/home/yhs/tmp/t.c")
                   DW_AT_decl_line       (2)
                   DW_AT_type    (0x0000003f "big")

0x00000101:     DW_TAG_formal_parameter
                   DW_AT_name    ("dead")
                   DW_AT_decl_file       ("/home/yhs/tmp/t.c")
                   DW_AT_decl_line       (2)
                   DW_AT_type    (0x00000096 "int")

0x0000010c:     DW_TAG_formal_parameter
                   DW_AT_location        (DW_OP_reg5 RDI)
                   DW_AT_name    ("x")
                   DW_AT_decl_file       ("/home/yhs/tmp/t.c")
                   DW_AT_decl_line       (2)
                   DW_AT_type    (0x00000096 "int")

0x00000119:     NULL

0x0000011a:   NULL

The following is the critical dwarf:

0x000000d9:   DW_TAG_subprogram
                 DW_AT_low_pc    (0x0000000000000030)
                 DW_AT_high_pc   (0x0000000000000039)
                 DW_AT_frame_base        (DW_OP_reg7 RSP)
                 DW_AT_GNU_all_call_sites        (true)
                 DW_AT_name      ("foo")
                 DW_AT_decl_file ("/home/yhs/tmp/t.c")
                 DW_AT_decl_line (2)
                 DW_AT_prototyped        (true)
                 DW_AT_calling_convention        (DW_CC_nocall)
                 DW_AT_type      (0x00000060 "long")

0x000000f3:     DW_TAG_formal_parameter
                   DW_AT_location        (DW_OP_fbreg +8)
                   DW_AT_name    ("u")
                   DW_AT_decl_file       ("/home/yhs/tmp/t.c")
                   DW_AT_decl_line       (2)
                   DW_AT_type    (0x0000003f "big")

0x00000101:     DW_TAG_formal_parameter
                   DW_AT_name    ("dead")
                   DW_AT_decl_file       ("/home/yhs/tmp/t.c")
                   DW_AT_decl_line       (2)
                   DW_AT_type    (0x00000096 "int")

0x0000010c:     DW_TAG_formal_parameter
                   DW_AT_location        (DW_OP_reg5 RDI)
                   DW_AT_name    ("x")
                   DW_AT_decl_file       ("/home/yhs/tmp/t.c")
                   DW_AT_decl_line       (2)
                   DW_AT_type    (0x00000096 "int")

0x00000119:     NULL

With true_signature:

$ pahole -JV --btf_features=+true_signature t.o
btf_encoder__new: 't.o' doesn't have '.data..percpu' section
File t.o:
[1] UNION big size=24
         a type_id=2 bits_offset=0
         buf type_id=3 bits_offset=0
[2] INT long size=8 nr_bits=64 encoding=SIGNED
[3] ARRAY (anon) type_id=4 index_type_id=6 nr_elems=24
[4] INT char size=1 nr_bits=8 encoding=SIGNED
[5] INT __ARRAY_SIZE_TYPE__ size=8 nr_bits=64 encoding=(none)
[6] INT int size=4 nr_bits=32 encoding=SIGNED
search cu 't.c' for percpu global variables.
[7] FUNC_PROTO (anon) return=2 args=(1 u, 6 x)
[8] FUNC foo type_id=7
[9] FUNC_PROTO (anon) return=6 args=(void)
[10] FUNC main type_id=9

It succeeded with proper true signature.

Without true_signature:

$ pahole -JV t.o
btf_encoder__new: 't.o' doesn't have '.data..percpu' section
File t.o:
[1] UNION big size=24
         a type_id=2 bits_offset=0
         buf type_id=3 bits_offset=0
[2] INT long size=8 nr_bits=64 encoding=SIGNED
[3] ARRAY (anon) type_id=4 index_type_id=6 nr_elems=24
[4] INT char size=1 nr_bits=8 encoding=SIGNED
[5] INT __ARRAY_SIZE_TYPE__ size=8 nr_bits=64 encoding=(none)
[6] INT int size=4 nr_bits=32 encoding=SIGNED
search cu 't.c' for percpu global variables.
foo : skipping BTF encoding of function due to unexpected register usage for parameter
[7] FUNC_PROTO (anon) return=6 args=(void)
[8] FUNC main type_id=7

The 'foo' will be missed due to mismatch between arg's and locations.

Not exactly sure what CI has an issue for the test.


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

