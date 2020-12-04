Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF35CC433FE
	for <linux-dwarves@archiver.kernel.org>; Fri,  4 Dec 2020 23:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CACC2078D
	for <linux-dwarves@archiver.kernel.org>; Fri,  4 Dec 2020 23:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgLDXOt (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 4 Dec 2020 18:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbgLDXOt (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Fri, 4 Dec 2020 18:14:49 -0500
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9651C0613D1
        for <dwarves@vger.kernel.org>; Fri,  4 Dec 2020 15:14:08 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id r127so6948074yba.10
        for <dwarves@vger.kernel.org>; Fri, 04 Dec 2020 15:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TN9Rq5K01ZU+C0MyKy1KxysvkMs1xM8xbPIXCT8rM9I=;
        b=IoCE0bpJoJH61FQoNYotXRUM2CAqWDwD+iD7qzRmIGxsK4NUPPszgtYHB3af0rfAoE
         2uJVZcqsXojoCxDe1Qpx18+dN4ZoIfb9ZXpoUOcVeLzQGLaNKRJiI26kij6wy8Tc5u+Z
         XGhX+J4/nPT1xLcOvZKY/ll0I+U/sB1nQDCUorNVh0V2qJG/SrUs3OYmgVhzbGGc6vsG
         OPUUaPlF5R9iNfhpmGAqbC13v9P78rrQ6WyL01B5CMYM5yt8RmlILwmhmDJojp0UkWSR
         70MXixdOgMzIBfV9EAmZiO3PxzxsRQZWbiJttPFfHU9iIPR/A8EmM3ExQVRh99hd/eAP
         fWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TN9Rq5K01ZU+C0MyKy1KxysvkMs1xM8xbPIXCT8rM9I=;
        b=H5Uu9pYMVJBwmqTYlDrfcBaq3jgxVHzW3kf+saBVZhamZhzKmYn2vBIUrvXGIeRpbs
         mAxfZLpovnixHLx5Hlrzdge6wMSwJIOAbMc3HOZimW22sCsda2x+us3FHjiYWqDQgFlM
         ht/VIX5tgRdBwYGQVqt+jeWFdctBG6VXVRZQ/AlRAJ1p04MEAWxuNoETTCyBF7bCm+2W
         osY7vi/4hFoU3b4ZTvEsiygqP5y+775t4DrwWRS6CCsNq7MpKkMJaZrPejL/e4B/kvtF
         eM+Y+OtVk8Atm19z2yLPiuOrMObsX4rJOT2vvQ/cEnp9wel92yP8wt1pCjiAnNAHdIEU
         BJQg==
X-Gm-Message-State: AOAM532HsvnGhXLBqBkQKIF7YJ06m8F1RjjT8ium3iOTVpyvWXdWxn7R
        mDWCsPcc7Sm8AOHOYiEypZpxNgvXSFsE3OG3CWM=
X-Google-Smtp-Source: ABdhPJzALLE7/ujAWhnpp16RWfVAz1tFb/wzoYwJEQINMzHcwbqPbuJelmRQTm3iRU0FXZ850b5nmZtNYATM6i7NTyE=
X-Received: by 2002:a25:6a05:: with SMTP id f5mr5674444ybc.459.1607123648001;
 Fri, 04 Dec 2020 15:14:08 -0800 (PST)
MIME-Version: 1.0
References: <20201204212014.2983374-1-andrii@kernel.org> <20201204230128.GA122569@kernel.org>
In-Reply-To: <20201204230128.GA122569@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 4 Dec 2020 15:13:57 -0800
Message-ID: <CAEf4BzaQAYWiLF+OZt98FTfNvtpj==0wTdpuus_3HHE9fbpegg@mail.gmail.com>
Subject: Re: [PATCH dwarves] rpm: fix changelog date
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Fri, Dec 4, 2020 at 3:01 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Fri, Dec 04, 2020 at 01:20:14PM -0800, Andrii Nakryiko escreveu:
> > It causes errors when trying to import 1.19 version.
>
> Thanks, applied, will go thru the fixes from Jiri that you already acked
> and probably do a quick v1.20.

Quick 1.20 with module static functions works for me even better!
Please see the RPM spec bug on the other thread, I think we finally
figured out why libdwarves1 was never upgraded properly.

>
> - Arnaldo
>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  rpm/SPECS/dwarves.spec | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/rpm/SPECS/dwarves.spec b/rpm/SPECS/dwarves.spec
> > index 9232002ccd28..693a9da19c82 100644
> > --- a/rpm/SPECS/dwarves.spec
> > +++ b/rpm/SPECS/dwarves.spec
> > @@ -275,7 +275,7 @@ rm -Rf %{buildroot}
> >  * Sat Nov 20 2010 Arnaldo Carvalho de Melo <acme@redhat.com> - 1.9-1
> >  - New release
> >
> > -* Tue Feb 08 2011 Fedora Release Engineering <rel-eng@lists.fedoraproject.org> - 1.8-2
> > +* Tue Feb 08 2010 Fedora Release Engineering <rel-eng@lists.fedoraproject.org> - 1.8-2
> >  - Rebuilt for https://fedoraproject.org/wiki/Fedora_15_Mass_Rebuild
> >
> >  * Fri Dec  4 2009 Arnaldo Carvalho de Melo <acme@redhat.com> - 1.8-1
> > --
> > 2.24.1
> >
>
> --
>
> - Arnaldo
