Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBD413777E;
	Tue, 16 Jun 2026 04:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781582817; cv=none; b=SDSDbXCAHC0jCKvQhxxDj60KnB4u5S03k8Ug7LrjZ7G6nMEYMHyynzqLOzmexwrpSgf9f2KRS/6zfll+oCXPE51oDchSPioT/nR3B2LnKMsMYfHj3ojas62ikul4jaYn+Q5Kj9pU/+2qqXf7kwaaykEKeBCp7E7GNwMdd4RWAgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781582817; c=relaxed/simple;
	bh=Pj6RjeROqlAnNK/PPMQJJvR5uQR1Sp0iWb3vsHF5I4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UtsPlTCfgidAywJ9II93LPQzhBosR85pNy8Gf3hgwCeHR7irVtf41z6o4biHZaCQ3o0NES6Up0LqFDJUgyrdiGsuMdEifuf54vMgIBkHMPxNQFIylHSZOo3+FYXMx19PVr5JHveTp5MVJ8i7Bu4tzMNgyMuTZ7TqPK3kdqvgXaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nWszITv7; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nWszITv7"
Message-ID: <bfa1e3a0-515f-4c08-ae53-469003d5509c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781582812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rdV/J46DH9/5jvehz571UOxEQLGpCsaQFxCHqaToNkg=;
	b=nWszITv7/M2HR9wMzcmSDjGyDZ5XpAyABGSIs2PX3M53MvRTUO5iKoQ0r/NBG5MrONjNFD
	N8vyPXJHn/H2EFWfctzXCTWZBDXjM7z0ao0C95p4v6yrmz1D6Wmhfb1Lf+Hj0Z34fmWwyP
	finLt+N2wf8+qh4Gg/yu25fSoKnwBOg=
Date: Mon, 15 Jun 2026 21:06:48 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves v5 00/11] pahole: Encode true signatures in kernel
 BTF
Content-Language: en-GB
To: Alan Maguire <alan.maguire@oracle.com>,
 Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, kernel-team@fb.com
References: <20260523165712.1225231-1-yonghong.song@linux.dev>
 <84234995-4664-4f03-81fe-38b22482a319@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <84234995-4664-4f03-81fe-38b22482a319@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/15/26 10:17 AM, Alan Maguire wrote:
> On 23/05/2026 17:57, Yonghong Song wrote:
>> Current vmlinux BTF encoding is based on the source level signatures.
>> But the compiler may do some optimization and changed the signature.
>> If the user tried with source level signature, their initial implementation
>> may have wrong results and then the user need to check what is the
>> problem and work around it, e.g. through kprobe since kprobe does not
>> need vmlinux BTF.
>>
>> Majority of changed signatures are due to dead argument elimination.
>> The following is a more complex one. The original source signature:
>>    typedef struct {
>>          union {
>>                  void            *kernel;
>>                  void __user     *user;
>>          };
>>          bool            is_kernel : 1;
>>    } sockptr_t;
>>    typedef sockptr_t bpfptr_t;
>>    static int map_create(union bpf_attr *attr, bpfptr_t uattr) { ... }
>> After compiler optimization, the signature becomes:
>>    static int map_create(union bpf_attr *attr, bool uattr__is_kernel) { ... }
>> In the above, uattr__is_kernel corresponds to 'is_kernel' field in sockptr_t.
>> This makes it easier for developers to understand what changed.
>>
>> The new signature needs to properly follow ABI specification based on
>> locations. Otherwise, that signature should be discarded. For example,
>>
>>      0x0242f1f7:   DW_TAG_subprogram
>>                      DW_AT_name      ("memblock_find_in_range")
>>                      DW_AT_calling_convention        (DW_CC_nocall)
>>                      DW_AT_type      (0x0242decc "phys_addr_t")
>>                      ...
>>      0x0242f22e:     DW_TAG_formal_parameter
>>                        DW_AT_location        (indexed (0x14a) loclist = 0x005595bc:
>>                           [0xffffffff87a000f9, 0xffffffff87a00178): DW_OP_reg5 RDI
>>                           [0xffffffff87a00178, 0xffffffff87a001be): DW_OP_reg14 R14
>>                           [0xffffffff87a001be, 0xffffffff87a001c7): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
>>                           [0xffffffff87a001c7, 0xffffffff87a00214): DW_OP_reg14 R14)
>>                        DW_AT_name    ("start")
>>                        DW_AT_type    (0x0242decc "phys_addr_t")
>>                        ...
>>      0x0242f239:     DW_TAG_formal_parameter
>>                        DW_AT_location        (indexed (0x14b) loclist = 0x005595e6:
>>                           [0xffffffff87a000f9, 0xffffffff87a00175): DW_OP_reg4 RSI
>>                           [0xffffffff87a00175, 0xffffffff87a001b8): DW_OP_reg3 RBX
>>                           [0xffffffff87a001b8, 0xffffffff87a001c7): DW_OP_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value
>>                           [0xffffffff87a001c7, 0xffffffff87a00214): DW_OP_reg3 RBX)
>>                        DW_AT_name    ("end")
>>                        DW_AT_type    (0x0242decc "phys_addr_t")
>>                        ...
>>      0x0242f245:     DW_TAG_formal_parameter
>>                        DW_AT_location        (indexed (0x14c) loclist = 0x00559610:
>>                           [0xffffffff87a001e3, 0xffffffff87a001ef): DW_OP_breg4 RSI+0)
>>                        DW_AT_name    ("size")
>>                        DW_AT_type    (0x0242decc "phys_addr_t")
>>                        ...
>>      0x0242f250:     DW_TAG_formal_parameter
>>                        DW_AT_const_value     (4096)
>>                        DW_AT_name    ("align")
>>                        DW_AT_type    (0x0242decc "phys_addr_t")
>>                        ...
>>
>> The third argument should correspond to RDX for x86_64. But the location suggests that
>> the parameter value is stored in the address with 'RSI + 0'. It is not clear whether
>> the parameter value is stored in RDX or not. So we have to discard this funciton in
>> vmlinux BTF to avoid incorrect true signatures.
>>
>> For llvm, any function having
>>    DW_AT_calling_convention        (DW_CC_nocall)
>> in dwarf DW_TAG_subprogram will indicate that this function has signature changed.
>> I did experiment with latest bpf-next. For x86_64, there are 69103 kernel functions
>> and 875 kernel functions having signature changed. A series of patches are intended
>> to ensure true signatures are properly represented. Eventually, only 18 functions
>> cannot have true signatures due to locations.
>>
>> For arm64, there are 863 kernel functions having signature changed, and
>> 70 functions cannot have true signatures due to locations. I checked those
>> functions and look like llvm arm64 backend more relaxed to compute parameter
>> values.
>>
>> For full testing, I enabled true signature support in kernel scripts/Makefile.btf like below:
>>    -pahole-flags-$(call test-ge, $(pahole-ver), 130) += --btf_features=attributes
>>    +pahole-flags-$(call test-ge, $(pahole-ver), 130) += --btf_features=attributes --btf_features=+true_signature
>>
>> For the patch set, Patch 1 introduced usage of DW_AT_calling_convention, which
>> can precisely identify which function has signature changed. This can filter
>> majority of functions where their signature won't change. Patch 2 did a prescan
>> of parameter registers to accommodate some cases where the optimization could
>> happen but didn't. Patches 3 to 9 tried to find functions with true signature.
>> Patch 10 enables to btf encoder to properly generate BTF.
>> Patch 11 includes a few tests.
>>
>> Changelog:
>>    v4 -> v5:
>>      - v4: https://lore.kernel.org/bpf/20260326013144.2901265-1-yonghong.song@linux.dev/
>>      - Check info.signature_changed only under clang.
>>      - Fix an uninitialized varable issue (var reg_dix) for gcc.
>>    v3 -> v4:
>>      - v3: https://lore.kernel.org/bpf/20260320190917.1970524-1-yonghong.song@linux.dev/
>>      - Add simple prescan of parameter registers in order to get true signatures
>>        for those functions where optimization could happen but compiler didn't do it.
>>      - Do not create a new name (e.g. "uattr__is_kernel") with malloc at parameter_reg()
>>        stage. Instead remember both "uattr" and "is_kernel" and later generate the
>>        name "uattr_is_kernel" in btf encoder.
>>      - Add comments to explain how to handle parameters which may take two registers.
>>      - Fix some test failures on aarch64.
>>    v2 -> v3:
>>      - v2: https://lore.kernel.org/bpf/20260309153215.1917033-1-yonghong.song@linux.dev/
>>      - Change tests by using newly added test_lib.sh.
>>      - Simplify to get bool variable producer_clang.
>>      - Try to avoid producer_clang appearance in dwarf_loader.c in order to avoid
>>        clear separation between clang and gcc.
>>    v1 -> v2:
>>      - v1: https://lore.kernel.org/bpf/20260305225455.1151066-1-yonghong.song@linux.dev/
>>      - Added producer_clang guarding in btf_encoder. Otherwise, gcc kernel build
>>        will crash pahole.
>>      - Fix an early return in parameter__reg() which didn't do pthread_mutex_unlock()
>>        which caused the deadlock for arm64.
>>      - Add a few more places to guard with producer_clang and conf->true_signature
>>        to maintain the previous behavior if not clang or conf->true_signature is false.
>>
> In order to be a bit more concrete about a proposed way forward, I'm thinking something
> along the lines of the attached patch (which should apply on top of this whole series);
> rather than doing prescans etc, we record param info as we go as we do today, and once done
> compute true signature info. This saves some complexity around prescan of params etc, so
> is a bit more  consistent with what's there today. Ideally we'd be able to enhance DWARF
> processing for both cases (you have some great improvements in that area in this series),
> and unify the representation of modified signatures where feasible. Let me know what you think.

Thanks Alan! I agree that we should have as much common codes as possible for clang and gcc.
I will check and try to understand your new patch. If everything is fine, I will incorporate
this patch into the patch series.

Yonghong

>
> Thanks!
>
> Alan

