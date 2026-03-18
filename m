Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF7427E04C;
	Wed, 18 Mar 2026 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773845128; cv=none; b=r9Y2QiW2c7bkwySy+OSr8Y8E7Rl5+kkXyNi3+msuP4WTZg4nV1aOUCD9WVULsxWKo8DWrxHfps8qITZBXJ/X3pDrCPcl2awV4es/LMZoYqgi+KYYISTLFA/Syq/nqQdWGSjUwQGmlu0NogRSMjXhMkoPwQB7AZtB4RPik96TQY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773845128; c=relaxed/simple;
	bh=q+E+YALFTyk5ozTWUhfz6/8GZeRfAyH6cBMTj1YKfaU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=LYvb2gHIos+imcPsAO7e2CjGax3oCNgeTDL6a0TjZRAsOdnunkUr4wjSFuZz3xjA0dqzRUiL++ji8RagI3ThHVyEAXr/jn02y0cYikiG+MFgfYR8DKfPZze7K/2KPdrRwWapyBZBDrGVtYzkU7qNzXocplafJjoU5B9PTaeFBnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIqRTbFY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIqRTbFY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26BBC2BC87;
	Wed, 18 Mar 2026 14:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773845128;
	bh=q+E+YALFTyk5ozTWUhfz6/8GZeRfAyH6cBMTj1YKfaU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=vIqRTbFYKaEN35AsnTc/jmJMLw551oyDqtLgRhGMN6rD3LIaCodqSZUD59oFBlqe8
	 7Ur4eCyhjji57Vv8fcd4D8VaOvFjLiHpUraytnl5AAvKR6VhnkPV7AWWhyGbDO2lKG
	 b4amZArrBOJuA0X9OeCPNt0z6FtsOkcNJfWVV1tSirKvfahUNYurLy6md+ZG6jHv5e
	 TU4mFnpS40rafvA+8LlwqYJ3qCfm2SHxc9uzazT/rmy1JixA/pOzuDINcs07VFpEC/
	 190DFZMs6TDBFU3KAcVoP7ow6nFosuUbo90lF0K1eaZycjvhQLXZ5UDx31t7EPG7Dk
	 pW7mZnpbnOdPg==
Content-Type: multipart/mixed; boundary="===============1325255656789277103=="
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9bb62dd69d27eaaf36db9036240de0354722c839121572557dd161a2511c6a43@mail.kernel.org>
In-Reply-To: <20260318132927.1142388-3-alan.maguire@oracle.com>
References: <20260318132927.1142388-3-alan.maguire@oracle.com>
Subject: Re: [PATCH v14 bpf-next 02/10] libbpf: Support layout section handling in BTF
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,andrii@kernel.org,ast@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,qmo@kernel.org,ihor.solodrai@linux.dev,mykyta.yatsenko5@gmail.com,dwarves@vger.kernel.org,bpf@vger.kernel.org,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 18 Mar 2026 14:45:27 +0000 (UTC)

--===============1325255656789277103==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 40becc9643688..37a3b317cb2f4 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c

[ ... ]

> -static void btf_bswap_hdr(struct btf_header *h)
> +static void btf_bswap_hdr(struct btf_header *h, __u32 hdr_len)
>  {
>  	h->magic = bswap_16(h->magic);
>  	h->hdr_len = bswap_32(h->hdr_len);
> @@ -224,66 +246,113 @@ static void btf_bswap_hdr(struct btf_header *h)
>  	h->type_len = bswap_32(h->type_len);
>  	h->str_off = bswap_32(h->str_off);
>  	h->str_len = bswap_32(h->str_len);
> +	/* May be operating on raw data with hdr_len that does not include below fields */
> +	if (hdr_len >= sizeof(struct btf_header)) {
> +		h->layout_off = bswap_32(h->layout_off);
> +		h->layout_len = bswap_32(h->layout_len);
> +	}
>  }
>
>  static int btf_parse_hdr(struct btf *btf)
>  {
> -	struct btf_header *hdr = btf->hdr;
> -	__u32 meta_left;
> +	struct btf_header *hdr = btf->raw_data;
> +	__u32 hdr_len, meta_left;
>
> -	if (btf->raw_size < sizeof(struct btf_header)) {
> +	if (btf->raw_size < offsetofend(struct btf_header, str_len)) {
>  		pr_debug("BTF header not found\n");
>  		return -EINVAL;
>  	}
>
> +	hdr_len = hdr->hdr_len;
> +
>  	if (hdr->magic == bswap_16(BTF_MAGIC)) {
>  		btf->swapped_endian = true;
> -		if (bswap_32(hdr->hdr_len) != sizeof(struct btf_header)) {
> +		hdr_len = bswap_32(hdr->hdr_len);
> +		if (hdr_len < offsetofend(struct btf_header, str_len)) {
>  			pr_warn("Can't load BTF with non-native endianness due to unsupported header length %u\n",
> -				bswap_32(hdr->hdr_len));
> +				hdr_len);
>  			return -ENOTSUP;
>  		}
> -		btf_bswap_hdr(hdr);
> +		btf_bswap_hdr(hdr, hdr_len);

Could btf_bswap_hdr() access memory beyond the raw_data buffer here?

The initial check guarantees raw_size >= offsetofend(str_len) which
is 24 bytes.  But if hdr_len (after bswap) is >= 32,
btf_bswap_hdr() will read and write h->layout_off at offset 24 and
h->layout_len at offset 28.  If raw_size is between 24 and 31,
those accesses go past the end of the raw_data buffer.

The raw_size >= hdr_len check that would catch this comes after the
btf_bswap_hdr() call:

>  	} else if (hdr->magic != BTF_MAGIC) {
>  		pr_debug("Invalid BTF magic: %x\n", hdr->magic);
>  		return -EINVAL;
>  	}
>
> -	if (btf->raw_size < hdr->hdr_len) {
> +	if (btf->raw_size < hdr_len) {
>  		pr_debug("BTF header len %u larger than data size %u\n",
> -			 hdr->hdr_len, btf->raw_size);
> +			 hdr_len, btf->raw_size);
>  		return -EINVAL;
>  	}

Moving this raw_size < hdr_len check (or an equivalent guard) to
before the btf_bswap_hdr() call in the swapped-endian branch would
prevent the out-of-bounds access.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23248215146
--===============1325255656789277103==--
