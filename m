Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB359C43381
	for <linux-dwarves@archiver.kernel.org>; Mon,  8 Feb 2021 19:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A25664E74
	for <linux-dwarves@archiver.kernel.org>; Mon,  8 Feb 2021 19:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbhBHTSB (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 8 Feb 2021 14:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236154AbhBHTRu (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 8 Feb 2021 14:17:50 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7A6C061786
        for <dwarves@vger.kernel.org>; Mon,  8 Feb 2021 11:17:09 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id e18so18563582lja.12
        for <dwarves@vger.kernel.org>; Mon, 08 Feb 2021 11:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9qRRFwTuqO+Aiajdff+1iriDFNvAEXC3WkSMPqPFbz0=;
        b=hXC3e+Os0Tjxx46Zo9mCNNZBdKdyJk28UTJa01dWh9Vczs6hqc9irq9PguyC3Tk7rS
         4JO4AIqc98dIxw9C6vE1E6P2o9KEHlrCidHqPG9ftYsA8S3jw+iwKdRfYhaPsDIWuEGZ
         bV/smCTeJBHCgUSp6ji4efSBf3w4AqruXNbGdlNyl7BUthz/vOtL3g26UfN9i9CTeij9
         UhGf+MeN7gYNjlzDuHyt+KyPpqZ0lY+EaUhxGVccUxobDECzYXBFtCwup/Q2CWMGAYQo
         keK2FJxRIH/8A14eTiNZomVijmQEehdQ0h0jVwjTBTt37tfBGJG93xbC+BIq/SrdSx62
         y/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9qRRFwTuqO+Aiajdff+1iriDFNvAEXC3WkSMPqPFbz0=;
        b=sGaXwh9JioaszW8cIZXMiTBYCl5LAWfT9MlH9+/+mjR19cvCE6i3I1OIvPNbHY1Do+
         kMTTCk0jG0EXAJO64e0G9dVhz6LCQQ4eJW3xPmiOmPPS9thM9pAWraXSRphUrf286b3e
         W9RamH3bCQuxzaCi9wZ36lagdmUSFW//QsI+5GtoLeVvC5z/suG4fAOzure7B6ZJOfhS
         8iGT8ZQ3P5fJpOyKVtl7nvEmaNuVXuRjKMVsY0geZqI7ci4tbiqwl19qgsr0g+htq/R8
         +MVkVyCbIvsSpkuyV8/VGQheO2O1rXD4Axr+e7zevmnUVjAZR7utXwzGdV10FKzNkWOG
         sRxA==
X-Gm-Message-State: AOAM533YTzGTX/h0ZR/JQpzl5mGe7ha0sLW+EDZZ7n5tERraq0XX0U2I
        vCZdn93JASMEam7853MH1hMI7S3cqg2pMECg7QdNEw==
X-Google-Smtp-Source: ABdhPJyBX2gPwejaHESl1FKAyFitddRy5yirbdvVLuQLaVidZ8uswiOJGDhE6a1mUqOrAXgLaCC7FbCEl4C4e9FACv8=
X-Received: by 2002:a2e:8541:: with SMTP id u1mr12328144ljj.0.1612811827604;
 Mon, 08 Feb 2021 11:17:07 -0800 (PST)
MIME-Version: 1.0
References: <20210207071726.3969978-1-yhs@fb.com> <a02164334d0e991820eefa45e2df1a8b49f5537e.camel@klomp.org>
In-Reply-To: <a02164334d0e991820eefa45e2df1a8b49f5537e.camel@klomp.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 8 Feb 2021 11:16:56 -0800
Message-ID: <CAKwvOdmMPjn-_opboZkVhRpYCUuKFv8G9GtKFAj=wqYRjr-jkA@mail.gmail.com>
Subject: Re: [PATCH dwarves v2] btf_encoder: sanitize non-regular int base type
To:     Mark Wielaard <mark@klomp.org>, David Blaikie <blaikie@google.com>
Cc:     Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Sun, Feb 7, 2021 at 6:18 AM Mark Wielaard <mark@klomp.org> wrote:
>
> Hi,
>
> On Sat, 2021-02-06 at 23:17 -0800, Yonghong Song wrote:
> > clang with dwarf5 may generate non-regular int base type,
> > i.e., not a signed/unsigned char/short/int/longlong/__int128.
> > Such base types are often used to describe
> > how an actual parameter or variable is generated. For example,
> >
> > 0x000015cf:   DW_TAG_base_type
> >                 DW_AT_name      ("DW_ATE_unsigned_1")
> >                 DW_AT_encoding  (DW_ATE_unsigned)
> >                 DW_AT_byte_size (0x00)
> >
> > 0x00010ed9:         DW_TAG_formal_parameter
> >                       DW_AT_location    (DW_OP_lit0,
> >                                          DW_OP_not,
> >                                          DW_OP_convert (0x000015cf) "DW_ATE_unsigned_1",
> >                                          DW_OP_convert (0x000015d4) "DW_ATE_unsigned_8",
> >                                          DW_OP_stack_value)
> >                       DW_AT_abstract_origin     (0x00013984 "branch")
> >
> > What it does is with a literal "0", did a "not" operation, and the converted to
> > one-bit unsigned int and then 8-bit unsigned int.
>
> Thanks for tracking this down. Do you have any idea why the clang
> compiler emits this? You might be right that it is intended to do what
> you describe it does (but then it would simply encode an unsigned
> constant 1 char in a very inefficient way). But as implemented it
> doesn't seem to make any sense. What would DW_OP_convert of an zero
> sized base type even mean (if it is intended as a 1 bit sized typed,
> then why is there no DW_AT_bit_size)?

David,
Any thoughts on the above sequence of DW_OP_ entries?  This is a part
of DWARF I'm unfamiliar with.

>
> So I do think your patch makes sense. clang clearly is emitting
> something bogus. And so some fixup is needed. But maybe we should at
> least give a warning about it, otherwise it might never get fixed.
>
> BTW. If these bogus base types are only emitted as part of a location
> expression and not as part of an actual function or variable type
> description, then why are we even trying to encode it as a BTF type? It
> might be cheaper to just skip/drop it. But maybe the code setup makes
> it hard to know whether or not such a (bogus) type is actually
> referenced from a function or variable description?
>
> Cheers,
>
> Mark



-- 
Thanks,
~Nick Desaulniers
