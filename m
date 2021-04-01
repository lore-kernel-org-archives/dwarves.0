Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80A9C433ED
	for <linux-dwarves@archiver.kernel.org>; Thu,  1 Apr 2021 19:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4F3161001
	for <linux-dwarves@archiver.kernel.org>; Thu,  1 Apr 2021 19:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbhDAT0q (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 1 Apr 2021 15:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234613AbhDAT0m (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 1 Apr 2021 15:26:42 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910F2C02FE97
        for <dwarves@vger.kernel.org>; Thu,  1 Apr 2021 11:50:16 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id b4so4319990lfi.6
        for <dwarves@vger.kernel.org>; Thu, 01 Apr 2021 11:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1KmEagxK+rhdAhvN7uNMepKmJEX8gVa3xuxeYizT0aQ=;
        b=LJ6w4Y2MjdRR9qq6CmzLbI/1TIGqZxQz3fw/4U4ekFeyWFUGW7JANMOSJun4pZvhZw
         0IfgNf7PA2cHVO8cvFSNXUgTdqv9CQ9UVLyL5IRijcT9PZjLOC5Wv/+ZW847NudcwHwB
         s9drZQTiwl72nebslb9YgbCW/5eWip06VuOdPubCKv5xQk2WwlsoC6kUAkCgzGAMLzHR
         Uy1x8e+xn+aj5Nl703kI8nraLZKOoH9n0Sc23mU2No2drb1zIkUXOquRizeyXAPrrlvN
         J2rKHihIJNb7dc4Gz1PodvPmohjGOFoYOmg7rEy+cGZEyjej7lTAW8g3FthGnJRfpA/n
         T+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1KmEagxK+rhdAhvN7uNMepKmJEX8gVa3xuxeYizT0aQ=;
        b=TcBo9Vux+n5ySb+AagQKEAMLtT/OD7ZrlsAvEVjg9XosQARbiVnRHHPW7B7tuoefC0
         p4JSz3QjnA/izh9jzMzY9/UIPzj58nhflaYa1fjg9HfsRDZI2xoE8PAa9WAT2Xpa4JS3
         hLWeuytnNxbVnbzAlQSs3gpQw3biTW8jOso18m+S9hs5abjc8IXMJuSQrs4VZxu9PSg3
         QgsVFBb0lkA73zkrzN10JZxj3YhBmC6SDAjulJDRqrm8drS5hAl15FYlUmMLewZRSkJJ
         W7pVT/2U1eSlfSwRTGVF38kjM5a3Z9HKy2ysjVsNVJZJ43JS05DKKod9gi1kXvZNorQf
         Yu1w==
X-Gm-Message-State: AOAM531azv9ntfWXNpvwpsKFnkw+L0/OCTYZADRDYrPR4/9in5Flh/g0
        tgAxqJ93AjLpxVpKssXAz8qnb/sG619Iyf2gI4yRXeeLBu4cig==
X-Google-Smtp-Source: ABdhPJzvHydJMrRKLEe5lQTcugNGl+V7JelQ4joFmeW58ikkQ+BHMey+pVknxNuG9KflDH1qaMkAGKFZm/ll5ytWc2s=
X-Received: by 2002:a19:8c19:: with SMTP id o25mr6411654lfd.547.1617303014926;
 Thu, 01 Apr 2021 11:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210401025815.2254256-1-yhs@fb.com>
In-Reply-To: <20210401025815.2254256-1-yhs@fb.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 1 Apr 2021 11:50:03 -0700
Message-ID: <CAKwvOdka=a-RtLzBdEQm5s570rLSDLfRD4Xf8SxOQHWcTdUz3w@mail.gmail.com>
Subject: Re: [PATCH dwarves 0/2] dwarf_loader: improve cus__merging_cu()
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bill Wendling <morbo@google.com>, bpf <bpf@vger.kernel.org>,
        David Blaikie <dblaikie@gmail.com>,
        =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        kernel-team@fb.com,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Wed, Mar 31, 2021 at 7:58 PM Yonghong Song <yhs@fb.com> wrote:
>
> Function cus__merging_cu() is introduced in Commit 39227909db3c
> ("dwarf_loader: Permit merging all DWARF CU's for clang LTO built
> binary") to test whether cross-cu references may happen.
> The original implementation anticipates compilation flags
> in dwarf, but later some concerns about binary size surfaced
> and the decision is to scan .debug_abbrev as a faster way
> to check cross-cu references. Also putting a note in vmlinux
> to indicate whether lto is enabled for built or not can
> provide a much faster way.
>
> This patch set implemented this two approaches, first
> checking the note (in Patch #2), if not found, then
> check .debug_abbrev (in Patch #1).

For the series:

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

(Noting for others on our mailing list:
https://lore.kernel.org/linux-kbuild/20210401012406.1800957-1-yhs@fb.com/
is a series of kernel patches required to test this. I had feedback on
the kernel patches, but this approach in pahole LGTM since I think
using simple notes in ELF is a good approach).

>
> Yonghong Song (2):
>   dwarf_loader: check .debug_abbrev for cross-cu references
>   dwarf_loader: check .notes section for lto build info
>
>  dwarf_loader.c | 76 ++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 55 insertions(+), 21 deletions(-)
>
> --
> 2.30.2
>


--
Thanks,
~Nick Desaulniers
