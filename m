Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5799288C08
	for <dwarves@vger.kernel.org>; Thu, 28 May 2026 13:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779976737; cv=none; b=FVyI+LZIaJOfU1C3ZGzJqM/BIXYb15h0oJN5PV+YNE8NJvzTjKDBUUFXeK0eRXO5Si1uIEfDnPPcIkR1GNmATUIjhD9ngd13dQRl6GZYFtBFAbhNy/2RH1D4kTPxPR4oBtF84b79wdzNnNfY5TufW9oimRxPUt6PlDPvGJJsgbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779976737; c=relaxed/simple;
	bh=66OVJUkXmb/VOAnjSc7fkpxkMoTROSLR0Afa5dlIBVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHUmzIUyH8TDfTSC0T/MDOKfE0fPP5/lRfAi/yUUaRJ9tVwHXPs2n5ZgH/QzJiE8OYNvuw2wMq0qwveV/W0OZ/laz3PgTptHpDvPgguIiyaQT2KPoBtSM1Fzowa4L2LKu22VUVLoLkQQnMRb6dqJdJcwR8d/WxpR4YP9gS0Rjdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5660368BEB; Thu, 28 May 2026 15:58:52 +0200 (CEST)
Date: Thu, 28 May 2026 15:58:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org
Subject: Re: pahole treats embedded structures a holes
Message-ID: <20260528135852.GA30243@lst.de>
References: <20260528051152.GA27820@lst.de> <ahhFlsCJzkxLt3M6@x1>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahhFlsCJzkxLt3M6@x1>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, May 28, 2026 at 10:39:34AM -0300, Arnaldo Carvalho de Melo wrote:
> > struct rhash_head is a single pointer, so 8 bytes on x86-64, and
> > xfs_daddr_t is also a 64-bit type, so both the 0 size and the 8
> > byte hole are clearly wrong.  The kernel .config is attached in case
> > it matter.
> 
> Starting from using the BTF info, that becomes available thru sysfs as
> soon as we load the xfs kernel module:

This works fine on my installed distro kernel as well.  But this is
for test builds which are only going to run in a VM.  I don't really
care about DWARF vs BTF, but I do care about not having to run the
kernel :)

Note that I'm also seeing this for other code than XFS, e.g. the nvme
driver or block layer code.

> Now I'll try with a fresh kernel build, with a default fedora kernel
> config, will take a while, but having access to a separate .o file from
> the kernel build process, with just DWARF info is what we need to get to
> the state you're in, that should work, lets see why you're getting the
> unsatisfactory results you're getting, maybe we need further info about
> compiler versions, etc, but lets see...

gcc (Debian 15.2.0-17) 15.2.0

