Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96355C433C1
	for <linux-dwarves@archiver.kernel.org>; Fri, 19 Mar 2021 23:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AEB961981
	for <linux-dwarves@archiver.kernel.org>; Fri, 19 Mar 2021 23:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbhCSXac (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 19 Mar 2021 19:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhCSXaR (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Fri, 19 Mar 2021 19:30:17 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36454C061760
        for <dwarves@vger.kernel.org>; Fri, 19 Mar 2021 16:30:17 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id u5so12243362ejn.8
        for <dwarves@vger.kernel.org>; Fri, 19 Mar 2021 16:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EPoVZ5X+a9FDxdbHDd0gz1tzT/gfcO99XoJkdfxUppg=;
        b=dQ6JNZT6YSxIs+E0SnHsFn0ECGVa2+xN6szWlSWCkmGAynxoGhGTQ1bC6pxfL0jwxV
         YFnDnIKHmWDjO+nPwo+c6dAQfRlUlt9RzlHClq9/rxWgB27l31Yer4U4E/8Zo/WN+dSc
         d+yog3DarToAnXi3Bsd1GXVR0s//TyrMgKFQSaDQ1Js77OT2EmdJZGTAuNhaDuKEJ2zr
         DRjsnHWzr87S7cX3ETgI9IYuzAaza5ZvxDnqUSAzO39926It6bkxUwZkaUOL65lb8ThW
         ajk97PHp/iNwrpYiN8PAs0nwO6eall+puoxjvQ3iP+QchZjFObVTentTg5TGHBpzAKjJ
         lP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EPoVZ5X+a9FDxdbHDd0gz1tzT/gfcO99XoJkdfxUppg=;
        b=k3WlXQXrhunH/+2tRX9Rt2ILyZVGAhRerT7cqNRBl7vSCg755bJIlIX3Qm9QjAwk4O
         poPuBvuaPnE38BU4TgYDCWQysmLoDnZe85K7r1XR3idn7a0cbMWY1Iw+z8p3ZXBvDyEF
         odV2HtPnzHbbk0nl6eMFdEKnyJvWO0HwfG4q6MVzouvyeD93NtdBbe4UOP/LJEa2h5LU
         porSU4k3ZUEOzzhOaVqafNwbzG76tj7V9OjXtVrRXT8P/3zYi0aOX1ysZSQo9vWFsiQg
         riee+iklSDcV8HcJa06PblWcoptPZ0rNp557jNdqwCRNIWTVOqpKbshbuGsqUu54Es2a
         y64g==
X-Gm-Message-State: AOAM532FKJRMb+HqTOoAZEoq7iZg65hk5Ryacx/goWNOm817Hmu1ihB9
        GKvCanig+mDcNO3+7GQOnuEPyUJ+Zr24/+hIn+2d
X-Google-Smtp-Source: ABdhPJxRG1LttmBc9K34NtZsTnpZGbDjL007OfGIoPL2WiFxH+N3q1s+wvz5G8ct8ZYLM6z3Us+b46Ry6a0cKFZ90Uw=
X-Received: by 2002:a17:906:7c44:: with SMTP id g4mr7031906ejp.269.1616196614471;
 Fri, 19 Mar 2021 16:30:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210317232657.mdnsuoqx6nbddjgt@google.com> <CAEf4BzZgNPAv+AbVjU+rS89WbmJGuEyk9QwQfyei438dNt7EBQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZgNPAv+AbVjU+rS89WbmJGuEyk9QwQfyei438dNt7EBQ@mail.gmail.com>
From:   Bill Wendling <morbo@google.com>
Date:   Fri, 19 Mar 2021 16:30:03 -0700
Message-ID: <CAGG=3QUqO6UiSgr188TBT0V3OytHdYFVrL0PUKm7f3caoqG2qA@mail.gmail.com>
Subject: Re: pahole -J usage in kernel scripts/link-vmlinux.sh
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Fangrui Song <maskray@google.com>, dwarves@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Fri, Mar 19, 2021 at 3:44 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Mar 17, 2021 at 4:28 PM Fangrui Song <maskray@google.com> wrote:
> >
> > Hi BTF folks,
> >
> > I have discovered some problems with pahole -J.
> > Its usage in kernel scripts/link-vmlinux.sh is like (make LLVM=3D1 bzIm=
age):
> >
> > ld.lld -m elf_x86_64 --emit-relocs --discard-none -z max-page-size=3D0x=
200000 --build-id=3Dsha1 --orphan-handling=3Dwarn -o .tmp_vmlinux.btf -T ./=
arch/x86/kernel/vmlinux.lds --whole-archive arch/x86/kernel/head_64.o arch/=
x86/kernel/head64.o arch/x86/kernel/ebda.o arch/x86/kernel/platform-quirks.=
o init/built-in.a usr/built-in.a arch/x86/built-in.a kernel/built-in.a cert=
s/built-in.a mm/built-in.a fs/built-in.a ipc/built-in.a security/built-in.a=
 crypto/built-in.a block/built-in.a lib/built-in.a arch/x86/lib/built-in.a =
lib/lib.a arch/x86/lib/lib.a drivers/built-in.a sound/built-in.a net/built-=
in.a virt/built-in.a arch/x86/pci/built-in.a arch/x86/power/built-in.a arch=
/x86/video/built-in.a --no-whole-archive --start-group --end-group
> > pahole -J .tmp_vmlinux.btf
> > llvm-objcopy --only-section=3D.BTF --set-section-flags .BTF=3Dalloc,rea=
donly --strip-all .tmp_vmlinux.btf .btf.vmlinux.bin.o
> >
> > pahole -J adds .BTF and rewrites .tmp_vmlinux.btf, then llvm-objcopy pr=
oduces .btf.vmlinux.bin.o of just one section.
> > Why doesn't pahole provide a command generating an object file with jus=
t the .BTF section?
> >
>
> We just recently discussed adding this. So the reason is that
> historically pahole never had this feature and no one bothered to add
> it.
>
> >
> >
> > When I contributed https://git.kernel.org/linus/90ceddcb495008ac8ba7a3d=
ce297841efcd7d584 ,
> > I remember pahole at that time added a non-SHF_ALLOC .BTF , now (1.20) =
.BTF becomes SHF_ALLOC.
>
> I don't think anything changed in 1.20 about how .BTF is added. pahole
> still uses the same llvm-objcopt and it doesn't add SHF_ALLOC. And I
> just double-checked that after running pahole -j .tmp_vmlinux.btf has
> non-allocatable .BTF section:
>
> $ llvm-readelf -S ~/tmp/pahole-vmlinux-output.o | grep BTF
>   [13] .BTF_ids          PROGBITS        ffffffff822b6804 14b6804
> 000510 00   A  0   0  1
>   [43] .BTF              PROGBITS        0000000000000000 18bc0e8c
> 4c8056 00      0   0  1
>
>
> > This is problematic if pahole does not have full-fledged binary manipul=
ation ability (objcopy,llvm-objcopy).
> >
> > In particular, there are two bugs:
> >
> > * pahole does not respect max-page-size (p_align of PT_LOAD). See the .=
text section, its
> >    sh_offset !=3D sh_addr (mod max-page-size)
> >
> >   Section Headers:
> >     [Nr] Name              Type            Address          Off    Size=
   ES Flg Lk Inf Al
> >     [ 0]                   NULL            0000000000000000 000000 0000=
00 00      0   0  0
> > -  [ 1] .text             PROGBITS        ffffffff81000000 200000 10039=
17 00  AX  0   0 4096
> > +  [ 1] .text             PROGBITS        ffffffff81000000 001000 e0169=
a 00  AX  0   0 4096
> >
> > * pahole does not rewrite p_offset/p_filesz of PT_LOAD segments.
> >    Because of the first bug, pahole -J rewritten object file generally =
has small offsets.
> >    If p_offset/p_filesz of PT_LOAD segments are not rewritten, the file=
 offset range of .symtab may be within
> >    a PT_LOAD range. llvm-objcopy --strip-all considers .symtab as part =
of the PT_LOAD and refuses --strip-all:
> >
> >    error: '.tmp_vmlinux.btf': string table '.strtab' cannot be removed =
because it is referenced by the symbol table '.symtab'
> >
> >    This is very rare, though.
> >
> >
> > So I suggest:
> >
> > * pahole -J: restore the previous non-SHF_ALLOC behavior. Don't rewrite=
 sh_offset of existing sections.
>
> so nothing changed (at least as of 1.20) about how pahole adds .BTF,
> so I'd like to understand why our observations differ
>
Here's one things we're seeing (note, we're using a kernel based on
4.15). Before we run pahole, we have this. Notice the offset of the
'.text' section:

  [ 0]                   NULL            0000000000000000 000000
000000 00      0   0  0
  [ 1] .text             PROGBITS        ffffffff81000000 200000
e0169a 00  AX  0   0 4096
  [ 2] .notes            NOTE            ffffffff81e0169c 100169c
000024 00   A  0   0  4
...
  [24] .BTF              PROGBITS        ffffffff825caf40 17caf40
000000 00  WA  0   0  1
  [25] .BTF_ids          PROGBITS        ffffffff825caf40 17caf40
0004c0 00   A  0   0  1

After running pahole, we get this:

  [ 0]                   NULL            0000000000000000 000000
000000 00      0   0  0
  [ 1] .text             PROGBITS        ffffffff81000000 001000
e0169a 00  AX  0   0 4096
  [ 2] .notes            NOTE            ffffffff81e0169c e0269c
000024 00   A  0   0  4
...
  [24] .BTF              PROGBITS        ffffffff825caf40 11ecf40
3c1ebe 00  WA  0   0  1
  [25] .BTF_ids          PROGBITS        ffffffff825caf40 15aedfe
0004c0 00   A  0   0  1

The offset of '.text' changed. This is because `elf_update` decides
what the offsets should be. Did the linker scripts change between 4.15
and top-of-tree to mark .BTF as non-allocatable?

-bw

> >    Place the new non-SHF_ALLOC .BTF section at the end.
> >    Then not rewriting PT_LOAD will be justified.
> > * Add a new option incorporating the current pahole -J + llvm-objcopy
>
> pahole is already using llvm-objcopy. Do you mean to add a mode where
> pahole will dump a separate ELF object file with just .BTF? Or
> something else?
