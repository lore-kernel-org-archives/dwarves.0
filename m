Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22D8C433DB
	for <linux-dwarves@archiver.kernel.org>; Thu, 18 Feb 2021 19:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98DA864EB4
	for <linux-dwarves@archiver.kernel.org>; Thu, 18 Feb 2021 19:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbhBRTwb (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 18 Feb 2021 14:52:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:60914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232120AbhBRTod (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Thu, 18 Feb 2021 14:44:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28D4264E2F;
        Thu, 18 Feb 2021 19:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613677432;
        bh=+PpwgEJApa5D7DIC7loQmPKH95NOW1IU4bEr022BMIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HiQcmr/sr56Sx58yFkg7FtdBBN/3lCVNCFBgZOxbNErxRInn9cJHegKHR6Y+3TXsE
         prcI8EjXkwzIPFSMOn1KO+5mb1Qtjhl5n0GVJHR4p0WfuKPo794SoGjrUzMP6Hn7Cq
         UOFfs51lB1nv3uNMk1/Lt7HlytF8UMg06iEBKh1GfXBEbhsn8mKmqxCV8RqMRbJjui
         k8ZUCxqr9nvaWWnN9x2QSja0sWL79tYiO/QMFZaNof3E9sszvqcXNXfF4DQ7wkhzku
         nMkbyiaFGnZuxgqB2DAtcx57W/lIuKrTydGc5NUP2FNfv8SyhWs+gG1i1YvKk8RN1k
         3B2FRmL7wqDGQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 61781411FC; Thu, 18 Feb 2021 16:43:49 -0300 (-03)
Date:   Thu, 18 Feb 2021 16:43:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     dwarves@vger.kernel.org
Subject: Re: [PATCH] Avoid warning when building with NDEBUG
Message-ID: <YC7DdRGjOL0miLyq@kernel.org>
References: <20210218175115.2850050-1-irogers@google.com>
 <YC6+RO9ayyGq45FK@kernel.org>
 <CAP-5=fV3mU0qE0rcgiG9hZPNHju=Y--6wB36EHv9SMdEWPv3BQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fV3mU0qE0rcgiG9hZPNHju=Y--6wB36EHv9SMdEWPv3BQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Thu, Feb 18, 2021 at 11:34:31AM -0800, Ian Rogers escreveu:
> On Thu, Feb 18, 2021 at 11:21 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Thu, Feb 18, 2021 at 09:51:15AM -0800, Ian Rogers escreveu:
> > > The assert macro is compiled out with NDEBUG which can lead to an unused
> > > variable warning if the variable is only read in the assert. This is
> > > seen just here:
> > >
> > > dwarf_loader.c:957:17: error: unused variable 'tag' [-Werror,-Wunused-variable]
> > >         const uint16_t tag = dwarf_tag(die);
> >
> > Thanks Ian, I added:
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > And CC: dwarves@vger.kernel.org
> >
> > Please let me know if this is all ok.
> >
> > - Arnaldo
> 
> That's okay by me, sorry for not posting in the right way and I'm also
> happy if this is just a bug report rather than a merged fix :-)

It's in my local branch now, thanks!

- Arnaldo
 
> Thanks!
> Ian
> 
> > > ---
> > >  dwarf_loader.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/dwarf_loader.c b/dwarf_loader.c
> > > index b73d786..22c3a55 100644
> > > --- a/dwarf_loader.c
> > > +++ b/dwarf_loader.c
> > > @@ -954,9 +954,10 @@ static struct lexblock *lexblock__new(Dwarf_Die *die, struct cu *cu)
> > >
> > >  static void ftype__init(struct ftype *ftype, Dwarf_Die *die, struct cu *cu)
> > >  {
> > > +#ifndef NDEBUG
> > >       const uint16_t tag = dwarf_tag(die);
> > >       assert(tag == DW_TAG_subprogram || tag == DW_TAG_subroutine_type);
> > > -
> > > +#endif
> > >       tag__init(&ftype->tag, cu, die);
> > >       INIT_LIST_HEAD(&ftype->parms);
> > >       ftype->nr_parms     = 0;
> > > --
> > > 2.30.0.617.g56c4b15f3c-goog
> > >
> >
> > --
> >
> > - Arnaldo

-- 

- Arnaldo
