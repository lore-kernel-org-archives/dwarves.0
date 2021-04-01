Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EBBC433B4
	for <linux-dwarves@archiver.kernel.org>; Thu,  1 Apr 2021 20:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A17676100C
	for <linux-dwarves@archiver.kernel.org>; Thu,  1 Apr 2021 20:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbhDAU5M (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 1 Apr 2021 16:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234145AbhDAU5L (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 1 Apr 2021 16:57:11 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D02C061788
        for <dwarves@vger.kernel.org>; Thu,  1 Apr 2021 13:57:10 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ce10so4826210ejb.6
        for <dwarves@vger.kernel.org>; Thu, 01 Apr 2021 13:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t1dRKLnqRWKm6yq/J0+UE2QfioTVkHwQNH3VvbIzUrA=;
        b=hOoJMIzyd/7f6Ev+fv0+A522rlWIOz3j1XCwCiFgdvOEihhHAdVrZSaeQnUcU1vAHn
         gHDa5WBDdQnaW+kl1vWeZwpsY14IsZNSThQnCZjNK90Ai9kIVMYZCVAGUBfddWHTjOwV
         hXk1IfAvAvjWKhe+jp0XeOKZGPAPWLXMQ7e7zzg+IUHdcjPedEVgyt/GSJTxNzNsAUn0
         vDELIO5j/IRfbvv2UPzVG+VvlRbPwTI+/1qhtPW4uCN5C/DKqi7h5eavj43ZvPhH5BMI
         jyzYoYPQG0eT6nXxq0B+xKpvZrN51OVgQ76obLmT6E48osccfFnf0WrFQUCEsh/ym88d
         fABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t1dRKLnqRWKm6yq/J0+UE2QfioTVkHwQNH3VvbIzUrA=;
        b=KI3C6qnGJL19hVYZFJ0DfxRkMLGOk87TTLDI57UKbVYXot543ZjdiXY0alJNRs5hgT
         LWVX/0kiUgdRWOGROMsQXo2QF/OJuZNnXxtBCwyafcFHBq1/JzZc9RwIb2NroYXTpPr4
         SAwKJWmhCiXg53iCEggCT6jY5qNqrUtwc5DuZHziZCw2xat4bDC4vdYZXwsp37kZIOFh
         yaQlQ6zXwEuolSjjpcCeLBqwH9N+yAR30sBk/Cz6b3f5x1Vc7PblaXrY67OA3LR5z5yf
         jquOsYZySpo7rOn9VP4oW/LbYc2//6znUdE+Z8rrZg4dlhp64d8ZHvuLzQ25lxqBIgCa
         xfwg==
X-Gm-Message-State: AOAM533/yLHnuZdCrLdcZhRG/xMpDEPKrqrCH9E2gNEpPFzNWLuic2g8
        v8sZ72CNKcSNOaWRGJpXxEOI2WgeaMdef8tuQyaK
X-Google-Smtp-Source: ABdhPJzEqQ6qaL7fXt9KQ3eXJPYBo6yWgBRUDM34C5r+a2wPaez551Iix6jo0KOEBNT8OkrSkaYWQoPTiAX21jHOTHI=
X-Received: by 2002:a17:906:4f10:: with SMTP id t16mr11019946eju.531.1617310628363;
 Thu, 01 Apr 2021 13:57:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210401025815.2254256-1-yhs@fb.com> <CAGG=3QWpcCG7b70oQsRTATgt10acEFS=-Tg9U=DHZ6xoS3GeMA@mail.gmail.com>
In-Reply-To: <CAGG=3QWpcCG7b70oQsRTATgt10acEFS=-Tg9U=DHZ6xoS3GeMA@mail.gmail.com>
From:   Bill Wendling <morbo@google.com>
Date:   Thu, 1 Apr 2021 13:56:57 -0700
Message-ID: <CAGG=3QUUYn9K7zVQ1UVZ57_FFeiiOexwq_OgDw9VFPJD3fFbVw@mail.gmail.com>
Subject: Re: [PATCH dwarves 0/2] dwarf_loader: improve cus__merging_cu()
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        David Blaikie <dblaikie@gmail.com>,
        =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        kernel-team@fb.com, Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Thu, Apr 1, 2021 at 12:35 PM Bill Wendling <morbo@google.com> wrote:
>
> On Wed, Mar 31, 2021 at 7:58 PM Yonghong Song <yhs@fb.com> wrote:
> >
> > Function cus__merging_cu() is introduced in Commit 39227909db3c
> > ("dwarf_loader: Permit merging all DWARF CU's for clang LTO built
> > binary") to test whether cross-cu references may happen.
> > The original implementation anticipates compilation flags
> > in dwarf, but later some concerns about binary size surfaced
> > and the decision is to scan .debug_abbrev as a faster way
> > to check cross-cu references. Also putting a note in vmlinux
> > to indicate whether lto is enabled for built or not can
> > provide a much faster way.
> >
> > This patch set implemented this two approaches, first
> > checking the note (in Patch #2), if not found, then
> > check .debug_abbrev (in Patch #1).
> >
> > Yonghong Song (2):
> >   dwarf_loader: check .debug_abbrev for cross-cu references
> >   dwarf_loader: check .notes section for lto build info
> >
> >  dwarf_loader.c | 76 ++++++++++++++++++++++++++++++++++++--------------
> >  1 file changed, 55 insertions(+), 21 deletions(-)
> >
> With this series of patches, the compilation passes for me with
> ThinLTO. You may add this if you like:
>
> Tested-by: Bill Wendling <morbo@google.com>

I did notice these warnings following the "pahole -J .tmp_vmlinux.btf"
command. I don't know the severity of them, but it might be good to
investigate.

$ ./tools/bpf/resolve_btfids/resolve_btfids vmlinux
  BTFIDS  vmlinux
WARN: multiple IDs found for 'inode': 355, 8746 - using 355
WARN: multiple IDs found for 'file': 588, 8779 - using 588
WARN: multiple IDs found for 'path': 411, 8780 - using 411
WARN: multiple IDs found for 'seq_file': 1414, 8836 - using 1414
WARN: multiple IDs found for 'vm_area_struct': 538, 8873 - using 538
WARN: multiple IDs found for 'task_struct': 28, 8880 - using 28
WARN: multiple IDs found for 'inode': 355, 9484 - using 355
WARN: multiple IDs found for 'file': 588, 9517 - using 588
WARN: multiple IDs found for 'path': 411, 9518 - using 411
WARN: multiple IDs found for 'seq_file': 1414, 9578 - using 1414
WARN: multiple IDs found for 'vm_area_struct': 538, 9615 - using 538
WARN: multiple IDs found for 'task_struct': 28, 9622 - using 28
WARN: multiple IDs found for 'seq_file': 1414, 12223 - using 1414
WARN: multiple IDs found for 'file': 588, 12237 - using 588
WARN: multiple IDs found for 'path': 411, 12238 - using 411
...

-bw
