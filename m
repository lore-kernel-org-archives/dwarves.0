Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF083A1D1A;
	Thu, 26 Feb 2026 10:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772100360; cv=none; b=mP/+cKcI3zbZW3QFfFZeVmSmdNcRWvCYfzITk3ikH2QYk10Kmd8l78UMPkXN087/8hkU02jqnpsnxO1Ij65Q/ehKoGBxxNIuWugui43hQXx/S4bsYefqLY/svWU88s2TjUvEOPh4fv1Gq1QmKzZvL0VMwwVIdcomVIvFwjz6zNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772100360; c=relaxed/simple;
	bh=eoRXZrRxRnKYax4o2Gq8rQTqHGtZNjsO6KvoELD9tx0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=rkOjFGGBXQVZndyepHgYQR/OpnRtY9mWC8Tf7pOzUJZy4eJUKBY8+3iPdmW8TPruB31jnzDrVSUqfKGAVJgHY7mHY4v4zXmmxw+JODn4l50DvtjDddzEzBWp1pLjQ5HZaWuqL/qBY4zLPhuUVwJ17u0I3P+klsYIvpvWR88WYMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eaQ14SLE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eaQ14SLE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B46C19422;
	Thu, 26 Feb 2026 10:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772100360;
	bh=eoRXZrRxRnKYax4o2Gq8rQTqHGtZNjsO6KvoELD9tx0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=eaQ14SLEZWkf948aq+zRZ8ejPhiQWlEIu+xLugNmIayLmySBw6URgXq9lDWrGEX+1
	 bia7rpsqohN66S4WIHf3xO0th2IYSav3ICuKAd/VM8wDUAPXq2/yHbYh0cdQek1x5+
	 AtLxNkk8pTm/MXUEWaxXhqE+AQtXSTmgFkvDhveHA+OnmMaS0odw4Ks9yGumep1C1K
	 MhAB3AdyZZYwgPFq6b92anAmDHN1cr9l76C/5qiyUdYst8E3y2/ZKlWTl9FVuPBLqN
	 AhsOAhI2EXr9ryIf3bQ5rD7hffMhSB+7MCWjx7MGeQGpD2UvLEYiss+Z0+D30RagzC
	 z8AnmjzvXlVdg==
Content-Type: multipart/mixed; boundary="===============6843499927274922463=="
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1e030700935a6f99789250a8841c908cfda89f4e5cd215ada2485b02c07994c7@mail.kernel.org>
In-Reply-To: <20260226085624.1909682-3-alan.maguire@oracle.com>
References: <20260226085624.1909682-3-alan.maguire@oracle.com>
Subject: Re: [PATCH v9 bpf-next 02/10] libbpf: Support layout section handling in BTF
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,andrii@kernel.org,ast@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,qmo@kernel.org,ihor.solodrai@linux.dev,mykyta.yatsenko5@gmail.com,dwarves@vger.kernel.org,bpf@vger.kernel.org,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 26 Feb 2026 10:05:58 +0000 (UTC)

--===============6843499927274922463==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 83fe79ffcb8f..3438cc15bb7a 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c

[ ... ]

> @@ -224,66 +242,95 @@ static void btf_bswap_hdr(struct btf_header *h)

[ ... ]

>  static int btf_parse_hdr(struct btf *btf)
>  {
> -	struct btf_header *hdr = btf->hdr;
> +	struct btf_header *hdr = btf->raw_data;
> +	__u32 hdr_len = hdr->hdr_len;

[ ... ]

> +	memcpy(&btf->hdr, hdr, min((size_t)hdr_len, sizeof(struct btf_header)));

The memcpy here correctly caps the copy at sizeof(struct btf_header),
but btf->hdr.hdr_len retains the original value from the raw data.
If the input BTF has a future-extended header where hdr_len exceeds
sizeof(struct btf_header), only sizeof(struct btf_header) bytes are
stored, yet hdr_len remembers the larger original value. This
matters in btf_get_raw_data() below.

[ ... ]

> @@ -1601,7 +1664,7 @@ static const void *btf_strs_data(const struct btf *btf)
>
>  static void *btf_get_raw_data(const struct btf *btf, __u32 *size, bool swap_endian)
>  {
> -	struct btf_header *hdr = btf->hdr;
> +	const struct btf_header *hdr = &btf->hdr;
>  	struct btf_type *t;
>  	void *data, *p;
>  	__u32 data_sz;

[ ... ]

>  	memcpy(p, hdr, hdr->hdr_len);

When hdr_len > sizeof(struct btf_header), does this read past the
end of the embedded btf->hdr struct? hdr points to &btf->hdr which
is sizeof(struct btf_header) bytes, but hdr->hdr_len can be larger
if the parsed BTF had a future-extended header. The extra bytes
would come from adjacent struct btf fields (types_data, etc.),
leaking internal state into the serialized output.

Previously, btf->hdr pointed directly into raw_data where the full
header (including any extension bytes) was available. The switch to
an embedded struct loses those extra bytes, but the serialization
still tries to write hdr_len bytes.

One possible fix:

    memcpy(p, hdr, min((__u32)sizeof(struct btf_header), hdr->hdr_len));
    if (hdr->hdr_len > sizeof(struct btf_header))
        memset(p + sizeof(struct btf_header), 0,
               hdr->hdr_len - sizeof(struct btf_header));

>  	if (swap_endian)
> -		btf_bswap_hdr(p);
> +		btf_bswap_hdr(p, hdr->hdr_len);
>  	p += hdr->hdr_len;

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22436234361

AI-authorship-score: low
AI-authorship-explanation: The patch went through nine review iterations on lore with detailed human reviewer interactions, follows established libbpf patterns, and the subtle header over-read is characteristic of human-authored refactoring.
issues-found: 1
issue-severity-score: medium
issue-severity-explanation: btf_get_raw_data() reads past the embedded btf->hdr struct into adjacent fields when hdr_len exceeds sizeof(struct btf_header), silently leaking internal state into serialized BTF output.

--===============6843499927274922463==--
