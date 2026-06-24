Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5533F35BDDB
	for <dwarves@vger.kernel.org>; Wed, 24 Jun 2026 21:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782334838; cv=none; b=VrNtCw5QhcJ4u4jY4EksyxGM004lztRtHJPRd5g3YNi0Ac9Ek6U8H1hA/jvCsN6nNlhKTD7sUmkSzBcbcsaUuRmaHbmp2lEQxl65gpGJeNJh0+yMccRkC/7zY5UWBzIZ7hWEAcIxKpEJiB3dwwdAWYPkmqXi5pdJPZBqEyGAD98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782334838; c=relaxed/simple;
	bh=jSX/+we71gT/FAoOFjra2Y3ZAfhf1BEIOKPLxIlRDo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iv/XSesMotwhZmkmePeS8h90NRTO2d9PUzQPguoKDD9cWEQJqJojVMGbJAxtbdjoBDXQ/zXrF2wpILkE10kD0zaSXfrIM72ucOlqgqQCJMZ0huc1HBBNSiRBdWO0mWp7+ORirl/Drj9MCV2K6C6dA52mgGULF5Pk+cNhba2954E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gahCdmHG; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gahCdmHG"
Message-ID: <9207f019-d487-411f-aef0-ec1fd1c333d5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782334831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=poMj/lTGnyus1ycsazo95hUVAvFIbVBej8hEUyTNjoY=;
	b=gahCdmHGwAanjHfRTcLH3YS+arEV+7/IDpMMxaEujYNdTUIUkSpgzdwqKkGRKNYlk3sRHu
	xFwQwAcfx5mu3wgXLUgYfDGEGghP/MpVBblC6n/0ZxSBla2l0hlSA1ZDKwKFqYgcDtFNjS
	2yyggDyoNMjN9FhG9YdZUliqt5YBOKk=
Date: Wed, 24 Jun 2026 14:00:10 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves v9 0/6] pahole: Encode true signatures in kernel
 BTF
To: Alan Maguire <alan.maguire@oracle.com>,
 Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, kernel-team@fb.com
References: <20260624052553.3139112-1-yonghong.song@linux.dev>
 <9f594fec-7044-44a8-8d92-10aaffbd5bbe@oracle.com>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <9f594fec-7044-44a8-8d92-10aaffbd5bbe@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/24/26 10:59 AM, Alan Maguire wrote:
> On 24/06/2026 06:25, Yonghong Song wrote:
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
>> But for non DW_CC_nocall functions, it is possible that true signature still not
>> available due to locations. So every functions will be checked.
>>
>> I did experiment with latest bpf-next. For x86_64, there are 69103 kernel functions
>> and 875 kernel functions having signature changed. A series of patches are intended
>> to ensure true signatures are properly represented. Eventually, only 20 functions
>> cannot have true signatures due to locations.
>>
>> For arm64, there are 863 kernel functions having signature changed, and
>> 108 functions cannot have true signatures due to locations. I checked those
>> functions and look like llvm arm64 backend more relaxed to compute parameter
>> values.
>>
>> For full testing, I enabled true signature support in kernel scripts/Makefile.btf like below:
>>    -pahole-flags-$(call test-ge, $(pahole-ver), 131) += --btf_features=attributes
>>    +pahole-flags-$(call test-ge, $(pahole-ver), 131) += --btf_features=attributes --btf_features=+true_signature
>>
>> See individual patches for details.
>>
> Seeing a new CI failure [1] with this series in the btf_functions test for clang (x86_64/aarch64):
>
> 1: btf_functions.sh
> Validation of BTF encoding of functions.
>     This may take some time.
> libbpf: STRUCT 'elf_note_info' size=248 vlen=8 cand_id[1195975] canon_id[1193376] shallow-equal but not equiv for field#0 'thread': 0
>     ERROR: mismatch : BTF 'void btf_verifier_log_vsi(struct btf_verifier_env *, const struct btf_type *, const struct btf_var_secinfo *, const char *, ...);' not found; DWARF ''
> Test ./btf_functions.sh failed
> Test data is in /tmp/btf_functions.sh.v9s3w4
>   
> The test does not run with true signature enabled, and I think the problem here
> is that previously this function would have been skipped. So it may be true signature
> leaking into non-true signature behaviour but I'm not 100%
>
> [1] https://github.com/alan-maguire/dwarves/actions/runs/28104464362/job/83214808300#step:7:12

The issue seems due to patch:
    btf_encoder: Avoid comparing inlined and out-of-line function prototypes
Taking the above patch out, ./btf_functions.sh runs successfully:

$ ./btf_functions.sh
vmlinux:/home/yhs/work/linux-bld/vmlinux
outdir:/tmp/btf_functions.sh.sXwgqd
Validation of BTF encoding of functions.
    This may take some time.
libbpf: STRUCT 'elf_note_info' size=248 vlen=8 cand_id[1405697] canon_id[1403135] shallow-equal but not equiv for field#0 'thread': 0
libbpf: STRUCT 'pt_iommu_map_args' size=48 vlen=6 cand_id[3100130] canon_id[3098170] shallow-equal but not equiv for field#1 'attrs': 0
Test ./btf_functions.sh passed

So the patch 'btf_encoder: Avoid comparing inlined and out-of-line function prototypes'
needs change and need more careful reviews. I will remove it in the next revision.

>
>> Changelog:
>>    v8 -> v9:
>>      - v8: https://lore.kernel.org/bpf/20260623222850.3290612-1-yonghong.song@linux.dev/
>>      - v8 made a mistake where all functions go through main loop in
>>        function__analyze_parameter_locations(). This is not correct as it includes functions
>>        whose signature is not changed. See function
>>        function__match_clang_parameter_locations().
>>      - Add a change in btf_encoder to avoid comparing inlined and out-of-line function prototypes.
>>        This allows some functions to be in btf.
>>      - Add one more test, clang_parm_optimized_stack_2, where a global function, with
>>        many unused parameters, gets properly handling in location checking.
>>    v7 -> v8:
>>      - v7: https://lore.kernel.org/bpf/20260623040704.2732530-1-yonghong.song@linux.dev/
>>      - Both Check and Analyze phases go through all functions.
>>      - Require true_signature in btf_encoder to have name like <paramName>__<field>.
>>      - Remove signature_changed (from nocall). It is possible that function signatures
>>        are not changed but the location reigsters do not match.
>>    v6 -> v7:
>>      - v6: https://lore.kernel.org/bpf/20260618011358.632394-1-yonghong.song@linux.dev/
>>      - Ensure that 'collect' and 'analyze' have the same location checking.
>>      - In 'analyze' stage, undo true_sig_member_name if the next expected register
>>        matches the previous source type although the previous parameter may
>>        only use half of the value.
>>    v5 -> v6:
>>      - v5: https://lore.kernel.org/bpf/20260523165712.1225231-1-yonghong.song@linux.dev/
>>      - The previous change relies on parameter__new() to collect and analyze each
>>        parameter to decide true signatures. The new one separates collecting and
>>        analyzing phase from Alan. This two-phase makes logic easy to understand.
>>      - In btf_encoder.c, remove usage of skip_idx to simplify the code.
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
>> Yonghong Song (6):
>>    dwarf_loader: Detect aggregate ABI register usage and signature
>>      changes
>>    dwarf_loader: Collect per-parameter information
>>    dwarf_loader: Analyze per-parameter information for true signatures
>>    btf_encoder: Emit true function signatures
>>    btf_encoder: Avoid comparing inlined and out-of-line function
>>      prototypes
>>    tests: Add BTF true_signature encoding tests
>>
>>   btf_encoder.c                         |  53 ++-
>>   dwarf_loader.c                        | 603 +++++++++++++++++++++++---
>>   dwarves.h                             |  14 +
>>   tests/clang_parm_aggregate_1.sh       |  85 ++++
>>   tests/clang_parm_aggregate_2.sh       |  88 ++++
>>   tests/clang_parm_memory.sh            |  77 ++++
>>   tests/clang_parm_optimized.sh         |  63 +++
>>   tests/clang_parm_optimized_stack_1.sh |  63 +++
>>   tests/clang_parm_optimized_stack_2.sh |  63 +++
>>   9 files changed, 1042 insertions(+), 67 deletions(-)
>>   create mode 100755 tests/clang_parm_aggregate_1.sh
>>   create mode 100755 tests/clang_parm_aggregate_2.sh
>>   create mode 100755 tests/clang_parm_memory.sh
>>   create mode 100755 tests/clang_parm_optimized.sh
>>   create mode 100755 tests/clang_parm_optimized_stack_1.sh
>>   create mode 100755 tests/clang_parm_optimized_stack_2.sh
>>

