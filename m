Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC7119C57F
	for <dwarves@vger.kernel.org>; Thu,  3 Oct 2024 14:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727967416; cv=none; b=PEczi9c6pL8y7rM1rYZFSjX/oHJv775k6zfHpYCb4fvL1G+E9PGjdCKrKTVjq6V1a8Xeq3w/lZNpnYZOFTskSxb0kqZQcpBeI5+ViCQUMub4Cwzv+hby1aI/EJgZj+elZlakVXI07k6Rxmw0NjSclcHC4YdkrovOA/rdZQZBs94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727967416; c=relaxed/simple;
	bh=PvDryq6+HeflIqRfy4N7b/diOzLfayrcER56tfepNq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpHm6KxEG/e2AWOZnGcgRc57vhpmxECoHZERnOJ8d9Kk6b8YiJQAYaxi/l3/ZJX+u3FMmzoyZBYKGcSef4y5VtQbsmklNmHTXf2RmNwhJd6l7GuPMcl+0hWIuFNehcAnP9VyiFzcK1VTmQrkGRNqxRaShvdPcQisYNyn8qFRlPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHyK4cWV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHyK4cWV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18956C4CEC5;
	Thu,  3 Oct 2024 14:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727967416;
	bh=PvDryq6+HeflIqRfy4N7b/diOzLfayrcER56tfepNq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KHyK4cWVwtJmhakv+wcVMsWpBRvBruLl1WszwwnETeBpoy6lHVh0+rFjiq8OfXdeG
	 CXawnfijAAPVcq64giTI0bY8ZU2/5+/ToNa8I7bF58SzPznAVyPwQrIJUo7EI5SNqN
	 NHd/ZAY9JnI6rO4RH8IbR70d6wlBaBGfhc4SHg8/lAHcBpHQNetTqPMLqAorMFMkaX
	 DOasRexahDPtcD85IO9xt9fW4+BE91HNCjLLHIRO3Lpj3Ot2qdRtKP8nTSlcKJHdIm
	 d+Eq3gWs2bu1ExrngqF2zLkcwKmyJh5DcoMnLQsahE2r+jqXfoOY5iz03e4cikMLgH
	 xdNKGLIAjx3cw==
Date: Thu, 3 Oct 2024 11:56:53 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: dwarves@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH dwarves 2/2] tests/btf_functions: reduce verbosity of test
Message-ID: <Zv6wtQHQvmt5PbOy@x1>
References: <20241002113326.792495-1-alan.maguire@oracle.com>
 <20241002113326.792495-3-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002113326.792495-3-alan.maguire@oracle.com>

On Wed, Oct 02, 2024 at 12:33:26PM +0100, Alan Maguire wrote:
> when in non-verbose mode, emit a single line describing test + result.
> 
> Non-verbose output now looks like this:
> 
>   1: Validation of BTF encoding of functions; this may take some time: Ok

Thanks, looks great now!

I added this to the commit log message so that we see how a full
tests/tests runs looks like:

Committer testing:

  acme@x1:~/git/pahole$ time tests/tests
    1: Validation of BTF encoding of functions; this may take some time: Ok
    2: Pretty printing of files using DWARF type information: Ok
    3: Parallel reproducible DWARF Loading/Serial BTF encoding: Ok
  /home/acme/git/pahole
 
  real  10m54.784s
  user  9m43.335s
  sys   5m14.034s
  acme@x1:~/git/pahole$ grep -m1 "model name" /proc/cpuinfo
  model name    : 13th Gen Intel(R) Core(TM) i7-1365U
  acme@x1:~/git/pahole$

Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
