Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2128C2D0E4
	for <linux-dwarves@archiver.kernel.org>; Fri, 13 Nov 2020 00:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 443E120872
	for <linux-dwarves@archiver.kernel.org>; Fri, 13 Nov 2020 00:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLqrQTHA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgKMATO (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 12 Nov 2020 19:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgKMATO (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 12 Nov 2020 19:19:14 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7FAC0613D1;
        Thu, 12 Nov 2020 16:19:14 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id u19so4998696lfr.7;
        Thu, 12 Nov 2020 16:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8+EhPURcwXDDViDE8V4qn4s0OiNQavdZ3Q7QsK4dz9Y=;
        b=QLqrQTHAv9tfoJG6fzLQ5v1zo4IZH17XARj4bWb+J7XgDw/Gl3W5G7Ma0ouPu16ST9
         APQn3ly9hbh4A//jCQdaridcd8C1nRJxvksoby+MBlpyy99/qp71ZLh6zw3V8618BIqT
         cE9JM//E3IJqY8WNSGpbivQktoW/Y1stamWiRk5Ph3O3VZL9gRlWJ+So1c2ARsS1PRj0
         cEsdaGcH7By0XOFhud8cT4HXZINA6rvKpa2LjlnbAwlVPCUsMMwKTiyEJbKhTQb912K4
         6txBjIVYYoXqYnUax1afd/LFQU5ZhJaA//qNq/qOmIlEQmGTiXpilOQyWFGWeryAi9RR
         K/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8+EhPURcwXDDViDE8V4qn4s0OiNQavdZ3Q7QsK4dz9Y=;
        b=FsraKHDkMMJhur1x0p+69DOJurgy9QgP8w2Hjr3COAIOv2i53SqpzlHpAhwsw8RFr1
         NAxUru7VucvK2eYQSk8IkZ+WZfuMXRzJqFmYraxXWGVsqLxLLqh3B1YjVPFWHF9/fbdA
         GVQ32z/BVfDG3708JfFd0sAv2xM2+V6AsnjB5y1jZKabbYntjRwxhbCq8CwxzDiTcUny
         jei0iULSs473zmr1VK6mtuH2C1ZFChCsAms8Dd+5O/uBxNjnO5+BGTXTTw/zy8Atgmr/
         yBLTr650hi43U7VAQWrt7qlEPH9CXovINN7oi33K5aBQcgBaNtCF/8Y+1smateOSWDaE
         u6ow==
X-Gm-Message-State: AOAM533FUPmeVZYVRfu2QaAfh5Wd6P+y6bRIM5m+O3b0N1m7zz8fl8oJ
        bGfV8wpVxw5v84jYe4XQik7PxYX3lSCkziLOyPVDkz4z
X-Google-Smtp-Source: ABdhPJxtec1GnCnV5aOkDvwqqgjBWJcBwt0dGvmgDUcZPfTrjtQ+0Gxwvc56gXHUXITIwmErnHY2NiibuvFU7UQIjx4=
X-Received: by 2002:a05:6512:3049:: with SMTP id b9mr688294lfb.554.1605226750897;
 Thu, 12 Nov 2020 16:19:10 -0800 (PST)
MIME-Version: 1.0
References: <20201112150506.705430-1-jolsa@kernel.org> <20201112150506.705430-4-jolsa@kernel.org>
 <CAEf4BzbhojeSdASwt4y4XEtgAF1caYx=-AuwzWJZv7qKgzkroA@mail.gmail.com>
 <20201112211413.GA733055@krava> <CAEf4BzbePw8gksT0MH=hwp4Pv1EV1-MOeiwfoFVR64XWFccTHw@mail.gmail.com>
In-Reply-To: <CAEf4BzbePw8gksT0MH=hwp4Pv1EV1-MOeiwfoFVR64XWFccTHw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 12 Nov 2020 16:18:59 -0800
Message-ID: <CAADnVQKUYFE0vE3XZB0FPNMxw_+BNpOLJ37QJ+CxLbssDPHFdw@mail.gmail.com>
Subject: Re: [RFC/PATCH 3/3] btf_encoder: Func generation fix
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Thu, Nov 12, 2020 at 4:08 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> So I looked at your vmlinux image. I think we should just keep
> everything mostly as it it right now (without changes in this patch),
> but add just two simple checks:
>
> 1. Skip if fn->declaration (ignore correctly marked func declarations)
> 2. Skip if DW_AT_inline: 1 (ignore inlined functions).
>
> I'd keep the named arguments check as is, I think it's helpful. 1)
> will skip stuff that's explicitly marked as declaration. 2) inline
> check will partially mitigate dropping of fn->external check (and we
> can't really attach to inlined functions).

I thought DW_AT_inline is an indication that the function was marked "inline"
in C code. That doesn't mean that the function was actually inlined.
So I don't think pahole should check that bit.
