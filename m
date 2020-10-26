Return-Path: <SRS0=a5OZ=EB=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0316C4363A
	for <linux-dwarves@archiver.kernel.org>; Mon, 26 Oct 2020 21:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65F2720773
	for <linux-dwarves@archiver.kernel.org>; Mon, 26 Oct 2020 21:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eeBpD4hP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731236AbgJZVRy (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 26 Oct 2020 17:17:54 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:34766 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730452AbgJZVRx (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 26 Oct 2020 17:17:53 -0400
Received: by mail-ej1-f66.google.com with SMTP id gs25so15912867ejb.1
        for <dwarves@vger.kernel.org>; Mon, 26 Oct 2020 14:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z+VT5Bt0ruFmuJ7JG+GW+ptflUdEU+3DngaQW10vtEQ=;
        b=eeBpD4hPkQgaad7/RVXoRC2N6QTumgGiTasTo8cASwrqqqqZaBMwd5K9YSQeQV3Mjo
         NFo3rLrh+vrp6/DJN0iFmv0ZeYBf31Azrw6vlpQMSbu62N9sCPjTP8uPr5opC+vYAJI9
         aM1uQou3F5Mdkr3CgYGAjZWvx6WAIJf2Xlx5wj95KJjc7Ic64BeycwqguVeUeoMy8XAx
         snA23TIIq6v4u0goVlSLAPfkVla1v6f+RXQ2VWECeMzaf+jIp3Y7LWCrHWVJQjuZFJ+Y
         nGL8EIw2YT/W3npeIDcIKBYTAyi2oEyu9Vh3B5awvJ2zHbBSFdcrEu8A3i9emwtcEJNQ
         7dRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z+VT5Bt0ruFmuJ7JG+GW+ptflUdEU+3DngaQW10vtEQ=;
        b=QNcegkC44enLgRT/meXOf/GSWYSJ04r+8+XbSY+TJCOf/tOm15ENbnjgSbrznaATGV
         Ti7V7GuRLMKIkKjbiMQUDLpMgpZAS5u8EUFdfpxlSi5uwXtWpc0oVlfTKHzwIzqLqVBY
         hDOtQO1tzURYx4kUaSVb1bnqc4BVDkdzk5TNxw2SiUhpF9eE1tq6foenrZn16Vyn8vwH
         aMfMN37VtMORCNsriCoYz8JhESvTimkvtuk3/3zzuNqEqYHEgyYkFwTtnM/CGg1rfgSx
         VGubmxXwomsiNdjVZCoLWl5LC1QB548U8x+e6ci9iliqG4xDq1HMi/iu3rEReGA2xMyp
         I5Nw==
X-Gm-Message-State: AOAM530g7HO87YhA1RJU71Naj/iJ/CHKxJCZSqCnSjGil2PPBgoVdYME
        BCZjzhES8f864O42EmMmKpKo8KQojjQPjQusrydnZA==
X-Google-Smtp-Source: ABdhPJzbKYbL89nOrZzE40r+Di/zxY1+/TcE0Kou9Wl8XMn8Hn/6JIC619j0CrizW4hKf6MVdJDBDM63QjHooHVE7RU=
X-Received: by 2002:a17:907:40c0:: with SMTP id nu24mr18168855ejb.359.1603747070841;
 Mon, 26 Oct 2020 14:17:50 -0700 (PDT)
MIME-Version: 1.0
References: <20201026195830.GD2449445@kernel.org> <20201026203238.GH2726983@krava>
In-Reply-To: <20201026203238.GH2726983@krava>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 26 Oct 2020 14:17:39 -0700
Message-ID: <CA+khW7j5ZJzR-zdSWApod6wRWsusuOoJqJU5UP0QZD6CcJzkZQ@mail.gmail.com>
Subject: Re: [PATCH dwarves] cmake: make libbpf's Linux UAPI headers
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Mon, Oct 26, 2020 at 1:32 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Mon, Oct 26, 2020 at 04:58:30PM -0300, Arnaldo Carvalho de Melo wrote:
> > Hi guys,
> >
> >       I just stumbled on this, investigating... This is with what is
> > in the tmp branch at
> > git://git.kernel.org/pub/scm/devel/pahole/pahole.git.
> >
> > error: found variable in CU '/home/acme/git/linux/security/selinux/hooks.c' that has void type
> > Encountered error while encoding BTF.
> >   LD      .tmp_vmlinux.kallsyms1
> >   KSYMS   .tmp_vmlinux.kallsyms1.S
> >   AS      .tmp_vmlinux.kallsyms1.S
> >   LD      .tmp_vmlinux.kallsyms2
> >   KSYMS   .tmp_vmlinux.kallsyms2.S
> >   AS      .tmp_vmlinux.kallsyms2.S
> >   LD      vmlinux
> >   BTFIDS  vmlinux
> > FAILED: load BTF from vmlinux: Unknown error -2make[1]: *** [/home/acme/git/linux/Makefile:1164: vmlinux] Error 255
> > make[1]: Leaving directory '/home/acme/git/build/v5.10.0-rc1+'
> > make: *** [Makefile:185: __sub-make] Error 2
>
> yep, I see the same and when I use --btf_encode_force,
> it shows more of them:
>
> error: found variable in CU 'arch/x86/kernel/cpu/mce/core.c' that has void type
> error: found variable in CU 'security/selinux/hooks.c' that has void type
> error: found variable in CU 'security/selinux/hooks.c' that has void type
> error: found variable in CU 'security/selinux/hooks.c' that has void type
> error: found variable in CU 'security/selinux/hooks.c' that has void type
> error: found variable in CU 'security/selinux/hooks.c' that has void type
> error: found variable in CU 'security/selinux/hooks.c' that has void type
> error: found variable in CU 'drivers/platform/x86/intel_pmc_core.c' that has void type
>
> I have no idea how variables are encoded in dwarf,
> but I wonder it's another gcc bug ;-)
>
> jirka
>

Still looking. But I found if I move

c815d266 (Hao Luo                  2020-08-24 17:45:23 -0700 444)
         if (var->ip.tag.type == 0) {
2e719cca (Andrii Nakryiko          2020-10-08 16:39:57 -0700 445)
                 fprintf(stderr, "error: found variable in CU '%s'
that has void type\n",
2e719cca (Andrii Nakryiko          2020-10-08 16:39:57 -0700 446)
                         cu->name);
f3d9054b (Hao Luo                  2020-07-08 13:44:10 -0700 447)
                 if (force)
f3d9054b (Hao Luo                  2020-07-08 13:44:10 -0700 448)
                         continue;
f3d9054b (Hao Luo                  2020-07-08 13:44:10 -0700 449)
                 err = -1;
f3d9054b (Hao Luo                  2020-07-08 13:44:10 -0700 450)
                 break;
f3d9054b (Hao Luo                  2020-07-08 13:44:10 -0700 451)
         }
f3d9054b (Hao Luo                  2020-07-08 13:44:10 -0700 452)

after

2e719cca (Andrii Nakryiko          2020-10-08 16:39:57 -0700 453)
         type = var->ip.tag.type + type_id_off;
2e719cca (Andrii Nakryiko          2020-10-08 16:39:57 -0700 454)
         linkage = var->external ? BTF_VAR_GLOBAL_ALLOCATED :
BTF_VAR_STATIC;
2e719cca (Andrii Nakryiko          2020-10-08 16:39:57 -0700 455)
         if (!percpu_var_exists(addr, &size, &name))
2e719cca (Andrii Nakryiko          2020-10-08 16:39:57 -0700 456)
                 continue; /* not a per-CPU variable */

the error is gone. I think we should check percpu_var_exists() before
checking var->ip.tag.type.

Hao
