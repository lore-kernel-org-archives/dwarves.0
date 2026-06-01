Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A289C3233E8
	for <dwarves@vger.kernel.org>; Mon,  1 Jun 2026 19:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780343064; cv=none; b=aF8jnHeEmZTEe47SwTXqI9Fvogbs1BrqkhOHesSzwJQruQ+IC9+u6bfSI683GJoTAGY/MdLf5aPEo3yzh9GT6mJvF1X2IyX3jlg1hfbTIUuMghhHinWbd5WWpyUeq3DqMtU7Ga/Dti8gifsGhX4hEnILyYzoLgVZYezy0+VCdXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780343064; c=relaxed/simple;
	bh=nej4lFTEJuyKRNeBlJrD7MrYJlmsLLQzR7ILP2W2V38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GS56kaKh3fCTMjPhaZOYchDlqQIe0X1MtGuNyCY+bYdRLOX4pvLxvmjFpC/vYG116qA/RidKrWnN8deGsAYD1ek51x3wQPXziHa5OS5mUSM3DHSSTMNa5AzjBVGTX6b+K6tXQ67rZkvrTUscUa5ak+6pluSz8XbCOvmp9muDTZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=amZA9AZN; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="amZA9AZN"
Message-ID: <98537aaa-fcf3-49bc-868e-fe46bf7e3a92@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780343060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2BKkWULirKVaSQNe98horNhJG4hOS/bRBZYPd7FcX+w=;
	b=amZA9AZNxYS4i4/P5Gv3ALI/MqWSpItLu0zFNk2/eUsVlRDFy0cSon4ggKj7tewx7906nY
	LgYh8RULbIqYcLVBZoCwAIPcxqn5dnmEd5J8aqgciRBIVkQyYv5MnK1TtcDBbCz4nSl+4B
	XXXyNNCKQHV2LQUMgznezThAXIw9Q8c=
Date: Mon, 1 Jun 2026 12:44:06 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PAHOLE v3 1/3] dwarf_loader: Extract die__add_btf_type_tag()
 helper
To: Emil Tsalapatis <emil@etsalapatis.com>, dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 acme@kernel.org, Alan Maguire <alan.maguire@oracle.com>,
 jose.marchesi@oracle.com, David Faust <david.faust@oracle.com>
References: <20260601183511.594100-1-vineet.gupta@linux.dev>
 <DIXYL7ZGEO7C.3HN24VDJYZQOR@etsalapatis.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <DIXYL7ZGEO7C.3HN24VDJYZQOR@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/1/26 12:27 PM, Emil Tsalapatis wrote:
>> +	/* Prepends: for annotations tag1 -> tag2 -> tag3,
> Not familiar with pahole's coding style, do we want to adjust the
> comments?

I just tweaked whatever was the style before for that comment block.
Pahole it seems has a mix of the 2 styles: linux kernel type with empty 
first and last lines vs. only empty last line.

Thx for taking a look.

Thx,
-Vineet
