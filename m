Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F920C4321E
	for <linux-dwarves@archiver.kernel.org>; Thu,  1 Dec 2022 00:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiLAAWA (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 30 Nov 2022 19:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiLAAVx (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 30 Nov 2022 19:21:53 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9243E312
        for <dwarves@vger.kernel.org>; Wed, 30 Nov 2022 16:21:52 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id ml11so488873ejb.6
        for <dwarves@vger.kernel.org>; Wed, 30 Nov 2022 16:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GN/bRnKnyQmJSnzkdXsefrtEhKt+qvjyhvTvw3J3Qhg=;
        b=SlETqOv6rIfB/ezujK0umF6k/tmvquHYxmhQo/mMs27PUKscWTTWyIt6z1hpW9Sxye
         y8e+nJsvV8MjqVtHQrdLrYtyERbCotACiumDmQytJACmbZ/Pg+DX7FUQmjH4Kg0FK0pv
         kv3QN5FAfWRwzFvyPZu9N5lb6qbhdJ4wMGYrL4VzMQ2zrG7aQa5tdr3S68F3pLjhOZxa
         dnQe0maNAX8xkOe35v2Os95rVuem7d7BPBki33MYo6/O1Sy10bEgoz0wJDuXYdCJTobj
         TJAnVTkrmacCFNianZvV7jIPrFjk1K9+3LvlExgss4OixjnRgRYxfpex04ct5roiKnH6
         m1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GN/bRnKnyQmJSnzkdXsefrtEhKt+qvjyhvTvw3J3Qhg=;
        b=OmsblFy+0DwQCOMEApfJUgEQsXRczOo9dF5U6m4ffYTn5DK4olnINSUOd/N7PMBCLA
         972S8O4KXKIP4X6tg8Ei9WKhDwUSmpxjK/bNtfmw4Uh0us/UrNUbtviZ8a+iRDiGnrfB
         ax4D8vj8ND+NJZJ7T1qcDFToJHjPL0/wxPHJWySv/KSaaTbMNMtmv581fUEmQzrJZNTL
         u8eNdCYyI9elemHr8I9uXQi+jDfS5Q11O6cfKrmIpB50LgGC3l5p2Q+asfypYFher6Hz
         keMeJM0AsMhqiopPQWF8snxcmTfc2VARjBe5d/j/bUwQkfKLqRu0bXhmnh2PpbpklowE
         S8qw==
X-Gm-Message-State: ANoB5plH7aUVpVXvI7nMMdPWEYNOCGnXVTBBjrmEQpTZrOzx7J0BWQgq
        +xZKsRmN4CXfzNeMr2iX+/ZTIjtwKHX7lYW0BhuD3nwNoSPh
X-Google-Smtp-Source: AA0mqf5HondScvdRKj4CTUXhOsUedDuSR9L3FjK6DA+E1Hfz5GuK/R1QG+E5bxTFdnMQy44oV6cWUC2BkTuaSgp0dUQ=
X-Received: by 2002:a17:906:a387:b0:7bc:2ad:7c1e with SMTP id
 k7-20020a170906a38700b007bc02ad7c1emr27342712ejz.588.1669854111018; Wed, 30
 Nov 2022 16:21:51 -0800 (PST)
MIME-Version: 1.0
References: <20221122000011.241697-1-morbo@google.com> <20221122000011.241697-2-morbo@google.com>
 <CAEf4BzYiHx0gAgJsam4usy23UTGwN-a-nyJa2+jzG+RzUFiWEQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYiHx0gAgJsam4usy23UTGwN-a-nyJa2+jzG+RzUFiWEQ@mail.gmail.com>
From:   Bill Wendling <morbo@google.com>
Date:   Wed, 30 Nov 2022 16:21:34 -0800
Message-ID: <CAGG=3QWGAepDQmSxarrMENOX79srigF48xYOsOjOPO-YuvFr1g@mail.gmail.com>
Subject: Re: [PATCH 1/1] btf_encoder: Generate a new .BTF section even if one exists
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     dwarves@vger.kernel.org, Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Wed, Nov 30, 2022 at 2:59 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Nov 21, 2022 at 4:00 PM Bill Wendling <morbo@google.com> wrote:
> >
> > LLD generates a zero-length .BTF section (BFD doesn't generate this
> > section). It shares the same address as .BTF_ids (or any section below
> > it). E.g.:
> >
> >   [24] .BTF              PROGBITS        ffffffff825a1900 17a1900 000000
> >   [25] .BTF_ids          PROGBITS        ffffffff825a1900 17a1900 000634
> >
> > Writing new data to that section doesn't adjust the addresses of
> > following sections. As a result, the "-J" flag produces a corrupted
> > file, causing further commands to fail.
> >
> > Instead of trying to adjust everything, just add a new section with the
> > .BTF data and adjust the name of the original .BTF section. (We can't
> > remove the old .BTF section because it has variables that are referenced
> > elsewhere.)
> >
>
> Have you tried llvm-objcopy --update-section instead? Doesn't it work?
>
I gave it a quick try and it fails for me with this:

llvm-objcopy: error: '.tmp_vmlinux.btf': cannot fit data of size
4470718 into section '.BTF' with size 0 that is part of a segment
btf_encoder__write_elf: failed to add .BTF section to '.tmp_vmlinux.btf': 2!
Failed to encode BTF

-bw

> > Link: https://lore.kernel.org/dwarves/20210317232657.mdnsuoqx6nbddjgt@google.com/
> > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Cc: Fangrui Song <maskray@google.com>
> > Cc: dwarves@vger.kernel.org
> > Signed-off-by: Bill Wendling <morbo@google.com>
> > ---
> >  btf_encoder.c | 88 +++++++++++++++++++++++++++++++--------------------
> >  1 file changed, 54 insertions(+), 34 deletions(-)
> >
> > diff --git a/btf_encoder.c b/btf_encoder.c
> > index a5fa04a84ee2..bd1ce63e992c 100644
> > --- a/btf_encoder.c
> > +++ b/btf_encoder.c
> > @@ -1039,6 +1039,9 @@ static int btf_encoder__write_elf(struct btf_encoder *encoder)
> >         Elf_Data *btf_data = NULL;
> >         Elf_Scn *scn = NULL;
> >         Elf *elf = NULL;
> > +       const char *llvm_objcopy;
> > +       char tmp_fn[PATH_MAX];
> > +       char cmd[PATH_MAX * 2];
> >         const void *raw_btf_data;
> >         uint32_t raw_btf_size;
> >         int fd, err = -1;
> > @@ -1081,42 +1084,58 @@ static int btf_encoder__write_elf(struct btf_encoder *encoder)
> >
> >         raw_btf_data = btf__raw_data(btf, &raw_btf_size);
> >
> > +       llvm_objcopy = getenv("LLVM_OBJCOPY");
> > +       if (!llvm_objcopy)
> > +               llvm_objcopy = "llvm-objcopy";
> > +
> > +       /* Use objcopy to add a .BTF section */
> > +       snprintf(tmp_fn, sizeof(tmp_fn), "%s.btf", filename);
> > +       close(fd);
> > +       fd = creat(tmp_fn, S_IRUSR | S_IWUSR);
> > +       if (fd == -1) {
> > +               fprintf(stderr, "%s: open(%s) failed!\n", __func__,
> > +                       tmp_fn);
> > +               goto out;
> > +       }
> > +
> > +       if (write(fd, raw_btf_data, raw_btf_size) != raw_btf_size) {
> > +               fprintf(stderr, "%s: write of %d bytes to '%s' failed: %d!\n",
> > +                       __func__, raw_btf_size, tmp_fn, errno);
> > +               goto unlink;
> > +       }
> > +
> >         if (btf_data) {
> > -               /* Existing .BTF section found */
> > -               btf_data->d_buf = (void *)raw_btf_data;
> > -               btf_data->d_size = raw_btf_size;
> > -               elf_flagdata(btf_data, ELF_C_SET, ELF_F_DIRTY);
> > -
> > -               if (elf_update(elf, ELF_C_NULL) >= 0 &&
> > -                   elf_update(elf, ELF_C_WRITE) >= 0)
> > -                       err = 0;
> > -               else
> > -                       elf_error("elf_update failed");
> > -       } else {
> > -               const char *llvm_objcopy;
> > -               char tmp_fn[PATH_MAX];
> > -               char cmd[PATH_MAX * 2];
> > -
> > -               llvm_objcopy = getenv("LLVM_OBJCOPY");
> > -               if (!llvm_objcopy)
> > -                       llvm_objcopy = "llvm-objcopy";
> > -
> > -               /* Use objcopy to add a .BTF section */
> > -               snprintf(tmp_fn, sizeof(tmp_fn), "%s.btf", filename);
> > -               close(fd);
> > -               fd = creat(tmp_fn, S_IRUSR | S_IWUSR);
> > -               if (fd == -1) {
> > -                       fprintf(stderr, "%s: open(%s) failed!\n", __func__,
> > -                               tmp_fn);
> > -                       goto out;
> > -               }
> > -
> > -               if (write(fd, raw_btf_data, raw_btf_size) != raw_btf_size) {
> > -                       fprintf(stderr, "%s: write of %d bytes to '%s' failed: %d!\n",
> > -                               __func__, raw_btf_size, tmp_fn, errno);
> > +               /*
> > +                * Existing .BTF section found. LLD creates a zero-sized .BTF
> > +                * section. Adding data to that section doesn't change the
> > +                * addresses of the other sections, causing an overwriting of
> > +                * data. These commands are a bit convoluted, but they will add
> > +                * a new .BTF section with the proper size. Note though that
> > +                * the __start_btf and __stop_btf variables aren't affected by
> > +                * this change, but then they aren't added when using
> > +                * "--add-section" either.
> > +                */
> > +               snprintf(cmd, sizeof(cmd),
> > +                        "%s --add-section .BTF.new=%s "
> > +                        "--rename-section .BTF=.BTF.old %s",
> > +                        llvm_objcopy, tmp_fn, filename);
> > +               if (system(cmd)) {
> > +                       fprintf(stderr, "%s: failed to add .BTF section to '%s': %d!\n",
> > +                               __func__, filename, errno);
> >                         goto unlink;
> >                 }
> >
> > +               snprintf(cmd, sizeof(cmd),
> > +                        "%s --rename-section .BTF.new=.BTF %s",
> > +                        llvm_objcopy, filename);
> > +               if (system(cmd)) {
> > +                       fprintf(stderr, "%s: failed to rename .BTF section to '%s': %d!\n",
> > +                               __func__, filename, errno);
> > +                       goto unlink;
> > +               }
> > +
> > +               err = 0;
> > +       } else {
> >                 snprintf(cmd, sizeof(cmd), "%s --add-section .BTF=%s %s",
> >                          llvm_objcopy, tmp_fn, filename);
> >                 if (system(cmd)) {
> > @@ -1126,10 +1145,11 @@ static int btf_encoder__write_elf(struct btf_encoder *encoder)
> >                 }
> >
> >                 err = 0;
> > -       unlink:
> > -               unlink(tmp_fn);
> >         }
> >
> > +unlink:
> > +       unlink(tmp_fn);
> > +
> >  out:
> >         if (fd != -1)
> >                 close(fd);
> > --
> > 2.38.1.584.g0f3c55d4c2-goog
> >
