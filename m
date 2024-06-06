Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5A86D1A9
	for <dwarves@vger.kernel.org>; Thu,  6 Jun 2024 20:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717704651; cv=none; b=A0CyaN/9tsCrIjRgmuNrdVgvvleP7fhYUHD0lE9Lx9OUdohEM2Nd9RoyfLFXmKBP9b0KImREPJud8cw7pQNxRew+oKAUHMh3h3brHr+YMcV6lqkalUTUVqqaePiK+v33IqfgaSnxlNY1KICnr8X4SDvFoKEFkMCP8Be6zdOtUg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717704651; c=relaxed/simple;
	bh=lBSNUoV1j/53T+ygJOw2tzPnZi9a0vwEIm3cBfKtYAU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=d0BANebHOq/SRdJp19c7GBcrgfBmg1e7z0dc2sw6FkJxl6WGtJ9hlR6wzo4IG5WyI/zYDFf5Yi0Q+OixqRK2fK+KwzRx/WDaMgVyrDUChdzgWAdwuhL7trbCOAtBz0OgHUIkjHJAJFdWxCIp2z5j5XBjwUcYzMLLmdIE12DicgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q757GuIU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q757GuIU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0CD7C2BD10;
	Thu,  6 Jun 2024 20:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717704650;
	bh=lBSNUoV1j/53T+ygJOw2tzPnZi9a0vwEIm3cBfKtYAU=;
	h=Date:From:To:Cc:Subject:From;
	b=Q757GuIUO9GwHE3Kv+8f71mXjg7OUnbi4ES0NWJKDZoX9sxLT0g7RNqMQROO6tBFJ
	 KhtQesCH4oqyNguPHtiguc8oX0CL8OuiAYf7iL9SbE3cxVTwM+0jq9UJLIl539gGpT
	 eClAa+huhfXo+GOZl5Tmj9GFpWozDArZ+VPzetuG/qqLxKsblLoHoeKJ/YIkHZYA3R
	 gcpZcwJEAqZ30rYDLoJt7EAw5S1BXZtFuqXFz3mMFm4amStYOjDuzzUEdqQu9/N2xS
	 v5iQ3InjwSh1/JzUGIoWRUmZp82bj5cpTFFhVGMFrmYb0n7FnHJK4b5lXVtqUfSNPv
	 d9JboKa/kRfZg==
Date: Thu, 6 Jun 2024 17:10:46 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: dwarves@vger.kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Matthias Schwarzott <zzam@gentoo.org>
Subject: RFT: Prepping up pahole 1.27
Message-ID: <ZmIXxgbfIJGWmXer@x1>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

	I just pushed what will be in v1.27 to the 'next' branch at:

https://git.kernel.org/pub/scm/devel/pahole/pahole.git next

	The changes file for what will be in this release, mostly
reproducible builds and tags for kfuncs:

https://git.kernel.org/pub/scm/devel/pahole/pahole.git/tree/changes-v1.27?h=next

	I plan to move it to 'master' and release it later today, so if
anyone could please do some more testing on it, that would be awesome,

Thanks!

- Arnaldo
