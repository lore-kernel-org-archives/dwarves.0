Return-Path: <SRS0=uCwc=DF=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73541C2D0A8
	for <linux-dwarves@archiver.kernel.org>; Mon, 28 Sep 2020 20:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3364B207E8
	for <linux-dwarves@archiver.kernel.org>; Mon, 28 Sep 2020 20:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura-hr.20150623.gappssmtp.com header.i=@sartura-hr.20150623.gappssmtp.com header.b="FDm9xHh4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgI1U1k (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 28 Sep 2020 16:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgI1U1j (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 28 Sep 2020 16:27:39 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEFCC0613CE
        for <dwarves@vger.kernel.org>; Mon, 28 Sep 2020 13:27:39 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id w1so3383676edr.3
        for <dwarves@vger.kernel.org>; Mon, 28 Sep 2020 13:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DF2/eLTFuB8N9fv1SG404jyibEGpFwRqzB5MphuCUCo=;
        b=FDm9xHh4uzjI+xv+2D4L4CbDtIDiH0fPLhQVCkijHgNOej1fL8YdRGnr0k9p4hEg/e
         RpD/EV6otStcbWvj7cifdYSnUu3UOnbPB/Bcwd2vlz0MIMabIkHEhkhcoel4PDea3gL/
         9kZN/okb8dmGGPZngJjIz+J84j7YSkJmPPD/nVF9ClE070EBbsBkMfJJSR6v3D1epUBl
         3z8CLmGY/RY44YWdA9ZyztooES6kyDRotWGdjK7ZQ6UwYK9jLTBaour30ZCeQLW/uYzc
         99spm7A/M2gqI5ROE4P9dmcO5z/3xm+m1W8YztsG5UAYTqu3W9Ld8w4UvqDeeyzxSHiU
         ygrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DF2/eLTFuB8N9fv1SG404jyibEGpFwRqzB5MphuCUCo=;
        b=az6dL3WT4Eq/cV6GQ6rAHgcHVbFkbVKOkmKfR5RU2h+ps3LYC4JPIOyP8HglJoclVR
         /gSSPgBdMak8/udiZFFR1wK33L6pGdXSXlinxHHiVXLqJ79ek+6XSJZn9FBMvRF/ZWg4
         Ve8bXUsbjZkcmGQmmy7/8MwKnIrjl6fQhLb0uW+9zsaIMy/c42P8c5g25iUx4jFU7A9I
         iMi1xiQqE0CH4T3UiI2hRrgGcd+OwDlIn5L6FFlsU4sIZQLXK5iXEAh/8PzI2z1/IYnh
         Tomsf5bO04K6TKt5yOZndpmHnX5fKskcRoxYObCblqgc3ExyHe1noWATYHG6F/X+aGjQ
         N6Ew==
X-Gm-Message-State: AOAM530qcm8Kgn7lzGTwKft6I8cG+5V75yHGwfzoJMYEuxdrzoVQmXDL
        atagZCTh+pJ1FRme1ZjRMvPJSThwlgVDCuGhRpW4PA==
X-Google-Smtp-Source: ABdhPJye/8Mf9eEEdorCA613tHzKBM/brDodk4qDkUtGbl4/OXToAm0ni/zu9Tqrhk385KSgafVT37P6LIir30k313I=
X-Received: by 2002:a05:6402:64b:: with SMTP id u11mr3617070edx.147.1601324857889;
 Mon, 28 Sep 2020 13:27:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAPGftE8ipAacAnm9xMHFabXCL-XrCXGmOsX-Nsjvz9wnh3Zx-w@mail.gmail.com>
 <9e99c5301fbbb4f5f601b69816ee1dc9ab0df948.camel@linux.ibm.com>
 <CAEf4Bza9tZ-Jj0dj9Ne0fmxa95t=9XxxJR+Ce=6hDmw_d8uVFA@mail.gmail.com>
 <8cf42e2752e442bb54e988261d8bf3cd22ad00f2.camel@linux.ibm.com>
 <20200909142750.GC3788224@kernel.org> <CAPGftE8jNys9aVfUZW2iE5vB=QWKEmmwwWuWq9ek0ZXp-Aobkg@mail.gmail.com>
 <CAEf4BzYDm3QOOgND9p+LR21bn98QMjE+VYspQSvi4ebG9EdW0g@mail.gmail.com> <CAEf4Bzb7LZX8Y=qKpO5j3eUYU=tJzvNRYd1CdXXxq8Y-V4=+Vw@mail.gmail.com>
In-Reply-To: <CAEf4Bzb7LZX8Y=qKpO5j3eUYU=tJzvNRYd1CdXXxq8Y-V4=+Vw@mail.gmail.com>
From:   Luka Perkov <luka.perkov@sartura.hr>
Date:   Mon, 28 Sep 2020 22:27:27 +0200
Message-ID: <CAKQ-crg3qdQ6=STwQd5NrWWdQSpuKQptUMfZU50sYATfkqf1cw@mail.gmail.com>
Subject: Re: Problem with endianess of pahole BTF output for vmlinux
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Tony Ambardar <tony.ambardar@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        bpf <bpf@vger.kernel.org>, dwarves@vger.kernel.org,
        David Marcinkovic <david.marcinkovic@sartura.hr>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>,
        Jakov Petrina <jakov.petrina@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Hello Andrii,

On Mon, Sep 28, 2020 at 10:19 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> Question to folks that are working with 32-bit and/or big-endian
> architectures. Do you guys have an VM image that you'd be able to
> share with me, such that I can use it with qemu to test patches like
> this. My normal setup is all 64-bit/little-endian, so testing changes
> like this (and a few more I'm planning to do to address mixed 32-bit
> on the host vs 64-bit in BPF cases) is a bit problematic. And it's
> hard to get superpumped about spending lots of time setting up a new
> Linux image (never goes easy or fast for me).
>
> So, if you do have something like this, please share. Thank you!

We thought this would be an issue and we have been working on this but
didn't finalize it yet.

We'll speed it up and send you an easy way to replicate the
development environment.

Luka and Juraj will also share some of our additional findings
regarding 32bit ARM.

Thanks,
Luka
