Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960A61F947
	for <dwarves@vger.kernel.org>; Fri, 18 Oct 2024 12:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729256365; cv=none; b=G0ER64hshFhKak89/qfsiwwY44qBzpLCfV6Yj4Iwrp7S4aJXyzCaMtEirMzWdqE5Z3nDtDHPPNadlKfw2Kvzh657v6aku9n3Wg+pcSJ2ujiHiNoi1IAFwI4siXrG0H6+0kYRwsx+mQ/QpcMrJmhaw9McPc71ajrAJu2MbwGBO3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729256365; c=relaxed/simple;
	bh=UG2uBg24KH/V21G8gBly4DiQivsE/ng6dFZxXJZmI5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gj8tcmjLGrMYFGAevfpj3r9u9kfUAtQQhw1EvnJn1mt609mnOBO9ua4KAIB8K6IyWFfwuvUwHpU1ZRjPHUHnGd92f4OlHVVzetoTYpihJgUtLVJ9YNCc0oW9eKvRKl2hPY70OLhUWrRhWOucrhGoZqbRsuI6MwhMnaOSGYnA9jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJd2VwU/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJd2VwU/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1076C4CEC3;
	Fri, 18 Oct 2024 12:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729256365;
	bh=UG2uBg24KH/V21G8gBly4DiQivsE/ng6dFZxXJZmI5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UJd2VwU/pbQYKIS9I4s6YlOjKzPXl4kwTEu3wnskPiNoDfzQQoENTVdAWOWOO/6Wj
	 j1f/IjHsBsrxxoGr4VeM5j3lzHK1D1j7dXJEswcu3PsrGzd5t5JV8JsF6xBOqtck4r
	 4PTfFhr7aRu6hLRsNsS1O+lUzRAH7OAND9XV/wAQo2Z1SFXMFz3tUMzchjT0akqQiQ
	 6ANEInt89T2bB9E7Lt62nGkU++Dl5C4iBn6dY8pRnxEy+2ZBx93MH5PqFtCkMKUP+z
	 Zgboome0Fv5zk/k7hd2BN5034papNkTlqQYnUkegcAa34GiU1D8dZZSre3aDs5MPW7
	 D+afqXJLU6jLA==
Date: Fri, 18 Oct 2024 09:59:22 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ihor.solodrai@pm.me, eddyz87@gmail.com, dwarves@vger.kernel.org
Subject: Re: [PATCH dwarves] btf_encoder: use ELF_C_READ_MMAP
Message-ID: <ZxJbqhus4Io4_1bg@x1>
References: <20241014103142.2280044-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014103142.2280044-1-alan.maguire@oracle.com>

On Mon, Oct 14, 2024 at 11:31:42AM +0100, Alan Maguire wrote:
> This reduces peak memory utilization during BTF vmlinux encoding,
> replacing ELF section-sized malloc()s with mmap()s.
> 
> For -j1 peak memory resident set size drops from
> 
>         Maximum resident set size (kbytes): 1069220
> 
> ...to:
> 
>         Maximum resident set size (kbytes): 701888
> 
> ...with this patch.
> 
> For -j8, peak memory resident set size drops from
> 
>         Maximum resident set size (kbytes): 1121172
> 
> ...to:
> 
>         Maximum resident set size (kbytes): 963516

Thanks, applied to perf-tools-next,

- Arnaldo
 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  btf_encoder.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 5954238..9599faf 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -1879,7 +1879,7 @@ static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
>  		goto out;
>  	}
>  
> -	elf = elf_begin(fd, ELF_C_READ, NULL);
> +	elf = elf_begin(fd, ELF_C_READ_MMAP, NULL);
>  	if (elf == NULL) {
>  		elf_error("Cannot update ELF file");
>  		goto out;
> -- 
> 2.43.5
