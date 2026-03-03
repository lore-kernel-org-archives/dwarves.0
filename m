Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135BE37C928;
	Tue,  3 Mar 2026 19:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772565326; cv=none; b=Z3aloDlnbJER8fisun0KlLVMKJPSbhrECf8qcxRPbhDLW4gwLdC4FvnAM6hL/6qFn7NKUCilkv8wFKmsWRYIkUp7fO6ZypUUMdkhAgHZz327wNseaa9AyHvNR+K9m1YDIcjPpl7EXV53ZNWeLEJ7dxskt9hGDi06eHXUAW89whI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772565326; c=relaxed/simple;
	bh=htzWbvB3FY3doCQU/LgOBiUX2vZy6IQAz9JZh2q127c=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=nyP1i1JLsgpyR9bJZtfEz9Lc7bTNA605F2HLIHOeBnU/wE6ZEnisHq4LwlmauNO6V62pr4UHq9i5pyhf7YL7vNBUmNMy4IPPwBxs1+Xy03HEnTnMCyZE7TpSN23wEafZ4FfOKZJRciMtqAZJA59TFxQdfETzcnwvzkoYHIlTEjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2vylJWn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2vylJWn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484F4C19425;
	Tue,  3 Mar 2026 19:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772565325;
	bh=htzWbvB3FY3doCQU/LgOBiUX2vZy6IQAz9JZh2q127c=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Z2vylJWnE424Du7qd4uGzneJMZZPB4jVIPbLBGtGOsUFUvhx9iZh1ewlerqIMopuA
	 3KFWpvY8+JWH4+hqwEgtOjcD/L5TMUhBf+w+G6RZiZnNoak4GHgCcPh4fhVgACrogE
	 G1Thxz004j/xGJ2USdCECXf2j3x1EfHkye2s/k1kLb8NrbG3nTeJbJAd+0FwmhLjh3
	 gNVMhi8eTT8wjyOh3loCyMnzX9eZieupnZ2pQc/WpwaxWau3qyBldHA2wXv9W9vvr4
	 6ydEWipXOWt3I9bCcidKLeJPyrX7xYLPigddwb9cfIEbQaIwoaTMNiDS9jf00HIdL+
	 E57mLyJaOMsSg==
Content-Type: multipart/mixed; boundary="===============7482303972349924174=="
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c7c1696f1bf7ccc682cd27a6f1245555f21abeb79163865d82eec9438895e47f@mail.kernel.org>
In-Reply-To: <20260303182003.117483-8-alan.maguire@oracle.com>
References: <20260303182003.117483-8-alan.maguire@oracle.com>
Subject: Re: [PATCH v12 bpf-next 7/8] selftests/bpf: test kind encoding/decoding
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,andrii@kernel.org,ast@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,qmo@kernel.org,ihor.solodrai@linux.dev,mykyta.yatsenko5@gmail.com,dwarves@vger.kernel.org,bpf@vger.kernel.org,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  3 Mar 2026 19:15:25 +0000 (UTC)

--===============7482303972349924174==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_kind.c b/tools/testing/selftests/bpf/prog_tests/btf_kind.c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_kind.c

[ ... ]

> +static void write_raw_btf(const char *btf_path, void *raw_btf, size_t raw_size)
> +{
> +	int fd = open(btf_path, O_WRONLY | O_CREAT);
                                          ^^^^^^^^

Should this include a mode argument?  When O_CREAT is specified,
open() requires a third mode_t parameter.  Without it, the file
permissions are determined by whatever value happens to be on the
stack, since open() is variadic.

Something like this would avoid the undefined behavior:

    int fd = open(btf_path, O_WRONLY | O_CREAT | O_TRUNC, 0600);

> +
> +	write(fd, raw_btf, raw_size);
> +	close(fd);
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22637324186
--===============7482303972349924174==--
