Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B2541686B
	for <dwarves@vger.kernel.org>; Tue,  4 Aug 2026 18:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869025; cv=none; b=AULkxQNq9MDoi+yW09yejApR63zmwmUmGMA/iqHqWRxrreEjPSPdACTkFfNJkRLukwmnw4tzdKP1yaB3NwvFvGG1IaXpOpn1BXjROR08KVNr2xDG1CvU1+rm2mIrqEqTMT0Q8tFlLFGRUpkb9+y4YjqAeLiY0sTvNpijNMeKoRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869025; c=relaxed/simple;
	bh=w3I849tp4nn7jUF+RIYsuF4W8RVAT1SMTjKYT+wKvFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IDN9kDdzT596FzdISmGW6w9/3mo6AV/kgCZo75S7mmibwf8KgmbP/TN4dmnNfrgk5WQ06Te2zpCdBHYZmFKqy8ynHubicGCVxhqwqvSuFg2+lHXeoxPkj980obyiCtwIP7kVPMB4OoVmw/tMcC1nKDNg3uufwDfdtDX/oJ2IkrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rx2jhkuZ; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rx2jhkuZ"
Message-ID: <4cb8bb30-1f01-4b78-a6b1-4ade3b965039@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785869020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l0pbxGg6HuESpwSDv777qFnuhhGQm6TbzwVowqQZwbI=;
	b=rx2jhkuZc6EF6xG8xH5TTs6NhghiM82974ZC8Kd9+1ctYFMnNyoOHYdjMjuYmenG+YfOSr
	ob9etDfxidInpvEjD5v7fBEQuMBvf8lvywPiJ3ULJ1JfyaowSea+SILy5UyDPxUoqAhKWD
	WPCALsZfY+6juCyMcu6Ein5YeqYfUY4=
Date: Tue, 4 Aug 2026 11:43:34 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves] btf_encoder: Infer arena kfunc arguments from
 suffixes
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Alan Maguire <alan.maguire@oracle.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Tejun Heo <tj@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>
References: <20260803125518.2279340-1-memxor@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260803125518.2279340-1-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/3/26 5:55 AM, Kumar Kartikeya Dwivedi wrote:
> The kernel verifier recognizes __arena and __arena_nullable parameter
> suffixes for registered kfuncs. These arguments need the matching
> address_space(1) BTF type attribute so bpftool emits usable declarations.

Hi Kartikeya,

+cc: Emil, Tejun

This patch is certainly a no-go, because of the ongoing effort to move
decl/type tag BTF generation from pahole to resolve_btfids [1][2]. I'm
going to send the last unlanded bits of that soon.

*If* we decide to make this change, it shouldn't be done in pahole.

But even setting that aside:

> The kernel verifier recognizes __arena and __arena_nullable
> parameter suffixes for registered kfuncs.

This is not true. The only way the kernel can recognize an arena
argument is via one of the three kfunc flags: KF_ARENA_RET,
KF_ARENA_ARG1 and KF_ARENA_ARG2. No __arena suffix support exist:

  $ git log --oneline -n1
  7f333f85f83d (HEAD -> bpf-next, origin/for-next, origin/bpf-next, bpf-next/master, bpf-next/for-next, bpf-next/HEAD) Merge branch 'bpf-invalidate-rcu-pointers-after-final-spin-unlock'
  $ grep -r --include="*.[ch]" __arena  kernel/bpf/
    # ...nothing

__arena symbol is only used in sched_ext, libarena and selftests code
as an alias to __atrribute__((address_space(1))) or a type tag:

  $ grep -r --include="*.[ch]" 'define __arena '
  tools/sched_ext/include/scx/bpf_arena_common.bpf.h:#define __arena __attribute__((address_space(1)))
  tools/testing/selftests/bpf/libarena/include/bpf_arena_common.h:#define __arena __attribute__((address_space(1))) __attribute__((btf_type_tag("arena")))
  tools/testing/selftests/bpf/libarena/include/bpf_arena_common.h:#define __arena __attribute__((btf_type_tag("arena")))

AFAIR prior discussions that led to KF_ARENA_* flags implementation,
we decided to *not* add an __arena arg suffix support. We were talking
about getting rid of this suffix-annotation mechanism completely.

What we want long term is proper decl/type tags support from
compilers, so that in the kernel we could have and use:

  #define __arena __attribute__((btf_type_tag("arena")))

At the time KF_ARENA_* flags were introduced, this wasn't feasible
because GCC compiler didn't support the tags. I think it does since
recently, but even so we'll have to support older compiler builds for
quite a while.

So while I understand the reluctance to add KF_ARENA_ARG3..N, I don't
think we want to introduce and support yet another mechanism for arena
argument annotations. If we do, we'll be stuck with a mess of
supporting two/three ways of doing the same thing for the foreseeable future.

Maybe adding support for proper type-tagging is worthwhile long-term,
but not the name suffix.

[1] https://lore.kernel.org/bpf/20260601221805.821394-1-ihor.solodrai@linux.dev/
[2] https://lore.kernel.org/bpf/20260722233518.778854-1-ihor.solodrai@linux.dev/


> 
> Extend the existing KF_ARENA_ARG1/2 handling to select arguments by either
> the legacy flag or either suffix. Iterate over all parameters, allowing the
> suffix convention at any argument position and avoiding duplicate tags when
> a flag and suffix select the same argument.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  btf_encoder.c | 38 ++++++++++++++++++++++++++++----------
>  dutil.h       | 13 +++++++++++++
>  2 files changed, 41 insertions(+), 10 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 4b422e09800f..07ca4f41ac32 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -42,6 +42,8 @@
>  #define BTF_KFUNC_TYPE_TAG	"bpf_kfunc"
>  #define BTF_FASTCALL_TAG       "bpf_fastcall"
>  #define BPF_ARENA_ATTR         "address_space(1)"
> +#define BPF_ARENA_SUFFIX       "__arena"
> +#define BPF_ARENA_NULLABLE_SUFFIX "__arena_nullable"
>  
>  /* kfunc flags, see include/linux/btf.h in the kernel source */
>  #define KF_FASTCALL   (1 << 12)
> @@ -808,12 +810,32 @@ static int btf__tag_bpf_arena_arg(struct btf *btf, struct btf_encoder_func_state
>  	return id;
>  }
>  
> -/* Modifies state->ret_type_id and state->parms[i].type_id for flagged kfuncs */
> +static bool btf__is_bpf_arena_arg(const struct btf *btf,
> +				  const struct btf_encoder_func_state *state, int idx)
> +{
> +	uint32_t flags = state->elf->kfunc_flags;
> +	const char *name;
> +	size_t name_len;
> +
> +	if ((idx == 0 && (flags & KF_ARENA_ARG1)) ||
> +	    (idx == 1 && (flags & KF_ARENA_ARG2)))
> +		return true;
> +
> +	name = btf__name_by_offset(btf, state->parms[idx].name_off);
> +	if (!name)
> +		return false;
> +	name_len = strlen(name);
> +	return (name_len > sizeof(BPF_ARENA_SUFFIX) - 1 && strends(name, BPF_ARENA_SUFFIX)) ||
> +	       (name_len > sizeof(BPF_ARENA_NULLABLE_SUFFIX) - 1 &&
> +		strends(name, BPF_ARENA_NULLABLE_SUFFIX));
> +}
> +
> +/* Modifies state->ret_type_id and state->parms[i].type_id for arena kfuncs */
>  static int btf__add_bpf_arena_type_tags(struct btf *btf, struct btf_encoder_func_state *state)
>  {
>  	uint32_t flags = state->elf->kfunc_flags;
>  	int ret_type_id;
> -	int err;
> +	int err, i;
>  
>  	if (!btf__add_type_attr) {
>  		fprintf(stderr, "btf__add_type_attr is not available, is libbpf < 1.6?\n");
> @@ -830,14 +852,10 @@ static int btf__add_bpf_arena_type_tags(struct btf *btf, struct btf_encoder_func
>  		state->ret_type_id = ret_type_id;
>  	}
>  
> -	if (KF_ARENA_ARG1 & flags) {
> -		err = btf__tag_bpf_arena_arg(btf, state, 0);
> -		if (err < 0)
> -			return err;
> -	}
> -
> -	if (KF_ARENA_ARG2 & flags) {
> -		err = btf__tag_bpf_arena_arg(btf, state, 1);
> +	for (i = 0; i < state->nr_parms; i++) {
> +		if (!btf__is_bpf_arena_arg(btf, state, i))
> +			continue;
> +		err = btf__tag_bpf_arena_arg(btf, state, i);
>  		if (err < 0)
>  			return err;
>  	}
> diff --git a/dutil.h b/dutil.h
> index 603556fa0308..d55d01abc842 100644
> --- a/dutil.h
> +++ b/dutil.h
> @@ -335,6 +335,19 @@ static inline bool strstarts(const char *str, const char *prefix)
>  	return strncmp(str, prefix, strlen(prefix)) == 0;
>  }
>  
> +/**
> + * strends - does @str end with @suffix?
> + * @str: string to examine
> + * @suffix: suffix to look for.
> + */
> +static inline bool strends(const char *str, const char *suffix)
> +{
> +	size_t str_len = strlen(str);
> +	size_t suffix_len = strlen(suffix);
> +
> +	return suffix_len <= str_len && strcmp(str + str_len - suffix_len, suffix) == 0;
> +}
> +
>  void *zalloc(const size_t size);
>  
>  Elf_Scn *elf_section_by_name(Elf *elf, GElf_Shdr *shp, const char *name, size_t *index);

