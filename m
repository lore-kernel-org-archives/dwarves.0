Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78331D3197
	for <dwarves@vger.kernel.org>; Tue, 19 Nov 2024 18:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732040954; cv=none; b=nQoALC6FbOj21h9+0ocbZ1XlQQKDmwaa7xTymgDll8w+0SGLJI6v42DwXP/qbOPRMp+XWpUnv6uczVGFRCYsDuOuQi9m5LxOpnOpc4dXEd0zeHBiuLzp8QcZhkwO7pzZ0PmXjXBLCsPvqAYHL/N3mAd6jdHYMJW/iu7Xsc79G1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732040954; c=relaxed/simple;
	bh=54y90a6t0IgH6WHbrIlj5CJDsDbfgZJyBuv1P92KfXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LN458e93NiHMcZCRZo8btN9KT1F/BjmqtFSijLfPshgg4eVSa+s0xn/jk0WRf6I31Pq3eSn+N22HhTIod7dk6X4akA+gixZZzg+F2xXWAMefc5YGPS3uyL+j6/TNQy3/U41rByh6W6rA1kl1tj8u4CRCJQGQ8WtPPN6PF/5qVYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKgg4HRX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKgg4HRX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2353C4CED0;
	Tue, 19 Nov 2024 18:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732040954;
	bh=54y90a6t0IgH6WHbrIlj5CJDsDbfgZJyBuv1P92KfXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dKgg4HRXEftZaHnJo19+rjhQjlRHiWPlvqKQweIjMzuYE4MZsIBiSxmb2mpildXDR
	 OIe3yd8l+N5AJzZq+QeuOuWrGJ/zUSbv9K8g6Lhjj/gRQ+EIX/gv11BPsQF6HC4ObG
	 5tgyRv70uUSZu8p6ejSc+vGcutkZwvLsdElyMdFlzYQlnRT5IJCY0DvOkEZJ+oB+dV
	 SHQRKGqABjirnfbAb7kp8aFrpeI79WvBtWS9BZ5m93vBKljxmdpwu4RvrMqrpC2QPm
	 8hYGFdkNQyy95W6x+t/yOo9spW2mXI25Q1SN9C4FiVzTPYdAb62DLVH5KErbfKzFIG
	 +Z575Z83JQhVw==
Date: Tue, 19 Nov 2024 15:29:10 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Matthias Schwarzott <zzam@gentoo.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>, dwarves@vger.kernel.org
Subject: Re: [PATCH 5/5] core, libctf: Check if constructor arguments are
 NULL before using them
Message-ID: <ZzzY9uwdCO9hezd6@x1>
References: <20241118204146.772762-1-acme@kernel.org>
 <20241118204146.772762-6-acme@kernel.org>
 <4b465bfc-8214-41ab-8b6d-bbdf7421e19b@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b465bfc-8214-41ab-8b6d-bbdf7421e19b@oracle.com>

On Tue, Nov 19, 2024 at 05:02:39PM +0000, Alan Maguire wrote:
> On 18/11/2024 20:41, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> >   # pahole
> >   Segmentation fault (core dumped)
> >   #
> > 
> > Now we have:
> > 
> >   # ls -la bla
> >   ls: cannot access 'bla': No such file or directory
> >   # export PAHOLE_VMLINUX_BTF_FILENAME=bla
> >   # pahole
> >   pahole: couldn't find any debug information on this system.
> >   # pahole list_head
> >   pahole: couldn't find any debug information on this system.
> >   # pahole -F btf list_head
> >   pahole: couldn't find any btf debug information on this system.
> >   # pahole -F dwarf list_head
> >   pahole: couldn't find any dwarf debug information on this system.
> >   # tests/default_vmlinux_btf.sh
> >   Default BTF on a system without BTF: Ok
> >   #
> > 
> > Reported-by: Matthias Schwarzott <zzam@gentoo.org>
> > Cc: Alan Maguire <alan.maguire@oracle.com>
> > Cc: Andrii Nakryiko <andrii@kernel.org>
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Song Liu <song@kernel.org>
> > Cc: Yonghong Song <yonghong.song@linux.dev>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> Tested-by: Alan Maguire <alan.maguire@oracle.com>

Thanks, added to the cset,

- Arnaldo
