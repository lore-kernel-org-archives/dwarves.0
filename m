Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0811D2B04
	for <dwarves@vger.kernel.org>; Tue, 19 Nov 2024 20:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732047164; cv=none; b=gOHIZgl3x+pmT7rYKdiNbi/mCwOjpkrGfpzsj7GsPqF+SOfq1lY/tZnc5jOu8VP5eIcBkgU4Eo9D9lTO5Q0mCwqETZBV8c64g7PUs6mpW+CgDMv9zNKeQIpUmM5/Tgq6+p2RqdSWK0KrDJS1DyQ9/MKB+4QIuXHsi5swpWhIFzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732047164; c=relaxed/simple;
	bh=36eDFjeXBkt4e0D07aHqdkYVD+7hIgLXzWY1T1HWp1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ATnq+JicsMB8xMUXRBFnQQLRg6u3LaIG+J6CQi34YP1gYFuGVSV80ZdWt0vJOsSi5suWaYs1MflraxUNqTZLGUgs8/9zLL9LdktdnC5TFZSAJCzEFHIKb5q30/ZTvs5Prl4rDEal0lOCiizUbQYk0OKzzlQ1KkBJpjiEEqs7njE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ME9SPggA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ME9SPggA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2A1C4CECF;
	Tue, 19 Nov 2024 20:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732047163;
	bh=36eDFjeXBkt4e0D07aHqdkYVD+7hIgLXzWY1T1HWp1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ME9SPggAlse6dWhi5KYuW8UvDxczhZZ3XrLOVndhIookTtssngRoVrD6thEH8XYIK
	 ejou4wuB4cUydZHMvYxmICT7rS3/7Ge7P8jaEzR9xaas5WYjIVb2DUK1hPZav739Jc
	 EIt2gdwpnAlT7QU5DgTFtAo8RxWrZobEDBaJc3LHqw9PR/3NqkGZSl8kVMMi6+ge8z
	 Rtj6TUbYUr2B4j+d45DRPN9SvLiQFvihanpqzm6WqQrMyABGMxi40uIyfioyVvHnr2
	 AxYhT4PbAOPcsKUZmR6MPFUzNiaXSRcEPYLGvgBpHRh6kVvIet/h7VrB5GIlWhKK2Q
	 0VjxbXnFcvxlQ==
Date: Tue, 19 Nov 2024 17:12:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Matthias Schwarzott <zzam@gentoo.org>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>, dwarves@vger.kernel.org
Subject: Re: [PATCH 2/5] tests default_vmlinux_btf: Introduce test for using
 BTF by default
Message-ID: <ZzzxNrJ51E2dIAGJ@x1>
References: <20241118204146.772762-1-acme@kernel.org>
 <20241118204146.772762-3-acme@kernel.org>
 <33b85d2c1adafb5a46a874dfcfd43682395e1564.camel@gmail.com>
 <ZzzrsLQCF9hYtT7P@x1>
 <020ec6550eb5e73bb5a273c57a686565a0a274df.camel@gmail.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <020ec6550eb5e73bb5a273c57a686565a0a274df.camel@gmail.com>

On Tue, Nov 19, 2024 at 11:54:12AM -0800, Eduard Zingerman wrote:
> On Tue, 2024-11-19 at 16:49 -0300, Arnaldo Carvalho de Melo wrote:
> 
> [...]
> 
> > > Lgtm.

And I'm taking the lgtm as an Acked-by, maybe a Reviewed-by?

- Arnaldo

> > > Would it make sense to move this patch to the end of the series?
> > > In case someone does a bisect and runs the tests to find some regression.
> > 
> > Humm?
> > 
> > So you think it should be introduced only when it passes? I.e. when the
> > problem is fixed?
> 
> Right.
> 
> > My practice so far has been to reproduce the problem manually, write a
> > test, show that it detects the problem, fix, then show that the
> > regression test shows that the problem is not present anymore.
> 
> Yes, the downside would be that anyone trying out the fix would
> need to do some rebase to try the test w/o fix.
> 
> > I see your point about a bisection when running in the cset that
> > introduces the test case and in all before the fix is added will fail,
> > confusing the bisector or not allowing it to be automated :-\
> > 
> > So, yeah, probably, for automated bisection we should move it to after
> > the fix, when finishing the devel cycle, which is now, will do.
> 
> Fwiw, that's what folks enforce for bpf selftests ¯\_(ツ)_/¯.
