Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38951A59
	for <dwarves@vger.kernel.org>; Thu,  4 Dec 2025 00:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764809191; cv=none; b=U0nyYR92xYKrrvMqARtncx/Fv7gVIqeRBS2hVPh/vIYV6avoRMTXXvOODZsAgS5TXuo1G17oMEVnspXYszBhBycyMsqrfAmLeOEJQmrzjQa1gHkY5wLjn1O2pvvghbthxg2rX9yjkBPQoBLPCwhahC9I+Dy4ivLsSAP0dbQ4M+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764809191; c=relaxed/simple;
	bh=O9lCepUFyiFQhV+JfSqxljP14/ZlyBPPTic5vGt8sts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j00yaFJSLDGR4662MCcXo2PrlZFKGYHASYJk8jhXoT2HIhfSaojw9RAdGCvbe2youBzcx3Q780tezYVc7mbEqVPMOQ3T/iw1tpYupWqMGER977X7+dUgk6Qq5/sjw4KRs0r2e64SCNISDx80PZCOCfqN8rbtNb4nPMwhBm1/kWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wkWWdEwm; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wkWWdEwm"
Message-ID: <a3f82302-09d2-45e1-a30a-38a32ddbf947@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764809185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k6JHds8XMJ+hVeqN4FjGaiDKtJ7waBDwAQRlYzhEcrY=;
	b=wkWWdEwmBpn0njT+7sNbFdjptxMFi3RvKDHSPPiBN/iPLjNRdiBuGPLlm1K0q5yPJOGFQY
	N0HHxlVNcN9j9yviZOmqgKjIjF+SKzA6CQje6WtJJW124BtfajKdd+h2NH+5feAT4jVSq3
	w0bblqjaAl5WKB70dOKK0lgGJ1/v1ww=
Date: Wed, 3 Dec 2025 16:46:20 -0800
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves] dwarf_loader: Handle DW_AT_location attrs
 containing DW_OP_plus_uconst
Content-Language: en-GB
To: Yao Zi <ziyao@disroot.org>, Alan Maguire <alan.maguire@oracle.com>
Cc: dwarves@vger.kernel.org, bpf@vger.kernel.org, q66 <me@q66.moe>
References: <20251130032113.4938-2-ziyao@disroot.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20251130032113.4938-2-ziyao@disroot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 11/29/25 7:21 PM, Yao Zi wrote:
> LLVM has a GlobalMerge pass, which tries to group multiple global
> variables together and address them with through a single register with
> offsets coded in instructions, to reduce register pressure. Address of
> symbols transformed by the pass may be represented by an DWARF
> expression consisting of DW_OP_addrx and DW_OP_plus_uconst, which
> naturally matches the way a merged variable is addressed.
>
> However, our dwarf_loader currently ignores anything but the first in
> the location expression, including the DW_OP_plus_uconst atom, which
> appears the second operation in this case. This could result in broken
> BTF information produced by pahole, where several merged symbols are
> given the same offset, even though in fact they don't overlap.
>
> LLVM has enabled MergeGlobal pass for PowerPC[1] and RISC-V[2] by
> default since version 20, let's handle DW_OP_plus_uconst operations in
> DW_AT_location attributes correctly to ensure correct BTF could be
> produced for LLVM-built kernels.
>
> Fixes: a6ea527aab91 ("variable: Add ->addr member")
> Reported-by: q66 <me@q66.moe>
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2089
> Link: https://github.com/llvm/llvm-project/commit/aaa37d6755e6 # [1]
> Link: https://github.com/llvm/llvm-project/commit/9d02264b03ea # [2]
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>
> The problem is found by several distros building Linux kernel with LLVM
> and BTF enabled, after upgrading to LLVM 20 or later, kernels built for
> RISC-V and PowerPC issue errors like
>
> [    1.296358] BPF:      type_id=4457 offset=4224 size=8
> [    1.296767] BPF:
> [    1.296919] BPF: Invalid offset
>
> on startup, and loading any modules fails with -EINVAL unless
> CONFIG_MODULE_ALLOW_BTF_MISMATCH is turned on,
>
> # insmod tun.ko
> [   12.892421] failed to validate module [tun] BTF: -22
> [   12.936971] failed to validate module [tun] BTF: -22
> insmod: can't insert 'tun.ko': Invalid argument
>
> By comparing DWARF dump and BTF dump, it's found BTF contains symbols
> with the same offset,
>
> type_id=4148 offset=4208 size=8 (VAR 'vector_misaligned_access')
> type_id=4147 offset=4208 size=8 (VAR 'misaligned_access_speed')
>
> while the same symbols are described with different DW_AT_location
> attributes,
>
> 0x0011ade7:   DW_TAG_variable
>                  DW_AT_name      ("misaligned_access_speed")
>                  DW_AT_type      (0x0011adf2 "long")
> 		DW_AT_decl_file	("...")
>                  DW_AT_external  (true)
>                  DW_AT_decl_line (24)
>                  DW_AT_location  (DW_OP_addrx 0x0)
>
> ...
>
> 0x0011adf6:   DW_TAG_variable
>                  DW_AT_name      ("vector_misaligned_access")
>                  DW_AT_type      (0x0011adf2 "long")
>                  DW_AT_external  (true)
>                  DW_AT_decl_file ("...")
>                  DW_AT_decl_line (25)
>                  DW_AT_location  (DW_OP_addrx 0x0, DW_OP_plus_uconst 0x8)
>
> For more detailed analysis and kernel config for reproducing the issue,
> please refer to the Closes link. Thanks for your time and review.
>
>   dwarf_loader.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 79be3f516a26..635015676389 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -708,6 +708,11 @@ static enum vscope dwarf__location(Dwarf_Die *die, uint64_t *addr, struct locati
>   		case DW_OP_addrx:
>   			scope = VSCOPE_GLOBAL;
>   			*addr = expr[0].number;
> +
> +			if (location->exprlen == 2 &&
> +			    expr[1].atom == DW_OP_plus_uconst)
> +				addr += expr[1].number;

This does not work. 'addr' is the parameter and the above new 'addr' value won't
pass back to caller so the above is effectively a noop.

I think we need to add an additional parameter to pass the 'expr[1].number' back
to the caller, e.g.,

static enum vscope dwarf__location(Dwarf_Die *die, uint64_t *addr, uint32_t *offset, struct location *location) { ... }

and

    in the above
        *offset = expr[1].number.

Now the caller has the following information:
   . The deference of *addr stores the index to .debug_addr
   . The offset to the address in .debug_addr
and the final address will be debug_addr[*addr] + offset.


> +
>   			break;
>   		case DW_OP_reg1 ... DW_OP_reg31:
>   		case DW_OP_breg0 ... DW_OP_breg31:

