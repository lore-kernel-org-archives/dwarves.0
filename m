Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBF4396D30;
	Tue, 24 Mar 2026 18:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774378530; cv=none; b=j9vxptei7a67/xmzPXGF7yB6DSxEE+lqoEDQv5WM9st1L3UaGmYcq52qDpZQctE7wpxw7O2+snoKTB+xPbBi6N8TZvr8Cr5HkMv8+n+2la6dSZ0cCjofaHBz6pM2apJe1z/qFRIDsIZO27tTDcaFfZg+V6OLfOfhDEWGDg7FHw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774378530; c=relaxed/simple;
	bh=nuEijuQG00gejYrU5FL0Cu1ZaNzlvw+Hm53CFkAscKE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=rN6VHpeTfHRDuBx38ARLyIFxeMKbHyNDcTO6E85VWz/dU6OZ/cmY0GpkzxqIBs50VO9kq2O9ovpzxiyELUdqFOqITc0f6MxRAU1akDo8LelkaVzAiSf5FlzruU+wF6tbSC3Z2RHlBN1BCi9topseM3eETQoPxdruuAG35ZD2pKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8AtpC0A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8AtpC0A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FBD4C19424;
	Tue, 24 Mar 2026 18:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774378529;
	bh=nuEijuQG00gejYrU5FL0Cu1ZaNzlvw+Hm53CFkAscKE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=r8AtpC0ADAzHGESH0FA3WJJT1Wy1dwJDj4F6wEdBj3t6A29n+koouRZc98fAYRPMc
	 BkG7KLuFcETnSEqzS3ik4tb0R/tnb3S+n9soqCD8JEUhLpYkQ9ARvYm6GsYZPo3tXg
	 /KBeLzReTQJFk/URIlwhnIX5ItiJ+S14geOgPeUEOnr5IA3fMBVCw18ywuzXtsWEXA
	 BNsKDrkSqplpcXQFlXGt3A9w61gmCCTO/cQD9MqDbbmbbYGThgSp/Hvl0/PfjuKoaX
	 XaUMoyqpYi8IF+ly7DqH2puW1MdWuRTsjtIJDfqet+YmZ9eUfVxgcVRbtx9fAp2E69
	 iXT6eBiqGgvkQ==
Content-Type: multipart/mixed; boundary="===============3152709391166260729=="
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ef3fe9d80d24f7498410bffe938da1882448e5b6012fcc3ca97fff5645018ba8@mail.kernel.org>
In-Reply-To: <20260324174450.1570809-7-alan.maguire@oracle.com>
References: <20260324174450.1570809-7-alan.maguire@oracle.com>
Subject: Re: [PATCH v15 bpf-next 6/9] libbpf: Support sanitization of BTF layout for older kernels
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,andrii@kernel.org,ast@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,qmo@kernel.org,ihor.solodrai@linux.dev,mykyta.yatsenko5@gmail.com,dwarves@vger.kernel.org,bpf@vger.kernel.org,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 24 Mar 2026 18:55:29 +0000 (UTC)

--===============3152709391166260729==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 1eaa7527d4dab..e32b42ef9be84 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> +	/* btf_header() gives us endian-safe header info */
> +	hdr = btf_header(orig_btf);
> +
> +	if (!has_layout && hdr->hdr_len >= sizeof(struct btf_header) &&
> +	    (hdr->layout_len != 0 || hdr->layout_off != 0)) {
> +		const struct btf_header *old_hdr = raw_data;
> +		struct btf_header *new_hdr;
> +		void *new_raw_data;
> +		__u32 new_str_off;
> +
> +		/*
> +		 * Need to rewrite BTF to exclude layout information and
> +		 * move string section to immediately after types.
> +		 */
> +		new_raw_data = malloc(sz);
> +		if (!new_raw_data)
> +			return ERR_PTR(-ENOMEM);
> +
> +		memcpy(new_raw_data, raw_data, sz);
> +		new_hdr = new_raw_data;
> +		new_hdr->layout_off = 0;
> +		new_hdr->layout_len = 0;
> +		new_str_off = hdr->type_off + hdr->type_len;
> +		/* Handle swapped endian case */
> +		if (old_hdr->str_off != hdr->str_off)
> +			new_hdr->str_off = bswap_32(new_str_off);
> +		else
> +			new_hdr->str_off = new_str_off;
> +
> +		memmove(new_raw_data + hdr->hdr_len + new_hdr->str_off,
> +			new_raw_data + hdr->hdr_len + hdr->str_off,
> +			hdr->str_len);

In the swapped-endian case, new_hdr->str_off holds the byte-swapped
(file-endian) value after the bswap_32() above.  When that value is
used here as a host memory offset for the memmove destination, it
produces a nonsensical address.

For example, if new_str_off is 24 (0x00000018), then bswap_32 gives
0x18000000, which is ~400 MB past the buffer.  This would overflow
the malloc'd new_raw_data buffer.

Should the memmove destination use new_str_off (the host-endian
offset) instead of new_hdr->str_off?  Something like:

    memmove(new_raw_data + hdr->hdr_len + new_str_off,
            new_raw_data + hdr->hdr_len + hdr->str_off,
            hdr->str_len);

> +		sz = hdr->hdr_len + hdr->type_off + hdr->type_len + hdr->str_len;
> +		btf = btf__new(new_raw_data, sz);
> +		free(new_raw_data);

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23504838405
--===============3152709391166260729==--
