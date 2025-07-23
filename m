Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60F21F5838
	for <dwarves@vger.kernel.org>; Wed, 23 Jul 2025 15:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753285047; cv=none; b=nB2UIBnCBNprYg96XDwFtISHesORUxwJ8bZtN5MuK5m3zSoZHwXo8l0e/JJTMoi96EG4Nwi+hxCYlTK7JT78Ha06YTbG6u0VhQH9hXSZJ70xSuUL5M9SNAgyoLVWucG0b8xO99lH2nX9TPYYo40ekzZdFp+l4AQCSSpf+VluJf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753285047; c=relaxed/simple;
	bh=YDM1oCy3bU7iq8A4WnduLbhL4wu1njeoeDRAHpE30lY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n0K54SycSCAY5undravIxKZX9jS0yv4oG2K+4ey5WJaw/4+5okmXt2soAU1ONj73M1CZGJRaTgaJBRP+VWLYk5+p8fAAFsnDQjzLfANikwuVl330cN0HjjP39d6dxFjtZC5m1Jb3V0qQYz9Cmxj0nYQfo7FA7T8A0qU4X9mMT8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zv58LPeP; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zv58LPeP"
Message-ID: <83f3a344-3d7d-44cb-af3c-2029abb0ebe3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753285042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yeWtFjcDnzL7cIRw9IbQlD+ZQIQMIFdH3i7YI9c1RMI=;
	b=Zv58LPePkp/P15o/zoarto71I/YYw0RMyDWZL8DmiypivDZ0oJh7tkD5M8/ybOtoyBSo4K
	d4BbFpsUdJuq9Lzfq8ykCuXg7EqYuws/OphXdfTnv3zWER2LAHDfym9PdLUbBj1yQ4QXgC
	N234XltMWAEGsKcPh2up50Fyc/NAZY8=
Date: Wed, 23 Jul 2025 08:37:17 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] pahole: do not return an error when printing only a
 specific class
To: Alan Maguire <alan.maguire@oracle.com>,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 dwarves@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, ebpf@linuxfoundation.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>
References: <20250716-lsk__abort-v1-1-586f31a9d97d@bootlin.com>
 <e1afba7b-93f9-4ed3-9cd5-ef4ff4bebb70@linux.dev>
 <DBJASAZ3SGNN.364AZ1P0QK6G6@bootlin.com>
 <b8eee8a2-943d-4724-b9b4-f4816b8aea85@oracle.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <b8eee8a2-943d-4724-b9b4-f4816b8aea85@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/23/25 3:03 AM, Alan Maguire wrote:
> On 23/07/2025 09:39, Alexis Lothoré wrote:
>> Hi Ihor,
>>
>> On Wed Jul 23, 2025 at 1:42 AM CEST, Ihor Solodrai wrote:
>>> On 7/16/25 2:04 AM, Alexis Lothoré (eBPF Foundation) wrote:
>>
>> [...]
>>
>>>>    	cu__finalize(cu, cus, conf);
>>>> -	if (cus__steal_now(cus, cu, conf) == LSK__STOP_LOADING)
>>>> +	if (cus__steal_now(cus, cu, conf) == LSK__ABORT)
>>>>    		goto out_abort;
>>>
>>> I think we should handle both LSK__STOP_LOADING and LSK__ABORT here,
>>> otherwise the worker will keep loading DWARF (which is most of the
>>> pahole's work) and passing cu-s to the stealer function.
>>>
>>> I guess in many cases it'll complete without errors, but it's just
>>> unnecessary work.
>>>
>>> Maybe add a check for LSK__STOP_LOADING here with goto_ok?
>>
>> Hmmm, I am not sure how to follow you here. Even if cus__steal_now returns
>> LSK__STOP_LOADING, I need to return DWARF_CB_OK from
>> cus__merge_and_process_cu, otherwise it will be processed as an error
>> again. Or are you suggesting just make sure to delete current cu but still
>> return DWARF_CB_OK when getting LSK__STOP_LOADING, as done below ?

LSK__STOP_LOADING signals that no more input needs to be processed.

So I was thinking we should make sure the workers terminate without
error and return DWARF_CB_OK. Whether we delete a cu or not is not
that important since we are exiting soon anyway.

>>
>> --- a/dwarf_loader.c
>> +++ b/dwarf_loader.c
>> @@ -3796,6 +3796,7 @@ static int cus__merge_and_process_cu(struct cus *cus, struct conf_load *conf,
>>          Dwarf_Off off = 0, noff;
>>          struct cu *cu = NULL;
>>          size_t cuhl;
>> +       int res;
>>
>>          while (dwarf_nextcu(dw, off, &noff, &cuhl, NULL, &pointer_size,
>>                              &offset_size) == 0) {
>> @@ -3874,7 +3875,8 @@ static int cus__merge_and_process_cu(struct cus *cus, struct conf_load *conf,
>>                  goto out_abort;
>>
>>          cu__finalize(cu, cus, conf);
>> -       if (cus__steal_now(cus, cu, conf) == LSK__ABORT)
>> +       res = cus__steal_now(cus, cu, conf);
>> +       if (res == LSK__STOP_LOADING || res == LSK__ABORT)
>>                  goto out_abort;
>>
>>          return 0;
>> @@ -3882,7 +3884,7 @@ static int cus__merge_and_process_cu(struct cus *cus, struct conf_load *conf,
>>   out_abort:
>>          dwarf_cu__delete(cu);
>>          cu__delete(cu);
>> -       return DWARF_CB_ABORT;
>> +       return res == LSK__STOP_LOADING ? DWARF_CB_OK : DWARF_CB_ABORT;
>>   }
>>
>>
>> Thanks,
>>
>> Alexis
>>
>>
> 
> Good point; I think ideally we'd like to stop processing in either case
> but still distinguish error from early exit. We could perhaps set the
> appropriate LSK_ value in dcus (dcus->lsk_status?) to make the
> distinction and use it in cus__load_module(), renaming out_error in
> dwarf_cus__process_cu()  to out_early or something to underline the fact
> that it's an early exit not necessarily a failure. So we preserve the
> return of CB_ABORT for both failure and early exit, but can still tell
> these apart using dcus->lsk_status. Would that work?

Good suggestion. Yes, I think that would work better than just return
DWARF_CB_OK from the worker.

I overlooked the fact that there are many workers, and one of them
exiting with DWARF_CB_OK would not affect the others. But
DWARF_CB_ABORT would via the cus_processing_queue.abort flag.


