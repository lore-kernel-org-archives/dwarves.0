Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05197401A16;
	Thu, 26 Mar 2026 15:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774540398; cv=none; b=nV0VCwvK0g5RgH1l1+/cj63LB3SRLT9Jpz9mzMy26+sBbb6quAb+3iec6S/q+WVlktEc7jX+jWM0eRqQwH8WzFSOvXBw8kOxZlMO/VtnkkSNNhgfATtPI9oWwLD6O0AzQ024EQa/RHJ1SUHOEUcaUMUT0RGBGDfFlbl6fUcR8Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774540398; c=relaxed/simple;
	bh=2dLZQLFzZZyIkFieYO5g5/wzaBQxEhrR7IxuzkiWRgw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=chvAupWRuMxDEEjaZGbpwULcMx+QdQGr6OaUPsIoyJ65y/rwhdFNIu/8pbRD+DAysSoa9pFmGp5fUAUaWu1io3cnYXQytfINlRMGQCctQCy7FBw65MKHV76zSHBiQu4+8Ilyc+fv3cDYdpsczkZOY9yRJqDEuUZFJYahBoWdLog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzGDC8qA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzGDC8qA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36828C116C6;
	Thu, 26 Mar 2026 15:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774540397;
	bh=2dLZQLFzZZyIkFieYO5g5/wzaBQxEhrR7IxuzkiWRgw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=LzGDC8qAWCCZx1JiOqmRGTru48xePLTxc6MkVTMp6m9Y8gTG7O11lj6TqusKx99SB
	 /lr2os3TD0bpUtrFW4e0vPGY8TDlFxvsOueRO8aU+f8h/RYTnN5h5hA7buhBcBesLy
	 dcHVokWjlEL6k/h3mmCnrFYSZ4d+5RucTWVNUnYCNlh+c6MFNk8jKEozvBTL2wclTC
	 rGNCxs+V4wplkm3avAQJIRJGJuqfDAZGnWQUDfwAZvc7jNLs7Mg46f3ecNWi6EZ8rc
	 HW19dDBHRN4Q/3eYfwscvDy7iQT5tiLYH1qtKBHIrj1rElppqpucB6ATim3ai9K7+N
	 PBuhaPr/cdYZQ==
Content-Type: multipart/mixed; boundary="===============1055253975063940016=="
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bd1688717a1d23adc4c0b7065c880526312122d910e37f72e12885ff5d5047b4@mail.kernel.org>
In-Reply-To: <20260326145444.2076244-2-alan.maguire@oracle.com>
References: <20260326145444.2076244-2-alan.maguire@oracle.com>
Subject: Re: [PATCH v16 bpf-next 1/9] btf: Add BTF kind layout encoding to UAPI
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,andrii@kernel.org,ast@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,qmo@kernel.org,ihor.solodrai@linux.dev,mykyta.yatsenko5@gmail.com,dwarves@vger.kernel.org,bpf@vger.kernel.org,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 26 Mar 2026 15:53:17 +0000 (UTC)

--===============1055253975063940016==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux/btf.h
> index 266d4ffa6c077..638615ebddc22 100644
> --- a/tools/include/uapi/linux/btf.h
> +++ b/tools/include/uapi/linux/btf.h

[ ... ]

> @@ -19,6 +29,8 @@ struct btf_header {
>  	__u32	type_len;	/* length of type section	*/
>  	__u32	str_off;	/* offset of string section	*/
>  	__u32	str_len;	/* length of string section	*/
> +	__u32	layout_off;	/* offset of layout section	*/
> +	__u32	layout_len;	/* length of layout section	*/
>  };

Adding these two fields changes sizeof(struct btf_header) from 24
to 32 bytes.  In libbpf's btf_parse_hdr(), the non-native endian
path has a strict equality check:

tools/lib/bpf/btf.c:btf_parse_hdr() {
    if (hdr->magic == bswap_16(BTF_MAGIC)) {
        btf->swapped_endian = true;
        if (bswap_32(hdr->hdr_len) != sizeof(struct btf_header)) {
            ...
            return -ENOTSUP;
        }
    ...
}

All existing cross-endian BTF has hdr_len=24.  After this UAPI
change, sizeof(struct btf_header) becomes 32, so
bswap_32(24) != 32 and the check rejects them.

Would it make sense to update this check in the same patch as
the header change?  As-is, recompiling libbpf with the new
header breaks loading of any pre-existing non-native-endian
BTF data.

This appears to be addressed in the next patch in the series,
d51f2326465ba ("libbpf: Support layout section handling in BTF"),
which relaxes the check to a minimum size comparison.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23601795195
--===============1055253975063940016==--
