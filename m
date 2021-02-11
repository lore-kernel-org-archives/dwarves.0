Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D2BC433E0
	for <linux-dwarves@archiver.kernel.org>; Thu, 11 Feb 2021 01:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFAC864EC9
	for <linux-dwarves@archiver.kernel.org>; Thu, 11 Feb 2021 01:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbhBKBZA (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 10 Feb 2021 20:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbhBKBY7 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 10 Feb 2021 20:24:59 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B930AC061574
        for <dwarves@vger.kernel.org>; Wed, 10 Feb 2021 17:24:18 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id sa23so7542685ejb.0
        for <dwarves@vger.kernel.org>; Wed, 10 Feb 2021 17:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BEXlHvTyZH7qZYc5/wanJ3+A/tSq4HeD6PPTeuxatvQ=;
        b=cLnv65VCo0gf7L8/T/AHbaxXsH6azCVGLp+T3O7cWQMoSNJlgbWCX72ExrHMaMQLrZ
         c+677RaJHFedEBIQTH7iSw6thEpdUn9K2ggCWKXkPUIjApbR0tJeYPVCcA9YiZh/KZdL
         rJw2qRhBl7QnsNcMoOzdn6l1Y88e/5qC0kzxqejroT4UBgXzYi6CSwQPD+3cB92mOi7X
         Pti+YQ1nCX/RVYbyeR2FpMB/w74uYffDZm/Uhs1Jf7qXwoys/IzP/he6mVNUesQOHzw5
         JFZIpqFmfS3YwBoYklrymR4vjpS2cOxMlt6KVkOYqESQOKb/T59qspCMIrLi3h66GVD4
         Yhvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BEXlHvTyZH7qZYc5/wanJ3+A/tSq4HeD6PPTeuxatvQ=;
        b=mBO+/Au0VxKtUFzczOPwaIdO/fIEopOoDoGT0oKteIRuFUzInYceaAOthhZTF6cGmr
         azuPSu/coVaUGJUDyMZrFq3xeYiGzlJNJdcTLCXMaPxvjtKL71cLtVbsU/WMYBmygV9a
         se3+tyiJat89UXXFoRLslklzxxYyUruARo1KtR65z5x5a41g8ROa5Or8tfjCB3Fq9ms+
         15X9qek+uuyChodJUHQAsU2I0Rf7SQhLRMhKI4w5SrdpG3H1z8d6zlBN91oq9fqCN5LN
         KPhhILGy/l98ciOixQyqEpla3rrWOglx47AUs0Z1A7kzluRiwQpH9e76m12wAYvaCIPp
         bdvw==
X-Gm-Message-State: AOAM531NcGKkJWZEjP1xJflw9wBfHi8hPQWBJb8sNrDW3szS+zoFPll2
        JO3Kcfhtx7kVvMn0ZpRg9l/gfeQk2ELIyT+NFy1Bhxtjsw==
X-Google-Smtp-Source: ABdhPJxQanBnCQHeGmaZqIyjoWVXea2e1I6JlLMEZ4fSc1dg79NNxqhv7Xte+x018jvYraBrDsY7KPHTjndazFlwkTk=
X-Received: by 2002:a17:906:f24a:: with SMTP id gy10mr5672792ejb.531.1613006657225;
 Wed, 10 Feb 2021 17:24:17 -0800 (PST)
MIME-Version: 1.0
References: <20210210232327.1965876-1-morbo@google.com> <CAEf4BzYrWe4N28JjM6na=sNvq5214zs5yHra_fCuE1KA24KQ0A@mail.gmail.com>
In-Reply-To: <CAEf4BzYrWe4N28JjM6na=sNvq5214zs5yHra_fCuE1KA24KQ0A@mail.gmail.com>
From:   Bill Wendling <morbo@google.com>
Date:   Wed, 10 Feb 2021 17:24:06 -0800
Message-ID: <CAGG=3QW0zuXUcpkcZqnaZS77EABEshhPtUCTr71dDDMuL1oMZQ@mail.gmail.com>
Subject: Re: [PATCH] dwarf_loader: use a better hashing function
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Wed, Feb 10, 2021 at 4:00 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Feb 10, 2021 at 3:25 PM Bill Wendling <morbo@google.com> wrote:
> >
> > This hashing function[1] produces better hash table bucket
> > distributions. The original hashing function always produced zeros in
> > the three least significant bits.
> >
> > The new hashing funciton gives a modest performance boost.
> >
> >       Original      New
> >        0:11.41       0:11.38
> >        0:11.36       0:11.34
> >        0:11.35       0:11.26
> >       -----------------------
> >   Avg: 0:11.373      0:11.327
> >
> > for a performance improvement of 0.4%.
> >
> > [1] From Numerical Recipes, 3rd Ed. 7.1.4 Random Hashes and Random Bytes
> >
>
> Can you please also test with the one libbpf uses internally:
>
> return (val * 11400714819323198485llu) >> (64 - bits);
>
> ?
>
> Thanks!
>
It's giving me a running time of ~11.11s, which is even better. Would
you like me to submit a patch?

-bw
