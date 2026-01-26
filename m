Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E533A34D90B
	for <dwarves@vger.kernel.org>; Mon, 26 Jan 2026 18:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769451217; cv=none; b=td0gQYnRMMKLLyGYw35Bj2U85CwVRbzYG0GZnnqXbYtB8BM3cO1hhok5UAa8Txk65sxyOkajX+wVLTP+TEPk4J44jASyh/1As+h2JzQIN7OSUMUtRgLW005pC+4I0g4WYFD6y8Exd8PeED/Ug6AcEW9DYVf7r/4FfH1eawKFXP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769451217; c=relaxed/simple;
	bh=mlM32ToavdKphI896CsqTXp+LAG2zRBHOIShcQw9RZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MbbAoUJZBZtE6WwlAYNViXv+46P2BA3J7G48+rq/HzFK50z9vlrwqnFKPgoYAhJ5W8KtHZhXtAuVpN1T6urKeBCr/0sDIKSqljDZliXLdCEEFoxkujV0OHcazOAgq/hhmq0jccmvxRQafPsoAJ0ZE00pjKayB98LOeOaKU52PDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v7TCiNjo; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v7TCiNjo"
Message-ID: <63b833ba-2f10-490e-b27e-45891207f904@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769451202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mf7N/POOAn258EtbR14IyzX7m+xTanbWv2g1tfzfKPw=;
	b=v7TCiNjoRaoSHtyMX4vI6NRwJqyYQuuG6oJp+g1H2knGvm/88r0yddh+qFdU/4L0tPc9tr
	nQEwemELCJgakPm3iudeTrvO63+UBH+l7QyOeezv97TZiTkaIchYIH9sx85jY1RNpvpqDQ
	JO3haHHe33WLSlG8HCP40mfNCpJwrgY=
Date: Mon, 26 Jan 2026 10:13:16 -0800
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 dwarves 4/5] man-pages: document true_signature
 btf_feature
Content-Language: en-GB
To: Alan Maguire <alan.maguire@oracle.com>,
 Matt Bobrowski <mattbobrowski@google.com>
Cc: ihor.solodrai@linux.dev, eddyz87@gmail.com, jolsa@kernel.org,
 andrii@kernel.org, ast@kernel.org, david.faust@oracle.com,
 dwarves@vger.kernel.org, bpf@vger.kernel.org
References: <20260123172650.4062362-1-alan.maguire@oracle.com>
 <20260123172650.4062362-5-alan.maguire@oracle.com>
 <aXc7uFtOhE7bSZnw@google.com>
 <e7345200-ce29-4077-9d2f-7d7e4b47ca79@oracle.com>
 <aXdOIBvo9rZLGn-f@google.com>
 <61ae18d7-30e6-494e-a0e1-f5bf7dfa2758@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <61ae18d7-30e6-494e-a0e1-f5bf7dfa2758@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 1/26/26 9:10 AM, Alan Maguire wrote:
> On 26/01/2026 11:21, Matt Bobrowski wrote:
>> On Mon, Jan 26, 2026 at 10:51:31AM +0000, Alan Maguire wrote:
>>> On 26/01/2026 10:02, Matt Bobrowski wrote:
>>>> On Fri, Jan 23, 2026 at 05:26:49PM +0000, Alan Maguire wrote:
>>>>> Ensure non-default "true_signature" feature is documented in
>>>>> the manual page.
>>>>>
>>>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>>>> Acked-by: Matt Bobrowski <mattbobrowski@google.com>
>>>>
>>>>> ---
>>>>>   man-pages/pahole.1 | 5 +++++
>>>>>   1 file changed, 5 insertions(+)
>>>>>
>>>>> diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
>>>>> index 3125de3..90a8f45 100644
>>>>> --- a/man-pages/pahole.1
>>>>> +++ b/man-pages/pahole.1
>>>>> @@ -337,6 +337,11 @@ Supported non-standard features (not enabled for 'default')
>>>>>   	                   of split BTF with a possibly changed base, storing
>>>>>   	                   it in a .BTF.base ELF section.
>>>>>   	global_var         Encode all global variables using BTF_KIND_VAR in BTF.
>>>>> +	true_signature     Encode functions ensuring that binary-level
>>>>> +	                   (rather than source-level) signatures are used;
>>>> 									 ^
>>>> 									 within the generated BTF.
>>>> 									
>>>>> +                           for gcc these are ".isra.0" and ".costprop.0"
>>>>> +                           optimized functions
>>>> For BTF generation, would there ever be a situation whereby we
>>>> wouldn't want true signature support? I'm just trying to understand
>>>> why this isn't defaulted to true.
>>> The key reason is the "." in the name for gcc-optimized functions
>>> "function.isra.0" ; older kernels will reject BTF function names with
>>> a "." in them, so we have to guard against new pahole with the feature
>>> enabled by default being run on older kernels. So by having the newer
>>> kernels request the feature only we avoid this.
>> Oh, yes, that makes sense. Once a new pahole version is released with
>> true_signature support available, will you also be looking to update
>> scripts/Makefile.btf and conditionally enable it based on
>> availability?
> Yep, we're hoping to get some support on the LLVM side for true signatures, but
> absolutely, that's the plan. Because the --btf_features option will simply
> ignore features that it does not know about, this approach works with older
> pahole too without erroring out.

I actually have started to work on this from llvm side. Once Alan's patch
lands (which has true_signature infrastructure implemented), I should be
able to send some patch to address true_signature for llvm-built kernel.

