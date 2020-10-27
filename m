Return-Path: <SRS0=Qbgy=EC=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F529C4363A
	for <linux-dwarves@archiver.kernel.org>; Tue, 27 Oct 2020 18:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7F5F2076D
	for <linux-dwarves@archiver.kernel.org>; Tue, 27 Oct 2020 18:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hz8XSB02"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757453AbgJ0SDJ (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 27 Oct 2020 14:03:09 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:38103 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1824120AbgJ0SDI (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 27 Oct 2020 14:03:08 -0400
Received: by mail-yb1-f196.google.com with SMTP id b138so2012820yba.5
        for <dwarves@vger.kernel.org>; Tue, 27 Oct 2020 11:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cx0zbXitiTb0zVU1e4NiG6RDKCEduJ8kQe2d3Z9/Nyg=;
        b=hz8XSB02QG2jXmjtV+NtKCg1TVv16TbDn5bA6Ee3FoLFdQej2p29mvgolfxX9rnkg+
         A1WrP9P0MuektpWnpnetM7v808C0A1i5L86qJEAtp8vB2HD8RdJ/5pKcaF+5nELymW3M
         IdjuLuvmoNPE7i6UWcit+ghVBez5f/2zYwqkH6Dz8bv4+Xa//lW9nc3jCAjYm8pdk8TD
         Jw2DxbcO1WnIzomOYQ0gNJAr51zHN52YMcPFuVO1z+UJQhiSayNnD3Qq2P/dlPyw2RNe
         YLxD0W+kifynlmFuL9AwU5dVM1R2mvIIX2CdOi/H0rgEPU+cSdImv1B51FIU6YPRGRMX
         nLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cx0zbXitiTb0zVU1e4NiG6RDKCEduJ8kQe2d3Z9/Nyg=;
        b=Z+6UHtjfdFTEOnkPQjgbqu0AyGuC5Suj2GydW37VCIWcUCOYhqUTDDwfQFYyJ0/aVo
         35tniNpEny6oAIvhGgrHgZrA6ahfcmP0Wa0lZC2UvgksfOEBh5oFE9hHmQamVoApnl7z
         lFQ8nIuR7w1/jc4AoVhATtetESmsB4dry5woRP1rvMP6hcogNrz7trYV4MSS0SxxiHAN
         M0fB1n/c0xm2s6/OzJtXouoOE9DIIS6/qXcFYlCY+RlBgJmePfkod4WXrQASghjRP28/
         2Pm+uLAIfMGuMhJvChSIdq6WWUdN3w40yGWDGumwDJiW9xqaltUbZTxdDVRUIWG5AQfN
         clEg==
X-Gm-Message-State: AOAM533HaeLjEZDB31Mes+9jEsE/IKAzJ+PfbaJYNb/8MBHZ/wIzy4NW
        TmU5QMMuTuo9DBhc76f41233bKm2hk+xX0o8faM=
X-Google-Smtp-Source: ABdhPJwIX7qBEvtjY4DpfanuiRy4lftDCxb4L05oMppBZoikUboDnUuKO8VcC3/mIgFdz6viN82x8xn08ofyYuXbaHA=
X-Received: by 2002:a25:b0d:: with SMTP id 13mr5203304ybl.347.1603821787114;
 Tue, 27 Oct 2020 11:03:07 -0700 (PDT)
MIME-Version: 1.0
References: <20201024183653.891042-1-andrii@kernel.org> <20201026194908.GC2449445@kernel.org>
 <CAEf4BzZ7TwoFJRq0uNs+w5bdXKPoswJzzfcaOn9FNNfTt1Ai7A@mail.gmail.com>
 <20201027112050.GI2449445@kernel.org> <20201027122201.GA2479604@kernel.org>
In-Reply-To: <20201027122201.GA2479604@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 27 Oct 2020 11:02:56 -0700
Message-ID: <CAEf4BzYJi7E2Yr_Ru69-iHd16w9eiBTtUtZfNKd4sFgusTk7tQ@mail.gmail.com>
Subject: Re: [PATCH dwarves] cmake: make libbpf's Linux UAPI headers available
 to all binaries
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Tue, Oct 27, 2020 at 5:22 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Oct 27, 2020 at 08:20:50AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Mon, Oct 26, 2020 at 04:26:22PM -0700, Andrii Nakryiko escreveu:
> > > On Mon, Oct 26, 2020 at 12:49 PM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > >
> > > > Em Sat, Oct 24, 2020 at 11:36:53AM -0700, Andrii Nakryiko escreveu:
> > > > > Now that libbpf is used to implement deduplicated strings container, all of
> > > > > the binaries will need linux/btf.h header to compile properly. libbpf is
> > > > > distributed with its own copies of Linux UAPI headers, so use them during
> > > > > compilation.
> > > >
> > > > Thanks, applied.
> > > >
> > >
> > > Still don't see it at
> > > https://git.kernel.org/pub/scm/devel/pahole/pahole.git/, did you
> > > forget to push? This is breaking libbpf and kernel CIs at the moment
> > > :(
> >
> > That got delayed due to that 'void variable found' bug that Hao fixed, I
> > just tested built a kernel with it, rebooting with it, some more testing
> > and it'll go to the public repo,
>
> Rebooted, tested usage of /sys/kernel/btf/vmlinux, pushed to the main
> git.kernel.org and to the mirror at github.
>
> Thanks, please let me know if now everything is ok with the kernel CIs.

Thanks, Arnaldo! All good now.

>
> - Arnaldo
