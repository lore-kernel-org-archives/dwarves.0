Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAC61D0411
	for <dwarves@vger.kernel.org>; Thu, 17 Oct 2024 20:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729196828; cv=none; b=hpq3iJA78j2nTLL1yqw1+RQGCGBZunCzUL8uGvT8RUKJkK5ccI6pN6j8Si4se1jAecKssPZQyMuZjjtpBYNS0Po9kYiE4myg6aRun3ykXEcXvvV7msoCgFIz9QsU/N1rZB2trA/cpc7Vy+ktGQiR/sJmVCCy9XB2lRbKASWo85s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729196828; c=relaxed/simple;
	bh=91mgah0Pa67n44g/R0pKK9GZGCOWQz055C5/BNrhjyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqFY8k6RZwSKs/z55WMjgQk5fGFqbl+LSL1zYvNBvJU2ktZgdit3SxnkT3ZhGkLre1GMaZY5AKnIo53rKzONGIECbZ/+7F/rOc2C5nZpDQcayVRikp0BxyE+RsybA0u8bk9WX7wcBb165ibqMQjKIXn3yPkDGJ99vavPVf8B2Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bl2mScB2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bl2mScB2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F2DC4CEC3;
	Thu, 17 Oct 2024 20:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729196827;
	bh=91mgah0Pa67n44g/R0pKK9GZGCOWQz055C5/BNrhjyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bl2mScB2g2bNBRF2q8M5n5ZiCQsUfH0jGd4rNuqA0POGryPPa02NFiO5nUH4zEak3
	 hWWKYFp3t/jpQVoI0bqJCZtC8ppa82eGDCIBXEpMVNcJ/0gtuwdBGWuPqckr/fhor/
	 o9anphW+7bzVsSqcmntm8/xe4RzuxY8IO8jvODFqSupughl9sPAu99YDOy0vre2g3+
	 bPHiUc+4dEJ0BxtCUN9c9tDl6mOAxHsOKQmRUsZvEFzfzLceZ3Jcov8lphQ/qJzXRr
	 K20f4sROtrgUqEGLWfSMAcQQ7hp5oNJfRVaXDcVmdhAtjxULdkRcQI25XF6C5Zt0NF
	 +V6qS+wpLskWQ==
Date: Thu, 17 Oct 2024 17:27:04 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: dwarves@vger.kernel.org, eddyz87@gmail.com
Subject: Re: [PATCH dwarves 1/2] btf_loader: send warnings to stderr
Message-ID: <ZxFzGNrgeFMSswGe@x1>
References: <20241017092433.690192-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017092433.690192-1-alan.maguire@oracle.com>

On Thu, Oct 17, 2024 at 10:24:32AM +0100, Alan Maguire wrote:
> Among other things, this helps simplify tests/btf_functions.sh.

Thanks, applied both patches.

- Arnaldo
 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  btf_loader.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/btf_loader.c b/btf_loader.c
> index c70b67f..4814f29 100644
> --- a/btf_loader.c
> +++ b/btf_loader.c
> @@ -449,7 +449,7 @@ static int create_new_tag(struct cu *cu, int type, const struct btf_type *tp, ui
>  	case BTF_KIND_TYPE_TAG:	tag->tag = DW_TAG_LLVM_annotation; break;
>  	default:
>  		free(tag);
> -		printf("%s: Unknown type %d\n\n", __func__, type);
> +		fprintf(stderr, "%s: Unknown type %d\n\n", __func__, type);
>  		return 0;
>  	}
>  
> @@ -470,7 +470,7 @@ static int process_decl_tag(struct cu *cu, const struct btf_type *tp)
>  		tag = cu__tag(cu, tp->type);
>  
>  	if (tag == NULL) {
> -		printf("WARNING: BTF_KIND_DECL_TAG for unknown BTF id %d\n", tp->type);
> +		fprintf(stderr, "WARNING: BTF_KIND_DECL_TAG for unknown BTF id %d\n", tp->type);
>  		return 0;
>  	}
>  
> @@ -478,7 +478,8 @@ static int process_decl_tag(struct cu *cu, const struct btf_type *tp)
>  
>  	if (tag->attribute != NULL) {
>  		char bf[128];
> -		printf("WARNING: still unsuported BTF_KIND_DECL_TAG(%s) for %s already with attribute (%s), ignoring\n",
> +
> +		fprintf(stderr, "WARNING: still unsuported BTF_KIND_DECL_TAG(%s) for %s already with attribute (%s), ignoring\n",
>  		       attribute, tag__name(tag, cu, bf, sizeof(bf), NULL), tag->attribute);
>  	} else {
>  		tag->attribute = attribute;
> -- 
> 2.43.5
