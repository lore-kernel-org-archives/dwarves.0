Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048913A1E76;
	Thu, 26 Feb 2026 10:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772100346; cv=none; b=Je3t6Pm/GLUeqi5tTNm9s9jqr7AlnqvpsFZ4runc/JFqFTTmpdvVspuvOjKfUvRDZnh/STPLQ7i/9sSvKuXJQbcXISnVi73tYBmBpeIdvhbI1P5S1J1tIhZ9Nhg8cdghdtNp1+9eXGZdd5qNmuVBgmHg9F11E9S2NnvBoW9/Xb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772100346; c=relaxed/simple;
	bh=L+cTRlZLJjUw/24jURijMY67vEbF3JRgA/kREVHYNIc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=r9HhpRSA4Uxxl9ZwFHd5gbJA210MmhROBymxA2LlxsjsoLBOP8+OX+qVJTigLQuPaar+BoH//Ib/Rn9awEHCDBntbur8UDxcDko/36/T+1DIU8PlgZoROZOFaBzTzjXdabjvXWJQWXgy/6HBiecKVFtpxu9hHyR+2xeCiMfHVT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+zGTjzZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+zGTjzZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFB17C19423;
	Thu, 26 Feb 2026 10:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772100345;
	bh=L+cTRlZLJjUw/24jURijMY67vEbF3JRgA/kREVHYNIc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=L+zGTjzZfnfZnbhFxk7VymKpL+cuZf5XsvO/iNht4A0+K7bSnXLUKGJXPxkVscCNn
	 C7UaxBUZU5fb7TGQQk2zlnOpExX1P+HogzO0g8u3YSJIAcLMCFXf1WYr4yefGbqNEm
	 +LbscxZ+bVh3KiPyH0vzxSS9A/wogEVPkgUl6QIJ7r8ayT482PE0U9XFYk+USN0wbr
	 qtotrwkUTuStT2yIMd9RCjh7Yh2Ul6efajiITlNaWSGaaxPuYFE0qJdzE/5GVUgYRV
	 pqDI28rTP2WXKF7W9psNu4AUxZzjw/myx6Goz+nTBDP9wkDJQa4wkindv+EJxIR3cJ
	 8jvIT3G5EDWlQ==
Content-Type: multipart/mixed; boundary="===============1814057301451628224=="
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <965519c1d6e765ce216b16bcc8831a5ec17e8b1185968f3291670a2cc75032e3@mail.kernel.org>
In-Reply-To: <20260226085624.1909682-4-alan.maguire@oracle.com>
References: <20260226085624.1909682-4-alan.maguire@oracle.com>
Subject: Re: [PATCH v9 bpf-next 03/10] libbpf: use layout to compute an unknown kind size
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,andrii@kernel.org,ast@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,qmo@kernel.org,ihor.solodrai@linux.dev,mykyta.yatsenko5@gmail.com,dwarves@vger.kernel.org,bpf@vger.kernel.org,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 26 Feb 2026 10:05:42 +0000 (UTC)

--===============1814057301451628224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -355,7 +355,36 @@ static int btf_parse_layout_sec(struct btf *btf)
>  	return 0;
>  }
>
> +/* for unknown kinds, consult kind layout. */
> +static int btf_type_size_unknown(const struct btf *btf, const struct btf_type *t)
> +{
> +	__u32 layout_kinds = btf->hdr.layout_len / sizeof(struct btf_layout);
> +	int size = sizeof(struct btf_type);
> +	struct btf_layout *l = btf->layout;
> +	__u16 vlen = btf_vlen(t);
> +	__u32 kind = btf_kind(t);

[ ... ]

> +	size += l[kind].info_sz;
> +	size += vlen * l[kind].elem_sz;
> +
> +	return size;
> +}

In the v8 review, Andrii suggested simplifying this to a single return
statement without the intermediate size variable:

    return sizeof(struct btf_type) + l[kind].info_sz + vlen * l[kind].elem_sz;

The size variable is initialized at declaration and only modified at
the very end, so it could be dropped.  Was this intentionally kept,
or just missed during the v9 update?

https://lore.kernel.org/bpf/CAEf4BzbsLMgRuJz0PGDojZG32G0GQcSKnt4F9CVVROLPXHY+TA@mail.gmail.com/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22436234361

AI-authorship-score: low
AI-authorship-explanation: Code follows established kernel BTF patterns with domain-specific naming, and the author has an extensive lore patch history for this subsystem.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Unaddressed style suggestion from libbpf maintainer to simplify size computation to a single return statement.

--===============1814057301451628224==--
