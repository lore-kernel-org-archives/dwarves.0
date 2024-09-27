Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F50814D43D
	for <dwarves@vger.kernel.org>; Fri, 27 Sep 2024 21:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727472437; cv=none; b=BoGklfoiIM0Jqmen4zGYUyiNN6tZWIDWiSyX6AylOcI4lrndoGwYb/oDjTLQv92KiZtvXytAwn3B3pWVHMd3QJYCwLCRntRX/UH+4XsCEuYmEWdYP//i05Yt363dMiVCacG+jaGFonP+D6Fnnu45HNw+EGY5g2ol6BfyKuq9TsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727472437; c=relaxed/simple;
	bh=5pVH9HgZ2pjPY3ZEV0fO42CXJJhH1Spqj7fXUio+fys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2nPDEvdrjIanHq5Rvh5JcO39RBVs/QT9e78md6wjEiM1A7gzysUKs7sWbp1idsl7wxs9AHteWx8EAmLkPwIS+QPAcHyIVG02/vIdSbNx9o5eVmd0Kjvu0pTUtMgC02O7VEs5TvKrotofm7rR2U4Z7IaRt85dCX/9tlJ9SEJ604=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 48RLF33x004044;
	Fri, 27 Sep 2024 23:15:03 +0200
Date: Fri, 27 Sep 2024 23:15:03 +0200
From: Willy Tarreau <w@1wt.eu>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>,
        Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH 0/2] --padding option to combine with
 --with_flexible_array
Message-ID: <20240927211503.GA4031@1wt.eu>
References: <20240927185958.37310-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927185958.37310-1-acme@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Arnaldo!

On Fri, Sep 27, 2024 at 03:59:56PM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Hi,
> 
> 	This implements --padding, that combined with the already
> available --with_flexible_array option may catch some questionable
> structs.
> 
> 	This comes from a quick discussion I had with Willy Tareau after
> Gustavo's talk at this year's Kernel Recipes.
> 
> 	I have this in the 'next' branch of:
> 
> https://git.kernel.org/pub/scm/devel/pahole/pahole.git
> 
> 	Willy, is that what you had in mind?

Oh that was fast!

I'm looking at the output here:

   http://oldvger.kernel.org/~acme/pahole--padding_ge_1_--with_flexible_array.6.10.10-200.fc40.x86_64.txt

I'm seeing in the output above that mem_cgroup was reported due to 48
bytes padding being caused by extra alignment. I'm not sure what to
think about it to be honest, there could be pros and cons. However it's
true that if this struct is embedded inside another one, it starts to
smell nevertheless, and such a case is not much frequent so it should
be a low rate of false positives in the worst case.

The output is clearly reviewable by hand, that's really cool!

I have not checked the code yet, but based on the result that's definitely
an ack for me!

Acked-by: Willy Tarreau <w@1wt.eu>

Thank you!
Willy
