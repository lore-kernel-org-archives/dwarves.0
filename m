Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BB334AB14
	for <dwarves@vger.kernel.org>; Sat, 20 Jun 2026 21:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781989288; cv=none; b=QndvjXQfYIjf3F1RYcAARyZTRE+PhqbmhylGx5X05Lznj+D0zEiwUK4LHkPjt8U4RYdNdArry6Os5aeHTLAVGwn84MOYxX9eAcqt2pO1RcLtgsl/nMjms7XP7szpfnd2dIWwRx/bTvmN7u2x6ZtBX9oCYa/AxsLjZ/2EMCBbrzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781989288; c=relaxed/simple;
	bh=N5unOiqSCt2z+o85jKE1upRV3WDjC6O3Vik0rK8BYdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=C637T/xf2cCFHL00GmLGs94rGfdAw6VNzVD6cVPq/hG3nCTWIYSONjT+FdafJ9Sd77RXl+bS/s5T42T4pqqql7/9Lt8KcyY8UgmXHmSaAVisPcfS76tNHLsM2oduZ1UCRChXUIuhXYYi1HCQP+KQZpUR18I3Pfii4hFOiLtUI8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v1pyx917; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v1pyx917"
Message-ID: <d9e0f529-7b42-4b97-abb0-ca54beb3a25c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781989284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JbMx52KdIy6mBSTmg0H5WDTAdIhbeYxXXL2IPb4W068=;
	b=v1pyx917MRFMjaD/28q8ygxUkTACAFadYhpgg1Qx69Sj183BNw2J3UdRWLHsUb73wAeGZk
	mZ9MvNzrwUZ/Z1nZe+yxcMwqzeDoTVe0zq2sUpvVLqrc+7B6gH366CIY9zU5A3nx8BQu9q
	xzKKby6pSmBue5wPI4V30ilQ5oNLsT0=
Date: Sat, 20 Jun 2026 14:01:10 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves] CI: add clang+aarch64 to matrix
Content-Language: en-GB
To: Alan Maguire <alan.maguire@oracle.com>, dwarves@vger.kernel.org
References: <20260620083056.361658-1-alan.maguire@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260620083056.361658-1-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/20/26 1:30 AM, Alan Maguire wrote:
> Need to test full matrix of gcc/clang + x86_64/aarch64.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

looks like we are still using llvm version 18, could you
increase llvm version to 21 or 22? Or ubuntu-24 only
supports llvm 18?

> ---
>   .github/workflows/test.yml | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/.github/workflows/test.yml b/.github/workflows/test.yml
> index f47cc4a..a81aa55 100644
> --- a/.github/workflows/test.yml
> +++ b/.github/workflows/test.yml
> @@ -34,6 +34,12 @@ jobs:
>               llvm-version: '18'
>               pahole: 'none'
>               cc: 'gcc'
> +          - kernel: 'LATEST'
> +            runs_on: 'ubuntu-24.04-arm'
> +            arch: 'aarch64'
> +            llvm-version: '18'
> +            pahole: 'none'
> +            cc: 'clang'
>       name: Linux ${{ matrix.kernel }}
>       uses: ./.github/workflows/vmtest.yml
>       with:

