Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDD636C584;
	Mon,  2 Mar 2026 12:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772453921; cv=none; b=UbHRLUz4rk+0HUP9y1kCGuIwGEGYAeEdk6o7ULe9G3XOELuxgdXurKyG1E1H2zi4HnOm1rBxHZsmWlFTHXm680Dcm6FyhCclNa4tQWFzzqZGKEOhPpmOR+k1JYQzkot6qfE6Z/wLh0+7Fxnj+iKsDF9CGh2hwH5cqSIzC2rL6F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772453921; c=relaxed/simple;
	bh=asnzSp/+QW3JDPk3mQV4491FnH0+FXmumS+0zuGHkP4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=T8gOUSAbZQIGYDvMDABPjA7iowCgiS+sXn1yBH0UE4/65YIMgv5/yjKnlIkRqDrCAl7XA7QdGhPtJ5XKV92OSnm0pKN+YYMUsGCcM6+atGrBQSU7Ey3tRfK009JHIcyhktSdRtl7gWniGkA0og8Q3gEkS/Ive9wkyKt64Pe2VUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgBF3KvB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgBF3KvB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01A5C19423;
	Mon,  2 Mar 2026 12:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772453921;
	bh=asnzSp/+QW3JDPk3mQV4491FnH0+FXmumS+0zuGHkP4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=PgBF3KvBWnItsKOE1A+a3fd0VIg04DY/cwE9omq6plFghukNzD49+FHNF3UvPHGe2
	 ygKGdVFkDuW+oHKs4H2Uc0ychoXWg0S126g4ygTGceGRC1UEUTI4EHC0NGddUFbWFX
	 htplSPkbSxiIuWGufkK6g61Xh3U5eNxZB6i4FrNS/L2XYgULyMtONj2DAgjgUzC4RU
	 mFU/H5dlb7HETHeajjTYCsQP8KqMqj6IHxKe7/6kwo+rQng0Sxv9lQMzTzIcqTMd86
	 F89N8A+swtXLVJ/+GQUzAzZioKP5bSUtP7OI5QbIv7fWRncywPjxb9xgPrE8O9Nts3
	 b7e4HICPmeHvw==
Content-Type: multipart/mixed; boundary="===============1072935580077873128=="
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <42a9f041ac450b0be216d4094dd7c3ca1ca63246db9e54bc4a39a6dbedbd7612@mail.kernel.org>
In-Reply-To: <20260302114059.3697879-7-alan.maguire@oracle.com>
References: <20260302114059.3697879-7-alan.maguire@oracle.com>
Subject: Re: [PATCH v11 bpf-next 6/8] btf: support kernel parsing of BTF with layout info
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,andrii@kernel.org,ast@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,qmo@kernel.org,ihor.solodrai@linux.dev,mykyta.yatsenko5@gmail.com,dwarves@vger.kernel.org,bpf@vger.kernel.org,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  2 Mar 2026 12:18:40 +0000 (UTC)

--===============1072935580077873128==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 4872d2a6c42d..bda363a2592e 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c

[ ... ]

> +static int btf_parse_layout_sec(struct btf_verifier_env *env)
> +{
> +	const struct btf_header *hdr = &env->btf->hdr;
> +	struct btf *btf = env->btf;
> +	void *start, *end;
> +
> +	if (hdr->hdr_len < sizeof(struct btf_header) ||
> +	    hdr->layout_len == 0)
> +		return 0;
> +
> +	/* Layout section must align to 4 bytes */
> +	if (hdr->layout_off & (sizeof(u32) - 1)) {
> +		btf_verifier_log(env, "Unaligned layout_off");
> +		return -EINVAL;
> +	}
> +	start = btf->nohdr_data + hdr->layout_off;
> +	end = start + hdr->layout_len;
> +
> +	if (hdr->layout_len % sizeof(struct btf_layout) != 0) {
> +		btf_verifier_log(env, "layout_len is not multiple of %zu",
> +				 sizeof(struct btf_layout));
> +		return -EINVAL;
> +	}
> +	if (hdr->layout_len < sizeof(struct btf_layout)) {
> +		btf_verifier_log(env, "Layout section is too small");
> +		return -EINVAL;
> +	}

Is this "too small" check reachable? At this point layout_len is
non-zero (the == 0 case returned above) and is a multiple of
sizeof(struct btf_layout) which is 4.  A positive multiple of 4 is
always >= 4, so this branch can never execute.

If the modulo check above it were removed or reordered in the
future, this would become live again, but as written it appears
to be dead code.

> +	if (end > btf->data + btf->data_size) {
> +		btf_verifier_log(env, "Layout section is too big");
> +		return -EINVAL;
> +	}
> +	btf->layout = start;
> +
> +	return 0;
> +}

[ ... ]

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22574705927

AI-authorship-score: low
AI-authorship-explanation: Part of a v10 series with 3 years of mailing list discussion, demonstrates deep BTF expertise, and the dead code is a characteristically human oversight from iteratively addressing review feedback.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Dead validation code in btf_parse_layout_sec that can never execute due to a preceding modulo check; no functional impact since the unreachable branch would only reject invalid input that is already rejected.

--===============1072935580077873128==--
