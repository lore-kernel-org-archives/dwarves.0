Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D51AC433DB
	for <linux-dwarves@archiver.kernel.org>; Tue,  9 Feb 2021 15:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B858A64DB2
	for <linux-dwarves@archiver.kernel.org>; Tue,  9 Feb 2021 15:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbhBIPAt (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 9 Feb 2021 10:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbhBIPAs (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 9 Feb 2021 10:00:48 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99D7C061786
        for <dwarves@vger.kernel.org>; Tue,  9 Feb 2021 07:00:07 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id v66so1135150vkd.10
        for <dwarves@vger.kernel.org>; Tue, 09 Feb 2021 07:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jd+gJhImGti6AIxVxWopyTw6UqxPWnjSI4DVjzLVR6E=;
        b=lhR17nSUvinlmhCvYsz4FY3B4Cux7AooHwG8g85itqORb23kJY5eUqx9oyl48r5eLh
         boUM7BDlBB7wxXTbsEV53hsYbfHdW0eyEMJ2p25eOxHyoX59yA+kJDX2VuRRtAOVeoTf
         rlcQDr2DRJccAT61zXVUQMZxGyaYEo0UE6XOhMRTmZr5lwJHNKIkqLMtm5WoATGP6Vzm
         p91v4xwGkb1x+HK0tOI7DmH3xJkiBo+hmq8kVWYxvj29fCE7rmGwX/pf6c/va4zfuMd+
         soRqDJ1VvEzqEeVBUNpKR5hN/uLb0FvbJV6WA9U7uwJVH6zbxodOhJV4Er3YsEu7nrXw
         MJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jd+gJhImGti6AIxVxWopyTw6UqxPWnjSI4DVjzLVR6E=;
        b=abBDkxQ6NHP09j1+41YlIEwNfby2sp2LVQ/MiUPUeLp2RaW/6Zijsue0atClbCQHTb
         8VMtY0nO2PEJ6kEWybL0MCGROgOkFSktzA8klNAorrhpm+pe/pyI+Q2tWlhqkJFi2VRY
         fX8UDoDmYtgPlsShR56fjNQYxE+vldXjT5EGdAj3liJp20S0GxOWQRGVEVmVZrHRhyb+
         C16+fWsrd59rDVOBcKqGitPoKd91gr9VZiHTOtMqUCXzJiw5Kb4JvtVm9mbebEtE9rxD
         7afxVsvy4X6Oe7HjC/Sn36gcSU16m1SjJqCUajqYcr6P7WsZNLZZb9LNSiHB6igHBn0d
         5trw==
X-Gm-Message-State: AOAM530jDnA6XJKbRQ0HxyBlnoZa3UODDDGy4b/vSw0krNGlDBlRXGVc
        QAwZWXJpeBVhTykmepJMIhZbODfbo7dUYBw7HputiZ7AJe8=
X-Google-Smtp-Source: ABdhPJwCXA67wkBZYKXdc5emZFkSgv8Nh7HAp1gBxOUzQFi0CDeSDV67fYa2ntCR/sQVc9ITAFS/B/ebtYsaq0mnkho=
X-Received: by 2002:a1f:a2c2:: with SMTP id l185mr7701802vke.2.1612882806910;
 Tue, 09 Feb 2021 07:00:06 -0800 (PST)
MIME-Version: 1.0
References: <20210201172530.1141087-1-gprocida@google.com> <20210205134221.2953163-1-gprocida@google.com>
 <20210205134221.2953163-4-gprocida@google.com> <CAEf4BzY4URifNvvFFyM2KYURh0c7-=ftHfyR5AxXGE_ZMDMy2Q@mail.gmail.com>
In-Reply-To: <CAEf4BzY4URifNvvFFyM2KYURh0c7-=ftHfyR5AxXGE_ZMDMy2Q@mail.gmail.com>
From:   Giuliano Procida <gprocida@google.com>
Date:   Tue, 9 Feb 2021 14:59:32 +0000
Message-ID: <CAGvU0H=gExkUbp4HXi==SoFe0JKgnC-VKBv0a0jEsrzV=eKJJA@mail.gmail.com>
Subject: Re: [PATCH dwarves v3 3/5] btf_encoder: Traverse sections using a for-loop
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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

On Mon, 8 Feb 2021 at 22:24, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Feb 5, 2021 at 5:42 AM Giuliano Procida <gprocida@google.com> wrote:
> >
> > The pointer (iterator) scn can be made local to the loop and a more
> > general while-loop is not needed.
> >
> > Signed-off-by: Giuliano Procida <gprocida@google.com>
> > ---
> >  libbtf.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/libbtf.c b/libbtf.c
> > index ace8896..4ae7150 100644
> > --- a/libbtf.c
> > +++ b/libbtf.c
> > @@ -700,7 +700,6 @@ static int btf_elf__write(const char *filename, struct btf *btf)
> >  {
> >         GElf_Ehdr ehdr;
> >         Elf_Data *btf_data = NULL;
> > -       Elf_Scn *scn = NULL;
> >         Elf *elf = NULL;
> >         const void *raw_btf_data;
> >         uint32_t raw_btf_size;
> > @@ -748,7 +747,7 @@ static int btf_elf__write(const char *filename, struct btf *btf)
> >          */
> >
> >         elf_getshdrstrndx(elf, &strndx);
> > -       while ((scn = elf_nextscn(elf, scn)) != NULL) {
>
> this is pretty "canonical" as far as libelf usage goes, I wouldn't
> touch this code, but it's up to Arnaldo
>

Ack.
In an intermediate version of the code, I got bitten when I used scn
by mistake instead of another pointer.
This wouldn't have compiled if scn had been scoped to the loop.

Giuliano.

>
> > +       for (Elf_Scn *scn = elf_nextscn(elf, NULL); scn; scn = elf_nextscn(elf, scn)) {
> >                 GElf_Shdr shdr;
> >                 if (!gelf_getshdr(scn, &shdr))
> >                         continue;
> > --
> > 2.30.0.478.g8a0d178c01-goog
> >
