Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB763BBCB
	for <dwarves@vger.kernel.org>; Wed, 28 Feb 2024 12:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709123660; cv=none; b=HbXwjX/DL/GZMoRFBz6vKCoaV4cf2zLgjEtKgNz8pA1g0tOPiXl6VipFGqAhfifBnnE9+3O5j+z6i/vzy9oaREipZRF2CmUKy7aGVqIKXdddomWWIQ8vnTvdJbaqQ8ymL5xsBXDY00bonpoBWbHq514XVsvKoAs9FfkV9zpoYRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709123660; c=relaxed/simple;
	bh=jbyB6HUhImX1YAIwjmBkdCMrrz/pa9m7rYYxkD8uJ3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lur48N+jojLC/pxFJ2/rJZmO30+nkO5jZ8t31cc2tRcOD/hsfYcfBS21e253hnYUV1JwTbfv4BRr8MPNJL3m/FzCGOV9aRswMfpEnXbU1bV7E3kwMeG+dWFsVJ9LdUcnz9Kksn+70mNOz1s4zXXcdjum4ARrHR1KrVzFgVlJHfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxg5U8EV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxg5U8EV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46132C433F1;
	Wed, 28 Feb 2024 12:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709123659;
	bh=jbyB6HUhImX1YAIwjmBkdCMrrz/pa9m7rYYxkD8uJ3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mxg5U8EVGwI6LJE/DWwP4mpQ5bQT6nYOxbdPooBhU4vvpXb6rZaxIP9OUdOFG/gPs
	 n9sis0PmGqTc5BRxeJ83GSGV7tZi6X5Ly0JyNuSwFOCKxqa55s6DhBhclscW7SKXik
	 vWioauYTwl1k1nq79oIOrmh2LWxrqL3L9qVWymUSz/Ikd3FNwQPVkslzxkebIPK3YA
	 8yDtIuOd1JMhtjrfHpq1BevucoapIwbW46l0SqkupiHlHHDr/q55PqaJEv4SDAkUVn
	 /3sedxE+HwDuY0C2YX8Z9vsHTgB9Ci+QGMG4U5XDzKUUMDDpBldlo6p8eDPZYW+FRK
	 5UVrFmI/hUknA==
Date: Wed, 28 Feb 2024 09:34:15 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Viktor Malik <vmalik@redhat.com>, dwarves@vger.kernel.org
Subject: Re: HEADS UP: pahole 1.26 to be released soon
Message-ID: <Zd8oR11yexremMWp@x1>
References: <Zd3cooJ1HgnuC1aV@x1>
 <Zd7vJyjGjzmXW4R0@krava>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zd7vJyjGjzmXW4R0@krava>

On Wed, Feb 28, 2024 at 09:30:31AM +0100, Jiri Olsa wrote:
> On Tue, Feb 27, 2024 at 09:59:14AM -0300, Arnaldo Carvalho de Melo wrote:
> > 	If you have time, please do some tests and report results.
> > 	You can find it in the usual places:
> > git://git.kernel.org/pub/scm/devel/pahole/pahole.git
> > https://github.com/acmel/dwarves.git
> > 	In the master branch.
 
> hi,
> tested on top of my setup and it looks good

Thanks!
 
> I hoped the kfuncs decl tag would get in, but AFAICS there was
> no new version of the patches.. I'll ping Daniel about that

There is this global variables case that is being discussed, the kfuncs
and I hope to do some work on .dwz, merging what I have at:

https://git.kernel.org/pub/scm/devel/pahole/pahole.git/log/?h=alt_dwarf

So I think I'll go ahead and release 1.26 today and work on merging
these other features to have 1.27 in the near future.

- Arnaldo
