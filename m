Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E6A23D2
	for <dwarves@vger.kernel.org>; Mon, 30 Sep 2024 14:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727706884; cv=none; b=F+yLzzliDpgQXw0BWAo1RISx17J+vdouAgGrXF2pZtYq/Dw0yaLvbxrWuT4/rz2m58r614X1zNn3XPfeI98dJrS/P/OZrGyUyJFn1d/MfKH1tSR6eQaHqnCqCxZLGp+xI6XknhynZGHhyjtaE7V4G4O6D34t8nt4ifK1cPxo4+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727706884; c=relaxed/simple;
	bh=4gJIjEsfSjg1evgGLlfcPO3fyJGdKIL0dG6yEdd2PAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6LJYWPJqJIr4x7Lgu/Evjur5fIOIxMFAmg2vVkspPPZDdUW9MlcXpk+6tH0LKjTJeww1/yeCTmv+a9a1nGsBmf+vt94NytrOaCl1KlitgoVQ+uGWhWonZBHCAer2bBIget90QxJPZpQjto9gNcbO3yZpv+OzJodxX7jdkcYCl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZNj8Biy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZNj8Biy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10FEC4CEC7;
	Mon, 30 Sep 2024 14:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727706884;
	bh=4gJIjEsfSjg1evgGLlfcPO3fyJGdKIL0dG6yEdd2PAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UZNj8Biy1EA4jzTCV8Ma5mrHD4hoxA7DLp14njmDyzk5wCmoY8btwahjAdnrCNpVt
	 jDMi0v+xwc277F/zNzPuaQNcF2YgpaE+54e3AvuvY2YcoA9gCye5b/JpBea4VSnkVQ
	 XmPwZTNRmV16RBfwVdYwoAfc8V6vS8+QvOPMIsK2Z9Rg0lEKySme3uwZust6L9x9pw
	 ajVl50UpIQKqf+yZhV+RWIfhsi140D5pzbU8uDksav2GwiyaJ7YGExzOedFVp1ifFP
	 rfEymkNc/LgE/LRVZVgthi5EsIPSd94i8L7qiUMPf/yWA5CC4OmpMK7+ofQu3euDrc
	 bqcO9L4IGYmkw==
Date: Mon, 30 Sep 2024 11:34:40 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, dwarves@vger.kernel.org,
	eddyz87@gmail.com, shung-hsi.yu@suse.com, jirislaby@kernel.org,
	sedat.dilek@gmail.com, w@1wt.eu
Subject: Re: [PATCH v4 dwarves 0/2] fixes for memory optimized BTF
Message-ID: <Zvq3AKQGHSXfiSIR@x1>
References: <20240930081725.2465825-1-alan.maguire@oracle.com>
 <ZvqJawSN_UVwQdAc@krava>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvqJawSN_UVwQdAc@krava>

On Mon, Sep 30, 2024 at 01:20:11PM +0200, Jiri Olsa wrote:
> On Mon, Sep 30, 2024 at 09:17:23AM +0100, Alan Maguire wrote:
> > This series is identical in effect to [1], it is simply applied
> > on top of the "next" branch which now includes v2 of the series.
> > 
> > Patch 1 fixes issues identified in code review around use of
> > func->state, strncpy issues.
> > 
> > Patch 2 speeds up the btf_functions.sh test by reducing the
> > number of greps/pipes, shaving ~1 minute off execution time.
> > 
> > [1] https://lore.kernel.org/dwarves/20240925091734.1943742-1-alan.maguire@oracle.com/
> > 
> > Changes since v2:
> > 
> > - fixed checks of func->state since it is always non-NULL and removed
> >   now-unneeded fields from dwarves.h; added assertions that either
> >   ELF or DWARF data is present for func encoding (Jiri, patch 1)
> 
> lgtm
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied to next,

- Arnaldo
