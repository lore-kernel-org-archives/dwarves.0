Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BA0C433DB
	for <linux-dwarves@archiver.kernel.org>; Thu, 21 Jan 2021 20:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0AB223A56
	for <linux-dwarves@archiver.kernel.org>; Thu, 21 Jan 2021 20:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbhAUUf6 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 21 Jan 2021 15:35:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:55624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbhAUUf3 (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Thu, 21 Jan 2021 15:35:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9BD2323A56;
        Thu, 21 Jan 2021 20:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611261288;
        bh=4Pai6cgb/jqdZNISICvcBV1wgP7zqsh/Uic/9XDaVkk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O+teyJ72SvHeskQwF4PPaU4XWNQrQGSp3LegfU+yysdOQtnCHFr5Jry4/1m+tCvom
         zgAFGg7PC2x5SmFd+edio53YkqbsJMxTI8ha8YlhLvzGPcOANSp7jHksjXw8jmDGMf
         ApQJ3YSmEjtR2bUUZ3kSeFowkwJ7N5bfAfMDnx1HsdyKefJZgKaKhh1Qwm5+KKUuIZ
         lJ51o3+tmCwXs17QyJJ11RA9QE7ndjtvVfa9LubNobhGJI8dqIZHhPgdvb5wB86mE6
         Q9y/poy6jVDep+16RwEK1g4u5TnuZkvSjkhFuXjkEJ9q6FcDvM1qc5ZhajBGtX+QC1
         Rp7A/7e2KluIw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8A12B40513; Thu, 21 Jan 2021 17:34:46 -0300 (-03)
Date:   Thu, 21 Jan 2021 17:34:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Luca Boccassi <bluca@debian.org>, dwarves@vger.kernel.org
Subject: Re: [PATCH dwarves] libbpf: allow to use packaged version
Message-ID: <20210121203446.GF356537@kernel.org>
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
> On Thu, Jan 21, 2021 at 5:29 AM Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > Em Mon, Jan 04, 2021 at 10:17:36PM +0000, Luca Boccassi escreveu:
> > > On Mon, 2021-01-04 at 12:23 -0800, Andrii Nakryiko wrote:
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

Ok, fair enough, I applied the patch, the default behaviour is the one
we like, so should be no problem for us :-)

- Arnaldo
