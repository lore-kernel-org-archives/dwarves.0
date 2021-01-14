Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE65C433E0
	for <linux-dwarves@archiver.kernel.org>; Thu, 14 Jan 2021 07:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CBE6233FD
	for <linux-dwarves@archiver.kernel.org>; Thu, 14 Jan 2021 07:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbhANHvP (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 14 Jan 2021 02:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbhANHvP (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 14 Jan 2021 02:51:15 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45A4C061786;
        Wed, 13 Jan 2021 23:50:34 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id w18so9502198iot.0;
        Wed, 13 Jan 2021 23:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=OAZBb5jIsKWPgZqOruS9t17QnTyfUBBMz/oAs44bveY=;
        b=Rg8lLI93ZTq0RaXIz22ZDfOI9CgwLi6veBnmVHve8czLSOC2bdjrcHISextzHTSt3I
         5IU1ixePJ59crSdCveF3DEQt7iEwcsemZe2bPbs1HTYjxtwvmn28JQyBUJINvxaZQTom
         OV2EUUiDDEJoUCbhDZB6K/qMbbiOJYmY7629CYw7j7DOhI7cE9ZpCUtOWLcnIf0ahIyr
         EUaaAxQ1Owpm0MGXzL9JyFcasK6RHjkOB+umbxXHQVR/tZwXP+mXVXKQAeo7SEV9Mkfg
         1nBd8OBv34QY6MDMpU0UAbyzjMyuIVNtMC2fvpMREzyeQtwQz+S12EzxeETHZCSUgW4n
         sl2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=OAZBb5jIsKWPgZqOruS9t17QnTyfUBBMz/oAs44bveY=;
        b=TplPn3FCMO01A5a7QyJMMw65Xc7BCJzzxPgqYeBNGz3zWpyMdJ3+r6TvI6ADniQxc9
         ngVKymhIiYsyOVqzSVQPPl2zKSCCmhIbU19b9rmXsJtdIoRYeEbPQ8uy1Xhz2t/pYQEm
         GvMheVkOjlvYNqkzKhfp/qofxWqsG24SczOevUjxshcGb5qB9W6qT2xXpGqoC+vtopkm
         kppJY6TYb1n4++ovrjMAE/2w70aKNNo7VicwHDLYvTzre01ceUlcw4d//kyWql2yciIU
         wm1tWwJ5s9s3GnbJiBGGyey8ghvXJeyFEg17GCGOFNhPQSHQagvoGv+Pv7tKJat5bThp
         Q2OA==
X-Gm-Message-State: AOAM53006ABB8NbZzyhVigfI8ZPK2LZ3wlqDLRAiO8oNvVZUEV0ikDPu
        //u1QxKFTQUG98sENiS2yQHEK2emPLDUzAyGd60=
X-Google-Smtp-Source: ABdhPJw4YJs51n1WUVtRQltsinBZ9HxfLAL2zbzpQEYvGz2yRFo2/5bb8dFPTFOke+3v106ZZJ3HTMU9qQrQBzqPXaw=
X-Received: by 2002:a5e:d70e:: with SMTP id v14mr4406660iom.75.1610610634236;
 Wed, 13 Jan 2021 23:50:34 -0800 (PST)
MIME-Version: 1.0
References: <20210112184004.1302879-1-jolsa@kernel.org> <f3790a7d-73bc-d634-5994-d049c7a73eae@redhat.com>
In-Reply-To: <f3790a7d-73bc-d634-5994-d049c7a73eae@redhat.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 14 Jan 2021 08:50:23 +0100
Message-ID: <CA+icZUV9rdRuswqDa9u=VFcqgHp1x+jmz565QCFi=yC0D7hhVQ@mail.gmail.com>
Subject: Re: [PATCH] btf_encoder: Add extra checks for symbol names
To:     tstellar@redhat.com
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Wed, Jan 13, 2021 at 1:28 AM Tom Stellard <tstellar@redhat.com> wrote:
>
> On 1/12/21 10:40 AM, Jiri Olsa wrote:
> > When processing kernel image build by clang we can
> > find some functions without the name, which causes
> > pahole to segfault.
> >
> > Adding extra checks to make sure we always have
> > function's name defined before using it.
> >
>
> I backported this patch to pahole 1.19, and I can confirm it fixes the
> segfault for me.
>

Thanks for testing.

Can you give me Git commit-id of LLVM-12 you tried?

- Sedat -

> -Tom
>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >   btf_encoder.c | 8 ++++++--
> >   1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/btf_encoder.c b/btf_encoder.c
> > index 333973054b61..17f7a14f2ef0 100644
> > --- a/btf_encoder.c
> > +++ b/btf_encoder.c
> > @@ -72,6 +72,8 @@ static int collect_function(struct btf_elf *btfe, GElf_Sym *sym)
> >
> >       if (elf_sym__type(sym) != STT_FUNC)
> >               return 0;
> > +     if (!elf_sym__name(sym, btfe->symtab))
> > +             return 0;
> >
> >       if (functions_cnt == functions_alloc) {
> >               functions_alloc = max(1000, functions_alloc * 3 / 2);
> > @@ -730,9 +732,11 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
> >               if (!has_arg_names(cu, &fn->proto))
> >                       continue;
> >               if (functions_cnt) {
> > -                     struct elf_function *func;
> > +                     const char *name = function__name(fn, cu);
> > +                     struct elf_function *func = NULL;
> >
> > -                     func = find_function(btfe, function__name(fn, cu));
> > +                     if (name)
> > +                             func = find_function(btfe, name);
> >                       if (!func || func->generated)
> >                               continue;
> >                       func->generated = true;
> >
>
