Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53891DE892
	for <dwarves@vger.kernel.org>; Tue, 15 Jul 2025 15:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752593830; cv=none; b=IenLlvgvCzv/PFqax+CEK9mujSIeivEaUR5ZhX8gxble1REwsKF5MuGv4MgRrcffTyaLKBJpDZm5gJXZH6JWh1DOYk7BymAdcw3nGrLdBypVuYRkNDOzeBQ7jQvXIDpG8oaQXAF+baM0JZdMuaWh8RlaJ+FylqqVBCDp4LotSdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752593830; c=relaxed/simple;
	bh=Bh0Y8SZoiEglHf0+3cV2Zu2LLLSNgefs0REhwYjPpfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fBehm4nBAxoQaGNTmD9b7WZX1peMTAJWTe3d4aN/jtM7yMnp2nqhtDIcx6NCDXoSvodWsK9OfunUI89yHulqV89Jgzx6cBLX6Kch38EhJnHS4kKMx4/Ac/uQCpaHhqpiTrRZfeh2ZDZ2rNSXX/a6o68CzRmGS6UieGAE8E7SUI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CaYHf0xI; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CaYHf0xI"
Message-ID: <e0dea1f3-b396-4503-8aeb-baba7cd21981@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752593816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZEhoBoqHfzUdGt1/xboG0chXhAgdsaLzQMQXZ1dytdg=;
	b=CaYHf0xIrT3MZtAkEqHXNJHw94z5TjHF0qbmvq+bikkuPEkp4KNkK0NAw16ty0L5pB073K
	ZMx+QQ3maRzuz8tt+xUvTg+NPtbk9RX1ORq8KhodMji46MGwI4iTegMlO3goVSdSaz7zcL
	LdIRSx+w8FkWL13tDFj//olL9qBQHrQ=
Date: Tue, 15 Jul 2025 08:36:41 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/3] tests: add some tests validating skipped functions
 due to uncertain arg location
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Alan Maguire <alan.maguire@oracle.com>, dwarves@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@fb.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>, ebpf@linuxfoundation.org
References: <20250707-btf_skip_structs_on_stack-v3-0-29569e086c12@bootlin.com>
 <20250707-btf_skip_structs_on_stack-v3-2-29569e086c12@bootlin.com>
 <DB5VWHU0N27I.3ETC4G47KB9Q@bootlin.com>
 <d26bb031-e88c-4d4b-8ce2-439aedc7a4a8@linux.dev>
 <680c6507-af5f-41be-8823-c8c9dfceaf5f@oracle.com>
 <DBCH1MVGI5EV.JODF0DE5B063@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <DBCH1MVGI5EV.JODF0DE5B063@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/15/25 1:04 AM, Alexis Lothoré wrote:
> On Wed Jul 9, 2025 at 6:21 PM CEST, Alan Maguire wrote:
>> On 07/07/2025 20:36, Ihor Solodrai wrote:
>>> On 7/7/25 7:14 AM, Alexis LothorÃ© wrote:
>>>> On Mon Jul 7, 2025 at 4:02 PM CEST, Alexis Lothoré (eBPF Foundation)
>>>> wrote:
> 
> [...]
> 
>>> I think a proper fix for this is differentiating two variants of
>>> LSK__STOP_LOADING: stop because of an error, and stop because there is
>>> nothing else to do. That would require a bit of refactoring.
>>>
>>> Alan, Arnaldo, what do you think?
>>>
>>
>> Would it suffice to treat LSK__STOP_LOADING as an error in the BTF
>> encoding case, and not otherwise? That's a bit of hack; ideally I
>> suppose we'd introduce LSK__ABORT (like DWARF_CB_ABORT) and use it for
>> all the failure modes, reserving LSK__STOP_LOADING for cases where we
>> are done processing rather than we met an error.
> 
> Ihor, Alan, is anyone one of you planning to work on it ? If not, do you
> want me take a look and implement one of the solution suggested above ? I
> guess it's best to aim for Alan's second suggestion first (introducing a
> new LSK enum to represent a failure), otherwise the simpler solution
> distinguishing reasons for LSK__STOP_LOADING.

If you're willing to work on this, please go ahead.

It's not directly related to this series though, so maybe a separate
patch.

> 
> Alexis
> 

