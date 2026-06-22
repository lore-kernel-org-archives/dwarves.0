Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D20D3438B2;
	Mon, 22 Jun 2026 20:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782160235; cv=none; b=uExE5w3x/db0ysl3/Fk4ogaqKkbPRJB/fpFEOmafNUQV70ZHCJArnt/OTXW2Xh3GFWaZkHv/6MDxXZLF5uuc0BI47sE7epoPjigvjVtS5kgnkQ2mE66khVdc3iZSlJBa6w5ovFmVAdMC+00wOoRH/WwU/ZSD9ZFJ4oaOzPfaGKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782160235; c=relaxed/simple;
	bh=IHlbI66jDZhkbQWDSvvk2u2OXpIrbOPDKZpFmo6ndfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1DP0P4rDWvGH+r8PEz6dWVpl3KUymhD6A/7Vs9pDhY7IfLK/3k9XNz9EtPBI4ipp4eb/C8U9uCfOGzGgB1eFgjjdP6nvmk2YYsIiFGKmqsC7fimdtxffjAo4b++bmF2CKSmHFRm6UJtvLcXxT87hcHQifP3ILHYz5bFBHB1du8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lI5u/nwz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lI5u/nwz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED4F1F000E9;
	Mon, 22 Jun 2026 20:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782160234;
	bh=WyDX1mI+bTZguEBOOYYMiI7Yx7J/bbYBgXJYTE7nbyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lI5u/nwzjiKcq4iI8tsChDz7tCaR+mlUvO6DmFLRF3ExhMYl0vrZ/Dk7uTsdeA4oH
	 czrYh6E7DJEoMraRQozU6oSzHvmHXDawnAVCrsqUdEkCIRt+RZ7raRtdvPdQNXFAyq
	 pQ2ER8oYtX0MgTPPlS4hgtd7xgDs0TkcQ7+nKzgCIp9NGMiPiALbKWu/Ziv3bxKrID
	 gEUMhDShrbs6hoaRqsTWHnslQjcJ8L5N4XZgHAHgJFxUqP1bHGFxNpIG+qW0xIGJsD
	 pgxU3RUikG2tAFWsRjdDc7I0gCWOlumCzB9WDRelrcXFmQEd7kukJMA+6/Zjst39Im
	 uvFtYlwlRkLOg==
Date: Mon, 22 Jun 2026 17:30:30 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Alan Maguire <alan.maguire@oracle.com>, sashiko@lists.linux.dev,
	dwarves@vger.kernel.org
Subject: Re: Sashiko reviews for pahole: missing custom_remotes
Message-ID: <ajmbZlAU17yPbOft@x1>
References: <ajWY48GyZXw0aMDx@x1>
 <02DBCD93-1189-4EFE-875D-25B22EF1657A@linux.dev>
 <ajmYLrz2qbUoRx8k@x1>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajmYLrz2qbUoRx8k@x1>

On Mon, Jun 22, 2026 at 05:16:46PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Jun 22, 2026 at 12:18:10PM -0700, Roman Gushchin wrote:
> > Sashiko is not really officially supporting a non-kernel code yet. It might work occasionally,
> > but I can’t guarantee anything and results might be pathetic.
 
> I'm using it locally with great results, using:
 
> acme@number:~/git/sashiko$ cat Settings.toml | grep -B1 -A3 'dwarves\|pahole'
> [mailing_lists]
> track = ["linux-kernel", "dwarves"]
 
> [nntp]
> server = "nntp.lore.kernel.org"
> --
> [[git.custom_remotes]]
> name = "pahole"
> url = "git://git.kernel.org/pub/scm/devel/pahole/pahole.git"
> check_all_branches = false
> only_branches = ["next", "master"]
 
> acme@number:~/git/sashiko$
 
> Submitting series to sashiko with:
 
> $ sashiko-cli submit FIRST_SHA^..LAST_SHA --repo /home/acme/git/pahole
 
> With great results, for instance:

> > We might explore adding support for more project going forward, but we’re not there yet.
 
> Your call, but just as a data point, its being useful for me for pahole
> development and I bet other pahole developers would like having it
> enabled, since it seems to be useful with the current sashiko codebase.

This series:

https://lore.kernel.org/all/20260622202441.14799-1-acme@kernel.org/

For instance, has several bugs addressed from review comments by
Sashiko, that is credited:

commit bf5e28c65bc52e61361a676acc9d2913b6d9e065
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Fri Jun 19 11:34:02 2026 -0300

    tests: Guard cleanup() against empty outdir to prevent rm /*

    If make_tmpdir() fails, outdir is empty.  The cleanup() function
    executes rm ${outdir}/* which expands to rm /* when outdir is unset or
    empty — potentially deleting the entire root filesystem.

    Add a guard to check that outdir is non-empty and points to an existing
    directory before attempting removal.

    Fixes: 52dbfb0b39595ed8 ("pahole: Refactor selftests")
    Reported-by: Sashiko:gemini-3-1-pro-preview # Running on a local machine
    Assisted-by: Claude:claude-opus-4-6
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
   
Cheers,

- Arnald


