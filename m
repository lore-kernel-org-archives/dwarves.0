Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F58135A5C
	for <dwarves@vger.kernel.org>; Tue, 27 Feb 2024 12:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709038758; cv=none; b=TikNGRoqlnCr74Gkqn8EXzhXmnGR2nVIO4zxDgiORaE14mraT7wA88zuBdqAljj0iD4pMPKCgTRwRYjc6DE4NvIzobunT1alOWeTOqRNoOqKxbwEK105KxiUbUYiZ1n0tmLNVfYQ6TBeVYw3iskxNDC7DrEJqzXlhaAwZjpOV1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709038758; c=relaxed/simple;
	bh=7rLno4AMgmdX9NrFrIafIrfyLoMbv8d4hMs9n535+YM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=i1bmSoTe8r6KLB5S+luu7tmSMsdtMacVDwQrE0n3wNkzKqMFc/9iNsZb/HkJSkFHYFYyO7gYCbYbAgES5KLx7Ni3jaUA4zlFe8FQhrzCrVaUpG1C48Asij8szu1skkUcFXLdmyWUZM8RKLbsduAJeVRTSUTrpTlXUiNQ8Solrf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5fHQ2Wo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5fHQ2Wo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B15C433F1;
	Tue, 27 Feb 2024 12:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709038757;
	bh=7rLno4AMgmdX9NrFrIafIrfyLoMbv8d4hMs9n535+YM=;
	h=Date:From:To:Cc:Subject:From;
	b=X5fHQ2WowHSJeRZJJl7YWbal1k7kwoyGeNAmChUge4naW4K0STeJzqAtMVDi81qnD
	 I+nuzW0tFI4vO50YvfKYImFNSHd0irH8rCT9RkbI03RDvfmK+vJ+7PZTwVjR3U6JOf
	 fPj4VUCYNLWLZpafKxnIH6njnBQsnPSj57kcoMcrqQ3FJCiJGFFPfeqMr32IpGyO9Q
	 Gm3Vsr1w5fGabKuqqg5/zaUVHk/yk+zjszB01+7LF/NGeWqXHQyOJHGGkFZ4y7oKzc
	 Oxjr/NPB/rNM3dUlHXCfxGwvA3unl/dsMt6Zpi9eq+Y/FqHU2ykFgpvi15Jw+S5hVU
	 RHaoB8emUeF5w==
Date: Tue, 27 Feb 2024 09:59:14 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>, Alan Maguire <alan.maguire@oracle.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Viktor Malik <vmalik@redhat.com>
Cc: dwarves@vger.kernel.org
Subject: HEADS UP: pahole 1.26 to be released soon
Message-ID: <Zd3cooJ1HgnuC1aV@x1>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

	I'm prepping up pahole 1.26, the noticeable thing for BTF
encoding are Alan's patches (--btf_features, --btf_features_strict and
--supported_btf_features).

	There was a fix for BTF loading, namely the signedness of
enumerations, but that isn't used when building the kernel, just when
pretty printing from BTF.

	I also have a few fixes and new features in the pretty printing
code, but again, that isn't involved when building the kernel.

	If you have time, please do some tests and report results.

	You can find it in the usual places:

git://git.kernel.org/pub/scm/devel/pahole/pahole.git
https://github.com/acmel/dwarves.git

	In the master branch.

Thanks a lot!

- Arnaldo
