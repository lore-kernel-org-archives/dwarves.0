Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC9AC4321E
	for <linux-dwarves@archiver.kernel.org>; Wed, 30 Nov 2022 22:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiK3W7Y (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 30 Nov 2022 17:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiK3W7X (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 30 Nov 2022 17:59:23 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82A556EE2
        for <dwarves@vger.kernel.org>; Wed, 30 Nov 2022 14:59:22 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id d20so188853edn.0
        for <dwarves@vger.kernel.org>; Wed, 30 Nov 2022 14:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gL0NQHLNb/FQ69UwCCQr7vRUn6hjmYxHS68lDrK6WmA=;
        b=cDu3pfLsQ0Is4HpyzzntaqGINatAJhYGeBa7YYgGDshJfNy68PM8ElscXFrgSx/mrc
         gwSKM7CSBvLOth30YmOgaoYehIUd6jixPA9fcxKcbDGMtUE2wDm35eil5j0KSblM8cdb
         WN4D0BomSLRwBILtLjGrrpBTyeRudmGF4FqRyg7bqaFbSqFQodrTY3ddrrv3CbmQX7tT
         Hz0Ee0xsWUpRBoEGiqTkm8wbC41KqAg865fmHKZvYp6PjWYXW9UdqjcmGfdmszyiDBvu
         PQpmnB3D3ETQzOkV+rZRJMrwTHyA9xIJGpUYNPBzhq/bglEDQsRtUbFW6/hAQMJ+uyZS
         sGYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gL0NQHLNb/FQ69UwCCQr7vRUn6hjmYxHS68lDrK6WmA=;
        b=TAOesxMHqGwo0dO0eqpVbEpE6aVzXh2FKx8I0gPyhcPcpcJv39TI5RwqmBniuu4xQj
         mkqofKWLJup2BdSSRuJ8HVflWcnKgedLz5DE5kZnC68JT9yiNZD7uV53Ki/9jrwhUlMT
         NgUZJ2gG7Nxqjru8EXnWUUlOwCkIlijfnlr/tirALy9xRFAX5IBgNDNIK6axw4exGUC2
         Xe2+IDVZ+F+vCgNcPK7ziCaC6UdDVs/GLwzVMl2btDMRiIvv3ttx1f2omvO8GLT9xo67
         C1FsiZ5kq/TiOQCTuJ8iyGNhgI4c3CXfk/DAV/HcG3YslHBegOLqoRiq/H29fUfj/KxQ
         oDQw==
X-Gm-Message-State: ANoB5pmTIvvmHIBW7gxjkHpRKwj/L+99uA+How4fSDVdkBkhYyQ77Kbn
        jypM1pJ+gFAbHpZLxMUpzqgt0IPpYBSIOtjMPYMLcd5ths0=
X-Google-Smtp-Source: AA0mqf5ZzFKmDZdl9pbhuY6HAvtWy4FJo76NwjQlXyYEZ+jHOuCuyJKvshSc31SFc7DwRf+FFH+QZgzE8DbaNODdm+k=
X-Received: by 2002:aa7:d80d:0:b0:46b:7645:86a9 with SMTP id
 v13-20020aa7d80d000000b0046b764586a9mr9314929edq.311.1669849161298; Wed, 30
 Nov 2022 14:59:21 -0800 (PST)
MIME-Version: 1.0
References: <20221122000011.241697-1-morbo@google.com> <20221122000011.241697-2-morbo@google.com>
In-Reply-To: <20221122000011.241697-2-morbo@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 30 Nov 2022 14:59:09 -0800
Message-ID: <CAEf4BzYiHx0gAgJsam4usy23UTGwN-a-nyJa2+jzG+RzUFiWEQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] btf_encoder: Generate a new .BTF section even if one exists
To:     Bill Wendling <morbo@google.com>
Cc:     dwarves@vger.kernel.org, Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Mon, Nov 21, 2022 at 4:00 PM Bill Wendling <morbo@google.com> wrote:
>
> LLD generates a zero-length .BTF section (BFD doesn't generate this
> section). It shares the same address as .BTF_ids (or any section below
> it). E.g.:
>
>   [24] .BTF              PROGBITS        ffffffff825a1900 17a1900 000000
>   [25] .BTF_ids          PROGBITS        ffffffff825a1900 17a1900 000634
>
> Writing new data to that section doesn't adjust the addresses of
> following sections. As a result, the "-J" flag produces a corrupted
> file, causing further commands to fail.
>
> Instead of trying to adjust everything, just add a new section with the
> .BTF data and adjust the name of the original .BTF section. (We can't
> remove the old .BTF section because it has variables that are referenced
> elsewhere.)
>

Have you tried llvm-objcopy --update-section instead? Doesn't it work?

> Link: https://lore.kernel.org/dwarves/20210317232657.mdnsuoqx6nbddjgt@google.com/
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Fangrui Song <maskray@google.com>
> Cc: dwarves@vger.kernel.org
> Signed-off-by: Bill Wendling <morbo@google.com>
> ---
>  btf_encoder.c | 88 +++++++++++++++++++++++++++++++--------------------
>  1 file changed, 54 insertions(+), 34 deletions(-)
>
> diff --git a/btf_encoder.c b/btf_encoder.c
> index a5fa04a84ee2..bd1ce63e992c 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -1039,6 +1039,9 @@ static int btf_encoder__write_elf(struct btf_encoder *encoder)
>         Elf_Data *btf_data = NULL;
>         Elf_Scn *scn = NULL;
>         Elf *elf = NULL;
> +       const char *llvm_objcopy;
> +       char tmp_fn[PATH_MAX];
> +       char cmd[PATH_MAX * 2];
>         const void *raw_btf_data;
>         uint32_t raw_btf_size;
>         int fd, err = -1;
> @@ -1081,42 +1084,58 @@ static int btf_encoder__write_elf(struct btf_encoder *encoder)
>
>         raw_btf_data = btf__raw_data(btf, &raw_btf_size);
>
> +       llvm_objcopy = getenv("LLVM_OBJCOPY");
> +       if (!llvm_objcopy)
> +               llvm_objcopy = "llvm-objcopy";
> +
> +       /* Use objcopy to add a .BTF section */
> +       snprintf(tmp_fn, sizeof(tmp_fn), "%s.btf", filename);
> +       close(fd);
> +       fd = creat(tmp_fn, S_IRUSR | S_IWUSR);
> +       if (fd == -1) {
> +               fprintf(stderr, "%s: open(%s) failed!\n", __func__,
> +                       tmp_fn);
> +               goto out;
> +       }
> +
> +       if (write(fd, raw_btf_data, raw_btf_size) != raw_btf_size) {
> +               fprintf(stderr, "%s: write of %d bytes to '%s' failed: %d!\n",
> +                       __func__, raw_btf_size, tmp_fn, errno);
> +               goto unlink;
> +       }
> +
>         if (btf_data) {
> -               /* Existing .BTF section found */
> -               btf_data->d_buf = (void *)raw_btf_data;
> -               btf_data->d_size = raw_btf_size;
> -               elf_flagdata(btf_data, ELF_C_SET, ELF_F_DIRTY);
> -
> -               if (elf_update(elf, ELF_C_NULL) >= 0 &&
> -                   elf_update(elf, ELF_C_WRITE) >= 0)
> -                       err = 0;
> -               else
> -                       elf_error("elf_update failed");
> -       } else {
> -               const char *llvm_objcopy;
> -               char tmp_fn[PATH_MAX];
> -               char cmd[PATH_MAX * 2];
> -
> -               llvm_objcopy = getenv("LLVM_OBJCOPY");
> -               if (!llvm_objcopy)
> -                       llvm_objcopy = "llvm-objcopy";
> -
> -               /* Use objcopy to add a .BTF section */
> -               snprintf(tmp_fn, sizeof(tmp_fn), "%s.btf", filename);
> -               close(fd);
> -               fd = creat(tmp_fn, S_IRUSR | S_IWUSR);
> -               if (fd == -1) {
> -                       fprintf(stderr, "%s: open(%s) failed!\n", __func__,
> -                               tmp_fn);
> -                       goto out;
> -               }
> -
> -               if (write(fd, raw_btf_data, raw_btf_size) != raw_btf_size) {
> -                       fprintf(stderr, "%s: write of %d bytes to '%s' failed: %d!\n",
> -                               __func__, raw_btf_size, tmp_fn, errno);
> +               /*
> +                * Existing .BTF section found. LLD creates a zero-sized .BTF
> +                * section. Adding data to that section doesn't change the
> +                * addresses of the other sections, causing an overwriting of
> +                * data. These commands are a bit convoluted, but they will add
> +                * a new .BTF section with the proper size. Note though that
> +                * the __start_btf and __stop_btf variables aren't affected by
> +                * this change, but then they aren't added when using
> +                * "--add-section" either.
> +                */
> +               snprintf(cmd, sizeof(cmd),
> +                        "%s --add-section .BTF.new=%s "
> +                        "--rename-section .BTF=.BTF.old %s",
> +                        llvm_objcopy, tmp_fn, filename);
> +               if (system(cmd)) {
> +                       fprintf(stderr, "%s: failed to add .BTF section to '%s': %d!\n",
> +                               __func__, filename, errno);
>                         goto unlink;
>                 }
>
> +               snprintf(cmd, sizeof(cmd),
> +                        "%s --rename-section .BTF.new=.BTF %s",
> +                        llvm_objcopy, filename);
> +               if (system(cmd)) {
> +                       fprintf(stderr, "%s: failed to rename .BTF section to '%s': %d!\n",
> +                               __func__, filename, errno);
> +                       goto unlink;
> +               }
> +
> +               err = 0;
> +       } else {
>                 snprintf(cmd, sizeof(cmd), "%s --add-section .BTF=%s %s",
>                          llvm_objcopy, tmp_fn, filename);
>                 if (system(cmd)) {
> @@ -1126,10 +1145,11 @@ static int btf_encoder__write_elf(struct btf_encoder *encoder)
>                 }
>
>                 err = 0;
> -       unlink:
> -               unlink(tmp_fn);
>         }
>
> +unlink:
> +       unlink(tmp_fn);
> +
>  out:
>         if (fd != -1)
>                 close(fd);
> --
> 2.38.1.584.g0f3c55d4c2-goog
>
