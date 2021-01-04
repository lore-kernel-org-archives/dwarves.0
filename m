Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143F3C433DB
	for <linux-dwarves@archiver.kernel.org>; Tue,  5 Jan 2021 00:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD1A12255F
	for <linux-dwarves@archiver.kernel.org>; Tue,  5 Jan 2021 00:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbhAEA1l (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 4 Jan 2021 19:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbhAEA1l (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 4 Jan 2021 19:27:41 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE2FC061574
        for <dwarves@vger.kernel.org>; Mon,  4 Jan 2021 16:27:01 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id n42so27765088ota.12
        for <dwarves@vger.kernel.org>; Mon, 04 Jan 2021 16:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/O2siRET8yGJYgR/DE6TxS+kcwtG22oi84VjQlQgjow=;
        b=pyf2qK3YR8NJdghNin9WgHQGyBvxrcnkZXye4+nwgQU//kL8jxWFymgPRjXCdd0jgk
         DvlRSKhzg2wr3K/nF4WTSkaEpyLQgdgEx3HUUw1R7mtJL1GzfNpwgp6ImwUEtaluQ/dw
         2naCHGMr7WTa2XpKSUdkOxU50H9jb+KoX8xK0mvTwZR8HsAxivB5BeDmus2E7SsZ1pGH
         34UFkYpDl/vBVA1XyUhxVs2GTe1geOP9cBcVppVmurPs8iH9efsajLOaV7oGD3gjdfxt
         k5jZj+RSA5GKBeC/UMRsL6iax5g8gUF0VP/6u7oXKm6YQA4aB73TJwdtbV34vYRb078j
         mYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/O2siRET8yGJYgR/DE6TxS+kcwtG22oi84VjQlQgjow=;
        b=Lc/EEUPHKsW6z8MXDvnNPYTn8vbKuGZOJBy/8dz65g4SsZBNy1k25qsu3X26TlgDlJ
         NPYy+bR3mx54WK5B+o4xc9CZM5C/+EtbzMA1tVqmLUOiky+WVeVLr64ocTp3UHsy1B4q
         qTzodZht4cedtEnCBED5jDIf6VL5PWWE4jo/qbBteEDLnOBfK7YW9/2w9eHdFBz9SPFM
         4n+TH936LcSixTWmjgRWDct9hBDPgN4zIB/CmSfM1HiVG86nb/hjtcjNmJmTOqGTmRGB
         AW0SgxMtxul5Eb8qtzL/X1MvK2vtjDGGU1UwM8/zIu3jl224lJPI0RlaRQ40IITIaudB
         ZL+A==
X-Gm-Message-State: AOAM530nuP9x3oPAgXeaUNJ+G8vTbcqyFmHwHl9hrP6NEkj59IS2maJV
        sYLqQDG3Z38EwhVCDfR2Sb9oH3jgkzKmD/nRgUWpxyYMlnU=
X-Google-Smtp-Source: ABdhPJwSXjEp9LneONB++0R2THYPuchji117F/AvqOYgx6+DjtjSoQFwN+3C1J3G1MD/xuwjV/WuCD+sMH73AN+9zBI=
X-Received: by 2002:a25:c7c6:: with SMTP id w189mr107135749ybe.403.1609791816400;
 Mon, 04 Jan 2021 12:23:36 -0800 (PST)
MIME-Version: 1.0
References: <20210102182201.122619-1-bluca@debian.org> <CAEf4Bzb3jtv4+KBRNOzfERWyx_4Wh_m7xRrWcc7nAgoXi+yW-Q@mail.gmail.com>
 <9809e2cd737edb9c70954b99bdf4ce874844965b.camel@debian.org>
In-Reply-To: <9809e2cd737edb9c70954b99bdf4ce874844965b.camel@debian.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 4 Jan 2021 12:23:25 -0800
Message-ID: <CAEf4BzarBG3HnxTiCpum9i31cTTdqDKWnHeV4zbRrUgs2V1Rpw@mail.gmail.com>
Subject: Re: [PATCH dwarves] libbpf: allow to use packaged version
To:     Luca Boccassi <bluca@debian.org>
Cc:     dwarves@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Sun, Jan 3, 2021 at 1:30 PM Luca Boccassi <bluca@debian.org> wrote:
>
> On Sun, 2021-01-03 at 11:10 -0800, Andrii Nakryiko wrote:
> > On Sat, Jan 2, 2021 at 10:25 AM Luca Boccassi <bluca@debian.org>
> > wrote:
> > >
> > > Add a new CMake option, LIBBPF_EMBEDDED, to switch between the
> > > embedded version and the system version (searched via pkg-config)
> > > of libbpf. Set the system version as the default.
> > >
> >
> > There's been a lot of arguments about libbpf as a submodule, so I
> > don't think we need to go about pros and cons again, but I just
> > wanted
> > to cast my vote against doing this at all. Having pahole built with
> > libbpf statically (only) was a great thing for me so far with
> > iterating quickly and adopting new APIs without overcomplicating the
> > source code with all sorts of feature detection code. Without it,
> > adopting libbpf's faster string deduplication, BTF writing APIs,
> > module/split BTFs, etc, etc, would be much bigger PITA and/or would
> > prolong such changes. To the point that I personally wouldn't bother
> > with some of them at all. Distro maintainers obviously don't care
> > about such inconveniences for developers, but it's a real factor in
> > determining what kind of functionality is implemented in pahole, so I
> > hope Arnaldo won't dismiss this without thinking about this
> > carefully.
>
> You know very well that it's not about caring or not caring :-) There
> are simply conflicting interests, and both sides are valid.

I didn't mean it in a negative way. Different priorities and interests
is a better way to put it, sure.

> I believe we can have best of both worlds with this. The user who does
> the build is empowered to choose what they prefer. The additional cost
> would be to set the correct minimum version required in the CMake file,
> as it's done with other dependencies, including CMake itself.
>
> > > Signed-off-by: Luca Boccassi <bluca@debian.org>
> > > ---
> > > Note: I can switch the default around if you prefer.
> >
> > With BCC you seem to go with the default preserving existing behavior
> > (using libbpf from a submodule), so if we do this, I think the
> > default
> > should be flipped.
>
> Sure, sent v2.
>
> > >
> > >  CMakeLists.txt   | 49 +++++++++++++++++++++++++++++++++++---------
> > > ----
> > >  btf_encoder.c    |  5 +++++
> > >  btf_loader.c     |  4 ++++
> > >  libbtf.c         |  6 ++++++
> > >  libbtf.h         |  4 ++++
> > >  pahole.c         |  4 ++++
> > >  pahole_strings.h |  4 ++++
> > >  strings.c        |  4 ++++
> > >  8 files changed, 67 insertions(+), 13 deletions(-)
> > >
> >
> > [...]
> >
> > >  #include "dutil.h"
> > > +#ifdef LIBBPF_FOUND
> > > +#include <bpf/libbpf.h>
> > > +#else
> > >  #include "lib/bpf/src/libbpf.h"
> > > +#endif
> >
> > this is horrible, are you sure there is no way to make <bpf/libbpf.h>
> > work for both cases?
>
> It really is, but unfortunately I don't see other ways that are not
> just as horrible. Suggestions welcome. The only thing I can think of,
> is if libbpf used the same directory hierarchy in-tree as it does in
> the installed tree. Ie: move those headers from libbpf/src/foo.h to
> libbpf/include/bpf/foo.h. Then we would just have the -Ilib/bpf/include
> in CPPFLAGS for the embedded build defined in the CMake files, and the
> sources would only use the "system" includes everywhere, without
> ifdeffery.
>
> Given you maintain libbpf, would that be something you'd accept? It's
> quite a common pattern for libraries to store their public headers in a
> separate directory in the git tree, after all.

It's quite risky, as there are plenty of (sometimes private)
integrations that assume such a layout of libbpf, so we'll be breaking
them badly. Makefile-based projects do `make install_headers` to put
*only exported* headers into the desired location. I'm not sure what's
the best way to achieve the same with Cmake, though.

One quick and easy hack would be to put a symlink lib/include/bpf ->
lib/bpf/src into pahole repo. And add -Ilib/include to let compiler
handle <bpf/*.h> properly.

>
> --
> Kind regards,
> Luca Boccassi
