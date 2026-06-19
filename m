Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653EE2E6CB8
	for <dwarves@vger.kernel.org>; Fri, 19 Jun 2026 23:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781911144; cv=none; b=qh1SGz5sR5Ft3GTpKzHGkuwkjJD3H0ELkviOcgUFcHq/fPPf4kuUl9rrAYzPLalXZ/Q4Zq5KaT/ktjBnIll/mmVdYXAIWdW8uLe4exrQ66MjKZAqPrUTgUaUZiX+C0c0PP/emCQHNt5imN8B6AyoEyxL3VMTTxIg9/UiDDNfKFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781911144; c=relaxed/simple;
	bh=1JyVplDhMeR4A27zCETSm2QSei+ypygpdnVrRWu/xHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pr0HhKRNqGyqhB8mQfS4/Ax8CTV+Nun/O1VBzq8lceJrpo8g6nFyM5G1OMa9kVAKm+F5LQ8A6CegKEFaVSBPfLW9LBDswG0LnUkE/jBC9Ijgsj7WRC85JuHtqhjER37tuuOU6cgljUVKteOBxw5j1YmZRqO1HDq/65G6vPdXMMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qKATV1fZ; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qKATV1fZ"
Message-ID: <ee92e842-85d8-4b1a-a741-4b6067895223@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781911131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XSvxE/LkQFTZ7tFOUM7elx/jZmpKTxsHeCanyoDkH1E=;
	b=qKATV1fZMSgpu6r3paZfdELrEb5IFzZbG6qUaXpgmOSYezVbILeO5wYK2SWwHHVV/R4BCj
	w84VwhWmafrGNaS0Et/vevYbzALB3ktvRIb+gnp+3sOEEExOIE8eNFnJVP89Llml8tGKr4
	QRANEaonNyI/oEgRyDjafsyrU2pZYXE=
Date: Fri, 19 Jun 2026 16:18:40 -0700
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <663c926a-09f2-4239-bbe9-078bbf900822@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Alan,

On 6/19/26 05:17, Alan Maguire wrote:
> On 18/06/2026 01:57, Vineet Gupta wrote:
>> Hi,
>>
>> This series handles gcc generated DW_TAG_GNU_annotation with the end
>> goal to finally enable CONFIG_PAHOLE_HAS_BTF_TAG for gcc kerenel builds.
>>
>> Patches 1/5 and 5/5 are newly introduced in v5 per Alan's ask.
>>
>> P.S.: I've optimistically included Reviewed-by/Acked-by from Emil and
>> Yonghong respectively on v4 [4] but those were before additional changes
>> in v5 from Alan for a few things. Please let me know if that's no longer
>> true.
>>
>> [4] https://lore.kernel.org/bpf/20260602195512.1511013-1-vineet.gupta@linux.dev/
>>
> series applied, along with CI change to support [1]. Thank you!

Thanks for quickly merging this. I now need to plumb this thru on the 
kernel side to essentially enable CONFIG_PAHOLE_HAS_BTF_TAG for gcc but 
that would need to be keyed off of a pahole release version. Is pahole 
due for a release (cadence and/or this changeset). If not I can 
speculative use the next version whenever that happens. There are other 
things in flight as well (gcc fix after 16.1) so this is not super 
urgent but will be good to get out of the way.

Thx,
-Vineet

>
> Alan
>
> [1] https://lore.kernel.org/dwarves/20260619073358.1605594-1-alan.maguire@oracle.com/T/#r0d979ca6aa79a4586b75223ec51a54e7be1d74f8
>
>   
>> Thx,
>> -Vineet
>>
>> Alan Maguire (2):
>>    btf_loader: Handle decl tag component_idx for parameters
>>    tests: Add btf_type_tag ordering test
>>
>> Vineet Gupta (3):
>>    dwarf_loader: Extract die__add_btf_type_tag() helper [NFC]
>>    dwarf_loader: Add support for DW_TAG_GNU_annotation
>>    tests: Support GCC in pfunct-btf-decl-tags test
>>
>>   btf_encoder.c                 |   1 +
>>   btf_loader.c                  |  46 ++++++++-
>>   dutil.h                       |  11 ++
>>   dwarf_loader.c                | 185 +++++++++++++++++++++++++++-------
>>   dwarves.h                     |   2 +-
>>   dwarves_fprintf.c             |  32 ++++--
>>   tests/btf_type_tag_order.sh   | 179 ++++++++++++++++++++++++++++++++
>>   tests/pfunct-btf-decl-tags.sh |  93 ++++++++++++-----
>>   8 files changed, 478 insertions(+), 71 deletions(-)
>>   create mode 100755 tests/btf_type_tag_order.sh
>>

