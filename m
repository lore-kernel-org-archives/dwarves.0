Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776B82940D
	for <dwarves@vger.kernel.org>; Tue, 16 Dec 2025 02:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765851396; cv=none; b=a6qja5D2EApuLlqCGN35yULJXqw/fktAunlNYO5GjbwRbB2KhyIBGugjHpa/NAA7Z4LbpnSsg7i3wPrWG/bKp4nEmc49nVKdP2Fmcu4CieOx9n/HZ1hDcTT5GuxEdFGsgwcR77y66gFaxLmTA/lACj6gGzSTLLbOEKbtA9qaB0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765851396; c=relaxed/simple;
	bh=zQEZE/wtEEhUf9YjyAzgDQ46dxWCG3WEEfwQjDr7tkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=idlamlqyckUDHlzH42+tZ8uv6taEOJVQQ8TJtQd2CcRrU7cmbMyNjfwww2OYmzZt6CsF92UWewHBDIX2tenQqavF1/S3lfOFSTva+bcqmym5cECoCXrvDkgTG73wc/qgtj9dJqrKuggUURe7+bdFkAxOyhgaAQbNbzCoMvZoHMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tw+NmO0/; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tw+NmO0/"
Message-ID: <063c8a1b-be0a-4688-bb7f-047db216de5f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765851382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uWD3P9+UXC4Auiu3i5M7XllEngFAOD7Hu6jHj8OyWak=;
	b=tw+NmO0/Nqp/4hzQp2XUYMOFhuGdAGdxA1hmuiIjgVqUCE1YUuZPfkjU5NOQYVZptSu0Eh
	0AWUzNV2SYYcm6WA50nWurUACsONhttIy9iZpl7tWBnke/jxJdtHZcCagb2Qum0gi1ue4Y
	KZCK9crP4PP9BgA/bTjArFpnzzD7+Dw=
Date: Mon, 15 Dec 2025 18:16:11 -0800
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 6/6] resolve_btfids: change in-place update
 with raw binary output
To: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
 Shuah Khan <shuah@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Alan Maguire <alan.maguire@oracle.com>, Donglin Peng <dolinux.peng@gmail.com>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
References: <20251205223046.4155870-6-ihor.solodrai@linux.dev>
 <20251205223554.4159772-1-ihor.solodrai@linux.dev>
 <b11c1ae3816842f7b1768072982680c0bc80d8f4.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <b11c1ae3816842f7b1768072982680c0bc80d8f4.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/11/25 11:08 PM, Eduard Zingerman wrote:
> On Fri, 2025-12-05 at 14:35 -0800, Ihor Solodrai wrote:
>
> [...]
> 
>> @@ -860,23 +913,34 @@ int main(int argc, const char **argv)
>>  	 */
>>  	if (obj.efile.idlist_shndx == -1 ||
>>  	    obj.efile.symbols_shndx == -1) {
>> -		pr_debug("Cannot find .BTF_ids or symbols sections, nothing to do\n");
>> -		err = 0;
>> -		goto out;
>> +		pr_debug("Cannot find .BTF_ids or symbols sections, skip symbols resolution\n");
>> +		goto dump_btf;
>>  	}
>>  
>>  	if (symbols_collect(&obj))
>>  		goto out;
>>  
>> -	if (load_btf(&obj))
>> -		goto out;
>> -
>>  	if (symbols_resolve(&obj))
>>  		goto out;
>>  
>>  	if (symbols_patch(&obj))
>>  		goto out;
>>  
>> +	err = make_out_path(out_path, obj.path, BTF_IDS_SECTION);
>> +	if (err || dump_raw_btf_ids(&obj, out_path))
>> +		goto out;
>> +
>> +dump_btf:
>> +	err = make_out_path(out_path, obj.path, BTF_ELF_SEC);
>> +	if (err || dump_raw_btf(obj.btf, out_path))
> 
> Nit: 'err' is not set if dump_raw_btf() errors out.
>      Maybe use:
> 
>      	   err = make_out_path(out_path, obj.path, BTF_ELF_SEC);
>      	   err = err ?: dump_raw_btf(obj.btf, out_path);
> 	   if (err)
> 	      goto out;
>      ?

Good observation. I'll fix this, thanks.

> 
>> +		goto out;
>> +
>> +	if (obj.base_btf && obj.distill_base) {
>> +		err = make_out_path(out_path, obj.path, BTF_BASE_ELF_SEC);
>> +		if (err || dump_raw_btf(obj.base_btf, out_path))
>> +			goto out;
>> +	}
>> +
>>  	if (!(fatal_warnings && warnings))
>>  		err = 0;
>>  out:
> 
> [...]

