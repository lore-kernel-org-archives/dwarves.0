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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8997BC433DB
	for <linux-dwarves@archiver.kernel.org>; Thu, 21 Jan 2021 07:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50A732396D
	for <linux-dwarves@archiver.kernel.org>; Thu, 21 Jan 2021 07:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbhAUHIl (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 21 Jan 2021 02:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbhAUHIg (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 21 Jan 2021 02:08:36 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F1AC0613C1;
        Wed, 20 Jan 2021 23:07:55 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id r32so1110939ybd.5;
        Wed, 20 Jan 2021 23:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yhLMqQFqTEGHYVWrpic3uSVoVSQoHHdmSMDigbaYXK4=;
        b=KX9vAwi7b326SXbGtOcLP4wpHQvNmLZKSHUf+SXEIq93kUJxWGlUtUZC+ACjxll3iC
         ACnfAn2l+OcoVYmpFLDjYIl9M7LP/PiLlpM+oS3f6S7zV62qgOD9Wl+9RYfDZhHmgrQc
         5VYzVc2XOwmyEMULH2S8++z/EVRwTekLHnOpVmk59rUF6oZILst4AmJSh1+GS8xTloZ2
         gpt3GUx8fEG7sTvjrnmk4PmJCnoShln8U0/jNzdTFDwoGB7VaDUdbwPnCFStDyxlI+Oo
         MC99orLawep9jm09BZOWJyqdLrQjz6HjpVa7cZOi/lLZi0osojDj2XcLRI1DiJc1saNg
         d4Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yhLMqQFqTEGHYVWrpic3uSVoVSQoHHdmSMDigbaYXK4=;
        b=EL21KmfxSe+tsqfgKWmW+PPCCKPzXZHyOXUOFnaYRl/jyFLRNNgkJouH6Jf/8Qa6Ah
         UtZTGPBLePhk43OIm7lItPtcNWLILKzhgHibEzYg9GHLLmlEE/4SYsR6J46LTxO7Eom0
         BzAJdv9ZDkImal0xDtiSH9ztfhG3heJd1JxOEd/5tePAmHRmE/U+8Kw9jf9Dq7biBCLY
         3VCFyCNNCdLJHZN/K5P599PzkqToIol78XiZK994cIrnN84d8NkwKQF6LyKpCDv2iAyC
         rGttgaAE3XMjZ/sxTs0j0o2LR/niVRUyNBzAuL+xhUHaWoGrqeLnJKaJGgpRr91ekQyo
         kCWA==
X-Gm-Message-State: AOAM531X5D3Otyht7ign8ozpNTCFRkpLg0zKmnji0PwD2sce0/drBbIZ
        K+NvENXmB9rgdVElyJrYwiRiuTPNel2jDWcTCdI=
X-Google-Smtp-Source: ABdhPJwDdfNvWio37bh9r5C96yXxfC1QkMIZdNdSf5N51NZkVgqBNzEcP/fAQXFrvDytCOKibCHDtM6tMWIKxcKED90=
X-Received: by 2002:a25:f40e:: with SMTP id q14mr19486702ybd.230.1611212874813;
 Wed, 20 Jan 2021 23:07:54 -0800 (PST)
MIME-Version: 1.0
References: <20210118160139.1971039-1-gprocida@google.com> <20210118160139.1971039-2-gprocida@google.com>
In-Reply-To: <20210118160139.1971039-2-gprocida@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 20 Jan 2021 23:07:44 -0800
Message-ID: <CAEf4BzZ-ibm_gmbv+JgZH6mNEmz0OxoF_nD9tymo1tYeE_BAjg@mail.gmail.com>
Subject: Re: [PATCH 1/3] btf_encoder: Fix handling of restrict qualifier
To:     Giuliano Procida <gprocida@google.com>
Cc:     dwarves@vger.kernel.org, kernel-team@android.com,
        maennich@google.com, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Mon, Jan 18, 2021 at 8:01 AM Giuliano Procida <gprocida@google.com> wrote:
>
> Fixes: 48efa92933e8 ("btf_encoder: Use libbpf APIs to encode BTF type info")
>
> Signed-off-by: Giuliano Procida <gprocida@google.com>
> ---

It's up to the maintainer, but some short commit message would be
welcome. Also, it would be nice to have [PATCH dwarves] to distinguish
this from patches targeted to bpf/bpf-next tree.

The fix itself looks good:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  libbtf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libbtf.c b/libbtf.c
> index 16e1d45..3709087 100644
> --- a/libbtf.c
> +++ b/libbtf.c
> @@ -417,7 +417,7 @@ int32_t btf_elf__add_ref_type(struct btf_elf *btfe, uint16_t kind, uint32_t type
>                 id = btf__add_const(btf, type);
>                 break;
>         case BTF_KIND_RESTRICT:
> -               id = btf__add_const(btf, type);
> +               id = btf__add_restrict(btf, type);
>                 break;
>         case BTF_KIND_TYPEDEF:
>                 id = btf__add_typedef(btf, name, type);
> --
> 2.30.0.284.gd98b1dd5eaa7-goog
>
