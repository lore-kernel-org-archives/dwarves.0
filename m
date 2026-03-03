Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30BF3537DE;
	Tue,  3 Mar 2026 19:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772565324; cv=none; b=c3NBg1UMc7/CLFSnUPt2TB+xvfSr0RToCdDWUH8RfQvmm1wgsPHPnZMON+PtbFnOtdBKObw1k/G+r8uz3LWgZyuzrwQqOQy1TEb/mkZEZtkuzEfL2tbS9GKQOPpBflfcI67M+7wCzH4+UbUCvuWt8H+S/YiWPOkgGM3u6IcYzpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772565324; c=relaxed/simple;
	bh=NE3k5ShK61JfPaYAteSxTjXb0MN3z1iOyzMaetYFGHI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=aAvfBnmVZfJ8GSM93HeRkSiVlDipahSEDAbW45BR8dMYvLyh20TSdDZFpfY3ek4UXA0gl1AXCzsbuYrG2tCZMEUR+M80WJVfn9nnWLCXjyp9UU+/1cb0633nRkSsV3U0WMqqqgBiYBG3ah3Axu1Nb+4O2VqyNGcndBZOAlkFFQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBg1V/Ee; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBg1V/Ee"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0C8C2BCAF;
	Tue,  3 Mar 2026 19:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772565323;
	bh=NE3k5ShK61JfPaYAteSxTjXb0MN3z1iOyzMaetYFGHI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=CBg1V/EeqFTFf1ScahFCO47L6QFEoF1wMiV2fjIy3kQDBAQG9IXtoJ2SSVqAVtdwg
	 9uJ37YmqVVxzwGAtv4LCjVZYOGNKA9qwChbYTYWV5UOPrqB9bHEQFRlNm6ry1LR8FU
	 LkmWogf9iC0sbFHQXsjq5+yErAkh02DFLEqn6ZemVz8j+uTEFr5nWbVEGrBzzjlSyr
	 xRUjyZn8tSNBrUPT3pJnDU+1cIoMTamYRzSgRDTKoFVjAyxgVKjpIGs83G10nv7Odf
	 gbZiJIzQ7CSnl42J5r9SxmvFP3R/Y/OJVeU6IqT2XtzPhiDfBpYpjBmwGdd9hiUuzz
	 S4P3CIRSmqTjg==
Content-Type: multipart/mixed; boundary="===============1886158095556110975=="
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e61bf7dbb3695fe7a79f12ab9d0bb64f0a3b2baabff37f0682492c37c11cb595@mail.kernel.org>
In-Reply-To: <20260303182003.117483-2-alan.maguire@oracle.com>
References: <20260303182003.117483-2-alan.maguire@oracle.com>
Subject: Re: [PATCH v12 bpf-next 1/8] btf: add BTF kind layout encoding to UAPI
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,andrii@kernel.org,ast@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,qmo@kernel.org,ihor.solodrai@linux.dev,mykyta.yatsenko5@gmail.com,dwarves@vger.kernel.org,bpf@vger.kernel.org,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  3 Mar 2026 19:15:23 +0000 (UTC)

--===============1886158095556110975==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux/btf.h
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
            pr_warn("Can't load BTF with non-native endianness "
                    "due to unsupported header length %u\n",
                    bswap_32(hdr->hdr_len));
            return -ENOTSUP;
        }
    ...
}

All existing cross-endian BTF has hdr_len=24.  After this UAPI
change, sizeof(struct btf_header) becomes 32, so
bswap_32(24) != 32 and the check rejects them.

Would it make sense to update this check in the same patch as
the header change?  As-is, recompiling libbpf with the new header
breaks loading of any pre-existing non-native-endian BTF data.

This appears to be addressed in the next patch in the series,
9aabbd83dae5 ("libbpf: Support layout section handling in BTF"),
which relaxes the check to a minimum size comparison.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22637324186
--===============1886158095556110975==--
