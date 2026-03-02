Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2038B2E612E;
	Mon,  2 Mar 2026 12:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772453918; cv=none; b=VqvOAucEHKl3ZMqiMEdeVyimaM0P9amiG5piEiKZ5BbhzxiRBkZ58xbTOpx8ja8TO+GZkrGvy8/gEtJEd5LCZq4OFQwAt98Kl0Ml/MjEwfWG9lx9IbCB0Z03KxunvpcyNd/L+0DMvLTAoX5AFFmfNaGPqur1NuEX3+zq66KBfw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772453918; c=relaxed/simple;
	bh=o/EDilnMID1sBXsf1AtGAZ+kf2Su9N5Mtz+dX90xNn0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=rfafdkfGcAjFEcINZ9h5VGu299CWisXRYmbuNCagRBtK97Gpu+hOSJYQnHlEHKg3wJm2jKKdbrLo6w8PZ8fjfjv0UPj5JR7B4/hqc+QOG21pVehSya8bBCOfaK7dSiVDfjzNgO9rYqkd06O01SgdE2mQCw53Yfk0G5IA2abjoSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uS5rt7wY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uS5rt7wY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7326CC19423;
	Mon,  2 Mar 2026 12:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772453917;
	bh=o/EDilnMID1sBXsf1AtGAZ+kf2Su9N5Mtz+dX90xNn0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=uS5rt7wYoelolV4MKB1nEhimD81WiIvHCGZgYbv8/jHP/oiwyUxsGH3Obki3fCI5f
	 gs5ysogsT5j3AfuiEWpJjRLsjeAMHbJzLly6A6siVi81UwMwwthJGT+8JqwivOXn2x
	 506LpnET1PnR0evyard0UMlasY51CQ8Yv8tanlI2z1+1AdU99ydPRKh+AFywe2TMQH
	 YgorfzP45hnvy1M1quiKCUx772/m4zawgtFAhbSm7TnEFdq3DjXlu85HVsRyj3QK3g
	 F5wHGV5YoPLv9N0PQrrvlkMT1Z8zsfEnjZMR3o7ClLvf665n0kdv/qUPygQ+LIf8HG
	 RRFF8vPhgLOZQ==
Content-Type: multipart/mixed; boundary="===============1568603404978382569=="
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ab4012acbb2b4a94c2e676d063d06353f91d383e8e462bd077185ad577f2eb93@mail.kernel.org>
In-Reply-To: <20260302114059.3697879-2-alan.maguire@oracle.com>
References: <20260302114059.3697879-2-alan.maguire@oracle.com>
Subject: Re: [PATCH v11 bpf-next 1/8] btf: add BTF kind layout encoding to UAPI
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,andrii@kernel.org,ast@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,qmo@kernel.org,ihor.solodrai@linux.dev,mykyta.yatsenko5@gmail.com,dwarves@vger.kernel.org,bpf@vger.kernel.org,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  2 Mar 2026 12:18:37 +0000 (UTC)

--===============1568603404978382569==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux/btf.h
> index 266d4ffa6c07..638615ebddc2 100644
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

Adding these two fields changes sizeof(struct btf_header) from 24 to
32 bytes.  In libbpf's btf_parse_hdr(), the non-native endian path
has a strict equality check against sizeof(struct btf_header):

tools/lib/bpf/btf.c:btf_parse_hdr() {
    if (hdr->magic == bswap_16(BTF_MAGIC)) {
        btf->swapped_endian = true;
        if (bswap_32(hdr->hdr_len) != sizeof(struct btf_header)) {
            ...
            return -ENOTSUP;
        }

All existing cross-endian BTF data has hdr_len=24.  After this UAPI
change, sizeof(struct btf_header) becomes 32, so the check rejects
any pre-existing non-native-endian BTF.

This is addressed in the next patch in the series, 5b3c2181ddc2
("libbpf: Support layout section handling in BTF"), which relaxes
the check to a minimum size comparison using
offsetofend(struct btf_header, str_len), and also adds the missing
layout_off/layout_len byte-swapping in btf_bswap_hdr().


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22574705927

AI-authorship-score: low
AI-authorship-explanation: Standard UAPI structure definition from a known kernel developer with prior lore discussion links and Suggested-by tag, consistent with human authorship.
issues-found: 1
issue-severity-score: medium
issue-severity-explanation: UAPI header change increases sizeof(struct btf_header), breaking libbpf cross-endian BTF loading for all pre-existing non-native-endian BTF data; fixed in the next patch in the series.

--===============1568603404978382569==--
