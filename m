Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA72C433E0
	for <linux-dwarves@archiver.kernel.org>; Thu,  4 Feb 2021 15:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1017464DF2
	for <linux-dwarves@archiver.kernel.org>; Thu,  4 Feb 2021 15:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237080AbhBDPNB (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 4 Feb 2021 10:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237056AbhBDPMn (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 4 Feb 2021 10:12:43 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C427C061793
        for <dwarves@vger.kernel.org>; Thu,  4 Feb 2021 07:11:41 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id u9so229566vkb.0
        for <dwarves@vger.kernel.org>; Thu, 04 Feb 2021 07:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WThyMEnbXwGEqg+xvb/UXgCzsUcKXxh8kviOEY1TJto=;
        b=XJVXiK6gZqATdu6sIUyOyoFoYNwWXK+5nKmbJLH2KGZpxaPfRGP/6ESTTt7JiGN5eU
         UJ1sTNpecJMgAAcLoncQraWw1rq4os/W1EC++xDCIT2CeA8OnnERYCVbsmgXMtZU6QOb
         +CBhUwtdtU/a1tlFBKmbTtUoN5guMHNGmfays/DF2vzaAEZDVHw+8fkScI7N58P4MZ6p
         vyBOxFHoqdRWDf6o2cMjV4vHmf4BmWtuEJC8noNevER8rVZb08DwTcoS3E4Y8r/WuKgR
         KxcgrPnNyHaspHd+PSc5g7tNcCj9oU5S1FmYBvaG+WhMZtDhbj/ifGDNq8ZJUf934zCc
         B3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WThyMEnbXwGEqg+xvb/UXgCzsUcKXxh8kviOEY1TJto=;
        b=HA/IyoWIn0UxHhRUlQgb/YT4CCskHY7utlS24pJyKm6pOaWKLb0K9kJbkxOGp+6BJ3
         jtdeQfGv8RQx8lrfxy+a4PZq6tHXKv+Odmtj0EXUaj2/t5kQWwBzj5YuvaI7Al0fofg5
         pev08tWWWLGKSjuLrR1Wb/o5QfyJRzHPO/P0JDLGaWPp7A4NZoJHvGj4msJQ7CgJdrpl
         vFhgLwXEbGu1GQzz5HNKWipNG8bDaD57m2eVUmSEnVt1o/Hd2BUyHCt08SzwYJJo6tPB
         XkrMh5K/BlBIVrxvjaE44SXM+D3ZtVzyYG9UX/qUBf+Iv6zNNyVx2axf+uKPi/KmsmsV
         G6Dg==
X-Gm-Message-State: AOAM53239tl22vbyHQNZZO9DphM5zl7wCXAXxnYyW0aAFaidAavYgGQW
        BAT+aeGfPPtucVDexan14IAIS2XMrxQC0OwAm6FygQ==
X-Google-Smtp-Source: ABdhPJw9uNQ/RPyGKyCJYOF26CCPbELLQwhASEzilEKyZt5Ecitwdv056nAb0pR6hPy3D5M7luI1qhh5nXvt3KMNOu4=
X-Received: by 2002:a1f:a643:: with SMTP id p64mr5453402vke.15.1612451500384;
 Thu, 04 Feb 2021 07:11:40 -0800 (PST)
MIME-Version: 1.0
References: <20210201172530.1141087-1-gprocida@google.com> <20210201172530.1141087-5-gprocida@google.com>
 <CAEf4Bzb6bKVo3NeVUr3Zb9+is0XbeOn+xLXtHv-GA_cWGVZfnA@mail.gmail.com>
In-Reply-To: <CAEf4Bzb6bKVo3NeVUr3Zb9+is0XbeOn+xLXtHv-GA_cWGVZfnA@mail.gmail.com>
From:   Giuliano Procida <gprocida@google.com>
Date:   Thu, 4 Feb 2021 15:11:03 +0000
Message-ID: <CAGvU0HmLckYQv43OgvpU1aDkwVTBHc3MV0rZ_jfi4Az_tZXjjA@mail.gmail.com>
Subject: Re: [PATCH dwarves v2 4/4] btf_encoder: Align .BTF section/segment to
 8 bytes
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

On Thu, 4 Feb 2021 at 04:10, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Feb 1, 2021 at 9:26 AM Giuliano Procida <gprocida@google.com> wrote:
> >
> > This is to avoid misaligned access to BTF type structs when
> > memory-mapping ELF sections.
> >
> > Signed-off-by: Giuliano Procida <gprocida@google.com>
> > ---
> >  libbtf.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/libbtf.c b/libbtf.c
> > index 048a873..ae99a93 100644
> > --- a/libbtf.c
> > +++ b/libbtf.c
> > @@ -755,7 +755,13 @@ static int btf_elf__write(const char *filename, struct btf *btf)
> >          * This actually happens in practice with vmlinux which has .strtab
> >          * after .shstrtab, resulting in a (small) hole the size of the original
> >          * .shstrtab.
> > +        *
> > +        * We'll align .BTF to 8 bytes to cater for all architectures. It'd be
> > +        * nice if we could fetch this value from somewhere. The BTF
> > +        * specification does not discuss alignment and its trailing string
> > +        * table is not currently padded to any particular alignment.
> >          */
> > +       const size_t btf_alignment = 8;
> >
> >         /*
> >          * First we look if there was already a .BTF section present and
> > @@ -847,8 +853,8 @@ static int btf_elf__write(const char *filename, struct btf *btf)
> >         elf_flagdata(btf_data, ELF_C_SET, ELF_F_DIRTY);
> >
> >         /* Update .BTF section in the SHT */
> > -       size_t new_btf_offset = high_water_mark;
> > -       size_t new_btf_size = raw_btf_size;
> > +       size_t new_btf_offset = roundup(high_water_mark, btf_alignment);
> > +       size_t new_btf_size = roundup(raw_btf_size, btf_alignment);
> >         GElf_Shdr btf_shdr_mem;
> >         GElf_Shdr *btf_shdr = gelf_getshdr(btf_scn, &btf_shdr_mem);
> >         if (!btf_shdr) {
> > @@ -856,6 +862,7 @@ static int btf_elf__write(const char *filename, struct btf *btf)
> >                         __func__, elf_errmsg(elf_errno()));
> >                 goto out;
> >         }
> > +       btf_shdr->sh_addralign = btf_alignment;
>
> if we set just this and let libelf do the layout, would libelf ensure
> 8-byte alignment of .BTF section inside the ELF file?
>

Yes. I'll follow up with a trivial patch that does that.




> >         btf_shdr->sh_entsize = 0;
> >         btf_shdr->sh_flags = SHF_ALLOC;
> >         if (dot_btf_offset)
> > @@ -926,6 +933,7 @@ static int btf_elf__write(const char *filename, struct btf *btf)
> >                 pht[phnum].p_memsz = pht[phnum].p_filesz = btf_shdr->sh_size;
> >                 pht[phnum].p_vaddr = pht[phnum].p_paddr = 0;
> >                 pht[phnum].p_flags = PF_R;
> > +               pht[phnum].p_align = btf_alignment;
> >                 void *phdr = gelf_newphdr(elf, phnum+1);
> >                 if (!phdr) {
> >                         fprintf(stderr, "%s: gelf_newphdr failed: %s\n",
> > --
> > 2.30.0.365.g02bc693789-goog
> >
