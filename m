Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B5D1553A3
	for <dwarves@vger.kernel.org>; Mon, 26 Aug 2024 14:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724683933; cv=none; b=lr67kUUTPMOKb/efwYuGwGtN/VgKO0+ec777AYPOghRm5XPNI64lBKoSXEdKFZoiSAzBsSpD8NL5trxr/8Sd5PbyYjxOqUu8awUXIyASrWgo5mCdBRVCQOOuKvs5dVReoL8wOhjZK1MZiwuj2MewJWEYgQjaT92tuTbM5uy9jys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724683933; c=relaxed/simple;
	bh=bI8E+UPYJ/ft0+7FCSKp7pdX/LJ65D2hBq+sadBd98s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQZ904ah2DaWQRlrM4k5jOYPUHO4AYELbD0pieqAUYQhtZoyqShG4jPHKR6lLAJ7RCjL0KKw4ApIbWTt+3bh5X/I5vQYezUTXigzu7SfXV7Pf+NLNce6KpikKziYAgl504B7l5IgOTj5daXmHoD0VoRJlIa1+ibz/f4S5MerKfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ib2G675N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ib2G675N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2435C52FC9;
	Mon, 26 Aug 2024 14:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724683933;
	bh=bI8E+UPYJ/ft0+7FCSKp7pdX/LJ65D2hBq+sadBd98s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ib2G675N+DdeJtg46FpsHNQavSvLWCdbcoZUa93Bz1tihR/CCFNfL6cg/N92GnV1f
	 IMdXJKL2RFzsBt9KXvqjOOdjxIKTqiqxUL301nQI5etJ6DpeiQtsn/k0mEc9RiWuAO
	 QTP7OZJZ+ygTyPlRE/avEcA4uQ5NjIogzeQctw5yqc1umkFEPLKMZxQP1Qp8vtu02i
	 Tt3km9GIuX1kU0dUMVTQXoM1AWVv8+ttmjS61+1XgSMKKG1lFRVvziVHUUvMJnhAyu
	 Yw3pp+ST5F8FfDTqhTXEsIeWAAHJ13n6LlW87ajBz5iQdBbknlV5wU+Ks6urwpj0Ng
	 w0Ejaqiu8gOhQ==
Date: Mon, 26 Aug 2024 11:52:09 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Will Hawkins <hawkinsw@obs.cr>
Cc: dwarves@vger.kernel.org
Subject: Re: [PATCH 0/1] btf_loader support for subprogram linkage
Message-ID: <ZsyWmWL7n4QbE1mp@x1>
References: <20240823212835.1078351-1-hawkinsw@obs.cr>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823212835.1078351-1-hawkinsw@obs.cr>

On Fri, Aug 23, 2024 at 05:28:30PM -0400, Will Hawkins wrote:
> First, 
> 
> I am a huge fan of pahole (and friends). I volunteered to work on
> helping to edit the BTF spec for the IETF and so I've started to look
> more deeply at BTF and the tools. 
> 
> Second, I hope that what I am offering is being sent to the right place
> and is in the right format. I tried to follow what seems to be the
> "right thing" by looking at mailing list archives.
> 
> This patch add supports to the btf_loader for subprogram (BTF_KIND_FUNC)
> linkages. For example,
> 
> ```
> $ cat a.c
> static int x() {
>   return 5;
> }
> $ gcc -gbtf -g -O0 -c a.c 
> $ ~/code/pahole/build/pfunct -Fbtf --compile a.o
> int x(void) /* linkage=static */
> {
> 	return 0;
> }
> ```

So, I'm changing this to become:

  $ ~/code/pahole/build/pfunct -Fbtf --compile a.o
  static int x(void)
  {
  	return 0;
  }

As --compile is supposed to generate compileable code that is as much as
possible from the type information similar to the original code, ok?

Thanks!

- Arnaldo
 
> Sincerely,
> Will
> 
> Will Hawkins (1):
>   btf_loader: Support linkages for BTF subprograms
> 
>  btf_loader.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> -- 
> 2.45.2
> 
> 
