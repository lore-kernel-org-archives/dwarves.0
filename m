Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40328C433C1
	for <linux-dwarves@archiver.kernel.org>; Fri, 19 Mar 2021 22:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FAE061974
	for <linux-dwarves@archiver.kernel.org>; Fri, 19 Mar 2021 22:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhCSWom (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 19 Mar 2021 18:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbhCSWod (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Fri, 19 Mar 2021 18:44:33 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7DEC061760
        for <dwarves@vger.kernel.org>; Fri, 19 Mar 2021 15:44:32 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id p193so7863210yba.4
        for <dwarves@vger.kernel.org>; Fri, 19 Mar 2021 15:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oBs9sLjk3nMvYe7aWxCbhfCcPF1pb5qfVnQy9H0+quA=;
        b=Ma8vh0e5QrA4LlT5rBWZQwGA9AmrEzoki9pHV3n4dnzOH9xtICULoUUiHqBeChRCr7
         Hpy0FZhZ+LkY9Dg0HGEnKVnDX/cMeWwJtrmckwY1dIR1H9vINWfZW0LSZyOlaq51FCaw
         jXXawkV3q8y93ofguWjahGvfnYrkXelmfzo5q/D0YGzjvjj8DU3IIGnWG9lh3CuMiG+d
         Gjd0KiK7+Z5y2NbB1tjLWJggehk3OWnZt7oRyIDbvfFzpu3JdRIu5QNzcUuX8eV+GBTl
         lW9PNhv1V5pU4LipDI9YX9nF5rBRwVZ/m0oD1Q0tFtcYu/c6Lgr3Ko8Iszw9ky8XWm8D
         CHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oBs9sLjk3nMvYe7aWxCbhfCcPF1pb5qfVnQy9H0+quA=;
        b=BB2eF7PI+ufcScRAqxh6KR1tjBYmBI4pEf7G5NLn5aOk0lV5CMxdEbKc2QxmgjVECF
         oC2hFz2oD0icp/ibznQg1gb6S4d7p07OBvnVLaj6ZQqrTTfijILQmm18G7/YnMVx5mHH
         RQCzezRyCok5nQKbBTuIvv+QvRebG16Mcx6zQpd63XFgXW0Is3JhWc7dxx4+KvkipFVh
         gdAwyiXKlhXvoRml2Nn8bdoFFu8Yqmdcjz0nRuXSxk34OUaLuv6fwugjxkJMlUDNoCcJ
         Zaw8rDVHs9ABmpfYZMOOyGZUu0c5IaLWtz/fCMKysGYZnlaDfQApomBoDjAq4M2npEb+
         lJBw==
X-Gm-Message-State: AOAM531WyJ5MebLJJhMS5vxmUokbG3pTDEUQDZC82R11vP5D793h4HB0
        XfEaAGpf9/gJdAULFiLo/i5Av1AiiQAtsUrRZ8AnJ4hQ/de99w==
X-Google-Smtp-Source: ABdhPJxY6R9vrHxB75/XLZWhE7F0TVQ4JkgeMywiGDVFxV6sU5Ezom7W6svhghCmBAfYUyU45FRq5vO/x4BZA4qo9q4=
X-Received: by 2002:a25:40d8:: with SMTP id n207mr9298581yba.459.1616193872129;
 Fri, 19 Mar 2021 15:44:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210317232657.mdnsuoqx6nbddjgt@google.com>
In-Reply-To: <20210317232657.mdnsuoqx6nbddjgt@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 19 Mar 2021 15:44:21 -0700
Message-ID: <CAEf4BzZgNPAv+AbVjU+rS89WbmJGuEyk9QwQfyei438dNt7EBQ@mail.gmail.com>
Subject: Re: pahole -J usage in kernel scripts/link-vmlinux.sh
To:     Fangrui Song <maskray@google.com>
Cc:     dwarves@vger.kernel.org, Bill Wendling <morbo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Wed, Mar 17, 2021 at 4:28 PM Fangrui Song <maskray@google.com> wrote:
>
> Hi BTF folks,
>
> I have discovered some problems with pahole -J.
> Its usage in kernel scripts/link-vmlinux.sh is like (make LLVM=3D1 bzImag=
e):
>
> ld.lld -m elf_x86_64 --emit-relocs --discard-none -z max-page-size=3D0x20=
0000 --build-id=3Dsha1 --orphan-handling=3Dwarn -o .tmp_vmlinux.btf -T ./ar=
ch/x86/kernel/vmlinux.lds --whole-archive arch/x86/kernel/head_64.o arch/x8=
6/kernel/head64.o arch/x86/kernel/ebda.o arch/x86/kernel/platform-quirks.o =
init/built-in.a usr/built-in.a arch/x86/built-in.a kernel/built-in.a certs/=
built-in.a mm/built-in.a fs/built-in.a ipc/built-in.a security/built-in.a c=
rypto/built-in.a block/built-in.a lib/built-in.a arch/x86/lib/built-in.a li=
b/lib.a arch/x86/lib/lib.a drivers/built-in.a sound/built-in.a net/built-in=
.a virt/built-in.a arch/x86/pci/built-in.a arch/x86/power/built-in.a arch/x=
86/video/built-in.a --no-whole-archive --start-group --end-group
> pahole -J .tmp_vmlinux.btf
> llvm-objcopy --only-section=3D.BTF --set-section-flags .BTF=3Dalloc,reado=
nly --strip-all .tmp_vmlinux.btf .btf.vmlinux.bin.o
>
> pahole -J adds .BTF and rewrites .tmp_vmlinux.btf, then llvm-objcopy prod=
uces .btf.vmlinux.bin.o of just one section.
> Why doesn't pahole provide a command generating an object file with just =
the .BTF section?
>

We just recently discussed adding this. So the reason is that
historically pahole never had this feature and no one bothered to add
it.

>
>
> When I contributed https://git.kernel.org/linus/90ceddcb495008ac8ba7a3dce=
297841efcd7d584 ,
> I remember pahole at that time added a non-SHF_ALLOC .BTF , now (1.20) .B=
TF becomes SHF_ALLOC.

I don't think anything changed in 1.20 about how .BTF is added. pahole
still uses the same llvm-objcopt and it doesn't add SHF_ALLOC. And I
just double-checked that after running pahole -j .tmp_vmlinux.btf has
non-allocatable .BTF section:

$ llvm-readelf -S ~/tmp/pahole-vmlinux-output.o | grep BTF
  [13] .BTF_ids          PROGBITS        ffffffff822b6804 14b6804
000510 00   A  0   0  1
  [43] .BTF              PROGBITS        0000000000000000 18bc0e8c
4c8056 00      0   0  1


> This is problematic if pahole does not have full-fledged binary manipulat=
ion ability (objcopy,llvm-objcopy).
>
> In particular, there are two bugs:
>
> * pahole does not respect max-page-size (p_align of PT_LOAD). See the .te=
xt section, its
>    sh_offset !=3D sh_addr (mod max-page-size)
>
>   Section Headers:
>     [Nr] Name              Type            Address          Off    Size  =
 ES Flg Lk Inf Al
>     [ 0]                   NULL            0000000000000000 000000 000000=
 00      0   0  0
> -  [ 1] .text             PROGBITS        ffffffff81000000 200000 1003917=
 00  AX  0   0 4096
> +  [ 1] .text             PROGBITS        ffffffff81000000 001000 e0169a =
00  AX  0   0 4096
>
> * pahole does not rewrite p_offset/p_filesz of PT_LOAD segments.
>    Because of the first bug, pahole -J rewritten object file generally ha=
s small offsets.
>    If p_offset/p_filesz of PT_LOAD segments are not rewritten, the file o=
ffset range of .symtab may be within
>    a PT_LOAD range. llvm-objcopy --strip-all considers .symtab as part of=
 the PT_LOAD and refuses --strip-all:
>
>    error: '.tmp_vmlinux.btf': string table '.strtab' cannot be removed be=
cause it is referenced by the symbol table '.symtab'
>
>    This is very rare, though.
>
>
> So I suggest:
>
> * pahole -J: restore the previous non-SHF_ALLOC behavior. Don't rewrite s=
h_offset of existing sections.

so nothing changed (at least as of 1.20) about how pahole adds .BTF,
so I'd like to understand why our observations differ

>    Place the new non-SHF_ALLOC .BTF section at the end.
>    Then not rewriting PT_LOAD will be justified.
> * Add a new option incorporating the current pahole -J + llvm-objcopy

pahole is already using llvm-objcopy. Do you mean to add a mode where
pahole will dump a separate ELF object file with just .BTF? Or
something else?
