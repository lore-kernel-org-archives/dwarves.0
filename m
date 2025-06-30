Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D694872613
	for <dwarves@vger.kernel.org>; Mon, 30 Jun 2025 18:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751308739; cv=none; b=liX+4vNvypZjbXHtBwXRk6c0IrqjbA17YxAnmLF+e899sAFrtJXbAqQDnPti353dEcoLwIIzec/x+kpFOvljzndubtxyL3T+buJoY6rzxifcDi+OzzCDeGQgiEPeSzAnHlMvYhGKuuL+6dfUExujJC9P2BcvqwTX+RZjXupzXw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751308739; c=relaxed/simple;
	bh=nhnEdgMm3BHEf24Sc6+CpFGpFoZUZ715ELZDcRSfk6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PPGzAnmOAA3kNAbv/8JdTUnJvhHUrTUgEv4XLDlU0s802YIMTPO5Q4ag0ZEFLqhcF8KUz0697veHQcGgxWgDc53ShCkpsPWgCYEYowDkQn/tGBx//90S8twiGpVFHjTVFmJVacmYcOipWr+hOFBxmWaSZFDeePjtv6UG/kSWFe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iNy93VfT; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iNy93VfT"
Message-ID: <e777afb7-b4b1-4625-b40d-b86b7a97dcbe@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751308736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WBuKXUgOHJqjkxLJ4o871KmO3t0TDkVvlWarIsjTUbI=;
	b=iNy93VfTvf5B0NGi7PNUVZQ05MTEjZ+Vntv0Ur6htFLRE6PsvAz9KlOw0OwBruZ4E5yI82
	vaO4gNtfdG3bxM5jx4r/AzWNTHYdueLtV9G6Ca1J5dtz3AHBm9ZN5zA8r4WH9JtHvSlQcN
	M9iOYCzBgfKisVgAuhqlGI4ff6+DZAY=
Date: Mon, 30 Jun 2025 11:38:51 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 dwarves 1/2] github CI: Build pahole "next" branch as
 well as latest changes
To: Alan Maguire <alan.maguire@oracle.com>, dwarves@vger.kernel.org
References: <20250630101537.2680289-1-alan.maguire@oracle.com>
 <20250630101537.2680289-2-alan.maguire@oracle.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20250630101537.2680289-2-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/30/25 3:15 AM, Alan Maguire wrote:
> In order to support compare/contrast of BTF generation with
> changes, build next branch of pahole for comparison purposes.
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>   .github/workflows/test.yml | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Ihor Solodrai <ihor.solodrai@linux.dev>

> 
> diff --git a/.github/workflows/test.yml b/.github/workflows/test.yml
> index f11ebfe..99c179a 100644
> --- a/.github/workflows/test.yml
> +++ b/.github/workflows/test.yml
> @@ -20,12 +20,12 @@ jobs:
>               runs_on: 'ubuntu-24.04'
>               arch: 'x86_64'
>               llvm-version: '18'
> -            pahole: 'master'
> +            pahole: 'next'
>             - kernel: 'LATEST'
>               runs_on: 'ubuntu-24.04-arm'
>               arch: 'aarch64'
>               llvm-version: '18'
> -            pahole: 'tmp.master'
> +            pahole: 'next'
>       name: Linux ${{ matrix.kernel }}
>       uses: ./.github/workflows/vmtest.yml
>       with:

