Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976B12848BB
	for <dwarves@vger.kernel.org>; Fri,  5 Dec 2025 22:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764975114; cv=none; b=j/VPUJuXmCcMY3ESg0rIit6qqRMFzoSmbfHNooqTX+1X0kzGwiEu28cPR93YaCIbo3uoKZgvV74GOOJihYl3M9pxzyPhAUrhAMW07+SxCbSy/BnieoIXKFuInalGZqg+ZTnOLhuy1Ysw/P87hXi5hON21dCrnAAq2dSgcTQYcfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764975114; c=relaxed/simple;
	bh=bogPixABuqptl6LcMZBzb7XcpAgwS3tuA0OLvJ14U2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZCJImx4awav2c3piEqgWw5mGZ2SLW/I/KCDuzdybRiso62PqdFZSQ+xqQN6L/pgKFTIQGT7QotPhDpIByChOxzetgvaqQjMd2GRSMr2FeDt0i+1u1k2A0CZZ9Z+RUfSwGBeW4q6cD81Tv+NQfnyx3vLCEs/HZwXCbTWWkavrBdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pwya64GC; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pwya64GC"
Message-ID: <45232d20-22f0-47e2-aada-8aaaa6106af0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764975100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WDsi6/cNsOPA/JWg8W56XHZWB/60SWOyGJbGe2MMBgQ=;
	b=pwya64GCTz/Qp1hLswXioOTXj8hxSsTAEdTPfifmvj8GQg8rYv+VfWpD/GLv5fc9SK7XDi
	XqFB+68M3SK0Zm0Yq7OrjUj35xfr//N5K7joXqj/JbR/TwQSMQ95TOX0Ju5MHLsfNAYO8q
	DBDqn2rja+nl/zRfKQhxqd8n5G0i0B4=
Date: Fri, 5 Dec 2025 14:51:22 -0800
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 4/6] lib/Kconfig.debug: Set the minimum
 required pahole version to v1.22
To: bot+bpf-ci@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 akpm@linux-foundation.org, nathan@kernel.org, nsc@kernel.org, tj@kernel.org,
 void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 shuah@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com,
 justinstitt@google.com, alan.maguire@oracle.com, dolinux.peng@gmail.com
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
 martin.lau@kernel.org, clm@meta.com
References: <20251205223046.4155870-5-ihor.solodrai@linux.dev>
 <2475b1c6ce4e9249129ca007de68b80cc4d32a0949e391a2de4467bf599f25f7@mail.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <2475b1c6ce4e9249129ca007de68b80cc4d32a0949e391a2de4467bf599f25f7@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/5/25 2:49 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>> index 742b23ef0d8b..3abf3ae554b6 100644
>> --- a/lib/Kconfig.debug
>> +++ b/lib/Kconfig.debug
> 
> [ ... ]
> 
>> -config PAHOLE_HAS_SPLIT_BTF
>> -	def_bool PAHOLE_VERSION >= 119
> 
> The PAHOLE_HAS_SPLIT_BTF config option was removed here.
> 
> [ ... ]
> 
>> diff --git a/tools/sched_ext/README.md b/tools/sched_ext/README.md
>> index 16a42e4060f6..56a9d1557ac4 100644
>> --- a/tools/sched_ext/README.md
>> +++ b/tools/sched_ext/README.md
>> @@ -65,7 +65,6 @@ It's also recommended that you also include the following Kconfig options:
>>  ```
>>  CONFIG_BPF_JIT_ALWAYS_ON=y
>>  CONFIG_BPF_JIT_DEFAULT_ON=y
>> -CONFIG_PAHOLE_HAS_SPLIT_BTF=y
>>  CONFIG_PAHOLE_HAS_BTF_TAG=y
>>  ```
> 
> The PAHOLE_HAS_SPLIT_BTF reference was removed from
> tools/sched_ext/README.md, but Documentation/scheduler/sched-ext.rst
> still contains this config option at line 46. Should that documentation
> file also be updated to remove this obsolete config option?

Yes. I thought I removed it, but the change got lost in translation.

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19978081551

