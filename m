Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1641C55ABD
	for <linux-dwarves@archiver.kernel.org>; Wed, 11 Nov 2020 00:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73F1A21D40
	for <linux-dwarves@archiver.kernel.org>; Wed, 11 Nov 2020 00:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tXIUGVFv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732023AbgKKAfj (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 10 Nov 2020 19:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbgKKAfi (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 10 Nov 2020 19:35:38 -0500
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502F6C0613D1;
        Tue, 10 Nov 2020 16:35:37 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id c129so279623yba.8;
        Tue, 10 Nov 2020 16:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Vr22uAVqYSqpbqNa9Yg0tn91cXoMuFBJPquIcGK7qg=;
        b=tXIUGVFvwD+KgKI41LTQoHHs2j3tef0uqtoB7nW2lq29qRPKDWpjJwYde5yjOfLik/
         3bmFLXxManeAjOefs/h+exZ/eMhbNAB0T7P9c/vpnLBUuV7yFoMPhtmmMyLtU6AfpmiU
         I/t3eJcEmvYRu7YapaVd7g1rd3kG71skaJ+wnjeu/x/ryJdEpEUs1Ssr+c0kMShE7MVy
         Dv8Qzqg4hho9Spxh5FUeAwKNBofeU/LfvgiZJeX9785O181oYXO0U1QMebHpAJUr5vXF
         N1KWZw1dptMJyeVKU3xkgCt38OB7UOLgO8xvArtKzlyzIXUeeR09fFs1XFsbBGBIMXVa
         APiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Vr22uAVqYSqpbqNa9Yg0tn91cXoMuFBJPquIcGK7qg=;
        b=asrCPyLkTNIOnLWOW3mE3W+tH6uR8GB08gtqycM9GE1x0Aoz7j/efVOFcq464Wuox6
         O5b0u0vBDl5ooFfKBkkiFK+8RnUw6FWbstzPuJU1LmsOlGUiBACdBXLt0kBG62HgskwA
         /leZn70fUQBGrcifWGEkpuhBQhvz2St00OyrK8ClSg1pIuVWgQFe79C3QDGjjpncd+lc
         0moxYqpKxdRKCRrUH9rsiLr9hWbwif+g3cVEgv/Chlm/EzpUSccIhNau1HyFwG+YmQsB
         QFqCddzoIIU4lokbpOmjMeCRgRsPxt9GC+fmstaehL2MgoAKsSjTefBprAbc14/BsIkB
         gqvw==
X-Gm-Message-State: AOAM5319MzJ1ACDCnZ5SSqPrb0jeHVocv1PkFUDatjyRaulYGWKxQfiR
        akEgmnA1sef4cKYzmSTqkOOmbNYm1y62+MQO8hk=
X-Google-Smtp-Source: ABdhPJztwFR5OlubGxhtc3fwQ5kMb0fYmMAK0ojxUZXyzM/p3KgiwLFPfGtGhnGDc1L9nyq9YBdsLS0SI+KgvL4KEjA=
X-Received: by 2002:a25:df82:: with SMTP id w124mr2223120ybg.347.1605054936492;
 Tue, 10 Nov 2020 16:35:36 -0800 (PST)
MIME-Version: 1.0
References: <20201106052549.3782099-1-andrii@kernel.org> <CAEf4BzZGXQaDEwASyaJ39AAZ7TWnbi89pgrwXB5uFi861c9CCA@mail.gmail.com>
 <348BC25F-0DDF-416E-8659-0C4B09F0A767@gmail.com>
In-Reply-To: <348BC25F-0DDF-416E-8659-0C4B09F0A767@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 10 Nov 2020 16:35:25 -0800
Message-ID: <CAEf4Bzb9CJeZKxJ=Ppdpsb_1qZ2nSOTmRyk1Lj_wok0sH8NZ_w@mail.gmail.com>
Subject: Re: [PATCH dwarves 0/4] Add split BTF support to pahole
To:     Arnaldo <arnaldo.melo@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Tue, Nov 10, 2020 at 4:30 PM Arnaldo <arnaldo.melo@gmail.com> wrote:
>
>
>
> On November 10, 2020 8:34:18 PM GMT-03:00, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >On Thu, Nov 5, 2020 at 9:25 PM Andrii Nakryiko <andrii@kernel.org>
> >wrote:
> >>
> >> Add ability to generate split BTF (for kernel modules), as well as
> >load split
> >> BTF. --btf_base argument is added to specify base BTF for split BTF.
> >This
> >> works for both btf_loader and btf_encoder.
> >
> >Arnaldo, can you please take a look at these patches? Would be nice to
> >get them landed ASAP so that we can start testing out kernel module
> >BTFs without locally applying patches first. Thanks!
>
>
> I've been working on prepping up v1.19, will process these patches first thing in the morning, tomorrow,
>

Thanks! Do you plan to include these changes into v1.19 as well?


> Thanks,
>
> - Arnaldo
> --
> Sent from my Android device with K-9 Mail. Please excuse my brevity.
