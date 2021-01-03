Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FE6C433E0
	for <linux-dwarves@archiver.kernel.org>; Sun,  3 Jan 2021 19:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BA2620786
	for <linux-dwarves@archiver.kernel.org>; Sun,  3 Jan 2021 19:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbhACTLP (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Sun, 3 Jan 2021 14:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbhACTLP (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Sun, 3 Jan 2021 14:11:15 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109E3C061573
        for <dwarves@vger.kernel.org>; Sun,  3 Jan 2021 11:10:35 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id y128so24047310ybf.10
        for <dwarves@vger.kernel.org>; Sun, 03 Jan 2021 11:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SVCbhCsyUmSir0x0r4AJ8nziY1s+eWc0hMoIdbFJBWY=;
        b=PCzz1xEkuPmV++KPYulyjjzYXR2XzznBGNyb5qIFDoMpWO+GMooNRQrT2BKff6Qwl2
         gZRm9Ii6wZCr317EPoDD119atc3btRuq5+j2bb8qUBb//4cB5XcJ0DivUCB1s/3Erm/I
         OuRjbSksBB56d5FVwEmZssftVuWqj1+Yye9V71Csrl5Kbvp/Bp+2zNvtdAYQ4BfUIPs1
         sD9OP141GGIaJuEcLTCAVH58L+27T8VYEIULDVXe8RHwwhTilM2lsJ4Sd54/OdJDVXmT
         vrTUwcXGQ6T1OB3CegJ680YaLp09BXPpSSQ0HiRjlY1PplF/3Ov7mY990BgICZkB4d8A
         qASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SVCbhCsyUmSir0x0r4AJ8nziY1s+eWc0hMoIdbFJBWY=;
        b=akN4CWTSS9/F/3hRNbkeH/RU/xvKNlCwyP9r8gkQ43HM9ACLsxqcdJH740E+sstzln
         FMkvXdgXrbrf/o3AlpjAi3K4pmAJlwy2pJpkFnrUQmWpot/yXE4OLQ6HPinxI/uoTshb
         ZUIMC/2z+suOE/J2xMA/lcxMEEG4ZK4SONPcWQfl8wL9Cr82GkWZSI5mFssY/yq5Rj7x
         bbPIlnN+ZSXtx+1096T89iJv0HPXvgjl8PaXcQLI1Q5RMV9UhohJPCgU7Lj87ltKb4qA
         P3d992HTqf/71E2UD7yXj6n5bWCgGwNbdQYEVtFV3RLVr3rVH6lpRjYXarKCTWfq996g
         rnQA==
X-Gm-Message-State: AOAM530guCjIiWWHCa2p+a6wiOga8oNlbAflsLO9hrY+QG9FrMx5Xwub
        Q3ERMxmKkTQePD/bMW5Eo0Edi87JiQA1JreuOqqRNsye
X-Google-Smtp-Source: ABdhPJxLSLTd9uX4jD19Ldu/NsWI9/8w8QcIo0h/oQzfEUUWQTf9PqRnh+sOF4PTkWDQclCEYpblWa0i0KfdJeqRyGc=
X-Received: by 2002:a25:c7c6:: with SMTP id w189mr100129096ybe.403.1609701034109;
 Sun, 03 Jan 2021 11:10:34 -0800 (PST)
MIME-Version: 1.0
References: <20210102182201.122619-1-bluca@debian.org>
In-Reply-To: <20210102182201.122619-1-bluca@debian.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sun, 3 Jan 2021 11:10:23 -0800
Message-ID: <CAEf4Bzb3jtv4+KBRNOzfERWyx_4Wh_m7xRrWcc7nAgoXi+yW-Q@mail.gmail.com>
Subject: Re: [PATCH dwarves] libbpf: allow to use packaged version
To:     Luca Boccassi <bluca@debian.org>
Cc:     dwarves@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Sat, Jan 2, 2021 at 10:25 AM Luca Boccassi <bluca@debian.org> wrote:
>
> Add a new CMake option, LIBBPF_EMBEDDED, to switch between the
> embedded version and the system version (searched via pkg-config)
> of libbpf. Set the system version as the default.
>

There's been a lot of arguments about libbpf as a submodule, so I
don't think we need to go about pros and cons again, but I just wanted
to cast my vote against doing this at all. Having pahole built with
libbpf statically (only) was a great thing for me so far with
iterating quickly and adopting new APIs without overcomplicating the
source code with all sorts of feature detection code. Without it,
adopting libbpf's faster string deduplication, BTF writing APIs,
module/split BTFs, etc, etc, would be much bigger PITA and/or would
prolong such changes. To the point that I personally wouldn't bother
with some of them at all. Distro maintainers obviously don't care
about such inconveniences for developers, but it's a real factor in
determining what kind of functionality is implemented in pahole, so I
hope Arnaldo won't dismiss this without thinking about this carefully.

> Signed-off-by: Luca Boccassi <bluca@debian.org>
> ---
> Note: I can switch the default around if you prefer.

With BCC you seem to go with the default preserving existing behavior
(using libbpf from a submodule), so if we do this, I think the default
should be flipped.

>
>  CMakeLists.txt   | 49 +++++++++++++++++++++++++++++++++++-------------
>  btf_encoder.c    |  5 +++++
>  btf_loader.c     |  4 ++++
>  libbtf.c         |  6 ++++++
>  libbtf.h         |  4 ++++
>  pahole.c         |  4 ++++
>  pahole_strings.h |  4 ++++
>  strings.c        |  4 ++++
>  8 files changed, 67 insertions(+), 13 deletions(-)
>

[...]

>  #include "dutil.h"
> +#ifdef LIBBPF_FOUND
> +#include <bpf/libbpf.h>
> +#else
>  #include "lib/bpf/src/libbpf.h"
> +#endif

this is horrible, are you sure there is no way to make <bpf/libbpf.h>
work for both cases?

>
>  struct strings *strings__new(void)
>  {
> --
> 2.29.2
>
