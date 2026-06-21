Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB143D994
	for <dwarves@vger.kernel.org>; Sun, 21 Jun 2026 16:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782059194; cv=none; b=D6LrouUEpfYuuBT1cJRRqBRY60gqH3q/b6O0UcoYsoHX0MTZFRmUDBNx+18bWVqV7l3ePCdxSSp/VhLv82IeDa5elbvgjwx1VcTOK6YTcOoZFxI/P52RVtkKtkKOOaekifbyK6RvkEx+UoXXo7Vt0WXDXu4p3mV59RxebfG/4f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782059194; c=relaxed/simple;
	bh=V5bxYyPYOy+chn92ALqes+EccWvl0JP7zH6u8WPitmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UOPPX8rwRtgVS0puGgdDtmiyOLTBVCUYMWmgR3KIpKLbbdjvv3GKsDirXGz+/piCFub1VO8m6ooAqfhacoJNQjbnZYppsMp+L1zkQBY5P+tLUWX/D81+2JKSTMByujPT0i3OMdN/btbQXM8NMKXS0TV+ZcvnfsPIpHUa+HUfNzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FtmzyhkA; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FtmzyhkA"
Message-ID: <28a9a5cb-4f0f-4586-9547-e35e4731c70c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782059190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZFADtfXs2K4Z+PbJH55Gh+tcP9gfeymLAtyHarUG+IA=;
	b=FtmzyhkA16odqzoDQrbsMizNsInjVJz1BwAeWw4gvmFQOVjWGeIhC8/ho+XzbtJy7uJRt6
	VqeW/Wm2wdX1CIiVRvuXMXLdq3HCCai+y3oQwKeY/zl3FVKfcNjEw4ROV3FfOe3xQeZNgC
	Zxn2JY0YQ0LYCsO8/qZXGm3z0ig8474=
Date: Sun, 21 Jun 2026 09:26:23 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves] CI: Update llvm version to 22
Content-Language: en-GB
To: Alan Maguire <alan.maguire@oracle.com>, dwarves@vger.kernel.org
References: <20260621125745.34985-1-alan.maguire@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260621125745.34985-1-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/21/26 5:57 AM, Alan Maguire wrote:
> Best to test with most recent available version.
>
> Suggested-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Thanks for using latest llvm22. LGTM.

> ---
>   .github/scripts/build-kernel.sh      | 2 +-
>   .github/scripts/compare-functions.sh | 2 +-
>   .github/workflows/ondemand.yml       | 2 +-
>   .github/workflows/test.yml           | 8 ++++----
>   .github/workflows/vmtest.yml         | 2 +-
>   5 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/.github/scripts/build-kernel.sh b/.github/scripts/build-kernel.sh
> index 9f11b22..63806f2 100755
> --- a/.github/scripts/build-kernel.sh
> +++ b/.github/scripts/build-kernel.sh
> @@ -10,7 +10,7 @@ REPO=${REPO:-https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git}
>   REPO_BRANCH=${REPO_BRANCH:-master}
>   REPO_TARGET=${GITHUB_WORKSPACE}/.kernel
>   CC=${CC:-gcc}
> -LLVM_VERSION=${LLVM_VERSION:-18}
> +LLVM_VERSION=${LLVM_VERSION:-22}
>   
>   export PATH=${GITHUB_WORKSPACE}/install/usr/local/bin:${PATH}
>   export PAHOLE=${GITHUB_WORKSPACE}/install/usr/local/bin/pahole
> diff --git a/.github/scripts/compare-functions.sh b/.github/scripts/compare-functions.sh
> index 48fc086..fdc9aae 100755
> --- a/.github/scripts/compare-functions.sh
> +++ b/.github/scripts/compare-functions.sh
> @@ -10,7 +10,7 @@ VMLINUX=${GITHUB_WORKSPACE}/.kernel/vmlinux
>   BASELINE=${BASELINE:-next}
>   GITHUB_STEP_SUMMARY=${GITHUB_STEP_SUMMARY:-/dev/null}
>   CC=${CC:-gcc}
> -LLVM_VERSION=${LLVM_VERSION:-18}
> +LLVM_VERSION=${LLVM_VERSION:-22}
>   
>   export PATH=${GITHUB_WORKSPACE}/install/usr/local/bin:${PATH}
>   which pahole
> diff --git a/.github/workflows/ondemand.yml b/.github/workflows/ondemand.yml
> index 5f3034f..6e48e12 100644
> --- a/.github/workflows/ondemand.yml
> +++ b/.github/workflows/ondemand.yml
> @@ -7,7 +7,7 @@ on:
>           default: 'x86_64'
>           required: true
>         llvm-version:
> -        default: '18'
> +        default: '22'
>           required: true
>         kernel:
>           default: 'LATEST'
> diff --git a/.github/workflows/test.yml b/.github/workflows/test.yml
> index a81aa55..940dab1 100644
> --- a/.github/workflows/test.yml
> +++ b/.github/workflows/test.yml
> @@ -19,25 +19,25 @@ jobs:
>             - kernel: 'LATEST'
>               runs_on: 'ubuntu-24.04'
>               arch: 'x86_64'
> -            llvm-version: '18'
> +            llvm-version: '22'
>               pahole: 'none'
>               cc: 'gcc'
>             - kernel: 'LATEST'
>               runs_on: 'ubuntu-24.04'
>               arch: 'x86_64'
> -            llvm-version: '18'
> +            llvm-version: '22'
>               pahole: 'none'
>               cc: 'clang'
>             - kernel: 'LATEST'
>               runs_on: 'ubuntu-24.04-arm'
>               arch: 'aarch64'
> -            llvm-version: '18'
> +            llvm-version: '22'
>               pahole: 'none'
>               cc: 'gcc'
>             - kernel: 'LATEST'
>               runs_on: 'ubuntu-24.04-arm'
>               arch: 'aarch64'
> -            llvm-version: '18'
> +            llvm-version: '22'
>               pahole: 'none'
>               cc: 'clang'
>       name: Linux ${{ matrix.kernel }}
> diff --git a/.github/workflows/vmtest.yml b/.github/workflows/vmtest.yml
> index 147b608..d6f9f79 100644
> --- a/.github/workflows/vmtest.yml
> +++ b/.github/workflows/vmtest.yml
> @@ -25,7 +25,7 @@ on:
>         llvm-version:
>           description: 'llvm version'
>           required: false
> -        default: '18'
> +        default: '22'
>           type: string
>         cc:
>           description: 'compiler'

