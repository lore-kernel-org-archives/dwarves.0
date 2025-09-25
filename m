Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9D81D5CD9
	for <dwarves@vger.kernel.org>; Thu, 25 Sep 2025 16:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758817985; cv=none; b=pTwgMW34OZfpAVw1khw03/+yAe2tOM99aw0+ZIxap2iZ78WCvwNb4VDamqT5y3kdOMgiDL+p7W2kujgMib64hkEV7evk+teFd/NH689BQTK5+rcAeaEix13qVet9B+xwG5zcYP0WCqYZWeXrgeAJELMbzyKYUwfDPHRJWkhuz1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758817985; c=relaxed/simple;
	bh=S3NKEt4GRgoBwPONRw+g8M2LkQgCWtko1S2apP7hbdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CeN6Rly6x4ocIeaI0L/FhLeMsdVDwpDU/OSl8/S+k4T9de6WSgYJDNQOUVqefQF4wK6qTubcMhN/i3aEzyLQlxunOl6YgzIkax9no4biVuAwRQy6gZRgnMsy5Wceb1HU93JvYCpenXJwViuESmqQgXIrN37UKvz0ON7bAPdIRwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kULI3936; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kULI3936"
Message-ID: <977e0020-fb79-4bf7-9349-cd99dc0d93d6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758817981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XHyNLQlojJR72U3JVe8KHfwEXQ2ZW6KVB1AD3T02K0A=;
	b=kULI3936GhlERED/54S8LILzUfOPEmXkPI3zcfMSH4D1UNT8RO+Y5kfvLBfKFIrGOi7pqp
	U+eWD612LQdfa7XVAN/p9/cAKoybrJqMv3GHRejORIEeEf/SNcGThIZ5ntQEDZx4jxase9
	Prf8hO6CaJ13AFvK1ySlBv+HOElNBGc=
Date: Thu, 25 Sep 2025 09:32:55 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 5/6] bpf: mark bpf_stream_vprink kfunc with
 KF_IMPLICIT_PROG_AUX_ARG
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, dwarves <dwarves@vger.kernel.org>,
 Alan Maguire <alan.maguire@oracle.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Eduard <eddyz87@gmail.com>,
 Tejun Heo <tj@kernel.org>, Kernel Team <kernel-team@meta.com>
References: <20250924211716.1287715-1-ihor.solodrai@linux.dev>
 <20250924211716.1287715-6-ihor.solodrai@linux.dev>
 <CAADnVQLVeZd0JOz-GBgZfi=t5kvtH_z1Ri2w6b-AW7DHgEBv5w@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAADnVQLVeZd0JOz-GBgZfi=t5kvtH_z1Ri2w6b-AW7DHgEBv5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 9/25/25 3:01 AM, Alexei Starovoitov wrote:
> On Wed, Sep 24, 2025 at 10:17 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> Update bpf_stream_vprink macro in libbpf and fix call sites in
> 
> 't' is missing in bpf_stream_vprintk().
> 
>> the relevant selftests.
>>
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>> ---
>>  kernel/bpf/helpers.c                            | 2 +-
>>  kernel/bpf/stream.c                             | 3 +--
>>  tools/lib/bpf/bpf_helpers.h                     | 4 ++--
>>  tools/testing/selftests/bpf/progs/stream_fail.c | 6 +++---
>>  4 files changed, 7 insertions(+), 8 deletions(-)
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 6b46acfec790..875195a0ea72 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -4378,7 +4378,7 @@ BTF_ID_FLAGS(func, bpf_strnstr);
>>  #if defined(CONFIG_BPF_LSM) && defined(CONFIG_CGROUPS)
>>  BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
>>  #endif
>> -BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_TRUSTED_ARGS)
>> +BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_TRUSTED_ARGS | KF_IMPLICIT_PROG_AUX_ARG)
> 
> This kfunc will be in part of 6.17 release in a couple days,
> so backward compat work is necessary.
> I don't think we can just remove the arg.

Acked.

> 
>> --- a/tools/lib/bpf/bpf_helpers.h
>> +++ b/tools/lib/bpf/bpf_helpers.h
>> @@ -316,7 +316,7 @@ enum libbpf_tristate {
>>  })
>>
>>  extern int bpf_stream_vprintk(int stream_id, const char *fmt__str, const void *args,
>> -                             __u32 len__sz, void *aux__prog) __weak __ksym;
>> +                             __u32 len__sz) __weak __ksym;
> 
> CI is complaining of conflicting types for 'bpf_stream_vprintk',
> since it's using pahole master.
> It will stop complaining once pahole changes are merged,
> but this issue will affect all developers until they
> update pahole.
> Not sure how to keep backward compat.

Right.

One way to do it is to conditionalize new kfunc defitions under a
config flag similar to how we have CONFIG_PAHOLE_HAS_SPLIT_BTF and co.

But this seems like too much trouble for just a couple of kfuncs,
especially since we do not guarantee stable interface for kfuncs.

We could ask people to update pahole version if they run into
issues. And they shouldn't unless they are actually using the kfuncs,
or more specifically: have their own declarations of said kfuncs.

bpf_stream_vprintk() is a special case, because it is already in
libbpf.
