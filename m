Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6E218AFD
	for <dwarves@vger.kernel.org>; Wed,  5 Nov 2025 04:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762315510; cv=none; b=IPo5x8V2kge+jj8YMO3LBoJYjRewTzeEifv8vmOgPmJitZTRXLfXnCg+a4a8CInna+QVgv+PD3kJclokKXe6zgq5fYHr08Ske45I/cqBF/nni/GjsocNcv4MuY508HaXsBM8ZjVLQ480/EsOpycS/p3miHKgERJex53zQh9yWmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762315510; c=relaxed/simple;
	bh=6KRptruN3/B4b6w97fhsIBpBI7uanBX2HGza1bREtxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nEQ//rcO6WeVqeMgSXaO0Q1+xlZOnw75CTaQXmUnoJYgev6mC/J7stTm9EaRax9n7tKJbmFyqOFdIgekOe1pYdmGiEMlEQzv2qUA0MEaTIP2nSHxwS1NzdPntkx6zvQ/Tb1tmQZd7AA5vyOdSGLtHPE90xIMfqKxMou/g/4z19Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VoHXXY2Q; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VoHXXY2Q"
Message-ID: <31a3eee0-a3f1-48e4-a577-be4496831647@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762315503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y12U0HSpmClAnZprjww302xzVajFyI9WWh9HDzAV0aA=;
	b=VoHXXY2QM0bRoc1tNJcby0d3miA4POSfE4cOC0maKTJ9XO/951/2U9m9SNWoRgVcPdBEFM
	fpk8jBgma7yHBPiRlyULy+nOUdEkYiNRhYSbFXO2gwiTOVecAGNj/UjXPa+F9lhWyUDY6f
	S0cgQGPD88F38L/dbqCQc94+q4MqNm8=
Date: Tue, 4 Nov 2025 20:04:58 -0800
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves v2 2/2] btf_encoder: factor out
 btf_encoder__add_bpf_kfunc()
To: Eduard Zingerman <eddyz87@gmail.com>, dwarves@vger.kernel.org,
 alan.maguire@oracle.com, acme@kernel.org
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
 kernel-team@meta.com
References: <20251104233532.196287-1-ihor.solodrai@linux.dev>
 <20251104233532.196287-3-ihor.solodrai@linux.dev>
 <da133e69429c39871b6f4f586ca9843c9e35048e.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <da133e69429c39871b6f4f586ca9843c9e35048e.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 11/4/25 5:55 PM, Eduard Zingerman wrote:
> On Tue, 2025-11-04 at 15:35 -0800, Ihor Solodrai wrote:
> 
> [...]
> 
>> @@ -1411,6 +1397,28 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder,
>>  		return -1;
>>  	}
>>  
>> +	return btf_fn_id;
>> +}
>> +
>> +static int btf_encoder__add_bpf_kfunc(struct btf_encoder *encoder,
>> +				      struct btf_encoder_func_state *state)
>> +{
> 
> As with previous iteration, 'state' has a link to 'encoder', so there
> is no need to pass it as a parameter.

You're right. I fixed this up in the first patch, but haven't noticed 
the same thing in the second. Will fix and send a v3.

> 
>> +	int btf_fn_id, err;
>> +
>> +	if (encoder->tag_kfuncs && encoder->encode_attributes)
>> +		if (btf__add_bpf_arena_type_tags(encoder->btf, state) < 0)
>> +			return -1;
>> +
>> +	btf_fn_id = btf_encoder__add_func(encoder, state);
>> +	if (btf_fn_id < 0)
>> +		return -1;
>> +
>> +	if (encoder->tag_kfuncs && !encoder->skip_encoding_decl_tag) {
>> +		err = btf__tag_kfunc(encoder->btf, state->elf, btf_fn_id);
>> +		if (err < 0)
>> +			return -1;
>> +	}
>> +
>>  	return 0;
>>  }
> 
> [...]

