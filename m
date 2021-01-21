Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32141C433E6
	for <linux-dwarves@archiver.kernel.org>; Thu, 21 Jan 2021 20:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFBD623A5C
	for <linux-dwarves@archiver.kernel.org>; Thu, 21 Jan 2021 20:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbhAUUFc (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 21 Jan 2021 15:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbhAUUDp (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 21 Jan 2021 15:03:45 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E668C06174A
        for <dwarves@vger.kernel.org>; Thu, 21 Jan 2021 12:03:04 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id k132so3269055ybf.2
        for <dwarves@vger.kernel.org>; Thu, 21 Jan 2021 12:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T2E6xGWeXPVV9hfygdQUWlPnJIIvN7a85k1DR2oro0M=;
        b=EkSc1dBwOoauq1YstPnX2GjYtOJQyyFtoKTTHnYAto6SvPe0INf4hTBOvjRmE7bj+9
         DDq1PQ7SGbmpRO4/tm2Q/Uu2bJlmgkyuDB3uO//ZniQ0WB/ceg43Fp9AilSV7NrHuwGc
         836iCQgmaRokan0+MaqAcQfZdbkdJMOuIsBYYU/xbeyX7hPYKvwxKvGJqIKx9v5v8fK1
         UO11wu5ci8vX3jXifVVjIqENuZdX1f4IDqzQFcIoeJZEdaTZ6sc/xZY6/H/vRhJXFO/m
         Qn175OOY9emq4acCic/UgWGFwtNl7PR9mo80iKRFawFL+QiZ73sFusP7AkNtMFreuqO9
         UcMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T2E6xGWeXPVV9hfygdQUWlPnJIIvN7a85k1DR2oro0M=;
        b=SLdt2ZYfvrCvKj1yH60XMfbzHSpPZVaZDhE6hL/kRfBF37jIvgc9WK3CiWjDDLzONf
         ewRnF2UDPAL1iGstvCsTtIyn2B7Xl3JME1IRyNsYw2roEz6AEhRTuVXolIu/3f24FCJJ
         L6ppBZNkMD8IreED3f+JJW7VQKD6X71wq4aihB2+WgfZfYR5hiVq3P/apH76LnyQ2eDB
         NePRRuUOQePBwDAFEl/qVxA2XQpfrY7BrnS95CgFfGdq1Jzgrt4c+aBiQhWicAF5CDKz
         TCRtBQLs/+3qbyOpmCv/RBsszcv1SIj2q+n2tJXB8sRNuD8uGeyoJmh8Y3KoSNfsflX2
         Hj1g==
X-Gm-Message-State: AOAM5306DzdpGyQxE/MB2NmlmrG5hridZl5TrvCss3ajcmj1ByDfPAEP
        tuQDRLSTyuVyzKMwpayKBRULb06KNgPE0pi77lk=
X-Google-Smtp-Source: ABdhPJx/lHXfF+yHxJRRLzU2HAirKIKsssGBY3nN4EZDs8RCEZ7fN0hSGhgPxLW/G18oJAxINvkPJiJ/xfizOd+XsAM=
X-Received: by 2002:a25:a183:: with SMTP id a3mr1344090ybi.459.1611259383860;
 Thu, 21 Jan 2021 12:03:03 -0800 (PST)
MIME-Version: 1.0
References: <20210102182201.122619-1-bluca@debian.org> <CAEf4Bzb3jtv4+KBRNOzfERWyx_4Wh_m7xRrWcc7nAgoXi+yW-Q@mail.gmail.com>
 <9809e2cd737edb9c70954b99bdf4ce874844965b.camel@debian.org>
 <CAEf4BzarBG3HnxTiCpum9i31cTTdqDKWnHeV4zbRrUgs2V1Rpw@mail.gmail.com>
 <df6bebe13ac5d5a80563f56805dee127ad380401.camel@debian.org> <20210121132902.GA12699@kernel.org>
In-Reply-To: <20210121132902.GA12699@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 21 Jan 2021 12:02:53 -0800
Message-ID: <CAEf4BzZn_dkeWxfAB_ysWgLnAvUUcPoNi0yHbLPkiBWW9Lh5BA@mail.gmail.com>
Subject: Re: [PATCH dwarves] libbpf: allow to use packaged version
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Luca Boccassi <bluca@debian.org>, dwarves@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Thu, Jan 21, 2021 at 5:29 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Mon, Jan 04, 2021 at 10:17:36PM +0000, Luca Boccassi escreveu:
> > On Mon, 2021-01-04 at 12:23 -0800, Andrii Nakryiko wrote:
> > > On Sun, Jan 3, 2021 at 1:30 PM Luca Boccassi <bluca@debian.org>
> > > > > >  #include "dutil.h"
> > > > > > +#ifdef LIBBPF_FOUND
> > > > > > +#include <bpf/libbpf.h>
> > > > > > +#else
> > > > > >  #include "lib/bpf/src/libbpf.h"
> > > > > > +#endif
>
> > > > > this is horrible, are you sure there is no way to make
> > > > > <bpf/libbpf.h>
> > > > > work for both cases?
>
> > > > It really is, but unfortunately I don't see other ways that are
> > > > not just as horrible. Suggestions welcome. The only thing I can
> > > > think of, is if libbpf used the same directory hierarchy in-tree
> > > > as it does in the installed tree. Ie: move those headers from
> > > > libbpf/src/foo.h to libbpf/include/bpf/foo.h. Then we would just
> > > > have the - Ilib/bpf/include in CPPFLAGS for the embedded build
> > > > defined in the CMake files, and the sources would only use the
> > > > "system" includes everywhere, without ifdeffery.
>
> > > > Given you maintain libbpf, would that be something you'd accept?
> > > > It's quite a common pattern for libraries to store their public
> > > > headers in a separate directory in the git tree, after all.
>
> > > It's quite risky, as there are plenty of (sometimes private)
> > > integrations that assume such a layout of libbpf, so we'll be
> > > breaking them badly. Makefile-based projects do `make
> > > install_headers` to put *only exported* headers into the desired
> > > location. I'm not sure what's the best way to achieve the same with
> > > Cmake, though.
>
> > > One quick and easy hack would be to put a symlink lib/include/bpf ->
> > > lib/bpf/src into pahole repo. And add -Ilib/include to let compiler
> > > handle <bpf/*.h> properly.
>
> > Sure, that works for me if it's acceptable as a solution. Sent v3 that
> > implements it. Thanks for the suggestion.
>
> Andrii, can I have your Reviewed-by or Acked-by for v3?

Well, I still think it's not good and not necessary for pahole. pahole
doesn't run under root. It's not a networking application open to the
world either. So I don't buy security arguments in this case at all.
So no, feel free to push this, but without my ack.

>
> I have it in my local repo and will push publicly later today after I
> perform tests.

While on the subject, do you have plans to release 1.20 any time soon?
I'm holding off until 1.20 is available to sync it internally to be
used for our kernels. Would be nice to get this off my head :)

>
> - Arnaldo
