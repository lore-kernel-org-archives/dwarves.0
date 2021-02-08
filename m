Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562ABC433E0
	for <linux-dwarves@archiver.kernel.org>; Mon,  8 Feb 2021 19:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04A0964DC3
	for <linux-dwarves@archiver.kernel.org>; Mon,  8 Feb 2021 19:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbhBHTX5 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 8 Feb 2021 14:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbhBHTXo (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 8 Feb 2021 14:23:44 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC40C061788
        for <dwarves@vger.kernel.org>; Mon,  8 Feb 2021 11:23:03 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id w36so10489238lfu.4
        for <dwarves@vger.kernel.org>; Mon, 08 Feb 2021 11:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QiBb/mdPkEeXWjau+RBUzp0TEZAqz2nNmMcNmf1aH+A=;
        b=aQduSGwaf25I3PpE08L19WytoAKBleqUwt84wJ9nZMMMAo6czUCvYeD7O/rlxBtRv0
         2ttrzv5ZQyZmBsYuLmHWrmjjSa9+jay7Of1Dwd9d1pFv136SnKjHY7mCtyN1ITH8FPk0
         xZ5MsNPijUkipYijE80u7N17Qi/69r9e5FwP0xLdm8LP0HcrERT4mBvT9M7YWc0vRqC4
         cOKu8X38hVULhtSYYhrpdjn1NSNZ5GH1rCYce3iDN/XVHQk2D/R0KupE28hJMt7RE3Ys
         RvBRO8ZfTEyPezPeAuf+YD+Y14cxYnkl9zhI6fN7qlhu1jxI/mrTtpNzGe4T8RXisbjS
         0EtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QiBb/mdPkEeXWjau+RBUzp0TEZAqz2nNmMcNmf1aH+A=;
        b=P69w1gswCBDhxjquZsiR+iez8iBa3mFoFNYOFXcoV/K/vSohG9b+v44vw2/SJi8ljQ
         sG0bcjlsWYs9D6tNmj+eeEk+Rru767xp6P6k4XxIJ7yysmFEqqvYIS+X3yqAsRaFHlie
         bs4y7VHFMsxHROVOnKERRvxx1eLUWgv3CbtCB1RX0s/P0vljEaRtcnhqyZak2Y7h/h9F
         9EaFA5VTuRi+zFvwfuT3/zNr+eyOlrg9Mgp2TkurNISE7J+UP3NdK69s7H/4pH1snDjH
         wuOozKSOsViHmWdhxZzs81o53oJBGTF3lQyPcohenIH/CQUjvg00o+ws39Qhps6TTHPs
         SORw==
X-Gm-Message-State: AOAM533PaFR4kexP537i8cIo9y3mUiPD8sG5ryYOI6ea80yfSyFAxsmM
        3O25FyabGgHe/MO0JtT4m0vwQydHVgCpdy9r9KqyARP/o9U=
X-Google-Smtp-Source: ABdhPJxrmpkxMf8Ur9GqjZivsEKq5KhNxBgsQPcJ0nnvJeocDyiohvVvOHlY4zsqUHNSj7IlZmf4RN8MFznAS2OMuVo=
X-Received: by 2002:ac2:5e90:: with SMTP id b16mr10870564lfq.122.1612812179287;
 Mon, 08 Feb 2021 11:22:59 -0800 (PST)
MIME-Version: 1.0
References: <20210207071726.3969978-1-yhs@fb.com>
In-Reply-To: <20210207071726.3969978-1-yhs@fb.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 8 Feb 2021 11:22:48 -0800
Message-ID: <CAKwvOdm81yoFXg65XPc=PTOC+P7J9TJuFc3ag9TvFkjGW0iGVg@mail.gmail.com>
Subject: Re: [PATCH dwarves v2] btf_encoder: sanitize non-regular int base type
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Mark Wielaard <mark@klomp.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Sat, Feb 6, 2021 at 11:17 PM Yonghong Song <yhs@fb.com> wrote:
>
> clang with dwarf5 may generate non-regular int base type,
> i.e., not a signed/unsigned char/short/int/longlong/__int128.
> Such base types are often used to describe
> how an actual parameter or variable is generated. For example,
>
> 0x000015cf:   DW_TAG_base_type
>                 DW_AT_name      ("DW_ATE_unsigned_1")
>                 DW_AT_encoding  (DW_ATE_unsigned)
>                 DW_AT_byte_size (0x00)
>
> 0x00010ed9:         DW_TAG_formal_parameter
>                       DW_AT_location    (DW_OP_lit0,
>                                          DW_OP_not,
>                                          DW_OP_convert (0x000015cf) "DW_ATE_unsigned_1",
>                                          DW_OP_convert (0x000015d4) "DW_ATE_unsigned_8",
>                                          DW_OP_stack_value)
>                       DW_AT_abstract_origin     (0x00013984 "branch")
>
> What it does is with a literal "0", did a "not" operation, and the converted to
> one-bit unsigned int and then 8-bit unsigned int.
>
> Another example,
>
> 0x000e97e4:   DW_TAG_base_type
>                 DW_AT_name      ("DW_ATE_unsigned_24")
>                 DW_AT_encoding  (DW_ATE_unsigned)
>                 DW_AT_byte_size (0x03)
>
> 0x000f88f8:     DW_TAG_variable
>                   DW_AT_location        (indexed (0x3c) loclist = 0x00008fb0:
>                      [0xffffffff82808812, 0xffffffff82808817):
>                          DW_OP_breg0 RAX+0,
>                          DW_OP_convert (0x000e97d5) "DW_ATE_unsigned_64",
>                          DW_OP_convert (0x000e97df) "DW_ATE_unsigned_8",
>                          DW_OP_stack_value,
>                          DW_OP_piece 0x1,
>                          DW_OP_breg0 RAX+0,
>                          DW_OP_convert (0x000e97d5) "DW_ATE_unsigned_64",
>                          DW_OP_convert (0x000e97da) "DW_ATE_unsigned_32",
>                          DW_OP_lit8,
>                          DW_OP_shr,
>                          DW_OP_convert (0x000e97da) "DW_ATE_unsigned_32",
>                          DW_OP_convert (0x000e97e4) "DW_ATE_unsigned_24",
>                          DW_OP_stack_value,
>                          DW_OP_piece 0x3
>                      ......
>
> At one point, a right shift by 8 happens and the result is converted to
> 32-bit unsigned int and then to 24-bit unsigned int.
>
> BTF does not need any of these DW_OP_* information and such non-regular int
> types will cause libbpf to emit errors.
> Let us sanitize them to generate BTF acceptable to libbpf and kernel.
>
> Cc: Sedat Dilek <sedat.dilek@gmail.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Yonghong Song <yhs@fb.com>

Thanks for the patch!

Tested-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  libbtf.c | 39 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 38 insertions(+), 1 deletion(-)
>
> diff --git a/libbtf.c b/libbtf.c
> index 9f76283..5843200 100644
> --- a/libbtf.c
> +++ b/libbtf.c
> @@ -373,6 +373,7 @@ int32_t btf_elf__add_base_type(struct btf_elf *btfe, const struct base_type *bt,
>         struct btf *btf = btfe->btf;
>         const struct btf_type *t;
>         uint8_t encoding = 0;
> +       uint16_t byte_sz;
>         int32_t id;
>
>         if (bt->is_signed) {
> @@ -384,7 +385,43 @@ int32_t btf_elf__add_base_type(struct btf_elf *btfe, const struct base_type *bt,
>                 return -1;
>         }
>
> -       id = btf__add_int(btf, name, BITS_ROUNDUP_BYTES(bt->bit_size), encoding);
> +       /* dwarf5 may emit DW_ATE_[un]signed_{num} base types where
> +        * {num} is not power of 2 and may exceed 128. Such attributes
> +        * are mostly used to record operation for an actual parameter
> +        * or variable.
> +        * For example,
> +        *     DW_AT_location        (indexed (0x3c) loclist = 0x00008fb0:
> +        *         [0xffffffff82808812, 0xffffffff82808817):
> +        *             DW_OP_breg0 RAX+0,
> +        *             DW_OP_convert (0x000e97d5) "DW_ATE_unsigned_64",
> +        *             DW_OP_convert (0x000e97df) "DW_ATE_unsigned_8",
> +        *             DW_OP_stack_value,
> +        *             DW_OP_piece 0x1,
> +        *             DW_OP_breg0 RAX+0,
> +        *             DW_OP_convert (0x000e97d5) "DW_ATE_unsigned_64",
> +        *             DW_OP_convert (0x000e97da) "DW_ATE_unsigned_32",
> +        *             DW_OP_lit8,
> +        *             DW_OP_shr,
> +        *             DW_OP_convert (0x000e97da) "DW_ATE_unsigned_32",
> +        *             DW_OP_convert (0x000e97e4) "DW_ATE_unsigned_24",
> +        *             DW_OP_stack_value, DW_OP_piece 0x3
> +        *     DW_AT_name    ("ebx")
> +        *     DW_AT_decl_file       ("/linux/arch/x86/events/intel/core.c")
> +        *
> +        * In the above example, at some point, one unsigned_32 value
> +        * is right shifted by 8 and the result is converted to unsigned_32
> +        * and then unsigned_24.
> +        *
> +        * BTF does not need such DW_OP_* information so let us sanitize
> +        * these non-regular int types to avoid libbpf/kernel complaints.
> +        */
> +       byte_sz = BITS_ROUNDUP_BYTES(bt->bit_size);
> +       if (!byte_sz || (byte_sz & (byte_sz - 1))) {
> +               name = "__SANITIZED_FAKE_INT__";
> +               byte_sz = 4;
> +       }
> +
> +       id = btf__add_int(btf, name, byte_sz, encoding);
>         if (id < 0) {
>                 btf_elf__log_err(btfe, BTF_KIND_INT, name, true, "Error emitting BTF type");
>         } else {
> --
> 2.24.1
>


-- 
Thanks,
~Nick Desaulniers
