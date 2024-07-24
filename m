Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4196F18E10
	for <dwarves@vger.kernel.org>; Wed, 24 Jul 2024 16:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721838551; cv=none; b=aOnkXrBt4S1/vw2p7wE8H25+zFKm5sEkZT0d6IrIOHuVcKTxFV4Wx1JuamQYIGb1uAfyfEg1iGFhP+tvJ32FHeHDqVm2AVoTFHcKsEmy6vc++t+bfRqPKMfCr1KQdYDE4eCfgGTpfqwxiafJugVThJe66deWESd3FyTBy6fIhII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721838551; c=relaxed/simple;
	bh=/diJkJZ9Ql+cyqB9SuyCgT7aL6dyKUZoo/Yzyml2/9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4onzMVUstX5vj8HzbCmErpNSOkGC7eFfMFYAKJDoNNgJUd1Xs+UfaAEtSM5z5llPe+08hsY8+l0syAwEd58qJ7vbQPZ19ORjtCv9jr2cRUuHeEd+oG8Y8JSpF6k34ZwY6WQZsv6CJKqZyn9+RzYxb9BRE7tgpWnLdZNB9UYkDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLOUd9xd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLOUd9xd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449A6C32781;
	Wed, 24 Jul 2024 16:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721838550;
	bh=/diJkJZ9Ql+cyqB9SuyCgT7aL6dyKUZoo/Yzyml2/9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZLOUd9xd8M5gCz42dnn91b9DLFvcAhVV4fJhxoGStqPSfgH/Kx2l2vNBH5O2zmKEg
	 YHF6e4LNWy4bE4ntr6uWZ96UhOEMWaZ5rsYKuqEBXCWGuN5lOk1OENiBdbqkvZfD2Z
	 W/pafzK1ZSC3k4UGACQ5qw1+AqeGhuWWIdZKgDohtY3OZFsBl6g97f+WfUJS3+uRkX
	 b0jYkh7qWJYQRfWTwUA7RWlsNJPwM4/f4cdwLI1umG3aUuCnYOzSuzkq42NCdgaMCA
	 CA2zyzwqjdCLNFqdX3jtJAU+C9S3Gb8wvztrwxXJHFZjfgCIr4CmjRxoj5BKNNN/F3
	 8zbJubWZi2W3Q==
Date: Wed, 24 Jul 2024 13:29:06 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Domenico Andreoli <cavok@debian.org>, Jiri Olsa <jolsa@kernel.org>,
	Ben Hutchings <ben@decadent.org.uk>, 1076564@bugs.debian.org,
	dwarves@vger.kernel.org
Subject: Re: Bug#1076564: pahole BTF processing seems flaky on powerpc
Message-ID: <ZqEr0qRJxYkolo8y@x1>
References: <172133976964.70930.13662511677581571913.reportbug@deadeye.wl.decadent.org.uk>
 <ZpoNZHIYuERg49N1@localhost>
 <Zpq6vEB3G1UlAeGR@x1>
 <f91db3d7-743d-4f76-b597-1ec5e3a4efa8@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f91db3d7-743d-4f76-b597-1ec5e3a4efa8@oracle.com>

On Wed, Jul 24, 2024 at 11:04:51AM +0100, Alan Maguire wrote:
> On 19/07/2024 20:13, Arnaldo Carvalho de Melo wrote:
> > Adding Alan and Jiri to the CC list.
> >
> 
> I'm late chiming in on this one, but judging by the output:
> 
>   BTF     .btf.vmlinux.bin.o
> + LLVM_OBJCOPY=powerpc-linux-gnu-objcopy pahole -J -j
> --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func
> --lang_exclude=rust .tmp_vmlinux.btf
> [102044] ARRAY (anon) type_id=99491 index_type_id=14 nr_elems=12 Error
> emitting BTF type
> Encountered error while encoding BTF.
> 
> 
> ...we hit an error in btf_encoder__add_array() as a result of
> btf__add_array() failing:
> 
> btf__log_err(btf, BTF_KIND_ARRAY, NULL, true,
>                               "type_id=%u index_type_id=%u nr_elems=%u
> Error emitting BTF type",
>                               type, index_type, nelems);
> 
> 
> Unfortunately we don't preserve the negative id value (containing the
> error code) in btf__log_err(); I'm thinking one thing we should do is
> modify btf__log_err() to preserves errors for cases where the encoding
> errors out due to a libbpf-returned -errno, something like
> 
> 
> -__attribute ((format (printf, 5, 6)))
> +__attribute ((format (printf, 6, 7)))
> -static void btf__log_err(const struct btf *btf, int kind, const char *name,
> +static void btf__log_err(const struct btf *btf, int libbpf_err, int
> kind, const char *name,
>                          bool output_cr, const char *fmt, ...)
> {
>         fprintf(stderr, "[%u] %s %s", btf__type_cnt(btf),
>                 btf_kind_str[kind], name ?: "(anon)");
> 
> 	if (fmt && *fmt) {
>                 va_list ap;
> 
>                 fprintf(stderr, " ");
>                 va_start(ap, fmt);
>                 vfprintf(stderr, fmt, ap);
>                 va_end(ap);
>         }
> 
> +	if (libbpf_err)
> +		fprintf(stderr, " libbpf error %d", libbpf_err);
>         if (output_cr)
>                 fprintf(stderr, "\n");
> }
> 
> 
> So at least if this error recurs we'd have a clearer picture of what's
> happening in libbpf. What do you think? I'll submit a patch for this if
> it makes sense.

I agree completely that the error reporting we have is lacking, we
better go and add extra info for these cases so that we can more quickly
get a clue of what is taking place, so please submit patches for that
and I'll consider them.

Thanks,

- Arnaldo
