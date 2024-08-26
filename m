Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EA27711F
	for <dwarves@vger.kernel.org>; Mon, 26 Aug 2024 20:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724702423; cv=none; b=Fw4ZBSGiKnKPGDmpAUX4sUYB/Coc6bfXemUXRncjoet/weciFJmx3r65FHvuvKt582bIDL4wg+vCtWvIc7r0XzuTJ9p2b9mwdFFOoHByZ7JJzeBIgbxfFScb30an3J0VPaVCe1WnfE36LsoHAI0owoWWDlfwzmxeHM7qS3R1G+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724702423; c=relaxed/simple;
	bh=b6eOrKVdJgaRx3OA7lALJSIwV+yhrlwTctNvFs7yJg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDHS7zHVXXy5MUL0YOg5qd9B5P+5tmOx49GNl2JGvpvG7HAx6SBWJTsdSGkiEHbVLfAr6O+N6oQkgmeu1Q0WVnr9D45V1UBqTmEGtWAvDJJH0wRO8gkTpdORGeylDBsmOX/BdJQN5RCLUwgln35IZoREpM3YyMV2rzLEDiJycjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNvzyqv9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNvzyqv9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F25DC8B7D0;
	Mon, 26 Aug 2024 20:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724702423;
	bh=b6eOrKVdJgaRx3OA7lALJSIwV+yhrlwTctNvFs7yJg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FNvzyqv9NTjfIoi7AOFo0XOnkyMgXyR1Z2mRJKhcFQCtIhWY/B2Yugmf22eSDbfSg
	 7pWUm6olKy+JCqRlOMy4V7U4n0YY0BYuLChAVxqsNIh6ecHeApc6VgEQkmsr7lcKUs
	 lsO9BG/5UkiaRHrfa0m2SzRKBHmCF/wJqsPwCyjWFPy02edCXNbSeBw7GfIp2QjOgA
	 AE3p8fUkqSVyHS2Qi6tWHJQWrdMrMPhBlb1ZSWlywjps31yZwO7axgWQJw2DV7fQJz
	 1B95+7OQzIk56q4q2TngV+DncwCaND9dFH8a7dv8xC41v17vdqQX2TuEOV8lq28nKp
	 bPnnXG4hvPcMg==
Date: Mon, 26 Aug 2024 17:00:19 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Will Hawkins <hawkinsw@obs.cr>
Cc: dwarves@vger.kernel.org
Subject: Re: [PATCH 0/1] btf_loader support for subprogram linkage
Message-ID: <Zsze05ar-q9iKvrS@x1>
References: <20240823212835.1078351-1-hawkinsw@obs.cr>
 <ZsyWmWL7n4QbE1mp@x1>
 <ZsyXAcCv8sBwxLH1@x1>
 <ZsyYGPUEtP5zP3i6@x1>
 <CADx9qWh=Sw2Cr2Y8K_2ExTFJecTrhenN9TzVH0kyKL+buWVa2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADx9qWh=Sw2Cr2Y8K_2ExTFJecTrhenN9TzVH0kyKL+buWVa2Q@mail.gmail.com>

On Mon, Aug 26, 2024 at 12:36:45PM -0400, Will Hawkins wrote:
> On Mon, Aug 26, 2024 at 10:58 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > commit ce516fb0cf2a3d9fc45c2a9c7ab2cf4bd24965a0
> > Author: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
> > Date:   Sun Jul 8 19:47:26 2007 -0300

> >     [LIB]: Support DW_AT_MIPS_linkage_name

> >     Another C++ specific case:

> >     -       class TypeTemplate ByName(const string  &, size_t);
> >     +       class TypeTemplate ByName(const string  &, size_t); /* linkage=_ZN4ROOT6Reflex12TypeTemplate6ByNameERKSsj */

> >     Signed-off-by: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>

> > So its not really "static" or "stern", but the mangled name in languages

oops, "extern"

> > such as C++, so I think this patch needs reworking, there is ambiguity
> > on the "linkage" term, we should use some other term :-\
> 
> Completely understand! I will rework it and propose something different.
> 
> I am just thankful that you are so welcoming of the contribution! Your
> enthusiasm has made a contributor for life!

Another recommendation, please don't point the field to strings like
"extern" or "static", as DWARF is not language specific, pahole manages
to handle C mostly, C++ to a great degree but I also used it with Go,
Rust.

We want to make it more language agnostic, so while the "linkage" as a
mangled name is not language specific, "static" or "extern" may be.

So just keep it using the DWARF constant/enumeration, so that at
dwarves_fprintf.c time we can, based on the language encoded in the
debugging info (for BTF we assume C until we introduce some way to
encode Rust (The kernel can be written using Rust, so we're bound to
have something in that direction introduced in BTF at some point)).

- Arnaldo
