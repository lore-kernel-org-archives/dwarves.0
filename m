Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6B33911BC;
	Wed,  3 Jun 2026 21:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780522885; cv=none; b=uwWH7rrv3tDkhNjhfbMEj/JoCjQXvrlPYHY+2VibrsL1uXJXCD0uKVg7DRplUf5I71qYTzpXgCUxRRqzQp4gT+BgrXG7o/3+2fsfgvuupfX5L+jmXfZJjKvN4KcuOpZHX6/AdRdO20lpmYGYkoSNC9mcHKz+BOgQyNaWTsEU5mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780522885; c=relaxed/simple;
	bh=paNw1FdSihJNknh365CgnLOARQ+FzMcLCwyPKqRPvX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D/Zao6PtwJ0LssGf03BpOBZ2ovduad43EdR/BXUT1gPrWV365xTlzCIr0RFeltjL+H8+Hmi8l8RRAZfPngIp2lWttiYl7xlJOYpwPPQncgAv2/4VRYneEm8YvrPtEAuq2n7DGv8jwavlNRoVjTlHws88tX5WjZV6Zh9sAPKpmTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MbfLJi5e; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MbfLJi5e"
Message-ID: <8ccb6133-2964-450c-9409-ac99e4d5300c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780522882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ipRvgil0U4e931XKU0W6qcnXGk8mgtmYBD7X+85HKOI=;
	b=MbfLJi5eQly1O9LnikX4O7Zj7BL1XlCckcdeKsJVEfjm5QTew719SzJnGjkN/eBlSv/M1I
	ahBKPX+GL3WFVdCmbMCzQD5U5JfP/AxnXd7REOA5oMYN9brz+1hqWLvNtq8BICIZ4ijio5
	+5GzMG+8o2so6CUzbPFrVvi6hwYNJRw=
Date: Wed, 3 Jun 2026 14:41:11 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PAHOLE v4 2/3] dwarf_loader: Add support for
 DW_TAG_GNU_annotation
Content-Language: en-GB
To: Vineet Gupta <vineet.gupta@linux.dev>, dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 acme@kernel.org, Alan Maguire <alan.maguire@oracle.com>,
 Emil Tsalapatis <emil@etsalapatis.com>, jose.marchesi@oracle.com,
 David Faust <david.faust@oracle.com>
References: <20260602195512.1511013-1-vineet.gupta@linux.dev>
 <20260602195512.1511013-2-vineet.gupta@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260602195512.1511013-2-vineet.gupta@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/2/26 12:55 PM, Vineet Gupta wrote:
> gcc 16 was the first release to support DW_TAG_GNU_annotations and this
> patch enables the same in pahole. Bulk of changes are dwarf_loader but
> btf_encoder also gains support with minimal changes.
>
> GCC encodes btf_type_tag and btf_decl_tag annotations differently from
> LLVM. While LLVM uses DW_TAG_LLVM_annotation (0x6000) as child DIEs,
> GCC uses DW_TAG_GNU_annotation (0x6001) as standalone sibling DIEs
> referenced via DW_AT_GNU_annotation (0x2139) attributes, with chaining
> through the same attribute on annotation DIEs themselves.
>
> Handle both encoding styles:
>
> For btf_type_tag (pointer annotations):
> - Recognize DW_TAG_GNU_annotation alongside DW_TAG_LLVM_annotation in
>    child annotation scanning.
> - Follow DW_AT_GNU_annotation attribute chains on pointer types for
>    GCC-style btf_type_tag resolution.
> - Normalize DW_TAG_GNU_annotation to DW_TAG_LLVM_annotation in the
>    internal representation so downstream code works unchanged.
>
> For btf_decl_tag (function/struct/member annotations):
> - Add add_gnu_annotation_chain() to follow DW_AT_GNU_annotation
>    attribute chains on function, struct, and member DIEs.
> - GCC puts DW_AT_GNU_annotation on the function/struct DIE itself
>    (not as child DIEs), referencing sibling annotation DIEs that chain
>    via the same attribute.
>
> Also:
> - Silently skip standalone DW_TAG_GNU_annotation DIEs at CU level.
> - Add tag__is_annotation() helper macro for annotation tag checks.
> - Rename add_llvm_annotation -> add_tag_annotation,
>    skip_llvm_annotations -> skip_tag_annotations since these now
>    handle both LLVM and GNU annotation formats.
>
> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>

LGTM except a nit below.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

[...]

> @@ -943,16 +948,40 @@ static int add_child_llvm_annotations(Dwarf_Die *die, int component_idx,
>   
>   	die = &child;
>   	do {
> -		if (dwarf_tag(die) == DW_TAG_LLVM_annotation) {
> -			ret = add_llvm_annotation(die, component_idx, conf, head);
> -			if (ret)
> -				return ret;
> -		}
> +		if (!die__tag_is_annotation(die))
> +			continue;
> +
> +		ret = add_tag_annotation(die, component_idx, conf, head);
> +		if (ret)
> +			return ret;
>   	} while (dwarf_siblingof(die, die) == 0);
>   
>   	return 0;
>   }
>   
> +/*
> + * Handle gcc style btf_decl_tag annotations for functions/struct/member tags.

For 'struct', gcc is not supported yet.

> + * Pointers are handled separately, inline in die__create_new_pointer_tag()
> + */
> +static int add_gnu_annotation_chain(Dwarf_Die *die, int component_idx,
> +				    struct conf_load *conf, struct list_head *head)
> +{
> +	Dwarf_Attribute attr;
> +	Dwarf_Die annot_die;
> +
> +	while (dwarf_attr(die, DW_AT_GNU_annotation, &attr) != NULL &&
> +	       dwarf_formref_die(&attr, &annot_die) != NULL &&
> +	       dwarf_tag(&annot_die) == DW_TAG_GNU_annotation) {
> +		int ret = add_tag_annotation(&annot_die, component_idx, conf, head);
> +		if (ret)
> +			return ret;
> +
> +		die = &annot_die;
> +	}
> +
> +	return 0;
> +}
> +
>
[...]

