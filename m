Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FB9C48BCF
	for <linux-dwarves@archiver.kernel.org>; Wed,  9 Jun 2021 16:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82324613AC
	for <linux-dwarves@archiver.kernel.org>; Wed,  9 Jun 2021 16:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbhFIQJI (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 9 Jun 2021 12:09:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:47266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229740AbhFIQJI (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Wed, 9 Jun 2021 12:09:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97EDE61377;
        Wed,  9 Jun 2021 16:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623254833;
        bh=dsWbfpFp9RRvAcp4ppUs877KPYIdLY/pNdDE95P+UBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jw50CjkH/6iYchOEq7ARoz1L545rtAzLuI2/vovpKU6l9HoCGNdAYRb3l8+gzQ4xP
         CsAr1On/sUxvB5bqwmC18gMAB+MAjj3gac3zh4fKgHGnNpKPlsmudL7nG/vO4zXVIW
         3rQV3CXGB4dPUF5Vn28lpwLDmR5KXvz/i+wWpai85m1wVg4STpakAvA3Fa5m09II1a
         MnCE9/7hQfl86SVlQFetgDG9hBQp62AYb/ZWFgujZuHPsXABvGYx4CvzUVvpPmNOKV
         zHK6Att9pwNRZqMduHLAUVqoTEwjP/41BvoMGwmS3NFCZOyDS99Yj/QHWBADmgF7Lh
         xCK31SYMWnX0w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C463C40B1A; Wed,  9 Jun 2021 13:07:10 -0300 (-03)
Date:   Wed, 9 Jun 2021 13:07:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Luca Boccassi <bluca@debian.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        dwarves@vger.kernel.org
Subject: Re: [PATCH dwarves] libbpf: allow to use packaged version
Message-ID: <YMDnLoL3H7bo3HOv@kernel.org>
References: <20210102182201.122619-1-bluca@debian.org>
 <CAEf4Bzb3jtv4+KBRNOzfERWyx_4Wh_m7xRrWcc7nAgoXi+yW-Q@mail.gmail.com>
 <9809e2cd737edb9c70954b99bdf4ce874844965b.camel@debian.org>
 <CAEf4BzarBG3HnxTiCpum9i31cTTdqDKWnHeV4zbRrUgs2V1Rpw@mail.gmail.com>
 <20210115152915.GA457607@kernel.org>
 <c3a211f0bef8aed1c097f13f0a178f838dc5f520.camel@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3a211f0bef8aed1c097f13f0a178f838dc5f520.camel@debian.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Fri, Jan 15, 2021 at 03:40:34PM +0000, Luca Boccassi escreveu:
> On Fri, 2021-01-15 at 12:29 -0300, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Jan 04, 2021 at 12:23:25PM -0800, Andrii Nakryiko escreveu:
> > > On Sun, Jan 3, 2021 at 1:30 PM Luca Boccassi <bluca@debian.org> wrote:
> > > > On Sun, 2021-01-03 at 11:10 -0800, Andrii Nakryiko wrote:
> > > > > On Sat, Jan 2, 2021 at 10:25 AM Luca Boccassi <bluca@debian.org>
> > > > > wrote:
> > > > > > Add a new CMake option, LIBBPF_EMBEDDED, to switch between the
> > > > > > embedded version and the system version (searched via pkg-config)
> > > > > > of libbpf. Set the system version as the default.
> > > > > > 
> > > > > 
> > > > > There's been a lot of arguments about libbpf as a submodule, so I
> > > > > don't think we need to go about pros and cons again, but I just
> > > > > wanted
> > > > > to cast my vote against doing this at all. Having pahole built with
> > > > > libbpf statically (only) was a great thing for me so far with
> > > > > iterating quickly and adopting new APIs without overcomplicating the
> > > > > source code with all sorts of feature detection code. Without it,
> > > > > adopting libbpf's faster string deduplication, BTF writing APIs,
> > > > > module/split BTFs, etc, etc, would be much bigger PITA and/or would
> > > > > prolong such changes. To the point that I personally wouldn't bother
> > > > > with some of them at all. Distro maintainers obviously don't care
> > > > > about such inconveniences for developers, but it's a real factor in
> > > > > determining what kind of functionality is implemented in pahole, so I
> > > > > hope Arnaldo won't dismiss this without thinking about this
> > > > > carefully.
> > 
> > Hey, having tools/perf/ and tools/lib/perf, tools/lib/bpf, etc all in
> > one place is really nice :-)
> > 
> > > > You know very well that it's not about caring or not caring :-) There
> > > > are simply conflicting interests, and both sides are valid.
> >  
> > > I didn't mean it in a negative way. Different priorities and interests
> > > is a better way to put it, sure.
> > 
> > I think the default should be submodules as we're still very much in
> > flux, adding new features, etc.
> > 
> > Disto maintainers can make sure they know what they're doing when making
> > tools use libbpf as a separate package.
> 
> Sure, v3 has the option as default-disabled already, not a problem at
> all.

Does this mean that if I have libbpf-devel installed in my system the
default build will _not_ link with it?

I have libbpf-devel installed in my machine but, by default, I _don't_
want pahole to build with it, libbpf-devel is there for other needs.

- Arnaldo
