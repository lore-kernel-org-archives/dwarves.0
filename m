Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B983F2E2852;
	Tue,  3 Mar 2026 19:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772565327; cv=none; b=Xw4Bvcai1GYF5Gb7SJsDhifaNpohseOYFg0QpqOKUpHFc8cxUuXfcwat17MU08MKau48acEJT6uZO6qOkCWQ09iYVl1Z4qaWA7YtfkmeY8HEfTRbh0MIJTlps1fRihhhk2Ii62WeiqyUV1/hk5jLorVz8QUpDl7TjcY7d6DS0As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772565327; c=relaxed/simple;
	bh=8+T3xdiQptMYEcaeS4p4OKnvS5XK55of7k2wnkVPxEk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=QyH0lMuZVqZmj/jBkZFbxJ8zoRUkdSpW5Ui2jR4k02dHFgsSrFZztFjfsiMbPJ11+vMCpqFdYwS9WH0N/6E5u/v2RlGl+woZ19g7RLIE6Rx9fFTaD/O8oWS/bld3fEpKX+FoKcd+08VME51i7VxrwNodCJH9Qu80utX/qQL5LY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axx8AMjf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axx8AMjf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E37C116C6;
	Tue,  3 Mar 2026 19:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772565327;
	bh=8+T3xdiQptMYEcaeS4p4OKnvS5XK55of7k2wnkVPxEk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=axx8AMjfW+96ZwmIa4a9BoJHG5mM8lnem2bUGoYM4w7PRIv0GtGuxe3ApD/95PFRM
	 PopmqoYSwb/kXPDlNSYaGS2oWENQ/sb0RBjjtHfX/r8VNCe36j45GDkeJvd9vPhqdm
	 lhbrkndssj2U/sc9DMK2i8JOKExrMd1YfxQL4MUsKz4V2ewGgQTF5i2+pBibKFPLcH
	 bjlgZGIN4j4AD8ZeYIfJG/keVI07nmpHe52Kbsq+VLyQpGiy6bj9MewqFn2oJD3FIE
	 ZNUo6wBNratNaMxvf4ggVLJhWeNwniMHSZviNGNb13Z6VEjF8d6P0Wj+ExUa+knZJK
	 vLxW7Z/F+Z1wQ==
Content-Type: multipart/mixed; boundary="===============9213348926159975098=="
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a1a841b4bd59afe171bf85b06e723705403e1092c5c17a0466feb7114d189296@mail.kernel.org>
In-Reply-To: <20260303182003.117483-7-alan.maguire@oracle.com>
References: <20260303182003.117483-7-alan.maguire@oracle.com>
Subject: Re: [PATCH v12 bpf-next 6/8] btf: support kernel parsing of BTF with layout info
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,andrii@kernel.org,ast@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,qmo@kernel.org,ihor.solodrai@linux.dev,mykyta.yatsenko5@gmail.com,dwarves@vger.kernel.org,bpf@vger.kernel.org,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  3 Mar 2026 19:15:26 +0000 (UTC)

--===============9213348926159975098==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
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

When one of these validation errors fires, btf_verifier_log_hdr()
has already printed the header dump.  That function currently logs
type_off, type_len, str_off, and str_len, but not layout_off or
layout_len:

kernel/bpf/btf.c:btf_verifier_log_hdr() {
    ...
    __btf_verifier_log(log, "type_off: %u\n", hdr->type_off);
    __btf_verifier_log(log, "type_len: %u\n", hdr->type_len);
    __btf_verifier_log(log, "str_off: %u\n", hdr->str_off);
    __btf_verifier_log(log, "str_len: %u\n", hdr->str_len);
    __btf_verifier_log(log, "btf_total_size: %u\n", btf_data_size);
}

Should layout_off and layout_len be added to the header log, at
least when hdr_len >= sizeof(struct btf_header)?  Without them a
user who hits "Unaligned layout_off" or "Layout section is too
small" cannot see the actual values in the verifier output.

> +	start = btf->nohdr_data + hdr->layout_off;
> +	end = start + hdr->layout_len;
> +
> +	if (hdr->layout_len < sizeof(struct btf_layout)) {
> +		btf_verifier_log(env, "Layout section is too small");
> +		return -EINVAL;
> +	}
> +	if (hdr->layout_len % sizeof(struct btf_layout) != 0) {
> +		btf_verifier_log(env, "layout_len is not multiple of %zu",
> +				 sizeof(struct btf_layout));
> +		return -EINVAL;
> +	}
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

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22637324186
--===============9213348926159975098==--
