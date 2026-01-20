Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5D33A0B17
	for <dwarves@vger.kernel.org>; Tue, 20 Jan 2026 17:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768931607; cv=none; b=jrBzobzykRlCLE2huuN715ijcAWv/rs+koeRipm953T7D0ZUeIyUxzvnpDgHdnbbsXN0okTeUF5I3YK2IS31E3UHojyvnwkN7XB5jgodlJVCNJE73M2SCkfG24fUeE6wKHkbNUN//uXYtTlJTANeU/Ng5IHkC6YHAISRKjZKRrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768931607; c=relaxed/simple;
	bh=FI0R8d+KWfIjqjH4XvQm6IIyp4GyM6pWXWHGrN8Go2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I1wzSPl9fraeZ07iVuZ8dh0NRMo0AiEkOApHOKrkYGUBwolj+EDl1YCfDZhp39AuFG8UHT0ncACZ3Rvis2E7EeK+Nim/QcT6ZBF6nKRVIWC41/uXMAthtYweT+wp31arZT0z0jXo7rWMUk0AHJK4BRItuNLKxWPQALxGxlILM7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oUwWG2OG; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oUwWG2OG"
Message-ID: <4d7c529c-a910-431f-8e6a-b8e5f4f7cffa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768931601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=azc7gbyiTwAxgEDjS5GnVUh4/fzk9QqV0xzC9eaR8Jg=;
	b=oUwWG2OGj5jOekjjS4WTcKqUpc48RKtfyifBwXFrJZ4Sj+woJGx5vP/5YOBAokz8rDKMM4
	7rrZC5wm4o8YUnqJQHmcaCYx4HDaSvVwXYo0E/taCQhaCHcEjwF6UnCiJ+vIRtMaZn9Qa9
	TvwMFpLxseAnXSqfmSYkVStoNOetfzw=
Date: Tue, 20 Jan 2026 09:53:16 -0800
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves 3/4] btf_encoder: Add true_signature feature
 support for "."-suffixed functions
Content-Language: en-GB
To: Alan Maguire <alan.maguire@oracle.com>, mattbobrowski@google.com
Cc: eddyz87@gmail.com, ihor.solodrai@linux.dev, jolsa@kernel.org,
 andrii@kernel.org, ast@kernel.org, dwarves@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260113131352.2395024-1-alan.maguire@oracle.com>
 <20260113131352.2395024-4-alan.maguire@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260113131352.2395024-4-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 1/13/26 5:13 AM, Alan Maguire wrote:
> Currently we collate function information by name and add functions
> provided there are no inconsistencies across various representations.
>
> For true_signature support - where we wish to add the real signature
> of a function even if it differs from source level - we need to do
> a few things:
>
> 1. For "."-suffixed functions, we need to match from DWARF->ELF;
>     we can do this via the address associated with the function.
>     In doing this, we can then be confident that the debug info
>     for foo.isra.0 is the right info for the function at that
>     address.
>
> 2. When adding saved functions we need to look for such cases
>     and provided they do not violate other constraints around BTF
>     representation - unexpected reg usage for function, uncertain
>     parameter location or ambiguous address - we add them with
>     their "."-suffixed name.  The latter can be used as a signal
>     that the function is transformed from the original.
>
> Doing this adds 500 functions to BTF.  These are traceable with
> their "."-suffix names and because we have excluded ambiguous
> address cases we know exactly which function address they refer
> to.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>   btf_encoder.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++-----
>   dwarves.h     |  1 +
>   pahole.c      |  1 +
>   3 files changed, 68 insertions(+), 7 deletions(-)
>
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 5bc61cb..01fd469 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -77,9 +77,16 @@ struct btf_encoder_func_annot {
>   	int16_t component_idx;
>   };
>   
> +struct elf_function_sym {
> +	const char *name;
> +	uint64_t addr;
> +};
> +
>   /* state used to do later encoding of saved functions */
>   struct btf_encoder_func_state {
>   	struct elf_function *elf;
> +	struct elf_function_sym *sym;
> +	uint64_t addr;
>   	uint32_t type_id_off;
>   	uint16_t nr_parms;
>   	uint16_t nr_annots;
> @@ -94,11 +101,6 @@ struct btf_encoder_func_state {
>   	struct btf_encoder_func_annot *annots;
>   };
>   
> -struct elf_function_sym {
> -	const char *name;
> -	uint64_t addr;
> -};
> -
>   struct elf_function {
>   	char		*name;
>   	struct elf_function_sym *syms;
> @@ -145,7 +147,8 @@ struct btf_encoder {
>   			  skip_encoding_decl_tag,
>   			  tag_kfuncs,
>   			  gen_distilled_base,
> -			  encode_attributes;
> +			  encode_attributes,
> +			  true_signature;
>   	uint32_t	  array_index_id;
>   	struct elf_secinfo *secinfo;
>   	size_t             seccnt;
> @@ -1271,14 +1274,34 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
>   			goto out;
>   		}
>   	}
> +	if (encoder->true_signature && fn->lexblock.ip.addr) {
> +		int i;
> +
> +		for (i = 0; i < func->sym_cnt; i++) {
> +			if (fn->lexblock.ip.addr != func->syms[i].addr)
> +				continue;
> +			/* Only need to record address for '.'-suffixed
> +			 * functions, since we only currently need true
> +			 * signatures for them.
> +			 */
> +			if (!strchr(func->syms[i].name, '.'))
> +				continue;
> +			state->sym = &func->syms[i];
> +			break;
> +		}
> +	}
>   	state->inconsistent_proto = ftype->inconsistent_proto;
>   	state->unexpected_reg = ftype->unexpected_reg;
>   	state->optimized_parms = ftype->optimized_parms;
>   	state->uncertain_parm_loc = ftype->uncertain_parm_loc;
>   	state->reordered_parm = ftype->reordered_parm;
>   	ftype__for_each_parameter(ftype, param) {
> -		const char *name = parameter__name(param) ?: "";
> +		const char *name;
>   
> +		/* No location info + reordered means optimized out. */
> +		if (ftype->reordered_parm && !param->has_loc)
> +			continue;
> +		name = parameter__name(param) ?: "";
>   		str_off = btf__add_str(btf, name);
>   		if (str_off < 0) {
>   			err = str_off;
> @@ -1367,6 +1390,9 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder,
>   
>   	btf_fnproto_id = btf_encoder__add_func_proto_for_state(encoder, state);
>   	name = func->name;
> +	if (encoder->true_signature && state->sym)
> +		name = state->sym->name;
> +
>   	if (btf_fnproto_id >= 0)
>   		btf_fn_id = btf_encoder__add_ref_type(encoder, BTF_KIND_FUNC, btf_fnproto_id,
>   						      name, false);
> @@ -1509,6 +1535,38 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
>   		while (j < nr_saved_fns && saved_functions_combine(encoder, &saved_fns[i], &saved_fns[j]) == 0)
>   			j++;
>   
> +		/* Add true signatures for case where we have an exact
> +		 * symbol match by address from DWARF->ELF and have a
> +		 * "." suffixed name.
> +		 */
> +		if (encoder->true_signature) {
> +			int k;
> +
> +			for (k = i; k < nr_saved_fns; k++) {
> +				struct btf_encoder_func_state *true_state = &saved_fns[k];
> +
> +				if (state->elf != true_state->elf)
> +					break;
> +				if (!true_state->sym)
> +					continue;
> +				/* Unexpected reg, uncertain parm loc and
> +				 * ambiguous address mean we cannot trust fentry.
> +				 */
> +				if (true_state->unexpected_reg ||
> +				    true_state->uncertain_parm_loc ||
> +				    true_state->ambiguous_addr)
> +					continue;
> +				err = btf_encoder__add_func(encoder, true_state);
> +				if (err < 0)
> +					goto out;
> +				break;
> +			}
> +		}
> +
> +		/* True symbol that was handled above; skip. */
> +		if (state->sym)
> +			continue;

I did an experiment with the following code:

$ cat test.c
struct t { int a; };
__attribute__((noinline)) char *tar(struct t *a, struct t *d) { if (a->a == d->a) return (char *)10; else return (char *)0; }
__attribute__((noinline)) static char * foo(struct t *a, int b, struct t *d)
{
   return tar(a, d);
}
__attribute__((noinline)) char *bar(struct t *a, struct t *d)
{
   return foo(a, 1, d);
}

struct t p1, p2;
int main() {
   return !!bar(&p1, &p2);
}

and compiled with gcc11:
$ gcc -O2 -g test.c

I hacked btf_encoder.c with true_signature is all on and with
$ pahole -JV ./a.out
...
btf_encoder__new: './a.out' doesn't have '.data..percpu' section
File ./a.out:
[1] STRUCT t size=4
         a type_id=2 bits_offset=0
[2] INT int size=4 nr_bits=32 encoding=SIGNED
[3] PTR (anon) type_id=4
[4] INT char size=1 nr_bits=8 encoding=SIGNED
[5] PTR (anon) type_id=1
search cu 'test.c' for percpu global variables.
[6] FUNC_PROTO (anon) return=3 args=(5 a, 5 d)
[7] FUNC bar type_id=6
[8] FUNC_PROTO (anon) return=3 args=(5 a, 5 d, vararg)
[9] FUNC foo.constprop.0 type_id=8
foo : skipping BTF encoding of function due to reordered parameters
[10] FUNC_PROTO (anon) return=2 args=(void)
[11] FUNC main type_id=10
[12] FUNC_PROTO (anon) return=3 args=(5 a, 5 d)
[13] FUNC tar type_id=12

There are two issues.

First in btf_encoder__add_saved_funcs(), it is possible below
+		/* True symbol that was handled above; skip. */
+		if (state->sym)
+			continue;
state->sym is false.
But one of true_state->sym in the above loop could be true.
So if btf_encoder__add_func(encoder, true_state) is successful,
we should continue in the above regardless state->sym null or not.
This will remove the warning:
   foo : skipping BTF encoding of function due to reordered parameters

Second, we have foo.constprop.0 func proto encoding:
   [8] FUNC_PROTO (anon) return=3 args=(5 a, 5 d, vararg)
The last argument 'vararg' should not be there since the
optimized out argument is already gone.

> +
>   		/* do not exclude functions with optimized-out parameters; they
>   		 * may still be _called_ with the right parameter values, they
>   		 * just do not _use_ them.  Only exclude functions with
> @@ -2585,6 +2643,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>   		encoder->tag_kfuncs	 = conf_load->btf_decl_tag_kfuncs;
>   		encoder->gen_distilled_base = conf_load->btf_gen_distilled_base;
>   		encoder->encode_attributes = conf_load->btf_attributes;
> +		encoder->true_signature = conf_load->true_signature;
>   		encoder->verbose	 = verbose;
>   		encoder->has_index_type  = false;
>   		encoder->need_index_type = false;
> diff --git a/dwarves.h b/dwarves.h
> index 78bedf5..d7c6474 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -101,6 +101,7 @@ struct conf_load {
>   	bool			btf_decl_tag_kfuncs;
>   	bool			btf_gen_distilled_base;
>   	bool			btf_attributes;
> +	bool			true_signature;
>   	uint8_t			hashtable_bits;
>   	uint8_t			max_hashtable_bits;
>   	uint16_t		kabi_prefix_len;
> diff --git a/pahole.c b/pahole.c
> index ef01e58..02a0d19 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -1234,6 +1234,7 @@ struct btf_feature {
>   	BTF_NON_DEFAULT_FEATURE(global_var, encode_btf_global_vars, false),
>   	BTF_NON_DEFAULT_FEATURE_CHECK(attributes, btf_attributes, false,
>   				      attributes_check),
> +	BTF_NON_DEFAULT_FEATURE(true_signature, true_signature, false),
>   };
>   
>   #define BTF_MAX_FEATURE_STR	1024

