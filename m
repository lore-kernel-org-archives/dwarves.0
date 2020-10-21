Return-Path: <SRS0=Qilz=D4=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA87BC388F9
	for <linux-dwarves@archiver.kernel.org>; Wed, 21 Oct 2020 16:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F18222249
	for <linux-dwarves@archiver.kernel.org>; Wed, 21 Oct 2020 16:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603297611;
	bh=rNAAM/r90IkCSUbtaY5FPZ1EPfnFPNizgiW6QhfRiXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zZlSHRS694OCDRE7Gd36DVPG/BQ8iM4n8KgNPcEn1mXfEGWbPm3eVYT1qRcPNZZ1o
	 lmJ207SaQ8mZt7VN07+EhRbAnqE0yPIdjSivs/9oF3wPwf3yn1GUITaRcWqXCuV8QE
	 x3tsH5vGxAWQ0VQViToYMHnHQiP9+TG2byqaNVRc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730745AbgJUQ0u (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 21 Oct 2020 12:26:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:59722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730587AbgJUQ0u (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Wed, 21 Oct 2020 12:26:50 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4AF321D7B;
        Wed, 21 Oct 2020 16:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603297609;
        bh=rNAAM/r90IkCSUbtaY5FPZ1EPfnFPNizgiW6QhfRiXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O+mZiMdtaNYPJC+m2IJKqLx9SoD8hgdvduSg2fd5+fATBlmn4rrg/QSTFkgvzjwNx
         lBKVXXqq7asgi4nm7VfMhPirOgBQkRVSqY4Fg6MqEWamsrREgI5saII5HuxwXlDfpN
         y01SCVbNanahv0HZyWhLs3j65kqtO2R9GvVE9c/0=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id ADEA7403C2; Wed, 21 Oct 2020 13:26:47 -0300 (-03)
Date:   Wed, 21 Oct 2020 13:26:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        =?iso-8859-1?Q?=C9rico?= Rolim <erico.erc@gmail.com>,
        dwarves@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Hao Luo <haoluo@google.com>, Andrii Nakryiko <andriin@fb.com>
Subject: Re: Segfault in pahole 1.18 when building kernel 5.9.1 for arm64
Message-ID: <20201021162647.GQ2342001@kernel.org>
References: <CAFDeuWM7D-Upi84-JovKa3g8Y_4fjv65jND3--e9u-tER3WmVA@mail.gmail.com>
 <82b757bb-1f49-ab02-2f4b-89577d56fec9@kernel.org>
 <20201020122015.GH2294271@kernel.org>
 <f7246cb6-901e-0bc3-eb18-194d1754da53@kernel.org>
 <20201021112900.GN2342001@kernel.org>
 <CAEf4BzbpRaDsRGv+V5xvhHERJA7zoXwOnL_WJCimHHLk=tM3nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbpRaDsRGv+V5xvhHERJA7zoXwOnL_WJCimHHLk=tM3nw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Wed, Oct 21, 2020 at 08:53:16AM -0700, Andrii Nakryiko escreveu:
> On Wed, Oct 21, 2020 at 6:48 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Wed, Oct 21, 2020 at 08:22:40AM +0200, Jiri Slaby escreveu:
> > > On 20. 10. 20, 14:20, Arnaldo Carvalho de Melo wrote:
> > > > > Yeah, I observe the very same. I reported it at:
> > > > > https://bugzilla.suse.com/show_bug.cgi?id=1177921
> >
> > > > Would it be possible to try with
> > > > https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=tmp.libbtf_encoder
> > > > ?
> >
> > > Yes, that branch fixes the crashes and the kernel build finishes. The
> > > zero-sized symbol error remains.
> >
> > > So what should distributions do now -- should we switch to a pahole snapshot
> > > for a while?
> >
> > That would do the trick, I just completed my testing and pushed to the
> > master branch on kernel.org and github, tests detailed at:
> >
> > https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=040fd7f585c9b9fcf4475d294b3f5ddf78405297
> >
> > There are some minor bug reports I want to address but my ETA right now
> > is the end of this week to release v1.19.
> 
> I've just sent a patch that skips zero-sized ELF symbols without a
> warning or error.

Got it, applied, Jiri, please consider testing it and providing a
Tested-by, in addition to the Reported-by that I'm adding now.

Thanks!

- Arnaldo
