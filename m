Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0363B350D7F
	for <dwarves@vger.kernel.org>; Tue, 30 Jun 2026 20:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782849778; cv=none; b=W5kbbGv+eD8/agAXZ0tdjdWcRD1YpjMJbf0OFQM1uRU09CbudmiOki9dqf4px76rlnZotsJuf+tmfUHQmbbmFPoEZODhmLcWJ1bey0XAkEV72eC0Tacco2bA1Sy4mwy/AQ4QlPAhyf+diW7vamS1HSmDphvOfkY5rUjd6AFjs3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782849778; c=relaxed/simple;
	bh=xst1DzWdaxXFt4+BZXS6RCE0rafa1NrbAxCW+tfUIBo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=oA6P17JVoMsY4XLbiwgriXFQX5vOSN+Dn0nZud6257CgNvIMVyT7RPsYrlYfoD9kzlC747BTFXFHPJWE2pKh2ICgFtBG4MoepVPZP21UmV86xe5efwnoa7xPBQaPrDDeRQZhs0/W1iG8mUz1QlM0LLzxhUgSWkqOEnRuhxgcmbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Jl6FnrHy; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Jl6FnrHy"
Message-ID: <252c53f3-3f06-40f4-9cd3-795eb298687c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782849763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H8t0Qt4F0E73z5RniCMl52vonFMgOcmL/y7SG1J9PCI=;
	b=Jl6FnrHyLFWcueY9vSMQnTQ+5nWLI+TkaF9oExI+qY9Q98jExQIE5wCeD/nGNEsZikk5BT
	31LwNzJSi7+6JuC3VBPHLY/3uCXySfph1P8isdRJMHcXDlQhgl2FiQSTIKlbSnXkFQDqbo
	1Q0RbS7kZxR0fo2ORtXGE/TOdEIsNS8=
Date: Tue, 30 Jun 2026 13:02:23 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PAHOLE v4 2/3] dwarf_loader: Add support for
 DW_TAG_GNU_annotation
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vineet Gupta <vineet.gupta@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>, dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 acme@kernel.org, Alan Maguire <alan.maguire@oracle.com>,
 Emil Tsalapatis <emil@etsalapatis.com>, jose.marchesi@oracle.com,
 David Faust <david.faust@oracle.com>
References: <20260602195512.1511013-1-vineet.gupta@linux.dev>
 <20260602195512.1511013-2-vineet.gupta@linux.dev>
 <9152fde6-d35c-4688-9ff1-c7fe152c9b2a@linux.dev>
 <4e425892-2aec-4fee-a199-7fe9c615d982@linux.dev>
Content-Language: en-US
In-Reply-To: <4e425892-2aec-4fee-a199-7fe9c615d982@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 6/17/26 11:18 AM, Vineet Gupta wrote:
> On 6/3/26 1:08 PM, Yonghong Song wrote:
>> For decl tag
>> ============
>>
>> $ cat decl_tag.c
>> /* btf_decl_tag test cases.
>>     *
>>     * btf_decl_tag can be attached to:
>>     *   - global (incl. static) variables
>>     *   - functions
>>     *   - function parameters
>>     *   - struct/union types and their members
>>     *   - typedefs
>>     *
>>     * Build:  clang -O2 -target bpf -g -c decl_tag.c -o decl_tag.o
>>     *         /home/yhs/work/gcc-build/opt/gcc-16.1/bin/gcc -O2 -gbtf -g -c decl_tag.c -o decl_tag.o
>>     * Dump:   bpftool btf dump file decl_tag.o
>>     */
>>
>> #define __tag(x) __attribute__((btf_decl_tag(x)))
>>
>> /* tag on a global variable */
>> int global_var __tag("global_var_tag");
>>
>> /* tag on a static variable */
>> static int static_var __tag("static_var_tag");
>>
>> /* multiple tags on one declaration */
>> int multi_tag_var __tag("tag_a") __tag("tag_b");
>>
>> /* tag on struct type and its members */
>> struct foo {
>>            int a __tag("member_a_tag");
>>            int b __tag("member_b_tag");
>> } __tag("struct_foo_tag");
>>
>> /* tag on a typedef */
>> typedef struct foo foo_t1 __tag("typedef_foo_tag");
>> typedef struct {int foo2;} foo_t2 __tag("typedef_foo2_tag");
>>
>> /* tag on a function and its parameters */
>> __tag("func_add_tag")
>> int add(int x __tag("param_x_tag"), int y __tag("param_y_tag"))
>> {
>>            return x + y;
>> }
>>
>> /* keep the globals/types alive so they land in BTF */
>> int use(foo_t1 *f, foo_t2 *g)
>> {
>>            return add(global_var + static_var + multi_tag_var, f->a + g->foo2);
>> }
>>
>> $ /home/yhs/work/gcc-build/opt/gcc-16.1/bin/gcc -O2 -gbtf -g -c decl_tag.c -o decl_tag.o
>> decl_tag.c:30:1: warning: ‘btf_decl_tag’ attribute does not apply to types [-Wattributes]
>>       30 | } __tag("struct_foo_tag");
>>          | ^
>>
> [snip]
>
>> Three decl tags (struct_foo_tag, typedef_foo_tag and typedef_foo2_tag)
>> are missing here:
>>
>> struct foo {
>>            int a __tag("member_a_tag");
>>            int b __tag("member_b_tag");
>> } __tag("struct_foo_tag");
>>
>> /* tag on a typedef */
>> typedef struct foo foo_t1 __tag("typedef_foo_tag");
>> typedef struct {int foo2;} foo_t2 __tag("typedef_foo2_tag");
> Semantically what does this mean ? Will the decl tag will be "applied"
> where ever the type is instantiated ?

So these are dec tags (not type tags) on typedefs.
Are these still relevant after the change below for supporting type tags 
on typedefs (and gcc has in flight patches to do the same).

    commit 5754a48780f516cbc06eeb2a31b1e445ddd9c935
    Author: yonghong-song <yhs@fb.com>
    Date:   Mon Jun 15 10:51:02 2026 -0700
         [Clang][BPF] Support btf_type_tag on typedef underlying types (#203089)
         Emil Tsalapatis suggested to add type tag for typedef like below:
         ```
           $ cat tag.c
           #define __type_tag(x) __attribute__((btf_type_tag(x)))
           struct bar { int c; int d; };
           typedef struct bar __type_tag("a") bar_t;
           int use(bar_t *v)
           {
             return v->c + v->d;
           }
         ```
         This makes the code simpler -- using `bar_t *v` instead of the longer
         form `struct bar __type_tag("a") *v`.
         So the goal is to allow type tag for typedef underlying types. The
         following describes the main changes:


And if so, how are they semantically different and what's the use case 
fot decl tags on typedefs.

> OK, opened PR/125862 [1]  for future improvement.
>
> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=125862

If not, we can close this gcc PR as won't fix / not needed.

Thx,
-Vineet
