Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4407AC433E6
	for <linux-dwarves@archiver.kernel.org>; Wed, 27 Jan 2021 04:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07E3A20709
	for <linux-dwarves@archiver.kernel.org>; Wed, 27 Jan 2021 04:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343638AbhA0EUt (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 26 Jan 2021 23:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S317668AbhA0BMu (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 26 Jan 2021 20:12:50 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21085C061574
        for <dwarves@vger.kernel.org>; Tue, 26 Jan 2021 17:11:18 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id k22so200707ual.0
        for <dwarves@vger.kernel.org>; Tue, 26 Jan 2021 17:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sy4DPtbk4kdU94XXdxoQUPQpfIoQqtYk3SL5LWyKtwE=;
        b=gaZ3K2sJv306H70bkAr+1zdQmm/uw0+A0jGvI8iLti5iMO2s4Q9BXOF1b+GLAG032Z
         4v+QsLrk4RbZkKB7W+2sXvKecOCWTX0FfDRmtp2VZWX6Jz0NsuP3Sdww2yLXFUsd6qp+
         mjMaw12WT9jkva+Hq7eSG02jjMyyhc6dqrWwZq1kgn9YwOVcNGpY+x/mYkBgjPbKn5Lj
         Jw7qlHvsr3Miy2cgYhgyv+3+SCcDB4nNo1CVH4+lqf5KRMjF7doqi14dAJudkru/dV01
         5B4HdphZRgzIR/SYYagMvv/xUwKOApu7DBoVvjh5pCx0+iwPwU8dTRtr54L0zVK1nhcq
         02Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sy4DPtbk4kdU94XXdxoQUPQpfIoQqtYk3SL5LWyKtwE=;
        b=Krvu30wSzXP+7MHtej0DBORz17thJNpPQbcwJSbtOUQCtW0m6Km6sYlCkc9Pp8RaS9
         lSiD5v1fPtFO883gP6fW6C0G01O5OpSCJKhVkIQhfnpbPljfKmkT9HJkP8SqeXB2Ei/r
         2u5lSCJkjkYhoRaJa6L0iONq4XCDcMM+rmMtaOm3LVFcV56qSLNxrWEHhYxHf3ZKc1pN
         nNlmvi5OEylrueYek/jEtBhbKLEW+7dw3oCYqb34oboQ9ZMMx68h5/aoJW/CQXIZBhuT
         Ei7TWSeJXi1S5v34VvVK4XNyik0dh5V85OK+7m9zUpVCNIFdvNtK3bOwSmsDvTnRXPuh
         zrpw==
X-Gm-Message-State: AOAM532OAQNZAeOpxpsjYeB36OxMYGJd8wgLqpb3wrmej8bo0QeND/xL
        dE66mWHYi9vvaF6ihukCX926S4qr5G87N4f3Q+dzplhbF0q6FA==
X-Google-Smtp-Source: ABdhPJz/YC6DfVHyoNFtk2FYryoau+UyvFitsxeyrfgIC/iovFXBUyb7M+DmLlO8RIpgjYOcQiU9C9E3hjRlzAR/IGU=
X-Received: by 2002:ab0:6654:: with SMTP id b20mr6697997uaq.49.1611709876951;
 Tue, 26 Jan 2021 17:11:16 -0800 (PST)
MIME-Version: 1.0
References: <20210125130625.2030186-1-gprocida@google.com> <20210126195542.GB120879@krava>
In-Reply-To: <20210126195542.GB120879@krava>
From:   Giuliano Procida <gprocida@google.com>
Date:   Wed, 27 Jan 2021 01:10:40 +0000
Message-ID: <CAGvU0H=CFBmGeNx_4zJt9ou8r31knPcq0doOi-3p5JqnaQbp7w@mail.gmail.com>
Subject: Re: [PATCH dwarves 0/4] BTF ELF writing changes
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     dwarves@vger.kernel.org, acme@kernel.org,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        =?UTF-8?Q?Matthias_M=C3=A4nnich?= <maennich@google.com>,
        kernel-team@android.com, Kernel Team <kernel-team@fb.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Hi.

On Tue, 26 Jan 2021 at 19:56, Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Mon, Jan 25, 2021 at 01:06:21PM +0000, Giuliano Procida wrote:
> > Hi.
> >
> > This follows on from my change to improve the error handling around
> > llvm-objcopy in libbtf.c.
> >
> > Note on recipients: Please let me know if I should adjust To or CC.
> >
> > Note on style: I've generally placed declarations as allowed by C99,
> > closest to point of use. Let me know if you'd prefer otherwise.
> >
> > 1. Improve ELF error reporting
> >
> > 2. Add .BTF section using libelf
> >
> > This shows the minimal amount of code needed to drive libelf. However,
> > it leaves layout up to libelf, which is almost certainly not wanted.
> >
> > As an unexpcted side-effect, vmlinux is larger than before. It seems
> > llvm-objcopy likes to trim down .strtab.
> >
> > 3. Manually lay out updated ELF sections
> >
> > This does full layout of new and updated ELF sections. If the update
> > ELF sections were not the last ones in the file by offset, then it can
> > leave gaps between sections.
> >
> > 4. Align .BTF section to 8 bytes
> >
> > This was my original aim.
> >
> > Regards.
> >
> > Giuliano Procida (4):
> >   btf_encoder: Improve ELF error reporting
> >   btf_encoder: Add .BTF section using libelf
> >   btf_encoder: Manually lay out updated ELF sections
> >   btf_encoder: Align .BTF section to 8 bytes
>
> hi,
> I can't apply this on dwarves git master, which commit is it based on?
>

It's based on:
https://www.spinics.net/lists/dwarves/msg00775.html (0/3)
https://www.spinics.net/lists/dwarves/msg00774.html (1/3, unrelated fix)
https://www.spinics.net/lists/dwarves/msg00773.html (2/3, this is the
one you'll need for a clean git am; obsoleted by this new series)
(3/3 was abandoned)

Arnaldo did say the two commits were applied... but perhaps they
haven't been pushed to public master yet.

> thanks,
> jirka
>

You're welcome.
Giuliano.

> >
> >  libbtf.c | 222 +++++++++++++++++++++++++++++++++++++++++++------------
> >  1 file changed, 175 insertions(+), 47 deletions(-)
> >
> > --
> > 2.30.0.280.ga3ce27912f-goog
> >
>
