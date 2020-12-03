Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B982AC4167B
	for <linux-dwarves@archiver.kernel.org>; Thu,  3 Dec 2020 23:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 768AA2245C
	for <linux-dwarves@archiver.kernel.org>; Thu,  3 Dec 2020 23:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgLCXXL (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 3 Dec 2020 18:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgLCXXK (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 3 Dec 2020 18:23:10 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A8FC061A53;
        Thu,  3 Dec 2020 15:22:29 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id 2so3628630ybc.12;
        Thu, 03 Dec 2020 15:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/0Ujqyr9SOu32wCr5NmjHzbSIH9DSGXFfdV6x7vToCE=;
        b=u/aNkEDv7n20QykwPYbjsNWLEVguYTnRz0BMiu+A2BFILAj1CJBDGKpAOlBwky0w5M
         c4mOAGpbrUfqUmnaWjQtSt5HOrBYNPsTYsub07yNomdXGKbUDbUAcQn0adoVs+zAcXQb
         /O98X/FNicM3V5YCgGsE6cL+bRU7OeY3gPRneyG/BuuR9xOGU4gRmIlvNTsFv0JBqCIq
         AAFftUk/mg7BYfxdkS5iUQeJMaY8PbP91TDgVqUi8JCT2jt2vPVnpp2Zerv0GD5BKa6W
         VWTrdOML1KaOXfMHVAJqUivmxpS8lw1URLqoij8pVZSb5DGPgDP2/DHTJzGqPLuHnVWl
         BsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/0Ujqyr9SOu32wCr5NmjHzbSIH9DSGXFfdV6x7vToCE=;
        b=czC+IyQP2R29+PZij23MZGZvsdpKBGfQgchmtmAfaiXeHGPiSXEAR0WoiaA4R3rI2I
         bS+K+8JQ3mwskSPV8BDg1GIWhQcXPpvx1KDktF2B/Lp6lRuzRViEarKJoZSuU9GNPw+w
         w/lMtE1IXSF/CZ4ILiIcsemVmeZliFD/OeLuymztLVFcuPsPlV+6xD97XqUYj3Llao75
         Vg9e5dZj5Er9fkGcHCVl+XaIqo2aOmk4qIZmrDhQG2HhVVX76uQYkmPtIZ5CBh0zMTRA
         FFIQKrjuIyO5EbHkAHq04PZ54NGj0S+YVs1kwhXMdBkOTIEpVDLMbOlBmocJTX0pmDI0
         mkIw==
X-Gm-Message-State: AOAM532zU7HfQB6KPMJXusmlN8AaHW6g8QxbZ5SNg6lPpZQEmIT8TO8f
        /joI5Yq7BJuQTVi15wt7BtIo/MTS7yMx3CA22qrIzT8o/HA=
X-Google-Smtp-Source: ABdhPJzwfOHyDBxXeh5YG63wOBkPRjgaHOank/RXntWfx2E+llpsdJc88uXUL90p4aO5JvlO2VDHqYlWZ5zn+JOxJDY=
X-Received: by 2002:a25:585:: with SMTP id 127mr2028489ybf.425.1607037749220;
 Thu, 03 Dec 2020 15:22:29 -0800 (PST)
MIME-Version: 1.0
References: <20201203220625.3704363-1-jolsa@kernel.org> <20201203220625.3704363-3-jolsa@kernel.org>
In-Reply-To: <20201203220625.3704363-3-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 3 Dec 2020 15:22:18 -0800
Message-ID: <CAEf4BzbdB4DUJ2BKVsVdpcZHunNxb_6FvAWOFt_be=81Jyxmnw@mail.gmail.com>
Subject: Re: [PATCH 2/3] btf_encoder: Use address size based on ELF's class
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Thu, Dec 3, 2020 at 2:08 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> We can't assume the address size is always size of unsigned
> long, we have to use directly the ELF's address size.
>
> Changing addrs array to __u64 and convert 32 bit address
> values when copying from ELF section.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---

It looks ok to me, but I didn't expect that changes would be so
numerous... Makes me wonder if pahole ever supported working with ELF
files of different bitness. I'll defer to Arnaldo to make a call on
whether this is necessary.

>  btf_encoder.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
>

[...]
