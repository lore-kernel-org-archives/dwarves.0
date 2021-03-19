Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B309FC433E0
	for <linux-dwarves@archiver.kernel.org>; Fri, 19 Mar 2021 23:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8479F6196E
	for <linux-dwarves@archiver.kernel.org>; Fri, 19 Mar 2021 23:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhCSXrw (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 19 Mar 2021 19:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhCSXrv (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Fri, 19 Mar 2021 19:47:51 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79303C061760
        for <dwarves@vger.kernel.org>; Fri, 19 Mar 2021 16:47:51 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id u5so12282191ejn.8
        for <dwarves@vger.kernel.org>; Fri, 19 Mar 2021 16:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z8N6y2cPyajfBd+3nVitG0kgP25GzlYOsIPLOQdJGoc=;
        b=KRqa50tgQHbOws0lCC/IEEN/Vh3MoqhwS9PuXjYmgMQqVKPy3nVc0GdiUrvAGuuYIY
         zs/c9JFFeQ08QqWFmfkHXcOIY+FicinQ2WWjdz4j5UJDYQcYd0qAs3Vnt9NKrRFTCnH1
         O+FKfZ0JAcDEuNaqi4NR8bdJGAgG8xZygXna3ld+QcUqaRqcCiBbMbgahESXGI7vDFvD
         T3Z/+YQ+QCTzsZG9/8u2smmRrKzeLfaIohl8EoKWawFYx2ypm8wNq5M5Jz9GFVKEtv0u
         gnavzcvzZ58xIGs4SgZyfWDekVR0DqXcBL3c1HUcavhCQsvkKSlfJ53L0viPoz82OQYa
         8TJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z8N6y2cPyajfBd+3nVitG0kgP25GzlYOsIPLOQdJGoc=;
        b=uHwkxgPa+Xb1T1/9QeCv9bBhsiOqlK3Z6gxxXV9be0NkcaBBvRURg7w/+Keu8qslIW
         buJSmDRQHrZqqJJVJYsByrGMWeyQjAHSGJy/Ot7DmES8pnL7ADJ9f5GB+q66zPlMFuM0
         YkYIZ3W0K/ZSAnrhlNDMdPBnfyUyyNdHt7mKYx7cAihv9+sQNkiD0/MNDhRuYmyJG1jG
         MZ2iQkW2AKL85s+4f3P2apXpD6yZLBDxIidaZnPofHsYywc9LwrZNMseyJQ1YBEI0G0Z
         KyTgK606iECW/K1K0VY7xb9X9UYSpVAY5wG9dFub6rDxxlM4bIRaL3o/IKGG1zrjD3TD
         86sA==
X-Gm-Message-State: AOAM533lP4zsv8FBjMvodJjChWerK1Et71uwRFdsAitNAQvFoVKMFGj6
        AUUngbQ624IzJHylxg83c5309n/nHej1pyghJj9a16EQwMKL
X-Google-Smtp-Source: ABdhPJysMeU9/7fRt6JK4OFvId+se6U/bUzu7nWj/WCLpn2m/5WRXPoo/wwtjsa0wMRHGiAfoP0ywOfeRD7PkmHi7VI=
X-Received: by 2002:a17:906:a413:: with SMTP id l19mr7167792ejz.421.1616197669914;
 Fri, 19 Mar 2021 16:47:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210317232657.mdnsuoqx6nbddjgt@google.com> <CAEf4BzZgNPAv+AbVjU+rS89WbmJGuEyk9QwQfyei438dNt7EBQ@mail.gmail.com>
 <CAGG=3QUqO6UiSgr188TBT0V3OytHdYFVrL0PUKm7f3caoqG2qA@mail.gmail.com> <CAEf4BzZN+24=x1QWY2Zq_eQM72DCmCrzmGSUyhcyqi36ApwgTA@mail.gmail.com>
In-Reply-To: <CAEf4BzZN+24=x1QWY2Zq_eQM72DCmCrzmGSUyhcyqi36ApwgTA@mail.gmail.com>
From:   Bill Wendling <morbo@google.com>
Date:   Fri, 19 Mar 2021 16:47:38 -0700
Message-ID: <CAGG=3QXEHDNBXx_gAkMfTn1xV2KOsRP4jrds-43RUYNfd=F1bg@mail.gmail.com>
Subject: Re: pahole -J usage in kernel scripts/link-vmlinux.sh
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Fangrui Song <maskray@google.com>, dwarves@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Fri, Mar 19, 2021 at 4:38 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Mar 19, 2021 at 4:30 PM Bill Wendling <morbo@google.com> wrote:
> >
> > On Fri, Mar 19, 2021 at 3:44 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Wed, Mar 17, 2021 at 4:28 PM Fangrui Song <maskray@google.com> wro=
te:
> > > >
> > > > Hi BTF folks,
> > > >
> > > > I have discovered some problems with pahole -J.
> > > > Its usage in kernel scripts/link-vmlinux.sh is like (make LLVM=3D1 =
bzImage):
> > > >
> > > > ld.lld -m elf_x86_64 --emit-relocs --discard-none -z max-page-size=
=3D0x200000 --build-id=3Dsha1 --orphan-handling=3Dwarn -o .tmp_vmlinux.btf =
-T ./arch/x86/kernel/vmlinux.lds --whole-archive arch/x86/kernel/head_64.o =
arch/x86/kernel/head64.o arch/x86/kernel/ebda.o arch/x86/kernel/platform-qu=
irks.o init/built-in.a usr/built-in.a arch/x86/built-in.a kernel/built-in.a=
 certs/built-in.a mm/built-in.a fs/built-in.a ipc/built-in.a security/built=
-in.a crypto/built-in.a block/built-in.a lib/built-in.a arch/x86/lib/built-=
in.a lib/lib.a arch/x86/lib/lib.a drivers/built-in.a sound/built-in.a net/b=
uilt-in.a virt/built-in.a arch/x86/pci/built-in.a arch/x86/power/built-in.a=
 arch/x86/video/built-in.a --no-whole-archive --start-group --end-group
> > > > pahole -J .tmp_vmlinux.btf
> > > > llvm-objcopy --only-section=3D.BTF --set-section-flags .BTF=3Dalloc=
,readonly --strip-all .tmp_vmlinux.btf .btf.vmlinux.bin.o
> > > >
> > > > pahole -J adds .BTF and rewrites .tmp_vmlinux.btf, then llvm-objcop=
y produces .btf.vmlinux.bin.o of just one section.
> > > > Why doesn't pahole provide a command generating an object file with=
 just the .BTF section?
> > > >
> > >
> > > We just recently discussed adding this. So the reason is that
> > > historically pahole never had this feature and no one bothered to add
> > > it.
> > >
> > > >
> > > >
> > > > When I contributed https://git.kernel.org/linus/90ceddcb495008ac8ba=
7a3dce297841efcd7d584 ,
> > > > I remember pahole at that time added a non-SHF_ALLOC .BTF , now (1.=
20) .BTF becomes SHF_ALLOC.
> > >
> > > I don't think anything changed in 1.20 about how .BTF is added. pahol=
e
> > > still uses the same llvm-objcopt and it doesn't add SHF_ALLOC. And I
> > > just double-checked that after running pahole -j .tmp_vmlinux.btf has
> > > non-allocatable .BTF section:
> > >
> > > $ llvm-readelf -S ~/tmp/pahole-vmlinux-output.o | grep BTF
> > >   [13] .BTF_ids          PROGBITS        ffffffff822b6804 14b6804
> > > 000510 00   A  0   0  1
> > >   [43] .BTF              PROGBITS        0000000000000000 18bc0e8c
> > > 4c8056 00      0   0  1
> > >
> > >
> > > > This is problematic if pahole does not have full-fledged binary man=
ipulation ability (objcopy,llvm-objcopy).
> > > >
> > > > In particular, there are two bugs:
> > > >
> > > > * pahole does not respect max-page-size (p_align of PT_LOAD). See t=
he .text section, its
> > > >    sh_offset !=3D sh_addr (mod max-page-size)
> > > >
> > > >   Section Headers:
> > > >     [Nr] Name              Type            Address          Off    =
Size   ES Flg Lk Inf Al
> > > >     [ 0]                   NULL            0000000000000000 000000 =
000000 00      0   0  0
> > > > -  [ 1] .text             PROGBITS        ffffffff81000000 200000 1=
003917 00  AX  0   0 4096
> > > > +  [ 1] .text             PROGBITS        ffffffff81000000 001000 e=
0169a 00  AX  0   0 4096
> > > >
> > > > * pahole does not rewrite p_offset/p_filesz of PT_LOAD segments.
> > > >    Because of the first bug, pahole -J rewritten object file genera=
lly has small offsets.
> > > >    If p_offset/p_filesz of PT_LOAD segments are not rewritten, the =
file offset range of .symtab may be within
> > > >    a PT_LOAD range. llvm-objcopy --strip-all considers .symtab as p=
art of the PT_LOAD and refuses --strip-all:
> > > >
> > > >    error: '.tmp_vmlinux.btf': string table '.strtab' cannot be remo=
ved because it is referenced by the symbol table '.symtab'
> > > >
> > > >    This is very rare, though.
> > > >
> > > >
> > > > So I suggest:
> > > >
> > > > * pahole -J: restore the previous non-SHF_ALLOC behavior. Don't rew=
rite sh_offset of existing sections.
> > >
> > > so nothing changed (at least as of 1.20) about how pahole adds .BTF,
> > > so I'd like to understand why our observations differ
> > >
> > Here's one things we're seeing (note, we're using a kernel based on
> > 4.15). Before we run pahole, we have this. Notice the offset of the
> > '.text' section:
> >
> >   [ 0]                   NULL            0000000000000000 000000
> > 000000 00      0   0  0
> >   [ 1] .text             PROGBITS        ffffffff81000000 200000
> > e0169a 00  AX  0   0 4096
> >   [ 2] .notes            NOTE            ffffffff81e0169c 100169c
> > 000024 00   A  0   0  4
> > ...
> >   [24] .BTF              PROGBITS        ffffffff825caf40 17caf40
> > 000000 00  WA  0   0  1
> >   [25] .BTF_ids          PROGBITS        ffffffff825caf40 17caf40
> > 0004c0 00   A  0   0  1
> >
> > After running pahole, we get this:
> >
> >   [ 0]                   NULL            0000000000000000 000000
> > 000000 00      0   0  0
> >   [ 1] .text             PROGBITS        ffffffff81000000 001000
> > e0169a 00  AX  0   0 4096
> >   [ 2] .notes            NOTE            ffffffff81e0169c e0269c
> > 000024 00   A  0   0  4
> > ...
> >   [24] .BTF              PROGBITS        ffffffff825caf40 11ecf40
> > 3c1ebe 00  WA  0   0  1
> >   [25] .BTF_ids          PROGBITS        ffffffff825caf40 15aedfe
> > 0004c0 00   A  0   0  1
> >
> > The offset of '.text' changed. This is because `elf_update` decides
> > what the offsets should be. Did the linker scripts change between 4.15
> > and top-of-tree to mark .BTF as non-allocatable?
>
> maybe so, but .tmp_vmlinux.btf which gets .BTF is discarded and not
> used anymore. We only dump .BTF section into a separate ELF, which is
> linked into the final vmlinux image as the next step. So pahole
> doesn't rewrite the final binary.
>
Right. The problem is with the follow-up command:

        ${OBJCOPY} --only-section=3D.BTF --set-section-flags .BTF=3Dalloc,r=
eadonly \
                --strip-all ${1} ${2} 2>/dev/null

The file .tmp_vmlinux.btf isn't "correct" (see maskray's explanation),
so this command fails to write a valid ELF file.

-bw
