Return-Path: <SRS0=ASgQ=C6=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB9EC41604
	for <linux-dwarves@archiver.kernel.org>; Mon, 21 Sep 2020 20:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBC2A2193E
	for <linux-dwarves@archiver.kernel.org>; Mon, 21 Sep 2020 20:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WreAHpry"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgIUUA2 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 21 Sep 2020 16:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbgIUUA2 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 21 Sep 2020 16:00:28 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B28C061755
        for <dwarves@vger.kernel.org>; Mon, 21 Sep 2020 13:00:28 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id a12so13961493eds.13
        for <dwarves@vger.kernel.org>; Mon, 21 Sep 2020 13:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+4yCtEjAAgXAx9M6I9Ju8eER/XWiUyAgxq5i40WwM7k=;
        b=WreAHpry7be8QCQXSaTZlCv7DEw3oScHTg6PKPvN9JCQ3gqYwab3X/65fnAcE61x7x
         ar8cpMgbsDwJMaaEJ78YWGwMHH36ncrGsWpKUoi2m/U7BqIXGe0nMKvm8tFhMoXi+VZt
         f542devxyXDk1DAo+XfcF4Ffl2bdd+KXJUKIhQppj2joQNmBYyauc3XNg2RFiexE0InG
         CUqeRmddaACyDjhCZ7Ckhp2WSjA7/DpqOUnnwaSl9AfeOO18qUWTGV0taJ5j8PBqK27/
         2U7dpyApllyQ4G63KfQM/aINlrQAvE1WAk+eplYIbVHQg0F00Axaw5tF9Ju99iJa2oQl
         1FnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+4yCtEjAAgXAx9M6I9Ju8eER/XWiUyAgxq5i40WwM7k=;
        b=AyYEUvUmuls6qe0lkYBiQSFWyYXjS4qwJmoO+aPBTCUtkldTWIhQ1uff4aeDdX8DdG
         Kat+Sp6Pim6MUr42Zhm8e/bW3B1HGfIzOXNUz8zoHdRVahPB5ubddFoFiRMpxzRPdcX5
         6kFD5tGpDt6zzHdRBcmhVOQmTfEq0erjb/APtCv812uV/iJTPHR3R0KAO1NB6jO0La+/
         jF5OZrAKoIffbcuELbH8qsSx1Pq7ZoCu75aSKH0O7RjbFq8mBf07Jpp0NKD6Wggnj2Lw
         Pjj2nN0G4R6lQxEkc7qSkXEyzC9/3B0MfKxtuE3Tfd8Wne5DsAofIxC6ytTKEyBIxIuc
         /+ow==
X-Gm-Message-State: AOAM532oP26G/Yo31Aj7CB9cke0TytqxJpoBH/TyPZh8tv8O5KyxJNyB
        GFvcJsXWurWDCWI/k8EDNucMOboCLeH71vQKcdpeGg==
X-Google-Smtp-Source: ABdhPJx2D5sxe2qkvBxygMSL6z6RJShPTaI+dCPIzCIebFs11bHHM7HhF83z3NCw4dvyibNaf9n3Ludq23pFCSL4YM8=
X-Received: by 2002:a05:6402:1d93:: with SMTP id dk19mr600440edb.198.1600718426324;
 Mon, 21 Sep 2020 13:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200921195310.3070085-1-haoluo@google.com> <20200921195653.GK1996959@kernel.org>
In-Reply-To: <20200921195653.GK1996959@kernel.org>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 21 Sep 2020 13:00:15 -0700
Message-ID: <CA+khW7jht3TUmW6tOcWrsTocTxB6ASNToVHgpi3qrcijO03+=A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] pahole: Make encoding percpu vars into BTF optional.
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        dwarves@vger.kernel.org, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Thanks, Arnaldo. I will remember to do it next time.

Hao

On Mon, Sep 21, 2020 at 12:56 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Mon, Sep 21, 2020 at 12:53:08PM -0700, Hao Luo escreveu:
> > v1 -> v2:
> >  - Use opt-out instead of opt-in. Rename the flag name to
> >    '--skip_encoding_btf_vars'
> >
> > Previous commit f3d9054ba8ff ("btf_encoder: Teach pahole to store
> > percpu variables in vmlinux BTF.") introduced a feature in btf_encoder
> > that encodes global symbols in BTF. However, this feature is not
> > protected by any flag. In order to avoid surprises after Pahole v1.18
> > rolls out, add a flag to toggle this feature off.
> >
> > Also as a refactor, introduce '--btf_encode_force' to replace the
> > old '--force' and '-j' option that is used to forcefully emit BTF.
> >
> > Hao Luo (2):
> >   btf_encoder: Allow disabling BTF var encoding.
> >   btf_encoder: Introduce option '--btf_encode_force'
> >
> >  btf_encoder.c |  5 ++++-
> >  btf_encoder.h |  3 ++-
> >  pahole.c      | 22 +++++++++++++++++-----
> >  3 files changed, 23 insertions(+), 7 deletions(-)
> >
> > --
> > 2.28.0.681.g6f77f65b4e-goog
>
> You forgot to update the man page, I'll do it this time,
>
> Thanks
>
> - Arnaldo
