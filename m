Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6356D13E03E
	for <dwarves@vger.kernel.org>; Tue, 19 Nov 2024 19:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732045750; cv=none; b=O27l81S4Ii7iiFOACX5rMDPvKRx1L469UJ130jRZsH3H/9fxKleiukIotka+2CBbHw/+j4evEgk8n+obJgAtGIg61ATUUAV+/mFAA3uSqWWK1jJhJKxWsj+Ma8Kf+2o2ELI/01HKYAiaM8qI+RWNOzN5RvZyRohn2UH69ObbGQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732045750; c=relaxed/simple;
	bh=TwyD7poXLrbF2zUID5qwYyHJFG6J75/23jfab1XHT/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uq4zBe+GTRaC7Qtc8w5WYJtS2/hCkMWLEiOaZyDL/0TqYBhDUpkn3ykdjGS37yBIZaoEOCsZdy3VAkliNA6qutIFPkUTFK5iOTYcPi8GGPBMFgonT6dk6RCdl7KACFxxBCoaYM5eceoWP9G2FdsRGRQ0SLbiD1agzFR5Re7kUtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRyyLvlx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRyyLvlx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B697C4CED1;
	Tue, 19 Nov 2024 19:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732045750;
	bh=TwyD7poXLrbF2zUID5qwYyHJFG6J75/23jfab1XHT/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fRyyLvlx2ywQ7Gy44qKRnEnjza+IM+Vw0Xhhs2f4c5q44FkinHyDwsyrSliC/B6Wp
	 jA6QsmFGS1T42+Ca+zM3gny9x/WjZTTWM3gMlD1oM6D4BYgF3eiangnsjMm8hv0BtD
	 WC2kvIyCHUugaSWj7sXJM3TCJEe94C8bZEXyBxvLX1HY9KSyBgyRLxniK3FZZ3aJ2q
	 447MNj5eDbC0HCE8C8n+MnpyQpQfIpK4T0yoO3S9p+0f47h4dG2zpXyqkoqhqdd3oW
	 +NKc/T/mJXuMYFZJKybLHm/D0d/Rvoi/IA+dtvbKhJmfzehewgBABY7ZUhWXefCQsL
	 7VYaFakZFOvKA==
Date: Tue, 19 Nov 2024 16:49:04 -0300
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
Message-ID: <ZzzrsLQCF9hYtT7P@x1>
References: <20241118204146.772762-1-acme@kernel.org>
 <20241118204146.772762-3-acme@kernel.org>
 <33b85d2c1adafb5a46a874dfcfd43682395e1564.camel@gmail.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33b85d2c1adafb5a46a874dfcfd43682395e1564.camel@gmail.com>

On Tue, Nov 19, 2024 at 10:35:35AM -0800, Eduard Zingerman wrote:
> On Mon, 2024-11-18 at 17:41 -0300, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > On a system without any debugging info or when one specifies BTF as the
> > only BTF info desired but no BTF is available (or invalidated using
> > PAHOLE_VMLINUX_BTF_FILENAME to an invalid/non-existent file), we're
> > getting a segfault:
> > 
> >   root@x1:/home/acme/git/pahole# export PAHOLE_VMLINUX_BTF_FILENAME=non-existent
> >   root@x1:/home/acme/git/pahole# pahole --running_kernel_vmlinux
> >   pahole: couldn't find a vmlinux that matches the running kernel
> >   HINT: Maybe you're inside a container or missing a debuginfo package?
> >   root@x1:/home/acme/git/pahole# pahole
> >   Segmentation fault (core dumped)
> >   root@x1:/home/acme/git/pahole#
> > 
> > So add a test that checks for that before we fix it:
> > 
> >   root@x1:/home/acme/git/pahole# tests/default_vmlinux_btf.sh
> >   Default BTF on a system without BTF: FAILED
> >   root@x1:/home/acme/git/pahole#
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
> Lgtm.
> Would it make sense to move this patch to the end of the series?
> In case someone does a bisect and runs the tests to find some regression.

Humm?

So you think it should be introduced only when it passes? I.e. when the
problem is fixed?

My practice so far has been to reproduce the problem manually, write a
test, show that it detects the problem, fix, then show that the
regression test shows that the problem is not present anymore.

I see your point about a bisection when running in the cset that
introduces the test case and in all before the fix is added will fail,
confusing the bisector or not allowing it to be automated :-\

So, yeah, probably, for automated bisection we should move it to after
the fix, when finishing the devel cycle, which is now, will do.

If someone disagrees, please holer.

- Arnaldo
