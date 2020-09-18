Return-Path: <SRS0=zo6D=C3=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256D2C43463
	for <linux-dwarves@archiver.kernel.org>; Fri, 18 Sep 2020 21:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB7E8206B6
	for <linux-dwarves@archiver.kernel.org>; Fri, 18 Sep 2020 21:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600465236;
	bh=4GvrB4SIoEQ3B5sai8xsC6U+Sy8v+GDEcMMhW4f9DbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VoT6lp23ZFeM4snxX1KJXvBTY1cl84oE4Rar4xv9d4X9IP5Rjuqqrz0EM3Ukkv8To
	 aIFwm+417ezwigUNR+lB95P7enmfgzAMA8Sq4R64fPubXzqSTIj3gzMGzi0qlPqN4i
	 yD2Yvd95G0E2grXXSvxxePtWxWNnghvY/3nlQLjE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgIRVkg (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 18 Sep 2020 17:40:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:42170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgIRVkg (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Fri, 18 Sep 2020 17:40:36 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 592EA205CB;
        Fri, 18 Sep 2020 21:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600465235;
        bh=4GvrB4SIoEQ3B5sai8xsC6U+Sy8v+GDEcMMhW4f9DbQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q09BMCq/U/Ait+EMV+9yP+WBSkE1PBnilmuSH7LECThhtJdqHpEDaLsfQo1SfzJ4D
         C+/+49QIk/XdbTkjzuwMnzmX9Jj4c/ugWnizIdju59QUQlEiauM6DvDRIglEQjbWrn
         vTY+8WT7Set3xHl9qtQkz3ju0nl1xCd0cSoHhbDU=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B1808400E9; Fri, 18 Sep 2020 18:40:32 -0300 (-03)
Date:   Fri, 18 Sep 2020 18:40:32 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Hao Luo <haoluo@google.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        dwarves@vger.kernel.org, Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH 1/2] btf_encoder: Make encoding vars into BTF optional.
Message-ID: <20200918214032.GG1996959@kernel.org>
References: <20200918204058.1030519-1-haoluo@google.com>
 <20200918204058.1030519-2-haoluo@google.com>
 <20200918212402.GE1996959@kernel.org>
 <CA+khW7icd3ndet5x845S+dBL4YiQPbWWSJa=EVYH464gKwzp-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+khW7icd3ndet5x845S+dBL4YiQPbWWSJa=EVYH464gKwzp-A@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Fri, Sep 18, 2020 at 02:26:14PM -0700, Hao Luo escreveu:
> How about '--btf_encode_vars'? It is actually encoding BTF_KIND_VAR.

Sounds good as it references both its for BTF and that is for KIND_VAR.

- Arnaldo
 
> Hao
> 
> On Fri, Sep 18, 2020 at 2:24 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Fri, Sep 18, 2020 at 01:40:57PM -0700, Hao Luo escreveu:
> > > Introduce an option --btf_encode_symbols to pahole so that pahole
> > > will only encode global symbols upon request. On the kernel side,
> > > we can add a Kconfig to turn on this feature. This would make the
> > > rollout of pahole v1.18 safe against potential bugs in the feature
> > > introduced in commit f3d9054ba8ff ("btf_encoder: Teach pahole to
> > > store percpu variables in vmlinux BTF.").
> >
> > 'encode_symbols' is too generic, please rename it to
> > encode_global_symbols or something like that.
> >
> > - Arnaldo
> >
> > > Signed-off-by: Hao Luo <haoluo@google.com>
> > > ---
> > >  btf_encoder.c |  5 ++++-
> > >  btf_encoder.h |  2 +-
> > >  pahole.c      | 11 ++++++++++-
> > >  3 files changed, 15 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/btf_encoder.c b/btf_encoder.c
> > > index 982f59d..54ffdd1 100644
> > > --- a/btf_encoder.c
> > > +++ b/btf_encoder.c
> > > @@ -237,7 +237,7 @@ static struct variable *hashaddr__find_variable(const struct hlist_head hashtabl
> > >       return NULL;
> > >  }
> > >
> > > -int cu__encode_btf(struct cu *cu, int verbose, bool force)
> > > +int cu__encode_btf(struct cu *cu, int verbose, bool force, bool encode_symbols)
> > >  {
> > >       bool add_index_type = false;
> > >       uint32_t type_id_off;
> > > @@ -314,6 +314,9 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force)
> > >               }
> > >       }
> > >
> > > +     /* if there is no request to encode symbols, just finish. */
> > > +     if (!encode_symbols)
> > > +             goto out;
> > >
> > >       if (btfe->percpu_shndx == 0 || !btfe->symtab)
> > >               goto out;
> > > diff --git a/btf_encoder.h b/btf_encoder.h
> > > index bca2348..f2e95fe 100644
> > > --- a/btf_encoder.h
> > > +++ b/btf_encoder.h
> > > @@ -13,6 +13,6 @@ struct cu;
> > >
> > >  int btf_encoder__encode();
> > >
> > > -int cu__encode_btf(struct cu *cu, int verbose, bool force);
> > > +int cu__encode_btf(struct cu *cu, int verbose, bool force, bool encode_symbols);
> > >
> > >  #endif /* _BTF_ENCODER_H_ */
> > > diff --git a/pahole.c b/pahole.c
> > > index e1cde61..079d951 100644
> > > --- a/pahole.c
> > > +++ b/pahole.c
> > > @@ -26,6 +26,7 @@
> > >  static bool btf_encode;
> > >  static bool ctf_encode;
> > >  static bool first_obj_only;
> > > +static bool btf_encode_symbols;
> > >
> > >  static uint8_t class__include_anonymous;
> > >  static uint8_t class__include_nested_anonymous;
> > > @@ -809,6 +810,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
> > >  #define ARGP_header_type        314
> > >  #define ARGP_size_bytes                 315
> > >  #define ARGP_range              316
> > > +#define ARGP_btf_encode_symbols         317
> > >
> > >  static const struct argp_option pahole__options[] = {
> > >       {
> > > @@ -1087,6 +1089,11 @@ static const struct argp_option pahole__options[] = {
> > >               .key  = 'J',
> > >               .doc  = "Encode as BTF",
> > >       },
> > > +     {
> > > +             .name = "btf_encode_symbols",
> > > +             .key  = ARGP_btf_encode_symbols,
> > > +             .doc  = "Encode global symbols in BTF. Off by default."
> > > +     },
> > >       {
> > >               .name = "force",
> > >               .key  = 'j',
> > > @@ -1207,6 +1214,8 @@ static error_t pahole__options_parser(int key, char *arg,
> > >               conf.range = arg;                       break;
> > >       case ARGP_header_type:
> > >               conf.header_type = arg;                 break;
> > > +     case ARGP_btf_encode_symbols:
> > > +             btf_encode_symbols = true;              break;
> > >       default:
> > >               return ARGP_ERR_UNKNOWN;
> > >       }
> > > @@ -2352,7 +2361,7 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
> > >               goto filter_it;
> > >
> > >       if (btf_encode) {
> > > -             cu__encode_btf(cu, global_verbose, force);
> > > +             cu__encode_btf(cu, global_verbose, force, btf_encode_symbols);
> > >               return LSK__KEEPIT;
> > >       }
> > >
> > > --
> > > 2.28.0.681.g6f77f65b4e-goog
> > >
> >
> > --
> >
> > - Arnaldo

-- 

- Arnaldo
