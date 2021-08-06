Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BFFC4338F
	for <linux-dwarves@archiver.kernel.org>; Fri,  6 Aug 2021 21:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17DE161184
	for <linux-dwarves@archiver.kernel.org>; Fri,  6 Aug 2021 21:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237142AbhHFVMU (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 6 Aug 2021 17:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbhHFVMU (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Fri, 6 Aug 2021 17:12:20 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C483C0613CF
        for <dwarves@vger.kernel.org>; Fri,  6 Aug 2021 14:12:03 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id m193so17509020ybf.9
        for <dwarves@vger.kernel.org>; Fri, 06 Aug 2021 14:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/QnfMreLw7k9hWIdkOKIDeTaUOSI3b3xQAIkhWiqc0Q=;
        b=Rsq6FdSrwz+KygUblr/zW0aDMrQpXMshl3mnJNYbsFY7QfYb26PxVa5ZjfRSYWzLdx
         KOZVxz/f83tGwgKVDOROp+VuNFWceSi5/jAv/Pplj/zJRSYOydmExErE6KGroYIbQIA1
         qnaWmTW99ZqTmU6gyXOtKB7VaWFV3l1sl2Fb0Hnro5W6fght1vVZ3btGZVBYXCHCAL9S
         vMe32mKt/5TFfSz3SuJQHQYfyvb6pph3EFnGGTG+2twbnzl8wXoSLm1QvOgTHsfGf68d
         shmujbN6SkPxm1S1pFTtciq8PDW3gYMCXIiXWe7rLFPGW135t0PKUATVI5OHD9a7pGgY
         jKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/QnfMreLw7k9hWIdkOKIDeTaUOSI3b3xQAIkhWiqc0Q=;
        b=K6FeZK08sV+ypcyqqlAAD+mF7HnnQf+r5uRe5u8f4LBkW3LmaeMJoEyJI58hqv7lHZ
         NjLveP6Xr7vdZwx+uD1bgQunjH8jak8pbJ90o2nFZHAr8BwLmr8M/RKdW2pe7Ev1TBmf
         VgfGR9R+RQSf7ACiLIjgN5I3GnkVOQvbxWGKb8ND9ARPfDc6/wj8Hba7hBQ9xwhqgwFr
         79YVAdqqTr5EvEmMKEJ6vqkspCvEjbmjavGA4fMZICUz12B0oUDwpDJou8P8XjRK8n+J
         JULZDZc2YHs7dOxL1qZyKZeZUC8dTEiVgX5CBcShFzFQ+lsQYEqt109dEBVTh6R3n3kh
         7d2w==
X-Gm-Message-State: AOAM531CfsQJx5/AwIuwIKMRq/ausNOifIRE9+Hk2xy3cdgL9eNRGPRk
        wJGf7qreqZe4jYqluVwyQ8z2kuzPWQvSUt4VXMw=
X-Google-Smtp-Source: ABdhPJwbaS0Y7gHjaO8BgzBNlTEOADj5Tp8mfNbVhCQDIdCaEqSCswYz/meYOIAZZ3j/HFh0cT0VaNgXuf7t4OvU38A=
X-Received: by 2002:a25:5054:: with SMTP id e81mr7216140ybb.510.1628284321590;
 Fri, 06 Aug 2021 14:12:01 -0700 (PDT)
MIME-Version: 1.0
References: <1628244763-1113-1-git-send-email-joseph.qi@linux.alibaba.com> <YQ2Chd/j62NCY2NX@kernel.org>
In-Reply-To: <YQ2Chd/j62NCY2NX@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 6 Aug 2021 14:11:50 -0700
Message-ID: <CAEf4BzaNV7bkdDoO4HhcwRO+aY5M=9xxwsTWabUDjt-HzXRVMg@mail.gmail.com>
Subject: Re: [PATCH] pahole: correct libbpf git url
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Joseph Qi <joseph.qi@linux.alibaba.com>, dwarves@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Fri, Aug 6, 2021 at 11:42 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Fri, Aug 06, 2021 at 06:12:43PM +0800, Joseph Qi escreveu:
> > Otherwise it will encounter the following error:
> > fatal: unable to access 'https://github.com/libbpf/libbpf/': Encountered end of file
> > fatal: clone of 'https://github.com/libbpf/libbpf' into submodule path '/home/workspace/pahole/lib/bpf' failed
> >
> > Also update README to add step 'make'.
>
> You forgot to add Andrii, the author of the patch you're fixing, to the
> CC list, please do it next time.

Heh, thanks! Don't worry, I'm subscribed to dwarves@vger, so I saw this anyways.

>
> - Arnaldo
>
> > Fixes: 21507cd3e97b ("pahole: add libbpf as submodule under lib/bpf")
> > Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> > ---
> >  .gitmodules | 2 +-
> >  README      | 3 ++-
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/.gitmodules b/.gitmodules
> > index 6be99dc..8be5eb6 100644
> > --- a/.gitmodules
> > +++ b/.gitmodules
> > @@ -1,3 +1,3 @@
> >  [submodule "lib/bpf"]
> >       path = lib/bpf
> > -     url = https://github.com/libbpf/libbpf
> > +     url = https://github.com/libbpf/libbpf.git

This doesn't hurt, but as Arnaldo pointed out, it seems to work just
fine as is. Not sure how you ran into this problem... And why did it
append the final '/' (still don't know if that's the reason)?

> > diff --git a/README b/README
> > index c9f1737..07f5876 100644
> > --- a/README
> > +++ b/README
> > @@ -4,7 +4,8 @@ Build instructions:
> >  2. mkdir build
> >  3. cd build
> >  4. cmake -D__LIB=lib ..
> > -5. make install
> > +5. make
> > +6. make install

Doesn't make install imply the build as well?


> >
> >  cmake Options:
> >    -DBUILD_SHARED_LIBS
> > --
> > 1.8.3.1
> >
>
> --
>
> - Arnaldo
