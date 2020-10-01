Return-Path: <SRS0=5UKE=DI=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82ED8C4727E
	for <linux-dwarves@archiver.kernel.org>; Thu,  1 Oct 2020 21:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19A2C20796
	for <linux-dwarves@archiver.kernel.org>; Thu,  1 Oct 2020 21:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ugIOJMTA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgJAVb7 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 1 Oct 2020 17:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgJAVb7 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 1 Oct 2020 17:31:59 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299FCC0613E2
        for <dwarves@vger.kernel.org>; Thu,  1 Oct 2020 14:31:59 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id p15so10196760ejm.7
        for <dwarves@vger.kernel.org>; Thu, 01 Oct 2020 14:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A6CtmI98AFn7eEMLNJqpuB1xJr57WJ8Q4N5w1gdELI8=;
        b=ugIOJMTAjAwpD+N6EgVYuSr637Nzpo1EfT7+QHYcfmWdGK9ezS9M7wtDzvdTP07wPj
         20LReBUPHFSzkBH+VzIRFvgh0YYP0GoTyUJCXROw3nAqzIdDFn1Xi/dd8UrAp5BrxsKA
         go7ImSOPq2ZczbJM+arJmHyZqSbzf8lOmdvsFqg5630bx25sZHHGSy4LqLdrSLwWBs/O
         J8whC5y5Czd+MSavif8VtEXYrRO/6xY/6cwQyVBruQYDKYKTVYZi5kl63ewPXSqgmfEB
         vtHw7tlRYFl+yZSo7THpFdsMAWcfW2PcLQrxUm3fqwCqay2DnXpP9plQzOfUEVVIuwEM
         c1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A6CtmI98AFn7eEMLNJqpuB1xJr57WJ8Q4N5w1gdELI8=;
        b=VSkOI5LEbs23B//Xy4G20O9fEQAj9rQeTiGqsf4lyNSIbbEvnt0mZlSh5eLgTAz1R/
         +EHDYwx/zRazJhTYPXhCFcikK+WyzS0+RBWokfpuK61z5BDUxbYEo0sex+eCkRpYuX6E
         mv+P9TNijC+GGI7JlUFfejgsuhu8tlarjdqlZgytyK13is5nNVDuYxY+KSKAKy0OLOkC
         zwK3UWE7QB1EtMhYsDbTDSq6E2fPZhbexfbrR1QYysdON2p9Bk3fSgIHp4UawEVPckw7
         KgS1ik2tXohKbQIxtOnT6wxa1FEUWRUQnPmoJfqHJ8UZA6xES3o9FFm0TMAkcckM9VwN
         KZBg==
X-Gm-Message-State: AOAM533QtujHhTYeZm1n14xfHBUgBPnSULwyCoVe/XptqwFBEiJs/OxX
        8CCBIvKs78jAfhn/el/89WRS2cdhYIpWMfYsdG4hFA==
X-Google-Smtp-Source: ABdhPJxDFgKwA6w3maTQlrJJVSq0sU+yG2XdZeidyVvnG2QsmlOeBRbl1oy3zj9zVfcUKQkJbt8+tCkP/pLkuFUAam0=
X-Received: by 2002:a17:906:915:: with SMTP id i21mr9992278ejd.113.1601587917513;
 Thu, 01 Oct 2020 14:31:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200825004523.1353133-1-haoluo@google.com> <20200826131143.GF1059382@kernel.org>
 <CA+khW7jf7Z=sMC1u5eyn6XOZDTFJaNjV-D0ogvQSyUGSKjC3LQ@mail.gmail.com>
 <DEC4CC81-88CE-4476-A631-2BBB6E922F5C@gmail.com> <CA+khW7imZ+1to15Y+6Suw5_RRQfOQ32X_mkcFACDedjHrNYFaQ@mail.gmail.com>
 <CAADnVQKkqtSLLiXsQk6EnMz61J3Em53HB9zPZtPeqE4jvzGt3g@mail.gmail.com>
 <20201001182415.GA101623@kernel.org> <CA+khW7iSd4EX0EdoQ0+FvnGg5CKai+TLsa4xbDUPA8tbiu3LZw@mail.gmail.com>
 <20201001202729.GA105734@kernel.org> <CA+khW7iVd3zUa0iwLuf=SwE3TtnNPB1ZGkUvWPfVt7JpJPcX5w@mail.gmail.com>
 <CAADnVQKJc45UhkRj_cjJLvW=crXhN-BpUN0rM4XK_KbLTioAow@mail.gmail.com>
In-Reply-To: <CAADnVQKJc45UhkRj_cjJLvW=crXhN-BpUN0rM4XK_KbLTioAow@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 1 Oct 2020 14:31:46 -0700
Message-ID: <CA+khW7iSyt_MyUCM21AT3pb-vw_ftCUnifV3o3t+Lx4UkgoOUw@mail.gmail.com>
Subject: Re: [PATCH v1] btf_encoder: Handle DW_TAG_variable that has DW_AT_specification
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>, dwarves@vger.kernel.org,
        Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Thu, Oct 1, 2020 at 2:07 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Oct 1, 2020 at 1:57 PM Hao Luo <haoluo@google.com> wrote:
> >
> > Arnaldo, thanks for the update. In that case, I think on the kernel
> > side I need to skip encoding percpu vars for this pahole release, and
> > re-enable for the next pahole release. (assuming the flag for opt-out
> > is in this release). Alexei, do you have any better idea?
>
> I'm not following. Let's get this fix landed in pahole and
> release new 1.18 with it.

Sorry, I misunderstood Arnaldo. I thought what he was saying was, not
having this fix in an officially released version (I took this as the
new 1.18) and will get 1.19 quicker. It would be ideal if we can have
this in 1.18. Sorry for my bad reading.

> The opt-out flag is orthogonal. I can be done in 1.19 or whenever.
> With your kernel patches the kernel will reject percpu vars when pahole
> is too old, because they will not be found in vmlinux btf,
> so I don't see any compatibility issues.
> There is no need to bump the required min version of pahole in
> scripts/link-vmlinux.sh.
> It can stay as v1.16. We only need clean verifier message that percpu BTF
> is not found and the kernel needs to be rebuilt with pahole 1.18.
