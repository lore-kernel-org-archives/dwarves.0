Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B904AE113
	for <dwarves@vger.kernel.org>; Thu,  3 Sep 2026 13:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442665; cv=none; b=sDMSZdKb+1cKhwkFUNfPUaGCAMgMxUQyrKHdGPVlYQJ2PNPKsdPzsg/crjxvBPazYeddENFw2PGo2IQTTIc9612Prgjp9HZbJStEXY0TFdIrDscTh6E1/FOI5+6FGOjBjvZ4vGEDVTek7fMG2fsVsGmqMJZ5hI+eXGm2/q9ZxxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442665; c=relaxed/simple;
	bh=h8UzVl/fwKYAnR6lhAhVGAfEBG0DbuAxYtdBf5PlTJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwG5DydwLps3gd7psTV3rfwl2wnKXhJhhBfgoi4i42UTp43z3QtoYC0Bf+OYuOaMfS8fEkZpsA3hfusnqI3CZ+YjQUVRy9K0tGIegRji0axHeeZ8Wgud7qeQfDUQ4w8KM3crUq35eomH9T2ZsEWPe/vNUxhUs07w7a/z8evFMj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tw7eFqH3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tw7eFqH3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ABDB1F00A3A;
	Thu,  3 Sep 2026 13:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788442660;
	bh=Exealxa4RaKsnvpzXW/vlxuwW4bUQTLtsWZKdsaQkxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Tw7eFqH36+Fmks8ZOAfb6KIBe00caFZSPzbmLFF3u6ia9R+6+PgfJBt9ki+r9VB9Y
	 JsWXUeulyLZGZpp/BsvruyB88fRsCeTcaH4knOpx0kf/2HuE+pMY1dSmTaExeMC9fR
	 qOQ0Mr/RuGi+x8fL5it4/NocajpNd402pqeFgLgqIzNFceR+VZQjkdjPBZcFe5ngeI
	 +PKH/OQwq7mypwb8zJH6c3ecugF215UzT8e3DL/C+Fvi/9K2EPOuwJRL4RAm5qDcXD
	 10gSlLHUIq59Xv6QSQKo9p18gEg0Z6vbc6kEcTjjGiLJGgu7V7v819pruvgP4AWJyl
	 SZJhsqQcsdTGA==
Date: Thu, 3 Sep 2026 10:37:37 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Aditya Dutt <duttaditya18@gmail.com>
Cc: dwarves@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH dwarves v2 0/3] pahole: Fix --unions bypassing the
 struct-only options
Message-ID: <apl4IUAlbwnXwIre@x2>
References: <cover.1788368236.git.duttaditya18@gmail.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1788368236.git.duttaditya18@gmail.com>

On Wed, Sep 02, 2026 at 05:05:55PM +0000, Aditya Dutt wrote:
> Split into three independent patches as you asked, so any of them can be
> picked up or dropped on its own:
> 
>   1/3 --unions --packable segfault fix with the Fixes: tag
>   2/3 add flexible array options, to the struct only check
>   3/3 stop ignoring the struct-only filters.
> 
> v1: https://lore.kernel.org/dwarves/20260831185641.971022-1-duttaditya18@gmail.com/
> 
> Holes and padding in the structs inside a union can be found with
> 'pahole -a -A.' Details are in my reply on the v1 thread.
> 
> Would a '--recursive' modifier make sense? The hole and padding filters
> don't look inside member structs currently. Optionally with a depth like
> '--recursive=2'.

I think --recursive-limit, longer, but conveys that this is a limit, not
a request for some specific recursiveness.

Thanks, applied!

- Arnaldo

