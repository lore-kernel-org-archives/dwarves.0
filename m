Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF25136C584;
	Mon,  2 Mar 2026 12:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772453919; cv=none; b=hQqzUrW2HfXh+fk+HHwVw6sU92RWkyfjsAyjqM4HmxIj7UR+lCV4Q25qAi/3afpceo7tAqV/bsAs2SpjAllrfUFPnuFEN6c5sTgQKtt8spGQ+bhHpujPyjuhxdyNVdCne9pINyZGv57z7olhH6ndh+fvwIGqACbMNg6pDyF9C+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772453919; c=relaxed/simple;
	bh=QkyEZn2Qrkukixn22LV+3XfOmPawNV9V2t/C50A+5rc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=YP+QLvMXzvokqW1YsZ4Yf46fJMB+1lx21aYDxFjcfqv3+um4tdcVxqRfoY6AD0V7hgddFGO+OcNAIxduYjpq0D6dg6s5pouHQW6LfcSr5k9rbHaoZ+A8QHunnyJpvIVdtpB0XxPh2yOOuwJzdrnGgMMqNhVX26XKkWOuW7jaW+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3Q3JYm5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3Q3JYm5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23FD1C19423;
	Mon,  2 Mar 2026 12:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772453919;
	bh=QkyEZn2Qrkukixn22LV+3XfOmPawNV9V2t/C50A+5rc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=a3Q3JYm5+p3gEKGKGieFtzW/fYi3UqwznrRdh3tmwXQ6W5eVWo+KqQDZ3wj4Qeamb
	 DMNCSYAk+tYApBcauVzS2PAS6qifG2XRTQ6cBlpzAW9XNM83l/ig3Kkb2LmrEZ2WYE
	 5YGT+Bo7Jk5Oh1h4higOrlkNBMYaqumPZOh7BkUTHMKym469xG6C6sKtxAKH77cSgB
	 AbTK4B5r0TP8aJf6XtrHbXD07MkDDhkSl3p9jfIGSsFALKsmgzr6ygNKZ9CvQxPZ4s
	 GTQpGKC6GIK80HlbAAP2NxcusRGYljymlCzinUtS/inqT2Fd5U0Ad/L2Nvu7hEDgj/
	 u7bXA08eQ+6Rw==
Content-Type: multipart/mixed; boundary="===============8870110828349857822=="
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <81e5bdca3b0c4eb5703b200781e30fa14ac256ba8042bb27dac98d28e743b7de@mail.kernel.org>
In-Reply-To: <20260302114059.3697879-5-alan.maguire@oracle.com>
References: <20260302114059.3697879-5-alan.maguire@oracle.com>
Subject: Re: [PATCH v11 bpf-next 4/8] libbpf: Add layout encoding support
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,andrii@kernel.org,ast@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,qmo@kernel.org,ihor.solodrai@linux.dev,mykyta.yatsenko5@gmail.com,dwarves@vger.kernel.org,bpf@vger.kernel.org,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  2 Mar 2026 12:18:39 +0000 (UTC)

--===============8870110828349857822==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 9f4d1bd73b4d..e87003711543 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c

[ ... ]

> @@ -1186,12 +1229,26 @@ static struct btf *btf_new_empty(struct btf *base_btf)
>
>  struct btf *btf__new_empty(void)
>  {
> -	return libbpf_ptr(btf_new_empty(NULL));
> +	LIBBPF_OPTS(btf_new_opts, opts);
> +
> +	return libbpf_ptr(btf_new_empty(&opts));
>  }

This isn't a bug, but Eduard Zingerman noted in v8 review that
btf_new_empty(NULL) should work fine because OPTS_GET already
handles NULL opts by returning default values. The LIBBPF_OPTS
wrapper could be simplified back to just passing NULL here.

https://lore.kernel.org/bpf/1456370aa292410bdda4bff85bead8e091675f4c.camel@gmail.com/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22574705927

AI-authorship-score: low
AI-authorship-explanation: Extensive 11-version revision history with iterative reviewer feedback responses and domain-specific BTF implementation choices consistent with experienced kernel developer.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Unaddressed minor style nit from libbpf maintainer Eduard Zingerman about simplifying btf__new_empty() to pass NULL instead of LIBBPF_OPTS wrapper.

--===============8870110828349857822==--
