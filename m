Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC261C433E0
	for <linux-dwarves@archiver.kernel.org>; Tue,  2 Feb 2021 10:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7105064EE2
	for <linux-dwarves@archiver.kernel.org>; Tue,  2 Feb 2021 10:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbhBBK4D (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 2 Feb 2021 05:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhBBK4C (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 2 Feb 2021 05:56:02 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040B4C06174A
        for <dwarves@vger.kernel.org>; Tue,  2 Feb 2021 02:55:22 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id 67so150982uao.1
        for <dwarves@vger.kernel.org>; Tue, 02 Feb 2021 02:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L2KcHewdO5OWdri1u0nj0dmMm94dkytL7v5kHywy6GM=;
        b=HdNk6ieCmG3cO1gUZZoUb89+U/a2vaB5zFr5uYXmkArQwGcGBD2/6dMsKXQZ33nR5m
         jiPu12XcbGQz7/+H/32v6JIJEGOvQNKsXAcSvj4woCbciTEZU0aHVdYUozLSIpzgBItd
         CyXzVl8FIInt88jLHaCFfUz2bhNV6sKAjBHFDYWl9CAdXe3lD5EfHDXm7P5IMbYY5LuS
         qxZ4uN2yk67DdZsF8YnzYbjUgrJjpyLRuJt2qYW+MYfog6HbeqhLIH2cq9GW9atBheac
         cRgQStgdmV0neEfbQhGBgT937ytWLL0yU1pKR2/6xFKulSlG1ouR9NRJaFqwPB3aH3JC
         lyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L2KcHewdO5OWdri1u0nj0dmMm94dkytL7v5kHywy6GM=;
        b=pgkRZZ2guEmBPq96eB3auG7QLbBDQifGfHWHP6ZJjXtPFI6YJFjCwymHu1j4W3T8i4
         QXrREi/jwFJvG9CHJQFGQgxElIC6UuXaeQ6YX5zQcra/dac7K1REhlgIY6cY2Cdmnaye
         E2omchinSFE6zimsmuX6xNq4tv6p8ZDVWXyYllGus1XEuqMTwoA2P9gNG7JtOpwj987n
         xfOa33xc4Mn6FnasTtWUiQdwteIMMedris0/jRQcCPQ00OGei5EE9NBa3vM6BUh450eY
         A6apgjHAyHaWjYe7LyrvU3HYGOg2yRGHqR6eLFU+2uus4nVYE+rUBWIGfDBmyqXcyegy
         CxRw==
X-Gm-Message-State: AOAM533B1ZUiqIZ3r4UVW08N9gwjekeRWqdG48pAE+EKa3U2R3vUGYMm
        YxUyN8XiD6k4fWfSHReKASkuDeJPN6cooBgd+2zAwrkFiSoufA==
X-Google-Smtp-Source: ABdhPJzIQLKbz2ruSkS7bpqdFRvpVqpaXUDzMwuBVABT2JQ7OtOfSEZnJEeBr1fw9SCccCx8Q9VjtazbkuyGPdP764g=
X-Received: by 2002:ab0:7193:: with SMTP id l19mr11527394uao.84.1612263320452;
 Tue, 02 Feb 2021 02:55:20 -0800 (PST)
MIME-Version: 1.0
References: <20210201172530.1141087-1-gprocida@google.com> <20210201172530.1141087-4-gprocida@google.com>
In-Reply-To: <20210201172530.1141087-4-gprocida@google.com>
From:   Giuliano Procida <gprocida@google.com>
Date:   Tue, 2 Feb 2021 10:54:43 +0000
Message-ID: <CAGvU0HnVVJYPXV65aG_iM7n5_SKp_CQ6OKwTG=YhXsYMRkQAYQ@mail.gmail.com>
Subject: Re: [PATCH dwarves v2 3/4] btf_encoder: Add .BTF as a loadable segment
To:     dwarves@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        =?UTF-8?Q?Matthias_M=C3=A4nnich?= <maennich@google.com>,
        kernel-team@android.com, Kernel Team <kernel-team@fb.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Two issues here.

On Mon, 1 Feb 2021 at 17:26, Giuliano Procida <gprocida@google.com> wrote:
>
> In addition to adding .BTF to the Section Header Table, we also need
> to add it to the Program Header Table and rewrite the PHT's
> description of itself.
>
> The segment as loadbale, at address 0 and read-only.
>

Typos.

> Signed-off-by: Giuliano Procida <gprocida@google.com>
> ---
>  libbtf.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/libbtf.c b/libbtf.c
> index 6e06a58..048a873 100644
> --- a/libbtf.c
> +++ b/libbtf.c
> @@ -699,6 +699,7 @@ static int btf_elf__write(const char *filename, struct btf *btf)
>         int fd, err = -1;
>         size_t strndx;
>         void *str_table = NULL;
> +       GElf_Phdr *pht = NULL;
>
>         fd = open(filename, O_RDWR);
>         if (fd < 0) {
> @@ -900,6 +901,47 @@ static int btf_elf__write(const char *filename, struct btf *btf)
>                 goto out;
>         }
>
> +       size_t phnum = 0;
> +       if (!elf_getphdrnum(elf, &phnum)) {
> +               pht = malloc((phnum + 1) * sizeof(GElf_Phdr));

Adding a segment unconditionally is incorrect.
It should behave differently if .BTF already has its own segment or is
part of an existing segment containing other sections.
The ELF surgery needed in the general case may be considerable.

> +               if (!pht) {
> +                       fprintf(stderr, "%s: malloc (PHT) failed\n", __func__);
> +                       goto out;
> +               }
> +               for (size_t ix = 0; ix < phnum; ++ix) {
> +                       if (!gelf_getphdr(elf, ix, &pht[ix])) {
> +                               fprintf(stderr,
> +                                       "%s: gelf_getphdr(%zu) failed: %s\n",
> +                                       __func__, ix, elf_errmsg(elf_errno()));
> +                               goto out;
> +                       }
> +                       if (pht[ix].p_type == PT_PHDR) {
> +                               size_t fsize = gelf_fsize(elf, ELF_T_PHDR,
> +                                                         phnum+1, EV_CURRENT);
> +                               pht[ix].p_memsz = pht[ix].p_filesz = fsize;
> +                       }
> +               }
> +               pht[phnum].p_type = PT_LOAD;
> +               pht[phnum].p_offset = btf_shdr->sh_offset;
> +               pht[phnum].p_memsz = pht[phnum].p_filesz = btf_shdr->sh_size;
> +               pht[phnum].p_vaddr = pht[phnum].p_paddr = 0;
> +               pht[phnum].p_flags = PF_R;
> +               void *phdr = gelf_newphdr(elf, phnum+1);
> +               if (!phdr) {
> +                       fprintf(stderr, "%s: gelf_newphdr failed: %s\n",
> +                               __func__, elf_errmsg(elf_errno()));
> +                       goto out;
> +               }
> +               for (size_t ix = 0; ix < phnum+1; ++ix) {
> +                       if (!gelf_update_phdr(elf, ix, &pht[ix])) {
> +                               fprintf(stderr,
> +                                       "%s: gelf_update_phdr(%zu) failed: %s\n",
> +                                       __func__, ix, elf_errmsg(elf_errno()));
> +                               goto out;
> +                       }
> +               }
> +       }
> +
>         if (elf_update(elf, ELF_C_WRITE) < 0) {
>                 fprintf(stderr, "%s: elf_update (write) failed: %s\n",
>                         __func__, elf_errmsg(elf_errno()));
> @@ -908,6 +950,8 @@ static int btf_elf__write(const char *filename, struct btf *btf)
>         err = 0;
>
>  out:
> +       if (pht)
> +               free(pht);
>         if (str_table)
>                 free(str_table);
>         if (fd != -1)
> --
> 2.30.0.365.g02bc693789-goog
>
