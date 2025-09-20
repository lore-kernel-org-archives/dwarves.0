Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1974D200BA1
	for <dwarves@vger.kernel.org>; Sat, 20 Sep 2025 00:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758329021; cv=none; b=db/WgyrZRxYm9FQHt/KV7fpDMhlGwWNfE8gC29uMoe0jf5nLgwC9gErKmejKj9pgcpb9eN2atix/5IGF4rY7+qVoZGg7lT8RqfGfVkFDTeIWb+op+Jy9/vNmTNN2TAiueDJNASwTLp/ScqciRPUiSUQKcxZN6kHxXVcHzy1MXVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758329021; c=relaxed/simple;
	bh=WSem02O4QbxGCk+Tpcch2QGxe+XE21JzsJeFesvMpaQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KowdcjBB+HkHj/gl7cBU3UDxsHaHwfZS6o8IEyx0/DCeE7ZeZAo9jmLFWn/yrMQ6pclGMErqgZu0YCh7ENSUGll0XxnZO+k3komcfnMIMfPSVDzlc287MWd+1Vuyn+bllLuSrIZDS+WSKhi4/YLR0SJMGBJb1F38XgtO2agdsnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f572Tngh; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f572Tngh"
Message-ID: <580f039a-72eb-417b-a435-d9ec0661fb96@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758329007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KnYZGpohqWkG2zIx8rYyGxu/tToNURYK9pWxDOhfsmk=;
	b=f572TnghSiUH0K8/gH2b0H97rN5A8oGSMxlM33r+Ao68pdlowG13dNK9H/h0M6PFy12rQ0
	9DuG/ZiOa6BCrJnhBMLZq2qcVdAXqsDSLacH9fmPh+T1CZIeyt3GzsvlY+AKHxTNU6OK3g
	1ZUteZjHHc5/vlRBuZUKDaaouDxtgZo=
Date: Fri, 19 Sep 2025 17:43:22 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves v1] btf_encoder: move ambiguous_addr flag to
 elf_function
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: alan.maguire@oracle.com, dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, acme@kernel.org, andrii@kernel.org, ast@kernel.org,
 eddyz87@gmail.com, olsajiri@gmail.com, kernel-team@meta.com
References: <20250920003656.3592976-1-ihor.solodrai@linux.dev>
Content-Language: en-US
In-Reply-To: <20250920003656.3592976-1-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/19/25 5:36 PM, Ihor Solodrai wrote:
> Having an "ambiguous address" in the context of BTF encoding is an
> attribute of an ELF function, and not any specific DWARF instance of
> it. Thus it is redundant to maintain this flag in every
> btf_encoder_func_state, and merging them in btf_encoder__save_func().
> 
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  btf_encoder.c | 47 ++++++++++++++++++++++++-----------------------
>  1 file changed, 24 insertions(+), 23 deletions(-)
> 
> [...]
Hi Alan,

I've just noticed that you merged v2 of "btf_encoder: group all
function ELF syms by function name" and not v3 [1] as I expected.

This patch is essentialy v2->v3 diff merged into current next.

vmlinux.h is identical between this patch and pahole/next (09c1e9c)
for a sample vmlinux I had at hand.

Successful CI checks: https://github.com/acmel/dwarves/pull/70/checks

[1] https://lore.kernel.org/dwarves/20250801202009.3942492-1-ihor.solodrai@linux.dev/
