Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BF4C352A1
	for <linux-dwarves@archiver.kernel.org>; Tue,  6 Dec 2022 20:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiLFUP4 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 6 Dec 2022 15:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiLFUPY (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 6 Dec 2022 15:15:24 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1992A442DF
        for <dwarves@vger.kernel.org>; Tue,  6 Dec 2022 12:15:22 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id vv4so9151897ejc.2
        for <dwarves@vger.kernel.org>; Tue, 06 Dec 2022 12:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Njq/u0oMailFL/8o6kjINwbn5z9cxe0cFHZxDHsAGWc=;
        b=LgLXBI65maOinyHbjcoBi3ixBBAWaEUqRubsllxIJIDk7uL5uRxv1rp1qtaNBuSjge
         43Ff3X6ueFA/BXKLmrKB4KQ7vJEJfLSDH2Yvu7TTwrAo+aUB/W7ZoSzL4+0YPpGJUeDK
         VQBbKEB6cPXfa+vjECBRum0KcmV++UdJr4SHlPppL3ubitGfzi5o2jK/vaeAnLoD6Z4w
         Stw3nmRqXrNZ8OFkiwr/aodrEPhBe8KIowMetEk5W1MhXMTZ90ir2X44q8Gais0WOMLr
         2Vt8G6Uj32Wwz3xof90kvoMmHev2s86YTAyOjkk6mW/dRnHVgOoGXC8NVBOMevs7EIAt
         3/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Njq/u0oMailFL/8o6kjINwbn5z9cxe0cFHZxDHsAGWc=;
        b=Wr/mRKK69jLW5eaVqTHvMQeesfu+lVd3laVuLNHlUo+prSRSV17pEM0Z8Pap05SLgL
         EYXCf7HzN80fOSuzltqpE+4M9QGtBU7nWNKkrjewsNbiW6nsXk1MVwIEvN4h3m/CHx9B
         A78kSe3Ts3yYzjIsBnRYdjhmwuAZgTLSEiQijcCR7GgodGemygzVhkYjI0KFsK+XvWmY
         JCNwStw0WEzhWEA3EIOyt2tbW4i4pMSXNtBAiztmObRmrXm2/fSL38yK9PpQ1o7Dulp6
         p1CfF4CSUqEFQ23VpxWHe8CXYBwz/nuPtYnKKiUvtAJXBiu5RhqMao45lono7DSKvAOy
         j/6A==
X-Gm-Message-State: ANoB5pl8MUifrLueZ6Tw30KFpZeBA7JvmJRqzbyVbpFh5SPaE7wueGOR
        31bmfCRVDVzGDc2E9fGPqEJw+1RqVcpetARGH/P1
X-Google-Smtp-Source: AA0mqf7c9/mJp+kAdQ0lZE+XPO7dyy3N93RBMQXCrktzrTkpSV8c/aN1hvkcItuo6nKuGzBGtmchh9K4R/I09rmRc7g=
X-Received: by 2002:a17:906:d8ab:b0:7c0:edcd:cf9d with SMTP id
 qc11-20020a170906d8ab00b007c0edcdcf9dmr10061805ejb.269.1670357720393; Tue, 06
 Dec 2022 12:15:20 -0800 (PST)
MIME-Version: 1.0
References: <20221122000011.241697-1-morbo@google.com> <20221122000011.241697-2-morbo@google.com>
 <CAEf4BzYiHx0gAgJsam4usy23UTGwN-a-nyJa2+jzG+RzUFiWEQ@mail.gmail.com>
 <CAGG=3QWGAepDQmSxarrMENOX79srigF48xYOsOjOPO-YuvFr1g@mail.gmail.com>
 <CAEf4Bzb38BXEL_mKuqRdUrvQVTXLH9TmOdwZbrVa_10YmdhoTw@mail.gmail.com>
 <CAGG=3QVC_qOFWRi4sf88Ct3Tz5_N6j_GUwj+Dk11Oi9AJYNm-A@mail.gmail.com> <CAEf4BzYs4h0ya7MbQ9P96293XkyW4ab3f+nYeJU6D=LFsrm6-w@mail.gmail.com>
In-Reply-To: <CAEf4BzYs4h0ya7MbQ9P96293XkyW4ab3f+nYeJU6D=LFsrm6-w@mail.gmail.com>
From:   Bill Wendling <morbo@google.com>
Date:   Tue, 6 Dec 2022 12:15:04 -0800
Message-ID: <CAGG=3QXVC-9tPT1KL0ze+5oWz=hpXsy+w=BJgSjokufmSP4eZQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] btf_encoder: Generate a new .BTF section even if one exists
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Tue, Dec 6, 2022 at 10:38 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Dec 1, 2022 at 12:20 PM Bill Wendling <morbo@google.com> wrote:
> >
> > On Thu, Dec 1, 2022 at 11:56 AM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Wed, Nov 30, 2022 at 4:21 PM Bill Wendling <morbo@google.com> wrote:
> > > >
> > > > On Wed, Nov 30, 2022 at 2:59 PM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > On Mon, Nov 21, 2022 at 4:00 PM Bill Wendling <morbo@google.com> wrote:
> > > > > >
> > > > > > LLD generates a zero-length .BTF section (BFD doesn't generate this
> > > > > > section). It shares the same address as .BTF_ids (or any section below
> > > > > > it). E.g.:
> > > > > >
> > > > > >   [24] .BTF              PROGBITS        ffffffff825a1900 17a1900 000000
> > > > > >   [25] .BTF_ids          PROGBITS        ffffffff825a1900 17a1900 000634
> > > > > >
> > > > > > Writing new data to that section doesn't adjust the addresses of
> > > > > > following sections. As a result, the "-J" flag produces a corrupted
> > > > > > file, causing further commands to fail.
> > > > > >
> > > > > > Instead of trying to adjust everything, just add a new section with the
> > > > > > .BTF data and adjust the name of the original .BTF section. (We can't
> > > > > > remove the old .BTF section because it has variables that are referenced
> > > > > > elsewhere.)
> > > > > >
> > > > >
> > > > > Have you tried llvm-objcopy --update-section instead? Doesn't it work?
> > > > >
> > > > I gave it a quick try and it fails for me with this:
> > > >
> > > > llvm-objcopy: error: '.tmp_vmlinux.btf': cannot fit data of size
> > > > 4470718 into section '.BTF' with size 0 that is part of a segment
> > >
> > > .BTF shouldn't be allocatable section, when added by pahole. I think
> > > this is the problem. Can you confirm that that zero-sized .BTF is
> > > marked as allocated and is put into one of ELF segments? Can we fix
> > > that instead?
> > >
> > I think it does:
> >
> > [24] .BTF              PROGBITS        ffffffff825a1900 17a1900 000000
> > 00  WA  0   0  1
> >
>
> So this allocatable .BTF section, could it be because of linker script
> in include/asm-generic/vmlinux.lds.h? Should we add some conditions
> there to not emit .BTF if __startt_BTF == __stop_BTF (i.e., no BTF
> data is present) to avoid this issue in the first place?
>
It looks like keeping the .BTF section around is intentional:

  commit 65c204398928 ("bpf: Prevent .BTF section elimination")

I assume that patch isn't meant if the section is zero sized...

I was able to get a working system with two patches: one to Linux and
one to pahole. The Linux patch specifies that the .BTF section
shouldn't be allocatable. The pahole patch uses --update-section if
the section exists rather than writing out a new ELF file. Thoughts?

Linux patch:

diff --git a/include/asm-generic/vmlinux.lds.h
b/include/asm-generic/vmlinux.lds.h
index 3dc5824141cd..5bea090b736e 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -680,7 +680,7 @@
  */
 #ifdef CONFIG_DEBUG_INFO_BTF
 #define BTF                                                            \
-       .BTF : AT(ADDR(.BTF) - LOAD_OFFSET) {                           \
+       .BTF (INFO) : AT(ADDR(.BTF) - LOAD_OFFSET) {                    \
                __start_BTF = .;                                        \
                KEEP(*(.BTF))                                           \
                __stop_BTF = .;                                         \

pahole patch:

diff --git a/btf_encoder.c b/btf_encoder.c
index a5fa04a84ee2..546d32aac4f1 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1040,6 +1040,9 @@ static int btf_encoder__write_elf(struct
btf_encoder *encoder)
        Elf_Scn *scn = NULL;
        Elf *elf = NULL;
        const void *raw_btf_data;
+       const char *llvm_objcopy;
+       char tmp_fn[PATH_MAX];
+       char cmd[PATH_MAX * 2];
        uint32_t raw_btf_size;
        int fd, err = -1;
        size_t strndx;
@@ -1081,55 +1084,44 @@ static int btf_encoder__write_elf(struct
btf_encoder *encoder)

        raw_btf_data = btf__raw_data(btf, &raw_btf_size);

+       llvm_objcopy = getenv("LLVM_OBJCOPY");
+       if (!llvm_objcopy)
+               llvm_objcopy = "llvm-objcopy";
+
+       /* Use objcopy to add a .BTF section */
+       snprintf(tmp_fn, sizeof(tmp_fn), "%s.btf", filename);
+       close(fd);
+       fd = creat(tmp_fn, S_IRUSR | S_IWUSR);
+       if (fd == -1) {
+               fprintf(stderr, "%s: open(%s) failed!\n", __func__,
+                       tmp_fn);
+               goto out;
+       }
+
+       if (write(fd, raw_btf_data, raw_btf_size) != raw_btf_size) {
+               fprintf(stderr, "%s: write of %d bytes to '%s' failed: %d!\n",
+                       __func__, raw_btf_size, tmp_fn, errno);
+               goto unlink;
+       }
+
        if (btf_data) {
-               /* Existing .BTF section found */
-               btf_data->d_buf = (void *)raw_btf_data;
-               btf_data->d_size = raw_btf_size;
-               elf_flagdata(btf_data, ELF_C_SET, ELF_F_DIRTY);
-
-               if (elf_update(elf, ELF_C_NULL) >= 0 &&
-                   elf_update(elf, ELF_C_WRITE) >= 0)
-                       err = 0;
-               else
-                       elf_error("elf_update failed");
+               snprintf(cmd, sizeof(cmd), "%s --update-section .BTF=%s %s",
+                        llvm_objcopy, tmp_fn, filename);
        } else {
-               const char *llvm_objcopy;
-               char tmp_fn[PATH_MAX];
-               char cmd[PATH_MAX * 2];
-
-               llvm_objcopy = getenv("LLVM_OBJCOPY");
-               if (!llvm_objcopy)
-                       llvm_objcopy = "llvm-objcopy";
-
-               /* Use objcopy to add a .BTF section */
-               snprintf(tmp_fn, sizeof(tmp_fn), "%s.btf", filename);
-               close(fd);
-               fd = creat(tmp_fn, S_IRUSR | S_IWUSR);
-               if (fd == -1) {
-                       fprintf(stderr, "%s: open(%s) failed!\n", __func__,
-                               tmp_fn);
-                       goto out;
-               }
-
-               if (write(fd, raw_btf_data, raw_btf_size) != raw_btf_size) {
-                       fprintf(stderr, "%s: write of %d bytes to '%s'
failed: %d!\n",
-                               __func__, raw_btf_size, tmp_fn, errno);
-                       goto unlink;
-               }
-
                snprintf(cmd, sizeof(cmd), "%s --add-section .BTF=%s %s",
                         llvm_objcopy, tmp_fn, filename);
-               if (system(cmd)) {
-                       fprintf(stderr, "%s: failed to add .BTF
section to '%s': %d!\n",
-                               __func__, filename, errno);
-                       goto unlink;
-               }
-
-               err = 0;
-       unlink:
-               unlink(tmp_fn);
        }

+       if (system(cmd)) {
+               fprintf(stderr, "%s: failed to add .BTF section to '%s': %d!\n",
+                       __func__, filename, errno);
+               goto unlink;
+       }
+
+       err = 0;
+unlink:
+       unlink(tmp_fn);
+
 out:
        if (fd != -1)
                close(fd);


> > Fangrui mentioned something similar to this in a previous message:
> >
> >   https://lore.kernel.org/dwarves/20210317232657.mdnsuoqx6nbddjgt@google.com/T/#u
> >
> > > Also, more generally, newer paholes (not that new anymore, it's been a
> > > supported feature for a while) support emitting BTF as raw binary
> > > files, instead of embedding them into ELF. I think this is a nicer and
> > > simpler option and we should switch link-vmlinux.sh to use that
> > > instead, if pahole is new enough.
> > >
> > > Hopefully eventually we can get rid of all the old pahole version
> > > cruft, but for now it's inevitable to support both modes, of course.
> > >
> >
> > Ah technical debt! :-)
>
> Yep, it would be good to get contributions to address it ;) It's
> better than hacks with renaming of sections, *wink wink* :)
>
;-)

-bw

> >
> > -bw
> >
> > > > btf_encoder__write_elf: failed to add .BTF section to '.tmp_vmlinux.btf': 2!
> > > > Failed to encode BTF
> > > >
> > > > -bw
> > > >
> > > > > > Link: https://lore.kernel.org/dwarves/20210317232657.mdnsuoqx6nbddjgt@google.com/
> > > > > > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > > > > Cc: Fangrui Song <maskray@google.com>
> > > > > > Cc: dwarves@vger.kernel.org
> > > > > > Signed-off-by: Bill Wendling <morbo@google.com>
> > > > > > ---
> > > > > >  btf_encoder.c | 88 +++++++++++++++++++++++++++++++--------------------
> > > > > >  1 file changed, 54 insertions(+), 34 deletions(-)
> > > > > >
> > > > > > diff --git a/btf_encoder.c b/btf_encoder.c
> > > > > > index a5fa04a84ee2..bd1ce63e992c 100644
> > > > > > --- a/btf_encoder.c
> > > > > > +++ b/btf_encoder.c
> > > > > > @@ -1039,6 +1039,9 @@ static int btf_encoder__write_elf(struct btf_encoder *encoder)
> > > > > >         Elf_Data *btf_data = NULL;
> > > > > >         Elf_Scn *scn = NULL;
> > > > > >         Elf *elf = NULL;
> > > > > > +       const char *llvm_objcopy;
> > > > > > +       char tmp_fn[PATH_MAX];
> > > > > > +       char cmd[PATH_MAX * 2];
> > > > > >         const void *raw_btf_data;
> > > > > >         uint32_t raw_btf_size;
> > > > > >         int fd, err = -1;
> > > > > > @@ -1081,42 +1084,58 @@ static int btf_encoder__write_elf(struct btf_encoder *encoder)
> > > > > >
> > > > > >         raw_btf_data = btf__raw_data(btf, &raw_btf_size);
> > > > > >
> > > > > > +       llvm_objcopy = getenv("LLVM_OBJCOPY");
> > > > > > +       if (!llvm_objcopy)
> > > > > > +               llvm_objcopy = "llvm-objcopy";
> > > > > > +
> > > > > > +       /* Use objcopy to add a .BTF section */
> > > > > > +       snprintf(tmp_fn, sizeof(tmp_fn), "%s.btf", filename);
> > > > > > +       close(fd);
> > > > > > +       fd = creat(tmp_fn, S_IRUSR | S_IWUSR);
> > > > > > +       if (fd == -1) {
> > > > > > +               fprintf(stderr, "%s: open(%s) failed!\n", __func__,
> > > > > > +                       tmp_fn);
> > > > > > +               goto out;
> > > > > > +       }
> > > > > > +
> > > > > > +       if (write(fd, raw_btf_data, raw_btf_size) != raw_btf_size) {
> > > > > > +               fprintf(stderr, "%s: write of %d bytes to '%s' failed: %d!\n",
> > > > > > +                       __func__, raw_btf_size, tmp_fn, errno);
> > > > > > +               goto unlink;
> > > > > > +       }
> > > > > > +
> > > > > >         if (btf_data) {
> > > > > > -               /* Existing .BTF section found */
> > > > > > -               btf_data->d_buf = (void *)raw_btf_data;
> > > > > > -               btf_data->d_size = raw_btf_size;
> > > > > > -               elf_flagdata(btf_data, ELF_C_SET, ELF_F_DIRTY);
> > > > > > -
> > > > > > -               if (elf_update(elf, ELF_C_NULL) >= 0 &&
> > > > > > -                   elf_update(elf, ELF_C_WRITE) >= 0)
> > > > > > -                       err = 0;
> > > > > > -               else
> > > > > > -                       elf_error("elf_update failed");
> > > > > > -       } else {
> > > > > > -               const char *llvm_objcopy;
> > > > > > -               char tmp_fn[PATH_MAX];
> > > > > > -               char cmd[PATH_MAX * 2];
> > > > > > -
> > > > > > -               llvm_objcopy = getenv("LLVM_OBJCOPY");
> > > > > > -               if (!llvm_objcopy)
> > > > > > -                       llvm_objcopy = "llvm-objcopy";
> > > > > > -
> > > > > > -               /* Use objcopy to add a .BTF section */
> > > > > > -               snprintf(tmp_fn, sizeof(tmp_fn), "%s.btf", filename);
> > > > > > -               close(fd);
> > > > > > -               fd = creat(tmp_fn, S_IRUSR | S_IWUSR);
> > > > > > -               if (fd == -1) {
> > > > > > -                       fprintf(stderr, "%s: open(%s) failed!\n", __func__,
> > > > > > -                               tmp_fn);
> > > > > > -                       goto out;
> > > > > > -               }
> > > > > > -
> > > > > > -               if (write(fd, raw_btf_data, raw_btf_size) != raw_btf_size) {
> > > > > > -                       fprintf(stderr, "%s: write of %d bytes to '%s' failed: %d!\n",
> > > > > > -                               __func__, raw_btf_size, tmp_fn, errno);
> > > > > > +               /*
> > > > > > +                * Existing .BTF section found. LLD creates a zero-sized .BTF
> > > > > > +                * section. Adding data to that section doesn't change the
> > > > > > +                * addresses of the other sections, causing an overwriting of
> > > > > > +                * data. These commands are a bit convoluted, but they will add
> > > > > > +                * a new .BTF section with the proper size. Note though that
> > > > > > +                * the __start_btf and __stop_btf variables aren't affected by
> > > > > > +                * this change, but then they aren't added when using
> > > > > > +                * "--add-section" either.
> > > > > > +                */
> > > > > > +               snprintf(cmd, sizeof(cmd),
> > > > > > +                        "%s --add-section .BTF.new=%s "
> > > > > > +                        "--rename-section .BTF=.BTF.old %s",
> > > > > > +                        llvm_objcopy, tmp_fn, filename);
> > > > > > +               if (system(cmd)) {
> > > > > > +                       fprintf(stderr, "%s: failed to add .BTF section to '%s': %d!\n",
> > > > > > +                               __func__, filename, errno);
> > > > > >                         goto unlink;
> > > > > >                 }
> > > > > >
> > > > > > +               snprintf(cmd, sizeof(cmd),
> > > > > > +                        "%s --rename-section .BTF.new=.BTF %s",
> > > > > > +                        llvm_objcopy, filename);
> > > > > > +               if (system(cmd)) {
> > > > > > +                       fprintf(stderr, "%s: failed to rename .BTF section to '%s': %d!\n",
> > > > > > +                               __func__, filename, errno);
> > > > > > +                       goto unlink;
> > > > > > +               }
> > > > > > +
> > > > > > +               err = 0;
> > > > > > +       } else {
> > > > > >                 snprintf(cmd, sizeof(cmd), "%s --add-section .BTF=%s %s",
> > > > > >                          llvm_objcopy, tmp_fn, filename);
> > > > > >                 if (system(cmd)) {
> > > > > > @@ -1126,10 +1145,11 @@ static int btf_encoder__write_elf(struct btf_encoder *encoder)
> > > > > >                 }
> > > > > >
> > > > > >                 err = 0;
> > > > > > -       unlink:
> > > > > > -               unlink(tmp_fn);
> > > > > >         }
> > > > > >
> > > > > > +unlink:
> > > > > > +       unlink(tmp_fn);
> > > > > > +
> > > > > >  out:
> > > > > >         if (fd != -1)
> > > > > >                 close(fd);
> > > > > > --
> > > > > > 2.38.1.584.g0f3c55d4c2-goog
> > > > > >
