Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB557C433DB
	for <linux-dwarves@archiver.kernel.org>; Fri, 19 Mar 2021 23:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B020D6192E
	for <linux-dwarves@archiver.kernel.org>; Fri, 19 Mar 2021 23:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhCSXiu (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 19 Mar 2021 19:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhCSXi0 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Fri, 19 Mar 2021 19:38:26 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FB8C061760
        for <dwarves@vger.kernel.org>; Fri, 19 Mar 2021 16:38:25 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id e193so3156697ybc.6
        for <dwarves@vger.kernel.org>; Fri, 19 Mar 2021 16:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uMM7nMzEagNEyf7RJFLLXpYyRTUrX5DN56blB4XW/v8=;
        b=TA4YHiJ0qeXgInUyOAEyY2ev6bA8+Ayqb6fNzV9go7ExKlli14u4THCFJENss4Cxd7
         967lHoFZBQwKtC8Vr0YUHec/OkuYnFlmJruQoH0oAddIHouZoMPtU77yV1e1757Rs6SP
         U4JtlzMq4uziYWm6VXha6WUbrKwO7ze2Cfe6845Kv356qeHmIKOfvZZslSV84zdCm7eP
         r+TAX8hLWHTDFLQqgmqNSbhRpqEHh5GE3RkKnzRzJfU3kwPvaBDvvAdt+LXx4Eqtgs0c
         XwfgIsC8DjwwXsR03F5a76sUUCsRDAzr0CTOjn0BlSjZ+7gB/i6dKjlNKPauxtdHKDdq
         1BUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uMM7nMzEagNEyf7RJFLLXpYyRTUrX5DN56blB4XW/v8=;
        b=fUnXVoOyR4alQ3pzn17ASBwGYQG+aT1TTD1eI1pJX5kkAQgLROyE3ABrN76OkLg8GY
         DnN0M2T2nKlAzxVk6Xz0Ugm7saVXJ07BuGBUPUHW/yfLmPJ32FJtR7H5/lm1qRicrtco
         bSsZwSUuTg7oI7rk3HZAr49KE7XVEcq6fsLxnRHouomdelmGipXwHRbMU5fIYx3WbXhr
         g9GTvA9P7YXkY+ucY6uHORhe+b/ag6HgLx/f3w2j+3ZflOqGj69ATKsJUDHpeZXd9d2B
         t2Xf/mwBxwHRAcC1Rtx1GGaai8+W4K9XMEtL6jYU5aM0TORjZ5uP4V6qQYawm+wrAyOx
         N5og==
X-Gm-Message-State: AOAM533NyDNobJ4gGe0MwxYVcjXClZHEISZf57r6EcgAmpKkb5jpJqn6
        ncIBNmjSNTeol8JXvQkIA3wp8eBkpW7n0RiX/9k=
X-Google-Smtp-Source: ABdhPJwBKiWGbSgCRyoZOAAoSY2q0Cc0a6i54kT6sRQ1MYxLXs+xHIb6o1upoF+3CVQieq7EzI7xB+GeE4P/Os4q9wc=
X-Received: by 2002:a25:40d8:: with SMTP id n207mr9518606yba.459.1616197104797;
 Fri, 19 Mar 2021 16:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210317232657.mdnsuoqx6nbddjgt@google.com> <CAEf4BzZgNPAv+AbVjU+rS89WbmJGuEyk9QwQfyei438dNt7EBQ@mail.gmail.com>
 <CAGG=3QUqO6UiSgr188TBT0V3OytHdYFVrL0PUKm7f3caoqG2qA@mail.gmail.com>
In-Reply-To: <CAGG=3QUqO6UiSgr188TBT0V3OytHdYFVrL0PUKm7f3caoqG2qA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 19 Mar 2021 16:38:13 -0700
Message-ID: <CAEf4BzZN+24=x1QWY2Zq_eQM72DCmCrzmGSUyhcyqi36ApwgTA@mail.gmail.com>
Subject: Re: pahole -J usage in kernel scripts/link-vmlinux.sh
To:     Bill Wendling <morbo@google.com>
Cc:     Fangrui Song <maskray@google.com>, dwarves@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Fri, Mar 19, 2021 at 4:30 PM Bill Wendling <morbo@google.com> wrote:
>
> On Fri, Mar 19, 2021 at 3:44 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Mar 17, 2021 at 4:28 PM Fangrui Song <maskray@google.com> wrote=
:
> > >
> > > Hi BTF folks,
> > >
> > > I have discovered some problems with pahole -J.
> > > Its usage in kernel scripts/link-vmlinux.sh is like (make LLVM=3D1 bz=
Image):
> > >
> > > ld.lld -m elf_x86_64 --emit-relocs --discard-none -z max-page-size=3D=
0x200000 --build-id=3Dsha1 --orphan-handling=3Dwarn -o .tmp_vmlinux.btf -T =
./arch/x86/kernel/vmlinux.lds --whole-archive arch/x86/kernel/head_64.o arc=
h/x86/kernel/head64.o arch/x86/kernel/ebda.o arch/x86/kernel/platform-quirk=
s.o init/built-in.a usr/built-in.a arch/x86/built-in.a kernel/built-in.a ce=
rts/built-in.a mm/built-in.a fs/built-in.a ipc/built-in.a security/built-in=
.a crypto/built-in.a block/built-in.a lib/built-in.a arch/x86/lib/built-in.=
a lib/lib.a arch/x86/lib/lib.a drivers/built-in.a sound/built-in.a net/buil=
t-in.a virt/built-in.a arch/x86/pci/built-in.a arch/x86/power/built-in.a ar=
ch/x86/video/built-in.a --no-whole-archive --start-group --end-group
> > > pahole -J .tmp_vmlinux.btf
> > > llvm-objcopy --only-section=3D.BTF --set-section-flags .BTF=3Dalloc,r=
eadonly --strip-all .tmp_vmlinux.btf .btf.vmlinux.bin.o
> > >
> > > pahole -J adds .BTF and rewrites .tmp_vmlinux.btf, then llvm-objcopy =
produces .btf.vmlinux.bin.o of just one section.
> > > Why doesn't pahole provide a command generating an object file with j=
ust the .BTF section?
> > >
> >
> > We just recently discussed adding this. So the reason is that
> > historically pahole never had this feature and no one bothered to add
> > it.
> >
> > >
> > >
> > > When I contributed https://git.kernel.org/linus/90ceddcb495008ac8ba7a=
3dce297841efcd7d584 ,
> > > I remember pahole at that time added a non-SHF_ALLOC .BTF , now (1.20=
) .BTF becomes SHF_ALLOC.
> >
> > I don't think anything changed in 1.20 about how .BTF is added. pahole
> > still uses the same llvm-objcopt and it doesn't add SHF_ALLOC. And I
> > just double-checked that after running pahole -j .tmp_vmlinux.btf has
> > non-allocatable .BTF section:
> >
> > $ llvm-readelf -S ~/tmp/pahole-vmlinux-output.o | grep BTF
> >   [13] .BTF_ids          PROGBITS        ffffffff822b6804 14b6804
> > 000510 00   A  0   0  1
> >   [43] .BTF              PROGBITS        0000000000000000 18bc0e8c
> > 4c8056 00      0   0  1
> >
> >
> > > This is problematic if pahole does not have full-fledged binary manip=
ulation ability (objcopy,llvm-objcopy).
> > >
> > > In particular, there are two bugs:
> > >
> > > * pahole does not respect max-page-size (p_align of PT_LOAD). See the=
 .text section, its
> > >    sh_offset !=3D sh_addr (mod max-page-size)
> > >
> > >   Section Headers:
> > >     [Nr] Name              Type            Address          Off    Si=
ze   ES Flg Lk Inf Al
> > >     [ 0]                   NULL            0000000000000000 000000 00=
0000 00      0   0  0
> > > -  [ 1] .text             PROGBITS        ffffffff81000000 200000 100=
3917 00  AX  0   0 4096
> > > +  [ 1] .text             PROGBITS        ffffffff81000000 001000 e01=
69a 00  AX  0   0 4096
> > >
> > > * pahole does not rewrite p_offset/p_filesz of PT_LOAD segments.
> > >    Because of the first bug, pahole -J rewritten object file generall=
y has small offsets.
> > >    If p_offset/p_filesz of PT_LOAD segments are not rewritten, the fi=
le offset range of .symtab may be within
> > >    a PT_LOAD range. llvm-objcopy --strip-all considers .symtab as par=
t of the PT_LOAD and refuses --strip-all:
> > >
> > >    error: '.tmp_vmlinux.btf': string table '.strtab' cannot be remove=
d because it is referenced by the symbol table '.symtab'
> > >
> > >    This is very rare, though.
> > >
> > >
> > > So I suggest:
> > >
> > > * pahole -J: restore the previous non-SHF_ALLOC behavior. Don't rewri=
te sh_offset of existing sections.
> >
> > so nothing changed (at least as of 1.20) about how pahole adds .BTF,
> > so I'd like to understand why our observations differ
> >
> Here's one things we're seeing (note, we're using a kernel based on
> 4.15). Before we run pahole, we have this. Notice the offset of the
> '.text' section:
>
>   [ 0]                   NULL            0000000000000000 000000
> 000000 00      0   0  0
>   [ 1] .text             PROGBITS        ffffffff81000000 200000
> e0169a 00  AX  0   0 4096
>   [ 2] .notes            NOTE            ffffffff81e0169c 100169c
> 000024 00   A  0   0  4
> ...
>   [24] .BTF              PROGBITS        ffffffff825caf40 17caf40
> 000000 00  WA  0   0  1
>   [25] .BTF_ids          PROGBITS        ffffffff825caf40 17caf40
> 0004c0 00   A  0   0  1
>
> After running pahole, we get this:
>
>   [ 0]                   NULL            0000000000000000 000000
> 000000 00      0   0  0
>   [ 1] .text             PROGBITS        ffffffff81000000 001000
> e0169a 00  AX  0   0 4096
>   [ 2] .notes            NOTE            ffffffff81e0169c e0269c
> 000024 00   A  0   0  4
> ...
>   [24] .BTF              PROGBITS        ffffffff825caf40 11ecf40
> 3c1ebe 00  WA  0   0  1
>   [25] .BTF_ids          PROGBITS        ffffffff825caf40 15aedfe
> 0004c0 00   A  0   0  1
>
> The offset of '.text' changed. This is because `elf_update` decides
> what the offsets should be. Did the linker scripts change between 4.15
> and top-of-tree to mark .BTF as non-allocatable?

maybe so, but .tmp_vmlinux.btf which gets .BTF is discarded and not
used anymore. We only dump .BTF section into a separate ELF, which is
linked into the final vmlinux image as the next step. So pahole
doesn't rewrite the final binary.

>
> -bw
>
> > >    Place the new non-SHF_ALLOC .BTF section at the end.
> > >    Then not rewriting PT_LOAD will be justified.
> > > * Add a new option incorporating the current pahole -J + llvm-objcopy
> >
> > pahole is already using llvm-objcopy. Do you mean to add a mode where
> > pahole will dump a separate ELF object file with just .BTF? Or
> > something else?
