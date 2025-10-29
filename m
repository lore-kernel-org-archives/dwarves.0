Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D290F2C21F0
	for <dwarves@vger.kernel.org>; Wed, 29 Oct 2025 20:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761770959; cv=none; b=pa3Q52d+gRLmaENx4YM+AIh0XgVq552BqNXfv7WRRY44ZbjgDgwz9xOn4przA+lm6az7dlWoTu3q4gSuqhcEraDnTZfpHvN/TDcmXq9MjqI5w5mYE49GD1q6HduPQPmyBmmJRdjS0ERyqdzGQay2uXM3PyVp7osiL/3H5MJ0H1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761770959; c=relaxed/simple;
	bh=Ne6N52DmWPfwpe8MA0V4Vbi7U9EnIOX89Tn/yyGBwpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XliDQp0ginurpnSDqxai25OS8Hou1HYrmKhyagfgevMfVGKdY3u8shPnGNIbjCx3/PEDrja2W+Io+XN9lcpca9pN3J0hxp1TmpIQxYs3Au+kddvhHeeQgvW6Zt6KCUkYw6OaoY1tmaWHP8drcEE5quf0MWsx5K4kQdZ7V0rEq0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xio+SCDx; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xio+SCDx"
Message-ID: <c974f5ed-b6d2-4716-a119-7efab07e2e8e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761770953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MAKz5OOMYGoJBDkuis9FSO26FtkXgNsy1VkFfK6LLdo=;
	b=xio+SCDxXBrourJ1ohaByqH3ZxBNykhGg0AUQeUhGQlbArzU+41E6kSuKbZBi2na/x1sbm
	+pTriLhJbiRzZSrRAexnZjXgPF8UlPW8w7AbpBpMcOUb1WLEJMbw0uTyldDaOKg1jaebam
	bsx2mCkg5pCGu3v4+eODf5dVkzDeOsw=
Date: Wed, 29 Oct 2025 13:49:03 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 3/8] bpf: Support for kfuncs with
 KF_MAGIC_ARGS
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, andrii@kernel.org,
 ast@kernel.org
Cc: dwarves@vger.kernel.org, alan.maguire@oracle.com, acme@kernel.org,
 eddyz87@gmail.com, tj@kernel.org, kernel-team@meta.com,
 daniel@iogearbox.net, martin.lau@kernel.org, yonghong.song@linux.dev,
 clm@meta.com
References: <20251029190113.3323406-4-ihor.solodrai@linux.dev>
 <39bb0d21fffe3855c246dd85b2e69524c8e31bc9d84b441b063f365e5cbf220c@mail.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <39bb0d21fffe3855c246dd85b2e69524c8e31bc9d84b441b063f365e5cbf220c@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/29/25 12:41 PM, bot+bpf-ci@kernel.org wrote:
> 
> ```
> commit 974828216758f5fff2d9783439b8daa20188ce8c
> Author: Ihor Solodrai <ihor.solodrai@linux.dev>
> 
> bpf: Support for kfuncs with KF_MAGIC_ARGS
> 
> This patch adds infrastructure for magic kfuncs, which have two BTF
> representations: one for BPF programs and one for kernel implementation.
> The verifier resolves these through a lookup table.
> 
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index cb1b483be..fcf0872b9 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -3263,17 +3263,68 @@ static struct btf *find_kfunc_desc_btf(struct bpf_verifier_env *env, s16 offset)
>>  	return btf_vmlinux ?: ERR_PTR(-ENOENT);
>>  }
>>
>> +/*
>> + * magic_kfuncs is used as a list of (foo, foo_impl) pairs
>> + */
>> +BTF_ID_LIST(magic_kfuncs)
>> +BTF_ID_UNUSED
>> +BTF_ID_LIST_END(magic_kfuncs)
>> +
>> +static s32 magic_kfunc_by_impl(s32 impl_func_id)
>> +{
>> +	int i;
>> +
>> +	for (i = 1; i < BTF_ID_LIST_SIZE(magic_kfuncs); i += 2) {
>> +		if (magic_kfuncs[i] == impl_func_id)
>> +			return magic_kfuncs[i - 1];
>> +	}
>> +	return -ENOENT;
>> +}
>> +
>> +static s32 impl_by_magic_kfunc(s32 func_id)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < BTF_ID_LIST_SIZE(magic_kfuncs); i += 2) {
>> +		if (magic_kfuncs[i] == func_id)
>> +			return magic_kfuncs[i + 1];
>                                     ^^^^^^^^^^^^^^^^^
> 
> Can impl_by_magic_kfunc() overflow magic_kfuncs[]? With the current
> initialization using BTF_ID_UNUSED, BTF_ID_LIST_SIZE(magic_kfuncs)
> equals 1. The loop condition checks i < 1, so when i=0 it executes and
> accesses magic_kfuncs[i+1], which is magic_kfuncs[1]. This is outside
> the array bounds.

Hmm... Given we do i += 2, this can't happen if magic_kfuncs table is
defined correctly. Also if BTF_ID_UNUSED is passed in here, we have
bigger problems.

I guess changing the loop condition to size-1 wouldn't hurt.

> 
> The same issue applies generally: the loop checks i < size but accesses
> i+1, so it should check i+1 < size instead.
> 
>> +	}
>> +	return -ENOENT;
>> +}
> 
> [ ... ]
> 
> 
> ```
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> In-Reply-To-Subject: `bpf: Support for kfuncs with KF_MAGIC_ARGS`
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/18919699520

