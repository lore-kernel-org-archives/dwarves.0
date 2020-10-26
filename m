Return-Path: <SRS0=a5OZ=EB=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DB4C4363A
	for <linux-dwarves@archiver.kernel.org>; Mon, 26 Oct 2020 23:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57978207F7
	for <linux-dwarves@archiver.kernel.org>; Mon, 26 Oct 2020 23:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElO51Uzp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404688AbgJZX1A (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 26 Oct 2020 19:27:00 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:38305 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405416AbgJZX0e (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 26 Oct 2020 19:26:34 -0400
Received: by mail-yb1-f195.google.com with SMTP id b138so9127680yba.5
        for <dwarves@vger.kernel.org>; Mon, 26 Oct 2020 16:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=30lgWqUUGcxf9u1hpmdxXGllZTlCRklIqxZXnRepshI=;
        b=ElO51UzpWylEJILVevQbzFNOCRw+HoePCo5cAvjDz3sJvfLtyM3Z7CDmMZn1zDmiNd
         lIUPHnYGVmwqPOlNohdqHuSI6UJsblH2ExQynZ9lfwtsY0JLMTwzy9bmbmuVR6sgb4g7
         wEyTDu19RN7iXel8rRxIWbiUDNjk2Z1kYQoBlnRfvVJK2kfjHMxmavZc0vOI/300gZY4
         qYkGYeczDd9o9C3Ndsj5H+pL8YPm1WF6gGaazzQaT8YHkTguLiW0nZqLK668xw8ntSLt
         18Q8+/Orq8SbdlbqzdVMMpC3MoSmJt94SoYyAksxNQVuHuEsLmQUj46il4fQ+20MTbsi
         Ec8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=30lgWqUUGcxf9u1hpmdxXGllZTlCRklIqxZXnRepshI=;
        b=c+dlLHvq895rnzV7Y8+0GXsmP26X2N3GmypGHiCi+NDGCodmogLj1ER81uJb330QUb
         /vOizeADlVplcib8HUpibFYMr4ZG49mK7V0yewjjHA5E00p+D/snpWTV4bTtAY56ifbf
         ZZ4nPcwDHNg0sO/+wwzPTmONQkRiOjBMvVWtrrkjIizn/OEt2eWM2BHa8pZjti/RXR7c
         E++oJ3hJUkoSF/h2wOF2pDyltVC+sky/WleT890mxBlP7g8BuVh+ruY18PWZ7IIux0Ph
         E+OpirgOOXlcrnnx/8Th657ce3A/sIQz2kf028QXnXXuiXDkft/FkT0tJqQKyvh1OTBa
         Z8nQ==
X-Gm-Message-State: AOAM531ZNPSQHFXXz4njQ9CoPpFIcK2Tv60xG91nkVtTP3jl4M5mjwZ8
        i6Um7wNt2znyyGwg5jiSoJtCDn2evRpO0Nlv83+uzBuOBHTWtQ==
X-Google-Smtp-Source: ABdhPJxdCAjLKzBHrrH3X5YghwDB0hgKF0+LGUnfKu81ez0peQt+icICdarSwE6ZU6RdI+tHlCdm4LfKKangs/9mvV8=
X-Received: by 2002:a25:b0d:: with SMTP id 13mr27807725ybl.347.1603754792794;
 Mon, 26 Oct 2020 16:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <20201024183653.891042-1-andrii@kernel.org> <20201026194908.GC2449445@kernel.org>
In-Reply-To: <20201026194908.GC2449445@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 26 Oct 2020 16:26:22 -0700
Message-ID: <CAEf4BzZ7TwoFJRq0uNs+w5bdXKPoswJzzfcaOn9FNNfTt1Ai7A@mail.gmail.com>
Subject: Re: [PATCH dwarves] cmake: make libbpf's Linux UAPI headers available
 to all binaries
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Mon, Oct 26, 2020 at 12:49 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Sat, Oct 24, 2020 at 11:36:53AM -0700, Andrii Nakryiko escreveu:
> > Now that libbpf is used to implement deduplicated strings container, all of
> > the binaries will need linux/btf.h header to compile properly. libbpf is
> > distributed with its own copies of Linux UAPI headers, so use them during
> > compilation.
>
> Thanks, applied.
>

Still don't see it at
https://git.kernel.org/pub/scm/devel/pahole/pahole.git/, did you
forget to push? This is breaking libbpf and kernel CIs at the moment
:(

> - Arnaldo
>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  CMakeLists.txt | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/CMakeLists.txt b/CMakeLists.txt
> > index 8e9fe4710a0c..84693514e0c8 100644
> > --- a/CMakeLists.txt
> > +++ b/CMakeLists.txt
> > @@ -2,7 +2,9 @@ project(pahole C)
> >  cmake_minimum_required(VERSION 2.8.8)
> >  cmake_policy(SET CMP0005 NEW)
> >
> > -INCLUDE_DIRECTORIES( ${CMAKE_CURRENT_BINARY_DIR} ${CMAKE_CURRENT_SOURCE_DIR} )
> > +INCLUDE_DIRECTORIES(${CMAKE_CURRENT_BINARY_DIR}
> > +                 ${CMAKE_CURRENT_SOURCE_DIR}
> > +                 ${CMAKE_CURRENT_SOURCE_DIR}/lib/bpf/include/uapi)
> >
> >  # Try to parse this later, Helio just showed me a KDE4 example to support
> >  # x86-64 builds.
> > --
> > 2.24.1
> >
>
> --
>
> - Arnaldo
