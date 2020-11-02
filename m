Return-Path: <SRS0=UIow=EI=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA94C00A89
	for <linux-dwarves@archiver.kernel.org>; Mon,  2 Nov 2020 18:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9036C2225E
	for <linux-dwarves@archiver.kernel.org>; Mon,  2 Nov 2020 18:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VWjnqBTI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgKBS3g (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 2 Nov 2020 13:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgKBS3g (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 2 Nov 2020 13:29:36 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD49C0617A6
        for <dwarves@vger.kernel.org>; Mon,  2 Nov 2020 10:29:35 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id e18so4188472edy.6
        for <dwarves@vger.kernel.org>; Mon, 02 Nov 2020 10:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OpMCV6DiwA90oIx03s3EMjuhB60pir+cNI+VltB5GH8=;
        b=VWjnqBTIlGrpPuF2LFgbeKu/sj0wZiKz1w3US24Lq1tK5vaaRd0hO3CZShJkGigzd6
         h2pIds/m16oOuFMiYOb8zOJYacIoR05iV43irQ81eVBcuGAnmTjJVzKvVtX6ATQl1f1I
         kpKkEza3WeGI/EHY50TsiwqvPMU+aXxAUz+jwhGdNcMz3r1bZgPji311QHJhOxdI1CBW
         3kbZPtACoxXXzvN9UWdRcJguAo8xoLf5GX+MieDpKhaBzCM4JBpKeKwDR4CBUzWjTg81
         DoiT5Ept1roX1wKjcCyasINyrbdbtRaL6/runLOm9WAcVmzXjfQAZfA7sHBDGhfjDair
         YXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OpMCV6DiwA90oIx03s3EMjuhB60pir+cNI+VltB5GH8=;
        b=R1RUhzHTgb19BPKS/JH5PJu4nzsWr/fxfHSCz4gTsoioy2Hmm2EwlUGF7RawS67NOa
         WJoB0eUh9XQFGH2VsIClNsdSnUcUdMCJfZcbvq+7Se/Jo7gsFLnqKtQTa0BIy/zoJHJ+
         /Qfy9yNOq3tVY03sFSKqu+DUa14PpNrxXOZMj28nrCaZi24E5K/3YXB4aDgj4vrtj695
         dCEarFm2jsW79pcVmukLzJF8LKOm5Fo51VxarRqZ/tRwL/eAYnBYOHFa3YPVB4jz8wLc
         0u3r4Vmt9hujT2IlnCH0g0qASDUYjw3NIpmPTStE3caMEzXiCAxX70bq/XK3FEDEwwIO
         AnDA==
X-Gm-Message-State: AOAM531eDLHsqiLLG0XAIBTHPoW+j9Pv0lrNP2AdkIMmxd8P4X0G+Azh
        sU8Kb6C8ltDzDK70Gaqjy6CnfvT/gdEJo1Tn0GIiuQ==
X-Google-Smtp-Source: ABdhPJxeMAsEsTOEEkH4GYmiXn1rIW4mdT597X8DL0FwXDSaY5ZRiEMF+yTIqat9/8JA+MGqOWEN6L2WR3AZNiEL9F4=
X-Received: by 2002:aa7:dc12:: with SMTP id b18mr17898467edu.295.1604341774102;
 Mon, 02 Nov 2020 10:29:34 -0800 (PST)
MIME-Version: 1.0
References: <20201031223131.3398153-1-jolsa@kernel.org> <20201031223131.3398153-2-jolsa@kernel.org>
In-Reply-To: <20201031223131.3398153-2-jolsa@kernel.org>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 2 Nov 2020 10:29:22 -0800
Message-ID: <CA+khW7hRm4xwKKDjdoJkaQADfjANCzy9hpp-xL_T-Two3oNAfA@mail.gmail.com>
Subject: Re: [PATCH 1/2] btf_encoder: Move find_all_percpu_vars in generic collect_symbols
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

This looks good to me. Thanks, Jiri.

Acked-by: Hao Luo <haoluo@google.com>

On Sat, Oct 31, 2020 at 3:31 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Moving find_all_percpu_vars under generic collect_symbols
> function that walks over symbols and calls collect_percpu_var.
>
> We will add another collect function that needs to go through
> all the symbols, so it's better we go through them just once.
>
> There's no functional change intended.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  btf_encoder.c | 124 +++++++++++++++++++++++++++-----------------------
>  1 file changed, 67 insertions(+), 57 deletions(-)
>
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 4c92908beab2..1866bb16a8ba 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -250,75 +250,85 @@ static bool percpu_var_exists(uint64_t addr, uint32_t *sz, const char **name)
>         return true;
>  }
>
> -static int find_all_percpu_vars(struct btf_elf *btfe)
> +static int collect_percpu_var(struct btf_elf *btfe, GElf_Sym *sym)
>  {
> -       uint32_t core_id;
> -       GElf_Sym sym;
> +       const char *sym_name;
> +       uint64_t addr;
> +       uint32_t size;
>
> -       /* cache variables' addresses, preparing for searching in symtab. */
> -       percpu_var_cnt = 0;
> +       /* compare a symbol's shndx to determine if it's a percpu variable */
> +       if (elf_sym__section(sym) != btfe->percpu_shndx)
> +               return 0;
> +       if (elf_sym__type(sym) != STT_OBJECT)
> +               return 0;
>
> -       /* search within symtab for percpu variables */
> -       elf_symtab__for_each_symbol(btfe->symtab, core_id, sym) {
> -               const char *sym_name;
> -               uint64_t addr;
> -               uint32_t size;
> +       addr = elf_sym__value(sym);
> +       /*
> +        * Store only those symbols that have allocated space in the percpu section.
> +        * This excludes the following three types of symbols:
> +        *
> +        *  1. __ADDRESSABLE(sym), which are forcely emitted as symbols.
> +        *  2. __UNIQUE_ID(prefix), which are introduced to generate unique ids.
> +        *  3. __exitcall(fn), functions which are labeled as exit calls.
> +        *
> +        * In addition, the variables defined using DEFINE_PERCPU_FIRST are
> +        * also not included, which currently includes:
> +        *
> +        *  1. fixed_percpu_data
> +        */
> +       if (!addr)
> +               return 0;
>
> -               /* compare a symbol's shndx to determine if it's a percpu variable */
> -               if (elf_sym__section(&sym) != btfe->percpu_shndx)
> -                       continue;
> -               if (elf_sym__type(&sym) != STT_OBJECT)
> -                       continue;
> +       size = elf_sym__size(sym);
> +       if (!size)
> +               return 0; /* ignore zero-sized symbols */
>
> -               addr = elf_sym__value(&sym);
> -               /*
> -                * Store only those symbols that have allocated space in the percpu section.
> -                * This excludes the following three types of symbols:
> -                *
> -                *  1. __ADDRESSABLE(sym), which are forcely emitted as symbols.
> -                *  2. __UNIQUE_ID(prefix), which are introduced to generate unique ids.
> -                *  3. __exitcall(fn), functions which are labeled as exit calls.
> -                *
> -                * In addition, the variables defined using DEFINE_PERCPU_FIRST are
> -                * also not included, which currently includes:
> -                *
> -                *  1. fixed_percpu_data
> -                */
> -               if (!addr)
> -                       continue;
> +       sym_name = elf_sym__name(sym, btfe->symtab);
> +       if (!btf_name_valid(sym_name)) {
> +               dump_invalid_symbol("Found symbol of invalid name when encoding btf",
> +                                   sym_name, btf_elf__verbose, btf_elf__force);
> +               if (btf_elf__force)
> +                       return 0;
> +               return -1;
> +       }
>
> -               size = elf_sym__size(&sym);
> -               if (!size)
> -                       continue; /* ignore zero-sized symbols */
> +       if (btf_elf__verbose)
> +               printf("Found per-CPU symbol '%s' at address 0x%lx\n", sym_name, addr);
>
> -               sym_name = elf_sym__name(&sym, btfe->symtab);
> -               if (!btf_name_valid(sym_name)) {
> -                       dump_invalid_symbol("Found symbol of invalid name when encoding btf",
> -                                           sym_name, btf_elf__verbose, btf_elf__force);
> -                       if (btf_elf__force)
> -                               continue;
> -                       return -1;
> -               }
> +       if (percpu_var_cnt == MAX_PERCPU_VAR_CNT) {
> +               fprintf(stderr, "Reached the limit of per-CPU variables: %d\n",
> +                       MAX_PERCPU_VAR_CNT);
> +               return -1;
> +       }
> +       percpu_vars[percpu_var_cnt].addr = addr;
> +       percpu_vars[percpu_var_cnt].sz = size;
> +       percpu_vars[percpu_var_cnt].name = sym_name;
> +       percpu_var_cnt++;
>
> -               if (btf_elf__verbose)
> -                       printf("Found per-CPU symbol '%s' at address 0x%lx\n", sym_name, addr);
> +       return 0;
> +}
> +
> +static int collect_symbols(struct btf_elf *btfe, bool collect_percpu_vars)
> +{
> +       uint32_t core_id;
> +       GElf_Sym sym;
>
> -               if (percpu_var_cnt == MAX_PERCPU_VAR_CNT) {
> -                       fprintf(stderr, "Reached the limit of per-CPU variables: %d\n",
> -                               MAX_PERCPU_VAR_CNT);
> +       /* cache variables' addresses, preparing for searching in symtab. */
> +       percpu_var_cnt = 0;
> +
> +       /* search within symtab for percpu variables */
> +       elf_symtab__for_each_symbol(btfe->symtab, core_id, sym) {
> +               if (collect_percpu_vars && collect_percpu_var(btfe, &sym))
>                         return -1;
> -               }
> -               percpu_vars[percpu_var_cnt].addr = addr;
> -               percpu_vars[percpu_var_cnt].sz = size;
> -               percpu_vars[percpu_var_cnt].name = sym_name;
> -               percpu_var_cnt++;
>         }
>
> -       if (percpu_var_cnt)
> -               qsort(percpu_vars, percpu_var_cnt, sizeof(percpu_vars[0]), percpu_var_cmp);
> +       if (collect_percpu_vars) {
> +               if (percpu_var_cnt)
> +                       qsort(percpu_vars, percpu_var_cnt, sizeof(percpu_vars[0]), percpu_var_cmp);
>
> -       if (btf_elf__verbose)
> -               printf("Found %d per-CPU variables!\n", percpu_var_cnt);
> +               if (btf_elf__verbose)
> +                       printf("Found %d per-CPU variables!\n", percpu_var_cnt);
> +       }
>         return 0;
>  }
>
> @@ -347,7 +357,7 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
>                 if (!btfe)
>                         return -1;
>
> -               if (!skip_encoding_vars && find_all_percpu_vars(btfe))
> +               if (collect_symbols(btfe, !skip_encoding_vars))
>                         goto out;
>
>                 has_index_type = false;
> --
> 2.26.2
>
