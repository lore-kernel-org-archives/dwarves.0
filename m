Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A7E242D70
	for <dwarves@vger.kernel.org>; Sun, 21 Jun 2026 16:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782060482; cv=none; b=qrVTtg1r/bW3hG979+n2Rb/v5/c8n69gO13jB7GSQFFSuMin0anDcpdgS894JVU+x+GbVk4ztfSHLRXAi/e6oxV7w0lKGnKCLitjNEi3Mya4z7p8WUjCJL53kJjIfNYEmvF2dJMOra8ha9J0OhZj8KttZjpokFgqf4uNoMvpL2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782060482; c=relaxed/simple;
	bh=heY+LUKoXTW/iI+BxFfgLKpKtksKXWBj78o0KfVJeCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gbeus7L+vwXAlS+RQuItuJQoikEsWuBPOxzj9ZjHY5pKs19DWqp0X1mc3VEkgzLrsloCOpz6cnnWs2vT8N1NHWoF8g96Q6wDZvx5YZQH+y2/bBQrMeUpeSC2Rb6AH6K3B+OasO+QdCq//MkrwANhf099aNHz6pFGhcvfhQv4FpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vRDQmjCs; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vRDQmjCs"
Message-ID: <d63e4e38-6059-442f-b128-69fad20cab32@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782060477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pIr4aXz/6fWvxJ4UnvhOdPxHzOVUFl0F5c0PFUnapsY=;
	b=vRDQmjCsdYxA0p9KnCcKaEmU4tsNyt/hWbdDfW+mh2TFrxhVNgkSeplYs4EcColhhUM0wo
	CU3WycLbA6pyKtNwdB6Q0PlFDxyrIHnFR2Af5TPDuViqDRPm+AFb9lni5lusFsczetdaZJ
	tIokRSgfLU9XdhEDraZDdQ0s485Ov/g=
Date: Sun, 21 Jun 2026 09:47:46 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves v6 0/5] pahole: Encode true signatures in kernel
 BTF
Content-Language: en-GB
To: Alan Maguire <alan.maguire@oracle.com>,
 Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, kernel-team@fb.com
References: <20260618011358.632394-1-yonghong.song@linux.dev>
 <675af05f-6f76-4a37-9619-5275fb941263@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <675af05f-6f76-4a37-9619-5275fb941263@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/20/26 1:46 AM, Alan Maguire wrote:
> On 18/06/2026 02:13, Yonghong Song wrote:
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
> hi Yonghong, changes look good but we do hit a CI issue; specifically
> in run_selftests in [1] for gcc+aarch64:
>
> 3: clang_parm_aggregate.sh
> Validation of BTF encoding of true_signatures.
>     On arm64, BTF and DWARF signatures should be the same but they are not: BTF: long foo(struct t a__f1, struct t b, int i); ; DWARF long foo(struct t a, struct t b, int i);
> Test ./clang_parm_aggregate.sh failed
> Test data is in /tmp/clang_parm_aggregate.sh.NH5a6D
>
> I think the problem is that as well as creating aggregate parameter names we
> need to decide whether they should actually be used; in this case it looks like
> we hit a function using aggregates, but without DW_CC_nocall. Perhaps the
> reason is that the calling conventions are preserved while we only get a piece
> of the "struct t a" argument? Something like [2] seems to resolve the problem,
> please take a look and feel free to roll the fix into one of the patches if it makes
> sense. You might find it convenient to use the merges of your series at [3]; they
> merge your work with Vineet's tag changes now that they have landed (just patch 1
> required merging IIRC).

On my arm64 machine, I run ./clang_parm_aggregate.sh and can reproduce your failure.
In v5, it does work with llvm23. Probalby due to compiler and/or pahole change in v6,
the test failed. The following can fix the issue (I tested with llvm22 and development
llvm23):

diff --git a/tests/clang_parm_aggregate.sh b/tests/clang_parm_aggregate.sh
index 9502f8b..339cd19 100755
--- a/tests/clang_parm_aggregate.sh
+++ b/tests/clang_parm_aggregate.sh
@@ -58,7 +58,7 @@ verbose_log "BTF: $btf_optimized  DWARF: $dwarf"
  
  arch=$(uname -m)
  
-if [[ "$arch" == "x86_64" ]]; then
+if [[ "$arch" == "x86_64" || "$arch" == "aarch64" ]]; then
         # On x86_64, clang emits DW_CC_nocall for optimized functions,
         # so pahole should detect the optimization and produce a
         # different BTF signature.
@@ -66,14 +66,6 @@ if [[ "$arch" == "x86_64" ]]; then
                 error_log "BTF and DWARF signatures should be different and they are not: BTF: $btf_optimized ; DWARF $dwarf"
                 test_fail
         fi
-elif [[ "$arch" == "aarch64" ]]; then
-       # On arm64, clang does not emit DW_CC_nocall, so pahole cannot
-       # detect the optimization. BTF and DWARF signatures are expected
-       # to be the same.
-       if [[ "$btf_cmp" != "$dwarf" ]]; then
-               error_log "On arm64, BTF and DWARF signatures should be the same but they are not: BTF: $btf_optimized ; DWARF $dwarf"
-               test_fail
-       fi
  else
         # On other architectures, skip if we cannot determine the
         # expected behavior.

Currently, my test mostly on llvm23. I will test with llvm22 as well and push another
revision after your CI with llvm22 land.

>
> I also think it would be better to add clang+aarch64 to the CI matrix in light of
> your changes, since it will give us test coverage for changed functions for clang
> for both x86_64 and aarch64; I've sent [4] to do that.
>
> [1] https://github.com/alan-maguire/dwarves/actions/runs/27839367799/job/82394707921#step:7:24
> [2] https://github.com/acmel/dwarves/commit/22d0512680d2ff5b6dd4d1e34ae603efe0f2d098
> [3] https://github.com/alan-maguire/dwarves/commits/dwarves-true-sig-v6/
> [4] https://lore.kernel.org/dwarves/20260620083056.361658-1-alan.maguire@oracle.com/
>
[...]

