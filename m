Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C4D1448DC
	for <dwarves@vger.kernel.org>; Tue, 19 Nov 2024 18:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732041131; cv=none; b=bUq9cX3w5+H0bR9mI19kIyFfIkMDE6wtMmh5ICsBR6RTskc2WaY0iHBn6f214sgZTST42YkdYdBYmHIWXh69TmMpX78/s5xIJEmyFVdZxTwO1KuLdoeADljt64GEmi/YZC3bqO5c0OuHThpghmPtYaKXGD/ZlC/szIkpLN7798Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732041131; c=relaxed/simple;
	bh=DuK7/l0mWNxy4bp2713DUVz1v5lQaU7vitluYndW+wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFwhBDNpTbO4Jn7hkgWrl4Rta27pXgVA3JpsqunQXEBunRJsA5aGHjfjafifMR37TEdV0/Dl8i6TXt0Si//YkazpqEb3enI4gu6gOKpOueG+NlPHzd/XoRWs3OaEldinqc1BdGYEjvF4Zsbn5KYMJovUOn7UmLt3TGTXLTI9jAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fX2OhD+1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fX2OhD+1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC0CC4CECF;
	Tue, 19 Nov 2024 18:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732041130;
	bh=DuK7/l0mWNxy4bp2713DUVz1v5lQaU7vitluYndW+wQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fX2OhD+13zL8cojH6lDA4t8H9lZTV5BcB3VZTp3eDlRM9Lgxg3S9O7gZJYkuGfwdG
	 FzY3B6mmde/nxS6588d/BNRpdyZLHZZDcHddNSKFLS/nsK1hpzKFwtwNIpXOFiDSq+
	 IFT5n2/hafDMQv5K6aH8MEc+4M7vrTHDhtPrUdMUoHnUZDzFrzNR5tSeydhwEZCFq0
	 l+N+gt/OFjLW2rEt2jT8ZQT+eU41rxrw7iTGKRuDZaSxWCIlRsy6KqjLkdSJoSoUjy
	 1DZCghUbkoxIo3b1wNt76zIFcyCZWr0sIHkbePIx2jSjeyvSJr4kZDXCXouSO+8YS6
	 NpXnEJkbGojVA==
Date: Tue, 19 Nov 2024 15:32:06 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Matthias Schwarzott <zzam@gentoo.org>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>, dwarves@vger.kernel.org
Subject: Re: [PATCH 1/5] core: Add method to get the vmlinux BTF filename,
 allow overriding it via env var
Message-ID: <ZzzZpqA8ZH-6-Aj9@x1>
References: <20241118204146.772762-1-acme@kernel.org>
 <20241118204146.772762-2-acme@kernel.org>
 <9992d2487775011278aef17d1a2db98b8cc74e7d.camel@gmail.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9992d2487775011278aef17d1a2db98b8cc74e7d.camel@gmail.com>

On Tue, Nov 19, 2024 at 10:24:14AM -0800, Eduard Zingerman wrote:
> On Mon, 2024-11-18 at 17:41 -0300, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > In systems where BTF isn't available there were reports that the
> > simplest pahole call, without any args, segfaults.
> > 
> > To have a proper test before fixing this problem, allow overriding the
> > /sys/kernel/btf/vmlinux filename, so that even in systems with BTF we an
> > point it to a invalid location, making pahole think that there is no BTF
> > available and thus fallback to something that currently segfaults.
> > 
> > Using it:
> > 
> >   $ pahole list_head
> >   struct list_head {
> >   	struct list_head *         next;                 /*     0     8 */
> >   	struct list_head *         prev;                 /*     8     8 */
> > 
> >   	/* size: 16, cachelines: 1, members: 2 */
> >   	/* last cacheline: 16 bytes */
> >   };
> >   $
> >   $ PAHOLE_VMLINUX_BTF_FILENAME=foobar pahole list_head
> >   Segmentation fault (core dumped)
> >   $
> > 
> > Reported-by: Matthias Schwarzott <zzam@gentoo.org>
> > Cc: Alan Maguire <alan.maguire@oracle.com>
> > Cc: Andrii Nakryiko <andrii@kernel.org>
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Song Liu <song@kernel.org>
> > Cc: Yonghong Song <yonghong.song@linux.dev>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> 
> Lgtm, tried setting PAHOLE_VMLINUX_BTF_FILENAME to unrelated selftests
> with some BTF, pahole works as expected (prints structures defined in
> the selftest).
> 
> Tested-by: Eduard Zingerman <eddyz87@gmail.com>

Thanks a lot, added to the cset!

- Arnaldo
 
> [...]
