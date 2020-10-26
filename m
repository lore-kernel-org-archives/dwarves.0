Return-Path: <SRS0=a5OZ=EB=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3923DC4363A
	for <linux-dwarves@archiver.kernel.org>; Mon, 26 Oct 2020 21:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE97120795
	for <linux-dwarves@archiver.kernel.org>; Mon, 26 Oct 2020 21:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pkUi8qOE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731351AbgJZVUF (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 26 Oct 2020 17:20:05 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43626 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731346AbgJZVUF (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 26 Oct 2020 17:20:05 -0400
Received: by mail-io1-f67.google.com with SMTP id h21so12244862iob.10
        for <dwarves@vger.kernel.org>; Mon, 26 Oct 2020 14:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nlIK9oEjHgKwa42k31I5AY9aTfLyujiKghRGR1I1QOI=;
        b=pkUi8qOEA9dLUyGIc1zxzjdqispGDD8RreK9I40wSs1UyhLk8ItycHwyOaAFOsN8Ss
         FpwooYk3TDtbruCYHU0Ck8cmjkXdxHR/eE7sFsrM/ohqb5oNkdcFDiu5Dj0IrzwDJETC
         CBv0hrfoktux6GfZTrAloZQWdXSOI+LDS8cK3b8qNooK7HtCMB9JzS4GlUjJ8EeG/bpD
         RJuHQMIMEmgniAOhI+P1vi8g7ZSkiW1d8cwuan0A9t4tN4wYpMXlNcBQdz2HGyR2WzFn
         Y/yX+RLJMmoI8oLJuEMjjMYXH1Mn5VzXxONACyYXS5DAa3NuAdYSUie1S3w/zDf8xAHU
         Ga7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nlIK9oEjHgKwa42k31I5AY9aTfLyujiKghRGR1I1QOI=;
        b=jFyjWxiqJ6pH+U+NBalz5Q7+bZx3qr05zWcokb8lzaD94YSZD9oFY8xAn1PKlPpjN6
         yqXm5ySBAz/FH7NxAm6elqLRUy+O/31T7zYEy320m9rDFunQAM/d2MrZ572AvWUkfmVL
         WC96100u5En9P8UCcuNjDOl5k+pSTsMSByfoX4UV+Fw0Qa1WRj9Q3oKYFQnGrisUBgBC
         AStiSdYFbTmi0L23eQIlB9esn4OS2Kasa6VVFji+CIVCKNpAxX+sW0sOILwaQAMEwp1/
         51MpOZT0V+FtvIAShKpsmD46H7eSy8UyMsALrMmQnH/z1N4ozFOb5kyy00TfMAsc8prn
         Idiw==
X-Gm-Message-State: AOAM532QC0vyxmW9/JtgEl8YlqBikPFAMBIg6IlGMYZN8hIedMB/R+K6
        RxOzKBzcD0NhNYDt9eWQcCcvmhrSzJC/bIf8F2yDOA==
X-Google-Smtp-Source: ABdhPJwGisUZNKEuzDBjmbL9plOhR79XLYOatvH5T01OmpaqK3zi+DpZ3d9pJW9nFtD9bseGpc2NosEBjseSZJV5HHI=
X-Received: by 2002:a05:6602:6ce:: with SMTP id n14mr12194631iox.34.1603747202771;
 Mon, 26 Oct 2020 14:20:02 -0700 (PDT)
MIME-Version: 1.0
References: <20201026195830.GD2449445@kernel.org> <20201026203238.GH2726983@krava>
 <CA+khW7j5ZJzR-zdSWApod6wRWsusuOoJqJU5UP0QZD6CcJzkZQ@mail.gmail.com>
In-Reply-To: <CA+khW7j5ZJzR-zdSWApod6wRWsusuOoJqJU5UP0QZD6CcJzkZQ@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 26 Oct 2020 14:19:51 -0700
Message-ID: <CA+khW7gsJWL5yBcAqQ2mK+1Bh-toFwVipxWX14_5+ZSBL_ckgA@mail.gmail.com>
Subject: Re: [PATCH dwarves] cmake: make libbpf's Linux UAPI headers
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Oops, sorry about my terrible formatting.


On Mon, Oct 26, 2020 at 2:17 PM Hao Luo <haoluo@google.com> wrote:
>
> On Mon, Oct 26, 2020 at 1:32 PM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Mon, Oct 26, 2020 at 04:58:30PM -0300, Arnaldo Carvalho de Melo wrote:
> > > Hi guys,
> > >
> > >       I just stumbled on this, investigating... This is with what is
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
> > yep, I see the same and when I use --btf_encode_force,
> > it shows more of them:
> >
> > error: found variable in CU 'arch/x86/kernel/cpu/mce/core.c' that has void type
> > error: found variable in CU 'security/selinux/hooks.c' that has void type
> > error: found variable in CU 'security/selinux/hooks.c' that has void type
> > error: found variable in CU 'security/selinux/hooks.c' that has void type
> > error: found variable in CU 'security/selinux/hooks.c' that has void type
> > error: found variable in CU 'security/selinux/hooks.c' that has void type
> > error: found variable in CU 'security/selinux/hooks.c' that has void type
> > error: found variable in CU 'drivers/platform/x86/intel_pmc_core.c' that has void type
> >
> > I have no idea how variables are encoded in dwarf,
> > but I wonder it's another gcc bug ;-)
> >
> > jirka
> >
>
> Still looking. But I found if I move
>
> c815d266 (Hao Luo                  2020-08-24 17:45:23 -0700 444)
>          if (var->ip.tag.type == 0) {
> 2e719cca (Andrii Nakryiko          2020-10-08 16:39:57 -0700 445)
>                  fprintf(stderr, "error: found variable in CU '%s'
> that has void type\n",
> 2e719cca (Andrii Nakryiko          2020-10-08 16:39:57 -0700 446)
>                          cu->name);
> f3d9054b (Hao Luo                  2020-07-08 13:44:10 -0700 447)
>                  if (force)
> f3d9054b (Hao Luo                  2020-07-08 13:44:10 -0700 448)
>                          continue;
> f3d9054b (Hao Luo                  2020-07-08 13:44:10 -0700 449)
>                  err = -1;
> f3d9054b (Hao Luo                  2020-07-08 13:44:10 -0700 450)
>                  break;
> f3d9054b (Hao Luo                  2020-07-08 13:44:10 -0700 451)
>          }
> f3d9054b (Hao Luo                  2020-07-08 13:44:10 -0700 452)
>
> after
>
> 2e719cca (Andrii Nakryiko          2020-10-08 16:39:57 -0700 453)
>          type = var->ip.tag.type + type_id_off;
> 2e719cca (Andrii Nakryiko          2020-10-08 16:39:57 -0700 454)
>          linkage = var->external ? BTF_VAR_GLOBAL_ALLOCATED :
> BTF_VAR_STATIC;
> 2e719cca (Andrii Nakryiko          2020-10-08 16:39:57 -0700 455)
>          if (!percpu_var_exists(addr, &size, &name))
> 2e719cca (Andrii Nakryiko          2020-10-08 16:39:57 -0700 456)
>                  continue; /* not a per-CPU variable */
>
> the error is gone. I think we should check percpu_var_exists() before
> checking var->ip.tag.type.
>
> Hao
