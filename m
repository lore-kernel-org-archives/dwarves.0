Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31609C433E9
	for <linux-dwarves@archiver.kernel.org>; Thu, 18 Feb 2021 19:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D35BA64EAF
	for <linux-dwarves@archiver.kernel.org>; Thu, 18 Feb 2021 19:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbhBRTpd (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 18 Feb 2021 14:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbhBRTfZ (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 18 Feb 2021 14:35:25 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C802BC061794
        for <dwarves@vger.kernel.org>; Thu, 18 Feb 2021 11:34:44 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id x19so3310873ybe.0
        for <dwarves@vger.kernel.org>; Thu, 18 Feb 2021 11:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TR20ue3w+NhKZ4B5Uqv/4Y+anAj3OfPdw7xd3qA05OU=;
        b=PpH/C+Tc2mgGsgh1tLCUAtjCVlspbq1zdrUFla7JEA63sbP0fyO2YB2dgRS/AFVDUb
         WIC3TvORBHd0BE2HQkq/2cwglnVqSwtSStzDkgsMmRMFM2OlYEDXMHnfOKSAXeJ/FD+e
         +vWorzQAi+Br0FswUt73aWaId7XbRVMTGU5cQvzPfM9Pf1dDl9/WJ3DnyQWhWln0GZe6
         KBpDfnn6glOaIozIcoO5wFCpWxr61rKtJLorajHw4egiaLsMD+tHgvdDA5MaM/5gs5e2
         GGVzmp7M6N/xrjV8/MdRAaAquRzkNAkkBLraRAFgJcX4DqZ2VLzMVVLN39rql3lEtrj1
         FRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TR20ue3w+NhKZ4B5Uqv/4Y+anAj3OfPdw7xd3qA05OU=;
        b=HMHsKbSdTgMAbgkme8nhAFPc8E2J2FSUvwK8XjS+cqk0fQkW1vtn+exWS7GG7+0Loc
         bnG83jBFJQtU8qfET38hbCf3C0GxgDLjtalqyLixNcgdUmYOebiTyMhkN7W8Sv2+f0sr
         DgXrV1KzZsjcwG+moxRncAqP5/xVIUaABetEr5dt7JGrD3GdW/dgs7cMD3RdZ0N3CNBd
         Orj9iEBvjGjGGZb74tLnMTPuon39DFciLWGZQt6ZaBBKBOH16BSdD2Ma/hj6ty6cS8vD
         ZfUf2EVRr8IszW5HkJMfRK2ZUPAuOAOVUq7fxrUry1XAt0MLoOTuFbOfQ2YHtGjz4wc4
         tz4w==
X-Gm-Message-State: AOAM530TlgBj7tRS8uXGfV4wqnRCrM6UtuGvG2L0fjTsS6M+jBnNN+dc
        iXigGB58G5RJq8H50GebiC/da0Db21CfDnLilfSMhw==
X-Google-Smtp-Source: ABdhPJzXcK+i0aenXmN4EWvR9EIhdD21fh/nLY2HjEI0Z8sMoiFtXuGdcpCt4HOy/hrejtVVozBMS8fB3trsCP54C3A=
X-Received: by 2002:a25:e4c4:: with SMTP id b187mr8586420ybh.92.1613676883887;
 Thu, 18 Feb 2021 11:34:43 -0800 (PST)
MIME-Version: 1.0
References: <20210218175115.2850050-1-irogers@google.com> <YC6+RO9ayyGq45FK@kernel.org>
In-Reply-To: <YC6+RO9ayyGq45FK@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 18 Feb 2021 11:34:31 -0800
Message-ID: <CAP-5=fV3mU0qE0rcgiG9hZPNHju=Y--6wB36EHv9SMdEWPv3BQ@mail.gmail.com>
Subject: Re: [PATCH] Avoid warning when building with NDEBUG
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     dwarves@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Thu, Feb 18, 2021 at 11:21 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Feb 18, 2021 at 09:51:15AM -0800, Ian Rogers escreveu:
> > The assert macro is compiled out with NDEBUG which can lead to an unused
> > variable warning if the variable is only read in the assert. This is
> > seen just here:
> >
> > dwarf_loader.c:957:17: error: unused variable 'tag' [-Werror,-Wunused-variable]
> >         const uint16_t tag = dwarf_tag(die);
>
> Thanks Ian, I added:
>
> Signed-off-by: Ian Rogers <irogers@google.com>
>
> And CC: dwarves@vger.kernel.org
>
> Please let me know if this is all ok.
>
> - Arnaldo

That's okay by me, sorry for not posting in the right way and I'm also
happy if this is just a bug report rather than a merged fix :-)

Thanks!
Ian

> > ---
> >  dwarf_loader.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/dwarf_loader.c b/dwarf_loader.c
> > index b73d786..22c3a55 100644
> > --- a/dwarf_loader.c
> > +++ b/dwarf_loader.c
> > @@ -954,9 +954,10 @@ static struct lexblock *lexblock__new(Dwarf_Die *die, struct cu *cu)
> >
> >  static void ftype__init(struct ftype *ftype, Dwarf_Die *die, struct cu *cu)
> >  {
> > +#ifndef NDEBUG
> >       const uint16_t tag = dwarf_tag(die);
> >       assert(tag == DW_TAG_subprogram || tag == DW_TAG_subroutine_type);
> > -
> > +#endif
> >       tag__init(&ftype->tag, cu, die);
> >       INIT_LIST_HEAD(&ftype->parms);
> >       ftype->nr_parms     = 0;
> > --
> > 2.30.0.617.g56c4b15f3c-goog
> >
>
> --
>
> - Arnaldo
