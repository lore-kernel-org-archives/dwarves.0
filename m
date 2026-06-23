Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F18540D595
	for <dwarves@vger.kernel.org>; Tue, 23 Jun 2026 16:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782233386; cv=none; b=Zt+cAJV3gj/SuiM2Ui1rbCYaXeA8uKxLy1CckNyTIMB0W4r0TwKVSeTJdZ6UsXposcXFVOmrsLUOisPNSZO7HbIvgdg+T5vuugfi5hhKBIZUiAGcZZDWviqp2b3N31wASdLDplu1DH03RlFc8uBR0W6N0Ima72apmpx4OaNUXcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782233386; c=relaxed/simple;
	bh=iNwO/rNKTXc/JKA2rRfx1omqBrvnxFZT+GDqXf7z4cQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pAxMVDp4NpQE9OSI5/ZscJxGU6+yOBLNGWHtGLZKb7h5ChJ5M6Glxtis4IJ1HVqP6zV8pBKuHY+a8wqXI0o5/p2vyLMsLiyK2Rd9LdwQ9QU1hSosa306z62sX7VpdGZjEXCVF3ae81OEDLrQzoxMgnxtWBPquIDqnzBwgJ1OrE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rfhJQ/cp; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rfhJQ/cp"
Message-ID: <60d2b741-b520-4f63-99ea-5a5e9825fcc5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782233382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FNd2N44ZnRaRe2kqiXc4lON/BYcZH0gC3XHUQm4SpBc=;
	b=rfhJQ/cpswPY1vMT2Et27GLVGiOUn4gDmEgUMZ5kXWWM6a8xc4L0mGxTfIfzvDtMzA0aPZ
	HWzqxQ3VhbDEvWjYbDcxtil0k8/jAbg29NfMq6ZEi58IIFjCYNwi38rVrxTtQc40GVS+Xi
	9x6WqVn5Qsn+DxuVMiIXOiFLE3Apkjs=
Date: Tue, 23 Jun 2026 09:49:35 -0700
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

Thanks, Alan. I think we should preserve the previous change in dwarf_loader.c
(the patch you applied Jiri).

The following is a dwarf example in clang built kernel:

0x053c4bb4:   DW_TAG_subprogram
                 DW_AT_low_pc    (0xffffffff828bce90)
                 DW_AT_high_pc   (0xffffffff828bde6d)
                 DW_AT_frame_base        (DW_OP_reg6 RBP)
                 DW_AT_call_all_calls    (true)
                 DW_AT_name      ("ZSTD_buildSequencesStatistics")
                 DW_AT_decl_file ("/home/yhs/work/bpf-next/lib/zstd/compress/zstd_compress.c")
                 DW_AT_decl_line (2677)
                 DW_AT_prototyped        (true)
                 DW_AT_type      (0x053c46b5 "ZSTD_symbolEncodingTypeStats_t")
                     
0x053c4bc6:     DW_TAG_formal_parameter
                   DW_AT_location        (indexed (0x8e8) loclist = 0x00e1597f:
                      [0xffffffff828bce99, 0xffffffff828bcf3d): DW_OP_reg4 RSI
                      [0xffffffff828bcf3d, 0xffffffff828bd045): DW_OP_reg12 R12
                      [0xffffffff828bd045, 0xffffffff828bd562): DW_OP_breg7 RSP+40
                      [0xffffffff828bd5bd, 0xffffffff828bdb0e): DW_OP_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value
                      [0xffffffff828bdb0e, 0xffffffff828bdbdc): DW_OP_breg7 RSP+40
                      [0xffffffff828bdbdc, 0xffffffff828bdbff): DW_OP_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value
                      [0xffffffff828bdbff, 0xffffffff828bdcfd): DW_OP_breg7 RSP+40
                      [0xffffffff828bdcfd, 0xffffffff828bde6d): DW_OP_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value)
                   DW_AT_name    ("seqStorePtr")
                   DW_AT_decl_file       ("/home/yhs/work/bpf-next/lib/zstd/compress/zstd_compress.c")
                   DW_AT_decl_line       (2678)
                   DW_AT_type    (0x053c4697 "const SeqStore_t *")
                 
0x053c4bd2:     DW_TAG_formal_parameter
                   DW_AT_location        (indexed (0x8e9) loclist = 0x00e159d4:
                      [0xffffffff828bce99, 0xffffffff828bcec1): DW_OP_reg1 RDX
                      [0xffffffff828bcec1, 0xffffffff828bd58b): DW_OP_breg7 RSP+72
                      [0xffffffff828bd5bd, 0xffffffff828bd5e8): DW_OP_breg7 RSP+72
                      [0xffffffff828bd61b, 0xffffffff828bd72d): DW_OP_breg7 RSP+72
                      [0xffffffff828bd76d, 0xffffffff828bd799): DW_OP_breg7 RSP+72
                      [0xffffffff828bd7cb, 0xffffffff828bd8d8): DW_OP_breg7 RSP+72
                      [0xffffffff828bd91b, 0xffffffff828bd943): DW_OP_breg7 RSP+72
                      [0xffffffff828bd974, 0xffffffff828bdafe): DW_OP_breg7 RSP+72
                      [0xffffffff828bdb0e, 0xffffffff828bde6d): DW_OP_breg7 RSP+72)
                   DW_AT_name    ("nbSeq")
                   DW_AT_decl_file       ("/home/yhs/work/bpf-next/lib/zstd/compress/zstd_compress.c")
                   DW_AT_decl_line       (2678)
                   DW_AT_type    (0x053be0a9 "size_t")
0x053c4bde:     DW_TAG_formal_parameter
                   DW_AT_location        (indexed (0x8ea) loclist = 0x00e15a36:
                      [0xffffffff828bce99, 0xffffffff828bcf0d): DW_OP_reg2 RCX
                      [0xffffffff828bcf0d, 0xffffffff828bd037): DW_OP_reg15 R15
                      [0xffffffff828bd037, 0xffffffff828bd58b): DW_OP_breg7 RSP+88
                      [0xffffffff828bd5bd, 0xffffffff828bd5e8): DW_OP_breg7 RSP+88
                      [0xffffffff828bd61b, 0xffffffff828bd72d): DW_OP_breg7 RSP+88
                      [0xffffffff828bd76d, 0xffffffff828bd799): DW_OP_breg7 RSP+88
                      [0xffffffff828bd7cb, 0xffffffff828bd8d8): DW_OP_breg7 RSP+88
                      [0xffffffff828bd91b, 0xffffffff828bd943): DW_OP_breg7 RSP+88
                      [0xffffffff828bd974, 0xffffffff828bdafe): DW_OP_breg7 RSP+88
                      [0xffffffff828bdb0e, 0xffffffff828bde6d): DW_OP_breg7 RSP+88)
                   DW_AT_name    ("prevEntropy")
                   DW_AT_decl_file       ("/home/yhs/work/bpf-next/lib/zstd/compress/zstd_compress.c")
                   DW_AT_decl_line       (2679)
                   DW_AT_type    (0x053c46a1 "const ZSTD_fseCTables_t *")

0x053c4bea:     DW_TAG_formal_parameter
                   DW_AT_location        (indexed (0x8eb) loclist = 0x00e15aa1:
                      [0xffffffff828bce99, 0xffffffff828bceb9): DW_OP_reg8 R8
                      [0xffffffff828bceb9, 0xffffffff828bd58b): DW_OP_breg7 RSP+48
                      [0xffffffff828bd5bd, 0xffffffff828bd5e8): DW_OP_breg7 RSP+48
                      [0xffffffff828bd61b, 0xffffffff828bd72d): DW_OP_breg7 RSP+48
                      [0xffffffff828bd76d, 0xffffffff828bd799): DW_OP_breg7 RSP+48
                      [0xffffffff828bd7cb, 0xffffffff828bd8aa): DW_OP_breg7 RSP+48
                      [0xffffffff828bd91b, 0xffffffff828bda06): DW_OP_entry_value(DW_OP_reg8 R8), DW_OP_stack_value
                      [0xffffffff828bda06, 0xffffffff828bda86): DW_OP_breg7 RSP+48
                      [0xffffffff828bda86, 0xffffffff828bdb0e): DW_OP_entry_value(DW_OP_reg8 R8), DW_OP_stack_value
                      [0xffffffff828bdb0e, 0xffffffff828bdbfa): DW_OP_breg7 RSP+48
                      [0xffffffff828bdbfa, 0xffffffff828bdbff): DW_OP_entry_value(DW_OP_reg8 R8), DW_OP_stack_value
                      [0xffffffff828bdbff, 0xffffffff828bde15): DW_OP_breg7 RSP+48
                      [0xffffffff828bde15, 0xffffffff828bde6d): DW_OP_entry_value(DW_OP_reg8 R8), DW_OP_stack_value)
                   DW_AT_name    ("nextEntropy")
                   DW_AT_decl_file       ("/home/yhs/work/bpf-next/lib/zstd/compress/zstd_compress.c")
                   DW_AT_decl_line       (2679)
                   DW_AT_type    (0x053c46ab "ZSTD_fseCTables_t *")

...

In this example, signature is not changed with compiler optimization so there does not have 'nocall'.
But the corresponding registers do not conform ABI's. So we have to reject such functions in BTF.

