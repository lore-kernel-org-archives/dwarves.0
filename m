Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3FD3803E2
	for <dwarves@vger.kernel.org>; Fri, 27 Mar 2026 19:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774640330; cv=none; b=ldTtv/O97COyOg+MY4yAvLq9ffCaSbGw2DLH37W5wwM2WgbKC72D78iIif9rZC15Sdk48SDr6YJgMgjs86SQGYXRppFfWNrylZm2BxjKwKu5TPJ3dp+0hkZLhEeEjVdUrHXASOaUBehOBQvWK9jshS71zkBdrtyc+l18GdL9CEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774640330; c=relaxed/simple;
	bh=0im2CGMYpM9hDYRNKyTHzBwYkMnd3N/tZGwFK9k+a+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DMvj+s5H7qlCoyrvPwNNb+CTDJnIQwDbMzHUticvwErm24hbWWyPxmwXk0oJx6YqBd4YxXinKy8/x2KulQkW9iy/s0xT7xffMxsWStRBTibRizDZb6Z5Taovw25nDBtD8p+jeK+ab2uCWQadJftisoqxFuOsGX6ZusMH/qZN9ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fKeH9Fxo; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fKeH9Fxo"
Message-ID: <8424ac77-a469-4064-bfca-542d671d5ea6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774640319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zP/c15LEKgs8vQ2sNu9JwixZXRAeOTCb6undKWETxN0=;
	b=fKeH9FxoDwDvj/DW+KEUSI/Hd4LKdbcH7nRrafD3IjsqRjiG0OA9WSfCkCehhdzPvnojJo
	9JxI1gUDNIAgDXqikCevYVscK92L7e2Z6H1txyGnkoIC3bzLXmGIAQ3DZifZl+g/14EDjJ
	g8dx+Auew9FM9EnCXHoOT7czxnYi81c=
Date: Fri, 27 Mar 2026 12:38:27 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves v4 00/11] pahole: Encode true signatures in kernel
 BTF
To: Alan Maguire <alan.maguire@oracle.com>,
 Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, kernel-team@fb.com
References: <20260326013144.2901265-1-yonghong.song@linux.dev>
 <c2143369-7b31-45d2-9c34-ae311582e074@oracle.com>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <c2143369-7b31-45d2-9c34-ae311582e074@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 3/27/26 9:02 AM, Alan Maguire wrote:
> On 26/03/2026 01:31, Yonghong Song wrote:
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
> I'm looking through this now, but FYI the test run with clang kernel build
> is passing now, great work! The log [1] shows 23 additional functions for
> clang kernel builds (see the "Compare functiokns generated" step). Interestingly
> it shows a few additional functions for x86_64 too, I suspect a side effect of
> better handling of parameter location info, but I need to confirm:
>
> ### Compare vmlinux BTF functions generated with this change vs baseline (none means no differences).
> 1345a1346
>> void __do_notify(struct mqueue_inode_info * info);

It would be great if both this change and baseline are showed. For example, for this __do_notify() function.
The kernel source:
   static void __do_notify(struct mqueue_inode_info *info) { ... }

The dwarf generated by clang23 build:

0x04442f84:   DW_TAG_subprogram
                 DW_AT_low_pc    (0xffffffff82409720)
                 DW_AT_high_pc   (0xffffffff82409db7)
                 DW_AT_frame_base        (DW_OP_call_frame_cfa, DW_OP_consts -128, DW_OP_plus)
                 DW_AT_call_all_calls    (true)
                 DW_AT_name      ("__do_notify")
                 DW_AT_decl_file ("/home/yhs/work/bpf-next/ipc/mqueue.c")
                 DW_AT_decl_line (777)
                 DW_AT_prototyped        (true)
                     
0x04442f98:     DW_TAG_formal_parameter
                   DW_AT_location        (indexed (0x19d) loclist = 0x00c7000c:
                      [0xffffffff82409725, 0xffffffff82409763): DW_OP_reg5 RDI
                      [0xffffffff82409763, 0xffffffff82409ac6): DW_OP_reg3 RBX
                      [0xffffffff82409ac6, 0xffffffff82409b01): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
                      [0xffffffff82409b01, 0xffffffff82409cdf): DW_OP_reg3 RBX
                      [0xffffffff82409cdf, 0xffffffff82409ce4): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
                      [0xffffffff82409ce4, 0xffffffff82409db7): DW_OP_reg3 RBX)
                   DW_AT_name    ("info")
                   DW_AT_decl_file       ("/home/yhs/work/bpf-next/ipc/mqueue.c")
                   DW_AT_decl_line       (777)
                   DW_AT_type    (0x0443d068 "mqueue_inode_info *")

The function __do_notify() does not have nocall attribute so the signature should
be preserved as the original.

> 4994a4996
>> int __vxlan_fdb_delete(struct vxlan_dev * vxlan, const unsigned char  * addr, union vxlan_addr ip, __be16 port, __be32 src_vni, __be32 vni, u32 ifindex, bool swdev_notify);

__vxlan_fdb_delete is a global function. See the signature:

int __vxlan_fdb_delete(struct vxlan_dev *vxlan,
                        const unsigned char *addr, union vxlan_addr ip,
                        __be16 port, __be32 src_vni, __be32 vni,
                        u32 ifindex, bool swdev_notify)
{ ... }

and dwarf

0x06c44a41:   DW_TAG_subprogram
                 DW_AT_low_pc    (0xffffffff82fa0aa0)
                 DW_AT_high_pc   (0xffffffff82fa0f9a)
                 DW_AT_frame_base        (DW_OP_reg7 RSP)
                 DW_AT_call_all_calls    (true)
                 DW_AT_name      ("__vxlan_fdb_delete")
                 DW_AT_decl_file ("/home/yhs/work/bpf-next/drivers/net/vxlan/vxlan_core.c")
                 DW_AT_decl_line (1273)
                 DW_AT_prototyped        (true)
                 DW_AT_type      (0x06c21271 "int")
                 DW_AT_external  (true)

So there should have no difference. Again, it would be great to show both base and this patch set.

> 15185a15188
>> int devlink_nl_param_value_put(struct sk_buff * msg, enum devlink_param_type type, int nla_type, union devlink_param_value val, bool flag_as_u8);
> 18862a18866
>> struct cpio_data find_microcode_in_initrd(const char  * path);
> 48240a48245
>> struct dst_entry * xfrm6_dst_lookup(const struct xfrm_dst_lookup_params  * params);
> I'll push the CI change to enable clang builds so we have it by default from now on.
>
> [1] https://github.com/alan-maguire/dwarves/actions/runs/23638670169
>   

Sounds good. Thanks!

