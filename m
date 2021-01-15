Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EBFC433DB
	for <linux-dwarves@archiver.kernel.org>; Fri, 15 Jan 2021 15:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19BED22473
	for <linux-dwarves@archiver.kernel.org>; Fri, 15 Jan 2021 15:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732522AbhAOP3Y (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 15 Jan 2021 10:29:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:43588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbhAOP3Y (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Fri, 15 Jan 2021 10:29:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7153922473;
        Fri, 15 Jan 2021 15:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610724522;
        bh=mMnEcudED5DbRzbmz9EN3EsbcIchkpfzvIdESxGdva4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R3K9rKcLBxlkFisWQ8HpkKCyvNEqa/NEtWh16YAqAOtGxTNipGUHlushjw1B7C5Ce
         oKHlzKedr/9NOBSYcEgBWKvSBIX3SAWv4h3NE2fc0VOtA3AbS5vSLsxF6ch1uQfHSj
         L1h9p6Bg9mBp7gITbjbwhcD84RwIzVetKZmCK1S9pSv5mMDEm9P82/Bs3LIDEoAvM4
         XkPWkrKAiT/GHwEwcWIcGuhM3vQxyNgQpUNNEBgqiFEFi5OKhku9XZtnl4Fc5VdlRu
         3zvNd5Wx6mm23OUoU7wMzqQZED7m35fe4CuqEw3QFAjJK/j5ll/kPyhkFPs3Ne5MVp
         6pJhyvG6KfBeg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9BFFC40522; Fri, 15 Jan 2021 12:29:15 -0300 (-03)
Date:   Fri, 15 Jan 2021 12:29:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Luca Boccassi <bluca@debian.org>, dwarves@vger.kernel.org
Subject: Re: [PATCH dwarves] libbpf: allow to use packaged version
Message-ID: <20210115152915.GA457607@kernel.org>
References: <20210102182201.122619-1-bluca@debian.org>
 <CAEf4Bzb3jtv4+KBRNOzfERWyx_4Wh_m7xRrWcc7nAgoXi+yW-Q@mail.gmail.com>
 <9809e2cd737edb9c70954b99bdf4ce874844965b.camel@debian.org>
 <CAEf4BzarBG3HnxTiCpum9i31cTTdqDKWnHeV4zbRrUgs2V1Rpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzarBG3HnxTiCpum9i31cTTdqDKWnHeV4zbRrUgs2V1Rpw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Mon, Jan 04, 2021 at 12:23:25PM -0800, Andrii Nakryiko escreveu:
> On Sun, Jan 3, 2021 at 1:30 PM Luca Boccassi <bluca@debian.org> wrote:
> >
> > On Sun, 2021-01-03 at 11:10 -0800, Andrii Nakryiko wrote:
> > > On Sat, Jan 2, 2021 at 10:25 AM Luca Boccassi <bluca@debian.org>
> > > wrote:
> > > >
> > > > Add a new CMake option, LIBBPF_EMBEDDED, to switch between the
> > > > embedded version and the system version (searched via pkg-config)
> > > > of libbpf. Set the system version as the default.
> > > >
> > >
> > > There's been a lot of arguments about libbpf as a submodule, so I
> > > don't think we need to go about pros and cons again, but I just
> > > wanted
> > > to cast my vote against doing this at all. Having pahole built with
> > > libbpf statically (only) was a great thing for me so far with
> > > iterating quickly and adopting new APIs without overcomplicating the
> > > source code with all sorts of feature detection code. Without it,
> > > adopting libbpf's faster string deduplication, BTF writing APIs,
> > > module/split BTFs, etc, etc, would be much bigger PITA and/or would
> > > prolong such changes. To the point that I personally wouldn't bother
> > > with some of them at all. Distro maintainers obviously don't care
> > > about such inconveniences for developers, but it's a real factor in
> > > determining what kind of functionality is implemented in pahole, so I
> > > hope Arnaldo won't dismiss this without thinking about this
> > > carefully.

Hey, having tools/perf/ and tools/lib/perf, tools/lib/bpf, etc all in
one place is really nice :-)

> > You know very well that it's not about caring or not caring :-) There
> > are simply conflicting interests, and both sides are valid.
 
> I didn't mean it in a negative way. Different priorities and interests
> is a better way to put it, sure.

I think the default should be submodules as we're still very much in
flux, adding new features, etc.

Disto maintainers can make sure they know what they're doing when making
tools use libbpf as a separate package.

I'm coming back from vacation, so trying to zip thru a lot of emails, so
just thought about sharing my first reaction to this in a quick way.

Regards,

- Arnaldo
 
> > I believe we can have best of both worlds with this. The user who does
> > the build is empowered to choose what they prefer. The additional cost
> > would be to set the correct minimum version required in the CMake file,
> > as it's done with other dependencies, including CMake itself.
> >
> > > > Signed-off-by: Luca Boccassi <bluca@debian.org>
> > > > ---
> > > > Note: I can switch the default around if you prefer.
> > >
> > > With BCC you seem to go with the default preserving existing behavior
> > > (using libbpf from a submodule), so if we do this, I think the
> > > default
> > > should be flipped.
> >
> > Sure, sent v2.
> >
> > > >
> > > >  CMakeLists.txt   | 49 +++++++++++++++++++++++++++++++++++---------
> > > > ----
> > > >  btf_encoder.c    |  5 +++++
> > > >  btf_loader.c     |  4 ++++
> > > >  libbtf.c         |  6 ++++++
> > > >  libbtf.h         |  4 ++++
> > > >  pahole.c         |  4 ++++
> > > >  pahole_strings.h |  4 ++++
> > > >  strings.c        |  4 ++++
> > > >  8 files changed, 67 insertions(+), 13 deletions(-)
> > > >
> > >
> > > [...]
> > >
> > > >  #include "dutil.h"
> > > > +#ifdef LIBBPF_FOUND
> > > > +#include <bpf/libbpf.h>
> > > > +#else
> > > >  #include "lib/bpf/src/libbpf.h"
> > > > +#endif
> > >
> > > this is horrible, are you sure there is no way to make <bpf/libbpf.h>
> > > work for both cases?
> >
> > It really is, but unfortunately I don't see other ways that are not
> > just as horrible. Suggestions welcome. The only thing I can think of,
> > is if libbpf used the same directory hierarchy in-tree as it does in
> > the installed tree. Ie: move those headers from libbpf/src/foo.h to
> > libbpf/include/bpf/foo.h. Then we would just have the -Ilib/bpf/include
> > in CPPFLAGS for the embedded build defined in the CMake files, and the
> > sources would only use the "system" includes everywhere, without
> > ifdeffery.
> >
> > Given you maintain libbpf, would that be something you'd accept? It's
> > quite a common pattern for libraries to store their public headers in a
> > separate directory in the git tree, after all.
> 
> It's quite risky, as there are plenty of (sometimes private)
> integrations that assume such a layout of libbpf, so we'll be breaking
> them badly. Makefile-based projects do `make install_headers` to put
> *only exported* headers into the desired location. I'm not sure what's
> the best way to achieve the same with Cmake, though.
> 
> One quick and easy hack would be to put a symlink lib/include/bpf ->
> lib/bpf/src into pahole repo. And add -Ilib/include to let compiler
> handle <bpf/*.h> properly.
> 
> >
> > --
> > Kind regards,
> > Luca Boccassi

-- 

- Arnaldo
