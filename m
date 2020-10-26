Return-Path: <SRS0=a5OZ=EB=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D21C56202
	for <linux-dwarves@archiver.kernel.org>; Mon, 26 Oct 2020 21:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 375502084C
	for <linux-dwarves@archiver.kernel.org>; Mon, 26 Oct 2020 21:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DX+zHgv1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390155AbgJZVmN (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 26 Oct 2020 17:42:13 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:40743 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390119AbgJZVmM (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 26 Oct 2020 17:42:12 -0400
Received: by mail-yb1-f195.google.com with SMTP id n142so8943778ybf.7
        for <dwarves@vger.kernel.org>; Mon, 26 Oct 2020 14:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=09P9WutfgZrcBSGpyK8Q98YraU3ltSTT+NGPz0bESc0=;
        b=DX+zHgv1Wgi7jeJ09Fi4rkhsmai4D9cQ2jr8LTGHadFw79ir2Irb30EgIwYKmpvrjs
         1kiSZGiReiluYmrBouOwZzuCQAq2Gc+TNGSXRU++uzzHs0l4OWassnmF9Ef92/q5Ngji
         cVNWMWu5sEfLTOZkphtNwft9zdmOkFd/EwCBbEZIPoP7R1U3KHwjVwSLq1lVtnB4CHol
         +be7AU4xLh4VBOCzOd6evaj0rIocPUJB5MTbuZ3HFSs4LcuctgLhudKHD4Qvu4NhxH52
         qGrix8hVyasijU+95VY7UYp/jsVnJdxIzLv+G3T3daKH821tsqQDIPBBjyBYS8ORoAxM
         KLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=09P9WutfgZrcBSGpyK8Q98YraU3ltSTT+NGPz0bESc0=;
        b=Pan/r/4XBevduCCTfDlxO3nQGLilpgl3hL/q6YvWl47bzil9LmSAFeh4mYQ50j+Cxm
         2NlQj7F4wduNRpGeb2efm4NGgXj6jHwRZ/YXrbEVreCSCrvIaKFDZFVBEUXix1NOpMaZ
         opAkBCjBO6rtUKaTqUyRnFw4Od/L8cOgmzhe7inPdT8r9gS+S54s0Rqz2OP/Fm/euClm
         G2lOra3g0xjQZFO8SWTITYVkcUNL7sMhTN8JsmP5cKXqrm+dA17pFw1FoI5HyaFJfXlt
         S6I/TQIp5SHgGZbuocNauG9S7NCHE/jf1xMm6mF/iieRKk6jxy+o6JPTWlyaExdNX0tg
         UO/Q==
X-Gm-Message-State: AOAM530R4vusFU0g4MgXx3OK0mVEw4s8cQ4PfxPjEwCZk6d5ttm3L2ap
        CPYS+7HmbZ/o2DphaGmGCKATjxYSUUO1fD3f4X0=
X-Google-Smtp-Source: ABdhPJzb+T/S7W564VqthScffxNoyDx18FETvXUHuBwV1OQGXuNUZDjqGVvUu2m282sh12H4xOms49n3qa89IV+g2o8=
X-Received: by 2002:a25:bdc7:: with SMTP id g7mr27560356ybk.260.1603748531321;
 Mon, 26 Oct 2020 14:42:11 -0700 (PDT)
MIME-Version: 1.0
References: <20201026201006.GE2449445@kernel.org> <20201026202239.GF2449445@kernel.org>
In-Reply-To: <20201026202239.GF2449445@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 26 Oct 2020 14:42:00 -0700
Message-ID: <CAEf4BzYvSNHbdAm=9SNsuOM1wgQtg5v9rz24PjyGWr-8QOkbjQ@mail.gmail.com>
Subject: Re: btf_encoder: error: found variable in CU that has void type
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, Hao Luo <haoluo@google.com>,
        dwarves@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Mon, Oct 26, 2020 at 1:22 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Mon, Oct 26, 2020 at 05:10:06PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Now with a correct subject :-)
> >
> > Em Mon, Oct 26, 2020 at 04:58:30PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Hi guys,
> > >
> > >     I just stumbled on this, investigating... This is with what is
> > > in the tmp branch at
> > > git://git.kernel.org/pub/scm/devel/pahole/pahole.git.
> > >
> > > error: found variable in CU '/home/acme/git/linux/security/selinux/hooks.c' that has void type
> > > Encountered error while encoding BTF.
> > >   LD      .tmp_vmlinux.kallsyms1
> > >   KSYMS   .tmp_vmlinux.kallsyms1.S
> > >   AS      .tmp_vmlinux.kallsyms1.S
> > >   LD      .tmp_vmlinux.kallsyms2
> > >   KSYMS   .tmp_vmlinux.kallsyms2.S
> > >   AS      .tmp_vmlinux.kallsyms2.S
> > >   LD      vmlinux
> > >   BTFIDS  vmlinux
> > > FAILED: load BTF from vmlinux: Unknown error -2make[1]: *** [/home/acme/git/linux/Makefile:1164: vmlinux] Error 255
> > > make[1]: Leaving directory '/home/acme/git/build/v5.10.0-rc1+'
> > > make: *** [Makefile:185: __sub-make] Error 2
> >
> > It is something recent:
> >
> > c815d26689313d8d7 (Hao Luo                  2020-08-24 17:45:23 -0700 440)              if (var->ip.tag.type == 0) {
> > 2e719cca667212840 (Andrii Nakryiko          2020-10-08 16:39:57 -0700 441)                      fprintf(stderr, "error: found variable in CU '%s' that has void type\n",
> > 2e719cca667212840 (Andrii Nakryiko          2020-10-08 16:39:57 -0700 442)                              cu->name);
> > f3d9054ba8ff1df0f (Hao Luo                  2020-07-08 13:44:10 -0700 443)                      if (force)
> > f3d9054ba8ff1df0f (Hao Luo                  2020-07-08 13:44:10 -0700 444)                              continue;
> > f3d9054ba8ff1df0f (Hao Luo                  2020-07-08 13:44:10 -0700 445)                      err = -1;
> > f3d9054ba8ff1df0f (Hao Luo                  2020-07-08 13:44:10 -0700 446)                      break;
>
> Printing the variable name and address gives:
>
>   LD      .tmp_vmlinux.btf
>   BTF     .btf.vmlinux.bin.o
> error: found variable "(null)" (addr: 0xffffffff82f4e260) in CU '/home/acme/git/linux/security/selinux/hooks.c' that has void type
> Encountered error while encoding BTF.
>
> Unsure if this is related:
>
> [root@five ~]# gcc --version | head -1
> gcc (GCC) 10.2.1 20200723 (Red Hat 10.2.1-1)
> [root@five ~]#
>
> [acme@five linux]$ readelf -sw ../build/v5.9.0+/vmlinux | grep ffffffff82f4e260
> readelf: ../build/v5.9.0+/vmlinux: Error: LEB value too large
> readelf: ../build/v5.9.0+/vmlinux: Error: LEB value too large
> readelf: ../build/v5.9.0+/vmlinux: Error: LEB value too large
> readelf: ../build/v5.9.0+/vmlinux: Error: LEB value too large
> readelf: ../build/v5.9.0+/vmlinux: Error: LEB value too large
> readelf: ../build/v5.9.0+/vmlinux: Error: LEB value too large
> readelf: ../build/v5.9.0+/vmlinux: Error: LEB value too large
> readelf: ../build/v5.9.0+/vmlinux: Error: LEB value too large
> readelf: ../build/v5.9.0+/vmlinux: Error: LEB value too large
> readelf: ../build/v5.9.0+/vmlinux: Error: LEB value too large
> readelf: ../build/v5.9.0+/vmlinux: Error: LEB value too large
> readelf: ../build/v5.9.0+/vmlinux: Error: LEB value too large
>
> <SNIP lots more such lines>
>

Don't know what this is, but what Hao proposed (to check everything
only after we make sure that the variable has a proper per-CPU symbol
in ELF) would eliminate all that, so I think we should do just that.

But I'm surprised I didn't see any of those issues in my kernel
configurations and environment (though I use GCC 8, still, so that
might explain).


> - Arnaldo
