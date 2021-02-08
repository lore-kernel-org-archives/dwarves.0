Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5095EC433DB
	for <linux-dwarves@archiver.kernel.org>; Mon,  8 Feb 2021 22:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06E1D64E8C
	for <linux-dwarves@archiver.kernel.org>; Mon,  8 Feb 2021 22:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhBHWav (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 8 Feb 2021 17:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbhBHWau (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 8 Feb 2021 17:30:50 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A7AC061786;
        Mon,  8 Feb 2021 14:30:09 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id l8so3853045ybe.12;
        Mon, 08 Feb 2021 14:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CUF6eyyP3ncSxbO+iAvljeI/a5BJeAQUM+miT5JiT/o=;
        b=tHdQYf3FgczfDQpCXiSHZ8PlAyYBtuUQkUt+0nxXEygTneVufn9VR1pldEOUsZSsoX
         811xhgFBX1ZDoWmRwVzYeUXQ5YS4prXh/dY6u9vIPgtm1nY/2+mnCfFlSWYb61HBUw+q
         cf9aOdH3rG1YIOnPBnQ9XDJZz1Yw9f4ZwXyfBRLdn14iViF+VuLqBGPHADCvNOR8rFrO
         y+ErdDorkXZZqhnFXuwcidNjj4lQEUnpyFyoaI8ZKRljhknyNVHBi49GOIzFxzQh6FCw
         kyTNcETnWUV8CcdwgmvvD/sjZIfhKask3arQxR1O6z3ujf7MdJkzPkgihUY26fit7nC6
         qPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CUF6eyyP3ncSxbO+iAvljeI/a5BJeAQUM+miT5JiT/o=;
        b=ZafRTMuMIbpaeqXz984tyYBFwtv3CvwtmIhupFcuK5QqKPlKvQEPVRA61ixPqfS1uA
         L5rfPq7JFzypaHi9HwjKTsuvw3A8Xhwq9BI2fMFNpXDJIzPr404sSuzwPAvGE4SmrVbf
         XzflLKlCaf4T4iaju9kTcUAla+ZS/EIaD/YY4nwcb2vzku0yxQjJV7HV3wLgsrBmovln
         PMKYkWqF1K7Db3sY5gA9fW7h6BLsKLONUdxwCB2UNSgwTYvAks7PPtmYETnt8aOCByEn
         gZcn/lWBEG3MtI3NF1Am71ku6WqR6eG93cYXuhxDcEVSRvwb29CDIC+EAuS7Gd3ZiYSf
         5b7Q==
X-Gm-Message-State: AOAM530cKAXGrhQNHRjVqa+NeQrUMx3cdjAVf0RlAJQZX5g4mSv5/2im
        +1Jq8RVFLm2PMLSMyR8vLcs8roTtPGGWjqXV9Vk=
X-Google-Smtp-Source: ABdhPJyZRPf/mMuNdRJlxlnmLjsVioBh9V5wn+rn+u7GaCQwG8TmQfvCrovEi9+wBg+MIllOV5AFl1qy3RSs4KHoarQ=
X-Received: by 2002:a25:4b86:: with SMTP id y128mr28343791yba.403.1612823409175;
 Mon, 08 Feb 2021 14:30:09 -0800 (PST)
MIME-Version: 1.0
References: <20210201172530.1141087-1-gprocida@google.com> <20210205134221.2953163-1-gprocida@google.com>
 <20210205134221.2953163-6-gprocida@google.com>
In-Reply-To: <20210205134221.2953163-6-gprocida@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 8 Feb 2021 14:29:58 -0800
Message-ID: <CAEf4Bza+mCKjva7BnChhFugjnE0mHzmfB4XErnmoZtkh6+jBpw@mail.gmail.com>
Subject: Re: [PATCH dwarves v3 5/5] btf_encoder: Align .BTF section to 8 bytes
To:     Giuliano Procida <gprocida@google.com>
Cc:     dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        =?UTF-8?Q?Matthias_M=C3=A4nnich?= <maennich@google.com>,
        kernel-team@android.com, Kernel Team <kernel-team@fb.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Fri, Feb 5, 2021 at 5:42 AM Giuliano Procida <gprocida@google.com> wrote:
>
> This is to avoid misaligned access to BTF type structs when
> memory-mapping ELF objects.
>
> Signed-off-by: Giuliano Procida <gprocida@google.com>
> ---

I trust you did verify that it actually works in cases where
previously .BTF was mis-aligned?

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  libbtf.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/libbtf.c b/libbtf.c
> index 9f4abb3..6754a17 100644
> --- a/libbtf.c
> +++ b/libbtf.c
> @@ -744,6 +744,14 @@ static int btf_elf__write(const char *filename, struct btf *btf)
>                 goto out;
>         }
>
> +       /*
> +        * We'll align .BTF to 8 bytes to cater for all architectures. It'd be
> +        * nice if we could fetch this value from somewhere. The BTF
> +        * specification does not discuss alignment and its trailing string
> +        * table is not currently padded to any particular alignment.
> +        */
> +       const size_t btf_alignment = 8;
> +
>         /*
>          * First we check if there is already a .BTF section present.
>          */
> @@ -821,6 +829,7 @@ static int btf_elf__write(const char *filename, struct btf *btf)
>                 elf_error("elf_getshdr(btf_scn) failed");
>                 goto out;
>         }
> +       btf_shdr.sh_addralign = btf_alignment;
>         btf_shdr.sh_entsize = 0;
>         btf_shdr.sh_flags = 0;
>         if (dot_btf_offset)
> --
> 2.30.0.478.g8a0d178c01-goog
>
