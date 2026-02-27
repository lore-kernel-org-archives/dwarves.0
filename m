Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B9E39A7EE;
	Fri, 27 Feb 2026 10:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772189537; cv=none; b=UE72dfHNtgDdij7CsLAR80inDwjEkBoHuMIM+YqDzXwa5lcBuo2KeVC1pFzmndUUaKD42FYLFjXiaC+Q434Tbbn7+dWMJZftpllCmCUnDDG3R6flnnLKyrLNZ5dYLr+0wr/t/4viAuxegxQB3in4+KI51La60e6RVI+9BTeEXYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772189537; c=relaxed/simple;
	bh=XD72lW81j7h2dYpdbIDsy350lKI1vKeexxDoGn3wKsA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=BNiu5v8yYXEmElDNFMsvbKuBIEx3PBpGZB/Rbc4aioJsgoDYUpY6ecWLRq2k7NUf6rzYnu4fgY47SQ8hP+i/lRMhqEdFjyUiL/7sHnnQCRmBm6HOVZXfEDFjJGB40wz1eypkZk/iOGxrzFOf34w3rAYWqyhhcp/oqrH9OsPuL90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSkhjsMf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSkhjsMf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F22C116C6;
	Fri, 27 Feb 2026 10:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772189536;
	bh=XD72lW81j7h2dYpdbIDsy350lKI1vKeexxDoGn3wKsA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=mSkhjsMfqLeSvVCw8NIGn68G2VtsqjSLz+xf8TIGEibUb2hZq+y0WUPNlScQQjdZe
	 XMkwfBI4Bd2w4nc8z1Mc5HqAsPxzWar5GrZLEydj3OCCKNFOt696bDqee5b+Y/gfoa
	 Jqs8/GUr4MFugQuCHQrZ+KgfV99LC4VnhV9CWql/iVheNsEkDe5aRsraHSJ23HNAUM
	 kKPK18BrYoHKwzXFD0Q7w90wDgP/S6xQxBzuqioJgl1xOGIBUhcknkbhzpCqofULUW
	 T27yBzu3nIwIzFlU3/Ddh3MBwtbIMyaKjnYvSk1khTHMkh7F6hy1cFwB6GFJVuHQku
	 WzT8rHYVKbnvQ==
Content-Type: multipart/mixed; boundary="===============8160448493734669229=="
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4b1bf31957861b05ae30b2e2380890f820604cb8fcd7f0414ba706e25a8d54ed@mail.kernel.org>
In-Reply-To: <20260227100426.2585191-3-alan.maguire@oracle.com>
References: <20260227100426.2585191-3-alan.maguire@oracle.com>
Subject: Re: [PATCH v10 bpf-next 02/10] libbpf: Support layout section handling in BTF
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,andrii@kernel.org,ast@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,qmo@kernel.org,ihor.solodrai@linux.dev,mykyta.yatsenko5@gmail.com,dwarves@vger.kernel.org,bpf@vger.kernel.org,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 27 Feb 2026 10:52:14 +0000 (UTC)

--===============8160448493734669229==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 83fe79ffcb8f..7b58724a90a2 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c

[ ... ]

>  static int btf_parse_hdr(struct btf *btf)
>  {
> -	struct btf_header *hdr = btf->hdr;
> +	struct btf_header *hdr = btf->raw_data;
> +	__u32 hdr_len = hdr->hdr_len;
>  	__u32 meta_left;
>
> -	if (btf->raw_size < sizeof(struct btf_header)) {
> +	if (btf->raw_size < offsetofend(struct btf_header, str_len)) {
>  		pr_debug("BTF header not found\n");
>  		return -EINVAL;
>  	}

Could the read of hdr->hdr_len at offset 4 above be an out-of-bounds
access when raw_size is less than 8?

The previous code set hdr as a pointer without dereferencing it, then
checked raw_size before accessing any header fields.  The new code
reads hdr->hdr_len before the raw_size check.

btf_new() calls btf_parse_hdr() with whatever size the caller provided
via btf__new() or btf_parse_elf(), so small or corrupt input could
reach here.  On the mmap path the data could sit at a page boundary
where offset 4 would fault.

Moving the initialization of hdr_len to after the size check would
restore the pre-patch safety:

    struct btf_header *hdr = btf->raw_data;
    __u32 hdr_len;
    __u32 meta_left;

    if (btf->raw_size < offsetofend(struct btf_header, str_len)) {
        ...
    }

    hdr_len = hdr->hdr_len;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22482435858

AI-authorship-score: low
AI-authorship-explanation: Patch went through 10 review iterations on lore with human interactions; the subtle ordering bug is characteristic of human-authored refactoring.
issues-found: 1
issue-severity-score: medium
issue-severity-explanation: btf_parse_hdr() reads hdr->hdr_len from raw_data before validating raw_size, causing an out-of-bounds heap read on small or corrupt input via the public btf__new() API.

--===============8160448493734669229==--
