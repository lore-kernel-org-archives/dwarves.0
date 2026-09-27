Received: from mta1.migadu.com (out-4.mta1.migadu.com [95.215.58.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E212DB7BE
	for <dwarves@vger.kernel.org>; Sun, 27 Sep 2026 05:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790488183; cv=none; b=sVTOFJ6OS25Z1epsPniwGF1Lk3SZ71RePdoFP212An8ok9LlSlrvw9zPHxS5l7UeyQX4DMUXWYG0NpHP9Iqw9vW1PFLa7IVKLpgcDBWIB/EUTDI/UI6nzz4eKA60Tf6yHB8a35LlMYRh6g/YTAZ7UMqQsWuyZ9IesOYNgpKhLjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790488183; c=relaxed/simple;
	bh=dfPLd2FnRW/99bwR4QFd27uQCYqrxoTkbXr1ugbGMaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XzUsEHHgBx02vT61Uwl7HOtyrv6eP0EaDqbUWkDyAd533ZxNosyIwGrV2ROsJevoM6Jl3WO6UKhkOXBgTGXoCLMSD+OqtHI+9scaGorF4KI2EhBshCkOFZJ1QuC94GHB7tpOjWZsWc8bNrkXygoQZpAaAUFzY0C3YeIsYQqzZ0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BCXT4sYW; arc=none smtp.client-ip=95.215.58.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BCXT4sYW"
X-Envelope-To: dwarves@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=dfPLd2FnRW/99bwR4QFd27uQCYqrxoTkbXr1ugbGMaw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790488179; v=1; x=1791092979;
 b=BCXT4sYWjbFDcHRIovxphf0t4OhYmVfnW1OhdOnttb3GeF4fUTktOHsQm0WYx28K4vnLm/B6
 ZUuKA6pwGjMSXZVc5QcD8y+IZYncLYNXlBBzAjxnFltEfoC6mLnkkmOrrte1aTi0IXTJZtlCaKT
 KLtmC50j4Xf+vjeqiT3et43w=
X-Envelope-To: dwarves@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 973c231d1a8be2b5;
	Sun, 27 Sep 2026 05:49:39 +0000
X-Mizu-Trace-ID: 973c231d1a8be2b5
X-Migadu-Flow: FLOW_OUT
Message-ID: <e3f30691-a5d8-41b8-a075-10cf8cf4bd95@linux.dev>
Date: Sat, 26 Sep 2026 22:49:35 -0700
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
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DLP2WZASF7LP.18SWCONJDR4LV@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/26/26 12:45 AM, Alexei Starovoitov wrote:
> On Fri, Sep 25, 2026 at 02:36 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> DW_OP_entry_value(DW_OP_regN) says the parameter still holds the value regN
>> had on entry to the function, so regN is by definition the register the
>> parameter was passed in.  That is better evidence than the first location
>> list entry, so prefer it.
> my bot is saying that this is not quite the case.
>
> gcc 13 -O2 for
>
> long f6(long a, long b)
> {
> 	b = a;
> 	ext();
> 	ext();
> 	return 0;
> }
>
> describes 'b' as:
>    [0x40, 0x44): DW_OP_reg4 RSI
>    [0x44, 0x4c): DW_OP_reg5 RDI
>    [0x4c, 0x59): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value

I tried with the above example.

$ cat t1.c
void ext(void);
long f6(long a, long b)
{
         b = a;
         ext();
         ext();
         return 0;
}

$ gcc -O2 -c -g t1.c.  # gcc14
$ llvm-dwarfdump t1.o
...

0x00000053:     DW_TAG_formal_parameter
                   DW_AT_name    ("a")
                   DW_AT_decl_file       ("/home/yhs/tmp/t1.c")
                   DW_AT_decl_line       (2)
                   DW_AT_decl_column     (14)
                   DW_AT_type    (0x0000008e "long int")
                   DW_AT_location        (0x00000010:
                      [0x0000000000000000, 0x0000000000000008): DW_OP_reg5 RDI
                      [0x0000000000000008, 0x0000000000000015): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value)
                   DW_AT_GNU_locviews    (0x0000000c)

0x00000063:     DW_TAG_formal_parameter
                   DW_AT_name    ("b")
                   DW_AT_decl_file       ("/home/yhs/tmp/t1.c")
                   DW_AT_decl_line       (2)
                   DW_AT_decl_column     (22)
                   DW_AT_type    (0x0000008e "long int")
                   DW_AT_location        (0x0000002d:
                      [0x0000000000000000, 0x0000000000000000): DW_OP_reg4 RSI
                      [0x0000000000000000, 0x0000000000000008): DW_OP_reg5 RDI
                      [0x0000000000000008, 0x0000000000000015): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value)
                   DW_AT_GNU_locviews    (0x00000027)

Maybe we need to poke into locations to get precise parameter register.
For example, for argument 'b', we have
	[0x0000000000000000, 0x0000000000000000): DW_OP_reg4 RSI
	...
	[0x0000000000000008, 0x0000000000000015): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value)
RSI has location starts from 0x0, RDI starts from 0x8 although it has DW_OP_entry_value.

But this makes things complicated, and there is no garantee across different compilers due to
code gen.

>
> pahole encodes f6() today. With this patch loc_reg of 'b' becomes RDI,
> RSI is expected, and f6() is dropped.

Okay, that means my patch actually not working.

>
>> +	if (entry_value_reg != PARAMETER_UNKNOWN_REG && !parameter__has_piece_info(parm))
>> +		parm->loc_reg = entry_value_reg;
> This fixes only the functions where clang happened to emit
> an entry value. clang -O2 for
>
> bool g_lazy(struct task *p, bool lazy)
> {
> 	rcu_lock();
> 	__atomic_store_n(&p->lazy, lazy, __ATOMIC_RELAXED);
> 	rcu_unlock();
> 	return lazy;
> }
>
> describes 'lazy' as:
>    [0x09, 0x1e): DW_OP_reg3 RBX
>    [0x1e, 0x21): DW_OP_reg0 RAX
>
> low_pc is 0. There is no entry value, so g_lazy() is still dropped.
> With 'int lazy' the list starts at low_pc with RSI.
> Looks like clang loses the entry range for every bool arg.

In some other cases, clang may generate even more complicated dwarf
for bool parameters.

One possible workaround is change 'lazy' type from 'bool' to say 'int'.
As Alexei mentioned in the above, clang didn't handle 'bool' well
in debug info.

