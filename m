Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E90D13DB9F
	for <dwarves@vger.kernel.org>; Tue, 19 Nov 2024 17:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732038365; cv=none; b=Ub5+0UCYWS43jAAa3KDCfE5hPWT3LzF1dQvHtdF66YCn+sCqOeCEC5WmjKGgk2O2G6oDMEc24T9q3vxvD96+JIyebZci3Bm2u+57nvBLnbq5ItzDoSTzaQIUSbqGtd+2FbgSiAQLxZi1ll5LY0Y4swHWa+f4wa+jmFbRklBgc/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732038365; c=relaxed/simple;
	bh=p0+iibJaG5EAERqgNmTC65NwkWeIQTl+0YEnqyEaH/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLj9dpNA4XIIIW5qxKslc5/3+lWWzF7jHhBJDRdk66Y7BL9k+6kYVBOWhsxiwjGdTLdyTV4055w7NvK6vP0uoBbRsHjIx7BgBK1ZVGJeNUwrrySmTTkRkKB5T921Cm3fHXGMVTjgO0IFjnbFdLZ15ciHO5HuDKOvQiHo7UYzZwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qTuuYEra; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qTuuYEra"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47968C4CECF;
	Tue, 19 Nov 2024 17:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732038364;
	bh=p0+iibJaG5EAERqgNmTC65NwkWeIQTl+0YEnqyEaH/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qTuuYEraoIPjE0KoFPLQ1ePUHVEhEh1A3B9DCoJVz9la9UheeOAv2CdZxdtWBlNe8
	 dpmuFugc1MVGXevJFPF5E7D+534Yoj4kuMlMaKMm0WtLw1vMas5E6K8HrQJFLCVlqi
	 nO0bYRZ7aBXWAhQYiRcPtZ6mheKNON5Ss+w4+svMj/+2q/Hy3L19GRQ5QiAMG/521V
	 0DhL4KeSzA2sHZxBB9xuJ3JTm8s1NDaEIlV/bYpgpTqrL2+sDhjFjrILoZAit5V8Za
	 RLmSyYm6ge4MJqm3iRhtiboix18DbiCWvvXs4fDLw5qC2rErBNm58G3qkkfKmlm6a1
	 LY150CmTJ91Tg==
Date: Tue, 19 Nov 2024 14:46:00 -0300
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
Message-ID: <ZzzO2KHBrPJk18q0@x1>
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

Thanks, added.

- Arnaldo
