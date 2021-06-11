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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE598C48BE5
	for <linux-dwarves@archiver.kernel.org>; Fri, 11 Jun 2021 23:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9105613A9
	for <linux-dwarves@archiver.kernel.org>; Fri, 11 Jun 2021 23:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhFKXou (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 11 Jun 2021 19:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhFKXou (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Fri, 11 Jun 2021 19:44:50 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06DCC061574
        for <dwarves@vger.kernel.org>; Fri, 11 Jun 2021 16:42:35 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id c14so6604198ybk.3
        for <dwarves@vger.kernel.org>; Fri, 11 Jun 2021 16:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zc+oJaGzyOSolAmOr0AtAODuJ5sQzTx5Mzcu0w6Qhy4=;
        b=Jjt6J9o9s+FggL+zvYj29XgceS/om4/tsgFALzEE7UQdnmgUtrK//ooVuA+EYLsQfp
         gVjU3VnFpgfKtWM3jxVeRUA4DrqwTd3BqGaOTK1zYM1dFS14fP/nXzKxMpGsWH5yflNs
         Ud8g0ZyKJaJLPnaR3S1sSZFjaV8SSy3BefXGxihTF+tmq3kT0v11D/ZjZhEwl9E0tYhC
         qQhrnWHtMAfasJrBz+Cy0c+x5ELESwnU1BpW6wSA0bq12EWHaxE4VrklRLhJJdG0sGVe
         LcGhci8A/+1/ZYIvijr4+BqPoUe25dopf0qPBlAmPFTPnJGAxJ3PBlVpw+eIIDR4JAJ1
         NwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zc+oJaGzyOSolAmOr0AtAODuJ5sQzTx5Mzcu0w6Qhy4=;
        b=KGdGlpSUGGnNeCna8N4PoMCxGijtbe4UqselV4IofU5UdYH8NVXMJgDZKNBKROQv14
         DK9yM9W2jcbFCEAO6FY/SLVARAH93Bj31mmlTpNsjNR+D03FycBnJsMWdSSSkgKzY9VL
         p+5ThPD3yFJVOIcXjxopEa+ujYr5Pz8DhdVNHiD+2Tu6JIiVnKYNkUHFVUoL3vz+3Wu/
         /QeBl8tdpgoz9wa/63TueYH8WhtsCJJE6Hd1bGw1+UmecyrspbuU/IOZJlyEDNKRNaCD
         F0GjV782b1PuaMkLb8cI2jQkaXZ0Fija3AhAAXAHd+IsjPLPLxRhk9jT20h7zCgSzXAY
         7KgQ==
X-Gm-Message-State: AOAM533IDN6EWt5cYBLBwF9ZM+MYU8EKJelG/h7El+PS0gfp+tWSOYLP
        7ppkos/XRrpuNzQH0xH2hh5kZznD052qGb2Y9sgzQ9k9KJyN/g==
X-Google-Smtp-Source: ABdhPJzl6CHwW/p9mSyEJypIaSQCIJkSdYlt5GFiG4qLOnsv/1bocftgr/7QgVybvXijBuoJuXAfyV0fitvASXozJZ4=
X-Received: by 2002:a5b:f05:: with SMTP id x5mr8977218ybr.425.1623454955216;
 Fri, 11 Jun 2021 16:42:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210611230126.57713-1-bluca@debian.org>
In-Reply-To: <20210611230126.57713-1-bluca@debian.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 11 Jun 2021 16:42:24 -0700
Message-ID: <CAEf4BzYTSd1PvreyK8gsdL6=XPPqELQpz7DYAc-B=cH7L0QDKQ@mail.gmail.com>
Subject: Re: [PATCH dwarves] Add missing lib/include/bpf -> ../bpf/src symlink
To:     Luca Boccassi <bluca@debian.org>
Cc:     dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Fri, Jun 11, 2021 at 4:03 PM Luca Boccassi <bluca@debian.org> wrote:
>
> The original "libbpf: allow to use packaged version" had a symlink
> as suggested during review:
>
> https://www.spinics.net/lists/dwarves/msg00738.html
>
> git show 82749180b23d3c9c060108bc290ae26507fc324e -- lib/include
> commit 82749180b23d3c9c060108bc290ae26507fc324e
> Author: Luca Boccassi <bluca@debian.org>
> Date:   Mon Jan 4 22:16:22 2021 +0000
>
>     libbpf: allow to use packaged version
>
>     Add a new CMake option, LIBBPF_EMBEDDED, to switch between the
>     embedded version and the system version (searched via pkg-config)
>     of libbpf. Set the embedded version as the default.
>
>     Signed-off-by: Luca Boccassi <bluca@debian.org>
>     Cc: dwarves@vger.kernel.org
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> diff --git a/lib/include/bpf b/lib/include/bpf
> new file mode 120000
> index 0000000..4c41b71
> --- /dev/null
> +++ b/lib/include/bpf
> @@ -0,0 +1 @@
> +../bpf/src
> \ No newline at end of file
>
> This patch was reverted, and then re-added manually.
> But the re-add dropped the symlink, which causes the system bpf/btf.h
> to be picked up instead of the local one. Re-add it.
>
> Signed-off-by: Luca Boccassi <bluca@debian.org>
> ---

This fixes the issue for me in my local setup:

Acked-by: Andrii Nakryiko <andrii@kernel.org>


Arnaldo,

Locally I have still another issue, which I don't believe is related
to Luca's changes. I get this error:

$ make -j60
[ 25%] Built target bpf
[ 26%] Building C object CMakeFiles/dwarves.dir/btf_encoder.c.o
In file included from /usr/include/sys/stat.h:106:0,
                 from /home/andriin/local/pahole/btf_encoder.c:24:
/usr/include/bits/stat.h:106:31: error: expected identifier or =E2=80=98(=
=E2=80=99
before =E2=80=98[=E2=80=99 token
     __syscall_slong_t __unused[3];
                               ^
/usr/include/bits/stat.h:164:31: error: expected identifier or =E2=80=98(=
=E2=80=99
before =E2=80=98[=E2=80=99 token
     __syscall_slong_t __unused[3];
                               ^
make[2]: *** [CMakeFiles/dwarves.dir/btf_encoder.c.o] Error 1
make[1]: *** [CMakeFiles/dwarves.dir/all] Error 2
make: *** [all] Error 2


I think it's some new interplay with dutil.h header defining its own

#define __unused __attribute__ ((unused))

Given __unused is used in vmlinux.h and /usr/include/bits/stat.h as
field names, I think it would be better to rename __unused macro
within pahole source code to avoid such confusing problems.


>  lib/include/bpf | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 120000 lib/include/bpf
>
> diff --git a/lib/include/bpf b/lib/include/bpf
> new file mode 120000
> index 0000000..4c41b71
> --- /dev/null
> +++ b/lib/include/bpf
> @@ -0,0 +1 @@
> +../bpf/src
> \ No newline at end of file
> --
> 2.30.2
>
