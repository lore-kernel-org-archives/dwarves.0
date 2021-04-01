Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2BCC433ED
	for <linux-dwarves@archiver.kernel.org>; Thu,  1 Apr 2021 19:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A076601FF
	for <linux-dwarves@archiver.kernel.org>; Thu,  1 Apr 2021 19:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbhDATf6 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 1 Apr 2021 15:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbhDATf5 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 1 Apr 2021 15:35:57 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84844C0613E6
        for <dwarves@vger.kernel.org>; Thu,  1 Apr 2021 12:35:57 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id jy13so4545116ejc.2
        for <dwarves@vger.kernel.org>; Thu, 01 Apr 2021 12:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jSH/WHddRbPf6STimxPVj0owKXpeyvm3Or6jIfJzeYA=;
        b=MgqN747F60JpErfrcDBkplHYzAtEvLiQS7DOj3NDmUccASu9PkdDQgHUkBOu5Aeami
         rYPcvUq4vPXtFazL42IgyJoVJhDUAqWLaEqXdoFL7ktQeKEVje4n0mSG6hVfS4lKCQVz
         xr8CR21ZWFcC5wa8W4QKnTgs9rrgWz3pym6ZIbHBvIVYt3PijlbWGKSypAmkWQ4wQktP
         eJpkJQoDP67Jirt2htgVEW1QtBUeAkjGy8qpTWsC3lvshb7w9fbAQ8SchfnBdST/kT42
         GyWv2OkEGm4+ctrd4eQFud30gstX77swaMj9r9LVaRVzKVECGDeyyp3w4d0h8/wi08V7
         Ituw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jSH/WHddRbPf6STimxPVj0owKXpeyvm3Or6jIfJzeYA=;
        b=LLFlDE4N07ItgQ0l1rom4vFldBwYmUw81FugLbxD3Zrub6A09r8sJhpJacmTR/zjY0
         RuexwmYykzFT/DtxLibb3O1vP3sTAAnTOsSTfr7SYkiW3dnCSYfVpJMSYkZDgyeHrKOJ
         vEBRuu4DDppSt3yfE7DCMQcWdpu4GIcWUj9BcFupU5d414LlQ596YYp62WglqYhnBFsQ
         +lhMBLSQZ1vn0GuZHVBSrNoufoda7/Px0aXuRkIPiIIDRMe1O0ivuA0oRD3/4ljsxokx
         C/9JS389aW5odAB8x9jlwJRAA16LPevA82yt3wHIcoIQg26DBoFzSuubSbanmNPADY+b
         qqkQ==
X-Gm-Message-State: AOAM532yjgtWdkORyXF00/joJnR8siyJQOP4FqSu58bAg2qhETixGNDr
        wf3FQyWvtKQmpVTnM3uBfqyivLaJZtQYtSudAzGS
X-Google-Smtp-Source: ABdhPJw2FE5Kpo3Br2tp++R3AapsUztluYSGA78Fa4Kiy0rIRS2RqdWZi27nTgHVJIUlHu5RHo6CgvQ/KoNcRE2f5M8=
X-Received: by 2002:a17:906:af97:: with SMTP id mj23mr11117694ejb.419.1617305755968;
 Thu, 01 Apr 2021 12:35:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210401025815.2254256-1-yhs@fb.com>
In-Reply-To: <20210401025815.2254256-1-yhs@fb.com>
From:   Bill Wendling <morbo@google.com>
Date:   Thu, 1 Apr 2021 12:35:45 -0700
Message-ID: <CAGG=3QWpcCG7b70oQsRTATgt10acEFS=-Tg9U=DHZ6xoS3GeMA@mail.gmail.com>
Subject: Re: [PATCH dwarves 0/2] dwarf_loader: improve cus__merging_cu()
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        David Blaikie <dblaikie@gmail.com>,
        =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        kernel-team@fb.com, Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Wed, Mar 31, 2021 at 7:58 PM Yonghong Song <yhs@fb.com> wrote:
>
> Function cus__merging_cu() is introduced in Commit 39227909db3c
> ("dwarf_loader: Permit merging all DWARF CU's for clang LTO built
> binary") to test whether cross-cu references may happen.
> The original implementation anticipates compilation flags
> in dwarf, but later some concerns about binary size surfaced
> and the decision is to scan .debug_abbrev as a faster way
> to check cross-cu references. Also putting a note in vmlinux
> to indicate whether lto is enabled for built or not can
> provide a much faster way.
>
> This patch set implemented this two approaches, first
> checking the note (in Patch #2), if not found, then
> check .debug_abbrev (in Patch #1).
>
> Yonghong Song (2):
>   dwarf_loader: check .debug_abbrev for cross-cu references
>   dwarf_loader: check .notes section for lto build info
>
>  dwarf_loader.c | 76 ++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 55 insertions(+), 21 deletions(-)
>
With this series of patches, the compilation passes for me with
ThinLTO. You may add this if you like:

Tested-by: Bill Wendling <morbo@google.com>

Thanks!
-bw
