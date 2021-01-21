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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D2FC433E0
	for <linux-dwarves@archiver.kernel.org>; Thu, 21 Jan 2021 07:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58C6923788
	for <linux-dwarves@archiver.kernel.org>; Thu, 21 Jan 2021 07:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbhAUHRn (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 21 Jan 2021 02:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbhAUHRX (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 21 Jan 2021 02:17:23 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E597C061575;
        Wed, 20 Jan 2021 23:16:43 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id k132so1147059ybf.2;
        Wed, 20 Jan 2021 23:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eoURqYvHbCeyxwJAYbqlT7Ea9gNe6O6cmfqiJEuGtAs=;
        b=mNeg7lBWryJPe3wfSBv+oLHTuxZ7xX5rFXe9W3dijqsX7lkVRLfmC1GTC9BWiC5ZEm
         /fR48NRlD3BHuuhHzncJVGDyEhQ0SnEiC8g5iPHbY06MvqrfeolTTSo9hfFKoHSti+2V
         ZbZZAniiLXSd7AAW+/mlkD9m6hstQzsYGcHsSvFZ5DKrOWT0BkPY+gARbghIGOWG5ohW
         YkXNCHU6IKtf2J240ub0utSDsAD04nhX1Ro51YvixBUHlDDb7eYkxQLQNvqpW6CLDv80
         4aSs2zz1ySJSZnf2oQEgW7g6HhGXbiz0WXshiKvOM3aRI+0dDeW6Zpa098O33ElJ88QO
         X0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eoURqYvHbCeyxwJAYbqlT7Ea9gNe6O6cmfqiJEuGtAs=;
        b=ScZ/NKC2qyDB/gKbBFy40V0djU8h6siPosbdjrSTcFmVoiwnMVPTo6IvdBeX2v4tTx
         icE/IRS7E2LN1ay09+71gLUM3xHvGAnUfdyPRczhy4UZl2Hs0ChnvcQhrAbXpNqHdbeV
         JlXBbYjLbIrNSyHZzPoz5MlzllGT4PcnZw7YczJB7Z6WwxBTbC/osfBVxrGQl5WT7Nrg
         pyMBYiXWHdo5AMCdDTQuWsynsICtPrd7TNcmC1BVryIGoQVY0dO0S9YoI6+Kfsolh6t3
         i1cp5qFWt8hfEUcESCpnoqBxo70/35VAHUl9GfZqsOu98nZvhLEtBc9cpeNJFbeGfMEi
         4mIg==
X-Gm-Message-State: AOAM532bHC5qLews/U3owGnvS9okrAwBEjdpZb3JsW1zM03b4NqVHOuK
        CAJFoWwTmxPSIGUrm4zi+dxGhqNxY//t8RaiWfpuZ+8o88U=
X-Google-Smtp-Source: ABdhPJxvNJ3u1k2WifT8nMxTC6lGIKn3IY/dTEV8hOsSiwMoj4+Wj+Rr+qbiLGSHJIEB6Kdm0VK0QvfI1QnG8vy3wRk=
X-Received: by 2002:a25:854a:: with SMTP id f10mr17469649ybn.510.1611213402492;
 Wed, 20 Jan 2021 23:16:42 -0800 (PST)
MIME-Version: 1.0
References: <20210118160139.1971039-1-gprocida@google.com> <20210118160139.1971039-4-gprocida@google.com>
In-Reply-To: <20210118160139.1971039-4-gprocida@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 20 Jan 2021 23:16:31 -0800
Message-ID: <CAEf4BzazvC9H=K_A9KamGTB3iKtjuNxd4hEvwFOnkPdnszo6Bw@mail.gmail.com>
Subject: Re: [PATCH 3/3] btf_encoder: Set .BTF section alignment to 16
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
> This is to avoid misaligned access when memory-mapping ELF sections.
>
> Signed-off-by: Giuliano Procida <gprocida@google.com>
> ---
>  libbtf.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/libbtf.c b/libbtf.c
> index 7552d8e..2f12d53 100644
> --- a/libbtf.c
> +++ b/libbtf.c
> @@ -797,6 +797,14 @@ static int btf_elf__write(const char *filename, struct btf *btf)
>                         goto unlink;
>                 }
>
> +               snprintf(cmd, sizeof(cmd), "%s --set-section-alignment .BTF=16 %s",
> +                        llvm_objcopy, filename);

does it align inside the ELF file to 16 bytes, or does it request the
linker to align it at 16 byte alignment in memory? Given .BTF section
is not loadable, trying to understand the implications.


> +               if (system(cmd)) {

Also curious, if objcopy emits error (saying that
--set-section-alignment argument is not recognized), will that error
be shown in stdout? or system() consumes it without redirecting it to
stdout?

> +                       /* non-fatal, this is a nice-to-have and it's only supported from LLVM 10 */
> +                       fprintf(stderr, "%s: warning: failed to align .BTF section in '%s': %d!\n",
> +                               __func__, filename, errno);

Probably better to emit this warning only in verbose mode, otherwise
lots of people will start complaining that they get some new warnings
from pahole.


> +               }
> +
>                 err = 0;
>         unlink:
>                 unlink(tmp_fn);
> --
> 2.30.0.284.gd98b1dd5eaa7-goog
>
