Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E03C433DB
	for <linux-dwarves@archiver.kernel.org>; Thu, 11 Feb 2021 01:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C67164EC9
	for <linux-dwarves@archiver.kernel.org>; Thu, 11 Feb 2021 01:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhBKBcp (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 10 Feb 2021 20:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbhBKBcj (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 10 Feb 2021 20:32:39 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BE6C06174A;
        Wed, 10 Feb 2021 17:31:59 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 133so4026813ybd.5;
        Wed, 10 Feb 2021 17:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eh9gSnVTmcMsPfA//9NXUsOsDtdbFA9FxHnsC7dtTno=;
        b=nqJghefQPgO0XOoEqIaFw+ZykUYdjJ3EiDEXoxPQLK08Dc3Cfy26lruLAUU1YCiqlN
         JKM1frJ/TAEH29NsM8g5lbEmcIxcKSpcrWRarNQnxSatIE2JVkH/zaoCOLn5VuV8eZb3
         AX7t09qY2Y00mOY5KUgPrEp6L6lVJtkJDfYCH0hfLgi8yyeM49GMISBsOt3Q9Et6EUuB
         dHdO/oYR6MR+sLz5UkEsr1OlBuvepnF+SQuuCb5lBA3V66Kc0BLbNkgNCBAr6rtNqqX9
         Y8yno1UHKDkkL+o2A/eICPPiwWF7XCsGQgAmRq9UCIoDpWuimdCEThQjnDAADdmg4tHc
         7Atg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eh9gSnVTmcMsPfA//9NXUsOsDtdbFA9FxHnsC7dtTno=;
        b=ayZrAQ9UzdFaHQZNWIompjm9GkbzdDZaWpe/xhLARPDS0p5guZnie/sf45nHKytzk/
         zZ0RMXYVdjVa5qKcLWE7zL3BEggjCutQkXui/cy1soBCbaCwf7Zkh+V696hY2APOQ5Wo
         W7QCsGiuZRdsAMfMMxTBcQ7WSsEO0JuxP4Zktzjw/VkCSg0GoWlx1xEnb7epeMloilru
         /COj04QKpedX6SJS0q78Kj9+D5k1PkxXXGzuDoETkGH3LrbOqQEyzDRWHbyKEBM2jfu2
         Mye5UijvrpXxAk5beMFmtm2kJYlEyD+JXA7WTNEb4crUWznN8jM201JxbZpfovJRt2Ce
         cK0Q==
X-Gm-Message-State: AOAM531fUTmcyuIP19MPyK0iq+QnDqMz6wVcXoVNXEbOblFaHdCh2Nds
        LzcQ8KuQ2Wvr++uoViDz19CRR2Uk5aml/MfBqNc=
X-Google-Smtp-Source: ABdhPJxWdlxuhsDB4ufRYilG137AnrottnKCTuDiSThZRHPg0DFvoYITrecJapSidl6eCcjO09YbD2XHdPgw3onDwHQ=
X-Received: by 2002:a5b:3c4:: with SMTP id t4mr7723146ybp.510.1613007118730;
 Wed, 10 Feb 2021 17:31:58 -0800 (PST)
MIME-Version: 1.0
References: <20210210232327.1965876-1-morbo@google.com> <CAEf4BzYrWe4N28JjM6na=sNvq5214zs5yHra_fCuE1KA24KQ0A@mail.gmail.com>
 <CAGG=3QW0zuXUcpkcZqnaZS77EABEshhPtUCTr71dDDMuL1oMZQ@mail.gmail.com>
In-Reply-To: <CAGG=3QW0zuXUcpkcZqnaZS77EABEshhPtUCTr71dDDMuL1oMZQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 10 Feb 2021 17:31:48 -0800
Message-ID: <CAEf4Bzap_SYhtQdLF8bMwVeag=8CGqpcnRFb=MtZX7CB7FwSYQ@mail.gmail.com>
Subject: Re: [PATCH] dwarf_loader: use a better hashing function
To:     Bill Wendling <morbo@google.com>
Cc:     dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Wed, Feb 10, 2021 at 5:24 PM Bill Wendling <morbo@google.com> wrote:
>
> On Wed, Feb 10, 2021 at 4:00 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Feb 10, 2021 at 3:25 PM Bill Wendling <morbo@google.com> wrote:
> > >
> > > This hashing function[1] produces better hash table bucket
> > > distributions. The original hashing function always produced zeros in
> > > the three least significant bits.
> > >
> > > The new hashing funciton gives a modest performance boost.
> > >
> > >       Original      New
> > >        0:11.41       0:11.38
> > >        0:11.36       0:11.34
> > >        0:11.35       0:11.26
> > >       -----------------------
> > >   Avg: 0:11.373      0:11.327
> > >
> > > for a performance improvement of 0.4%.
> > >
> > > [1] From Numerical Recipes, 3rd Ed. 7.1.4 Random Hashes and Random Bytes
> > >
> >
> > Can you please also test with the one libbpf uses internally:
> >
> > return (val * 11400714819323198485llu) >> (64 - bits);
> >
> > ?
> >
> > Thanks!
> >
> It's giving me a running time of ~11.11s, which is even better. Would
> you like me to submit a patch?

faster is better, so yeah, why not? :)

>
> -bw
