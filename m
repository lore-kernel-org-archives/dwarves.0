Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5DCC433ED
	for <linux-dwarves@archiver.kernel.org>; Fri,  2 Apr 2021 19:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50F3F6115C
	for <linux-dwarves@archiver.kernel.org>; Fri,  2 Apr 2021 19:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235938AbhDBTpF (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 2 Apr 2021 15:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbhDBTpE (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Fri, 2 Apr 2021 15:45:04 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB519C0613E6
        for <dwarves@vger.kernel.org>; Fri,  2 Apr 2021 12:45:02 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id bf3so6389134edb.6
        for <dwarves@vger.kernel.org>; Fri, 02 Apr 2021 12:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zcF9qgZiHLnN9T4lFl4zcLX2Wynh3BKU27WpuIrGe9g=;
        b=WFGKBv+jMWcbUwJ1cWdfHLb0/DF/n2BOIOpHBdW4hLryupocuFHoPqhSA/pzqGpJxb
         cpMbDzL64ycC0tk7LBCki9Oh/v9Z4yx0e6nZ9dJEj8DN7GThFGMEN+Fb6JdxrcGZ9AYK
         3Bc0sSdY00BPQFyFmzxS+7aHU7rsX5oZP4TqY22jY92CXMAgin8HtEsIX9hMrlTiMbQy
         vW5E1k557bSAUFsS2t/X0h0BY2Jah9+teeEaUQnR9AVfxOzIA9/dsJNqtAy47khe3oDT
         exFOnZNJ+fcC7N/WGg18bQSA63gtWpR2ZCzM9wA+VB4yJPxvYUZZuVer+xIRKKv3w00J
         vfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zcF9qgZiHLnN9T4lFl4zcLX2Wynh3BKU27WpuIrGe9g=;
        b=lSD1O3chnfBErL/3Avy21js61Y3rbZ+zRW88LtvikdiwSopkKu3tTfxIU7MjA1uO2r
         zzE3ettAiPcsbswfSJisYXOXIbV2J3Mwr5g/zfwL6JYCTHtQ46zh20RqD8teGlbjGGcD
         mgNn1k3OsimAZUByFlDxlPpQBKhCeS1xO4vGKs5soUfRY50dajRluzpylvSeqsjwyiXn
         Z5qpgrupbgTgqJl+ClJVfBatSDkZkZ/FtuPw8EbA7IDojkfIJqen47S2xgfF4bAj1z1d
         FPUGb1b+PjfCXQxMBhuRw/l75tns5RTEp5VcctD6KVExNNrxKaDrCkgHsuchwcnmIieM
         cXCQ==
X-Gm-Message-State: AOAM533xB90pUXAE2qFSbt9keUlpj3QZZPJX4+MsWY6YcYT9YFmvo9Z1
        fKQ726FYSldL8SDgHnAbHmLVu66EVcI0+y1y/kAs
X-Google-Smtp-Source: ABdhPJzRxOjjR6cPR+ric1hQGmLt5u+wiRk8yIoMQdqq833wTZGa8QTcm3WpCjZQFs5+oc22Z6afajXFEDbVoYmX1Aw=
X-Received: by 2002:aa7:db01:: with SMTP id t1mr17341313eds.77.1617392701367;
 Fri, 02 Apr 2021 12:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210401025815.2254256-1-yhs@fb.com> <CAGG=3QWpcCG7b70oQsRTATgt10acEFS=-Tg9U=DHZ6xoS3GeMA@mail.gmail.com>
 <CAGG=3QUUYn9K7zVQ1UVZ57_FFeiiOexwq_OgDw9VFPJD3fFbVw@mail.gmail.com> <06ba2ed4-2730-9ce8-0665-3c720bc786a3@fb.com>
In-Reply-To: <06ba2ed4-2730-9ce8-0665-3c720bc786a3@fb.com>
From:   Bill Wendling <morbo@google.com>
Date:   Fri, 2 Apr 2021 12:44:50 -0700
Message-ID: <CAGG=3QXkvwrm_tnsYtJ-gvHw8Emv5xFWeckoPoD4PhEud7v8EA@mail.gmail.com>
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

I tried porting the .config we're using to the official branch and
couldn't replicate the problem. It's probably something local.

-bw

On Thu, Apr 1, 2021 at 3:00 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 4/1/21 1:56 PM, Bill Wendling wrote:
> > On Thu, Apr 1, 2021 at 12:35 PM Bill Wendling <morbo@google.com> wrote:
> >>
> >> On Wed, Mar 31, 2021 at 7:58 PM Yonghong Song <yhs@fb.com> wrote:
> >>>
> >>> Function cus__merging_cu() is introduced in Commit 39227909db3c
> >>> ("dwarf_loader: Permit merging all DWARF CU's for clang LTO built
> >>> binary") to test whether cross-cu references may happen.
> >>> The original implementation anticipates compilation flags
> >>> in dwarf, but later some concerns about binary size surfaced
> >>> and the decision is to scan .debug_abbrev as a faster way
> >>> to check cross-cu references. Also putting a note in vmlinux
> >>> to indicate whether lto is enabled for built or not can
> >>> provide a much faster way.
> >>>
> >>> This patch set implemented this two approaches, first
> >>> checking the note (in Patch #2), if not found, then
> >>> check .debug_abbrev (in Patch #1).
> >>>
> >>> Yonghong Song (2):
> >>>    dwarf_loader: check .debug_abbrev for cross-cu references
> >>>    dwarf_loader: check .notes section for lto build info
> >>>
> >>>   dwarf_loader.c | 76 ++++++++++++++++++++++++++++++++++++--------------
> >>>   1 file changed, 55 insertions(+), 21 deletions(-)
> >>>
> >> With this series of patches, the compilation passes for me with
> >> ThinLTO. You may add this if you like:
> >>
> >> Tested-by: Bill Wendling <morbo@google.com>
> >
> > I did notice these warnings following the "pahole -J .tmp_vmlinux.btf"
> > command. I don't know the severity of them, but it might be good to
> > investigate.
> >
> > $ ./tools/bpf/resolve_btfids/resolve_btfids vmlinux
> >    BTFIDS  vmlinux
> > WARN: multiple IDs found for 'inode': 355, 8746 - using 355
> > WARN: multiple IDs found for 'file': 588, 8779 - using 588
> > WARN: multiple IDs found for 'path': 411, 8780 - using 411
> > WARN: multiple IDs found for 'seq_file': 1414, 8836 - using 1414
> > WARN: multiple IDs found for 'vm_area_struct': 538, 8873 - using 538
> > WARN: multiple IDs found for 'task_struct': 28, 8880 - using 28
> > WARN: multiple IDs found for 'inode': 355, 9484 - using 355
> > WARN: multiple IDs found for 'file': 588, 9517 - using 588
> > WARN: multiple IDs found for 'path': 411, 9518 - using 411
> > WARN: multiple IDs found for 'seq_file': 1414, 9578 - using 1414
> > WARN: multiple IDs found for 'vm_area_struct': 538, 9615 - using 538
> > WARN: multiple IDs found for 'task_struct': 28, 9622 - using 28
> > WARN: multiple IDs found for 'seq_file': 1414, 12223 - using 1414
> > WARN: multiple IDs found for 'file': 588, 12237 - using 588
> > WARN: multiple IDs found for 'path': 411, 12238 - using 411
> > ...
>
> I didn't see it with my config. Maybe you can share your config file?
>
> >
> > -bw
> >
