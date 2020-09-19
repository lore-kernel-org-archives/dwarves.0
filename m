Return-Path: <SRS0=Dio3=C4=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEA8C43464
	for <linux-dwarves@archiver.kernel.org>; Sat, 19 Sep 2020 04:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05A4221897
	for <linux-dwarves@archiver.kernel.org>; Sat, 19 Sep 2020 04:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UNTjzLpJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgISEAX (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Sat, 19 Sep 2020 00:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgISEAX (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Sat, 19 Sep 2020 00:00:23 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D59C0613CE
        for <dwarves@vger.kernel.org>; Fri, 18 Sep 2020 21:00:23 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id w1so7965582edr.3
        for <dwarves@vger.kernel.org>; Fri, 18 Sep 2020 21:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C5TfCdEobPZaNTmYc2YXaKI9LgSDVcmeOndguXiANPo=;
        b=UNTjzLpJ5ARVA5FtyUgRhcnBL7iMjifINrHrm/sz8d9vseFzlPZiVFQm4Ay/9Hwj5w
         mrp7cv+NQ74xtJGr9n3oK7O2RobDvoSIGAZvIfOlVI9eguF+rgIyNrGTx7szZyMNn0xs
         nAwO/iP0Nv7y8CGr17lBVLN6eSVn/EvUNSAc1BMx/OuId2XS+dE4WFBUAEa+xBzLOJQU
         0WJx35hNX6kdWnHrDrbHmeBqSvMsQ9T+cFpFqxB5HPpncCNUgWftIEPp4dQv4mzNAGpW
         m7Z8sGotkFDDImue0SMN34v+wStLeBJQDxlo6MHheZLkibcD8q2OTN4wCHytTvyUZ9Sp
         7Dow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C5TfCdEobPZaNTmYc2YXaKI9LgSDVcmeOndguXiANPo=;
        b=ADVLFg3DFEIL8J9Sa6MhmImmlwQ9yrplb+ewUOr+Fv6udh37pumWqvWtOEOPSx1QDn
         H1RgdqLerupeml5+wEuVZb4zFkOt64PAYl/zEKjt9wrwcJa6mb9n2Xo8rORGoAbGTAGh
         3XfSLxkYdhLS1BnRI2pMGbtnTpxV86TI0QfeuHOr5vvbPaoLO6e3cSNhM5d4LyOpw8+6
         Wx/PQpsDthwtwYitGZPvaHsiFNl6gEwBMLd8xbF5JGk4Leo5/WyU7lMvpZQjNjVeRLqK
         nnGdWMIfSH/pCdhROIJEvlY9JxDbX/7yBH/BSj9ljQsNXJf7eKJkzByr8BwAEW2XihQd
         F3iQ==
X-Gm-Message-State: AOAM5327NzvtObWYZu/iGA2LRCEc/q5tucLdHnT+Ty3B0zdZpj3//cmz
        hveKx6KpvPgrYZGo3Qu6nth3rTQVkWqqD+eMl2NXBA==
X-Google-Smtp-Source: ABdhPJxiTNZO4B35u2TM/uJ6rOppyO7edgJY0C1XP/a4j97wcHynsrn4KsIzgeJoyA3itSyT02rgt+Q3pXqTrr9irGM=
X-Received: by 2002:aa7:dc18:: with SMTP id b24mr42050167edu.285.1600488021242;
 Fri, 18 Sep 2020 21:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200918204058.1030519-1-haoluo@google.com> <CAADnVQL_Qudg34PpgKDz4pObwUZBJfbmKm+NcSLiQf575JcvEQ@mail.gmail.com>
In-Reply-To: <CAADnVQL_Qudg34PpgKDz4pObwUZBJfbmKm+NcSLiQf575JcvEQ@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Fri, 18 Sep 2020 21:00:10 -0700
Message-ID: <CA+khW7i5vWnUMCvHmtEDVUQ92Wy+sLhOmnLjHBgVUdgdMWKQdQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] pahole: Make encoding percpu vars into BTF optional.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        dwarves@vger.kernel.org, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Hi Alexei,

I was syncing with Arnaldo offline on whether the change in Pahole was
enough for supporting percpu vars in BPF. While I think about it, I
felt it's better to have a flag in pahole to toggle the feature on and
off. My concern is mainly malformed BTF caused by the newly introduced
VAR entries. I've tested over some kernel configurations and compilers
but not confident enough.

I haven't thought about opt-out. Maybe we should use opt-out instead of opt-in?

Hao

On Fri, Sep 18, 2020 at 5:58 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Sep 18, 2020 at 1:41 PM Hao Luo <haoluo@google.com> wrote:
> >
> > Previous commit f3d9054ba8ff ("btf_encoder: Teach pahole to store
> > percpu variables in vmlinux BTF.") introduced a feature in btf_encoder
> > that encodes global symbols in BTF. However, this feature is not
> > protected by any flag. In order to avoid surprises after Pahole v1.18
> > rolls out, make this feature off by default and enable only upon
> > request. On the kernel side, we can add a Kconfig to enable this
> > new capability on an opt-in pattern.
>
> I think I've missed some earlier discussions and motivation for opt-in.
> Why opt-out is a problem?
> I would think the kernel build should always include percpu vars.
