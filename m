Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735EE3314D1
	for <dwarves@vger.kernel.org>; Mon,  5 Jan 2026 08:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767601639; cv=none; b=nIj+cXjW8Y2u4IFpb/IzDxeG6Ps3BiQOJInE1ckTBKHwcoONLWCmxZqGZuWmiDq26xvsgbLE3fq3qKHz0V6isoqQmNnmc8es0y2loUN6WuEORFH8fGQ5ZGJh6sBMXf8Jbf3LP1Kdbb9AoNo69TLuY/tdKoaprnbGG25Vzc+PwMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767601639; c=relaxed/simple;
	bh=Q/4shMsvIqe+UVceg+uI8+MSBlld+JPMnlECd1YXtcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KspNTwG16YfD/T1GJG0lMYvYrUxxxbnfhRJj1fYb9QkHkAobt5zrLywq5WwzE+avFz3hFGOAxORlIPxJZsKEZ7DbfMfRbbplABXI2Jit6MBb/487yhvKW2DwnA9AfKP9n0AFSSU12wGj1gEvYSdVZ10Zw7GRH8VVb3XoKtSHYVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yns2VgMu; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yns2VgMu"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b7ffbf4284dso1863322466b.3
        for <dwarves@vger.kernel.org>; Mon, 05 Jan 2026 00:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767601636; x=1768206436; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ypkgWHkBo9WqgDQ1DB/IsjD4ESwuJWsD2d1J9VktW48=;
        b=yns2VgMuI75H7ay1CTh197zDxa7y7a8mdIjeoRlfaX3O+Usq5ohqd7PqoJROyTGY9Q
         Xus0MnpJAdvswNooWoBNQhPV/qu/hIJoKVmQBIQKavDVPcw26afDhksYTwT777uu9nBx
         Vo0eT4LnLoM1igtAhBtlk1Q3mUFB3FZbnpvlerxBLtG+N0zXkvVyagHZzoyCwtSFQmwC
         QmBDOvHk/LlP/nn5jv0WJ9ek3j5uLJmqHpPf6TgEHYg4Xfflnz+ey8Zo+4TxeFpqdcVs
         N2s0lfDBOmngcApqJH542DmGUAWwG7wnwhiO7LkmpXszpLrOk1TRFE8nDUSDI9UTtRX8
         LlYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767601636; x=1768206436;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ypkgWHkBo9WqgDQ1DB/IsjD4ESwuJWsD2d1J9VktW48=;
        b=fyRUZ+HqO4Hk2zXVGhSQaJVSqpC4/YvnRScF3Pj45NBoijoMuq+fouRTZiqZ2mOzTX
         MWGWLO0Xnmv5iznaVFdggtuK48nJf9kx7BE1mDbe6vx01UcBrZMLCwsEn8ToVsWOVqGX
         8KSCL67SE2nBuBM8pEJdRT4mEKMu3f1eQ8P3tJWIFn11QBgdbO3X60A7/NCcpRaqtwlD
         b/9OcBrJnFhE7tbvuM5PyOTZpwnrWloelyhZb32Vo7cza9Cjwe/aj4R9vn9hCD8Tb/1R
         lZIMQ1c7/WPf0JqPoGhD5NMg4JVNqSwP7sROdIlu8FtOi/w6zRz0kcpsI1LFP7PFqPIc
         ayJw==
X-Forwarded-Encrypted: i=1; AJvYcCUiqBrAK5rF7d5oM7TB/2QJAsSlGEF8qRZFRW2mz7X1bUk1jesY8y2AJwsWVWIxDxwiNhAFFUhM@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+9qMXa/G2OApwjxnQ+9rWxLPmy4BcI4akfHLLImdC8o+k6IFG
	xwREogt4ZxJ2Dj58bIoXXu07PmmT2sIQMCaf//oatM/5LSmH6ZuIUBZ6Hrvk7b5Rjw==
X-Gm-Gg: AY/fxX4niI+9+Yat2ViXBYs9vbuuOel/6SVu2CKDFXBoa534qxsdmPY7Sca7fcHWYQg
	alZmkCT9DDKq4w2f3Ysn1YhhpQOz7c4HejrS3dzspT8aGE3RkT5NGOF4spqYHRolbpRPAfcspAp
	ZAnlYl932Qni5/tjHwd1PBcWZJ+Ml1tjy7AJmpEfOekkj4W7o7aymxydalBxI5da8KLKOmEey/Q
	mXsKj5ZHT3Sap6QXg0sBd+KZ1GPy1BqNhLrfGVZ1FJENdROotfz+/Hm21SHzQ4hOyRCgdOiESyW
	eqSdiP4XRXzyVrY8TgwhY7SRj6BGbhGDvR3pl1oVAlvE73N7mPwNByV4CfWmWz5FJ/aCH0jqpvX
	dBWe+XHYm1wD1fnQrP/KqFfukIlVJsZyYCXOrZ2NVpsNqVj7IfmG/dBB2NqQcaTIZgUigqS4ptp
	TyckIIDqW5/ku3WTJB7OaMVi3J+LjDp2DKfVglL+StRGadw1fVwI1cqQ==
X-Google-Smtp-Source: AGHT+IHg8IuiD2PkmJ7EJ4lhwJde9cluUgzn2k0YiKFANT0BVwSM54RIFnXDXNsAPagJmofnNzk08w==
X-Received: by 2002:a17:907:9691:b0:b80:2315:b4ca with SMTP id a640c23a62f3a-b80371f956fmr5349308466b.46.1767601635537;
        Mon, 05 Jan 2026 00:27:15 -0800 (PST)
Received: from google.com (14.59.147.34.bc.googleusercontent.com. [34.147.59.14])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037ad806asm5604243166b.23.2026.01.05.00.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 00:27:14 -0800 (PST)
Date: Mon, 5 Jan 2026 08:27:11 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	John Fastabend <john.fastabend@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH dwarves] btf_encoder: prefer strong function definitions
 for BTF generation
Message-ID: <aVt139VXMTka-hYw@google.com>
References: <20251231085322.3248063-1-mattbobrowski@google.com>
 <926aca4a-d7d5-4e7d-9096-77b27374c5cd@linux.dev>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <926aca4a-d7d5-4e7d-9096-77b27374c5cd@linux.dev>

On Fri, Jan 02, 2026 at 10:46:00AM -0800, Yonghong Song wrote:
> 
> 
> On 12/31/25 12:53 AM, Matt Bobrowski wrote:
> > Currently, when a function has both a weak and a strong definition
> > across different compilation units (CUs), the BTF encoder arbitrarily
> > selects one to generate the BTF entry. This selection fundamentally is
> > dependent on the order in which pahole processes the CUs.
> > 
> > This indifference often leads to a mismatch where the generated BTF
> > reflects the weak definition's prototype, even though the linker
> > selected the strong definition for the final vmlinux binary.
> > 
> > A notable example described in [0] involving function
> > bpf_lsm_mmap_file(). Both weak and strong definitions exist,
> > distinguished only by parameter names (e.g., file vs
> > file__nullable). While the strong definition is linked into the
> > vmlinux object, the generated BTF contained the prototype for the weak
> > definition. This causes issues for BPF verifier (e.g., __nullable
> > annotation semantics), or tools relying on accurate type information.
> > 
> > To fix this, ensure the BTF encoder selects the function definition
> > corresponding to the actual code linked into the binary. This is
> > achieved by comparing the DWARF function address (DW_AT_low_pc) with
> > the ELF symbol address (st_value). Only the DWARF entry for the strong
> > definition will match the final resolved ELF symbol address.
> > 
> > [0] https://lore.kernel.org/all/aVJY9H-e83T7ivT4@google.com/
> > 
> > Link: https://lore.kernel.org/all/aVJY9H-e83T7ivT4@google.com/
> > Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
> 
> LGTM with some nits below.

Thanks for the review.

> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> 
> > ---
> >   btf_encoder.c | 36 ++++++++++++++++++++++++++++++++++++
> >   1 file changed, 36 insertions(+)
> > 
> > diff --git a/btf_encoder.c b/btf_encoder.c
> > index b37ee7f..0462094 100644
> > --- a/btf_encoder.c
> > +++ b/btf_encoder.c
> > @@ -79,6 +79,7 @@ struct btf_encoder_func_annot {
> >   /* state used to do later encoding of saved functions */
> >   struct btf_encoder_func_state {
> > +	uint64_t addr;
> >   	struct elf_function *elf;
> >   	uint32_t type_id_off;
> >   	uint16_t nr_parms;
> > @@ -1258,6 +1259,7 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
> >   	if (!state)
> >   		return -ENOMEM;
> > +	state->addr = function__addr(fn);
> >   	state->elf = func;
> >   	state->nr_parms = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
> >   	state->ret_type_id = ftype->tag.type == 0 ? 0 : encoder->type_id_off + ftype->tag.type;
> > @@ -1477,6 +1479,29 @@ static void btf_encoder__delete_saved_funcs(struct btf_encoder *encoder)
> >   	encoder->func_states.cap = 0;
> >   }
> > +static struct btf_encoder_func_state *btf_encoder__select_canonical_state(struct btf_encoder_func_state *combined_states,
> > +									  int combined_cnt)
> > +{
> > +	int i, j;
> > +
> > +	/*
> > +	 * The same elf_function is shared amongst combined functions,
> > +	 * as per saved_functions_combine().
> > +	 */
> > +	struct elf_function *elf = combined_states[0].elf;
> 
> The logic is okay. But can we limit elf->sym_cnt to be 1 here?
> This will match the case where two functions (weak and strong)
> co-exist in compiler and eventually only strong/global function
> will survive.

In fact, checking again I believe that the loop is redundant because
elf_function__has_ambiguous_address() ensures that if we reach this
point, all symbols for the function share the same address. Therefore,
checking the first symbol (elf->syms[0]) should be sufficient and
equivalent to checking all of them.

Will send through a v2 with this amendment.

> > +
> > +	for (i = 0; i < combined_cnt; i++) {
> > +		struct btf_encoder_func_state *state = &combined_states[i];
> > +
> > +		for (j = 0; j < elf->sym_cnt; j++) {
> > +			if (state->addr == elf->syms[j].addr)
> > +				return state;
> > +		}
> > +	}
> > +
> > +	return &combined_states[0];
> > +}
> > +
> >   static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_encoding_inconsistent_proto)
> >   {
> >   	struct btf_encoder_func_state *saved_fns = encoder->func_states.array;
> > @@ -1517,6 +1542,17 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
> >   					0, 0);
> >   		if (add_to_btf) {
> > +			/*
> > +			 * We're to add the current function within
> > +			 * BTF. Although, from all functions that have
> > +			 * possibly been combined via
> > +			 * saved_functions_combine(), ensure to only
> > +			 * select and emit BTF for the most canonical
> > +			 * function definition.
> > +			 */
> > +			if (j - i > 1)
> > +				state = btf_encoder__select_canonical_state(state, j - i);
> > +
> >   			if (is_kfunc_state(state))
> >   				err = btf_encoder__add_bpf_kfunc(encoder, state);
> >   			else
> 
