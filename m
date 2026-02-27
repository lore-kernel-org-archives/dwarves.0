Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D579B3D6686;
	Fri, 27 Feb 2026 10:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772189529; cv=none; b=oDSnIaI58fNVPO3DdK1/lQBhuF8lF0J1Lu8FLNIXpTCPRfpzfIgpt20WtCIvllj8UizGMwW+xkjCuDLj4zWLyS7fKZRpewX3jUT4EtC+465tu/hZ+6K1S1ojH1hPoDrP07PfaNmPpUQ7q2osX/MxL6Cdg+7nr0QByH79dX57lcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772189529; c=relaxed/simple;
	bh=IZeKt88sjdmO0d7EwYBTnVtwttkx9n2sc65Yfhxhgbs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=HxnhxT3PHypCQBhWMyNQWzsvfeUnq9FIMg8FAKItlqWbJHyDq1P8FX4KGPMrHIN1fL+DBwUyPh+9ZZOv31SKUyopHw/ka8xli/j8gGNhIpevIVQfiIoESS4VIabthsAcX30RiUaWL6R5nT9yKsp7ubi4xhAoM218uW004ocAjEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rEFomRKH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rEFomRKH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91B2C116C6;
	Fri, 27 Feb 2026 10:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772189529;
	bh=IZeKt88sjdmO0d7EwYBTnVtwttkx9n2sc65Yfhxhgbs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=rEFomRKHxljaBmDxCP02pNNwk5D3CDFIfcGE3jgEREDcRnNmDya6CLiD5+70S3ONV
	 qlvbf3RTbnojLqlP8p8wPnha8sdTXYZVSBdVNhZ6P9Sx0bbk/1c9uAl2HIqx/pJasp
	 ZE4Mhoj4dc9jv/uwQ3VXASjhtIXR5lbK0pGkQhCDiadUF4SaHQlfmUE7R76vM38dHk
	 ZM5tj6m0A3m4y5zYIH4lUt1UIBi3eRK/DtrkkYK2n7RHB9a/z8pSIgeIuroJAg4b70
	 VPihiLyswuFgyB0Yzf+xSndQoUXnGCuproci2OXv2W/VBOu+lwzQvu0HI4Kc2LmGS/
	 3Pbwmr8yjyxug==
Content-Type: multipart/mixed; boundary="===============4839099163509389329=="
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <df00956ee63256fa4f1cd7d847797e49362aee2963cfc771a05e9c4ef640e781@mail.kernel.org>
In-Reply-To: <20260227100426.2585191-2-alan.maguire@oracle.com>
References: <20260227100426.2585191-2-alan.maguire@oracle.com>
Subject: Re: [PATCH v10 bpf-next 01/10] btf: add BTF kind layout encoding to UAPI
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,andrii@kernel.org,ast@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,qmo@kernel.org,ihor.solodrai@linux.dev,mykyta.yatsenko5@gmail.com,dwarves@vger.kernel.org,bpf@vger.kernel.org,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 27 Feb 2026 10:52:07 +0000 (UTC)

--===============4839099163509389329==
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

Adding these two fields changes sizeof(struct btf_header) from 24
to 32 bytes. In libbpf's btf_parse_hdr(), the non-native endian
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

All existing cross-endian BTF has hdr_len=24. After this UAPI
change, sizeof(struct btf_header) becomes 32, so bswap_32(24)
!= 32 and the check rejects them.

Would it make sense to update this check in the same patch as
the header change? As-is, recompiling libbpf with the new
header breaks loading of any pre-existing non-native-endian
BTF data.

This appears to be addressed in the next patch in the series,
aa01655822a6 ("libbpf: Support layout section handling in BTF"),
which relaxes the check to a minimum size comparison.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22482435858

AI-authorship-score: low
AI-authorship-explanation: Standard UAPI structure definition from a known kernel developer with prior lore discussion links and Suggested-by tag, consistent with human authorship.
issues-found: 1
issue-severity-score: medium
issue-severity-explanation: UAPI header change increases sizeof(struct btf_header), breaking libbpf cross-endian BTF loading for all pre-existing non-native-endian BTF data; fixed in the next patch in the series.

--===============4839099163509389329==--
