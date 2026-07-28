Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F0D13790B
	for <dwarves@vger.kernel.org>; Tue, 28 Jul 2026 03:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785207711; cv=none; b=nsVOgu2kFi+sob07Y4C6clWTGDBfBwgQ74UCTVkremJ1hg7uQetyLUJrllke0xWymyUKqEYJVmMViti1WbkDdEcBkN9QEjfHMa8qyqT/4m6AWuZaFm6Ay5Fs4uLe+ycTfJJwRElGITg0nZEqNi3xMal/0Na4rI12WGwv7wUNEF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785207711; c=relaxed/simple;
	bh=SWF3Xg76/jG3GjuNhXbOTWuiv/NKpcBduP7nweZEe68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BpRPjzNtYU2ynSHd+udx4pxoR2ASgu/TlhQz316DOREI81EDULoFfkIZMkcQq+ngvGqXPdKLc3qPNPWeyvvi8MOGizX1VOq7uK4otlQlGUhqaShHyi+PiPdsD8fK3L9UPqzLIWzJmTxRm52ixGHMGzSkHK5XshPumTMnBIgtDq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RIzzWfqq; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RIzzWfqq"
Message-ID: <42f7a2d9-8ffd-4066-bb02-9392ad21a416@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785207697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O7ecUA3pSVzIK+RUU1iD1tJsj3Wcw4Lt1xAhQZIlqnc=;
	b=RIzzWfqqQgjfptayX7ADbBpNVJeNSSZZKnoi15XIhK0sBgM2inw55OkeQtYS8u1c6aS3aS
	qVRpCDgCGz+qoEFunFWShZ2CcSiPYuLpGn6pCwMUkJpk97H5Bk+tuVOngx+udpxRscaLyj
	as0YyoyrZ6CSS45OQ0f/vgeHx89DRGs=
Date: Mon, 27 Jul 2026 20:01:20 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PAHOLE v4 2/3] dwarf_loader: Add support for
 DW_TAG_GNU_annotation
Content-Language: en-GB
To: David Faust <david.faust@oracle.com>,
 Vineet Gupta <vineet.gupta@linux.dev>, dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 acme@kernel.org, Alan Maguire <alan.maguire@oracle.com>,
 Emil Tsalapatis <emil@etsalapatis.com>, jose.marchesi@oracle.com
References: <20260602195512.1511013-1-vineet.gupta@linux.dev>
 <20260602195512.1511013-2-vineet.gupta@linux.dev>
 <9152fde6-d35c-4688-9ff1-c7fe152c9b2a@linux.dev>
 <4e425892-2aec-4fee-a199-7fe9c615d982@linux.dev>
 <252c53f3-3f06-40f4-9cd3-795eb298687c@linux.dev>
 <c9beceb9-946d-47ce-9311-4b9559f21613@linux.dev>
 <a0bc5009-0c11-4909-9ae1-7dc873a78ff9@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <a0bc5009-0c11-4909-9ae1-7dc873a78ff9@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 7/16/26 9:12 AM, David Faust wrote:
>
> On 7/1/26 10:14, Yonghong Song wrote:
>>
>> On 6/30/26 1:02 PM, Vineet Gupta wrote:
>>> On 6/17/26 11:18 AM, Vineet Gupta wrote:
>>>> On 6/3/26 1:08 PM, Yonghong Song wrote:
>>>>> For decl tag
>>>>> ============
>>>>>
>>>>> $ cat decl_tag.c
>>>>> /* btf_decl_tag test cases.
>>>>>      *
>>>>>      * btf_decl_tag can be attached to:
>>>>>      *   - global (incl. static) variables
>>>>>      *   - functions
>>>>>      *   - function parameters
>>>>>      *   - struct/union types and their members
>>>>>      *   - typedefs
>>>>>      *
>>>>>      * Build:  clang -O2 -target bpf -g -c decl_tag.c -o decl_tag.o
>>>>>      *         /home/yhs/work/gcc-build/opt/gcc-16.1/bin/gcc -O2
>>>>> -gbtf -g -c decl_tag.c -o decl_tag.o
>>>>>      * Dump:   bpftool btf dump file decl_tag.o
>>>>>      */
>>>>>
>>>>> #define __tag(x) __attribute__((btf_decl_tag(x)))
>>>>>
>>>>> /* tag on a global variable */
>>>>> int global_var __tag("global_var_tag");
>>>>>
>>>>> /* tag on a static variable */
>>>>> static int static_var __tag("static_var_tag");
>>>>>
>>>>> /* multiple tags on one declaration */
>>>>> int multi_tag_var __tag("tag_a") __tag("tag_b");
>>>>>
>>>>> /* tag on struct type and its members */
>>>>> struct foo {
>>>>>             int a __tag("member_a_tag");
>>>>>             int b __tag("member_b_tag");
>>>>> } __tag("struct_foo_tag");
>>>>>
>>>>> /* tag on a typedef */
>>>>> typedef struct foo foo_t1 __tag("typedef_foo_tag");
>>>>> typedef struct {int foo2;} foo_t2 __tag("typedef_foo2_tag");
>>>>>
>>>>> /* tag on a function and its parameters */
>>>>> __tag("func_add_tag")
>>>>> int add(int x __tag("param_x_tag"), int y __tag("param_y_tag"))
>>>>> {
>>>>>             return x + y;
>>>>> }
>>>>>
>>>>> /* keep the globals/types alive so they land in BTF */
>>>>> int use(foo_t1 *f, foo_t2 *g)
>>>>> {
>>>>>             return add(global_var + static_var + multi_tag_var, f->a
>>>>> + g->foo2);
>>>>> }
>>>>>
>>>>> $ /home/yhs/work/gcc-build/opt/gcc-16.1/bin/gcc -O2 -gbtf -g -c
>>>>> decl_tag.c -o decl_tag.o
>>>>> decl_tag.c:30:1: warning: ‘btf_decl_tag’ attribute does not apply to
>>>>> types [-Wattributes]
>>>>>        30 | } __tag("struct_foo_tag");
>>>>>           | ^
>>>>>
>>>> [snip]
>>>>
>>>>> Three decl tags (struct_foo_tag, typedef_foo_tag and typedef_foo2_tag)
>>>>> are missing here:
>>>>>
>>>>> struct foo {
>>>>>             int a __tag("member_a_tag");
>>>>>             int b __tag("member_b_tag");
>>>>> } __tag("struct_foo_tag");
>>>>>
>>>>> /* tag on a typedef */
>>>>> typedef struct foo foo_t1 __tag("typedef_foo_tag");
>>>>> typedef struct {int foo2;} foo_t2 __tag("typedef_foo2_tag");
>>>> Semantically what does this mean ? Will the decl tag will be "applied"
>>>> where ever the type is instantiated ?
>>> So these are dec tags (not type tags) on typedefs.
>>> Are these still relevant after the change below for supporting type
>>> tags on typedefs (and gcc has in flight patches to do the same).
>>>
>>>     commit 5754a48780f516cbc06eeb2a31b1e445ddd9c935
>>>     Author: yonghong-song <yhs@fb.com>
>>>     Date:   Mon Jun 15 10:51:02 2026 -0700
>>>          [Clang][BPF] Support btf_type_tag on typedef underlying types
>>> (#203089)
>>>          Emil Tsalapatis suggested to add type tag for typedef like below:
>>>          ```
>>>            $ cat tag.c
>>>            #define __type_tag(x) __attribute__((btf_type_tag(x)))
>>>            struct bar { int c; int d; };
>>>            typedef struct bar __type_tag("a") bar_t;
>>>            int use(bar_t *v)
>>>            {
>>>              return v->c + v->d;
>>>            }
>>>          ```
>>>          This makes the code simpler -- using `bar_t *v` instead of the
>>> longer
>>>          form `struct bar __type_tag("a") *v`.
>>>          So the goal is to allow type tag for typedef underlying types.
>>> The
>>>          following describes the main changes:
>>>
>>>
>>> And if so, how are they semantically different and what's the use case
>>> fot decl tags on typedefs.
>> Decl tags and type tags are different in the above. Decl tags will be something like
>>
>>       decl_tag -> typedef -> ...
>>
>> Type tags will be something like\
>>
>>       typedef -> type_tag -> ...
>>
>> You can do both decl tag and type dag for the same typedef
>>
>>       decl_tag -> typedef -> type_tag -> ...
>>
>> There is a selftest (progs/test_btf_decl_tag.c) which has an example with decl_tag
>> for typedef.
> Curious about the above commit, in particular "on typedef underlying types".
>
> What is the motivation to only support type_tag specifically on the underlying
> type of a typedef but not elsewhere? Similar to only specifically supporting
> it in pointers but not elsewhere.
>
> I find it exceedingly strange that in this design, iiuc, one could do e.g.:
>
>    typedef int __typetag("foo") my_int;
>    my_int x;
>
>    var("x") -> typedef -> type_tag ("foo") -> int;
>
> but NOT
>
>    int __typetag("foo") x;
>
>    var("x") -> type_tag ("foo") -> int;
>
>
>
> I mean, why not just support type_tag on any type? Like cv-quals.

The original design is for potential use cases. And we don't think
kernel bpf will handle things like 'var("x") -> type_tag ("foo") -> int;'.
So we didn't allow arbitrary type_tag and only for cases where kernel bpf
may use.

>
>
>> About the question what is the use case for decl tags for typedef.
>> The initial llvm implementation is to have more coverage so we do not need
>> to add them later on. I didn't monitor this and not sure whether anybody
>> uses it or not.
>>
>> But I think gcc should implement
>>       typedef -> type_tag -> ...
>> if this is the case, I assume it should be easier for gcc to implement
>>       decl_tag -> typedef -> ...
>>
>>>> OK, opened PR/125862 [1]  for future improvement.
>>>>
>>>> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=125862
>>> If not, we can close this gcc PR as won't fix / not needed.
>>>
>>> Thx,
>>> -Vineet

