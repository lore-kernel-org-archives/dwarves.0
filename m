Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603001D1E6C
	for <dwarves@vger.kernel.org>; Tue, 19 Nov 2024 17:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732038677; cv=none; b=axQ3Ve/a8eoWz1c2IaWM0K5wiNg5fPeT1B5YDxjv0Xwd7D8NaCKAATf9ZbMFFtrggNFpipQTmfuho9UA4deXFnXLAwf31peNFlNKKsXiY4NP79o/u1jSB/soe67ZzjwEA3P85444leaj2iEtX2lRIWwP08TS4pWkcZ23oR6rnrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732038677; c=relaxed/simple;
	bh=S4zzwsIK5279pRaw9TZlm/mOaVhuIkKloynQm8HQ0BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OR06B4eZS8hmhpeIKcY+fP0YQhbMWydI4c9vwjPzv4LxMwz1mspFvwxCcFonUaO3VG7ZqQtsrJPhzFDGnOuOsP0Mu5Hsximuxgws54XalozRrVVwrQ9OOOPG2K78pGrCD9MauDSLWzQYondo4+VA2eZBUHMhnYYa+ubT2BlLCZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uM6C8lc5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uM6C8lc5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8FE7C4CECF;
	Tue, 19 Nov 2024 17:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732038677;
	bh=S4zzwsIK5279pRaw9TZlm/mOaVhuIkKloynQm8HQ0BE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uM6C8lc5+HetScVxHC/bIV15h0tAfHMQLcyl3QCWszSV/89oaFG9sB2afq6cnaSjI
	 UQk7UeBxUKj1a9Z4N+etU5AAVaYmQYsKhfnRfSYzlYElQAg30DGhTGyKQJVNyxw61Z
	 NWFfYS9cV4aa6m+ZTJ1ggyEekhkb57nL27aPukI8wLm8G8DWlGB7kDDNKx2EMqTmNm
	 lPmYQyBKsA0FxVtqyxiUcc9zal9Hhqa7SA+hAQU/bGMClA1nmCn+za65OdjFv5btOM
	 yEQ22cy/BzPxpwqcYDq78lM2LKp+7vfBVORRFXcgpFe0BoKt88+hly5HoUjcSSAA3M
	 5PiorsuecVpoQ==
Date: Tue, 19 Nov 2024 14:51:13 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Matthias Schwarzott <zzam@gentoo.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>, dwarves@vger.kernel.org
Subject: Re: [PATCH 4/5] tests default_vmlinux_btf: Cover the no args
 segfault too
Message-ID: <ZzzQEdPoMDoGjI5z@x1>
References: <20241118204146.772762-1-acme@kernel.org>
 <20241118204146.772762-5-acme@kernel.org>
 <20f6d8af-5c4e-4eb4-925e-7a6b10efcb55@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20f6d8af-5c4e-4eb4-925e-7a6b10efcb55@oracle.com>

On Tue, Nov 19, 2024 at 04:45:42PM +0000, Alan Maguire wrote:
> On 18/11/2024 20:41, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> >   root@x1:/home/acme/git/pahole# pahole --running_kernel_vmlinux
> >   pahole: couldn't find a vmlinux that matches the running kernel
> >   HINT: Maybe you're inside a container or missing a debuginfo package?
> >   root@x1:/home/acme/git/pahole# tests/default_vmlinux_btf.sh
> >   Default BTF on a system without BTF: FAILED
> >   root@x1:/home/acme/git/pahole# pahole
> >   Segmentation fault (core dumped)
> >   root@x1:/home/acme/git/pahole#
> > 
> > Now to fix this one as well.
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

Thanks, added to the cset,

- Arnaldo
