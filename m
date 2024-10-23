Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF45E1BFE05
	for <dwarves@vger.kernel.org>; Wed, 23 Oct 2024 14:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693503; cv=none; b=Z313lAaJdNEBGMU/YmR5qCKa0ZARse8gesHrJAXmgyJmTaiq3Sqyom02Mt0aNQwgAwqXAZwlp2W8N9Mk2XuLRVQdBZfP+8Qnd9kQqa2StxqYa7LV/8D8gaPpkULvMjGzLEbE6T1wlyWIPAvFJC/v4UgKugfuDWAJCuxkhRo6As8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693503; c=relaxed/simple;
	bh=ww1xpzx7UVXgBIVa5h8wG1r9/JmebYP6yWi4p6K2Yag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJNuIbIOmyUvPwZS9S3n+QKneyRdpG3f5MJ6A0PemwnHkdBNcRIE2Ve9qs7vDcML3U3ZYR/UQ9sd+LATnMeQ5KVeb2bzXwFjQbwUiXOm8A2WmlaDYKlrORiQP8L9Ri/xMquhzJDN38rYamIqyeMf33MCzQKIczoG5ZWxruP8/Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLwpdz1c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLwpdz1c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD022C4CEEB;
	Wed, 23 Oct 2024 14:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693503;
	bh=ww1xpzx7UVXgBIVa5h8wG1r9/JmebYP6yWi4p6K2Yag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GLwpdz1c0U5ZcqfGXViycqBsxQxQu6n7lSvX5J/8FOijw8Qx8+lFzsXv6C0nBENlQ
	 +wh3kDaWJd3AGwJ3wf6UIRSMcDaJzyH3rSfEW+3/gSXFvndJhKBkMq/mUokDxxXHWb
	 wd2RUECYRxphawLRPHld6/xyj/xFTszV5R/VKhHkuWz2vw/Bm5dMA2pHe3MFh4F09A
	 icEdZhfcGt4kI5aq0hPLCEdA8wBxVvnThxvoyJsKjujSDaw8leBVAfiRd07AtTwy1c
	 KyrnLH+OzxeZwtc5gV56Xx6T657DDG/Bk2i0wGLr6rvUCJ2ur/IWpK3sRWxydjipK7
	 Ce+z+VGhGOzLA==
Date: Wed, 23 Oct 2024 11:24:59 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, ojeda@kernel.org,
	andrii.nakryiko@gmail.com, jolsa@kernel.org,
	dwarves@vger.kernel.org
Subject: Re: [PATCH dwarves] btf_encoder: filter var names before btf name
 check
Message-ID: <ZxkHOybaXSWYo6Mq@x1>
References: <20241018094301.1550149-1-alan.maguire@oracle.com>
 <87v7xjrdei.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v7xjrdei.fsf@oracle.com>

On Tue, Oct 22, 2024 at 03:17:09PM -0700, Stephen Brennan wrote:
> Alan Maguire <alan.maguire@oracle.com> writes:
> > ...as this means we avoid seeing multiple messages of the form

> > PAHOLE: Warning: Found invalid variable name when encoding btf, ignored (sym: '__UNIQUE_ID___addressable__RNvXsa_NtCs2vSfyxKMEZc_4core4charNtB5_11EscapeDebugNtNtNtNtB7_4iter6traits10exact_size17ExactSizeIterator3len57').
> 
> a beautiful variable name :P

A unique one :-)
 
> > Such symbols are filtered anyway due to the __UNIQUE_ID prefix, so
> > warning about them is not necessary; simply reordering the checks
> > should ensure we will not see these warnings.

> > Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

> Sorry I'm late to review. This is a good catch and is clearly correct
> to me.

Thanks, since it hasn't moved to master, I'm adding it.
 
> Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>

- Arnaldo
