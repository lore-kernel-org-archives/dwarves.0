Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC1513632B
	for <dwarves@vger.kernel.org>; Fri, 22 Nov 2024 15:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732287842; cv=none; b=Lx+GrQTrraGJWIJYOvJ4wHnRhJWWbFs+vsuMVLiC3BaihNetxnVXNCh4bKVIIs9Vz/BK3PEfXM/4+dWyskySbyLj7cDtfAXttQC45cdl6gGrVIYG3xslq3QkKTkrratFwbIuXi+vWyQRDBlBf/5gGIlqVRYOg+jDDyzjV7Emw28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732287842; c=relaxed/simple;
	bh=oEQRvR0VnhoPMcEq8odyrVmnHT8gOxGExOMibCqS+Vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d5KJWMfRpCQMDfha8CHx8aNae/CNKVOPfybAPHl+B2iZKRsCHtxW2wvW2lINNp5uQDJFkV2CWk5Va4gOz4/4Mc6yjxGfWAiG9O+l7rsG5+em/XwZZPc3MATmhl5dAl3nIffPMuOAbAj56OOb4ef2bC+pmzGqC9e71mSZlgfK30s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mrcQ7mY0; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mrcQ7mY0"
Message-ID: <1fcebf3f-ce94-46b8-b95a-0adf8b88772c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732287833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xE7cv5uZn3PW5EysRv0RVf0QrdGn9FbyFakjHXRxXaI=;
	b=mrcQ7mY0KWPNNZ9Q7vaC22RUiiv8WsutQZipFvU+UsC6GGHRFhuHj6WuDoWrHSmYgdeDMC
	OLajzXr9psA2u/j+wKb3/Auh73fKysnHJIJF84jGBpk4TFQq5MGba5t70292rOmPr4TIF4
	iEGn7OstqOiDZRFH5VFI0ZrxypIy4mk=
Date: Fri, 22 Nov 2024 07:03:41 -0800
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves v1] btf_encoder: handle .BTF_ids section
 endianness when cross-compiling
To: Eduard Zingerman <eddyz87@gmail.com>, dwarves@vger.kernel.org,
 arnaldo.melo@gmail.com
Cc: bpf@vger.kernel.org, kernel-team@fb.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, yonghong.song@linux.dev,
 Alan Maguire <alan.maguire@oracle.com>, Daniel Xu <dxu@dxuuu.xyz>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Vadim Fedorenko <vadfed@meta.com>
References: <20241122070218.3832680-1-eddyz87@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241122070218.3832680-1-eddyz87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 21/11/2024 23:02, Eduard Zingerman wrote:
> btf_encoder__tag_kfuncs() reads .BTF_ids section to identify a set of
> kfuncs present in the ELF being processed. This section consists of
> records of the following shape:
> 
>    struct btf_id_and_flag {
>        uint32_t id;
>        uint32_t flags;
>    };
> 
> When endianness of binary operated by pahole differs from the
> host endianness these fields require byte swap before using.
> 
> At the moment such byte swap does not happen and kfuncs are not marked
> with decl tags when e.g. s390 kernel is compiled on x86.
> To reproduces the bug:
> - follow instructions from [0] to build an s390 vmlinux;
> - execute:
>    pahole --btf_features_strict=decl_tag_kfuncs,decl_tag \
>           --btf_encode_detached=test.btf vmlinux
> - observe no kfuncs generated:
>    bpftool btf dump test.btf format c | grep __ksym
> 
> This commit fixes the issue by adding an endianness conversion step
> for .BTF_ids section data before main processing step, modifying the
> Elf_Data object in-place.
> The choice is such in order to:
> - minimize changes;
> - keep using Elf_Data, as it provides fields {d_size,d_off} used
>    by kfunc processing routines;
> - avoid sprinkling bswap_32 at each 'struct btf_id_and_flag' field
>    access in fear of forgetting to add new ones when code is modified.
> 
> [0] https://docs.kernel.org/bpf/s390.html
> 

LGTM, Thanks!

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>


