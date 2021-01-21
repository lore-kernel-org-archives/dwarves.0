Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5757C433DB
	for <linux-dwarves@archiver.kernel.org>; Thu, 21 Jan 2021 20:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4AA123A5A
	for <linux-dwarves@archiver.kernel.org>; Thu, 21 Jan 2021 20:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbhAUUf0 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 21 Jan 2021 15:35:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:55434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbhAUUe7 (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Thu, 21 Jan 2021 15:34:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 85B5D230F9;
        Thu, 21 Jan 2021 20:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611261198;
        bh=qJcHNkuUo/la0IDspYfBBrbBBRjuonsHH0JPLTx1F5E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EoSjo/eQ+UBtr2qSU7Uzs5lOtiQDxkRU8SxNQht1mwoKSQ8dKbNRJQ0NE8a/91+8K
         UMNjR093eBFON9yLspIlj44UuNVfjzTJAhQkIiSzby1IDVksfpJoD7Qj3aZML7HrJS
         KV+0PueMF0IoNLhTdsAQvmFdUD6acd2S+xLTAzi66DHv/trQh8E4mDmdKihAghjXAP
         XAUWtIbxZGHX3T945TYSa4Qicmo6K6wuPdBwBI9vns3tVVCghTPXI2VWX/f3Rn2XlO
         XrBpoEQzdQuOggWvKccOpD7pQQwQJjAcJhgBwylXHOb1tMCSDZ7XoFFHvLcTyc2PFe
         pCsqT/EDJqbKg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7505040513; Thu, 21 Jan 2021 17:33:16 -0300 (-03)
Date:   Thu, 21 Jan 2021 17:33:16 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Luca Boccassi <bluca@debian.org>, dwarves@vger.kernel.org
Subject: Re: [PATCH dwarves] libbpf: allow to use packaged version
Message-ID: <20210121203316.GE356537@kernel.org>
References: <20210102182201.122619-1-bluca@debian.org>
 <CAEf4Bzb3jtv4+KBRNOzfERWyx_4Wh_m7xRrWcc7nAgoXi+yW-Q@mail.gmail.com>
 <9809e2cd737edb9c70954b99bdf4ce874844965b.camel@debian.org>
 <CAEf4BzarBG3HnxTiCpum9i31cTTdqDKWnHeV4zbRrUgs2V1Rpw@mail.gmail.com>
 <df6bebe13ac5d5a80563f56805dee127ad380401.camel@debian.org>
 <20210121132902.GA12699@kernel.org>
 <CAEf4BzZn_dkeWxfAB_ysWgLnAvUUcPoNi0yHbLPkiBWW9Lh5BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZn_dkeWxfAB_ysWgLnAvUUcPoNi0yHbLPkiBWW9Lh5BA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Thu, Jan 21, 2021 at 12:02:53PM -0800, Andrii Nakryiko escreveu:
> On Thu, Jan 21, 2021 at 5:29 AM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> > Em Mon, Jan 04, 2021 at 10:17:36PM +0000, Luca Boccassi escreveu:
> > > On Mon, 2021-01-04 at 12:23 -0800, Andrii Nakryiko wrote:
> > > > On Sun, Jan 3, 2021 at 1:30 PM Luca Boccassi <bluca@debian.org>
> > > > > > >  #include "dutil.h"
> > > > > > > +#ifdef LIBBPF_FOUND
> > > > > > > +#include <bpf/libbpf.h>
> > > > > > > +#else
> > > > > > >  #include "lib/bpf/src/libbpf.h"
> > > > > > > +#endif
> >
> > > > > > this is horrible, are you sure there is no way to make
> > > > > > <bpf/libbpf.h>
> > > > > > work for both cases?
> >
> > > > > It really is, but unfortunately I don't see other ways that are
> > > > > not just as horrible. Suggestions welcome. The only thing I can
> > > > > think of, is if libbpf used the same directory hierarchy in-tree
> > > > > as it does in the installed tree. Ie: move those headers from
> > > > > libbpf/src/foo.h to libbpf/include/bpf/foo.h. Then we would just
> > > > > have the - Ilib/bpf/include in CPPFLAGS for the embedded build
> > > > > defined in the CMake files, and the sources would only use the
> > > > > "system" includes everywhere, without ifdeffery.
> >
> > > > > Given you maintain libbpf, would that be something you'd accept?
> > > > > It's quite a common pattern for libraries to store their public
> > > > > headers in a separate directory in the git tree, after all.
> >
> > > > It's quite risky, as there are plenty of (sometimes private)
> > > > integrations that assume such a layout of libbpf, so we'll be
> > > > breaking them badly. Makefile-based projects do `make
> > > > install_headers` to put *only exported* headers into the desired
> > > > location. I'm not sure what's the best way to achieve the same with
> > > > Cmake, though.
> >
> > > > One quick and easy hack would be to put a symlink lib/include/bpf ->
> > > > lib/bpf/src into pahole repo. And add -Ilib/include to let compiler
> > > > handle <bpf/*.h> properly.
> >
> > > Sure, that works for me if it's acceptable as a solution. Sent v3 that
> > > implements it. Thanks for the suggestion.
> >
> > Andrii, can I have your Reviewed-by or Acked-by for v3?
> 
> Well, I still think it's not good and not necessary for pahole. pahole
> doesn't run under root. It's not a networking application open to the
> world either. So I don't buy security arguments in this case at all.
> So no, feel free to push this, but without my ack.
> 
> >
> > I have it in my local repo and will push publicly later today after I
> > perform tests.
> 
> While on the subject, do you have plans to release 1.20 any time soon?
> I'm holding off until 1.20 is available to sync it internally to be
> used for our kernels. Would be nice to get this off my head :)

I planed to do it as quick release, but then holidays and my vacation
got in the way, now there are some issues to solve, but I think I should
release a version and then get back to those DWARF5 and 32-bit issues
:-\

- Arnaldo
