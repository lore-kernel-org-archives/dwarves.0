Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DDB225390
	for <dwarves@vger.kernel.org>; Wed, 16 Apr 2025 19:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744832088; cv=none; b=rY5MYopMGdScjoXAt2iUUm/32A1Vv+IUOTvnseSTyY8RZV7Miu+Wjdq+Qp6qnpWJ/fe5eDsh4JxlgP+ebzdI/4Ec/lVgXjuofJwkiLhVJAOxzWjDlFI6E+IeGtLPZLbaIqiRLLuQGP8dsXxGpIHZjXnUzCtwGWmtZTSq7GR6ZX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744832088; c=relaxed/simple;
	bh=A9bijqbqojc3tSMInh9gdKNDEZ3rj2AJ04dXIVge4ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzvnltNJiYGes771GF1RrAiuFBO1FYGkpgHzvb88Agxt0crG2E6zR0uwhTaTTOVMqb+iQEw/BF7JpzeaSimhunG4PU+xv3pybA993Q6vWKHX6leKSEKDBGjriz7xKrUkZDMPusegVkE+mmTm48i7K3bc7AOzZGekGtZ1anSpEKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kteQIbv7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kteQIbv7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE3CC4CEE2;
	Wed, 16 Apr 2025 19:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744832088;
	bh=A9bijqbqojc3tSMInh9gdKNDEZ3rj2AJ04dXIVge4ek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kteQIbv7aeJOZ9YAzbl9RFB+QjsCjXmJDg1Xeb1x3DvB63zH93UWhxSbuh74ScvLx
	 bgBMgyWYUkiehbnvN8B5iR6GebJFbWjowYDToV4alVWKnHBkBb8I1HqLfdIYSR/fym
	 /HHMBg5WyBQPy5aWW0BUpS3dh30gace7PgF6X2A9fbdgm69N6/SK7eE6johYDXilBH
	 m14R9zJBFoWLfZrfzdtJ8CGM4VggU8/DDV2fUeXZE77eLGwasozXbvTeEbazrvHFBR
	 ZA3jZmqjOoWhAjXf1W9KIxP1PKDLkpWEQXrEf+bqf28yqPpwofL7QULhYWH4bTzUp2
	 1Lk8HpqEy1VIw==
Date: Wed, 16 Apr 2025 16:34:45 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Domenico Andreoli <domenico.andreoli@linux.com>,
	dwarves@vger.kernel.org
Subject: Re: Is 1.30 released?
Message-ID: <aAAGVRUbj6_4YEWr@x1>
References: <Z_4mPCCLXBCakppE@localhost>
 <aae20053-ce1e-4fa3-8c73-1f1a702d123c@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aae20053-ce1e-4fa3-8c73-1f1a702d123c@oracle.com>

On Wed, Apr 16, 2025 at 08:51:59AM +0100, Alan Maguire wrote:
> On 15/04/2025 10:26, Domenico Andreoli wrote:
> > Hello,
> > 
> > I see from [0] that v1.30 has been tagged but I missed the announcement.
> > Additionally [1] does not show an updated (& signed) tarball.
> > 
> > Is everything in order here?
> >
> 
> Arnaldo got some late reports of build failures when we were finalizing
> the release; we're awaiting more data to determine what's happening.

You mean this report:

https://github.com/acmel/dwarves/issues/63

It is not something new, they say they started seeing the problem when
switching from 1.25 to 1.26, so not related to what is in 1.30.

And I _think_ this is just a correlation, the cause seems to be a change
in how they link software, they have LTO enabled, etc.

I did some analysis and updated that github issue.

Or are you talking about some other case?

If this is the case I think we can go ahead with releasing 1.30.

- Arnaldo
