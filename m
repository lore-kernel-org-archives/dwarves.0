Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF637379ED6
	for <dwarves@vger.kernel.org>; Wed, 17 Jun 2026 18:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781720316; cv=none; b=uKkMjDFzIHpd41ITaO+TgZnZqcNqqkN6KbanMs3Y4QHKlJVRUJcKsj3gMINc5QlHyJDPhxL57MAek1z+viuZWJVF+meCKgbWMn43IaEqkz4bJJLMH0BeFj6YtBtiJUYiA5lAemKl/8RMsai7rpQsOiSKiT4hqqts0MgWCELvAyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781720316; c=relaxed/simple;
	bh=7qTZpQrUp5K+Zb0CqYqRXXo/XKysAbuofskHW5jiiyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sng4ianqH4hZ2KuvHFAZ8crj5lBzVm/FXQt2ztezdsGI6Pk3N+YpMgkYl7bGKaA6MGLrrPxff/dvNi4T1Y3pgLzyeul4s0U3ULEWxJV1oS1bbNXo//gow0ywoQrit/z3ItE+kTSwalUbrpBmsRZD0aqmKRqjqmtzmwi681wzse8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QT1eplSs; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QT1eplSs"
Message-ID: <4e425892-2aec-4fee-a199-7fe9c615d982@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781720301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4EXE/8+Y6tXL0YAPhqNVvGIqIngTRpck0IjjxP+xLW0=;
	b=QT1eplSsRl/4vCM1R8bnDECJwEiGlKsfv+rxe8sBs00dCg73egQRcQG7LNnrIyHDExCcTc
	SQGTDipJF+mwtyvpReVCRCx3ct448n/Zpm7ABZBofyUOiOYr6n0t2z9j7ZRTIFQ6+WeV4h
	FfF/yX0OgPO8U1M+5XN9pK+5t8hE3GQ=
Date: Wed, 17 Jun 2026 11:18:13 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PAHOLE v4 2/3] dwarf_loader: Add support for
 DW_TAG_GNU_annotation
To: Yonghong Song <yonghong.song@linux.dev>, dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 acme@kernel.org, Alan Maguire <alan.maguire@oracle.com>,
 Emil Tsalapatis <emil@etsalapatis.com>, jose.marchesi@oracle.com,
 David Faust <david.faust@oracle.com>
References: <20260602195512.1511013-1-vineet.gupta@linux.dev>
 <20260602195512.1511013-2-vineet.gupta@linux.dev>
 <9152fde6-d35c-4688-9ff1-c7fe152c9b2a@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <9152fde6-d35c-4688-9ff1-c7fe152c9b2a@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 6/3/26 1:08 PM, Yonghong Song wrote:
> I download and build gcc-16.1 which will be used for gcc compilation.
> I did some experiments with this patch set for both type tag and decl tag.

Thx for this doing this exercise.

> For type tag
> ============

[snip]

> So type tag matches between clang and gcc.

Nice !

> For decl tag
> ============
>
> $ cat decl_tag.c
> /* btf_decl_tag test cases.
>    *
>    * btf_decl_tag can be attached to:
>    *   - global (incl. static) variables
>    *   - functions
>    *   - function parameters
>    *   - struct/union types and their members
>    *   - typedefs
>    *
>    * Build:  clang -O2 -target bpf -g -c decl_tag.c -o decl_tag.o
>    *         /home/yhs/work/gcc-build/opt/gcc-16.1/bin/gcc -O2 -gbtf -g -c decl_tag.c -o decl_tag.o
>    * Dump:   bpftool btf dump file decl_tag.o
>    */
>
> #define __tag(x) __attribute__((btf_decl_tag(x)))
>
> /* tag on a global variable */
> int global_var __tag("global_var_tag");
>
> /* tag on a static variable */
> static int static_var __tag("static_var_tag");
>
> /* multiple tags on one declaration */
> int multi_tag_var __tag("tag_a") __tag("tag_b");
>
> /* tag on struct type and its members */
> struct foo {
>           int a __tag("member_a_tag");
>           int b __tag("member_b_tag");
> } __tag("struct_foo_tag");
>
> /* tag on a typedef */
> typedef struct foo foo_t1 __tag("typedef_foo_tag");
> typedef struct {int foo2;} foo_t2 __tag("typedef_foo2_tag");
>
> /* tag on a function and its parameters */
> __tag("func_add_tag")
> int add(int x __tag("param_x_tag"), int y __tag("param_y_tag"))
> {
>           return x + y;
> }
>
> /* keep the globals/types alive so they land in BTF */
> int use(foo_t1 *f, foo_t2 *g)
> {
>           return add(global_var + static_var + multi_tag_var, f->a + g->foo2);
> }
>
> $ /home/yhs/work/gcc-build/opt/gcc-16.1/bin/gcc -O2 -gbtf -g -c decl_tag.c -o decl_tag.o
> decl_tag.c:30:1: warning: ‘btf_decl_tag’ attribute does not apply to types [-Wattributes]
>      30 | } __tag("struct_foo_tag");
>         | ^
>
[snip]

> Three decl tags (struct_foo_tag, typedef_foo_tag and typedef_foo2_tag)
> are missing here:
>
> struct foo {
>           int a __tag("member_a_tag");
>           int b __tag("member_b_tag");
> } __tag("struct_foo_tag");
>
> /* tag on a typedef */
> typedef struct foo foo_t1 __tag("typedef_foo_tag");
> typedef struct {int foo2;} foo_t2 __tag("typedef_foo2_tag");

Semantically what does this mean ? Will the decl tag will be "applied" 
where ever the type is instantiated ?

> /* tag on a static variable */
> static int static_var __tag("static_var_tag");
>
> ...
>
> [24] DECL_TAG 'tag_b' type_id=22 component_idx=-1
>
> DECL_TAG 'static_var_tag' type_id=0 component_idx=-1 is missing in llvm.
> This is execpted for llvm since 'static_var' is 'inlined' since it is
> value is 0 and the compiler optimization removed it in function use().
> In llvm Dwarf->BTF conversion is very late and we only emit survived
> globals.
>
> gcc emits 'static_var_tag' probably in frontend. Emitting
> 'static_var_tag' is okay, just not used.

Yeah I recall something like this when talking to David.
We can live with this it seems.

> I think gcc should support
>    - declaration tag for typedef, and
>    - declaration tag for the whole struct (like above 'struct_foo_tag')
> to be compatible with llvm.

OK, opened PR/125862 [1]  for future improvement.

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=125862

Thx,
-Vineet
