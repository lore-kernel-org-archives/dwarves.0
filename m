Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9035A349CFD
	for <dwarves@vger.kernel.org>; Mon, 22 Jun 2026 19:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782157238; cv=none; b=cZU7IazY2VwEQdEFd5QVBD7CM/PDKW/reutQAxaXuwrpkNr+jwqS0RAtODyfNB3pt4CqACcgdyislVSDg6wWx5RrMV0WQ8WPYPZes7apiyzmhpr6dNy5Novnuhh1lq00pyKrizEoQkjqeULqQcYrvfo7NxANm0QHt7nodH2dgw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782157238; c=relaxed/simple;
	bh=6IM2ydXiMTWVlkMwZc5XhD9aMvIdoyOpBuCY8vr5e5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nvyHrl/DBz7qBtOXhCokt/39ilRuj3CZ9/S3bruZzSLhe9FC/wQlmgb/2RWZXkDYXShpFwFBu4U9bhdP7WvNGeQKBnxsout7YX3En28uUSLY3SC2oJlr+x7wcE3F6/ULsKaEz7grqmmyq+KibcCmg8H6rR5j2LMWtyJdEqR4DHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GyxATqeL; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GyxATqeL"
Message-ID: <5606057a-aeae-494b-9c7d-939e92a41ce9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782157224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IySzVHuPMQunEP1lWUZJvG3UyiwnMSyhTa1J0FUz/Ts=;
	b=GyxATqeL9ZItl/d5N+59sAxX9EmFSQ+9FsCIIMqRAKdNzthMpVNaVKWqBTQIGYaMY6Yxv7
	tY84X4F2AI2xm9fx2aW7diltWU0lHDN3R0gDNW3q9L/rNMgIvfsuuTWNSaXnYfKGMmDehO
	6poYIQFeldTMHuRT8dxHfW1C7wTI4Wo=
Date: Mon, 22 Jun 2026 12:40:01 -0700
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
 <d63e4e38-6059-442f-b128-69fad20cab32@linux.dev>
 <9bc04946-81ce-4c24-bbc3-178a01fe6381@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <9bc04946-81ce-4c24-bbc3-178a01fe6381@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/22/26 1:14 AM, Alan Maguire wrote:
> On 21/06/2026 17:47, Yonghong Song wrote:
>>
>> On 6/20/26 1:46 AM, Alan Maguire wrote:
>>> On 18/06/2026 02:13, Yonghong Song wrote:
>>>> Current vmlinux BTF encoding is based on the source level signatures.
>>>> But the compiler may do some optimization and changed the signature.
>>>> If the user tried with source level signature, their initial implementation
>>>> may have wrong results and then the user need to check what is the
>>>> problem and work around it, e.g. through kprobe since kprobe does not
>>>> need vmlinux BTF.
>>>>
>>>> Majority of changed signatures are due to dead argument elimination.
>>>> The following is a more complex one. The original source signature:
>>>>     typedef struct {
>>>>           union {
>>>>                   void            *kernel;
>>>>                   void __user     *user;
>>>>           };
>>>>           bool            is_kernel : 1;
>>>>     } sockptr_t;
>>>>     typedef sockptr_t bpfptr_t;
>>>>     static int map_create(union bpf_attr *attr, bpfptr_t uattr) { ... }
>>>> After compiler optimization, the signature becomes:
>>>>     static int map_create(union bpf_attr *attr, bool uattr__is_kernel) { ... }
>>>> In the above, uattr__is_kernel corresponds to 'is_kernel' field in sockptr_t.
>>>> This makes it easier for developers to understand what changed.
>>>>
>>>> The new signature needs to properly follow ABI specification based on
>>>> locations. Otherwise, that signature should be discarded. For example,
>>>>
>>>>       0x0242f1f7:   DW_TAG_subprogram
>>>>                       DW_AT_name      ("memblock_find_in_range")
>>>>                       DW_AT_calling_convention        (DW_CC_nocall)
>>>>                       DW_AT_type      (0x0242decc "phys_addr_t")
>>>>                       ...
>>>>       0x0242f22e:     DW_TAG_formal_parameter
>>>>                         DW_AT_location        (indexed (0x14a) loclist = 0x005595bc:
>>>>                            [0xffffffff87a000f9, 0xffffffff87a00178): DW_OP_reg5 RDI
>>>>                            [0xffffffff87a00178, 0xffffffff87a001be): DW_OP_reg14 R14
>>>>                            [0xffffffff87a001be, 0xffffffff87a001c7): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
>>>>                            [0xffffffff87a001c7, 0xffffffff87a00214): DW_OP_reg14 R14)
>>>>                         DW_AT_name    ("start")
>>>>                         DW_AT_type    (0x0242decc "phys_addr_t")
>>>>                         ...
>>>>       0x0242f239:     DW_TAG_formal_parameter
>>>>                         DW_AT_location        (indexed (0x14b) loclist = 0x005595e6:
>>>>                            [0xffffffff87a000f9, 0xffffffff87a00175): DW_OP_reg4 RSI
>>>>                            [0xffffffff87a00175, 0xffffffff87a001b8): DW_OP_reg3 RBX
>>>>                            [0xffffffff87a001b8, 0xffffffff87a001c7): DW_OP_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value
>>>>                            [0xffffffff87a001c7, 0xffffffff87a00214): DW_OP_reg3 RBX)
>>>>                         DW_AT_name    ("end")
>>>>                         DW_AT_type    (0x0242decc "phys_addr_t")
>>>>                         ...
>>>>       0x0242f245:     DW_TAG_formal_parameter
>>>>                         DW_AT_location        (indexed (0x14c) loclist = 0x00559610:
>>>>                            [0xffffffff87a001e3, 0xffffffff87a001ef): DW_OP_breg4 RSI+0)
>>>>                         DW_AT_name    ("size")
>>>>                         DW_AT_type    (0x0242decc "phys_addr_t")
>>>>                         ...
>>>>       0x0242f250:     DW_TAG_formal_parameter
>>>>                         DW_AT_const_value     (4096)
>>>>                         DW_AT_name    ("align")
>>>>                         DW_AT_type    (0x0242decc "phys_addr_t")
>>>>                         ...
>>>>
>>>> The third argument should correspond to RDX for x86_64. But the location suggests that
>>>> the parameter value is stored in the address with 'RSI + 0'. It is not clear whether
>>>> the parameter value is stored in RDX or not. So we have to discard this funciton in
>>>> vmlinux BTF to avoid incorrect true signatures.
>>>>
>>>> For llvm, any function having
>>>>     DW_AT_calling_convention        (DW_CC_nocall)
>>>> in dwarf DW_TAG_subprogram will indicate that this function has signature changed.
>>>> I did experiment with latest bpf-next. For x86_64, there are 69103 kernel functions
>>>> and 875 kernel functions having signature changed. A series of patches are intended
>>>> to ensure true signatures are properly represented. Eventually, only 20 functions
>>>> cannot have true signatures due to locations.
>>>>
>>>> For arm64, there are 863 kernel functions having signature changed, and
>>>> 108 functions cannot have true signatures due to locations. I checked those
>>>> functions and look like llvm arm64 backend more relaxed to compute parameter
>>>> values.
>>>>
>>>> For full testing, I enabled true signature support in kernel scripts/Makefile.btf like below:
>>>>     -pahole-flags-$(call test-ge, $(pahole-ver), 131) += --btf_features=attributes
>>>>     +pahole-flags-$(call test-ge, $(pahole-ver), 131) += --btf_features=attributes --btf_features=+true_signature
>>>>
>>>> See individual patches for details.
>>>>
>>> hi Yonghong, changes look good but we do hit a CI issue; specifically
>>> in run_selftests in [1] for gcc+aarch64:
>>>
>>> 3: clang_parm_aggregate.sh
>>> Validation of BTF encoding of true_signatures.
>>>      On arm64, BTF and DWARF signatures should be the same but they are not: BTF: long foo(struct t a__f1, struct t b, int i); ; DWARF long foo(struct t a, struct t b, int i);
>>> Test ./clang_parm_aggregate.sh failed
>>> Test data is in /tmp/clang_parm_aggregate.sh.NH5a6D
>>>
>>> I think the problem is that as well as creating aggregate parameter names we
>>> need to decide whether they should actually be used; in this case it looks like
>>> we hit a function using aggregates, but without DW_CC_nocall. Perhaps the
>>> reason is that the calling conventions are preserved while we only get a piece
>>> of the "struct t a" argument? Something like [2] seems to resolve the problem,
>>> please take a look and feel free to roll the fix into one of the patches if it makes
>>> sense. You might find it convenient to use the merges of your series at [3]; they
>>> merge your work with Vineet's tag changes now that they have landed (just patch 1
>>> required merging IIRC).
>> On my arm64 machine, I run ./clang_parm_aggregate.sh and can reproduce your failure.
>> In v5, it does work with llvm23. Probalby due to compiler and/or pahole change in v6,
>> the test failed. The following can fix the issue (I tested with llvm22 and development
>> llvm23):
>>
>> diff --git a/tests/clang_parm_aggregate.sh b/tests/clang_parm_aggregate.sh
>> index 9502f8b..339cd19 100755
>> --- a/tests/clang_parm_aggregate.sh
>> +++ b/tests/clang_parm_aggregate.sh
>> @@ -58,7 +58,7 @@ verbose_log "BTF: $btf_optimized  DWARF: $dwarf"
>>   
>>   arch=$(uname -m)
>>   
>> -if [[ "$arch" == "x86_64" ]]; then
>> +if [[ "$arch" == "x86_64" || "$arch" == "aarch64" ]]; then
>>          # On x86_64, clang emits DW_CC_nocall for optimized functions,
>>          # so pahole should detect the optimization and produce a
>>          # different BTF signature.
>> @@ -66,14 +66,6 @@ if [[ "$arch" == "x86_64" ]]; then
>>                  error_log "BTF and DWARF signatures should be different and they are not: BTF: $btf_optimized ; DWARF $dwarf"
>>                  test_fail
>>          fi
>> -elif [[ "$arch" == "aarch64" ]]; then
>> -       # On arm64, clang does not emit DW_CC_nocall, so pahole cannot
>> -       # detect the optimization. BTF and DWARF signatures are expected
>> -       # to be the same.
>> -       if [[ "$btf_cmp" != "$dwarf" ]]; then
>> -               error_log "On arm64, BTF and DWARF signatures should be the same but they are not: BTF: $btf_optimized ; DWARF $dwarf"
>> -               test_fail
>> -       fi
>>   else
>>          # On other architectures, skip if we cannot determine the
>>          # expected behavior.
>>
>> Currently, my test mostly on llvm23. I will test with llvm22 as well and push another
>> revision after your CI with llvm22 land.
>>
> Great, those CI changes have landed now in pahole so you should be good to go.
>
> I think the problem I was seeing was we got some of the effect of your changes
> (renaming of parameters due to partial parameter) in the absence of DW_CC_nocall.
> This raises a question for me; if the function register usage does not change -
> matches calling conventions (meaning no DW_CC_nocall I think) - but we do get a
> partial parameter from DWARF, should the parameter name still change to
> reflect we only have a piece of the parameter?

Thanks for raising this question. Now I think we do have issues in pahole.
In v5, I have

+       /* Both halves are used based on dwarf */
+       if (first_half && second_half)
+               return PARM_TWO_ADDR_LEN;
+
+       /* Only one half is used. Check if the next parameter's starting register
+        * indicates the ABI still reserves the full register space for this
+        * parameter. If so, the compiler only eliminated the dead half but the
+        * register layout is preserved — keep the original source type.
+        *
+        * Use register_params[] array for the expected next register since
+        * DW_OP_reg numbers are not necessarily sequential across architectures.
+        */
+       if (param_idx + 1 < info->nr_params) {
+               int next_start = info->param_start_regs[param_idx + 1];
+
+               if (next_start >= 0) {
+                       int num_regs = (byte_size + cu->addr_size - 1) / cu->addr_size;
+                       int next_reg_idx = reg_idx + num_regs;
+
+                       if (next_reg_idx < cu->nr_register_params &&
+                           next_start == cu->register_params[next_reg_idx])
+                               return PARM_TWO_ADDR_LEN;
+               }
+       }

Basically, e.g. for a 16 byte struct, only the first (or the second) 8-byte
is used, e.g. register RDI. But checking expected next register is RDX, in
this case, we should preserve the original type for the 16 byte struct. So
the above change in v5 is correct.

But for v6, we had two issues:
   1. we should have the same check_registers condition in parameter__new and
      function__analyze_parameter_locations(). Otherwise, we may have issues.
      For example, for the following function:

struct t { long f1; long f2; };
__attribute__((noinline)) static long foo(struct t a, struct t b, int i)
{
         return a.f1 + b.f1 + b.f2 + i;
}

      at parameter__new stage, pahole decides that 'struct t a' should be 'int a__f1'.

      But for the above function foo(), clang decided signature changed is false
      since 'struct t a' is for RDI, and 'struct t b' is for RDX, and
      function__analyze_parameter_locations() didn't do anything and later
      in btf_encoder.c, a__f1 is used but it is incorrect.

   2. In parameter__new() phase, some struct parameter (e.g., the above struct t a)
      may have optional name a__f1 for future use. Then in analysis stage,
      if analysis decides to use the original type, we will need to set
      pos->true_sig_member_name = 0 so later in btf_encoder can use the original name.

I will fix these issues and fix/add related selftests as well. Something like:

  static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
-                                       struct conf_load *conf, int param_idx)
+                                       struct conf_load *conf, struct ftype *ftype, int param_idx)
  {
         struct parameter *parm = tag__alloc(cu, sizeof(*parm));
  
         if (parm != NULL) {
                 Dwarf_Attribute attr;
+               bool true_sig_enabled, check_registers;
  
                 tag__init(&parm->tag, cu, die);
                 parm->name = attr_string(die, DW_AT_name, conf);
                 parm->idx = param_idx;
+               if (!ftype)
+                       return parm;
+
+               true_sig_enabled = conf->true_signature && ftype->signature_changed;
+               check_registers = !cu->producer_clang || true_sig_enabled;
+               if (!check_registers)
+                       return parm;
+
                 parm->loc_reg = PARAMETER_UNKNOWN_REG;
                 parm->type_byte_size = get_type_byte_size(die, cu);
                 parm->passed_in_memory = parm->type_byte_size >
@@ -1592,7 +1601,7 @@ static int formal_parameter_pack__load_params(struct formal_parameter_pack *pack
                         continue;
                 }
  
-               struct parameter *param = parameter__new(die, cu, conf, -1);
+               struct parameter *param = parameter__new(die, cu, conf, NULL, -1);
  
                 if (param == NULL)
                         return -1;
@@ -2136,7 +2145,7 @@ static struct tag *die__create_new_parameter(Dwarf_Die *die,
                                              struct cu *cu, struct conf_load *conf,
                                              int param_idx)
  {
-       struct parameter *parm = parameter__new(die, cu, conf, param_idx);
+       struct parameter *parm = parameter__new(die, cu, conf, ftype, param_idx);
  
         if (parm == NULL)
                 return NULL;
@@ -3153,8 +3162,12 @@ static void function__analyze_parameter_locations(struct function *fn, struct cu
                         }
  
                         if (true_sig_enabled && parameter__has_piece_info(pos)) {
-                               if (parameter__uses_full_aggregate(pos) ||
-                                   ftype__next_parameter_preserves_slots(ftype, pos, reg_idx, slots, cu)) {
+                               if (parameter__uses_full_aggregate(pos)) {
+                                       reg_idx += slots;
+                                       continue;
+                               }
+                               if (ftype__next_parameter_preserves_slots(ftype, pos, reg_idx, slots, cu)) {
+                                       pos->true_sig_member_name = 0;
                                         reg_idx += slots;
                                         continue;
                                 }

