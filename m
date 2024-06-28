Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E3F1E89A
	for <dwarves@vger.kernel.org>; Fri, 28 Jun 2024 13:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719583199; cv=none; b=NmHrpSjClph+kIlW9mvDqCZbM5vqFnJ5YGPc5us12kDnF4c997rWPRiSitVsflnYypn+3qhm2DO2HnvkqD1dDK3yqIc+BZ2SxXeb94ixGpv5iefUthr5lysR4dXtdlB1ruDsQwjaVe8NK4Q08IY66l1l6A0pWl9Gb5C6oh6NBCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719583199; c=relaxed/simple;
	bh=AblTWyQZR/zMRMY20qVwANorSZmfB04jlY51ZFWR/RI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+M7jch4dZo0MFszxlZONBQQka7BYKNB5jGSI1MqU6RDtoD41mPtW+119ZAauNEMR+2355rCdOAdV5lAsid3lV5JkALsUozmKI/86ie8RDvRUIwiyGzXqqBfUlR8S0uZJNLKXMGPzmAfDQvuhZbaakL1k91IPPc/F8+NXxIKTdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5/IKUyK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5/IKUyK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D54C2BBFC;
	Fri, 28 Jun 2024 13:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719583199;
	bh=AblTWyQZR/zMRMY20qVwANorSZmfB04jlY51ZFWR/RI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G5/IKUyKhUOUfoU5jHS8mvnazn1tN3kBG0Lotnw6GidHqab1b86EbY8q5toGYsY32
	 iDb/BW1ztYgN9hJYI05EqfR9bX19YWbIpwVcuJnO41LaJ3Kw7/2JtWtgFm9cap2cjn
	 Jl8DOfVMQT01et6w+8zHVOh7LHFNuAURCpX3ucA5t0BFHbI35BkJRVkzadlnFLY2tl
	 puOCbqOmfHtgr8GQqNt8RmNr5LeOKk1Qptw88x/yNyvOtZPxKA/oSjNv1gil6TNCVI
	 5KTahy7H8xCt2huRuwjjmpgDyzOJ6MMIG65FCooSXCjK1iADo5jtOEwuJEH1p+DO2j
	 baDlsNw9tXU3A==
Date: Fri, 28 Jun 2024 10:59:54 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Dominique Martinet <asmadeus@codewreck.org>, andrii.nakryiko@gmail.com,
	dwarves@vger.kernel.org, jolsa@kernel.org, williams@redhat.com,
	kcarcia@redhat.com, dxu@dxuuu.xyz, eddyz87@gmail.com
Subject: Re: [PATCH dwarves] pahole: enable --reproducible_build when
 SOURCE_DATE_EPOCH is set
Message-ID: <Zn7B2ioa62DC_SAK@x1>
References: <20240626032253.3406460-1-asmadeus@codewreck.org>
 <c1414fb5-f7a8-4cb4-9c27-9c0c9b431f28@oracle.com>
 <ZnydwHhgCbUbkm44@codewreck.org>
 <fc0bff28-eb41-401b-95d4-49fd4b72e5c7@oracle.com>
 <1213004a-c75a-4882-bd51-47d458c67e04@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1213004a-c75a-4882-bd51-47d458c67e04@oracle.com>

On Fri, Jun 28, 2024 at 09:31:17AM +0100, Alan Maguire wrote:
> On 27/06/2024 18:25, Alan Maguire wrote:
> > On 27/06/2024 00:01, Dominique Martinet wrote:
> >> Alan Maguire wrote on Wed, Jun 26, 2024 at 03:29:37PM +0100:
> >>> On 26/06/2024 04:22, Dominique Martinet wrote:
> >>>> The SOURCE_DATE_EPOCH environment variable is used in reproducible
> >>>> builds to set build timestamps and is generally synonymous with
> >>>> reproducible builds: instead of making users figure out how to pass
> >>>> pahole flags (e.g. explicitly setting PAHOLE_FLAGS in linux) just assume
> >>>> that the user wants a reproducible build if this variable is set.

> >>> From the kernel perspective it looks like as a result of [1]
> >>> [1] https://patchwork.kernel.org/project/linux-kbuild/patch/1443741332.2730.75.camel@decadent.org.ukOB/
> >>> the setting of SOURCE_DATE_EPOCH will be converted into
> >>> KBUILD_BUILD_TIMESTAMP; I thought the plan was to add the
> >>> BTF feature flag explicitly if KBUILD_BUILD_TIMESTAMP was set?

> >> Hmm, that patch (2015) never got in apparently?...
> >> And I don't see anythiing that'd make pahole output reproducible if
> >> either variables are set in the kernel either right now; we still build
> > 
> > I can send a patch for this to bpf-next if it's needed. But it'd be good
> > to figure out the right approach first, more below...
> > 
> >> plenty of older kernels so even if such a patch gets in I'd rather this
> >> is checked in pahole than kbuild.

> > I'm not sure that's the right answer though - there's a bunch of
> > existing infrastructure in the kernel tree that relies on
> > KBUILD_BUILD_TIMESTAMP, so to integrate properly with the existing
> > kbuild infrastructure around reproducible builds feels like the right
> > direction to me. It's a bit more work, but not too much. Arnaldo may
> > disagree of course, and he's the maintainer so it's his decision - this
> > is just my personal take.
> > 
> > We've tried to explicitly enable flags in pahole Makefile.btf so that
> > it's obvious from pahole invocations which features are wanted, and to
> > get that support on older kernels it would just be a matter of
> > backporting the
> > 
> > if > 1.26
> > 	use --btf_features
> > 
> > ...patch, and a patch for adding the reproducible build option to stable
> > kernels. Similar has been done in the past for other pahole features.
> > 
> > All that's needed here for bpf-next tree is I think is the below 3-line
> > addition:
> > 
> > diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> > index b75f09f3f424..40bb72662967 100644
> > --- a/scripts/Makefile.btf
> > +++ b/scripts/Makefile.btf
> > @@ -21,6 +21,10 @@ else
> >  # Switch to using --btf_features for v1.26 and later.
> >  pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j
> > --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs
> > 
> > +ifneq ($(KBUILD_BUILD_TIMESTAMP),)
> > +pahole-flags-$(call test-ge, $(pahole-ver), 126) +=
> > --btf_features=reproducible_build
> > +endif
> > +
> >  ifneq ($(KBUILD_EXTMOD),)
> >  module-pahole-flags-$(call test-ge, $(pahole-ver), 126) +=
> > --btf_features=distilled_base
> >  endif
> > 
> > 
> > Can you test at your end if that does the right thing? Thanks!
> 
> FWIW I verified that with the above change, and
> 
> export KBUILD_BUILD_TIMESTAMP=$(date -I)
> 
> ...the feature flag is added to pahole and as a result we get
> reproducible BTF in vmlinux; .btf.vmlinux.bin.o is identical across
> multiple kernel builds.

This sounds reasonable, pahole doesn't have to look at something so
specific for a particular use case (the kernel) while using what pahole
would look (KBUILD_BUILD_TIMESTAMP) but in the kernel build scripts,
that in turn uses the prefered, self-documenting way of asking for some
specific BTF feature (--btf_features).

- Arnaldo
