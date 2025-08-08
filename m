Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DD61DE8A4
	for <dwarves@vger.kernel.org>; Fri,  8 Aug 2025 05:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754631579; cv=none; b=kynq4iwRahMcPfmV2v1WRWgmLYQB52f3o1rT2MnDBOyl2dD4AyMpfG1t+Kzgz13dNbxKl+bGIpOh9rc2Vb343dUrU51pw5ZTaiQ+8dCJXBLTlTVO6l98AoQ+pmsnmzgWrvok//8Oix9FfUiAqbGI/i7PjZyjha1rpFwG2YO04Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754631579; c=relaxed/simple;
	bh=yXbjJdigZXnr2v/PBLY6jCPCgPn7EXSZA5XqGHNRu3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EU6tLUAhv0gq0SjeEp1ukKWekQ7RA/5o2pInHsUdOIHWhQrcdJLNl54UWJjteJrp8E33VlT+kIxMcgli8W5uU68YNorgcCeKKa3+HIdzZ+OsVPIW2rmtW06eK4gZyIHGyaH8PNKEM9rKZg1yLZiPWIl9J2g7+uvElbyh1FDVgi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=leW4gXu+; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="leW4gXu+"
Message-ID: <0ce8e869-69aa-41d8-9bc0-422c28081818@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754631569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f8J3/j/nGYCphop2XSpc/ducCsk6pFOUvKoJbDQnig4=;
	b=leW4gXu+4I2VNdt35AOQzPPs8LYIeJHHuvZoDux9axrbu/wH70TWj720gY1TOIYo8T6ZEL
	AlDQEjM65Du64LOSaeCaU19mG+PEuFkhkBTfP3EwFndKSV7vcoyB0rfxWr2T1mT5MtQgAJ
	uGmzTeHos36LhALnCiVlMP1Xbmow4p8=
Date: Thu, 7 Aug 2025 22:39:22 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC dwarves 5/6] btf_encoder: Do not error out if BTF is not
 found in some input files
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, dwarves
 <dwarves@vger.kernel.org>, bpf <bpf@vger.kernel.org>
References: <20250807144209.1845760-1-alan.maguire@oracle.com>
 <20250807144209.1845760-6-alan.maguire@oracle.com>
 <CAADnVQK38yk3XO9cebrXhMUSK10bH2LVPvs6W4e168x3mGpTWA@mail.gmail.com>
 <87cy972imt.fsf@oracle.com>
 <CAADnVQ+x3Jir0s=nsvw7eV54FJjFkfwx=+xWMM4bFHHmwD5ORw@mail.gmail.com>
 <1c78d157e7f174fd3eb154bf0655f0d14650b43e.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <1c78d157e7f174fd3eb154bf0655f0d14650b43e.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 8/7/25 12:18 PM, Eduard Zingerman wrote:
> On Thu, 2025-08-07 at 10:12 -0700, Alexei Starovoitov wrote:
>> On Thu, Aug 7, 2025 at 9:37 AM Jose E. Marchesi
>> <jose.marchesi@oracle.com> wrote:
>>>
>>>> On Thu, Aug 7, 2025 at 7:42 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>> This is no substitute for link-time BTF deduplication of course, but
>>>>> it does provide a simple way to see the BTF that gcc generates for vmlinux.
>>>>>
>>>>> The idea is that we can explore differences in BTF generation across
>>>>> the various combinations
>>>>>
>>>>> 1. debug info source: DWARF; dedup done via pahole (traditional)
>>>>> 2. debug info source: compiler-generated BTF; dedup done via pahole (above)
>>>>> 3. debug info source: compiler-generated BTF; dedup done via linker (TBD)
>>>>>
>>>>> Handling 3 - linker-based dedup - will require BTF archives so that is the
>>>>> next step we need to explore.
>>>> Overall, the patch set makes sense and we need to make this step in pahole,
>>>> but before we start any discussion about 3 and BTF archives
>>>> the 1 and 2 above need to reach parity.
>>>> Not just being close enough, but an exact equivalence.
>>>>
>>>> But, frankly, gcc support for btf_decl_tags is much much higher priority
>>>> than any of this.
>>>>
>>>> We're tired of adding hacks through the bpf subsystem, because
>>>> gcc cannot do decl_tags.
>>>> Here are the hacks that will be removed:
>>>> 1. BTF_TYPE_SAFE*
>>>> 2. raw_tp_null_args[]
>>>> 3. KF_ARENA_ARG
>>>> and probably other cases.
>>> We are getting there.  The C front-end maintainer just looked at the
>>> latest version of the series [1] and, other than a small observation
>>> concerning wide char strings, he seems to be ok with the attributes.
>>>
>>> [1] https://gcc.gnu.org/pipermail/gcc-patches/2025-August/692057.html
>> Good to know.
>>
>> Yonghong, what does llvm do with wchar?
> The literal is copied as-is with a warning.
>
>    $ cat wide-string-test.c
>    __attribute__((btf_decl_tag(u8"üüü")))
>    int foo(void) { return 42; }
>
>    $ clang --target=bpf -O2 -g wide-string-test.c -c -o wide-string-test.o
>    wide-string-test.c:1:29: warning: encoding prefix 'u8' on an unevaluated string literal has no effect [-Winvalid-unevaluated-string]
>        1 | __attribute__((btf_decl_tag(u8"üüü")))
>          |                             ^~
>    1 warning generated.
>
>    $ bpftool btf dump file wide-string-test.o
>    [1] FUNC_PROTO '(anon)' ret_type_id=2 vlen=0
>    [2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
>    [3] FUNC 'foo' type_id=1 linkage=global
>    [4] DECL_TAG 'üüü' type_id=3 component_idx=-1
>
> "As-is" means using compiler internal encoding (UTF8),
> e.g. above u8"üüü" is encoded as "c3 bc c3 bc c3 bc" in the final .BTF
> section, same happens for UTF32 literal U"üüü".

If we remove 'u8' prefix, there will be no warnings. For example,

$ cat wide-string-test.c
__attribute__((btf_decl_tag("üüü")))
int foo(void) { return 42; }
$ clang --target=bpf -O2 -g wide-string-test.c -c -o wide-string-test.o
$

"üüü" will be treated similar to other ascii strings w.r.t. decl/type tag.

