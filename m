Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6711C19D8A8
	for <dwarves@vger.kernel.org>; Wed, 24 Jun 2026 01:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782265542; cv=none; b=cjQ4hlMnRsxYSAdox9ccFBo3aIrUnjinZSLy5vTXJaRKt0gZiHdcklA4Cv5bupMhfQ/j4DDcSZi83bPaQhU1LGsGSDls7Pr3FwuEdSD8Vf/amfVL9fcmwgCwPXvnpGmcOXmyJRiQDZlXBXoe16MwWMqjPT0C68dwIJM8Zn6cDTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782265542; c=relaxed/simple;
	bh=CngTVle8YDcuOTJdYITzR0b8sLOqOysx2B7lKtSiKkg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RMwOQqdJ0LMPYbkkNXKeYnaQdbVvwmZ96/ehFl0QzqA7O/ymibYHZBYk8612efGmgFNE9cnqmeSWfTWjqg4xZr/jDDGbq5x1y1VF6ZOoBAvT5fqm+xsdgJudwWxUwtKRp8UB2psqhrdeOi60wcJ2DLW5RXBsShd84/lAy96Oby8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FsJjBbmp; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FsJjBbmp"
Message-ID: <5d332838-8f41-43f7-9509-ec97dcbb0578@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782265529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7quBymQv6qig28yFts2+yXJkHxS0N3Z7ODbIG7Vxt8Y=;
	b=FsJjBbmpxqDSJl59dI8pzd4XeKDt9Dbva3CIHnOy8e4tJihSRaQOVd+XlbK/umYfsBCGvk
	DWBybJPRyTla+vOmtqGe2Wm+j1w5aVvKr4pdZemokvQpx7DZyVJkwkHgwmMOk4VmP5Hyf3
	1MgqY6YC1x6w7lO8zN6GGVoB8X+v2Os=
Date: Tue, 23 Jun 2026 18:45:17 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves v8 4/5] btf_encoder: Emit true function signatures
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
 Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, kernel-team@fb.com
References: <20260623222850.3290612-1-yonghong.song@linux.dev>
 <20260623222911.3294083-1-yonghong.song@linux.dev>
In-Reply-To: <20260623222911.3294083-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/23/26 3:29 PM, Yonghong Song wrote:
> When true_signature is enabled, consume the per-parameter analysis the
> DWARF loader recorded while saving a function's BTF:
>   - Drop parameters that were optimized out of a signature-changed function
>     (cu->producer_clang && param->optimized), adjusting the saved
>     parameter count accordingly.
>   - When a parameter was reduced to a single aggregate member
>     (param->true_sig_member_name is set), emit it under the synthesized name
>     "<parameter>__<member>" so the BTF reflects the value actually passed in
>     the register.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>   btf_encoder.c | 26 +++++++++++++++++++++++++-
>   1 file changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/btf_encoder.c b/btf_encoder.c
> index d5af706..eb6ccaa 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -1297,14 +1297,38 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
>   	state->reordered_parm = ftype->reordered_parm;
>   	ftype__for_each_parameter(ftype, param) {
>   		const char *name;
> +		char *final_name = NULL;
>   
>   		/* No location info/optimized + reordered means optimized out. */
>   		if (ftype->reordered_parm && (!param->has_loc || param->optimized)) {
>   			state->nr_parms--;
>   			continue;
>   		}
> -		name = parameter__name(param) ?: "";
> +		if (encoder->true_signature && encoder->cu->producer_clang && param->optimized) {
> +			state->nr_parms--;
> +			continue;
> +		}
> +
> +		name = parameter__name(param);
> +		if (!name) {
> +			name = "";
> +		} else if (encoder->true_signature &&
> +			   encoder->cu->producer_clang &&
> +			   param->true_sig_member_name) {
> +			/* Non-null param->true_sig_member_name indicates that the parameter
> +			 * name is <parameter_name>__<field_name>.
> +			 */
> +			if (asprintf(&final_name, "%s__%s", name, param->true_sig_member_name) == -1) {
> +				err = -ENOMEM;
> +				goto out;
> +			}
> +			name = final_name;
> +		}
> +
>   		str_off = btf__add_str(btf, name);
> +		if (final_name)
> +			free(final_name);
> +
>   		if (str_off < 0) {
>   			err = str_off;
>   			goto out;

Find another issue in this file, not related to the above.
Just give a simple example for

static inline void io_file_bitmap_set(struct io_file_table *table, int bit)
{
         WARN_ON_ONCE(test_bit(bit, table->bitmap));
         __set_bit(bit, table->bitmap);
         table->alloc_hint = bit + 1;
}

It is in a header file io_uring/filetable.h.

We have inlined subprogram:

0x04fb6857:   DW_TAG_subprogram
                 DW_AT_name      ("io_file_bitmap_set")
                 DW_AT_decl_file ("/home/yhs/work/bpf-next/io_uring/filetable.h")
                 DW_AT_decl_line (29)
                 DW_AT_prototyped        (true)
                 DW_AT_inline    (DW_INL_inlined)
                       
0x04fb685c:     DW_TAG_formal_parameter
                   DW_AT_name    ("table")
                   DW_AT_decl_file       ("/home/yhs/work/bpf-next/io_uring/filetable.h")
                   DW_AT_decl_line       (29)
                   DW_AT_type    (0x04fb6885 "io_file_table *")
                            
0x04fb6865:     DW_TAG_formal_parameter
                   DW_AT_name    ("bit")
                   DW_AT_decl_file       ("/home/yhs/work/bpf-next/io_uring/filetable.h")
                   DW_AT_decl_line       (29)
                   DW_AT_type    (0x04fa5103 "int")

and

0x04fb77d8:   DW_TAG_subprogram
                 DW_AT_low_pc    (0xffffffff8273d430)
                 DW_AT_high_pc   (0xffffffff8273d50c)
                 DW_AT_frame_base        (DW_OP_reg7 RSP)
                 DW_AT_call_all_calls    (true)
                 DW_AT_abstract_origin   (0x04fb6857 "io_file_bitmap_set")
                   
0x04fb77e5:     DW_TAG_formal_parameter
                   DW_AT_location        (indexed (0x11f) loclist = 0x00d4bcf7:
                      [0xffffffff8273d430, 0xffffffff8273d45c): DW_OP_reg5 RDI
                      [0xffffffff8273d45c, 0xffffffff8273d4c3): DW_OP_reg3 RBX
                      [0xffffffff8273d4c3, 0xffffffff8273d4e6): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
                      [0xffffffff8273d4e6, 0xffffffff8273d4f6): DW_OP_reg3 RBX
                      [0xffffffff8273d4f6, 0xffffffff8273d50c): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value)
                   DW_AT_abstract_origin (0x04fb685c "table")
                   
0x04fb77ec:     DW_TAG_formal_parameter
                   DW_AT_location        (indexed (0x120) loclist = 0x00d4bd23:
                      [0xffffffff8273d430, 0xffffffff8273d464): DW_OP_reg4 RSI
                      [0xffffffff8273d464, 0xffffffff8273d50c): DW_OP_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value)
                   DW_AT_abstract_origin (0x04fb6865 "bit")

0x04ff5f5e:   DW_TAG_subprogram
                 DW_AT_name      ("io_file_bitmap_set")
                 DW_AT_decl_file ("/home/yhs/work/bpf-next/io_uring/filetable.h")
                 DW_AT_decl_line (29)
                 DW_AT_prototyped        (true)
                 DW_AT_inline    (DW_INL_inlined)
                      
0x04ff5f63:     DW_TAG_formal_parameter
                   DW_AT_name    ("table")
                   DW_AT_decl_file       ("/home/yhs/work/bpf-next/io_uring/filetable.h")
                   DW_AT_decl_line       (29)
                   DW_AT_type    (0x04ff5f59 "io_file_table *")

0x04ff5f6c:     DW_TAG_formal_parameter
                   DW_AT_name    ("bit")
                   DW_AT_decl_file       ("/home/yhs/work/bpf-next/io_uring/filetable.h")
                   DW_AT_decl_line       (29)
                   DW_AT_type    (0x04fe77c6 "int")

I get the following error:

+io_file_bitmap_set : skipping BTF encoding of function due to param count mismatch; 2 params != 0 params
+io_file_bitmap_set : skipping BTF encoding of function due to inconsistet prototype

How do we resolve the issue like this?

If this is hard, we can try to resolve as a follow-up.

