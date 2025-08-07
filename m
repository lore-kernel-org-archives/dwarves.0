Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C59824886C
	for <dwarves@vger.kernel.org>; Thu,  7 Aug 2025 20:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754598187; cv=none; b=Vb/hBFT9xnkZxziVyCwZtRJyGqyXNFs5bPyeeyEsFIud1m3ISwk7eyY9D9zrqeKE1h7OobQOYGCdFLXy8jzg8qV/BoaeoMe/G6pATq5aNwxH6MPkcANRmQVB9PozMyi2wMwTIf6EMLmrwhTd259SMDR9NZd7yWnT7HXTWoDh06g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754598187; c=relaxed/simple;
	bh=PhM6aZDLh04KoatxwLiGyayOhIgRFJjx1Ds0aL/u/eQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvOmJT54t8hdblWmmDgHuaiHeb8OrA1Mp/4ERR9JagW69GuRSFMqrU7h6mfCNwRiGCfRdjbUTBDyGka4gJTZUD2PHzx8Y1Q3fucywcbi3xhNN93f4Q2TLBaFxcyM1dxCZ0nwmfXTDpYklb6YSe0hRYBxnEV5s0yCNTMvBIoxFnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PW6kpPyK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PW6kpPyK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2659C4CEED;
	Thu,  7 Aug 2025 20:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754598186;
	bh=PhM6aZDLh04KoatxwLiGyayOhIgRFJjx1Ds0aL/u/eQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PW6kpPyKjb/lQse8t/X3oFqRMptQB3btY0h+pV7KTEmZeXybod0Cm1be9wgJp2Mln
	 bnaUxMma6x1sd5T3jwpdF9EnzCazxZGSrlKvcPYE3wqCLyNs6gUXysP9QnE7AgRTW9
	 EQm0lMgARvq0Uc+jarkWtCCEIzEmOMzTW9FfHki5IB4PluYuaiF2zfWbNgJKRDDchc
	 FNW2qVJ6A02pGCOiXlsO83jLJKgJ1wi0eAkZ+qgWfocOUdJoco2YaSSvYqtx2LX+qJ
	 jxL5x0Rkc6mhUi/eTML0RY7GSUzBON2fmWcqjqEyZKM1CNsc34EiHC314qO4tD+Kr4
	 Ldy38rm8v2qsQ==
Date: Thu, 7 Aug 2025 17:23:01 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	"Jose E. Marchesi" <jose.marchesi@oracle.com>,
	Nick Alcock <nick.alcock@oracle.com>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	"bpf@vger.kernel.org Clark Williams" <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>, dwarves@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [RFC 0/4] BTF archive with unmodified pahole+toolchain
Message-ID: <aJULJSHV0t2s0HuQ@x1>
References: <20250807182538.136498-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807182538.136498-1-acme@kernel.org>

On Thu, Aug 07, 2025 at 03:25:34PM -0300, Arnaldo Carvalho de Melo wrote:
> If we use completely unmodified libbpf, bpftool, etc, the "BTF archive"
> in the resulting vmlinux .BTF ELF section is still consumable, but just
> the first "CU" (the first .o .BTF ELF section) is visible, the one for
> init/main.o:
 
> acme@number:~/git/linux$ bpftool version
> bpftool v7.5.0
> using libbpf v1.5
> features: llvm, skeletons
> acme@number:~/git/linux$
 
> acme@number:~/git/bpf-next$ bpftool btf dump file ~/vmlinux-v6.16.0+.btf_archive format c | wc -l
> 11361
> acme@number:~/git/linux$ bpftool btf dump file ../build/v6.16.0+/init/main.o format c | wc -l
> 11361
> acme@number:~/git/linux$
 
> Furthermore:

> acme@number:~/git/linux$ bpftool btf dump file ../build/v6.16.0+/init/main.o format c > a
> acme@number:~/git/linux$ bpftool btf dump file ~/vmlinux-v6.16.0+.btf_archive format c > b

Oops, the expected:

acme@number:~/git/linux$ diff a b
acme@number:~/git/linux$

> acme@number:~/git/linux$

- Arnaldo
