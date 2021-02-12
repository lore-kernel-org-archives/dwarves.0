Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792B6C433DB
	for <linux-dwarves@archiver.kernel.org>; Fri, 12 Feb 2021 06:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30A3664DF0
	for <linux-dwarves@archiver.kernel.org>; Fri, 12 Feb 2021 06:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbhBLG4Z (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 12 Feb 2021 01:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhBLG4Z (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Fri, 12 Feb 2021 01:56:25 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA09C061574
        for <dwarves@vger.kernel.org>; Thu, 11 Feb 2021 22:55:45 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id t5so9534480eds.12
        for <dwarves@vger.kernel.org>; Thu, 11 Feb 2021 22:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=olnuZnPxo4MYBAlR8KF0+6WYlN+urR4E9H67lh4qAVI=;
        b=C5BUBZEUgbs/W4RtAfm12B2WIOGRdOLOzialVaKG2L5/xC/Bb9/Gnt9SlWMhqkdTed
         Dv2CI8uRgsBEwPyKDnPnf8iP+Rh6ietTQLILA54EE/wjd1/wSpCjY1bF3mwE6/fusz4F
         onAJLGLeagX7JfqM6L+6DWE4/7CioKyMfNSwh30DiHK/p6xDbGdYHpOfa27Hv6GwH70J
         aq+/DCbsvUCH7QE2+OzEzWOZzimG10sSmnUObMwqyVPyh0nVJFMTI/Mm6vgYP9n4d3oe
         BAke1n3OuDBTG19VBB2FPbEP9Cziqpw4kFE3XGG1muPwmr+jOs9YZA9nqP2pAL3i+ERU
         wpWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=olnuZnPxo4MYBAlR8KF0+6WYlN+urR4E9H67lh4qAVI=;
        b=t6MYl6Z80q5arW7kSf3qjA4M7q6uRR7lwlW8H7qOfI5BRPMZJaT7ZpqmEJWfyWdiyJ
         zbsNSijccaDHYNpWbNh/XLYaQzYZ9Dy2Tab3eiOWCi3i0uIsSmxu2YwzY4gfvwL1X0cC
         I446bm1vIJfBrgaSNISvDBxnItvPK2Dqq5tZOUJ481GKfIzXTp6IjGNFIsHr6P4wqyHd
         cntSNHbXtuSTicHuPz3e5zUy7JiHY9whkclYxc5B1ckEO5xtk1TZHo3mj6uqKxBXG+j4
         Rqja9N0z72JgJwSZSWiTWm3PbfzCVO30C2w8jlQeBN4O767uRDXJfsaj+cqpXVZlwnjY
         NuSg==
X-Gm-Message-State: AOAM533Gw3mreimbWB8ZUvYZKngIoYql5b2SgnqLhz82uXwttj4zUIgV
        Rsh/0Tr6/vId2ua/guEPN2GWao4w+3WKHcsXEJl3EWZ7/w==
X-Google-Smtp-Source: ABdhPJzuOU6TrLXiB42lmXYbh6K9nprWXZhC4ZgQ4om667c791OsI9hPqH80QjKvl0MbpxMjIMS7kySIWJCesWTCuFI=
X-Received: by 2002:a05:6402:202d:: with SMTP id ay13mr1803646edb.335.1613112943617;
 Thu, 11 Feb 2021 22:55:43 -0800 (PST)
MIME-Version: 1.0
References: <20210210232327.1965876-1-morbo@google.com> <CAEf4BzYrWe4N28JjM6na=sNvq5214zs5yHra_fCuE1KA24KQ0A@mail.gmail.com>
 <CAGG=3QW0zuXUcpkcZqnaZS77EABEshhPtUCTr71dDDMuL1oMZQ@mail.gmail.com>
 <CAEf4Bzap_SYhtQdLF8bMwVeag=8CGqpcnRFb=MtZX7CB7FwSYQ@mail.gmail.com> <20210211130109.GD1131885@kernel.org>
In-Reply-To: <20210211130109.GD1131885@kernel.org>
From:   Bill Wendling <morbo@google.com>
Date:   Thu, 11 Feb 2021 22:55:32 -0800
Message-ID: <CAGG=3QWADRX158cM-wMWG4Gf4NxN+bpJTnRNwesV5JPnL9-PWw@mail.gmail.com>
Subject: Re: [PATCH] dwarf_loader: use a better hashing function
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Thu, Feb 11, 2021 at 5:01 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Feb 10, 2021 at 05:31:48PM -0800, Andrii Nakryiko escreveu:
> > On Wed, Feb 10, 2021 at 5:24 PM Bill Wendling <morbo@google.com> wrote:
> > > On Wed, Feb 10, 2021 at 4:00 PM Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > > > On Wed, Feb 10, 2021 at 3:25 PM Bill Wendling <morbo@google.com> wrote:
> > > > > This hashing function[1] produces better hash table bucket
> > > > > distributions. The original hashing function always produced zeros in
> > > > > the three least significant bits.
>
> > > > > The new hashing funciton gives a modest performance boost.
>
> > > > >       Original      New
> > > > >        0:11.41       0:11.38
> > > > >        0:11.36       0:11.34
> > > > >        0:11.35       0:11.26
> > > > >       -----------------------
> > > > >   Avg: 0:11.373      0:11.327
>
> > > > > for a performance improvement of 0.4%.
>
> > > > > [1] From Numerical Recipes, 3rd Ed. 7.1.4 Random Hashes and Random Bytes
>
> > > > Can you please also test with the one libbpf uses internally:
>
> > > > return (val * 11400714819323198485llu) >> (64 - bits);
>
> > > > ?
>
> > > It's giving me a running time of ~11.11s, which is even better. Would
> > > you like me to submit a patch?
>
> > faster is better, so yeah, why not? :)
>
> Yeah, I agree, faster is better, please make it so :-)
>
Your wish is my command! :-) Done.

-bw
