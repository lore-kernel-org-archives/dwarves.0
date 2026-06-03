Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159EE384CD6
	for <dwarves@vger.kernel.org>; Wed,  3 Jun 2026 20:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780517350; cv=none; b=fVxdwHdxDEw0MMwIhoCD6yBubRgpMXOdsNHeibqyfWmkl6D5paQcfzQpcItovlzoN6DPJbwMiWOmRAeUStch44NJCx9c5pix+8IOydPnE3t+Avkes+GEjXogmQd0ml+o1nmgYbNfqeZMuLGl8+l8ddJveXLJm31obWAnG4dv2pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780517350; c=relaxed/simple;
	bh=mHzMCXdHwcnRqCc1iyfzA/VFwfQr1OXUsMblG6/s2g0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j8HP5gOXW+W8rKut1Vc43qQY6A6zfJqgmnr7rXCkrwg0+jrmy3ubs9ySbGarr+zD9F0gRo49gknG5NU+D+PEldnJjsS/MPvjoln5Jy+lOBWbdaKs7px47jthWu2EbPuJiHkJv0hVJNXCPeMLjg4b5gwqropQ4bJ8WOx5pTrGzh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bJs2yxAo; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bJs2yxAo"
Message-ID: <9152fde6-d35c-4688-9ff1-c7fe152c9b2a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780517345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X/wT3bkQv7R5AugJIMnfQzYjsQR8VrEJXhEMloZJlws=;
	b=bJs2yxAo0APWV4fGvqrg5RApcFW52WFIFE0uW7QpoXXFzRccTPpnVp24EzFnohEnt2cfCk
	MCpsW4PltFzUnh/Rnc+C1whO81pj6cPo3FomR1e4OTWwC0yTy8w1akxofvzoLI/tgUgXxw
	/xTn24LSdQS0bIuclGjcDGdS0BzV9Hs=
Date: Wed, 3 Jun 2026 13:08:54 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PAHOLE v4 2/3] dwarf_loader: Add support for
 DW_TAG_GNU_annotation
Content-Language: en-GB
To: Vineet Gupta <vineet.gupta@linux.dev>, dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 acme@kernel.org, Alan Maguire <alan.maguire@oracle.com>,
 Emil Tsalapatis <emil@etsalapatis.com>, jose.marchesi@oracle.com,
 David Faust <david.faust@oracle.com>
References: <20260602195512.1511013-1-vineet.gupta@linux.dev>
 <20260602195512.1511013-2-vineet.gupta@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260602195512.1511013-2-vineet.gupta@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/2/26 12:55 PM, Vineet Gupta wrote:
> gcc 16 was the first release to support DW_TAG_GNU_annotations and this
> patch enables the same in pahole. Bulk of changes are dwarf_loader but
> btf_encoder also gains support with minimal changes.
>
> GCC encodes btf_type_tag and btf_decl_tag annotations differently from
> LLVM. While LLVM uses DW_TAG_LLVM_annotation (0x6000) as child DIEs,
> GCC uses DW_TAG_GNU_annotation (0x6001) as standalone sibling DIEs
> referenced via DW_AT_GNU_annotation (0x2139) attributes, with chaining
> through the same attribute on annotation DIEs themselves.
>
> Handle both encoding styles:
>
> For btf_type_tag (pointer annotations):
> - Recognize DW_TAG_GNU_annotation alongside DW_TAG_LLVM_annotation in
>    child annotation scanning.
> - Follow DW_AT_GNU_annotation attribute chains on pointer types for
>    GCC-style btf_type_tag resolution.
> - Normalize DW_TAG_GNU_annotation to DW_TAG_LLVM_annotation in the
>    internal representation so downstream code works unchanged.
>
> For btf_decl_tag (function/struct/member annotations):
> - Add add_gnu_annotation_chain() to follow DW_AT_GNU_annotation
>    attribute chains on function, struct, and member DIEs.
> - GCC puts DW_AT_GNU_annotation on the function/struct DIE itself
>    (not as child DIEs), referencing sibling annotation DIEs that chain
>    via the same attribute.
>
> Also:
> - Silently skip standalone DW_TAG_GNU_annotation DIEs at CU level.
> - Add tag__is_annotation() helper macro for annotation tag checks.
> - Rename add_llvm_annotation -> add_tag_annotation,
>    skip_llvm_annotations -> skip_tag_annotations since these now
>    handle both LLVM and GNU annotation formats.
>
> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
> ---
> Changes since v3 [3]
>   - Add helper tag__is_annotation [Emil]
>   - Rename some functions containing "llvm" as they are common to LLVM/GCC tags [Emil]
>   - Deduplicate checks before loop and inside loop in add_gnu_annotation_chain() and check_gnu_attr [Arnaldo]
>   - Fix some typos and move some comments [Emi]
>
> Changes since v2 [2]
>   - Removed loop detection logic [Alan]
>   - Move test changes to different patch [Alan]
>
> Changes since v1 [1]
>   - NFC Reduce indentation with early exits (Alexei offlist)
>
> [3] https://lore.kernel.org/bpf/20260601183511.594100-2-vineet.gupta@linux.dev/
> [2] https://lore.kernel.org/bpf/20260528223616.2035618-2-vineet.gupta@linux.dev/
> [1] https://lore.kernel.org/bpf/20260526181818.4159927-2-vineet.gupta@linux.dev/

I download and build gcc-16.1 which will be used for gcc compilation.
I did some experiments with this patch set for both type tag and decl tag.
See below.

For type tag
============

$ cat type_tag.c
/* btf_type_tag test cases.
  *
  * btf_type_tag annotates a *type* and the tag becomes part of the type
  * chain in BTF (TYPE_TAG kind), e.g. used by the kernel for __user / __rcu
  * / __percpu style annotations.
  *
  * Placement matters: the tag is written *before* the '*' so it annotates
  * the pointee type.  This produces  PTR -> TYPE_TAG 'x' -> <pointee>.
  *
  * Build:  clang -O2 -g -target bpf -c type_tag.c -o type_tag.o
  *         /home/yhs/work/gcc-build/opt/gcc-16.1/bin/gcc -O2 -gbtf -g -c type_tag.c -o type_tag.o
  * Dump:   bpftool btf dump file type_tag.o
  */

#define __type_tag(x) __attribute__((btf_type_tag(x)))

/* a single type tag on a pointer's pointee */
int __type_tag("user") *user_ptr_var;

/* stacked type tags: the chain is preserved, outermost first */
int __type_tag("tag1") __type_tag("tag2") *stacked_var;

/* type tags inside struct members */
struct bar {
         char __type_tag("rcu") *name;
         int  __type_tag("percpu") *counter;
};

/* type tag on a function parameter's pointee */
int read_user(int __type_tag("user") *p)
{
         return *p;
}

/* keep things referenced */
int use(struct bar *b)
{
         return read_user(user_ptr_var) + (stacked_var ? *stacked_var : 0) +
                (b->counter ? *b->counter : 0);
}

$ /home/yhs/work/gcc-build/opt/gcc-16.1/bin/gcc -O2 -gbtf -g -c type_tag.c -o type_tag.o
$ bpftool btf dump file type_tag.o
[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
[2] PTR '(anon)' type_id=15
[3] PTR '(anon)' type_id=17
[4] STRUCT 'bar' size=16 vlen=2
         'name' type_id=6 bits_offset=0
         'counter' type_id=7 bits_offset=64
[5] INT 'char' size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
[6] PTR '(anon)' type_id=18
[7] PTR '(anon)' type_id=19
[8] FUNC_PROTO '(anon)' ret_type_id=1 vlen=1
         'b' type_id=9
[9] PTR '(anon)' type_id=4
[10] FUNC_PROTO '(anon)' ret_type_id=1 vlen=1
         'p' type_id=2
[11] VAR 'stacked_var' type_id=3, linkage=global
[12] VAR 'user_ptr_var' type_id=2, linkage=global
[13] FUNC 'use' type_id=8 linkage=global
[14] FUNC 'read_user' type_id=10 linkage=global
[15] TYPE_TAG 'user' type_id=1
[16] TYPE_TAG 'tag1' type_id=1
[17] TYPE_TAG 'tag2' type_id=16
[18] TYPE_TAG 'rcu' type_id=5
[19] TYPE_TAG 'percpu' type_id=1
[20] DATASEC '.bss' size=0 vlen=2
         type_id=11 offset=0 size=8 (VAR 'stacked_var')
         type_id=12 offset=0 size=8 (VAR 'user_ptr_var')
$

$ clang -O2 -g -target bpf -c type_tag.c -o type_tag.o
$ bpftool btf dump file type_tag.o
[1] TYPE_TAG 'user' type_id=3
[2] PTR '(anon)' type_id=1
[3] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
[4] FUNC_PROTO '(anon)' ret_type_id=3 vlen=1
         'p' type_id=2
[5] FUNC 'read_user' type_id=4 linkage=global
[6] PTR '(anon)' type_id=7
[7] STRUCT 'bar' size=16 vlen=2
         'name' type_id=9 bits_offset=0
         'counter' type_id=12 bits_offset=64
[8] TYPE_TAG 'rcu' type_id=10
[9] PTR '(anon)' type_id=8
[10] INT 'char' size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
[11] TYPE_TAG 'percpu' type_id=3
[12] PTR '(anon)' type_id=11
[13] FUNC_PROTO '(anon)' ret_type_id=3 vlen=1
         'b' type_id=6
[14] FUNC 'use' type_id=13 linkage=global
[15] VAR 'user_ptr_var' type_id=2, linkage=global
[16] TYPE_TAG 'tag1' type_id=3
[17] TYPE_TAG 'tag2' type_id=16
[18] PTR '(anon)' type_id=17
[19] VAR 'stacked_var' type_id=18, linkage=global
[20] DATASEC '.bss' size=0 vlen=2
         type_id=15 offset=0 size=8 (VAR 'user_ptr_var')
         type_id=19 offset=0 size=8 (VAR 'stacked_var')
$

So type tag matches between clang and gcc.

For decl tag
============

$ cat decl_tag.c
/* btf_decl_tag test cases.
  *
  * btf_decl_tag can be attached to:
  *   - global (incl. static) variables
  *   - functions
  *   - function parameters
  *   - struct/union types and their members
  *   - typedefs
  *
  * Build:  clang -O2 -target bpf -g -c decl_tag.c -o decl_tag.o
  *         /home/yhs/work/gcc-build/opt/gcc-16.1/bin/gcc -O2 -gbtf -g -c decl_tag.c -o decl_tag.o
  * Dump:   bpftool btf dump file decl_tag.o
  */

#define __tag(x) __attribute__((btf_decl_tag(x)))

/* tag on a global variable */
int global_var __tag("global_var_tag");

/* tag on a static variable */
static int static_var __tag("static_var_tag");

/* multiple tags on one declaration */
int multi_tag_var __tag("tag_a") __tag("tag_b");

/* tag on struct type and its members */
struct foo {
         int a __tag("member_a_tag");
         int b __tag("member_b_tag");
} __tag("struct_foo_tag");

/* tag on a typedef */
typedef struct foo foo_t1 __tag("typedef_foo_tag");
typedef struct {int foo2;} foo_t2 __tag("typedef_foo2_tag");

/* tag on a function and its parameters */
__tag("func_add_tag")
int add(int x __tag("param_x_tag"), int y __tag("param_y_tag"))
{
         return x + y;
}

/* keep the globals/types alive so they land in BTF */
int use(foo_t1 *f, foo_t2 *g)
{
         return add(global_var + static_var + multi_tag_var, f->a + g->foo2);
}

$ /home/yhs/work/gcc-build/opt/gcc-16.1/bin/gcc -O2 -gbtf -g -c decl_tag.c -o decl_tag.o
decl_tag.c:30:1: warning: ‘btf_decl_tag’ attribute does not apply to types [-Wattributes]
    30 | } __tag("struct_foo_tag");
       | ^

$ bpftool btf dump file decl_tag.o
[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
[2] STRUCT 'foo' size=8 vlen=2
         'a' type_id=1 bits_offset=0
         'b' type_id=1 bits_offset=32
[3] TYPEDEF 'foo_t1' type_id=2
[4] STRUCT '(anon)' size=4 vlen=1
         'foo2' type_id=1 bits_offset=0
[5] TYPEDEF 'foo_t2' type_id=4
[6] FUNC_PROTO '(anon)' ret_type_id=1 vlen=2
         'f' type_id=7
         'g' type_id=8
[7] PTR '(anon)' type_id=3
[8] PTR '(anon)' type_id=5
[9] FUNC_PROTO '(anon)' ret_type_id=1 vlen=2
         'x' type_id=1
         'y' type_id=1
[10] VAR 'multi_tag_var' type_id=1, linkage=global
[11] VAR 'global_var' type_id=1, linkage=global
[12] FUNC 'use' type_id=6 linkage=global
[13] FUNC 'add' type_id=9 linkage=global
[14] DECL_TAG 'global_var_tag' type_id=11 component_idx=-1
[15] DECL_TAG 'static_var_tag' type_id=0 component_idx=-1
[16] DECL_TAG 'tag_b' type_id=10 component_idx=-1
[17] DECL_TAG 'tag_a' type_id=10 component_idx=-1
[18] DECL_TAG 'member_a_tag' type_id=2 component_idx=0
[19] DECL_TAG 'member_b_tag' type_id=2 component_idx=1
[20] DECL_TAG 'param_x_tag' type_id=13 component_idx=0
[21] DECL_TAG 'param_y_tag' type_id=13 component_idx=1
[22] DECL_TAG 'func_add_tag' type_id=13 component_idx=-1
[23] DATASEC '.bss' size=0 vlen=2
         type_id=10 offset=0 size=4 (VAR 'multi_tag_var')
         type_id=11 offset=0 size=4 (VAR 'global_var')
$ bpftool btf dump file decl_tag.o | grep DECL_TAG
[14] DECL_TAG 'global_var_tag' type_id=11 component_idx=-1
[15] DECL_TAG 'static_var_tag' type_id=0 component_idx=-1
[16] DECL_TAG 'tag_b' type_id=10 component_idx=-1
[17] DECL_TAG 'tag_a' type_id=10 component_idx=-1
[18] DECL_TAG 'member_a_tag' type_id=2 component_idx=0
[19] DECL_TAG 'member_b_tag' type_id=2 component_idx=1
[20] DECL_TAG 'param_x_tag' type_id=13 component_idx=0
[21] DECL_TAG 'param_y_tag' type_id=13 component_idx=1
[22] DECL_TAG 'func_add_tag' type_id=13 component_idx=-1
$

Three decl tags (struct_foo_tag, typedef_foo_tag and typedef_foo2_tag)
are missing here:

struct foo {
         int a __tag("member_a_tag");
         int b __tag("member_b_tag");
} __tag("struct_foo_tag");

/* tag on a typedef */
typedef struct foo foo_t1 __tag("typedef_foo_tag");
typedef struct {int foo2;} foo_t2 __tag("typedef_foo2_tag");

$ clang -O2 -g -target bpf -c decl_tag.c -o decl_tag.o
$ bpftool btf dump file decl_tag.o
[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
[2] FUNC_PROTO '(anon)' ret_type_id=1 vlen=2
         'x' type_id=1
         'y' type_id=1
[3] FUNC 'add' type_id=2 linkage=global
[4] DECL_TAG 'param_x_tag' type_id=3 component_idx=0
[5] DECL_TAG 'param_y_tag' type_id=3 component_idx=1
[6] DECL_TAG 'func_add_tag' type_id=3 component_idx=-1
[7] PTR '(anon)' type_id=8
[8] TYPEDEF 'foo_t1' type_id=10
[9] DECL_TAG 'typedef_foo_tag' type_id=8 component_idx=-1
[10] STRUCT 'foo' size=8 vlen=2
         'a' type_id=1 bits_offset=0
         'b' type_id=1 bits_offset=32
[11] DECL_TAG 'struct_foo_tag' type_id=10 component_idx=-1
[12] DECL_TAG 'member_a_tag' type_id=10 component_idx=0
[13] DECL_TAG 'member_b_tag' type_id=10 component_idx=1
[14] PTR '(anon)' type_id=15
[15] TYPEDEF 'foo_t2' type_id=17
[16] DECL_TAG 'typedef_foo2_tag' type_id=15 component_idx=-1
[17] STRUCT '(anon)' size=4 vlen=1
         'foo2' type_id=1 bits_offset=0
[18] FUNC_PROTO '(anon)' ret_type_id=1 vlen=2
         'f' type_id=7
         'g' type_id=14
[19] FUNC 'use' type_id=18 linkage=global
[20] VAR 'global_var' type_id=1, linkage=global
[21] DECL_TAG 'global_var_tag' type_id=20 component_idx=-1
[22] VAR 'multi_tag_var' type_id=1, linkage=global
[23] DECL_TAG 'tag_a' type_id=22 component_idx=-1
[24] DECL_TAG 'tag_b' type_id=22 component_idx=-1
[25] DATASEC '.bss' size=0 vlen=2
         type_id=20 offset=0 size=4 (VAR 'global_var')
         type_id=22 offset=0 size=4 (VAR 'multi_tag_var')
$ bpftool btf dump file decl_tag.o | grep DECL_TAG
[4] DECL_TAG 'param_x_tag' type_id=3 component_idx=0
[5] DECL_TAG 'param_y_tag' type_id=3 component_idx=1
[6] DECL_TAG 'func_add_tag' type_id=3 component_idx=-1
[9] DECL_TAG 'typedef_foo_tag' type_id=8 component_idx=-1
[11] DECL_TAG 'struct_foo_tag' type_id=10 component_idx=-1
[12] DECL_TAG 'member_a_tag' type_id=10 component_idx=0
[13] DECL_TAG 'member_b_tag' type_id=10 component_idx=1
[16] DECL_TAG 'typedef_foo2_tag' type_id=15 component_idx=-1
[21] DECL_TAG 'global_var_tag' type_id=20 component_idx=-1
[23] DECL_TAG 'tag_a' type_id=22 component_idx=-1
[24] DECL_TAG 'tag_b' type_id=22 component_idx=-1

DECL_TAG 'static_var_tag' type_id=0 component_idx=-1 is missing in llvm.
This is execpted for llvm since 'static_var' is 'inlined' since it is
value is 0 and the compiler optimization removed it in function use().
In llvm Dwarf->BTF conversion is very late and we only emit survived
globals.

gcc emits 'static_var_tag' probably in frontend. Emitting
'static_var_tag' is okay, just not used.

I think gcc should support
  - declaration tag for typedef, and
  - declaration tag for the whole struct (like above 'struct_foo_tag')
to be compatible with llvm.

> ---
>   btf_encoder.c     |   1 +
>   dutil.h           |  11 +++++
>   dwarf_loader.c    | 105 +++++++++++++++++++++++++++++++++++++++-------
>   dwarves.h         |   2 +-
>   dwarves_fprintf.c |  12 ++++--
>   5 files changed, 110 insertions(+), 21 deletions(-)

[...]

