Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECC1C433DB
	for <linux-dwarves@archiver.kernel.org>; Sat, 20 Mar 2021 17:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEDE76192D
	for <linux-dwarves@archiver.kernel.org>; Sat, 20 Mar 2021 17:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhCTRVf (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Sat, 20 Mar 2021 13:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbhCTRVU (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Sat, 20 Mar 2021 13:21:20 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33044C061574
        for <dwarves@vger.kernel.org>; Sat, 20 Mar 2021 10:21:20 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id j2so1768601ybj.8
        for <dwarves@vger.kernel.org>; Sat, 20 Mar 2021 10:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u5klhgbEvLJVgXMwnLQ60ZVPPUUei8zTBLFhfuCN0X0=;
        b=h8Q+KDthPoIcDK3BmFqD6V6tGgdS9r5cfw2KVJszJtRIaHn9n2Cd5d62wPjXJNi+BU
         MVUCInAvw1Ktv9RL2w6nGN5jL1QT6cTuhmSXhKMPQGSGsJrso9aatqNNNMJdZCDpvfNr
         5rg4xUrpokDs3LkeQDRPUUBkaHFHXq7YHuZoE2I6hHcUk0IBUFtYve8wIw0GDvxwWEqy
         22d72Wnflc/ZmtTXkxxlKskftzCZ6qGZ/xSVnfDdGDJOQreJ8D6F5xHeHg5ot5dJtvxw
         S9Pzk9s8qPogUJHbCTsBoEWmSL3cXXieAo0tQH6nCpxvvUzacAk+ReKZ1n3BAZsdDGpZ
         vpxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u5klhgbEvLJVgXMwnLQ60ZVPPUUei8zTBLFhfuCN0X0=;
        b=tvDbngR9k71FsSHpGzE1cetaRwKDtLajaq/LXuRs552mCrJCw2J/dMt8GYNC7I/uSZ
         NjlEy16MijEsFtqSmJhXPvPnS4RyhLWrB8d4EnCZxkhggLyyPCFUl6YN+CKhad6PTVIp
         4xQ/FfHaim+xAT1ijDg8kSBfTsSPPBmuxC8OF5pjrHwVAS1L196RSodJemQkzltuPuSn
         0Cq7SMe87RwVEjzVJeh9uYYEz1/jKY5+2JfVEXX8fstpRB9G22QVw/xmx5iMNj8BnwMe
         qM85mTj5tFtKQa9iGhv8vYEtWukbuuhM59prHFm1ufaqY1BLJQJ8/G3cgOJsuTNABQpP
         ITSw==
X-Gm-Message-State: AOAM532R/n8OB36joJuEPIjYNoXYeel2sCcWx6/FMtxckfPmKyPnk2uA
        MHxwKsrkSjtwVlGivOXijO3OrxCiHjmeDdkQ+4kBM4F3zb4=
X-Google-Smtp-Source: ABdhPJx6tvOSuXKPQuYm0NM3r8xFVFsdIGG0tZQLNEckFJ/PhtY/W7eMBNgj+j9ZM74jlIuX2zJBGypayJlH5uiqe/E=
X-Received: by 2002:a25:874c:: with SMTP id e12mr13848472ybn.403.1616260879540;
 Sat, 20 Mar 2021 10:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210317232657.mdnsuoqx6nbddjgt@google.com> <CAEf4BzZgNPAv+AbVjU+rS89WbmJGuEyk9QwQfyei438dNt7EBQ@mail.gmail.com>
 <CAGG=3QUqO6UiSgr188TBT0V3OytHdYFVrL0PUKm7f3caoqG2qA@mail.gmail.com>
 <CAEf4BzZN+24=x1QWY2Zq_eQM72DCmCrzmGSUyhcyqi36ApwgTA@mail.gmail.com> <CAGG=3QXEHDNBXx_gAkMfTn1xV2KOsRP4jrds-43RUYNfd=F1bg@mail.gmail.com>
In-Reply-To: <CAGG=3QXEHDNBXx_gAkMfTn1xV2KOsRP4jrds-43RUYNfd=F1bg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 20 Mar 2021 10:21:08 -0700
Message-ID: <CAEf4BzY_0ihWfuPdMYk7OG_W64yiL8L56dNpU0pFKV3crNs=Vw@mail.gmail.com>
Subject: Re: pahole -J usage in kernel scripts/link-vmlinux.sh
To:     Bill Wendling <morbo@google.com>
Cc:     Fangrui Song <maskray@google.com>, dwarves@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Fri, Mar 19, 2021 at 4:47 PM Bill Wendling <morbo@google.com> wrote:
>
> On Fri, Mar 19, 2021 at 4:38 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Mar 19, 2021 at 4:30 PM Bill Wendling <morbo@google.com> wrote:
> > >
> > > On Fri, Mar 19, 2021 at 3:44 PM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Wed, Mar 17, 2021 at 4:28 PM Fangrui Song <maskray@google.com> w=
rote:
> > > > >
> > > > > Hi BTF folks,
> > > > >
> > > > > I have discovered some problems with pahole -J.
> > > > > Its usage in kernel scripts/link-vmlinux.sh is like (make LLVM=3D=
1 bzImage):
> > > > >
> > > > > ld.lld -m elf_x86_64 --emit-relocs --discard-none -z max-page-siz=
e=3D0x200000 --build-id=3Dsha1 --orphan-handling=3Dwarn -o .tmp_vmlinux.btf=
 -T ./arch/x86/kernel/vmlinux.lds --whole-archive arch/x86/kernel/head_64.o=
 arch/x86/kernel/head64.o arch/x86/kernel/ebda.o arch/x86/kernel/platform-q=
uirks.o init/built-in.a usr/built-in.a arch/x86/built-in.a kernel/built-in.=
a certs/built-in.a mm/built-in.a fs/built-in.a ipc/built-in.a security/buil=
t-in.a crypto/built-in.a block/built-in.a lib/built-in.a arch/x86/lib/built=
-in.a lib/lib.a arch/x86/lib/lib.a drivers/built-in.a sound/built-in.a net/=
built-in.a virt/built-in.a arch/x86/pci/built-in.a arch/x86/power/built-in.=
a arch/x86/video/built-in.a --no-whole-archive --start-group --end-group
> > > > > pahole -J .tmp_vmlinux.btf
> > > > > llvm-objcopy --only-section=3D.BTF --set-section-flags .BTF=3Dall=
oc,readonly --strip-all .tmp_vmlinux.btf .btf.vmlinux.bin.o
> > > > >
> > > > > pahole -J adds .BTF and rewrites .tmp_vmlinux.btf, then llvm-objc=
opy produces .btf.vmlinux.bin.o of just one section.
> > > > > Why doesn't pahole provide a command generating an object file wi=
th just the .BTF section?
> > > > >
> > > >
> > > > We just recently discussed adding this. So the reason is that
> > > > historically pahole never had this feature and no one bothered to a=
dd
> > > > it.
> > > >
> > > > >
> > > > >
> > > > > When I contributed https://git.kernel.org/linus/90ceddcb495008ac8=
ba7a3dce297841efcd7d584 ,
> > > > > I remember pahole at that time added a non-SHF_ALLOC .BTF , now (=
1.20) .BTF becomes SHF_ALLOC.
> > > >
> > > > I don't think anything changed in 1.20 about how .BTF is added. pah=
ole
> > > > still uses the same llvm-objcopt and it doesn't add SHF_ALLOC. And =
I
> > > > just double-checked that after running pahole -j .tmp_vmlinux.btf h=
as
> > > > non-allocatable .BTF section:
> > > >
> > > > $ llvm-readelf -S ~/tmp/pahole-vmlinux-output.o | grep BTF
> > > >   [13] .BTF_ids          PROGBITS        ffffffff822b6804 14b6804
> > > > 000510 00   A  0   0  1
> > > >   [43] .BTF              PROGBITS        0000000000000000 18bc0e8c
> > > > 4c8056 00      0   0  1
> > > >
> > > >
> > > > > This is problematic if pahole does not have full-fledged binary m=
anipulation ability (objcopy,llvm-objcopy).
> > > > >
> > > > > In particular, there are two bugs:
> > > > >
> > > > > * pahole does not respect max-page-size (p_align of PT_LOAD). See=
 the .text section, its
> > > > >    sh_offset !=3D sh_addr (mod max-page-size)
> > > > >
> > > > >   Section Headers:
> > > > >     [Nr] Name              Type            Address          Off  =
  Size   ES Flg Lk Inf Al
> > > > >     [ 0]                   NULL            0000000000000000 00000=
0 000000 00      0   0  0
> > > > > -  [ 1] .text             PROGBITS        ffffffff81000000 200000=
 1003917 00  AX  0   0 4096
> > > > > +  [ 1] .text             PROGBITS        ffffffff81000000 001000=
 e0169a 00  AX  0   0 4096
> > > > >
> > > > > * pahole does not rewrite p_offset/p_filesz of PT_LOAD segments.
> > > > >    Because of the first bug, pahole -J rewritten object file gene=
rally has small offsets.
> > > > >    If p_offset/p_filesz of PT_LOAD segments are not rewritten, th=
e file offset range of .symtab may be within
> > > > >    a PT_LOAD range. llvm-objcopy --strip-all considers .symtab as=
 part of the PT_LOAD and refuses --strip-all:
> > > > >
> > > > >    error: '.tmp_vmlinux.btf': string table '.strtab' cannot be re=
moved because it is referenced by the symbol table '.symtab'
> > > > >
> > > > >    This is very rare, though.
> > > > >
> > > > >
> > > > > So I suggest:
> > > > >
> > > > > * pahole -J: restore the previous non-SHF_ALLOC behavior. Don't r=
ewrite sh_offset of existing sections.
> > > >
> > > > so nothing changed (at least as of 1.20) about how pahole adds .BTF=
,
> > > > so I'd like to understand why our observations differ
> > > >
> > > Here's one things we're seeing (note, we're using a kernel based on
> > > 4.15). Before we run pahole, we have this. Notice the offset of the
> > > '.text' section:
> > >
> > >   [ 0]                   NULL            0000000000000000 000000
> > > 000000 00      0   0  0
> > >   [ 1] .text             PROGBITS        ffffffff81000000 200000
> > > e0169a 00  AX  0   0 4096
> > >   [ 2] .notes            NOTE            ffffffff81e0169c 100169c
> > > 000024 00   A  0   0  4
> > > ...
> > >   [24] .BTF              PROGBITS        ffffffff825caf40 17caf40
> > > 000000 00  WA  0   0  1
> > >   [25] .BTF_ids          PROGBITS        ffffffff825caf40 17caf40
> > > 0004c0 00   A  0   0  1
> > >
> > > After running pahole, we get this:
> > >
> > >   [ 0]                   NULL            0000000000000000 000000
> > > 000000 00      0   0  0
> > >   [ 1] .text             PROGBITS        ffffffff81000000 001000
> > > e0169a 00  AX  0   0 4096
> > >   [ 2] .notes            NOTE            ffffffff81e0169c e0269c
> > > 000024 00   A  0   0  4
> > > ...
> > >   [24] .BTF              PROGBITS        ffffffff825caf40 11ecf40
> > > 3c1ebe 00  WA  0   0  1
> > >   [25] .BTF_ids          PROGBITS        ffffffff825caf40 15aedfe
> > > 0004c0 00   A  0   0  1
> > >
> > > The offset of '.text' changed. This is because `elf_update` decides
> > > what the offsets should be. Did the linker scripts change between 4.1=
5
> > > and top-of-tree to mark .BTF as non-allocatable?
> >
> > maybe so, but .tmp_vmlinux.btf which gets .BTF is discarded and not
> > used anymore. We only dump .BTF section into a separate ELF, which is
> > linked into the final vmlinux image as the next step. So pahole
> > doesn't rewrite the final binary.
> >
> Right. The problem is with the follow-up command:
>
>         ${OBJCOPY} --only-section=3D.BTF --set-section-flags .BTF=3Dalloc=
,readonly \
>                 --strip-all ${1} ${2} 2>/dev/null
>
> The file .tmp_vmlinux.btf isn't "correct" (see maskray's explanation),
> so this command fails to write a valid ELF file.

Oh, I see. Yeah, I didn't get that from the original email. So seems
like llvm-objcopy that pahole invokes internally will corrupt that
.tmp_vmlinux.btf file to the point of another objcopy not being able
to handle it. Interesting.

But regardless, as I said, we already discussed this feature and think
that it's a good addition. I'd like to be able to both get object file
with just .BTF (for kernel linking process) and pure binary contents
of .BTF section (for other, CO-RE-related reasons, especially for
legacy systems). I think Arnaldo is onboard as well. So please feel
free to send patches.

>
> -bw
