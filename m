Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0ABC433E0
	for <linux-dwarves@archiver.kernel.org>; Fri,  5 Feb 2021 21:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7EE464DD5
	for <linux-dwarves@archiver.kernel.org>; Fri,  5 Feb 2021 21:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbhBEVmB (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 5 Feb 2021 16:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhBEVlA (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Fri, 5 Feb 2021 16:41:00 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251E7C061756
        for <dwarves@vger.kernel.org>; Fri,  5 Feb 2021 13:40:20 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id f1so11959580lfu.3
        for <dwarves@vger.kernel.org>; Fri, 05 Feb 2021 13:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HZYn5Ce+L0yx8LnAN5tmPGD2JqoQJUOBT07GkqQWBng=;
        b=MK6YRXtYAchkAyJlAy7ambep9El1MPm8OChMY/h3gMlXkqEQJFXa+cWdqi+VQV3fsa
         JFGtm4w92co/kRBkTNlHeYHmNRGRyZZLjlV426BAhsxb7dhe1W7ZaVH4+Nu+bdUH7U0X
         nYaCuFGCGKpcVQ5mUS/PcT5PdA5a0ul28nbQVvmT5OcM3EQJrYl+PO9W/slCPpr/MPxX
         RxQI4l2IU0P4n6MmUIdxWn1QexU0loIFZ/23M7LxAAshOGUkBW3+d3JcPO1fD+lFII08
         +HnLb52xHtz1z0Sg4MiD7Qa7gdiwrdxK86kBTHHObCC9gF7hHO7bJELwjnraYCGBzPpG
         Pybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HZYn5Ce+L0yx8LnAN5tmPGD2JqoQJUOBT07GkqQWBng=;
        b=B2sMrbwO5RNL+pxjiwz2WkldSo3oWit+B2A3YvGzGVYdS6V7fZyWmYGdueSYVgGuKl
         8xZx9jyL52iqFF7sLKbp1H8RWdG+xqjHaFKk3IJE+J7xQo6/Jd7B9hgt0T41NUTB1G3I
         v5xwIqWwg9GIiaBOOON/+HDs/qAWLtUO3jCFUJC4Z1+ijqqTqLDGTDwy4CFF55okOGdM
         UVxSsFBqOvi9j0dMHWeXkO6dRJcK0j/SOESZKLNDCdFTJMwoicKy87dci8w8W+zAQAYK
         /3UkEvze7FDRnjJcdEFrPm99zN+6hr1TrjIuLaMKoY/7r1Pdte0wI7lINIxeYCOQhllw
         uX8Q==
X-Gm-Message-State: AOAM533HWe4yDUtqujxhUu54BtmEoVmbu9mqZHrUyiT2vJCGakKKl1aJ
        4jJJL4QB2cJ6m509egT70tR61NqZd8r6lAOKTN3EHQ==
X-Google-Smtp-Source: ABdhPJyG5EKrUDm90MbScH/89VdYI31kchDTGyATQSzF9IWc/r5yRiq8+wws2poKBu0xdKkbolfeGMMlibLyZuzKnYc=
X-Received: by 2002:ac2:5e90:: with SMTP id b16mr3431873lfq.122.1612561218365;
 Fri, 05 Feb 2021 13:40:18 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUVQSojGgnis8Ds5GW-7-PVMZ2w4X5nQKSSkBPf-29NS6Q@mail.gmail.com>
 <20210205211010.2764627-1-ndesaulniers@google.com> <CA+icZUXkCC9U3PsYzqhzu7BZa-eE2kd53SfX2ODrr+N=QO6VvQ@mail.gmail.com>
In-Reply-To: <CA+icZUXkCC9U3PsYzqhzu7BZa-eE2kd53SfX2ODrr+N=QO6VvQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 5 Feb 2021 13:40:05 -0800
Message-ID: <CAKwvOd=ktdttx5E=_k7B-WuJsic3imOecTUDyaQA9VUpLF45Jw@mail.gmail.com>
Subject: Re: ERROR: INT DW_ATE_unsigned_1 Error emitting BTF type
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, arnaldo.melo@gmail.com,
        berrange@redhat.com, bpf <bpf@vger.kernel.org>, cavok@debian.org,
        dwarves@vger.kernel.org, jengelh@inai.de,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Wielaard <mjw@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>, paul@paul-moore.com,
        Tom Stellard <tstellar@redhat.com>, Yonghong Song <yhs@fb.com>,
        zzam@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Fri, Feb 5, 2021 at 1:17 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Fri, Feb 5, 2021 at 10:10 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > > Hi,
> > >
> > > when building with pahole v1.20 and binutils v2.35.2 plus Clang
> > > v12.0.0-rc1 and DWARF-v5 I see:
> > > ...
> > > + info BTF .btf.vmlinux.bin.o
> > > + [  != silent_ ]
> > > + printf   %-7s %s\n BTF .btf.vmlinux.bin.o
> > >  BTF     .btf.vmlinux.bin.o
> > > + LLVM_OBJCOPY=/opt/binutils/bin/objcopy /opt/pahole/bin/pahole -J
> > > .tmp_vmlinux.btf
> > > [115] INT DW_ATE_unsigned_1 Error emitting BTF type
> > > Encountered error while encoding BTF.
> >
> > Yes, I observe this error, too.
> >
> > https://gist.github.com/nickdesaulniers/ae8c9efbe4da69b1cf0dce138c1d2781
> >
> > via v9 of my DWARF v5 series, which should help make this easier to
> > reproduce:
> > https://lore.kernel.org/lkml/CA+icZUW3sg_PkbmKSFMs6EqwQV7=hvKuAgZSsbg=Qr6gTs7RbQ@mail.gmail.com/T/#m45ec7e6df4c4b5e9da034b95d7dfc8e2a0c81dac
>
> Thanks Nick for confirming the error.
>
> Ah, I see you passed:
>
> make LLVM=1 LLVM_IAS=1 ...
>
> Can you by chance try with KCFLAGS="-fbinutils-version=2.35"?

$ PATH=/path/to/tot/pahole/build:$PATH make LLVM=1 LLVM_IAS=1 -j72
KCFLAGS="-fbinutils-version=2.35"
...
  BTF     .btf.vmlinux.bin.o
[12919] INT DW_ATE_unsigned_1 Error emitting BTF type
Encountered error while encoding BTF.
...
  LD      vmlinux
  BTFIDS  vmlinux
FAILED: load BTF from vmlinux: Invalid argument
-- 
Thanks,
~Nick Desaulniers
