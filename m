Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60A23DA7E7;
	Fri, 27 Feb 2026 10:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772189526; cv=none; b=sfltIPOgX17pIqSyqxIs7PIH2ZAzPM8YpK6rSz7Ic+GxHbC03xgYRsCmVqA8Y2wsxQOI7erVDPdYGDlLD4kertck2WS5kLj1jO+W2tbz9MG74/9l7QkG2WFI7jIwyfE5gNtW0JXVfiG4gmr8sLtmDvASqFz6ilmYgWhIn14mnKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772189526; c=relaxed/simple;
	bh=+i1Bl/u3LxX7qoFCTpLr2QtQ+gWzwaZAemiMIigdwgk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WT9ZTCHzfDrAzA6jKjl2LcRTPWm0jWCyHIqCXjwl+DSqjRyMk1qXzdLoqRU8/j51MQ6Dz8zX8XnrZqYsVu5Ptif51jaJh2tZT4GufuOH53hGBADeUfz+Z0SkH1F1bDNSIFjnEyer3PdojD5fbCjJgAcwjqxkXHnrUV6L8SbSn8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EB9+IQjy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EB9+IQjy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82799C116C6;
	Fri, 27 Feb 2026 10:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772189526;
	bh=+i1Bl/u3LxX7qoFCTpLr2QtQ+gWzwaZAemiMIigdwgk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=EB9+IQjyRSIYeyvvBjgpmUoiYAXBzFfHiF3YkSDFKNS5pGDO1I82B7UaAEzOjNP5M
	 Tdl/GP/G9vmrZa1b+1zEvdJUHT9G0MWVd84NaIOWoKl4HchgIhIagCfPnb1XMoIr4o
	 2glT2nB/Wg9ltxqcHIU2+jC/7eOTuQ7ateKIz+49+8IEbhJ9lyus12FgcTxNB3JC1R
	 fJjeDZgOg8XSveJyuJROTKZH53XDdgl6eK+VNXxCtyXih2bi37TB/ksdecYAdrEtI/
	 NcFT6pTYWcYJUUXeaZYAW4OSLpIVKZn4IZ/ns2k9+XX1o+n6DfV0lhOmBf/fV4VKR7
	 t2JgurOgEjmWQ==
Content-Type: multipart/mixed; boundary="===============5334910527371013985=="
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ee7305416a59102140d18d5d7f544061d8d82658dda98768c209905d5db222e6@mail.kernel.org>
In-Reply-To: <20260227100426.2585191-10-alan.maguire@oracle.com>
References: <20260227100426.2585191-10-alan.maguire@oracle.com>
Subject: Re: [PATCH v10 bpf-next 09/10] bpftool: Update doc to describe bpftool btf dump .. format metadata
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,andrii@kernel.org,ast@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,qmo@kernel.org,ihor.solodrai@linux.dev,mykyta.yatsenko5@gmail.com,dwarves@vger.kernel.org,bpf@vger.kernel.org,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 27 Feb 2026 10:52:04 +0000 (UTC)

--===============5334910527371013985==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> --- a/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-btf.rst

[ ... ]

> @@ -267,3 +268,26 @@
>    [104861] FUNC 'smbus_do_alert' type_id=84827 linkage=static
> +
> +Display BTF metadata from file vmlinux
> +
> +**# bpftool btf dump file vmlinux format meta**
> +
> +::
> +
> +  size 5161076
> +  magic 0xeb9f
> +  version 1
> +  flags 0x1
> +  hdr_len 40
> +  type_len 3036368
> +  type_off 0
> +  str_len 2124588
> +  str_off 3036368
> +  layout_len 80
> +  layout_off 5160956
> +  kind 0    UNKNOWN    info_sz 0    elem_sz 0   flags 0
> +  kind 1    INT        info_sz 0    elem_sz 0   flags 0
> +  kind 2    PTR        info_sz 0    elem_sz 0   flags 0
> +  kind 3    ARRAY      info_sz 0    elem_sz 0   flags 0
> +  kind 4    STRUCT     info_sz 0    elem_sz 0   flags 0

Does this example reflect actual tool output? A few values appear
inconsistent with the implementation in dump_btf_meta() and the
layout encoding in libbpf:

The kind layout values are all zeros, but the layouts[] array in
tools/lib/bpf/btf.c populates non-zero values for known kinds:

  [BTF_KIND_INT]    = { sizeof(__u32),            0, 0 },  /* info_sz=4  */
  [BTF_KIND_ARRAY]  = { sizeof(struct btf_array), 0, 0 },  /* info_sz=12 */
  [BTF_KIND_STRUCT] = { 0, sizeof(struct btf_member), 0 }, /* elem_sz=12 */

The implementation commit (62f2c6445a46) also shows the correct
non-zero values in its own example:

  kind 1    INT        info_sz 4    elem_sz 0    flags 0
  kind 3    ARRAY      info_sz 12   elem_sz 0    flags 0
  kind 4    STRUCT     info_sz 0    elem_sz 12   flags 0

Would it be worth regenerating this example from an actual
bpftool run to make sure the values match?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22482435858

AI-authorship-score: low
AI-authorship-explanation: Straightforward RST documentation update with iterative human review history spanning 2023-2026, typical of a developer documenting their own feature.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Documentation example output does not match actual tool behavior; kind layout values are all zeros when the implementation produces non-zero values for known kinds.

--===============5334910527371013985==--
