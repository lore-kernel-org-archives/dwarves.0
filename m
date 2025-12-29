Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE305271A7C
	for <dwarves@vger.kernel.org>; Mon, 29 Dec 2025 19:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767036523; cv=none; b=nV3gWze0DAZ+ch2fDx1Imv9YLkw7ZMYc0pIGM+jIQnOAtGiQ0vkphHNFmRh3szjoBi8d+z6yfptHp5uYn8EmF6wBUxWsQhd1F/DIYh552A0s6Ps12u643lXa7LV8r7zF6gwbkJv1T3QVHzyw1LG+NoNJt2w/DANZDOhagzuZZbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767036523; c=relaxed/simple;
	bh=OvepIgKTsXQ554crop9a18ID5p0xWukoyJgTO3AWK+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ERTgy21v0WSlg0Fk2Bv55LFWgvaKSAxNlCBSPJ9wdmpO+wCYdqd1vdDT9draD4P1Sz/sT8L6hUuIKAsWSWk9iJiXJXHl2TLHfJnBZajo7JKjTSPMZrjaG9h0pmIFrVFffSaRxoEeTzswkhxP1iGDVXh4VJ8xxEqguuXby3jvhj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jNeIe3bC; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jNeIe3bC"
Message-ID: <5c9130f8-dd8a-41c4-8033-d5661f64c01a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767036509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Irz9LTpqvbmdmlGPdks1FZg7wCTsfvzQn5Eo49frrB4=;
	b=jNeIe3bCnu6XyQCXlqqd5hpLnTRq96sypyzRUtDSC6IHaCuWb7ttMM4nGHeAaXtjshEnam
	qVSotNJSq4u18h03AMXj9tATx7VRK69uKeu+c126wv8frmZHDHEs77M53pSAGB/Se5nSsX
	2oF8EeFZniVaZ0rEM8Lx/htuO/53pDA=
Date: Mon, 29 Dec 2025 11:28:10 -0800
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [bpf-next:master 8/9] FAILED: load BTF from .tmp_vmlinux1.BTF.1:
 No such file or directory
To: kernel test robot <lkp@intel.com>, Dinh Nguyen <dinguyen@kernel.org>,
 Alan Maguire <alan.maguire@oracle.com>
Cc: oe-kbuild-all@lists.linux.dev, Andrii Nakryiko <andrii@kernel.org>,
 bpf <bpf@vger.kernel.org>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, dwarves <dwarves@vger.kernel.org>
References: <202512250932.X7mdviuH-lkp@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <202512250932.X7mdviuH-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/24/25 5:01 PM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> head:   f14cdb1367b947d373215e36cfe9c69768dbafc9
> commit: 522397d05e7d4a7c30b91841492360336b24f833 [8/9] resolve_btfids: Change in-place update with raw binary output
> config: nios2-randconfig-001-20251224 (https://download.01.org/0day-ci/archive/20251225/202512250932.X7mdviuH-lkp@intel.com/config)
> compiler: nios2-linux-gcc (GCC) 11.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251225/202512250932.X7mdviuH-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202512250932.X7mdviuH-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    Complex, interval and imaginary float types are not supported
>    Error while encoding BTF.

Hi Dinh, Alan,

Not sure why this has surfaced only now, but it appears that kernel
build with ARCH=nios2 and CONFIG_DEBUG_INFO_BTF=y has been broken for
a long time.

I tried the following revisions:
  - bpf-next @ 522397d05e7d as in bug report
  - bpf-next @ 014e1cdb5fad without the gen-btf.sh patch
  - v6.18
  - v6.17
  - v6.12 (~1y ago)

All fail with the same error in pahole [1]:

	Complex, interval and imaginary float types are not supported
	Encountered error while encoding BTF.

I used v1.24 in most experiments, the default debian:bookworm
installation.  Upgrading pahole to v1.31 doesn't change this behavior.

I also stumbled on a phoronix article [2], saying Nios II support has
ended with GCC 15. Is it actively supported in Linux?

Not clear to me if anything needs to be fixed here. I'd appreciate any input.

Thanks.

[1] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/tree/btf_encoder.c?h=v1.31#n469
[2] https://www.phoronix.com/news/GCC-15-Drops-Altera-Nios-II


>>> FAILED: load BTF from .tmp_vmlinux1.BTF.1: No such file or directory
> 

