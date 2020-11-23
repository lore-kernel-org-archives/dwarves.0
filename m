Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B850C5519F
	for <linux-dwarves@archiver.kernel.org>; Mon, 23 Nov 2020 00:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFFA82076E
	for <linux-dwarves@archiver.kernel.org>; Mon, 23 Nov 2020 00:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tC28EI5V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgKWAZu (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Sun, 22 Nov 2020 19:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgKWAZu (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Sun, 22 Nov 2020 19:25:50 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128F9C0613CF;
        Sun, 22 Nov 2020 16:25:50 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id l14so14414417ybq.3;
        Sun, 22 Nov 2020 16:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xiSILJWO7KVBzbQc8ciKzQWp1rDDoAA1vzBVnVNBoK0=;
        b=tC28EI5VEh1HYiYUwqi3ZJ4xLLTOXSNFxskUDxV/ip8ykQ118ebbDXkzWVHiOES3Wv
         BUW9azQ4y8SVbKBogjuHOOWSDVg6A6inT8FEbrIgwwTD+Fq2Raf4GQ7xIOHGbLQVWbpK
         b/NsX2n4v+2zSpezGSfiOkTtVPvBu+209lQZcKQr40dimRtzk42qLAgB2wvVYcAIeLu7
         hRAshAqDR7eZq2bA3F2XNj47FBLX63K+cdeETR1hkY9iU5Ycgphdl9v+D0mwQLanc6tL
         e2B5SIQcyhhhL78yTfmyYaiH9dbJoRdlGBxdBnrdpMGEF3gWCKuJDjy1xVWmTUe8GJBU
         WxXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xiSILJWO7KVBzbQc8ciKzQWp1rDDoAA1vzBVnVNBoK0=;
        b=VPqiTzylqPbU8iDzuyZ2M6IeCPWlCfpQ+eF82kxv+avMxKa+5761ePg4piC/IFoPrS
         el4g6sZuQjSFkOvQg4eqluPQ1b47lvFeLyYEdhZW1tEcEhiM1Bvah1rKmiLM3370D83O
         SKlobtsshBgbOlijaXikb+Q4jCimhRQEJgegbPKAlp9728mFWqw5yr4UmLmFk2oYQHys
         5K87LcPJXKWzFMpfmOjzZe2uTqxvxKdMRpkMcotHNWkgVin0HqY/k1gbVcN/ooGmhK2Y
         MJeo9e8LP8xrRDcSjnQ5Qx/X8WvQnpKpwttaA7CJc0a4chOlZjGIKT3vP9zs4+96J+ay
         MAtg==
X-Gm-Message-State: AOAM532p5HEOmIn2I/mEBsllRLQb5r2OEBpSBHnhnEyaVIS31CKxtNvT
        4JELaIbZxdpHJXASzyceeRY8cSuoil1IQX2hs1Q=
X-Google-Smtp-Source: ABdhPJwsWZ/EfkdHfPoT6O9kxUaFb/UhZ0rt6tRM62cTdGc1HnzSCPkKTia52d//14oW1aiAB13TH0BKc1hDr3VPhvs=
X-Received: by 2002:a25:2845:: with SMTP id o66mr41635667ybo.260.1606091149113;
 Sun, 22 Nov 2020 16:25:49 -0800 (PST)
MIME-Version: 1.0
References: <20201114223853.1010900-1-jolsa@kernel.org> <CAEf4BzZ-0exZK7skcB_UjyatAx_R=hNqAXKVZ8EXgmSsHmthFg@mail.gmail.com>
 <20201122225617.GA1902740@krava>
In-Reply-To: <20201122225617.GA1902740@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sun, 22 Nov 2020 16:25:38 -0800
Message-ID: <CAEf4BzYu5OuF-5K91ofEE4Uk3nQWZubgYZWAfVnMGxUb0w7rEw@mail.gmail.com>
Subject: Re: [PATCHv3 0/2] btf_encoder: Fix functions BTF data generation
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Sun, Nov 22, 2020 at 2:56 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Nov 20, 2020 at 05:13:24PM -0800, Andrii Nakryiko wrote:
> > On Sat, Nov 14, 2020 at 2:39 PM Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > hi,
> > > recent btf encoder's changes brakes BTF data for some gcc
> > > versions. The problem is that some functions can appear
> > > in dwarf data in some instances without arguments, while
> > > they are defined with some.
> >
> > Hey Jiri,
> >
> > So this approach with __start_mcount_loc/__stop_mcount_loc works for
> > vmlinux only, but it doesn't work for kernel modules. For kernel
> > modules there is a dedicated "__mcount_loc" section, but no
> > __start/__stop symbols. I'm working around for now by making sure
> > functions that I need are global, but it would be nice to have this
> > working for modules out of the box as well.
>
> hi,
> I checked and it's bit more tricky than with vmlinux,
> addresses are in __mcount_loc, but it's all zeros and
> it gets filled after via relocation from .rela__mcount_loc
>
> I think we could do relocation of __mcount_loc section
> with zero base and get all base addresses.. and then
> continue from there with current code checks
>
> I'll check on it tomorrow

Thanks!

>
> >
> > If you get a chance to fix this soon, that would be great. If not,
> > I'll try to get to this ASAP as well, because it would be nice to have
> > this in the same version of pahole that got static function BTFs for
> > vmlinux (if Arnaldo doesn't mind, of course).
>
> we're eagerly expecting the new pahole with the DWARF bug
> workaround, so we asked Arnaldo to release soon, how big
> problem is it for you if the modules fix is in the next one?
>

Not a problem, I just hate remembering all the versions of all the
binaries/libraries/compilers and what each version added. 1.19 had a
chance to be the version which makes fentry/fexit work for all cases,
but I guess it won't happen :) No big deal.

> thanks,
> jirka
>
> >
> > >
> > > v3 changes:
> > >   - move 'generated' flag set out of should_generate_function
> > >   - rename should_generate_function to find_function
> > >   - added ack
> > >
> > > v2 changes:
> > >   - drop patch 3 logic and just change conditions
> > >     based on Andrii's suggestion
> > >   - drop patch 2
> > >   - add ack for patch 1
> > >
> > > thanks,
> > > jirka
> > >
> > >
> > > ---
> > > Jiri Olsa (2):
> > >       btf_encoder: Generate also .init functions
> > >       btf_encoder: Fix function generation
> > >
> > >  btf_encoder.c | 86 +++++++++++++++++++++-----------------------------------------------------------------
> > >  1 file changed, 21 insertions(+), 65 deletions(-)
> > >
> >
>
