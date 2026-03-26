Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D43141C72;
	Thu, 26 Mar 2026 21:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560040; cv=none; b=OTp4r1wOnQJu08rcUPbd/+YED0aGDkF13yiieYXcwuqUAkQ7Hj9J/Omon89ZCuaJsNwF/HTDe5Z/wzDNYgkD0/KN5OsAhvwGBOk43ekqvjtx8G2O+73AJpQESN9SCQUmukSpOAOnxvSRJmbvYDqEOqxjPAc2mZ2lENvsT7nd6G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560040; c=relaxed/simple;
	bh=gtmB+zFOa41OuBqbmO7TmyD/jbj4QQC/RgxbGwilKJU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jyH//hAzfMGP2z9gzkpSuwNsDNvrygaNcaqqMoRPWG7MGqJ7VYTO/ofFIOwv8aKafxhpdh8M2uY40jyr4obig+h4T1ECTwxcOMy81OXsp10geVQdZsZ9qxjBM5hRxGLe2DtNQWB12vMd/RwiC//Wqy7/e/6NqY8vpsAQ/jHsXd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVeVbaEv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVeVbaEv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F21C116C6;
	Thu, 26 Mar 2026 21:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774560040;
	bh=gtmB+zFOa41OuBqbmO7TmyD/jbj4QQC/RgxbGwilKJU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KVeVbaEv4EoD1gHM6u+zygqYmIuMPmCXuu1G3of5Mvf70bR48gyA7PVvmGn21Zskk
	 P+3aMqvK0eSU+vYZuUPvanzUQkTSjMD2sU6BvgmHfTEiqt1swpVl/fLkJgC1EQJr7d
	 ypL1+X3CtdiUH6dg94Z0q9T5i+g0CTGRnvUi3xSmJ/gdJmXfGaz5vN/D8xp1yAw8bu
	 HmJL4inOe9djx/mziB+ZqBOIPOT7BjwOPVR2oZKx0X75NFQGZsKKD1+gLRlg7fY+8l
	 UORptWAN1u/YSw/0+ZWv8hr/v0Gpr7uKyrVHRle7b9QXjVNT1j2FdXjaJCmPrtJE4l
	 g/aT1TnnneJqg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA01939F280C;
	Thu, 26 Mar 2026 21:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v16 bpf-next 0/9] Add BTF layout to BTF
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177456002639.3181880.17500353700750230925.git-patchwork-notify@kernel.org>
Date: Thu, 26 Mar 2026 21:20:26 +0000
References: <20260326145444.2076244-1-alan.maguire@oracle.com>
In-Reply-To: <20260326145444.2076244-1-alan.maguire@oracle.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, qmo@kernel.org,
 ihor.solodrai@linux.dev, mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
 bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 26 Mar 2026 14:54:35 +0000 you wrote:
> Update struct btf_header to add a new "layout" section containing
> a description of how to parse the BTF kinds known about at BTF
> encoding time.  This provides the opportunity for tools that might
> not know all of these kinds - as is the case when older tools run
> on more newly-generated BTF - to still parse the BTF provided,
> even if it cannot all be used.
> 
> [...]

Here is the summary with links:
  - [v16,bpf-next,1/9] btf: Add BTF kind layout encoding to UAPI
    https://git.kernel.org/bpf/bpf-next/c/222edc843c15
  - [v16,bpf-next,2/9] libbpf: Support layout section handling in BTF
    https://git.kernel.org/bpf/bpf-next/c/087f3964f4b3
  - [v16,bpf-next,3/9] libbpf: Use layout to compute an unknown kind size
    https://git.kernel.org/bpf/bpf-next/c/2ecbe53e0e99
  - [v16,bpf-next,4/9] libbpf: Add layout encoding support
    https://git.kernel.org/bpf/bpf-next/c/d686d92c4080
  - [v16,bpf-next,5/9] libbpf: BTF validation can use layout for unknown kinds
    https://git.kernel.org/bpf/bpf-next/c/6ad89285996a
  - [v16,bpf-next,6/9] libbpf: Support sanitization of BTF layout for older kernels
    https://git.kernel.org/bpf/bpf-next/c/081677d03d8b
  - [v16,bpf-next,7/9] btf: support kernel parsing of BTF with layout info
    https://git.kernel.org/bpf/bpf-next/c/626e88c070ee
  - [v16,bpf-next,8/9] selftests/bpf: Test kind encoding/decoding
    https://git.kernel.org/bpf/bpf-next/c/0467491617cb
  - [v16,bpf-next,9/9] kbuild, bpf: Specify "layout" optional feature
    https://git.kernel.org/bpf/bpf-next/c/5e1942eb1c01

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


