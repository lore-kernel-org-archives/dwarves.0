Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4822E39A7EE;
	Fri, 27 Feb 2026 10:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772189533; cv=none; b=dRO/ZquePSI8Y7Fb9nb0SrY0Q2iZuVejEZm3Tdt21OvFkHWLd4Gu5H+mL0lzGoQwFBO0ErufCun0z7ALLYQixWMk2g68UeWiSOWqKAxYss8KCvbmZEQ5etAz1pI/hmpfMUi+RUtxbISZ1ZQJXij7PRy1/L4tPX6T2BN5WfyatZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772189533; c=relaxed/simple;
	bh=69kcLd6bI2f1P1yBOcLJ81o54JvYl/e5cNy7Y7RWljI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=X9zCwG8oR2HjMNttOG7EIrhYvYWn4K+BQEzVo+K4hCm1KDJo4rDOKwc0a51xbZPHPUQ8BtlvRD1Y8MdJSTxgqdmaL6hm/CL6yl/Z3degpoHwm9Cu9LhIwLkZ3/PXVJhmiy3dOUcQKbfQy1JtyoVrtMwdlkgP4geAMOYjEnZh4Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzZ/A0R1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzZ/A0R1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E63C19425;
	Fri, 27 Feb 2026 10:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772189533;
	bh=69kcLd6bI2f1P1yBOcLJ81o54JvYl/e5cNy7Y7RWljI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=QzZ/A0R1zneg/eMCKpj6IvZjh8qUSEl2f7+QRI0od8JscitX+uC21a7HBuxDbls+f
	 RuUHxAzl4u0b1ifir+NBL59RNe1Wo8Yvu/5zw2TyI69baC1pNTlsHxfhqrynjXSddH
	 nLiV6MASCnvtk4nBFnZA2nsZJN9yiQQVaC3eGwl7++/sOGInnKR44Pqc5WDjVWsXmp
	 TUEC9EiaE7IxIvXJoCnB2lPEB42L38RWDdGOcZ4udyorgzIyFwVEWUjL766rsql6S5
	 MJMdEwb8pelXIFeNeT6MWVZYJS0BnbZSrG42Ec17jwcFR4yuTxW2xjbelTQQQrFFzD
	 O/pZ3bctKF/bg==
Content-Type: multipart/mixed; boundary="===============6909873855672191391=="
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0efadf2d602744395c950d0540c14c43d7c80c4974faecfb07b43e8186370510@mail.kernel.org>
In-Reply-To: <20260227100426.2585191-7-alan.maguire@oracle.com>
References: <20260227100426.2585191-7-alan.maguire@oracle.com>
Subject: Re: [PATCH v10 bpf-next 06/10] btf: support kernel parsing of BTF with layout info
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,andrii@kernel.org,ast@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,qmo@kernel.org,ihor.solodrai@linux.dev,mykyta.yatsenko5@gmail.com,dwarves@vger.kernel.org,bpf@vger.kernel.org,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 27 Feb 2026 10:52:11 +0000 (UTC)

--===============6909873855672191391==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 4872d2a6c42d..e5a9774907fe 100644
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
> +	/* Llayout section must align to 4 bytes */
> +	if (hdr->layout_off & (sizeof(u32) - 1)) {
> +		btf_verifier_log(env, "Unaligned layout_off");
> +		return -EINVAL;
> +	}
> +	start = btf->nohdr_data + hdr->layout_off;
> +	end = start + hdr->layout_len;
> +
> +	if (hdr->layout_len < sizeof(struct btf_layout)) {
> +		btf_verifier_log(env, "Layout section is too small");
> +		return -EINVAL;
> +	}

Should layout_len also be checked for alignment to
sizeof(struct btf_layout)?  The libbpf counterpart in
btf_parse_layout_sec() validates this:

    if (btf->hdr.layout_len % sizeof(struct btf_layout) != 0) {
        pr_debug("Invalid BTF kind layout section\n");
        return -EINVAL;
    }

Without this check the kernel accepts a layout section with a
partial trailing entry (e.g. layout_len = 5 passes the >= 4
check here).  The commit message notes "the kernel must be
strict in what it accepts," so matching the libbpf validation
seems appropriate.

> +	if (end > btf->data + btf->data_size) {
> +		btf_verifier_log(env, "Layout section is too big");
> +		return -EINVAL;
> +	}
> +	btf->layout = start;
> +
> +	return 0;
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22482435858

AI-authorship-score: low
AI-authorship-explanation: Part of a v10 series with extensive mailing list discussion, demonstrates deep kernel BTF expertise, and the Llayout typo is a characteristically human error.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Missing layout_len modular validation allows the kernel to accept malformed BTF that libbpf rejects, but no kernel code currently iterates over layout entries so the impact is limited to inconsistent validation.

--===============6909873855672191391==--
