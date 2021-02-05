Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AC0C433DB
	for <linux-dwarves@archiver.kernel.org>; Fri,  5 Feb 2021 21:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85A7C64E51
	for <linux-dwarves@archiver.kernel.org>; Fri,  5 Feb 2021 21:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbhBEVOS (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 5 Feb 2021 16:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbhBEVMW (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Fri, 5 Feb 2021 16:12:22 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E13BC0617AA
        for <dwarves@vger.kernel.org>; Fri,  5 Feb 2021 13:10:12 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id ob3so4996512pjb.0
        for <dwarves@vger.kernel.org>; Fri, 05 Feb 2021 13:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=PWPQxeCAdhLh3iBL7DE/6gQVuXBKlPLZEtdhRuCjmxw=;
        b=NVSHL24F+1cvfoWwSWqqObWmcSZ+jmqBVq/c4//iEhKqhjfAp3ck1OyTyQIfo6vOwq
         IzvZWR1V+fZmIKTRY6keeQrrjFffwzyRbKg3KIWQTXZG0lh7XU9IgpA+YOZv+FIAZcRT
         Y+vHWkVnhODRGhUCp43s+0N8646L9yGlYSaJMHPWkJcbGyxE6mfFn2GgozQvGnNmv/hx
         DOC8+qufXNZX+iIhg7SxYhq7Zs8t7mHXlFelstQIOF6k3tYIMUgbiCKZ1vrIn7pt4aLn
         VPPBnli46CbhzX6rWKn9wdj2s6mcob+dODr4z/GN36VnNl7wnwOxI27Y/AXrcLtdrIDP
         saug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PWPQxeCAdhLh3iBL7DE/6gQVuXBKlPLZEtdhRuCjmxw=;
        b=E2JLEt1cBSEPpk7YYGu2LdiRp9OylbS/aPfDnQsXE2DSpzM/WoivLEE9R8y7fDAIQl
         Hqr8G/j6sAbTBq/cpS4dIelPsX0denwQbL8gZk/bIyN+EVw98JDE45lp7h1h8Lzcut6O
         +lS8cyeMOva8badjGKiv/GvBMkQKo3WfeqYv2RZ3nIuCi73xVQZZosU/CSA1Q9Ohgpgl
         v7vhweBq8uQ6khXC0f8PlWJ6Iv7AWagJ8GnxLr3nIo+99aNyeJ/Y8NzdlwPfJSBVCqfJ
         YyqE4igO7HBFqk5mbFDXwx6PzsISq6bL6d2NWWzL9uH98c/tbl+tvto2f3x8vKbNb4O4
         YQ/Q==
X-Gm-Message-State: AOAM531LFHQV6BEVtlX+3mx8fJgScXZeWQJwJZ9n91ct652ixbEnQ3zi
        3O9j+bktYa4tA75eraD1bmanjHiIDgH35nzoMIM=
X-Google-Smtp-Source: ABdhPJxExyVCuSceD3ifRJmPh4e6qYieel8G6WM1s0Z4zTD3g3ANK25YrnpQAQC6Cgtpy/n50ph6dZ0xx7gfZ2oOuns=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:fce9:1439:f67f:bf26])
 (user=ndesaulniers job=sendgmr) by 2002:a17:90a:2b8c:: with SMTP id
 u12mr5684697pjd.98.1612559412019; Fri, 05 Feb 2021 13:10:12 -0800 (PST)
Date:   Fri,  5 Feb 2021 13:10:10 -0800
In-Reply-To: <CA+icZUVQSojGgnis8Ds5GW-7-PVMZ2w4X5nQKSSkBPf-29NS6Q@mail.gmail.com>
Message-Id: <20210205211010.2764627-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <CA+icZUVQSojGgnis8Ds5GW-7-PVMZ2w4X5nQKSSkBPf-29NS6Q@mail.gmail.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: Re: ERROR: INT DW_ATE_unsigned_1 Error emitting BTF type
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     sedat.dilek@gmail.com
Cc:     andriin@fb.com, arnaldo.melo@gmail.com, berrange@redhat.com,
        bpf@vger.kernel.org, cavok@debian.org, dwarves@vger.kernel.org,
        jengelh@inai.de, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        mjw@redhat.com, omosnace@redhat.com, paul@paul-moore.com,
        tstellar@redhat.com, yhs@fb.com, zzam@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

> Hi,
> 
> when building with pahole v1.20 and binutils v2.35.2 plus Clang
> v12.0.0-rc1 and DWARF-v5 I see:
> ...
> + info BTF .btf.vmlinux.bin.o
> + [  != silent_ ]
> + printf   %-7s %s\n BTF .btf.vmlinux.bin.o
>  BTF     .btf.vmlinux.bin.o
> + LLVM_OBJCOPY=/opt/binutils/bin/objcopy /opt/pahole/bin/pahole -J
> .tmp_vmlinux.btf
> [115] INT DW_ATE_unsigned_1 Error emitting BTF type
> Encountered error while encoding BTF.

Yes, I observe this error, too.

https://gist.github.com/nickdesaulniers/ae8c9efbe4da69b1cf0dce138c1d2781

via v9 of my DWARF v5 series, which should help make this easier to
reproduce:
https://lore.kernel.org/lkml/CA+icZUW3sg_PkbmKSFMs6EqwQV7=hvKuAgZSsbg=Qr6gTs7RbQ@mail.gmail.com/T/#m45ec7e6df4c4b5e9da034b95d7dfc8e2a0c81dac
