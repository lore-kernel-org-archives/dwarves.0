Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B12C368D55;
	Fri, 31 Jul 2026 20:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785529288; cv=none; b=eIQnscl/2aqLIC8wDxj4ViHuLkJ7qETEXMS2i44h8+M/QH1zAyCG5GXWTibb0xDs/V6If94FxTr20E28LYYkSNy7m6ygprhTmT7J1thJJGFzm6wSvRBI+exURAzDPvKlUxUEpI+fMXOSEh5ECCNMLBJ4HEKagaW6i3bm3ZuSMsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785529288; c=relaxed/simple;
	bh=YnwOpWh3IV5WG8GLYjQ47rOt2YLfjf2IdxIOC9htOi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQ6jAySOA+uwFhaYAPH9+OhN8uxnQbFHDczd9JNDW5uc4Lm3SGbge8TgWuJbsjxaScLZPq4u/f1Hc4bi6Pp6AJERGGxC0tDDEL+9kpV1AOmGPXlchlYNNUk2rccNPWYSsADNzFi4SaexF3dmlN+y9ghCXaM2aKSsdzif3ImRzKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dz4v4B/z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dz4v4B/z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424371F00AC4;
	Fri, 31 Jul 2026 20:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785529286;
	bh=Krt9qO7IkakN23XsJcgn7LamhLp+6IkdgetXngOcMJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dz4v4B/zUM5+1TvCr0z+0u1X5vhAv7vp8+qQeRoKaP/WemHQiuDA7VvebwN9lzMyr
	 Lb7A7f+YNe+jUQ/umZaq36U/UGf6tDG5H8BjE3C09CUBRhSdaYWNcLyva5x5hsjSX+
	 AYz4Woxj8cmFssjqxnUgCEskYU8R0WKkUt4Mlm+GaH8jGs+G5qZfD93g9u+YzGY3n7
	 LY90H4zI5UM16GnduB6Z5R7x3ctUVQ5KBV+ATD0/d1zF8jLl9uQqbUNlmBKOki7fLJ
	 K8Bs4aOUo5FQjd3yPgy74aunsxYFquLfBcfrn2YCDj0/xdQVkJCz4ZHwXxlTBDL1Qi
	 BIw0GlohfXWRQ==
Date: Fri, 31 Jul 2026 17:21:24 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org, bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCHES 00/31] pahole: Bug fixes and small improvements
Message-ID: <am0DxB4WdMdU_31j@x1>
References: <20260729190733.72876-1-acme@kernel.org>
 <e4926c40-9788-4f3f-991f-6833ade41000@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4926c40-9788-4f3f-991f-6833ade41000@oracle.com>

On Fri, Jul 31, 2026 at 01:52:40PM +0100, Alan Maguire wrote:
> On 29/07/2026 20:07, Arnaldo Carvalho de Melo wrote:
> > 	Here are 31 patches fixing pre-existing bugs found via coverage
> > analysis, AI-assisted review (sashiko), and manual testing. No new
> > features.

> > Critical kernel build path fix:
> >   Multi-dimensional arrays (e.g. int[2][3]) were incorrectly collapsed
> >   into flat arrays (int[6]) in BTF encoding. The encoder wrote only
> >   the total element count; the loader read only the first dimension.
> >   Both now preserve the full dimension chain using chained
> >   BTF_KIND_ARRAY nodes, matching bpftool and kernel verifier format.
> > 
> >   Before: pahole -F btf showed int a[3][4] as int a[12]
> >   After:  int a[2][3][4] encodes as three chained BTF_KIND_ARRAY nodes
> >           and round-trips correctly

<SNIP>
 
> Series applied, thanks!

Thanks a lot!

I just submitted the next batch, 12 patches with support for more Rust
tags and for alternate debug files/dwz, both are needed to make the
pretty printing of perf.data contents test to work without warnings,
this also supports building the kernel with almost all DWARF modes
(DWARF5, compression, etc), which should speed up kernel builds that
want BTF.

This first bugfixes series also removed the serialization when elfutils
is built thread safe, so should further speed up kernel builds.

There is a new script that compares the BTF generation (and thus DWARF
loading) for all these modes, everything produces the same end result.

I have these extra branches that will be submitted when this last one
submitted lands:

acme@number:~/git/pahole$ git branch | grep topic
  topic/build-infra
  topic/cli-fixes
  topic/coverage
  topic/cpp-templates
  topic/ctracer
  topic/test-infra
acme@number:~/git/pahole$

Cheers,

- Arnaldo
