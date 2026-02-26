Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77BF394496;
	Thu, 26 Feb 2026 10:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772100357; cv=none; b=KTPKcGhfYaqYb5iWY8J6Lk7DZK8d7xwAM+Zef2HlZ8Y9IwUZ+M0opvjTKx3WCSctqk7DSkuBVWN9iR/0Ng9igkVMriAi1u1GH3kRhCYtueLGbH6vlICgp7HX7nDTCbnjx955/GS6pS37BetA4Qn5Md5Y3EAthnWRsPwiD/iklTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772100357; c=relaxed/simple;
	bh=+VTGIvfnV0UjS2fYd3+wF+qTS94i6mZEr6QVkORUYZI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=e86mqtgDs1cCUCki48r1hSix1EBeGydlog4zUh1rpH2R9k/WSIBc/lW/C2U8DI8HX7QhtQMDFbp7RFgkSwupeHPfFMKVSiZ0iaJWrv5v5K4BIN3UoOKk2eXOnn2s6Veb0wqGmlrZDSZxplSosGwLdVQt/3fosDj3KSTwij+ryF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PL3y36kk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PL3y36kk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5EC3C19422;
	Thu, 26 Feb 2026 10:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772100356;
	bh=+VTGIvfnV0UjS2fYd3+wF+qTS94i6mZEr6QVkORUYZI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=PL3y36kkjkNMOgtOBhgDLwzVZBHeHa0/P8czUP70mmNXDr0tScVZlfMBCudDkSpO0
	 F1recgRV9s4pk5B/S5RBk4Ko9PqCOvSW+VdY0B8Mh92WuEIig7y2yjuzsfwmbuYS7y
	 1GOv4eP/ds7qBMnrYzfTYhh3YbUJuO8yr4sVFatNwR2zyK/QHxUYZ6wOa2BTOZ/a9k
	 ekB4wEfb+8Tqryf4GIyU99EdXtZ9XzACKXq7qnILpReW/er+1ShZn6LC+PznTh5TpT
	 1u04DOF7ukPJT1ylwniV+Kh9Oja8D1EJpA1xc8RAb2OIHge1rf1un9kjnXk50B5iJD
	 MEBrKvfehWgfw==
Content-Type: multipart/mixed; boundary="===============8979527142850515311=="
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6c47d067a977a179a9c4e888efc97ba8521749688c591e1da34a2b33d1abf343@mail.kernel.org>
In-Reply-To: <20260226085624.1909682-5-alan.maguire@oracle.com>
References: <20260226085624.1909682-5-alan.maguire@oracle.com>
Subject: Re: [PATCH v9 bpf-next 04/10] libbpf: Add layout encoding support
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,andrii@kernel.org,ast@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,qmo@kernel.org,ihor.solodrai@linux.dev,mykyta.yatsenko5@gmail.com,dwarves@vger.kernel.org,bpf@vger.kernel.org,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 26 Feb 2026 10:05:53 +0000 (UTC)

--===============8979527142850515311==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Layout information is maintained in btf.c in the layouts[] array;
> when BTF is created with the add_layout option in represents the
> current view of supported BTF kinds.

There is a typo in the commit message: "in represents" should be
"it represents".

> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index b30008c267c0..a1f8deca2603 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h

[ ... ]

> +struct btf_new_opts {
> +	size_t sz;
> +	struct btf *base_btf;	/* optional base BTF */
> +	bool add_layout;	/* add BTF layout information */
> +	size_t:0;
> +};

In v8, Andrii Nakryiko asked why this is an option rather than
always emitting layout unconditionally:

https://lore.kernel.org/bpf/CAEf4BzZuFB6zvMjdqKDumUAT4vr5MeA3LBqTh5xRZmAQ5KC10g@mail.gmail.com/

Was there a reason the suggestion to always emit layout and
sanitize it for older kernels was not followed?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22436234361

AI-authorship-score: low
AI-authorship-explanation: Long lore history (v3-v9 spanning 2023-2026), iterative reviewer feedback, human-style typo in commit message, and consistent with author's established BPF contributions.
issues-found: 2
issue-severity-score: low
issue-severity-explanation: A commit message typo and an unaddressed maintainer design request about always emitting layout rather than making it optional; no functional bugs found.

--===============8979527142850515311==--
