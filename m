Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40093F5BE2;
	Wed,  3 Jun 2026 20:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780517915; cv=none; b=VZOb3qz/oiB+pKPu46iI8gCip48d+hV9ENQxMcif/rA166/wAiNhTwa/TSTtM+Qle0QA+NNPbwpQ+OF4V/wqAJMIkOA54A+sbp7/Y1M4B9Apww72WkcyJBkWEOQobFKOyBQuGMTdqaGKU80IZj/zu8ucW9raOyiYHJCzTT6Pokg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780517915; c=relaxed/simple;
	bh=vd1UqlbeKxfktRs9ujmxbxVEV2FbtpqtvRC1AW7gllM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=erWuLkqCXPFTqDq5+1b+8WlUluyL14VCJYymDbDLLp2lr5d4DNXWKestS/VK8S0cZnQCVbpDO4NBbsfWxnq0aD+kvPwbVqHkt01jJAU+7j3N8gZdXG0v87uZk/xhYRt5MXhv3lZ6IBSAqQ/bB5DuNK7i3CM8uyOHfdfW4zE4V14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L0C4fieg; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L0C4fieg"
Message-ID: <c894bf32-f632-40b6-8557-ba7c9afd5699@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780517910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UaAE3yHIMeo4qc7AvLlIseYNafaeE9rUtAqS+DGbm+A=;
	b=L0C4fiegBM6/8Od5sP/BZXFy8vVZdLvVxx5L1biNS71QAVe2gCw1+ILvlM3bF+OqrZwJAO
	g+hK36W6HkcVlQbN6UeyMfYNCVnPqJHEg5B/w9LERwsHz6oxID2Gw22/v2iSm2Sdnsr0Mt
	tkDE3VGDxku0FwiOv2dmrUbN3BYjQAk=
Date: Wed, 3 Jun 2026 13:18:21 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PAHOLE v4 1/3] dwarf_loader: Extract die__add_btf_type_tag()
 helper [NFC]
Content-Language: en-GB
To: Vineet Gupta <vineet.gupta@linux.dev>, dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 acme@kernel.org, Alan Maguire <alan.maguire@oracle.com>,
 Emil Tsalapatis <emil@etsalapatis.com>, jose.marchesi@oracle.com,
 David Faust <david.faust@oracle.com>
References: <20260602195512.1511013-1-vineet.gupta@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260602195512.1511013-1-vineet.gupta@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/2/26 12:55 PM, Vineet Gupta wrote:
> NFC change preparing for DW_TAG_GNU_annotation support.
> Extract the btf_type_tag annotation creation logic into helper
> die__add_btf_type_tag().
>
> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
> Changes since v3 [3]
>   - Fix comment to kernel style [Arnaldo]
>
> Changes since v2 [2]
>   - die__add_btf_type_tag() returns pointer not error code [Alan]
>
> Changes since v1 [1]
>   - NFC reinstate some original comments
>
> [3] https://lore.kernel.org/bpf/20260601183511.594100-1-vineet.gupta@linux.dev/
> [2] https://lore.kernel.org/bpf/20260528223616.2035618-1-vineet.gupta@linux.dev/
> [1] https://lore.kernel.org/bpf/20260526181818.4159927-1-vineet.gupta@linux.dev/

If there is a further revision, for a three patch series, I think it is worthwhile
to have a cover letter so the above change log (and 2nd patch or more)
can be all in cover letter.

> ---
>   dwarf_loader.c | 58 +++++++++++++++++++++++++++++---------------------
>   1 file changed, 34 insertions(+), 24 deletions(-)
>
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 16fb7becffee..42a0f3f74ce3 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -1600,14 +1600,44 @@ static struct btf_type_tag_type *die__create_new_btf_type_tag_type(Dwarf_Die *di
>   	return tag;
>   }
>   
>
[...]

