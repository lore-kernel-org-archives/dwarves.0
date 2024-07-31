Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2C3288B1;
	Wed, 31 Jul 2024 18:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722449525; cv=none; b=ooDbuuOIwMK1c+OCNLg/7TnoOFo1x7ZjTDaNhj0epMn0r3qcGOcqP++a3sdvthAYkATIb5/1sqEp482uO9zIXwXFgGF8foktZJ0mvcSWYiF6xEz1JxdgwylRaebVdBXJEr45qoGB7ECse99a0+3T6OdtFtc/eeI7EKv/iMob2+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722449525; c=relaxed/simple;
	bh=/OMyjSYuGatg0CBdXe03skcVHexYv82P/7+QTnL/4G0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPI+vrgvLP89TcgnSyP14ighVND4gXYL30WHxnQpfmf1zFRsUJFe4iaQRewniWH1ecjtkXxqMftZ1mIA+kxjSbCqfGYhTQbiJm7zJSHOIJpxIry4grt0sCPtmZU6Qxiq1kRjhfSgM02ldJhlLN8g54xPnJApKbSr36GJM6au/YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8kFqrt3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8kFqrt3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A476DC116B1;
	Wed, 31 Jul 2024 18:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722449525;
	bh=/OMyjSYuGatg0CBdXe03skcVHexYv82P/7+QTnL/4G0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M8kFqrt3Qi1R8thzyEcFykIQzWl0j7VBcPSVJUv+rgScaezgS5MKXxFmgNVkfVlAn
	 4wWDxXaVRT1hg/ScqAe3mvEoDHs5ot/yB1aOCbjFFVKlJzWYqFjU1qHqcnhA6A0vOu
	 fcu/76qQ1DOUC2X9G9SR7ECGYJ44JujI1ZBOdETcc0+tViN5DqwRN8HTMsvpKa6Zom
	 0Sss+/ltiYJ1bb0ZlVXTiYFrkO0mTx1d+ZHi1DJb63as/ZYH9SFjvJLpRFPTx6p7OD
	 L77rOKiO5U/puzOWp+RnXiSNqRrsXcaCEJRs4RBGBYIjdGj4k5RNvkL7mpeZxerIXH
	 KVZy7iLutyIgA==
Date: Wed, 31 Jul 2024 15:12:02 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Matthew Maurer <mmaurer@google.com>, rust-for-linux@vger.kernel.org,
	dwarves@vger.kernel.org, aliceryhl@google.com
Subject: Re: [PATCH] pahole: Apply CU-level filters early in loading
Message-ID: <Zqp-cqZcOOCzQMEg@x1>
References: <20240730224350.4039790-1-mmaurer@google.com>
 <0c0031f6-7f5b-4ec2-9804-c9d576c8302b@oracle.com>
 <Zqo7mW3brA09hA8b@x1>
 <d4152b9d-2bc4-4458-a1a2-71ebb5932d9c@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4152b9d-2bc4-4458-a1a2-71ebb5932d9c@oracle.com>

On Wed, Jul 31, 2024 at 06:43:51PM +0100, Alan Maguire wrote:
> 
> 
> On 31/07/2024 14:26, Arnaldo Carvalho de Melo wrote:
> > On Wed, Jul 31, 2024 at 09:57:25AM +0100, Alan Maguire wrote:
> >> On 30/07/2024 23:43, Matthew Maurer wrote:
> >>> Without this, even with `--lang_exclude=rust` set, running on `vmlinux`
> >>> with `CONFIG_RUST` enabled will lead to errors like:
> >>> die__process_function: tag not supported 0x2f (template_type_parameter)!
> >>> because the filtering doesn't happen until finalization, but unsupported
> >>> tags are reported during loading.
> >>>
> >>> As an added bonus, this should speed up processing of large objects with
> >>> filtered CUs, as their details will no longer be walked.
> >>>
> >>
> >> One question on this; if we are always doing early filtering like this,
> >> should the explicit cu__filter() call be removed from pahole_stealer()?
> > 
> > When I saw the introduction of an extra callback to be used inside the
> > dwarf_loader I thought that it would be used only for this specific
> > language filtering feature, i.e. a defensive approach at implementing
> > this to avoid unintended side effects of doing all filtering at that
> > point, maybe some other feature somehow depends on the cu__filter()
> > being called where it was so far.
> > 
> > But then it is being used for all filtering, so it seems just a way to
> > reduce the patch size...
> > 
> > So I'd keep the cu->early_cu_filter() but would use it only for the
> > language filtering feature, wdyt?
> 
> So if I understand correctly,
> 
> 	if (languages.exclude)
> 		conf_load.early_cu_filter = cu__filter;
> 
> ? Seems reasonable to me. Thanks!

yeah, you got it. So this new early filtering is done for the feature we
have at hand and if other uses of cu__filter() already in place need, we
can transition to this new mechanism that reuses the cu__filter()
function signature/semantics.

- Arnaldo
