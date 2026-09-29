Received: from mta1.migadu.com (out-16.mta1.migadu.com [95.215.58.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CEE511E71
	for <dwarves@vger.kernel.org>; Tue, 29 Sep 2026 17:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790704780; cv=none; b=o4/t75b7QaHFf5kN5hcvViYUScEUfxrfxnY/Kul2JEPSyVZiSrPysRzZGVLE1sS5U0Hrg1LkUEWr63hTGl8JyAXMfHb/fK1v2v7x8EWOlgU2vU/j8vjUR1C2Il966PxypoDTTu0MUyknu1zDUI+aCyNO4AqFXZwJSyqCjnljSgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790704780; c=relaxed/simple;
	bh=nvDwR7D5xUNEfLr23LHFHtYc/r1DbyybvGN9zSJqDHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GPh2PZitPYqDz3Uf7cM2ga+pZa63ovW9JvUlCXx2xuSeXPVnVQwb35YkN3zcIz06LeI4IwlGSWbmEuwD5lfqc04M60OCzNicYZnf7SxdVJDd+SxOzE1d+JtN89v98vQvVGmn59l7Pkb23z5TaPQonlfsHqeZdQ63KNyRPhfZGqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PE6kp6d0; arc=none smtp.client-ip=95.215.58.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PE6kp6d0"
X-Envelope-To: dwarves@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=nvDwR7D5xUNEfLr23LHFHtYc/r1DbyybvGN9zSJqDHc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790704775; v=1; x=1791309575;
 b=PE6kp6d0yV9CtYByzmov1c8hqQipG0geqyX5nfyjLxRtSxJB1cPYkwJLe7JG0ybi92qHdyBe
 +DoxA9s+UOVHIoNNqNW+dYodpIhMkPoyCMsirljqz/SLFOjViEDgPlyXsiLwDalUbUwjiK6QbZy
 f0+b6qzjR6M7cjdTHOu3XS7o=
X-Envelope-To: dwarves@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7760a9e8107f8b0b;
	Tue, 29 Sep 2026 17:59:35 +0000
X-Mizu-Trace-ID: 7760a9e8107f8b0b
X-Migadu-Flow: FLOW_OUT
Message-ID: <2c5555c4-4dbf-44cd-8fd1-9da41740d23a@linux.dev>
Date: Tue, 29 Sep 2026 10:59:32 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves 1/2] dwarf_loader: Trust the entry value register
 over the first location entry
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Alan Maguire <alan.maguire@oracle.com>,
 Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, dwarves@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 kernel-team@fb.com, Tejun Heo <tj@kernel.org>
References: <20260925213619.2187751-1-yonghong.song@linux.dev>
 <DLP2WZASF7LP.18SWCONJDR4LV@gmail.com>
 <e3f30691-a5d8-41b8-a075-10cf8cf4bd95@linux.dev>
 <DLRKT5MG6W2P.2V1P0QD4GQEKY@gmail.com>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DLRKT5MG6W2P.2V1P0QD4GQEKY@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/28/26 11:11 PM, Alexei Starovoitov wrote:
> On Sat, Sep 26, 2026 at 10:49 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Maybe we need to poke into locations to get precise parameter register.
>> For example, for argument 'b', we have
>> 	[0x0000000000000000, 0x0000000000000000): DW_OP_reg4 RSI
>> 	...
>> 	[0x0000000000000008, 0x0000000000000015): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value)
>> RSI has location starts from 0x0, RDI starts from 0x8 although it has DW_OP_entry_value.
>>
>> But this makes things complicated, and there is no garantee across different compilers due to
>> code gen.
> I don't think it has to be complicated.
> In your gcc 14 dump the first entry of 'b' starts at low_pc and it's RSI.
> In scx_bpf_task_set_lazy_resched() low_pc is ...d70 and the first entry
> of 'lazy' starts at ...d8b. RBP there says nothing about the register
> 'lazy' was passed in.
> parameter__decode_location() already has 'start' of every entry.
> Can it take the register of the first entry only when that entry
> starts at low_pc and use the entry value otherwise?

Yes, this is what I thought as well.

>
> There is no guarantee, right, but when the guess is wrong the function
> is dropped. It's not encoded with a wrong signature.

Okay, no guarantee, but it should be an improvement.

>
>> One possible workaround is change 'lazy' type from 'bool' to say 'int'.
>> As Alexei mentioned in the above, clang didn't handle 'bool' well
>> in debug info.
> That works for this kfunc and for pahole that is already released,
> but every other function with a bool arg is still dropped.
> Can clang be fixed to keep the entry range?

Let me investigate this. Probably will be slow a little bit
due lpc and some other events.

