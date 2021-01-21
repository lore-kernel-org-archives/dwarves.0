Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D1BC433E0
	for <linux-dwarves@archiver.kernel.org>; Thu, 21 Jan 2021 15:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1651235FF
	for <linux-dwarves@archiver.kernel.org>; Thu, 21 Jan 2021 15:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732289AbhAUPDC (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 21 Jan 2021 10:03:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:41234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730752AbhAUN3r (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Thu, 21 Jan 2021 08:29:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 48754206DC;
        Thu, 21 Jan 2021 13:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611235745;
        bh=8zHxd31xZC7Uz9ArBtoZNz80KDb7kSWfXXrW9hgvac4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YdQ5PU4qhHGHTRyEm55c66y9++UJq3Z7eJrHVd9M5p/Y5fbA0gcwChe03VP1GjaUP
         0dnXlceTTrTCbwyXp/Xqqkyz8itoZDwTwy+Q6u5fLIYs9I02Fj2Tb69aYF+ih8BdFN
         7o46wyfzWjVzqPmvT+3/ML2rmfVv8tmHAVk5JHthPVdl+FV/kdVDttCAlMBzWdfRql
         O9rxszYKU/Zgp43JeIDpRf3PBa0FKrtJgNAERVoGUJLHCqVsjYoeMB1Mjvh/kr22zv
         BOnLcnkfrftSwAEfv3VgF7mnqW4Uji7C93HShhQ7+pMEBNPfsrGUJZ55e0CKeo/+Xy
         btpGv+xze1YLg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 08D0040513; Thu, 21 Jan 2021 10:29:03 -0300 (-03)
Date:   Thu, 21 Jan 2021 10:29:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Luca Boccassi <bluca@debian.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        dwarves@vger.kernel.org
Subject: Re: [PATCH dwarves] libbpf: allow to use packaged version
Message-ID: <20210121132902.GA12699@kernel.org>
References: <20210102182201.122619-1-bluca@debian.org>
 <CAEf4Bzb3jtv4+KBRNOzfERWyx_4Wh_m7xRrWcc7nAgoXi+yW-Q@mail.gmail.com>
 <9809e2cd737edb9c70954b99bdf4ce874844965b.camel@debian.org>
 <CAEf4BzarBG3HnxTiCpum9i31cTTdqDKWnHeV4zbRrUgs2V1Rpw@mail.gmail.com>
 <df6bebe13ac5d5a80563f56805dee127ad380401.camel@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df6bebe13ac5d5a80563f56805dee127ad380401.camel@debian.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Mon, Jan 04, 2021 at 10:17:36PM +0000, Luca Boccassi escreveu:
> On Mon, 2021-01-04 at 12:23 -0800, Andrii Nakryiko wrote:
> > On Sun, Jan 3, 2021 at 1:30 PM Luca Boccassi <bluca@debian.org>
> > > > >  #include "dutil.h"
> > > > > +#ifdef LIBBPF_FOUND
> > > > > +#include <bpf/libbpf.h>
> > > > > +#else
> > > > >  #include "lib/bpf/src/libbpf.h"
> > > > > +#endif

> > > > this is horrible, are you sure there is no way to make
> > > > <bpf/libbpf.h>
> > > > work for both cases?

> > > It really is, but unfortunately I don't see other ways that are
> > > not just as horrible. Suggestions welcome. The only thing I can
> > > think of, is if libbpf used the same directory hierarchy in-tree
> > > as it does in the installed tree. Ie: move those headers from
> > > libbpf/src/foo.h to libbpf/include/bpf/foo.h. Then we would just
> > > have the - Ilib/bpf/include in CPPFLAGS for the embedded build
> > > defined in the CMake files, and the sources would only use the
> > > "system" includes everywhere, without ifdeffery.

> > > Given you maintain libbpf, would that be something you'd accept?
> > > It's quite a common pattern for libraries to store their public
> > > headers in a separate directory in the git tree, after all.
 
> > It's quite risky, as there are plenty of (sometimes private)
> > integrations that assume such a layout of libbpf, so we'll be
> > breaking them badly. Makefile-based projects do `make
> > install_headers` to put *only exported* headers into the desired
> > location. I'm not sure what's the best way to achieve the same with
> > Cmake, though.
 
> > One quick and easy hack would be to put a symlink lib/include/bpf ->
> > lib/bpf/src into pahole repo. And add -Ilib/include to let compiler
> > handle <bpf/*.h> properly.
 
> Sure, that works for me if it's acceptable as a solution. Sent v3 that
> implements it. Thanks for the suggestion.

Andrii, can I have your Reviewed-by or Acked-by for v3?

I have it in my local repo and will push publicly later today after I
perform tests.

- Arnaldo
