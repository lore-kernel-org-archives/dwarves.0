Return-Path: <SRS0=a5OZ=EB=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E64C4363A
	for <linux-dwarves@archiver.kernel.org>; Mon, 26 Oct 2020 21:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2991207F7
	for <linux-dwarves@archiver.kernel.org>; Mon, 26 Oct 2020 21:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZG4Ay+2r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389929AbgJZVjc (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 26 Oct 2020 17:39:32 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:40439 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389927AbgJZVjc (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 26 Oct 2020 17:39:32 -0400
Received: by mail-yb1-f193.google.com with SMTP id n142so8938454ybf.7
        for <dwarves@vger.kernel.org>; Mon, 26 Oct 2020 14:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dcv19toRGHeiER+deJyDT4frYg7L1dWhbWF6MolDmnY=;
        b=ZG4Ay+2rpMbSGrB1ywkZsT04Tz5U17OxMmPCkT8lT7dhh+U18I9Uy9F/Xk83AI+siG
         YTzynQU4NiCJOicECshccf/D5y6K2a8S3mDa/adoxKtGIVZdXWhPtonKXK7afWL9D/kE
         Loow1iRvh4YKVHfuFw0MV/rw5hUB2O9S532q+2gLC12Inqcb+L1seNYlwgX9kIVCpTVa
         4ZatiLNoFFI9et+1bjgxhnzwY0UOAnwXy9GU53jnW+ZArrMP/DtOp7NxY7IBDN9w6YII
         fp/5JheHC0uaosJDf/h6G2Vdq1P3GYC06XMtcO+YZLUhOIBiPJyFQktAnFY8FKsFe1sH
         VCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dcv19toRGHeiER+deJyDT4frYg7L1dWhbWF6MolDmnY=;
        b=KS4F6ZZiqmGCuTLVnByvrWOD6kHfdE+D+eYNuRuNjpU4iPCXs5qz/2bB7oMioY0GED
         XIAMUYkdVIx2mKl7MVuwMzWfx96rr3CxMSpBjVwpbyOmULmCaRWfPDgWM+ZYjbummXVZ
         rUv/f/tAAQOUfrdLZzYQcaCnumTdYXzT4j2ha4uJPEqQaUesgntC0FwrMhi8lwvZnXmD
         Zg6foB89+gk7KHNZW0ZZAqJUJHuYAwlgOqAno/+ws6Y77Ho8Uk6fzW6+YRhB3Ftff6gn
         2patiKcfZn64/SpIpKl+NS1R8jaO2Uy8umbwgag3KQiOgNNHiizzYcFd0MhWT68H7TBY
         u/7A==
X-Gm-Message-State: AOAM531XgMLSwVoGcOUlXy7MUeMbtgHvFlOzZFl80wuGSxb3mRrajs8W
        G1ohbd3QqWZ5L2DXDhiXow3XevsG1uXAqRDdH/XOWRBZZb0=
X-Google-Smtp-Source: ABdhPJyxnlmH8tQ3/K5FtW7uYPYARzsAJGcJwigTAykj+FZz6uv1ekAh/Qo3pGDdRV+UqGPFRhHpx7MT71gJfev+nc0=
X-Received: by 2002:a25:da4e:: with SMTP id n75mr25391664ybf.425.1603748370644;
 Mon, 26 Oct 2020 14:39:30 -0700 (PDT)
MIME-Version: 1.0
References: <20201026195830.GD2449445@kernel.org> <20201026203238.GH2726983@krava>
 <CA+khW7j5ZJzR-zdSWApod6wRWsusuOoJqJU5UP0QZD6CcJzkZQ@mail.gmail.com> <CA+khW7gsJWL5yBcAqQ2mK+1Bh-toFwVipxWX14_5+ZSBL_ckgA@mail.gmail.com>
In-Reply-To: <CA+khW7gsJWL5yBcAqQ2mK+1Bh-toFwVipxWX14_5+ZSBL_ckgA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 26 Oct 2020 14:39:19 -0700
Message-ID: <CAEf4BzaVhE59TJ+h7Oqsxr9VLHhoVupfBXzJBkaZQ+NPhFLVBg@mail.gmail.com>
Subject: Re: [PATCH dwarves] cmake: make libbpf's Linux UAPI headers
To:     Hao Luo <haoluo@google.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Mon, Oct 26, 2020 at 2:20 PM Hao Luo <haoluo@google.com> wrote:
>
> Oops, sorry about my terrible formatting.
>
>
> On Mon, Oct 26, 2020 at 2:17 PM Hao Luo <haoluo@google.com> wrote:
> >
> > On Mon, Oct 26, 2020 at 1:32 PM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Mon, Oct 26, 2020 at 04:58:30PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > Hi guys,
> > > >
> > > >       I just stumbled on this, investigating... This is with what is
> > > > in the tmp branch at
> > > > git://git.kernel.org/pub/scm/devel/pahole/pahole.git.
> > > >
> > > > error: found variable in CU '/home/acme/git/linux/security/selinux/hooks.c' that has void type
> > > > Encountered error while encoding BTF.
> > > >   LD      .tmp_vmlinux.kallsyms1
> > > >   KSYMS   .tmp_vmlinux.kallsyms1.S
> > > >   AS      .tmp_vmlinux.kallsyms1.S
> > > >   LD      .tmp_vmlinux.kallsyms2
> > > >   KSYMS   .tmp_vmlinux.kallsyms2.S
> > > >   AS      .tmp_vmlinux.kallsyms2.S
> > > >   LD      vmlinux
> > > >   BTFIDS  vmlinux
> > > > FAILED: load BTF from vmlinux: Unknown error -2make[1]: *** [/home/acme/git/linux/Makefile:1164: vmlinux] Error 255
> > > > make[1]: Leaving directory '/home/acme/git/build/v5.10.0-rc1+'
> > > > make: *** [Makefile:185: __sub-make] Error 2
> > >
> > > yep, I see the same and when I use --btf_encode_force,
> > > it shows more of them:
> > >
> > > error: found variable in CU 'arch/x86/kernel/cpu/mce/core.c' that has void type
> > > error: found variable in CU 'security/selinux/hooks.c' that has void type
> > > error: found variable in CU 'security/selinux/hooks.c' that has void type
> > > error: found variable in CU 'security/selinux/hooks.c' that has void type
> > > error: found variable in CU 'security/selinux/hooks.c' that has void type
> > > error: found variable in CU 'security/selinux/hooks.c' that has void type
> > > error: found variable in CU 'security/selinux/hooks.c' that has void type
> > > error: found variable in CU 'drivers/platform/x86/intel_pmc_core.c' that has void type
> > >
> > > I have no idea how variables are encoded in dwarf,
> > > but I wonder it's another gcc bug ;-)
> > >
> > > jirka
> > >
> >
> > Still looking. But I found if I move
> >
> > c815d266 (Hao Luo                  2020-08-24 17:45:23 -0700 444)
> >          if (var->ip.tag.type == 0) {
> > 2e719cca (Andrii Nakryiko          2020-10-08 16:39:57 -0700 445)
> >                  fprintf(stderr, "error: found variable in CU '%s'
> > that has void type\n",
> > 2e719cca (Andrii Nakryiko          2020-10-08 16:39:57 -0700 446)
> >                          cu->name);
> > f3d9054b (Hao Luo                  2020-07-08 13:44:10 -0700 447)
> >                  if (force)
> > f3d9054b (Hao Luo                  2020-07-08 13:44:10 -0700 448)
> >                          continue;
> > f3d9054b (Hao Luo                  2020-07-08 13:44:10 -0700 449)
> >                  err = -1;
> > f3d9054b (Hao Luo                  2020-07-08 13:44:10 -0700 450)
> >                  break;
> > f3d9054b (Hao Luo                  2020-07-08 13:44:10 -0700 451)
> >          }
> > f3d9054b (Hao Luo                  2020-07-08 13:44:10 -0700 452)
> >
> > after
> >
> > 2e719cca (Andrii Nakryiko          2020-10-08 16:39:57 -0700 453)
> >          type = var->ip.tag.type + type_id_off;
> > 2e719cca (Andrii Nakryiko          2020-10-08 16:39:57 -0700 454)
> >          linkage = var->external ? BTF_VAR_GLOBAL_ALLOCATED :
> > BTF_VAR_STATIC;
> > 2e719cca (Andrii Nakryiko          2020-10-08 16:39:57 -0700 455)
> >          if (!percpu_var_exists(addr, &size, &name))
> > 2e719cca (Andrii Nakryiko          2020-10-08 16:39:57 -0700 456)
> >                  continue; /* not a per-CPU variable */
> >
> > the error is gone. I think we should check percpu_var_exists() before
> > checking var->ip.tag.type.

sounds like a plan, can you please send a patch? Thanks!

> >
> > Hao
