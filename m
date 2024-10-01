Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813941C6F7E
	for <dwarves@vger.kernel.org>; Tue,  1 Oct 2024 14:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727793477; cv=none; b=UQP1fpB3JLLXmaI2zjvPUU3zk3FOxcD5G4mRta1y09u4YPhAp2b1lZ1tEUvuluGOBG5ZvdnBH7FKNW8r1fBaC2WWxCyfEzC8FUr9zU0W/w1uPHW5kO9zvxuCDJeP0srEnJw5Nx7oeDT0z3TVyOrtcid1e1nGAdA6hGw4q1EyRXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727793477; c=relaxed/simple;
	bh=YdLVF9NC66uvRM83Wz29pOthQz+xGW6jygywJ0T3PgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVkOcJfDL3ywrJaslRl5y97lbICEcg7Q9zGrxun78HOwyze9gAMQ4jgxxym/4h+sIU9z4kqhxvYo+EmARtAs8HLH85zLmrDNYJEQ5EhmCy4JQ6obfq6rnTHvPi8Aq7YK9sW9McZdqduuxwAz6KxVpyEWFIRLlB3jtj560Fji194=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXstVatG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXstVatG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591A0C4CEC6;
	Tue,  1 Oct 2024 14:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727793477;
	bh=YdLVF9NC66uvRM83Wz29pOthQz+xGW6jygywJ0T3PgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MXstVatGiK5Dv+9OF7x8jcaT8rWf6b/ZYvXUkT1BMZ4sNQA77CdqxqK9BX5LN1BXM
	 DJ+CY5NZZKpbfU5CaO4UqErvLgdYTkM1oG2o2xZQb8OFgZWiTCOPxtOgW4XqP/OhBO
	 ZwD2R4xbsiVhoEmnOoYj3aICyotuqpxJ6OpMdGdUHQUGZOBShcSq489rZ9Ans12q7F
	 vCZH7HFzNA+sVEtKoY8xOiJG9sDw+r0LPZo4nuUFlBLqYm1WZLngXaVl5hPNcQ/Q4X
	 6OULcQ6mc3kjrD8opctEWsssdDwKA7Y7WZk1zbkypI62aJnisdXc2ELcm8nd48s6LG
	 nPzKzHLjnxh8Q==
Date: Tue, 1 Oct 2024 11:37:51 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: dwarves@vger.kernel.org
Subject: Re: [PATCH dwarves 0/4] tests: unify behaviour, pass through fail
Message-ID: <ZvwJP_795_qiP9hk@x1>
References: <20241001114629.3947401-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001114629.3947401-1-alan.maguire@oracle.com>

On Tue, Oct 01, 2024 at 12:46:25PM +0100, Alan Maguire wrote:
> The "tests" script has recently been added to support running tests;
> unify behaviour across all tests to
> 
> 1. return 2 for cases where the test has to be skipped (versus 1
>    for an actual failure)
> 2. for tests that require vmlinux, allow it to be speficied via
>    environment variable; this allows the tests script to be run
>    with a specific vmlinux not discoverable via pahole
> 
> Patches 1-3 handle updating individual tests; patch 4 ensures that
> if we hit a failure, the tests script will return 1 to indicate
> that a test failed.
> 
> Alan Maguire (4):
>   tests/reproducible_builds: support envvar-specified vmlinux
>   tests/btf_functions: return 2 to indicate test had to be skipped
>   tests/reproducible_build: return 2 (skipped) if no vmlinux available
>   tests: distinguish between failed/skipped tests

Thanks, applied.

- Arnaldo
