Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BA218893C
	for <dwarves@vger.kernel.org>; Mon, 28 Oct 2024 16:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730132911; cv=none; b=cqlqVwkIPBcakkkkY5Z/19k+/7eAhBoy1L2jVLKpR9xujd0eJVlcQ8SsWtvzHxTFQuZpvRowixtiTb/U7PXnGeX1+pXZvt8fniFsQFMPxC78we54q4C2hPAqRfnEEw58ghLoF9etm/PjlJg3vnEmlSeW6yEka5EhfmcghzDpmY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730132911; c=relaxed/simple;
	bh=iXT1vvwm1NUc/NCl6za/le7QdMShI1OIvqox1ZoSYVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6V3DOfUTFbbWxG+iHcvbmB6+mky2ZnToyFMnwbQtaDIXfXBDGBXx59Rb4Mn35sDBEBz7hqZbDH5OXhExu2Q4N5EzzeL1+4pYNMkQBaujN/yQF7VpXl06q1LHn32eiCk6GDRFHzwrvzJEE9m7GTiVdCGUgdGPqv1D/YeGl0aSc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qm6AfKy9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qm6AfKy9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544F1C4CEC3;
	Mon, 28 Oct 2024 16:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730132910;
	bh=iXT1vvwm1NUc/NCl6za/le7QdMShI1OIvqox1ZoSYVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qm6AfKy9ecGQEAPGHosdMTikKg4wu0KgPG4oKVCovLHreq14xXLhBw3ojCPNQ+Wbj
	 OmOx1mekRAu5YK2KJujepzGUBVKX964R1XVFL0ctwjPu0DrPtmHeYVyGXS8s7b9KNY
	 bx0VYcIzBxjTtoYn8jNMB33WVGIgRHncqEOasHI9zozZ7dMjC1FoyKkk5DNiJdxQeS
	 18/Zm8mfkXX4fllgdNVLmIfhv7Cu1OvFIK+RZ2ufTehrdlVEYmjh5X+lYwKGlhpY9C
	 LP1QNSXpL/wLQpjDFrY/LOR2/ieKB9NU2t/qmIhB4Uup3i+3h0AJrFowuqQOxvDXFX
	 9qoEDFGOyUNaQ==
Date: Mon, 28 Oct 2024 13:28:27 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: dwarves@vger.kernel.org,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH dwarves] pahole: distilled_base btf_feature should be
 reported for libbpf > 1.5
Message-ID: <Zx-7qyu-m9mR3zbA@x1>
References: <20241025171553.1850692-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025171553.1850692-1-alan.maguire@oracle.com>

On Fri, Oct 25, 2024 at 06:15:53PM +0100, Alan Maguire wrote:
> Alexei ran into issues [1] generating distilled base BTF with pahole built
> against an older < 1.5 libbpf.  For older libbpf, we cannot support
> distilled base BTF (since the library API btf__distill_base() is not
> present) so we should not report it as a feature in that case.
> 
> [1] https://lore.kernel.org/bpf/CAADnVQKFjK8BnZ-rYzXKv-Zdw=HBJRoJ7jo5PN+0P6+qpJOxNg@mail.gmail.com/
> 
> Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Thanks, applied.

- Arnaldo

> ---
>  pahole.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/pahole.c b/pahole.c
> index 0b91a7e..55d04cf 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -1206,7 +1206,9 @@ struct btf_feature {
>  	BTF_DEFAULT_FEATURE(consistent_func, skip_encoding_btf_inconsistent_proto, false),
>  	BTF_DEFAULT_FEATURE(decl_tag_kfuncs, btf_decl_tag_kfuncs, false),
>  	BTF_NON_DEFAULT_FEATURE(reproducible_build, reproducible_build, false),
> +#if LIBBPF_MAJOR_VERSION >= 1 && LIBBPF_MINOR_VERSION >= 5
>  	BTF_NON_DEFAULT_FEATURE(distilled_base, btf_gen_distilled_base, false),
> +#endif
>  	BTF_NON_DEFAULT_FEATURE(global_var, encode_btf_global_vars, false),
>  };
>  
> -- 
> 2.43.5
