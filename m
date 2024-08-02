Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882721E3CA2
	for <dwarves@vger.kernel.org>; Fri,  2 Aug 2024 13:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722606263; cv=none; b=uMpNCdjh4Pr2gmNyssM55J4Fgr8u4Hmgve3xB2PA0F+vruI/+fCzj4juA6JTJappUq+R4MEIoiIQdUmewkGoZ+L03SxSJKtonT69fcXh5fRQwfOi0TgRkI7WXEKLI+fQK5xMU8kJcV/IcGcO/0878Ymn2whyWb6Hm66iwENqVyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722606263; c=relaxed/simple;
	bh=mrrNIXqvbNhkC7GYhd5Wzp3bHaqCsYl4EQq5oqsDMUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lo6QIcrVHTDNxH5udfzLg6W9wk6i0HXeraM2rdWij2p7Al/bSB5cACOn0T5L5oHQ1uzTOpqI/6jeriH4qU0R1ho+C8WhsfwmhbI33uqUQS12Fu2KtsNt44tSNyI8K45ICkeIZVv/pEe25Dla9qmv3nIFOudv5mW3tD3X3bwr10g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+BFKcx/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+BFKcx/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69AC1C32782;
	Fri,  2 Aug 2024 13:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722606263;
	bh=mrrNIXqvbNhkC7GYhd5Wzp3bHaqCsYl4EQq5oqsDMUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U+BFKcx/K9azVDhxJrEFdlynWgdxIb5ciISeycFmk4/3QlCshNmJ2quv/oGL7JXEO
	 RBaWdD5LvqFzaLJU+1nEpmTNBE3NvmMZClQwHaEAa2+Wp/fDwUAsQuDaqrFjlS6HLh
	 phzhD0kdlt6t2yZbxJiW2H68WwhyxDB1qoXBwwlny1AwYBe8uDkYO6vNWUQrCeiMj8
	 1dzQQYii3hr3qmm2Du3oG3lJAgkGU1IcMxGDrJvodTEs9nt28Wgqa7Qc/R+LndQg/R
	 UOmTEUgFfNHyM8nj0zcosIOhVRF2xX/pSNUMNOO1y0n/TKx0X6E01fE5o1a/+R0WkW
	 VaB/m+7/0F2jg==
Date: Fri, 2 Aug 2024 10:44:19 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: dwarves@vger.kernel.org
Subject: Re: [PATCH dwarves] pahole: only warn about multithreading in
 verbose mode
Message-ID: <Zqziswx7ua4B3Djv@x1>
References: <20240801095058.1946790-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801095058.1946790-1-alan.maguire@oracle.com>

On Thu, Aug 01, 2024 at 10:50:58AM +0100, Alan Maguire wrote:
> For kernel builds, pahole is called with -j to specify multithreading
> as long as it is >= 1.22.  However, if elfutils are older than 0.178
> at compile time, multithreading is not supported and we emit a
> warning to stderr.  The problem is this message will be emitted each
> time pahole is run, and this translates to thousands of times in a
> kernel build (once for vmlinux and once for each module).  Often users
> who are not familiar with BTF generation or pahole reasonably assume
> this is an error, whereas it is actually fine; it just means that
> pahole is a bit slower to generate BTF.
> 
> Move the message to verbose mode only, as in debugging cases it is
> important to know if pahole is running in parallel.

Thanks, applied to tmp.perf-tools-next,

- Arnaldo
 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  pahole.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/pahole.c b/pahole.c
> index dd5002a..4db5107 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -1889,7 +1889,8 @@ static error_t pahole__options_parser(int key, char *arg,
>  		  conf_load.nr_jobs = arg ? atoi(arg) :
>  					    sysconf(_SC_NPROCESSORS_ONLN) * 1.1;
>  #else
> -		  fputs("pahole: Multithreading requires elfutils >= 0.178. Continuing with a single thread...\n", stderr);
> +		  if (global_verbose)
> +			  fputs("pahole: Multithreading requires elfutils >= 0.178. Continuing with a single thread...\n", stderr);
>  #endif
>  							break;
>  	case ARGP_btf_encode_detached:
> -- 
> 2.43.5
