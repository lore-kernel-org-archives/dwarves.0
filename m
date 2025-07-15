Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007482522B1
	for <dwarves@vger.kernel.org>; Tue, 15 Jul 2025 15:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752594118; cv=none; b=CLjiHOzgI6CsxERbeabZgQM30OCEB103a6gd+1I/c5Cd05FZRSUKPEm+U8RTf+/+CEUUbuhgNBU1VUKiKDAJni7fyiotZST3xPDcybtY9T9MqKwVZ7gaZ6YZtxqmfFYiKGyGDTsdhS3RW8tgziCBR8L9y4elV6MTI+yJH/Ynxis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752594118; c=relaxed/simple;
	bh=6xM4bkz18XXFdVf0XZReeqarFpnYfPTC8uRy06xAZN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LAfBlJi2alb0HrNDOD/ZHmn0G1spWly0KUCn5sKE4Q/9UsUEfMjoM6WwJqO7vbQTLAiWQEUAiDsDxJ4wGYRuErlCpdf/pZBMhrdxcUJCJdiTjx3rf7NoUG8lnAZcaVHdJNdkCq6TOhzmb2NyayYuOz5HpErmW/rhvsWtqgOFZgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sY6G70hw; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sY6G70hw"
Message-ID: <10fb86ef-8e1e-47a0-a553-e900af1d8c9c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752594113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NnLoB/bjSoDNhvtv4OKCOZCvQoOqBv0o4yG7uWLd32s=;
	b=sY6G70hw9+1/5x6A1834loWB+sW0HC22fHVTWeg40ZVGRhipTjAZlrJei8Q3l4ESSzJMMw
	UY7iTcugY4BZnSOOUK1E5uxpILTZcqsO/GVMhBO/92ByKAnWNTWW4fOn2tnh7k9ReWb8qG
	HUpzK1x9FoiTyfwpdL7gW0CLMmxm2Xg=
Date: Tue, 15 Jul 2025 08:41:43 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 dwarves 0/2] Add function list comparison to github CI
To: Alan Maguire <alan.maguire@oracle.com>, dwarves@vger.kernel.org
References: <20250710161632.191304-1-alan.maguire@oracle.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20250710161632.191304-1-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/10/25 9:16 AM, Alan Maguire wrote:
> As changes to pahole can generate different sets of functions for
> vmlinux BTF, automate comparison between next branch and the series
> CI is testing.  Build baseline (default 'next' branch) as part of
> build-pahole.sh and build kernel with both test and baseline pahole,
> using pfunct to generate function lists for comparison.
> Example job here [1].
> 
> Patch 1 ensures that the baseline pahole is not built as part of
> setup; patch 2 adds the baseline build and compare-functions job to
> the dwarves-ci pipeline.
> 
> Changes since v2:
> 
> - altered patch 1 to not build pahole (pahole: 'none') during setup
>    (Ihor, patch 1)
> - do baseline build when building pahole via script, add compare
>    functions to summary (Ihor, patch 2)

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>

Thanks!

> 
> Changes since v1:
> 
> - fix rebuild to actually rebuild with baseline pahole (patch 2)
> 
> [1] https://github.com/alan-maguire/dwarves/actions/runs/16192185959
> 
> Alan Maguire (2):
>    github CI: Do not build pahole as part of dwarves-ci setup
>    github CI: Add comparison of generated BTF functions between baseline,
>      change
> 
>   .github/scripts/build-pahole.sh      | 23 +++++++++++++++++++++
>   .github/scripts/compare-functions.sh | 30 ++++++++++++++++++++++++++++
>   .github/workflows/test.yml           |  4 ++--
>   .github/workflows/vmtest.yml         |  4 ++++
>   4 files changed, 59 insertions(+), 2 deletions(-)
>   create mode 100755 .github/scripts/compare-functions.sh
> 

