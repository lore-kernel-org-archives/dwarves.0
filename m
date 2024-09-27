Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45891C1AC4
	for <dwarves@vger.kernel.org>; Fri, 27 Sep 2024 19:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727465983; cv=none; b=YF4vNCM23yrAi6A/XvTzx+LQyVLMrOTzJXMFQWD9GE5hLch3wK4coaTDgviUm7AlQYYc2G8cPoMZfuFhsxZrBZjdcgHfEB39SZF2nVDcpIAcwv4eYIhozLjUttjyU7yPipisjeJcF6cLAJq6sQstxyUvW2qilssuo2lkGbK1s9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727465983; c=relaxed/simple;
	bh=rqbZWXB12kAvhCbn4qFAQDp1GAMLb5iB/JQMa0W5BWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxLqBfYWF6N+zLFAQYAsye2o8oiGl9iZVlk58aV2KDQKdWjo2+NC1QKwGa5Q56x+e+AHTX8W4XgYzFNtEn7/dafE5j7Lk2cBAWjtG2V9yRNWcfDjBn2jUjlZdGykKeJiHuI1OOh0q9427n8bcsSWfyUFKPyWw95OL1ZVVnHKq4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTJ2ngno; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTJ2ngno"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E948AC4CEC4;
	Fri, 27 Sep 2024 19:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727465981;
	bh=rqbZWXB12kAvhCbn4qFAQDp1GAMLb5iB/JQMa0W5BWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jTJ2ngnoNEq1uqBW6e7fhvEJSvi5cfRx44CukS+CF4alxMhZ9zpgLoSCAH6T/ZKHB
	 4irWySot7dLin0SCEm6b+yQ/UcvDKLsvZ2khpUEgJb448WQBL1ZZ5ptU6gz+WyMyv5
	 U81IU+zIBn2uIb39u+w7EoWH+NMA1Y1NUnxXW6HsI/HmOvPBBcfvKYYkxeedlL3fRK
	 nBJmhKIOR8tb25m76uyFABSbyHvBzXzYOYD77fHTWKOL8bwSSP/B4bZm1Mzg7HOifD
	 PuR9ddneMStx2vKr5yu8MqXEyLZgweDkSEkVh13//Udbq4bjaFtmcCJrfhn1LZ5LbP
	 2EUJmCa4C65lA==
Date: Fri, 27 Sep 2024 16:39:37 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Willy Tarreau <w@1wt.eu>, dwarves@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH 0/2] --padding option to combine with
 --with_flexible_array
Message-ID: <ZvcJ-REjrrUfImcZ@x1>
References: <20240927185958.37310-1-acme@kernel.org>
 <b1bbd9c1-d9f7-4305-b107-f4dc3f9827a9@embeddedor.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1bbd9c1-d9f7-4305-b107-f4dc3f9827a9@embeddedor.com>

On Fri, Sep 27, 2024 at 09:22:46PM +0200, Gustavo A. R. Silva wrote:
> On 27/09/24 20:59, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > Hi,
> > 
> > 	This implements --padding, that combined with the already
> > available --with_flexible_array option may catch some questionable
> > structs.
> > 
> > 	This comes from a quick discussion I had with Willy Tareau after
> > Gustavo's talk at this year's Kernel Recipes.
> 
> Nice. :)
> 
> I think it'd be interesting to take a look at the output of the
> following command:
> 
> $ pahole --padding_ge 1 --with_flexible_array

acme@x1:~$ pahole --padding_ge 1 --with_flexible_array > pahole--padding_ge_1_--with_flexible_array.`uname -r`.txt
acme@x1:~$ ls -lart pahole--padding_ge_1_--with_flexible_array.6.10.10-200.fc40.x86_64.txt 
-rw-r--r--. 1 acme acme 172848 Sep 27 16:36 pahole--padding_ge_1_--with_flexible_array.6.10.10-200.fc40.x86_64.txt
acme@x1:~$ 

It is at http://vger.kernel.org/~acme/pahole--padding_ge_1_--with_flexible_array.6.10.10-200.fc40.x86_64.txt
 
> Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!

- Arnaldo
