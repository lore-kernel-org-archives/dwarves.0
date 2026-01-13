Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE722E54BD
	for <dwarves@vger.kernel.org>; Tue, 13 Jan 2026 18:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768329137; cv=none; b=j/ubbys6MasuweLTE7CeTb2D1by76l7zzmecwlirwO4nWG+xT1NIw7cpsZQY8Belzk99KD7k7uhZO6seQ9vPCrQ2rVyoQl4OD9amnOG6R3JdMABJe9GXo4Yx4Xq8cI4LXIlq0wkZB+OELwhoKgPRVFwXkovh2yVPBHMz/T7cAhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768329137; c=relaxed/simple;
	bh=ENG+11mj1pGt7Skmt2T/CyLWWh2v/nVikkxAGUFTx50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JaFnJ5yaDPBpXVAgX/Ju2/AQrGD0fmx01dDncAz8y9Bng1o+xmNmncgqnd8P5q9XdH9dZCqEYtJyYPn2nPolNqub3sEDiOG1TmkJPTr7AP22/H1pgP2QxRmlalMyaD+aIhQTivmavyYtSVy6pG2jfozhMYK64BIuB2Ihx/ymax0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eCi15rBU; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eCi15rBU"
Message-ID: <362ab824-6726-49ad-9602-ea25490e3298@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768329132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mGvPwcyoxR1wA0wC6H8sOa53pn7aq0IjfadSr+fYNdY=;
	b=eCi15rBUj+eB5SiM2coXa8NqCk8wIoT0mdJk/+jFGJK9YvmKjor5UHRzKypdpHz6pKS9lk
	IIDor356XMj6nWZ5OxOSz3PhTQb9nlsDXOnyxY751EoPz37lnSYsUuvGdvGawiBHRmpsvN
	sEtGn0lGYgrU3Hwyn9RKrrq0lxayudo=
Date: Tue, 13 Jan 2026 10:32:06 -0800
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves 2/4] btf_encoder: Refactor elf_functions__new()
 with struct btf_encoder as argument
To: Alan Maguire <alan.maguire@oracle.com>, yonghong.song@linux.dev,
 mattbobrowski@google.com
Cc: eddyz87@gmail.com, jolsa@kernel.org, andrii@kernel.org, ast@kernel.org,
 dwarves@vger.kernel.org, bpf@vger.kernel.org
References: <20260113131352.2395024-1-alan.maguire@oracle.com>
 <20260113131352.2395024-3-alan.maguire@oracle.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260113131352.2395024-3-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/13/26 5:13 AM, Alan Maguire wrote:
> From: Yonghong Song <yonghong.song@linux.dev>
> 
> For elf_functions__new(), replace original argument 'Elf *elf' with
> 'struct btf_encoder *encoder' for future use.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  btf_encoder.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 2c3cef9..5bc61cb 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -187,11 +187,13 @@ static inline void elf_functions__delete(struct elf_functions *funcs)
>  
>  static int elf_functions__collect(struct elf_functions *functions);
>  
> -struct elf_functions *elf_functions__new(Elf *elf)
> +struct elf_functions *elf_functions__new(struct btf_encoder *encoder)

Hi Alan, Yonghong,

I assume "future use" refers to this patch:
https://lore.kernel.org/dwarves/20251130040350.2636774-1-yonghong.song@linux.dev/

Do I understand correctly that you're passing btf_encoder here in
order to detect that the `encoder->dotted_true_signature` feature flag
is set? If so, I think this is a bit of an overkill.

How about just store the flag in struct elf_functions, pass it to the
elf_functions__new() directly and set it there:

	funcs->elf = elf;
	funcs->dotted_true_signature = dotted_true_signature; // <--
	err = elf_functions__collect(funcs);
	if (err < 0)
		goto out_delete;

And even then, it doesn't feel right to me that the contents of the
*ELF* functions table changes based on a feature flag. But we are
discarding the suffixes currently, so I understand why this was done.

Taking a step back, I remember Yonghong mentioned some pushback both
from LLVM and DWARF side regarding the introduction of true signatures
to DWARF data. Is there a feasible path forward landing all that?

I haven't followed this work in detail, so apologies if I missed
anything. Just want to have a high-level understanding of the
situation.

Thank you!


>  {
>  	struct elf_functions *funcs;
> +	Elf *elf;
>  	int err;
>  
> +	elf = encoder->cu->elf;
>  	funcs = calloc(1, sizeof(*funcs));
>  	if (!funcs) {
>  		err = -ENOMEM;
> @@ -1552,7 +1554,7 @@ static struct elf_functions *btf_encoder__elf_functions(struct btf_encoder *enco
>  
>  	funcs = elf_functions__find(encoder->cu->elf, &encoder->elf_functions_list);
>  	if (!funcs) {
> -		funcs = elf_functions__new(encoder->cu->elf);
> +		funcs = elf_functions__new(encoder);
>  		if (funcs)
>  			list_add(&funcs->node, &encoder->elf_functions_list);
>  	}

