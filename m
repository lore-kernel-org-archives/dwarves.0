Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911E5402B9F
	for <dwarves@vger.kernel.org>; Fri, 29 May 2026 18:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780078329; cv=none; b=DDcaMDT+bT16IVmdp9anfTn9yBgWvUmzth39WB0ZBnr6mCzONpGoEo877vrpRmZ7gC5V3IKxVWePvJ3wdxUdyU3gN5vn4HU3H8Yp4KV798CW3bjsUi1XzGCCynNngqcn/5T/4F2eAX3Ut/5/1992TF7F3PHbr8+C8MaE/ulKenw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780078329; c=relaxed/simple;
	bh=yXeAzLn9NcfhSemxluW6MU0ogcDKqa8DhIlsYmpX0Eo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kSL9mBAs/FG3U1cb/lu/vmrUtp2s1cogklwMyqAMU9QKfe4gGIUcaQi/wvBGhhdVnFq+2O70QKa6uSNgouiKAdAuZEHJrynIdNwY3EV+9T+N+cPloywt6DgAKPw3CiKJGa55X93XrjAd9WDeusgPHoyX52wHH08D1Dc0i7M0YQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TtJ/c8cZ; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TtJ/c8cZ"
Message-ID: <2fb9e4df-d906-46e7-8239-79025b628e5b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780078311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MexmIPrUohugpiijFiu328LdXV+dU5AGgrmgQ6bbklE=;
	b=TtJ/c8cZAm3ddlCsH/QZK5aGOBx3JDFTGuIDmAqcakotlyNE55vP8hlJJvJBAW0E9gSrQG
	TsZrvPvmU4NNI02nPKxrGrUpkYThIpQx4bLdK1eSWfd0t5+pATBQlHKpiTah+/UI+M6Od7
	et3RISRV+eVkhU46N5RadQuLWT6EWIg=
Date: Fri, 29 May 2026 11:11:43 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PAHOLE Patch v2 1/2] dwarf_loader: Extract
 die__add_btf_type_tag() helper [NFC]
To: Alan Maguire <alan.maguire@oracle.com>, dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 acme@kernel.org, jose.marchesi@oracle.com,
 David Faust <david.faust@oracle.com>
References: <20260528223616.2035618-1-vineet.gupta@linux.dev>
 <8c8826d1-6534-4aef-8129-5c8da61f731e@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <8c8826d1-6534-4aef-8129-5c8da61f731e@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Alan,


On 5/29/26 06:23, Alan Maguire wrote:
> looks good Vineet! One small suggestion:
>
>> +static int die__add_btf_type_tag(struct btf_type_tag_ptr_type **tagp,
>> +				 Dwarf_Die *die, Dwarf_Die *adie,
>> +				 struct cu *cu, struct conf_load *conf)
> maybe just change the function to return the struct btf_type_tag_ptr_type *,
> since consumers just check for non-zero rather than doing anything with the
> error code?

OK will do.

Thx for taking a look.
-Vineet
