Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B49C433DB
	for <linux-dwarves@archiver.kernel.org>; Fri, 22 Jan 2021 22:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00D9523B70
	for <linux-dwarves@archiver.kernel.org>; Fri, 22 Jan 2021 22:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbhAVWAx (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 22 Jan 2021 17:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730189AbhAVUGW (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Fri, 22 Jan 2021 15:06:22 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4803C0613D6;
        Fri, 22 Jan 2021 12:05:40 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id r32so6619378ybd.5;
        Fri, 22 Jan 2021 12:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yIJeE19Ex412BCh+tXZdyqfHWVAMXMH3ZAW2ZmTwEvs=;
        b=EHtGF6/TD4BsGrkHJBxIryItSGkMyar7VNULjL950bhJ7Mh2bp2g43eQEkoX80cCjD
         Jt1sAd7/bb5badTmt81icFDmrkYmgGXtsOUYhX7ytNeVi1ZgdCehzUkSTYJlXfckYPOD
         9PD0TZPBTGegD1cR+ioo9v5zlxzrqjG3nCK45JgsmfylzMs7HVJfcgzwxTG0wcOER30+
         +/PvU5KKMLwcW66J++eacO4l5qppcU3C+/7io+An8WGnWHpgFXAI6Q3mEcf/tUyH57b8
         08bF+7ag+E0cvRsPGtCpkxraJnPU68RRkiNaVjgZfyqdg+KzONT7H0p0UHFNGIztDVd1
         I8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yIJeE19Ex412BCh+tXZdyqfHWVAMXMH3ZAW2ZmTwEvs=;
        b=cAuhSwLhcktQD242baBGY/jrQGheACQvnxXgMm/5uTxM6LemKEYDan2Sd6tL8ch8KZ
         SrYB2UQCxSEXARljiF1coi4oGOGgHCq+PEFEnWB92oC01JrAYGyK6XGIqNlrmOWumjRw
         MGMXieRXg6vw/XPDo17x/77YVB5+7rJuMXjxmBfxLOO6RzBeOFa+rAf3GFtDvrlFf6P/
         W51S6+v6VT7s79k72oY3lBo/XRVb6SRmB4eykvlhvG9k/f5RxiSGv8QWdUBdxVUzXOy+
         HuCxbxPPxsQ1iyei7WoySc8cxp6C2WFtjgEfa1m+HH4sJKQq6pqOylDJUsXRrVISMJJM
         R53A==
X-Gm-Message-State: AOAM5330KYsjkW4u+r3yPjUf8tDIwkMrwxSIQg4g+YFPyboDEUYddytK
        Co1MvgTy0CfZz6wdex+Mrijt3aVt39YRMTZEqNA=
X-Google-Smtp-Source: ABdhPJzH9EaAVMjy4oznG8MRXKCsklDSK7xJtJFAv5F51i+auk5rZ05L0WLF6kwCNTlgofr+6K0ySUs/6QM8cBv+MZg=
X-Received: by 2002:a25:9882:: with SMTP id l2mr8206839ybo.425.1611345940074;
 Fri, 22 Jan 2021 12:05:40 -0800 (PST)
MIME-Version: 1.0
References: <20210122163920.59177-1-jolsa@kernel.org> <20210122163920.59177-2-jolsa@kernel.org>
In-Reply-To: <20210122163920.59177-2-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 22 Jan 2021 12:05:28 -0800
Message-ID: <CAEf4BzZEeuw0LPVHcR_7wvt14jkWZdSa9Rf-cGwpgJ57Rg9qHA@mail.gmail.com>
Subject: Re: [PATCH 1/2] elf_symtab: Add support for SHN_XINDEX index to elf_section_by_name
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>, dwarves@vger.kernel.org,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>, Hao Luo <haoluo@google.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Fri, Jan 22, 2021 at 9:22 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> In case the elf's header e_shstrndx contains SHN_XINDEX,
> we need to call elf_getshdrstrndx to get the proper
> string table index.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  dutil.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/dutil.c b/dutil.c
> index 7b667647420f..11fb7202049c 100644
> --- a/dutil.c
> +++ b/dutil.c
> @@ -179,12 +179,18 @@ Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,
>  {
>         Elf_Scn *sec = NULL;
>         size_t cnt = 1;
> +       size_t str_idx;
> +
> +       if (elf_getshdrstrndx(elf, &str_idx))
> +               return NULL;
>
>         while ((sec = elf_nextscn(elf, sec)) != NULL) {
>                 char *str;
>
>                 gelf_getshdr(sec, shp);
> -               str = elf_strptr(elf, ep->e_shstrndx, shp->sh_name);
> +               str = elf_strptr(elf, str_idx, shp->sh_name);
> +               if (!str)
> +                       return NULL;
>                 if (!strcmp(name, str)) {
>                         if (index)
>                                 *index = cnt;
> --
> 2.26.2
>
