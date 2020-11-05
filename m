Return-Path: <SRS0=OQ7q=EL=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C91C388F7
	for <linux-dwarves@archiver.kernel.org>; Thu,  5 Nov 2020 19:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A29B20867
	for <linux-dwarves@archiver.kernel.org>; Thu,  5 Nov 2020 19:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLBbUJoN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgKETeU (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 5 Nov 2020 14:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbgKETeU (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 5 Nov 2020 14:34:20 -0500
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BAAC0613CF;
        Thu,  5 Nov 2020 11:34:20 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id f140so2353564ybg.3;
        Thu, 05 Nov 2020 11:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4bQlCbRS2Gvepe95Y5RmN58m8YHVvwNl/sNCuwvGz+c=;
        b=JLBbUJoNRydZyR/9YWLMBx14ATadcu6Fona1GE3xtWkomKOD7NfJHyydT/UgBq/9lQ
         F9ZuidnZ3o2xa27jx//72dfVfF8prSO/nlm0QW61RTjUiixkeXw9lUW35Ucdnkk0swXE
         stQwAZ5I5ddGT5hvyQC2TQ9y/xrj4gtCdUa5b7jU3mMbUw3BO48L8XJwpxwW6l/bhxG2
         6NAgeGcYxC1kZHF3hGp5H0ingGmb0fUf63a3+4yPgDAhXgF1nxd7hpeHVpte3eZ6hrvu
         /pWvOgLR3fF6Yn0WvYRaOl8bH7bj/3hep/9FD+5EkbpBbquoLG5eq/ykuj3CD3sp9vbb
         OK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4bQlCbRS2Gvepe95Y5RmN58m8YHVvwNl/sNCuwvGz+c=;
        b=n6RY+kf1aq+8sjQsp9DrZGFmNjgPnAa0rk3IgLObEli+8bfpTnLsd3pTBNjFTd1m6g
         HY0G9CkzWiqZObIXVeQ1NXMmrmRMxFrSlEv0qLc4wQDfJhrLEWSjiYuMOeCa95ys71sY
         FUu++VFm/cRstf65VrfCvKANqFzmpMUCvKUjBsNBe0ffuzZ1qEXbLkL0daZPX2spRm8W
         DcqQb0Koi3mZQx4KGxJHYE5S0JDl3tCACSlZKfw8ttZx3EcbwZsnfpqSEG9riS1dC5Id
         QdZjjUGUKNUU381nPSbqxQgMXEAdtuqWnI27IWuiK9WqDJCvWK3Zs+hslY666lobbJtZ
         accQ==
X-Gm-Message-State: AOAM533kWKkpaW81kO9/dQO+YZLlLAT/pPOR3gsjypN8EJAP5Or4YPoC
        NIzYLq1cbQAG2GpRiYebiYeKL3XwogbxTiiKMZI=
X-Google-Smtp-Source: ABdhPJyC0TrTEfU6YqDztsDKf//67amJKhUFXJ/N59Y/wH5NRz6P43ywtaVbj0ol+q7u7wNfhLoGsNOyllHVX1Nw3hA=
X-Received: by 2002:a25:afc1:: with SMTP id d1mr5391775ybj.27.1604604859672;
 Thu, 05 Nov 2020 11:34:19 -0800 (PST)
MIME-Version: 1.0
References: <20201104215923.4000229-1-jolsa@kernel.org> <20201104215923.4000229-3-jolsa@kernel.org>
In-Reply-To: <20201104215923.4000229-3-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 5 Nov 2020 11:34:08 -0800
Message-ID: <CAEf4BzYJd5ib3WOO_gp+vs7VQtuSAOC8+QTah_S+=kN=PMpyjg@mail.gmail.com>
Subject: Re: [PATCH 2/3] btf_encoder: Move find_all_percpu_vars in generic collect_symbols
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Hao Luo <haoluo@google.com>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Wed, Nov 4, 2020 at 2:02 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Moving find_all_percpu_vars under generic collect_symbols
> function that walks over symbols and calls collect_percpu_var.
>
> We will add another collect function that needs to go through
> all the symbols, so it's better we go through them just once.
>
> There's no functional change intended.
>
> Acked-by: Hao Luo <haoluo@google.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---

diff tool didn't do a great job here :( but code seems fine to me, so:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  btf_encoder.c | 124 +++++++++++++++++++++++++++-----------------------
>  1 file changed, 67 insertions(+), 57 deletions(-)
>

[...]
