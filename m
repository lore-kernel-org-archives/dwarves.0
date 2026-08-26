Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681DE218E91
	for <dwarves@vger.kernel.org>; Wed, 26 Aug 2026 00:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787705566; cv=none; b=Sy1SNERLSRspIaOGpMU+86gMLmZQLncFbdvvFkihf8KBco0hBso9ir4Smaor5oo0u06oFj5I6uws69xjaCp78dxnb1blyNvDvmsUxzE3WtiKRyCFDkshmRs3Kxd73Cl+8eNGMiYaHdQnOSsqp6WzADS3zhNu3HKKvir9ICH05U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787705566; c=relaxed/simple;
	bh=CEhrI4Z4zTl1V7UwnuC/45qSySqkn0BHPOLh0UMmZSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjbWA8lOKb4RgTG7kJuD6BYE8jHFRZ8bYY6o/xM6ZAwBgDDTwB5Eo9PI9VIArLZ19cDSI1cTVm0UP05WFVuSzl4xgMPSdhGcyBlTAjnvABxFLbuP6bo7V9hImficzV8RBb7sn8ikUJP0wENizqxVdHrNc1GoyNEgfSVr2ZHnNkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xi1TzDSd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xi1TzDSd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C03F1F000E9;
	Wed, 26 Aug 2026 00:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787705565;
	bh=EuvARVbHpKNExv2kYUXCkJXnPjbu9sTVAhmfdJCHeWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Xi1TzDSdRXssgGpp8+w6MMjLCBKwJI8v/Uk9vI0I3Kir+/vntXXEIz0aXubOMihaG
	 tarPD9Qsl82+UAtRajhZ6Seye9EzTeTkabmI/tJvGGHZVfQHjlOUvrUS8B8LCY9Lld
	 +8n6QwKCKLndR5hmnfrUyH4veLm49tntyOOCkG6O6ioqeikj83TSOeeW/PHy2l56+x
	 zgtac7BYeqmWGBiELK7I7P7et7cS2B3xoNIkURr2IqIRdMJDOxW8axqlDVLF6/Jjr6
	 Z5tVEk31PUK0PVNo78z3vTQZFamcRRYnHOcHY83s1fHZ/QQnGocNLtUO49L7jL/Rpy
	 WS031y0VbnfBw==
Date: Tue, 25 Aug 2026 21:52:42 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v2 0/9] pahole: Support cross-CU type references and dwz
 alternate debug files
Message-ID: <ao442rldWrCNG3zC@x2>
References: <20260821213510.22423-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821213510.22423-1-acme@kernel.org>

On Fri, Aug 21, 2026 at 06:34:59PM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Add support for cross-CU type references and dwz alternate debug
> files so pahole can process binaries (e.g. a perf binary with rust
> objects, or Firefox) that use DW_FORM_ref_addr inter-CU references or
> dwz-compressed .dwz alternate debug files.
> 
> Cross-CU type references:
> 
>   Force-merge CUs that contain inter-CU references (DW_FORM_ref_addr)
>   so type lookups resolve correctly.  Handle same-file partial units
>   where types are shared across CUs via DW_TAG_imported_unit.  Fix
>   cus__merging_cu failing to detect DW_FORM_ref_addr when
>   DW_FORM_implicit_const causes dwarf_getabbrevattr() to fail.

I did a lot of test runs, and with the patches that are waiting for this
series to be landed that stress even more this series, so I'll merge
this tomorrow unless anybody have anything against it.

And then as a followup I'll land a series of test patches that don't
affect the functioning of these tools, just do coverage analysis and add
lots more tests for its features.

We need to release a new version as there are people asking for features
developed and not yet released, so I'll make sure we get the goodies in
and the release out ASAP,

Best regards,

- Arnaldo
