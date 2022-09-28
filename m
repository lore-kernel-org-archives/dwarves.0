Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45146C32771
	for <linux-dwarves@archiver.kernel.org>; Wed, 28 Sep 2022 21:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbiI1VgC (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 28 Sep 2022 17:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbiI1VgB (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 28 Sep 2022 17:36:01 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C69796A3
        for <dwarves@vger.kernel.org>; Wed, 28 Sep 2022 14:36:00 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id iw17so12856799plb.0
        for <dwarves@vger.kernel.org>; Wed, 28 Sep 2022 14:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=f527iDuMrIlXVmyBET0HAqXBGaF0ucSA6fsuOhPCxbQ=;
        b=TeFokwKZO1gJ07OmAwajBHsPlZ/3hSnNYhWF37ChULaEfUvTEy1HvOghwS0ALi1Z70
         VcmFU6kQ2DStVWZbe9q2lI8Ejz/ZJZPGTHrGyKiOGU5TxMEykMlfZsI+LQ101Oc6lZoF
         JYeNDNhixbwN5PBIXmMKSEr49sQqTug9jbMVfaxsWZ9HPbcn+aA6wxdAQvd4azODFPb7
         uqFN/RJCtBTyhVrwomTYlQItTmGrbcZhGFzgWe+BM60gF/R7tek6lDyfl4u8ikTzJWu9
         2lKhB/qPB7RQ1d4uS1NdTbDYv/grYVsmBS65yu5O/A5kirK1Iq/fTCUzS4xS3A75GHqn
         vDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=f527iDuMrIlXVmyBET0HAqXBGaF0ucSA6fsuOhPCxbQ=;
        b=LxhJI2gM/b09WrOtCVqJQmzyJ2eocwq8ZkoUwT0ti0qynBkCtMCF0+X7lheQx62hea
         T3lULjS9sb/iB86yA9FlHAU1tfc4X15Q5kEw25GO8YMUmkatNwWOBbpHIjKE6WiC1t5V
         GnAADCZOiJEzpqgPiQwzla5TfHQ0B9HwVZqNc9RVTcERo3t2bDP9exXelAFDG9BTZ0Pe
         T5zva66tGFOSkCJzj0JG9zJJMEV8oINpnGAq+8BPCqVvTkT6FtG/PcQtUIB6k0bDSwkA
         nKq3vkM1ZZhLXnT6smFjLkMkejdkD21wBuXcsVODFfXTiqyieWll8TSom0l+bd63Tt8i
         EBww==
X-Gm-Message-State: ACrzQf0xMbvCB+UDD3CRcgvldonnL/cObVTbLZ60Ry/hFX0+gvnseaEc
        NXIJBgJbOR0qntOdbaGkDJHIyzuwwa6Cl04s/BcTaw==
X-Google-Smtp-Source: AMsMyM6TF6vE5nw+LIaKN8kgH/Xec47qlzf7v8D2Xjhagh34tjGASsUx7GtC32CoRRTjM6rdZbaA8hyEsKQ7YPBtI6Q=
X-Received: by 2002:a17:902:a411:b0:178:9e4c:2ef8 with SMTP id
 p17-20020a170902a41100b001789e4c2ef8mr3082plq.95.1664400959688; Wed, 28 Sep
 2022 14:35:59 -0700 (PDT)
MIME-Version: 1.0
References: <YzNHYoI4EZOQdCQ0@dev-arch.thelio-3990X>
In-Reply-To: <YzNHYoI4EZOQdCQ0@dev-arch.thelio-3990X>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 28 Sep 2022 14:35:48 -0700
Message-ID: <CAKwvOd=ES+v0X6_ydB5+MNWdPw8dNAUD0Biq=BKB6KqPqNp+Ng@mail.gmail.com>
Subject: Re: die__process_unit: DW_TAG_label (0xa) @ <0x7b> not handled!
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     dwarves@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Tue, Sep 27, 2022 at 11:56 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Hi Arnaldo,
>
> When building a kernel with LLVM and CONFIG_DEBUG_INFO_BTF after commit
> 32ef9e5054ec ("Makefile.debug: re-enable debug info for .S files") in
> the kernel, I see the following spew of warnings, which appear to come
> from pahole:
>
> $ clang --version
> clang version 15.0.0 (Fedora 15.0.0-3.fc38)
> Target: x86_64-redhat-linux-gnu
> Thread model: posix
> InstalledDir: /usr/bin
>
> $ pahole --version
> v1.24
>
> $ make -skj"$(nproc)" ARCH=x86_64 LLVM=1 defconfig
>
> $ scripts/config \
>     -d DEBUG_INFO_NONE \
>     -e BPF_SYSCALL \
>     -e DEBUG_INFO_BTF \
>     -e DEBUG_INFO_DWARF5
>
> $ make -skj"$(nproc)" ARCH=x86_64 LLVM=1 olddefconfig all
> ...
> die__process_unit: DW_TAG_label (0xa) @ <0x7b> not handled!
> die__process_unit: tag not supported 0xa (label)!
> die__process_unit: DW_TAG_label (0xa) @ <0x97> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0xbd> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0xed> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x109> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x12a> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x146> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x16f> not handled!

Running llvm-dwarfdump on vmlinux, I see:

```
$ make -skj"$(nproc)" ARCH=x86_64 LLVM=1 olddefconfig all
die__process_unit: DW_TAG_label (0xa) @ <0xbf> not handled!
die__process_unit: tag not supported 0xa (label)!
...
$ llvm-dwarfdump vmlinux | less
...
0x000000bf:   DW_TAG_label
                DW_AT_name      ("startup_64")
                DW_AT_decl_file
("/android0/kernel-all/arch/x86/kernel/head_64.S")
                DW_AT_decl_line (868)
                DW_AT_low_pc    (0xffffffff81000000)

0x000000db:   DW_TAG_label
                DW_AT_name      ("secondary_startup_64")
                DW_AT_decl_file
("/android0/kernel-all/arch/x86/kernel/head_64.S")
                DW_AT_decl_line (921)
                DW_AT_low_pc    (0xffffffff81000060)
...
```

So these seem to be labels in assembler sources.  The DW_TAGs look the
same to be for labels from C sources.

> ...
>
> Is this a problem with LLVM or pahole? I do not see this when building
> with GCC + GNU as but that could just be a red herring. I assume that
> there could be something missing for processing debug info from
> assembly, perhaps?

That's what I suspect.

> If there is any further information I can provide or
> anything I can test, I am more than happy to do so.
>
> Cheers,
> Nathan

I swear I used to be able to build pahole from sources...just moved to
a new machine and something seems off...
$ sudo apt install libdwarf-dev libdw-dev
$ git clone git://git.kernel.org/pub/scm/devel/pahole/pahole.git
$ mkdir pahole/build
$ cd !$
$ cmake -D__LIB=lib ..
$ make
...
[ 63%] Linking C executable codiff
/usr/bin/ld: libdwarves.so.1.0.0: undefined reference to `dwfl_module_getelf'
/usr/bin/ld: libdwarves.so.1.0.0: undefined reference to `dwfl_report_end'
...
-- 
Thanks,
~Nick Desaulniers
