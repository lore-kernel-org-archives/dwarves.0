Return-Path: <SRS0=Dio3=C4=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094C9C43463
	for <linux-dwarves@archiver.kernel.org>; Sat, 19 Sep 2020 00:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A521321D43
	for <linux-dwarves@archiver.kernel.org>; Sat, 19 Sep 2020 00:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntl+DWhV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgISA6F (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 18 Sep 2020 20:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgISA6F (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Fri, 18 Sep 2020 20:58:05 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D4FC0613CE
        for <dwarves@vger.kernel.org>; Fri, 18 Sep 2020 17:58:04 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id y4so6479414ljk.8
        for <dwarves@vger.kernel.org>; Fri, 18 Sep 2020 17:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pZ5wi8jIOWzLRpX0RYv1U5STsuvGrzwO5RB9BjjV5gY=;
        b=ntl+DWhVoWLZcFZOJ2kgm8kNEnhmil18Iz57OhyTPzQFTC+Seh0vRd/b2vK3rcktDs
         mTVJ/dRlmWUscy/QM3FHBcAbZmkOWWqqxFO12gxs/noIVVf/oI4u3tY6BxI/sNaCKCrQ
         KJMfO4WUQvaA/ziQm1bOCa6wq8rfApmfDjzZ7DXJ5eZmYd8bKWjNdge5dLgeyTJiwbkN
         XqDF0eBu/TcUZ7lViR/ji/hUivpqPVj/kS/ALkQThbkQ/h82NWB6RRX0iPWCl0CzGpJS
         dF5/3gYr0m7Nt+kcVOe0PanHocjhGXed15D+9WrrTt6iJPXVQvvTxSqxARWk6C826BdQ
         m11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pZ5wi8jIOWzLRpX0RYv1U5STsuvGrzwO5RB9BjjV5gY=;
        b=UeRg/Jr2/UKeP0O95HWiHHMhUDCh4BtbUD1kguPt1LJizn+Xfw+hQSIJh+sLYbZYud
         vXbKjT9f0NaIzTm+m0h/sPvF0Pfi8mXeHN6w5NIVybgENZYfVuiVloJliGfuMRrZUfWW
         F8vK9G7R7dUldW96Lu+k7SSwoOKCeljSVsNBOELs7CHDhefUB38/yMtAGD3UAp+/2uzf
         +LdNytPK7iYatiYKywlT4nir1eSpGjGA1JW2UnZwBd3tScW3g3vSmXpf3RtY+2qpFxZn
         T5mGWe8VoXkujrOQdkKrwPj5RmxKfMiyBSF520juDTdsUDTUn/KviIxsvbDsB6AxX2OJ
         lHJA==
X-Gm-Message-State: AOAM532CHtU+rSdK6jmH7dckIDXbU3/F+WSazRi4JeWkCiDrjwkjE4iH
        T3ImTUCsGFjPpUJxNW4qQYL0gf1yVEtpZHRAxYE=
X-Google-Smtp-Source: ABdhPJwbmgJP7037U4f9cFRaTQ21r3KHAevViiw65wV6N4x0LUmzECbp7Yeb+QqskOTg2aCDhkP4txUuit4u7/ryTPw=
X-Received: by 2002:a2e:8593:: with SMTP id b19mr11823173lji.290.1600477082163;
 Fri, 18 Sep 2020 17:58:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200918204058.1030519-1-haoluo@google.com>
In-Reply-To: <20200918204058.1030519-1-haoluo@google.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 18 Sep 2020 17:57:50 -0700
Message-ID: <CAADnVQL_Qudg34PpgKDz4pObwUZBJfbmKm+NcSLiQf575JcvEQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] pahole: Make encoding percpu vars into BTF optional.
To:     Hao Luo <haoluo@google.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        dwarves@vger.kernel.org, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Fri, Sep 18, 2020 at 1:41 PM Hao Luo <haoluo@google.com> wrote:
>
> Previous commit f3d9054ba8ff ("btf_encoder: Teach pahole to store
> percpu variables in vmlinux BTF.") introduced a feature in btf_encoder
> that encodes global symbols in BTF. However, this feature is not
> protected by any flag. In order to avoid surprises after Pahole v1.18
> rolls out, make this feature off by default and enable only upon
> request. On the kernel side, we can add a Kconfig to enable this
> new capability on an opt-in pattern.

I think I've missed some earlier discussions and motivation for opt-in.
Why opt-out is a problem?
I would think the kernel build should always include percpu vars.
