Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170D23A1E76;
	Thu, 26 Feb 2026 10:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772100364; cv=none; b=p+/GtgHGBxJXb5E3nDushWZ512xjV3F7umt5uaKIkwyiCVQ/aA7B0b4Jnh6MOqRhM17/Gjq5/K8ODcMW5Q6UttqJRLKXeo5ZD/+XbQ8NiNRBLOHo634gkPNeIcW8N5pW76L3XXQLLewAv0VH2jVt+zxnAR+bkaqQ8BQvIMw2D6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772100364; c=relaxed/simple;
	bh=bWq7S11Pcslrpv4TS8TucLgiZaXPTgWla2zTDpm0U5o=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=r0vZ2/wurJBJOH2x7GYC3MECM2HBcwUmVL/20gsg+1MOchpearDfaquwGdTYoUBiqQSxi/cxHuKAg/wCsy49Nu4RHboiN3mKQ4ZdBBCzcmdt8d7F0DgrGqxpLTKWvit0DDp1+UssU81W+UZE1/+uQxgAMGYq66JuwKY2B3vom7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fStFYkS/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fStFYkS/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E4BC19423;
	Thu, 26 Feb 2026 10:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772100363;
	bh=bWq7S11Pcslrpv4TS8TucLgiZaXPTgWla2zTDpm0U5o=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=fStFYkS/RmpOqqcxA5C8Vano6hXGxRNbgH6517WOi5HB+BapqTlZGu9qNuEkljd05
	 OkSg0x+2+iediVyvpWzQouzv7x1DcsZDNfChYUcjIx0m49wIT7a6QCJ1WmcHrF1aMl
	 E8fjXIwhqMlkKOvM6HrT5UK/aCB5Ev6p28w5xqw7AzDiwOmlXGhbEea8xxaBzC4cfE
	 xGJLuV2woyJyFKcOPSYpyke4B8Uqf/i2P65V9MHmCotPAHGI1J6e/9+uo4I/kfFtKG
	 zPZi63O6cXnUYc3gJoJExmIrhINwjkenqdCHBmXBQFxBT8QNdSauqlU9ikewy51xsg
	 M2fFM01miacEg==
Content-Type: multipart/mixed; boundary="===============9188822609562961542=="
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <53fd1afa60a674667754fb1d92f3385d695c7db4a2ff2cb92e73ab9390d7a78b@mail.kernel.org>
In-Reply-To: <20260226085624.1909682-2-alan.maguire@oracle.com>
References: <20260226085624.1909682-2-alan.maguire@oracle.com>
Subject: Re: [PATCH v9 bpf-next 01/10] btf: add BTF kind layout encoding to UAPI
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,andrii@kernel.org,ast@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,qmo@kernel.org,ihor.solodrai@linux.dev,mykyta.yatsenko5@gmail.com,dwarves@vger.kernel.org,bpf@vger.kernel.org,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 26 Feb 2026 10:06:01 +0000 (UTC)

--===============9188822609562961542==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux/btf.h
> index 266d4ffa6c07..638615ebddc2 100644
> --- a/tools/include/uapi/linux/btf.h
> +++ b/tools/include/uapi/linux/btf.h

[ ... struct btf_layout addition ... ]

> @@ -19,6 +29,8 @@ struct btf_header {
>  	__u32	type_len;	/* length of type section	*/
>  	__u32	str_off;	/* offset of string section	*/
>  	__u32	str_len;	/* length of string section	*/
> +	__u32	layout_off;	/* offset of layout section	*/
> +	__u32	layout_len;	/* length of layout section	*/
>  };

Adding layout_off and layout_len to struct btf_header changes
sizeof(struct btf_header) from 24 to 32 bytes.  Existing libbpf
code in tools/lib/bpf/btf.c uses sizeof(struct btf_header) in two
checks inside btf_parse_hdr() that will regress at this point in the
series:

The minimum size check:

    if (btf->raw_size < sizeof(struct btf_header)) {

now requires 32 bytes instead of 24, so won't this reject valid
BTF blobs produced by older toolchains whose headers are only 24
bytes?

The cross-endian strict equality check:

    if (bswap_32(hdr->hdr_len) != sizeof(struct btf_header)) {

now compares against 32 instead of 24, so won't this reject all
cross-endian BTF that has hdr_len set to 24?  This looks like it
would break all non-native-endian BTF loading until the next commit
(fcaa86ee9542 "libbpf: Support layout section handling in BTF")
updates these checks to use offsetofend(struct btf_header, str_len).

These are bisection regressions -- at this commit, libbpf cannot load
any BTF produced before layout support was added.  The fix in
fcaa86ee9542 is already present in the series, but could these two
commits be reordered or squashed so that the UAPI change and the
libbpf compatibility fix land together?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22436234361

AI-authorship-score: low
AI-authorship-explanation: Standard kernel commit style with specific lore references and appropriate tags; no AI indicators.
issues-found: 2
issue-severity-score: medium
issue-severity-explanation: Bisection regressions that break libbpf BTF loading for all pre-layout BTF blobs and all cross-endian BTF, though both are fixed by the next commit in the series.

--===============9188822609562961542==--
