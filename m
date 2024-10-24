Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BEA136A
	for <dwarves@vger.kernel.org>; Thu, 24 Oct 2024 13:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729777550; cv=none; b=FrlMA+imL5XG3xBdQV5m4ea5CjdmJ6ErVmS6FDh5lQDPO5fmt0MFV8jtSXvugjFvLJPaWbna3HPrsC8y89yVljPUKyeChs/NEW5znJGfM6JtHo8bS6ilkKCFerrn8XedLi5jzyWq9rmdMy6TRrWLue8uBGon0F0XP09GxbisTU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729777550; c=relaxed/simple;
	bh=vBVHwwAmzbBMFXEAFq80lQb/AOqt4euIz4jMF5sTHeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/rkpZb7mDZZcz7DaWiV2Dz46rZYLMGHwSjL2EZWKCLOMJ/rW1NibShjcDUMenw+xnka5EGH1X1gPcc3nYSTLrBqQ4/u6OZn1c+D5Cy4eQ4tF26CjHRGctwQIGtf7Zbuvx9eliOppAnrN7yxNXjEoL+yCw+YamKnmP1clEVSfv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxYZNBLP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxYZNBLP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B06C4CECC;
	Thu, 24 Oct 2024 13:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729777549;
	bh=vBVHwwAmzbBMFXEAFq80lQb/AOqt4euIz4jMF5sTHeA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kxYZNBLPW0DsY3q/GFUQPhUqWjVB1rGF2Zzhkz9HCa0GyLOFYHKKKperOwfcgWcF3
	 QVrePWmGlI0yuRaoviT1ZU60KAilo4EDGHCwE9TN0LuaZuThgYU85qd3g3CMIqCj5e
	 IhAGVctgyljer9g/muiWDQJsCd51WJNj/cJwDg2UKYOhw8MXJIFF4Bl0LVdQUs/Nx+
	 DVM2Dk5jLl3Kk8LZwRKSp9W27dfaAfCeIkgZjlbmOM7T8+C1SG1SLB2XjR6naA1/Ct
	 3whg3XPaTXZVma3nUKaU9P6Tt+fl5eqpgzw8XRJolcqlZZBJ2lvt2pyxozrm9WwZcB
	 C50CyStcFIDSw==
Date: Thu, 24 Oct 2024 10:45:44 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Subject: Re: [PATCH dwarves 1/2] tests/flexible_arrays: redirect stderr to
 avoid warnings
Message-ID: <ZxpPiOgly-lbDT5L@x1>
References: <20241024112615.750704-1-alan.maguire@oracle.com>
 <20241024112615.750704-2-alan.maguire@oracle.com>
 <CA+JHD923mvOrr9JoKeVkeB1k2PTGSHsi7=6HPrV4tVNF1R=GWA@mail.gmail.com>
 <74f2a4bd-27c9-4f5b-963f-2d1a492c9eec@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74f2a4bd-27c9-4f5b-963f-2d1a492c9eec@oracle.com>

On Thu, Oct 24, 2024 at 02:01:21PM +0100, Alan Maguire wrote:
> On 24/10/2024 13:13, Arnaldo Carvalho de Melo wrote:
> > 
> > On Thu, Oct 24, 2024, 8:26 AM Alan Maguire <alan.maguire@oracle.com
> > <mailto:alan.maguire@oracle.com>> wrote:
> > 
> >     With recent kernel, saw
> > 
> >       2: Flexible arrays accounting: WARNING: still unsuported
> >     BTF_KIND_DECL_TAG(bpf_fastcall) for bpf_cast_to_kern_ctx already
> >     with attribute (bpf_kfunc), ignoring
> >     WARNING: still unsuported BTF_KIND_DECL_TAG(bpf_fastcall) for
> >     bpf_rdonly_cast already with attribute (bpf_kfunc), ignoring
> >     Ok
> > 
> >     Redirect pahole output to avoid seeing the stderr messaging.
> > 
> > 
> > 
> > This is something I kinda expect from these tests, now I want to get
> > hold of such a vmlinux to understand what's needed to address the warning. 
> >  
> > Maybe have a quiet mode for testing just what's supported in a released
> > version when tested by packagers?
> > 
> > Maybe not, as knowing that they have a kernel with a feature unsupported
> > by pahole may be important and should elicit measures to either get a
> > newer version of pahole or disable a still experimental feature in their
> > kernel? 
> > 
> > WDYT?
> > 
> 
> Good point on the visibility of warnings being useful. We have VERBOSE
> already so it seems like having QUIET (implying stderr > /dev/null)
> would be easiest to add at this stage rather than having to add multiple
> levels to VERBOSE. Maybe QUIET isn't even needed though as the above is
> still clearly a test pass, and the messaging doesn't interfere with test
> success.
> 
> Probably best to drop this one for now anyway..

That is what I did, agreed.

I adapted the second one to this fact and applied it, thanks!

- Arnaldo

> > 
> > 
> >     Signed-off -by: Alan Maguire <alan.maguire@oracle.com
> >     <mailto:alan.maguire@oracle.com>>
> >     ---
> >      tests/flexible_arrays.sh | 2 +-
> >      1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> >     diff --git a/tests/flexible_arrays.sh b/tests/flexible_arrays.sh
> >     index 7c21253..e9e3cb0 100755
> >     --- a/tests/flexible_arrays.sh
> >     +++ b/tests/flexible_arrays.sh
> >     @@ -20,7 +20,7 @@ pretty=$(mktemp /tmp/flexible_arrays.data.sh
> >     <http://flexible_arrays.data.sh>.XXXXXX.c)
> > 
> >      echo -n "Flexible arrays accounting: "
> > 
> >     -for struct in $(pahole -F btf --sizes --
> >     with_embedded_flexible_array $vmlinux | cut -f1) ; do
> >     +for struct in $(pahole -F btf --sizes --
> >     with_embedded_flexible_array $vmlinux 2>/dev/null| cut -f1) ; do
> >             pahole $struct > $pretty
> > 
> >             # We need to check for just one tab before the comment as
> >     when expanding unnamed
> >     -- 
> >     2.43.5
> > 
