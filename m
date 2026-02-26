Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D7838F93E;
	Thu, 26 Feb 2026 10:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772100352; cv=none; b=nOwp+pgKhy7JkS8LK41fwo/h9FvIDOG2GYAbCk5HLsxjumAxh6iXVP8gNI2WIeWaQiB50lVk3LHBhtJ2XrbenCuWmi1sVXqSFma05gT5K70J8mgyZReNXZBqi7zdru3XAfHjB6NuOJrMb7GKXepldGb8PplY4ZyXW576b3t9bfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772100352; c=relaxed/simple;
	bh=D0qJuSpU0Gty9tLbS/qN9Ky8StV+HXREw5JF+V/RAfI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=G1bgKJwRTqvvpn2NpA0lIDCYUjngaqS6OGI5tjqaHDm+Eb/TY+nFj4ipPjTxXE57XzHvS4BirTPqanEMO3kH7XH3Gb1Y6FowghF6Qf//+s6tojPipJwCZLSc8UrhzvMdHS5hEebVRzBONmE6lEdLnh6KC97/8QDoSf7Hvwn6zjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGgpiyWI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGgpiyWI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622C2C19422;
	Thu, 26 Feb 2026 10:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772100352;
	bh=D0qJuSpU0Gty9tLbS/qN9Ky8StV+HXREw5JF+V/RAfI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=gGgpiyWIVaBig6oFwZFSuYeXhBO3aPHdmbKrTW/PUnOMewfyuqocQWwWS1ntroKyN
	 C8I50OwbLRm1PiwmdwPNDuM9TBYWlW4uWeAHDwo+K7qkQgYCfyKX3j8bVBwYYgIJ73
	 XnzxS+9TkSZ2TI9i3YPTxJfWxxAF0H8u0EE5EF3iSAfl2bg1ntPaQWdTbV+0qFM65B
	 M9y+ud8CEZDsGSVzQbZzuoXtYkZ3Gj9a7Gek1zfAt9ipfvCJglf3McezGr5nzTgy44
	 Ju87dM5lhYFbTTWTw8FM1NUSFoGqbf8O0lt1m8LvomxVM81yN9alaAGaQw39CA1zTP
	 FzdYdY3HrK3eQ==
Content-Type: multipart/mixed; boundary="===============0829458916520923019=="
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <dc1d9fb29ac2eba86b21fb85ad1bac9d096f0e9680ef87b42a86200120b5e7a1@mail.kernel.org>
In-Reply-To: <20260226085624.1909682-7-alan.maguire@oracle.com>
References: <20260226085624.1909682-7-alan.maguire@oracle.com>
Subject: Re: [PATCH v9 bpf-next 06/10] btf: support kernel parsing of BTF with layout info
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,andrii@kernel.org,ast@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,qmo@kernel.org,ihor.solodrai@linux.dev,mykyta.yatsenko5@gmail.com,dwarves@vger.kernel.org,bpf@vger.kernel.org,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 26 Feb 2026 10:05:50 +0000 (UTC)

--===============0829458916520923019==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c

[ ... ]

> @@ -5327,23 +5328,36 @@ static s32 btf_check_meta(struct btf_verifier_env *env,
>  		return -EINVAL;
>  	}
>
> +	if (!btf_name_offset_valid(env->btf, t->name_off)) {
> +		btf_verifier_log(env, "[%u] Invalid name_offset:%u",
> +				 env->log_type_id, t->name_off);
> +		return -EINVAL;
> +	}
> +
> +	if (BTF_INFO_KIND(t->info) == BTF_KIND_UNKN) {
>  		btf_verifier_log(env, "[%u] Invalid kind:%u",
>  				 env->log_type_id, BTF_INFO_KIND(t->info));
>  		return -EINVAL;
>  	}
>
> +	if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX && env->btf->layout &&
> +	    ((BTF_INFO_KIND(t->info) + 1) * sizeof(struct btf_layout)) <
> +	     env->btf->hdr.layout_len) {
                                       ^

Should this be <= instead of < ?  If the layout section has exactly
N entries, layout_len is N * sizeof(struct btf_layout).  For the
last covered kind (K = N - 1), this computes:

    (K + 1) * sizeof(struct btf_layout) == layout_len

With < that evaluates to false, so the last kind covered by the
layout section falls through to the else branch and gets logged as
"Invalid kind" instead of "unknown but required kind".

The libbpf equivalent in btf_type_size_unknown() uses:

    __u32 layout_kinds = btf->hdr.layout_len / sizeof(struct btf_layout);
    if (!l || kind >= layout_kinds) {

which accepts the last entry.  Using <= here would match that
behavior.

> +		btf_verifier_log(env, "[%u] unknown but required kind %u",
> +				 env->log_type_id,
> +				 BTF_INFO_KIND(t->info));
>  		return -EINVAL;
> +	} else {
> +		if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX) {
> +			btf_verifier_log(env, "[%u] Invalid kind:%u",
> +					 env->log_type_id, BTF_INFO_KIND(t->info));
> +			return -EINVAL;
> +		}
> +		var_meta_size = btf_type_ops(t)->check_meta(env, t, meta_left);
> +		if (var_meta_size < 0)
> +			return var_meta_size;
>  	}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22436234361

AI-authorship-score: low
AI-authorship-explanation: Multi-year revision history with detailed reviewer interactions, idiomatic kernel C, and an off-by-one error typical of manual arithmetic translation are inconsistent with AI-generated code.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Off-by-one in layout bounds check produces wrong verifier log message but does not change functional behavior since both paths return -EINVAL.

--===============0829458916520923019==--
