Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED3F3382C3
	for <dwarves@vger.kernel.org>; Sun, 22 Mar 2026 17:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774200983; cv=none; b=sT6o/Hkg3jzio0zqyuLIVmpjTOX2omncmNQnKqRu0HWPvYvfDPdoZDSCIafzMYmuTEb6g9tPC0oCnkjHvsm4BG4iY3XROOq6h9smmEsXDmZDqXQqIu57iLr6yZVEzR8qhUmKVUooqC/0YNcLg8aPzV82iRHXQ4RuGQOxFcljpoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774200983; c=relaxed/simple;
	bh=82ZxUAZcmNBU6wZ1Lb/CNq5PgzsWJD14mGWVWneVuwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b1D6z0QN45uiffzLAqsBsMZzjkg7w5vWPJEWy24LlxTBXTZbdnwBOQDOMd9SlLXjMY2ZqhPjqMCTskguEnPkzyKABnaH77E170PQLwEyDdZwE6SZ8Jd+hVoVP3ltb4dOPctvs0G7wxPN1r/YkTYvRXTmRIMVwd6JNnP325yHrLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uazEQU4G; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uazEQU4G"
Message-ID: <2c9260b9-0eb3-416b-a75f-f33f37be6b63@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774200973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yxe5CWU+eDGkL6k5XfqteyqTp3illiA3mbY2G0EXX54=;
	b=uazEQU4GtdsszsUjy8Z8QJy/Kl/5+IMHKMLlkj6oJRKqgfxp3n7YIxpPtphr5e3xCbbNgL
	2S8OUqOGG4jae3WSsO09mJox60QTsU7/j4BpVUJacbm8oHwND6hg7SnkajkaIwmTkJ4AyB
	xKP5g5rmwJXeZVlvs3ebxDXC+awCQ7w=
Date: Sun, 22 Mar 2026 10:36:01 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves v3 1/9] dwarf_loader: Reduce parameter checking
 with clang DW_AT_calling_convention attr
Content-Language: en-GB
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
 Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, dwarves@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, kernel-team@fb.com
References: <20260320190917.1970524-1-yonghong.song@linux.dev>
 <20260320190922.1970709-1-yonghong.song@linux.dev> <ab8lWhTT8LZGbtQs@krava>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <ab8lWhTT8LZGbtQs@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 3/21/26 4:10 PM, Jiri Olsa wrote:
> On Fri, Mar 20, 2026 at 12:09:22PM -0700, Yonghong Song wrote:
>> Currently every function is checked for its parameters to identify whether
>> the signature changed or not. If signature indeed changed, pahole may do
>> some adjustment for parameters for true signatures.
>>
>> In clang, any function with the following attribute
>>        DW_AT_calling_convention        (DW_CC_nocall)
>> indicates this function having signature changed.
>> pahole can take advantage of this to avoid parameter checking if
>> DW_AT_calling_convention is not DW_CC_nocall.
>>
>> But more importantly, DW_CC_nocall can identify signature-changed functions
>> and parameters can be checked one-after-another to create the true
>> signatures. Otherwise, it takes more effort to identify whether a
>> function has signature changed or not. For example, for funciton
>>    __bpf_kfunc static void bbr_main(struct sock *sk, u32 ack, int flag,
>>       const struct rate_sample *rs) { ... }
>> and bbr_main() is a callback function in
>>    .cong_control   = bbr_main
>> in 'struct tcp_congestion_ops tcp_bbr_cong_ops'.
>> In the above bbr_main(...), parameter 'ack' and 'flag' are not used.
>> The following are some details:
>>
>> 0x0a713b8d:     DW_TAG_formal_parameter
>>                    DW_AT_location        (indexed (0x28) loclist = 0x0166d452:
>>                       [0xffffffff83e77fd9, 0xffffffff83e78016): DW_OP_reg5 RDI
>>                       ...
>>                    DW_AT_name    ("sk")
>>                    DW_AT_type    (0x0a6f5b2b "sock *")
>>                    ...
>>
>> 0x0a713b98:     DW_TAG_formal_parameter
>>                    DW_AT_name    ("ack")
>>                    DW_AT_type    (0x0a6f58fd "u32")
>>                    ...
>>
>> 0x0a713ba2:     DW_TAG_formal_parameter
>>                    DW_AT_name    ("flag")
>>                    DW_AT_type    (0x0a6f57d1 "int")
>>                    ...
>>
>> 0x0a713bac:     DW_TAG_formal_parameter
>>                    DW_AT_location        (indexed (0x29) loclist = 0x0166d4a8:
>>                       [0xffffffff83e77fd9, 0xffffffff83e78016): DW_OP_reg2 RCX
>>                       ...
>>                    DW_AT_name    ("rs")
>>                    DW_AT_type    (0x0a710da5 "const rate_sample *")
>>                    DW_AT_decl_line       (1027)
>>
>> Some analysis for the above dwarf can conclude that the 'ark' and 'flag'
>> may be related to RSI and RDX, considering the last one is RCX. Basically this
>> requires all parameters are available to collectively decide whether the
>> true signature can be found or not. In such case, DW_CC_nocall can make things
>> easier as parameter can be checked one after another.
>>
>> For a clang built bpf-next kernel, in non-LTO setup, the number of kernel functions
>> is 69103 and the number of signature changed functions is 875, based on
>>        DW_AT_calling_convention        (DW_CC_nocall)
>> indication.
> we don't display these stats, right? would be great and probably easy
> to count different flags and aggregate them

The actual stats will be different depending on kernel code and compiler optimization.
But I think I can still count them for each commit so people will know
which change caused how much true signature.

>
>> Among 875 signature changed functions, after this patch, 495 functions
>> can have proper true signatures, mostly due to simple dead argument
>> elimination. The number of remaining functions, which cannot get the
>> true signature, is 379. They will be addressed in the subsequent commits.
> after this change I have more functions added (below) and I checked
> few and they seem ok (w/o DW_CC_nocall)

Most global functions should be okay. But some global functions
esp. if argument is more than 8 byte (struct type), they may be
considered as signature change with the current implementation.

>
> jirka
>
>
> acpi_ex_do_debug_object
> add_bits
> amd_pstate_get_mode_string
> dma_alloc_from_contiguous
> do_set_pmd
> dst_destroy
> find_cpio_data
> find_microcode_in_initrd
> ima_write_policy
> insn_init
> io_tx_ubuf_complete
> ip6_protocol_deliver_rcu
> kvm_tdp_mmu_unmap_gfn_range
> net_dim_get_def_rx_moderation
> net_dim_get_def_tx_moderation
> pinctrl_commit_state
> string_unescape
> syscall_copy_user_array
> tdp_mmu_zap_leafs
> usb_speed_string
> __vlan_find_dev_deep_rcu
> __vxlan_fdb_delete
> xfs_bmbt_maxrecs
> xfs_inobt_maxrecs
> ZSTD_buildSequencesStatistics
> ZSTD_copyCCtx
> ZSTD_findFrameSizeInfo
> ZSTD_get1BlockSummary
> zstd_get_cparams
> ZSTD_getCParams
> ZSTD_getCParamsFromCCtxParams
> ZSTD_getCParamsFromCDict
> ZSTD_getCParams_internal
> zstd_get_params
> ZSTD_getParams

