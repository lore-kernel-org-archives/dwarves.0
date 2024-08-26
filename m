Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3C71714C3
	for <dwarves@vger.kernel.org>; Mon, 26 Aug 2024 14:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724684036; cv=none; b=JpSNPiQH9AVwOWI4ahePtw7+3zr3ZIXkRi4E9BO6ezaN6JQxMXlUgQ6HDeQ4KCh7rJdX2TJB+5rLLTH0G7uAV9DLi2nJ1mRTzUYFETr+bxqzi8HRNbvGNmLh0cLWzpJyRQgIgMW/gq6kto9oiFq9Gu359EGGBBATLm2aK1mSTQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724684036; c=relaxed/simple;
	bh=O2HdBB49qeR96amRsoITSzDnO7jo7VCnuuTcth7tgt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfIQ7q37ow5t32izaIxNHpAVnPmamUGiZRCMvWC1kspcbI9D0DzD18m8zrHmPjeBrXi62nmDKteCdWOmrRe0+83TdJGm+ceGuRUnMKMFVjyeYz3XAYcIjJfMFZCLNDbtmH3K2tuJDjVNsY/+XXfYvzlO4nuZkEfoLUC3LJx7FIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWbVInug; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWbVInug"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D489C4AF52;
	Mon, 26 Aug 2024 14:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724684035;
	bh=O2HdBB49qeR96amRsoITSzDnO7jo7VCnuuTcth7tgt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hWbVInugXDn9wcWM3gGuOl/CEif18NFwkNc0iiIUGXudnwHUw36SkDb4oSbPS25fv
	 0p+/Jkbwpo5v1cXqwLT2UUxeTmQ3QWWMk6nNdjQ9nHw0bRLQyy7B1RT//wCh2a44Dk
	 eeZZLimS5qhQNXUQXh0CuOjnWXKAHxCnYpcr3b54NS8r7PAw+4KYo+A8xohjcGqtTs
	 dnC4S/L9f+BWSoJzU8u83Ai7bdJZoJF4NLPa1cYioJzbVyWw7XE2ubmVcsN0spejfu
	 9g/UT91xD8x1h9Bquk+PubGJVngNpfT/h72WzLJJ+6mzMkZKWXoho8DX8wsORuty0B
	 iZPGQqvWgVKkw==
Date: Mon, 26 Aug 2024 11:53:53 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Will Hawkins <hawkinsw@obs.cr>
Cc: dwarves@vger.kernel.org
Subject: Re: [PATCH 0/1] btf_loader support for subprogram linkage
Message-ID: <ZsyXAcCv8sBwxLH1@x1>
References: <20240823212835.1078351-1-hawkinsw@obs.cr>
 <ZsyWmWL7n4QbE1mp@x1>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsyWmWL7n4QbE1mp@x1>

On Mon, Aug 26, 2024 at 11:52:13AM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Aug 23, 2024 at 05:28:30PM -0400, Will Hawkins wrote:
> > First, 
> > 
> > I am a huge fan of pahole (and friends). I volunteered to work on
> > helping to edit the BTF spec for the IETF and so I've started to look
> > more deeply at BTF and the tools. 
> > 
> > Second, I hope that what I am offering is being sent to the right place
> > and is in the right format. I tried to follow what seems to be the
> > "right thing" by looking at mailing list archives.
> > 
> > This patch add supports to the btf_loader for subprogram (BTF_KIND_FUNC)
> > linkages. For example,
> > 
> > ```
> > $ cat a.c
> > static int x() {
> >   return 5;
> > }
> > $ gcc -gbtf -g -O0 -c a.c 
> > $ ~/code/pahole/build/pfunct -Fbtf --compile a.o
> > int x(void) /* linkage=static */
> > {
> > 	return 0;
> > }
> > ```
> 
> So, I'm changing this to become:
> 
>   $ ~/code/pahole/build/pfunct -Fbtf --compile a.o
>   static int x(void)
>   {
>   	return 0;
>   }
> 
> As --compile is supposed to generate compileable code that is as much as
> possible from the type information similar to the original code, ok?

I see, your patch isn't the one adding that linkage comment, you're just
collecting it from BTF, I'll then add a followup patch to get to the
output I described.

- Arnaldo
