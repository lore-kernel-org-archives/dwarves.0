Return-Path: <SRS0=a5OZ=EB=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B895AC4363A
	for <linux-dwarves@archiver.kernel.org>; Mon, 26 Oct 2020 23:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7850720715
	for <linux-dwarves@archiver.kernel.org>; Mon, 26 Oct 2020 23:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsHFTSq8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404519AbgJZXW2 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 26 Oct 2020 19:22:28 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:46925 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404241AbgJZXW1 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 26 Oct 2020 19:22:27 -0400
Received: by mail-yb1-f194.google.com with SMTP id a4so9099891ybq.13
        for <dwarves@vger.kernel.org>; Mon, 26 Oct 2020 16:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dg1eH98pBWwIPpjJzSTrr4m7nXUc+TiGDLtemWWFdgE=;
        b=LsHFTSq86XpSysAkFJFurN12ACmwPiCoZOTzN0R4EXwtMnHcQa19BwRXItWZe05WiD
         a5SlbXW59l0APJ2z8GF/dZFTPIAeeI8iXU011+P7VFizccm1ksw2z5Koai7HfJptm8Wh
         pFjTk9TyHB4f2bRlCgt5sZ0k3/t4Smz20UZWCV8ln3s6ci1r6mNVlGSPcR0KeSqDYc9f
         jaeJlTDFRdFY0MEUxGMelt7lRWajin5Ir5vRM4ms8aHE1j9QFSDt4CIHhBl8lA44RV3M
         WNYj63Q8l9szE4wTr7CkmVzOI5n6ANU6SIEJCOyxP0hR0CvEKxSdtFqBbsLQKQ3VRLGQ
         L0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dg1eH98pBWwIPpjJzSTrr4m7nXUc+TiGDLtemWWFdgE=;
        b=iNE6DV8PQHxKrsJvkyUNW2+9+mOYJOQRf8NFnozfT46cVAyjFab76nXehe316Xcrcu
         nPDIpI8CTulz5Z7lxsqRlWO/2A2x1gC1ZtZjvw9MeC4JeyYd8fa8kVtL28yeltsE7mN4
         UBSgoKzFmHck5wWp9gHoABgIR1+fjtcbxVx3MOtiTe9QZU4BClTPSIl8oyjg223jQCfR
         dJC/oynCUCKl0H/gvAyWHHgA/Y0TTdAJe6OqnSc1qBWOlX74eRxA09/stBX/5OJbGx9t
         9/h4djcuUwmdJCWYxKet/apo6Dz6aYZoA0DhfFeVs69WPd4k418nIylOyMFZVcQY72L2
         gY7Q==
X-Gm-Message-State: AOAM530NIDpzKJ0qfHGJ8ZwE3pRZdCW2F7vO+MhJOhM/RGV8V3I+50Xg
        gj4kK5Aiw8+vjskbWq5VYPQoGqbbfTcky2uC2TQ=
X-Google-Smtp-Source: ABdhPJxdxuDVLXmBRuZmrM1Y/OAeAESfYznzHCM/cqmMHyA8/dTQgBn/r/MqblqrKQX7vPkcYAxoIqZHD+c4+BSZa2g=
X-Received: by 2002:a25:25c2:: with SMTP id l185mr21643873ybl.230.1603754546440;
 Mon, 26 Oct 2020 16:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <20201026221822.29021-1-haoluo@google.com>
In-Reply-To: <20201026221822.29021-1-haoluo@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 26 Oct 2020 16:22:15 -0700
Message-ID: <CAEf4Bza6-L19rguOgPVeFcqjQQGqULVS6g7FPWj4Mm=+GkWa+A@mail.gmail.com>
Subject: Re: [PATCH] btf_encoder: Check var type after checking var addr.
To:     Hao Luo <haoluo@google.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Mon, Oct 26, 2020 at 3:18 PM Hao Luo <haoluo@google.com> wrote:
>
> Commit 2e719cc ("btf_encoder: revamp how per-CPU variables are
> encoded") adds percpu_var_exists() to filter out the symbols that
> are not percpu var. However, the check comes after checking the
> var's type. There can be symbols that are of zero type. If we hit
> that, btf_encoder will not work without '--btf_encode_force'.
> So we should check percpu_var_exists before checking var's type.
>
> Tested:
>  haoluo@haoluo:~/kernel/tip$ gcc --version
>  gcc (GCC) 10.2.0
>  Copyright (C) 2020 Free Software Foundation, Inc.
>  This is free software; see the source for copying conditions.  There is NO
>  warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>
>  Before:
>
>  haoluo@haoluo:~/kernel/tip$ make clean -s
>  haoluo@haoluo:~/kernel/tip$ make -j 32 -s
>    LINK     resolve_btfids
>  error: found variable in CU 'kernel/bpf/btf.c' that has void type
>  Encountered error while encoding BTF.
>  FAILED: load BTF from vmlinux: Unknown error -2make: *** [Makefile:1164: vmlinux] Error 255
>
>  After:
>
>  haoluo@haoluo:~/kernel/tip$ make clean -s
>  haoluo@haoluo:~/kernel/tip$ make -j 32 -s
>    LINK     resolve_btfids
>  haoluo@haoluo:~/kernel/tip$
>
> Fixes: 2e719cc ("btf_encoder: revamp how per-CPU variables are encoded")
> Signed-off-by: Hao Luo <haoluo@google.com>
> ---

Looks good, thanks for the prompt fix!

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  btf_encoder.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 2a6455b..b5f8f3e 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -441,9 +441,12 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
>                 if (var->spec)
>                         var = var->spec;
>
> +               if (!percpu_var_exists(addr, &size, &name))
> +                       continue; /* not a per-CPU variable */
> +
>                 if (var->ip.tag.type == 0) {
> -                       fprintf(stderr, "error: found variable in CU '%s' that has void type\n",
> -                               cu->name);
> +                       fprintf(stderr, "error: found variable '%s' in CU '%s' that has void type\n",
> +                               name, cu->name);
>                         if (force)
>                                 continue;
>                         err = -1;
> @@ -452,8 +455,6 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
>
>                 type = var->ip.tag.type + type_id_off;
>                 linkage = var->external ? BTF_VAR_GLOBAL_ALLOCATED : BTF_VAR_STATIC;
> -               if (!percpu_var_exists(addr, &size, &name))
> -                       continue; /* not a per-CPU variable */
>
>                 if (btf_elf__verbose) {
>                         printf("Variable '%s' from CU '%s' at address 0x%lx encoded\n",
> --
> 2.29.0.rc1.297.gfa9743e501-goog
>
