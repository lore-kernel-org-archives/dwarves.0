Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0195EC433DB
	for <linux-dwarves@archiver.kernel.org>; Tue,  9 Feb 2021 15:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBE5264EB8
	for <linux-dwarves@archiver.kernel.org>; Tue,  9 Feb 2021 15:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbhBIPHF (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 9 Feb 2021 10:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbhBIPG7 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 9 Feb 2021 10:06:59 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2933FC061786
        for <dwarves@vger.kernel.org>; Tue,  9 Feb 2021 07:06:18 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id o186so9576666vso.1
        for <dwarves@vger.kernel.org>; Tue, 09 Feb 2021 07:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DbTXuOBblU9jPQgm8MRCYvaknfLBOXYdW6zn/C5UsN4=;
        b=g/Bp8tCC+w+JRa9cSdlGPUAvUtCoqGkBlEfY1+vOAFxvIGs7DjlKloprbuxuxF5h9u
         Gef1X9bSr41acjjYqEEn/POZS54oqzEyIGXl5EbHqEjBZguUxuFRzcCO5egLwpSxCoMc
         dk1WYzkGF0G3b6dc2FVDPpzbwxilHHlDVDoL/kLgmswz2m0pUz4Pvcx3Ktb83zxvw4OZ
         2KnAQSskFdQbV+G/GjXouzw9Ls/cP5stTdUfuxLEfTiIxHj9CE/0C3n8kGuBGxmBSk+S
         H0jd7NON01AGegEToSoLwVq1BJS84nIx5elUDZDWnMiy550CFlQrmjzYotNYVHeZ05aG
         xP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DbTXuOBblU9jPQgm8MRCYvaknfLBOXYdW6zn/C5UsN4=;
        b=AArbdvTEiR3K0oJ3gyOwshZecoRDEHttSofK2XIPplJ5x6SIaghrBCJzM/2pKqmYZd
         F+IO/CV/xbLS2KwCpO4X7dlxJUXw3yXmSYAvfsruU1/nnokxxer6W7tBu4vrSckr2Wxn
         1tubHT9KOxBJdpzsnxbILR0xPnGrwvoQF/yI8ft6mbYDNvM2Od4sziZaZU4gsJuCmVmw
         A3b0zAfUOnyyyApxyXeHJXmYuyreeAU2KMr+lWxATN+5+83IKFw4HxzEPUG3zQu5KMxK
         wX827hJD7qeQFTCSA575Rm1cEs4AuNCz7TkbmZ5ApvjzkJ0eZMh/AcL6aumLlHnzPI3R
         kPmg==
X-Gm-Message-State: AOAM530wNmrLFC1nwYGo162NOtn9PcGiRgW+lf5vaO+eAK0QK616y+T1
        SeThfo6+E2OgNMEwwrCbTaNATmUuB6AGJ0l8OGJcSUzNAI4=
X-Google-Smtp-Source: ABdhPJxhv1/QRVdi6XCilq9+IFSXqAjlels0Dy9hn4GDFSmN3+hX4k6pNhxQyVDMM4aboLB11aWrWNo+3Q4Gk5bskyQ=
X-Received: by 2002:a67:1142:: with SMTP id 63mr13478014vsr.24.1612883176546;
 Tue, 09 Feb 2021 07:06:16 -0800 (PST)
MIME-Version: 1.0
References: <20210201172530.1141087-1-gprocida@google.com> <20210205134221.2953163-1-gprocida@google.com>
 <20210205134221.2953163-6-gprocida@google.com> <CAEf4Bza+mCKjva7BnChhFugjnE0mHzmfB4XErnmoZtkh6+jBpw@mail.gmail.com>
In-Reply-To: <CAEf4Bza+mCKjva7BnChhFugjnE0mHzmfB4XErnmoZtkh6+jBpw@mail.gmail.com>
From:   Giuliano Procida <gprocida@google.com>
Date:   Tue, 9 Feb 2021 15:05:42 +0000
Message-ID: <CAGvU0HmnzjGvgaQ8VHfFgEO4n12a+ik7vEh6Fkgj1Z=RvWJM8g@mail.gmail.com>
Subject: Re: [PATCH dwarves v3 5/5] btf_encoder: Align .BTF section to 8 bytes
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        =?UTF-8?Q?Matthias_M=C3=A4nnich?= <maennich@google.com>,
        kernel-team@android.com, Kernel Team <kernel-team@fb.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Mon, 8 Feb 2021 at 22:30, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Feb 5, 2021 at 5:42 AM Giuliano Procida <gprocida@google.com> wrote:
> >
> > This is to avoid misaligned access to BTF type structs when
> > memory-mapping ELF objects.
> >
> > Signed-off-by: Giuliano Procida <gprocida@google.com>
> > ---
>
> I trust you did verify that it actually works in cases where
> previously .BTF was mis-aligned?
>

Yes. :-)

> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
> >  libbtf.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/libbtf.c b/libbtf.c
> > index 9f4abb3..6754a17 100644
> > --- a/libbtf.c
> > +++ b/libbtf.c
> > @@ -744,6 +744,14 @@ static int btf_elf__write(const char *filename, struct btf *btf)
> >                 goto out;
> >         }
> >
> > +       /*
> > +        * We'll align .BTF to 8 bytes to cater for all architectures. It'd be
> > +        * nice if we could fetch this value from somewhere. The BTF
> > +        * specification does not discuss alignment and its trailing string
> > +        * table is not currently padded to any particular alignment.
> > +        */
> > +       const size_t btf_alignment = 8;
> > +
> >         /*
> >          * First we check if there is already a .BTF section present.
> >          */
> > @@ -821,6 +829,7 @@ static int btf_elf__write(const char *filename, struct btf *btf)
> >                 elf_error("elf_getshdr(btf_scn) failed");
> >                 goto out;
> >         }
> > +       btf_shdr.sh_addralign = btf_alignment;
> >         btf_shdr.sh_entsize = 0;
> >         btf_shdr.sh_flags = 0;
> >         if (dot_btf_offset)
> > --
> > 2.30.0.478.g8a0d178c01-goog
> >
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
