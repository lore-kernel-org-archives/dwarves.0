Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91552836A0
	for <dwarves@vger.kernel.org>; Mon, 22 Jun 2026 20:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782159663; cv=none; b=fOwH4PLesl6/9DqaXkbXnkDNyUvCC6F/+PO/uBt1CzttnuT5D3Mo0F3yZvOo3Ha7s+f9uH3adQOeMzQeR9qG8GDlMD+h4zO6xNqRt1sQT58vyXstgNVqFuXQcpSLyhdujVUQ7vXnI15dteyfin4yxO+QqNmlXuwXVPiCG9lykOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782159663; c=relaxed/simple;
	bh=Dr8wKO6+kc8O9HJR+zv1iSMRshGTTAzOtPpjq/GML6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tiWyGTwnDgWdvfGJrTcKS2vuntP0nG8s0adbPZ387jVUfMBcXLwX0w2eRnBklZyBQo7W/Nv5jjKPzsJ1J/HYx43GG339StqeTAVgRedAeevAh/lnDlmfwDux8B8oO7phPa964pj+GipKizpB1f388QgD5Mb6U0cXHbfTkkrZ5qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W132FXuo; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W132FXuo"
Message-ID: <50d109ff-e8de-47ea-af57-9b949256c71f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782159650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dr8wKO6+kc8O9HJR+zv1iSMRshGTTAzOtPpjq/GML6U=;
	b=W132FXuoGNUznkzchIqJXQMuQFYQaBQwH/dEr18U99mqLocSagYpV3galMH1J46GDggGM/
	ephRK9Gh7HfG60pYxcrVc+EUwVK7g+tbjkY1cm9qbGhwV+3OP6Ou5/bAaHgKzVTisPBGql
	oZl+lVzxbuE6lTQrMUqzmXvSbeVT8pE=
Date: Mon, 22 Jun 2026 13:20:33 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PAHOLE v5 0/5] support for DW_TAG_GNU_annotation and fixes
To: Alan Maguire <alan.maguire@oracle.com>, dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 acme@kernel.org, Emil Tsalapatis <emil@etsalapatis.com>,
 jose.marchesi@oracle.com, David Faust <david.faust@oracle.com>,
 Yonghong Song <yonghong.song@linux.dev>
References: <20260618005731.273181-1-vineet.gupta@linux.dev>
 <663c926a-09f2-4239-bbe9-078bbf900822@oracle.com>
 <ee92e842-85d8-4b1a-a741-4b6067895223@linux.dev>
 <ab92c03c-f0af-45fb-8334-b156644056c1@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <ab92c03c-f0af-45fb-8334-b156644056c1@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/22/26 12:03 PM, Alan Maguire wrote:
> On 20/06/2026 00:18, Vineet Gupta wrote:
>> Hi Alan,
>>
>> On 6/19/26 05:17, Alan Maguire wrote:
>>> On 18/06/2026 01:57, Vineet Gupta wrote:
>>>> Hi,
>>>>
>>>> This series handles gcc generated DW_TAG_GNU_annotation with the end
>>>> goal to finally enable CONFIG_PAHOLE_HAS_BTF_TAG for gcc kerenel builds.
>>>>
>>>> Patches 1/5 and 5/5 are newly introduced in v5 per Alan's ask.
>>>>
>>>> P.S.: I've optimistically included Reviewed-by/Acked-by from Emil and
>>>> Yonghong respectively on v4 [4] but those were before additional changes
>>>> in v5 from Alan for a few things. Please let me know if that's no longer
>>>> true.
>>>>
>>>> [4] https://lore.kernel.org/bpf/20260602195512.1511013-1-vineet.gupta@linux.dev/
>>>>
>>> series applied, along with CI change to support [1]. Thank you!
>> Thanks for quickly merging this. I now need to plumb this thru on the kernel side to essentially enable CONFIG_PAHOLE_HAS_BTF_TAG for gcc but that would need to be keyed off of a pahole release version. Is pahole due for a release (cadence and/or this changeset). If not I can speculative use the next version whenever that happens. There are other things in flight as well (gcc fix after 16.1) so this is not super urgent but will be good to get out of the way.
>>
> hi Vineet, we will likely spin a 1.32 soon. I'm hoping to get Yonghong's true signature work
> in, and my inline stuff is close (but is now rebuilt to use some of the true signature changes
> so is gated on it), but we don't strictly need to wait on the inline work landing.
>
> Given PTO etc I would say we could aim for a 1.32 release in mid-July; does that work from your
> side? Thanks!

Yeah this seems reasonable.

Thx,
-Vineet
