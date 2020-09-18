Return-Path: <SRS0=zo6D=C3=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BC1C43464
	for <linux-dwarves@archiver.kernel.org>; Fri, 18 Sep 2020 21:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDCBD22208
	for <linux-dwarves@archiver.kernel.org>; Fri, 18 Sep 2020 21:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cVX0zmDn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgIRV02 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 18 Sep 2020 17:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgIRV01 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Fri, 18 Sep 2020 17:26:27 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DD4C0613CE
        for <dwarves@vger.kernel.org>; Fri, 18 Sep 2020 14:26:27 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id g4so7498016edk.0
        for <dwarves@vger.kernel.org>; Fri, 18 Sep 2020 14:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hwgtDi5HlQzVlMgJe6UG23JSeSpB4w4hOOgzhnIA2tM=;
        b=cVX0zmDnSB8lbjOjHsKqroR525vQkHuNZ49Ef+qnqQSTJwhCsdTBEOW1tX5J5a8w/K
         Uyax+fev3S3DN/jRrxRHhDh7uAFc93m5nwkkMRg7OKOGxuf4jhfHEkqlw81IqsZnERTE
         oqFCHSBsLpSmP8Dw63mwuGPsDQdRqGyGuFdF4OnmU9nAOyTNGmeiKyaurP3y8UHnRGfT
         G3Ibx2ZpenGqzfMknEMKYtPm/kT7EOwL6Fl8gBv2nQssG71KvQLVYjzHghOIAtOYmChy
         OZKAn4CJWcmlT4ZHttUgazrp5gWYEdN9zKuaIrju0sUTQnqiIy6yQFv+jOJfh4L4tC1M
         aVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hwgtDi5HlQzVlMgJe6UG23JSeSpB4w4hOOgzhnIA2tM=;
        b=Em+mqFz9RtGwkWsshzsfZd2AcOxB7QGIyD6BM0elK5Uf2DsYnkjY36Ub8ken8Dykd2
         +yT16hbVX1R0qYe7aA9ffoOrDVQ9Lsv4XCSgZzqLEvGRkBwhWTJfaPYN2drM6/du07WD
         BV42grZ2Ik6bQGR+r8JMIJwXWBt/LZtgc1F4VT9NZF+iUqRJCyimq0sPUp7OnJKYWZJ2
         8zwdV73IzLSA+KiVw2cXSA81jNvTf8u+VWssLT0CLZLyF7BmeHbLWq8LUxuuZODhYO0L
         QjCD4vemStqWR2lG9KHbqu2H8G3VIVDp1VBaHkzjApUyhv2ng+0ssKJkHTy+nS0qhokp
         +H+g==
X-Gm-Message-State: AOAM530j+B0PLTpeIdWWORaRFhBlQwZUddlB3tL/QSawxPac9AmySpgB
        xOnWgtjbgBEa+KtWxBySP+Pa5uyZGaIBevEQjg+kbA==
X-Google-Smtp-Source: ABdhPJyZvGXh5WK1NhFL/npgyb7S0SfXqJvNnsUEK3hkqe0piRkc0lOXOIzJKgJjvDhdBK5hx/qmjjxISgu3xwSQjog=
X-Received: by 2002:aa7:dc18:: with SMTP id b24mr40818731edu.285.1600464385595;
 Fri, 18 Sep 2020 14:26:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200918204058.1030519-1-haoluo@google.com> <20200918204058.1030519-2-haoluo@google.com>
 <20200918212402.GE1996959@kernel.org>
In-Reply-To: <20200918212402.GE1996959@kernel.org>
From:   Hao Luo <haoluo@google.com>
Date:   Fri, 18 Sep 2020 14:26:14 -0700
Message-ID: <CA+khW7icd3ndet5x845S+dBL4YiQPbWWSJa=EVYH464gKwzp-A@mail.gmail.com>
Subject: Re: [PATCH 1/2] btf_encoder: Make encoding vars into BTF optional.
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        dwarves@vger.kernel.org, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

How about '--btf_encode_vars'? It is actually encoding BTF_KIND_VAR.

Hao

On Fri, Sep 18, 2020 at 2:24 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, Sep 18, 2020 at 01:40:57PM -0700, Hao Luo escreveu:
> > Introduce an option --btf_encode_symbols to pahole so that pahole
> > will only encode global symbols upon request. On the kernel side,
> > we can add a Kconfig to turn on this feature. This would make the
> > rollout of pahole v1.18 safe against potential bugs in the feature
> > introduced in commit f3d9054ba8ff ("btf_encoder: Teach pahole to
> > store percpu variables in vmlinux BTF.").
>
> 'encode_symbols' is too generic, please rename it to
> encode_global_symbols or something like that.
>
> - Arnaldo
>
> > Signed-off-by: Hao Luo <haoluo@google.com>
> > ---
> >  btf_encoder.c |  5 ++++-
> >  btf_encoder.h |  2 +-
> >  pahole.c      | 11 ++++++++++-
> >  3 files changed, 15 insertions(+), 3 deletions(-)
> >
> > diff --git a/btf_encoder.c b/btf_encoder.c
> > index 982f59d..54ffdd1 100644
> > --- a/btf_encoder.c
> > +++ b/btf_encoder.c
> > @@ -237,7 +237,7 @@ static struct variable *hashaddr__find_variable(const struct hlist_head hashtabl
> >       return NULL;
> >  }
> >
> > -int cu__encode_btf(struct cu *cu, int verbose, bool force)
> > +int cu__encode_btf(struct cu *cu, int verbose, bool force, bool encode_symbols)
> >  {
> >       bool add_index_type = false;
> >       uint32_t type_id_off;
> > @@ -314,6 +314,9 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force)
> >               }
> >       }
> >
> > +     /* if there is no request to encode symbols, just finish. */
> > +     if (!encode_symbols)
> > +             goto out;
> >
> >       if (btfe->percpu_shndx == 0 || !btfe->symtab)
> >               goto out;
> > diff --git a/btf_encoder.h b/btf_encoder.h
> > index bca2348..f2e95fe 100644
> > --- a/btf_encoder.h
> > +++ b/btf_encoder.h
> > @@ -13,6 +13,6 @@ struct cu;
> >
> >  int btf_encoder__encode();
> >
> > -int cu__encode_btf(struct cu *cu, int verbose, bool force);
> > +int cu__encode_btf(struct cu *cu, int verbose, bool force, bool encode_symbols);
> >
> >  #endif /* _BTF_ENCODER_H_ */
> > diff --git a/pahole.c b/pahole.c
> > index e1cde61..079d951 100644
> > --- a/pahole.c
> > +++ b/pahole.c
> > @@ -26,6 +26,7 @@
> >  static bool btf_encode;
> >  static bool ctf_encode;
> >  static bool first_obj_only;
> > +static bool btf_encode_symbols;
> >
> >  static uint8_t class__include_anonymous;
> >  static uint8_t class__include_nested_anonymous;
> > @@ -809,6 +810,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
> >  #define ARGP_header_type        314
> >  #define ARGP_size_bytes                 315
> >  #define ARGP_range              316
> > +#define ARGP_btf_encode_symbols         317
> >
> >  static const struct argp_option pahole__options[] = {
> >       {
> > @@ -1087,6 +1089,11 @@ static const struct argp_option pahole__options[] = {
> >               .key  = 'J',
> >               .doc  = "Encode as BTF",
> >       },
> > +     {
> > +             .name = "btf_encode_symbols",
> > +             .key  = ARGP_btf_encode_symbols,
> > +             .doc  = "Encode global symbols in BTF. Off by default."
> > +     },
> >       {
> >               .name = "force",
> >               .key  = 'j',
> > @@ -1207,6 +1214,8 @@ static error_t pahole__options_parser(int key, char *arg,
> >               conf.range = arg;                       break;
> >       case ARGP_header_type:
> >               conf.header_type = arg;                 break;
> > +     case ARGP_btf_encode_symbols:
> > +             btf_encode_symbols = true;              break;
> >       default:
> >               return ARGP_ERR_UNKNOWN;
> >       }
> > @@ -2352,7 +2361,7 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
> >               goto filter_it;
> >
> >       if (btf_encode) {
> > -             cu__encode_btf(cu, global_verbose, force);
> > +             cu__encode_btf(cu, global_verbose, force, btf_encode_symbols);
> >               return LSK__KEEPIT;
> >       }
> >
> > --
> > 2.28.0.681.g6f77f65b4e-goog
> >
>
> --
>
> - Arnaldo
