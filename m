Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB951DA628
	for <dwarves@vger.kernel.org>; Fri, 23 Jan 2026 19:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769195150; cv=none; b=tSyZq2DdSw7d48QQumf1c5cNx9gb1IQsztOarvpIBPKWxgZf4fSdZMPlt9C4KvdFeKV7LzyOnpAf4ZSU81+SIMFCzNKcH0n4WuvK1BYgB6oZwI1FAwuRu5AasnFdtGsW1SFsnrpYJFDbbJYOBwQQeVkKoC3qM7Wr3DVHgW+ZlI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769195150; c=relaxed/simple;
	bh=vEgGnmKQ3/w5bJ2jiMRqtltEJGbTjhrRKZ1ALWspsHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IFjj1rD/uUlp0twW0XmDoLB/IKhqQSM4ZC2v2lS9/Bd8zKU0/ak2djfyUWwK9Tk7HRtPj5RidjKdqPjizwaRci3/V5n70Fkmvde7GxC3q7I3wKmbnPm752C27b0GGwax8iajoXt0Z/h2xRAjM7ok3sm5HDE2gyjXBe/F7RT6zDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BnNEXmSY; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BnNEXmSY"
Message-ID: <8cc92e34-c77f-4293-a0a3-9f13e3440716@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769195145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=932oIGiEPEF7l80f+ZE1KYAU4eKnL27ViShR3j7TwJ4=;
	b=BnNEXmSYbxqeWRdNFsZogBmS2P4Bt9MiXIaNwmVl4OAX4eR47MN80677moo7mUgCrG4fTv
	yJ8DH554Cr/svQCtCML8gFMUuK9WX+bjVFqZ7A7BQHPUiWpJJLvq4PzaRiF5KmxxgEd0yS
	Ty3AK3FvlN4cYWYARWIjeyLS3o6xTLw=
Date: Fri, 23 Jan 2026 11:05:40 -0800
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 dwarves 2/5] btf_encoder: Add true_signature feature
 support for "."-suffixed functions
Content-Language: en-GB
To: Alan Maguire <alan.maguire@oracle.com>, mattbobrowski@google.com
Cc: ihor.solodrai@linux.dev, eddyz87@gmail.com, jolsa@kernel.org,
 andrii@kernel.org, ast@kernel.org, david.faust@oracle.com,
 dwarves@vger.kernel.org, bpf@vger.kernel.org
References: <20260123172650.4062362-1-alan.maguire@oracle.com>
 <20260123172650.4062362-3-alan.maguire@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260123172650.4062362-3-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 1/23/26 9:26 AM, Alan Maguire wrote:
> Currently we collate function information by name and add functions
> provided there are no inconsistencies across various representations.
>
> For true_signature support - where we wish to add the real signature
> of a function even if it differs from source level - we need to do
> a few things:
>
> 1. For "."-suffixed functions, we need to match from DWARF->ELF;
>     we can do this via the address associated with the function.
>     In doing this, we can then be confident that the debug info
>     for foo.isra.0 is the right info for the function at that
>     address.
>
> 2. When adding saved functions we need to look for such cases
>     and provided they do not violate other constraints around BTF
>     representation - unexpected reg usage for function, uncertain
>     parameter location or ambiguous address - we add them with
>     their "."-suffixed name.  The latter can be used as a signal
>     that the function is transformed from the original.
>
> Doing this adds 500 functions to BTF.  These are traceable with
> their "."-suffix names and because we have excluded ambiguous
> address cases we know exactly which function address they refer
> to.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

