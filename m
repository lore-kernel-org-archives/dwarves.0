Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AE6187870
	for <dwarves@vger.kernel.org>; Mon, 26 Aug 2024 14:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724684315; cv=none; b=Gnt2snKUc3DX/3KZ00gRce5t52uR8EtvPVjRSiEQRtjlTKqGS/ExvlIqP5Ff3kQbn7tzM2+OEiakSUFhmfWG4fZvv8wSNLRfSR9Snb+elhDtBT7aLhPWckMmjN9y/RYCZmY9aXvD4oovqGiWKXGD9dJ0gAzuXEP+ODvUrNVjre8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724684315; c=relaxed/simple;
	bh=Gn+qdG+E9W5B2FbJzQoG5DtaxlYrawCQC69A2/pCfFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXVnKjxKA3mxMfl0cAfAb1OpETDt6ZNIz6Yh9FS2FJVNOo+HPJd21nkS8CSDgIfNXO8GZi028L9VhWbYxKp82zwMB5WbbvX6GEh1+MOtL5L2HezjjPdFJvp9lmTr5qvaaMTzgLKF+pdHpul0fY9DFhsQwsStzk8RInAl4mpFHX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDnt+vnc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDnt+vnc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BDDEC4FE95;
	Mon, 26 Aug 2024 14:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724684315;
	bh=Gn+qdG+E9W5B2FbJzQoG5DtaxlYrawCQC69A2/pCfFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fDnt+vnc4Q+8+qMKSQhhJ4RbTlQIAH6cnVVslH9PuBSPnj9EgeZU4QgNsCQyNnRkA
	 p/2ZG4LrSNIE/sIC/1YAExPbBHGFHIFRF+o2kDXm3rIe9Uxzuk8N3Mho4lwaYj7nex
	 KQJgGjxyi7f8e8X/H8R8H8LHMYQtdUidF2x1ZGkllNjsp8fmGkc2KguB9gf+xd3mDI
	 5AbHZhy3HskI9paZNnVgrhPlGWpAG0G4sr2SSIR3gHFgWecpcbcTntalpyhPxJYAWC
	 qicrLuf0CaHZdDTn0KV/IAe4ZIMsRzTf0elJoKNzBO0G0avCrAG5qR75jk0SlnEGMk
	 ALoqObKcYPfRA==
Date: Mon, 26 Aug 2024 11:58:32 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Will Hawkins <hawkinsw@obs.cr>
Cc: dwarves@vger.kernel.org
Subject: Re: [PATCH 0/1] btf_loader support for subprogram linkage
Message-ID: <ZsyYGPUEtP5zP3i6@x1>
References: <20240823212835.1078351-1-hawkinsw@obs.cr>
 <ZsyWmWL7n4QbE1mp@x1>
 <ZsyXAcCv8sBwxLH1@x1>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsyXAcCv8sBwxLH1@x1>

On Mon, Aug 26, 2024 at 11:53:56AM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Aug 26, 2024 at 11:52:13AM -0300, Arnaldo Carvalho de Melo wrote:
> > On Fri, Aug 23, 2024 at 05:28:30PM -0400, Will Hawkins wrote:
> > > First, 
> > > 
> > > I am a huge fan of pahole (and friends). I volunteered to work on
> > > helping to edit the BTF spec for the IETF and so I've started to look
> > > more deeply at BTF and the tools. 
> > > 
> > > Second, I hope that what I am offering is being sent to the right place
> > > and is in the right format. I tried to follow what seems to be the
> > > "right thing" by looking at mailing list archives.
> > > 
> > > This patch add supports to the btf_loader for subprogram (BTF_KIND_FUNC)
> > > linkages. For example,
> > > 
> > > ```
> > > $ cat a.c
> > > static int x() {
> > >   return 5;
> > > }
> > > $ gcc -gbtf -g -O0 -c a.c 
> > > $ ~/code/pahole/build/pfunct -Fbtf --compile a.o
> > > int x(void) /* linkage=static */
> > > {
> > > 	return 0;
> > > }
> > > ```
> > 
> > So, I'm changing this to become:
> > 
> >   $ ~/code/pahole/build/pfunct -Fbtf --compile a.o
> >   static int x(void)
> >   {
> >   	return 0;
> >   }
> > 
> > As --compile is supposed to generate compileable code that is as much as
> > possible from the type information similar to the original code, ok?
> 
> I see, your patch isn't the one adding that linkage comment, you're just
> collecting it from BTF, I'll then add a followup patch to get to the
> output I described.

So I'll looked up what that linkage field comes from and:

commit ce516fb0cf2a3d9fc45c2a9c7ab2cf4bd24965a0
Author: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Date:   Sun Jul 8 19:47:26 2007 -0300

    [LIB]: Support DW_AT_MIPS_linkage_name
    
    Another C++ specific case:
    
    -       class TypeTemplate ByName(const string  &, size_t);
    +       class TypeTemplate ByName(const string  &, size_t); /* linkage=_ZN4ROOT6Reflex12TypeTemplate6ByNameERKSsj */
    
    Signed-off-by: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>

So its not really "static" or "stern", but the mangled name in languages
such as C++, so I think this patch needs reworking, there is ambiguity
on the "linkage" term, we should use some other term :-\

- Arnaldo
