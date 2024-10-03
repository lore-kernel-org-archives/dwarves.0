Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EE319E968
	for <dwarves@vger.kernel.org>; Thu,  3 Oct 2024 14:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727966381; cv=none; b=bqxZN8kTPjrgFjFdeaNFL+5inSzPjITFDVV54/d3Wx2DrY+//+1Sf36hR/NoYlUYiMj9Bmnvwcd+RWg1afK+tOXUmJpNp9UNKR2687jG9smZoDpNHoF87NMTrlJU8/zMyV6pAttNKV6EHPEAGI84MSriSHfG7JfvaSHyd4hgzmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727966381; c=relaxed/simple;
	bh=MnJ5o9BEzDdHgMAjEb7GfMd1h7dOWpaTfNAGGs2BwFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eAkopOD8w+Ny1OjCS56KbHBoUAlMDYgBiWsYBrRkqSs2wuzse36fIKcWU/vZPkgw4RjvAjP5WoOVwCq5oPim+91Pf/mLhp0Oc8B+JbGcEJcd8EjfC5qdwdxD7S6LZ73+6/y6kVtloEaseaTaGjLVhGYX5vZEYNocP+nXfCEohi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DROHhKsc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DROHhKsc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F59C4CECE;
	Thu,  3 Oct 2024 14:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727966381;
	bh=MnJ5o9BEzDdHgMAjEb7GfMd1h7dOWpaTfNAGGs2BwFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DROHhKscmu9hRkq7JKw16V0ptsTAN8q6tHQLDN+TrmgVa+Rvn2+063/cM0DAnZNkm
	 TPBhVY7iVxEBQ8xyHKGYjapFKrw9XTuKoFIxpOZYQRVTwe1sYi1MjgP9NSoWMoapps
	 DRkwEkusdFIqJfpmxZ5XxcrwCE/Y82zehfzisSQqK+UMCIhLJty3Sttkpej27btQcc
	 P9K6Gqq77BFOasJupkFGTk3Ft+LkMcNFOxwTAfjPLBZK9o54kU2inTZMO/nXppQ7GK
	 lY24Lfr97Xrz4dlBIa3Ms5yToNr31/bx7zb16I/baiCjOD1/O6nrB4R4TCocoy+nO8
	 onC4ItdtlQ5tQ==
Date: Thu, 3 Oct 2024 11:39:37 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: dwarves@vger.kernel.org
Subject: Re: [PATCH dwarves 0/2] tests: reproducible_build/btf_functions fix
Message-ID: <Zv6sqR-pVTj_nIQI@x1>
References: <20241002113326.792495-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002113326.792495-1-alan.maguire@oracle.com>

On Wed, Oct 02, 2024 at 12:33:24PM +0100, Alan Maguire wrote:
> Patch 1 fixes specification of vmlinux in the reproducible_build test
> to support env var, command line parameter and pahole-based discovery.
> Patch 2 reduces verbosity of btf_functions test.

Thanks, applied.

- Arnaldo
