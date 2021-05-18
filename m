Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DBAC433ED
	for <linux-dwarves@archiver.kernel.org>; Tue, 18 May 2021 18:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE0FA60D07
	for <linux-dwarves@archiver.kernel.org>; Tue, 18 May 2021 18:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245010AbhERScI (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 18 May 2021 14:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244333AbhERScI (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 18 May 2021 14:32:08 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CD4C061573
        for <dwarves@vger.kernel.org>; Tue, 18 May 2021 11:30:50 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id b13so13219034ybk.4
        for <dwarves@vger.kernel.org>; Tue, 18 May 2021 11:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gT1Om+9Oxz9v3Kicz9MxdnPqZZ8ANN1BKJjnttbWbnM=;
        b=c1sV3F11d84HhsaLU+ETHA4Y8QYXj+qk7Yjf3O8X1Sbv8oz3GFDQGZ8Kwqf5w6JNb4
         hsz8FXKLviAgLfaPbnlx+lzq/95a79f1qbRCR+7nq8VzvVgiJBg9O3vdQK1XM7IfUu3w
         LlnNthzYYxq5vbvnUIqBQZDphctrzciKknIQioVn1MnloPQeGKHKQYhwCY394kGLt698
         Xbs3yggkIaZu+7YKqs1hlrWnYHtPIwarflw64E7uAaWG+cDaveOD6R0cFtMY4mQ7lw29
         dLU6PgvqW2Ui5Efn9sKG59YJNcQXI2SRNMW8nar7n7+vr52VnCcaMuQ2Jr5kLhLHiCOy
         7IWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gT1Om+9Oxz9v3Kicz9MxdnPqZZ8ANN1BKJjnttbWbnM=;
        b=tXvJDxYzVJCe2HlyZb3cKMmfVyk+25Di2UIYDVpVXpRHxtZi4TxNgmJ80GRXY9srhl
         7gIEhHkUs6dbGQCgtEjvcxcqfKltqmZe14BgLKMUKvbozQzOJByJdJ9ek9ZkL1Y061qd
         782RtmvJL0sYMO00dpJGowZBVvmia5qKcBhniZ3UHyQ7wDCT14FLfklpPNQ6sWtiv0Yx
         uf9M6fDDcLl6SVPVSGsrIYUwjCCWajZaLS5wReywLkqWUXplIaH/FY9gxN5ZcgmnaMas
         H75yZXTpmzgakfkwcHjHv677FvHqx8z7FovE58GscgnTW3m7Wxx/gan41nTufF09RrRE
         4o5Q==
X-Gm-Message-State: AOAM533lgV756UXySXvn8raZsNO1urQQyjIcKugK4XQW62FsDdeqN1Um
        +IOfau6l8AOvddYMxDK2ejRYv7p+gNEpr+V1Ry+cvdRb
X-Google-Smtp-Source: ABdhPJyhptd8ANJhCzpGGBOrnMwvuJv/nSapkKAjQychFDs4Owwm8DR1EMZNcQemWlTGoVMVCFVr5Ajja4qsNSJ+Q8M=
X-Received: by 2002:a25:7246:: with SMTP id n67mr9450363ybc.510.1621362649206;
 Tue, 18 May 2021 11:30:49 -0700 (PDT)
MIME-Version: 1.0
References: <a249699a-7c6c-4d4a-71b0-87981c8d229e@linux.alibaba.com>
 <YKKA64WWqYN3P7YJ@kernel.org> <c3520803-77af-cc34-000a-de4ba6334bcb@linux.alibaba.com>
 <YKO34fq6P8G9IyMD@kernel.org>
In-Reply-To: <YKO34fq6P8G9IyMD@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 18 May 2021 11:30:38 -0700
Message-ID: <CAEf4Bzazh4RNCY3rGRRXfO2wJ7DSiMx8w+61B_hjhu9FrOffpQ@mail.gmail.com>
Subject: Re: [PATCH] btf: Add --btf_prefix flag
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     chengshuyi <chengshuyi@linux.alibaba.com>, dwarves@vger.kernel.org,
        wenan.mao@linux.alibaba.com, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Tue, May 18, 2021 at 5:49 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Tue, May 18, 2021 at 05:02:26PM +0800, chengshuyi escreveu:
> >
> > On 2021/5/17 10:42PM, Arnaldo Carvalho de Melo wrote:
> > > Em Mon, May 17, 2021 at 08:06:30PM +0800, =E7=A8=8B=E4=B9=A6=E6=84=8F=
 escreveu:
> > > > To solve problems similar to _RH_KABI_REPLACE, _RH_KABI_REPLACE mak=
es many
> > > Can you explain what is _RH_KABI_REPLACE, why it is needed so that
> > > people unfamiliar with it can make sense of your patch?
> >
> > The _RH_KABI_REPLACE(_orig, _new) macros perserve size alignment and ka=
bi
> > agreement between _orig and _new.Below is the definition of this macro:
> >
> > # define _RH_KABI_REPLACE(_orig, _new)         \
> >      union {                        \
> >          _new;                    \
> >          struct {                \
> >              _orig;                \
> >          } __UNIQUE_ID(rh_kabi_hide);        \
> >          __RH_KABI_CHECK_SIZE_ALIGN(_orig, _new);    \
> >      }
> >
> >
> > __UNIQUE_ID uses the __COUNTER__ macro, and the __COUNTER__ macro is
> > automatically incremented by 1 every time it is precompiled. Therefore,=
 in
> > different compilation units, the same structure has different names.Her=
e is
> > a concrete example:
> >
> > struct acpi_dev_node {
> >      union {
> >          struct acpi_device *companion;
> >          struct {
> >              void *handle;
> >          } __UNIQUE_ID_rh_kabi_hide29;
> >          union {        };
> >      };
> > };
> > struct acpi_dev_node {
> >      union {
> >          struct acpi_device *companion;
> >          struct {
> >              void *handle;
> >          } __UNIQUE_ID_rh_kabi_hide31;
> >          union {        };
> >      };
> > };
> >
> > Finally, it will cause the btf algorithm to de-duplication efficiency i=
s not
> > high, and time-consuming.
> >
> > >
> > > Also why "btf_prefix" when this is related to this other feature? Can
> > > you find a better name?
> >
> > "btf_prefix" means that if two strings have the same prefix, treat them=
 as
>
> I understood what is its purpose, but pahole is not just about DWARF
> and BTF, it has an admittedly unmaintained CTF encoder that predates BTF
> and was even used as an starting point for the BTF encoder, so using BTF
> isn't appropriate, perhaps --common_prefix? Or even --kabi_prefix to
> make it even more explicit?
>

+1 for --kabi_prefix

> - Arnaldo
>
> > the same string.From the above example,if btf_prefix is
> > __UNIQUE_ID_rh_kabi_hide, then __UNIQUE_ID_rh_kabi_hide29 and
> > __UNIQUE_ID_rh_kabi_hide31 are equal.Maybe "btf_kabi_prefix_string" is
> > better
> >
> > > You also forgot to update the man page at man-pages/pahole.1.
> > >
> > > - Arnaldo
> >
> > Yes i forgot.
> >
> > > > structures have different names, resulting in a
> > > > particularly large vmlinux btf. For example, running ./pahole -J
> > > > vmlinux-3.10.0-1160.el7.x86_64 without --btf_prefix flag,
> > > > the running time is:
> > > >                  real 8m28.912s
> > > >                  user 8m27.271s
> > > >                  sys 0m1.471s
> > > > And the size of the generated btf segment is 30678240 bytes.
> > > >
> > > > After adding the patch, running ./pahole
> > > > --btf_prefix=3D__UNIQUE_ID_rh_kabi_hide -J vmlinux-3.10.0-1160.el7.=
x86_64. The
> > > > running
> > > > time of the command is:
> > > >                  real 0m19.634s
> > > >                  user 0m18.457s
> > > >                  sys 0m1.169s
> > > > The size of the generated btf segment is 3117719 bytes.
> > > >
> > > > Thanks.
> > > >
> > > > Signed-off-by: chengshuyi<chengshuyi@linux.alibaba.com>
> > > > ---
> > > >   pahole.c         | 10 ++++++++++
> > > >   pahole_strings.h |  2 ++
> > > >   strings.c        |  9 +++++++--
> > > >   3 files changed, 19 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/pahole.c b/pahole.c
> > > > index dc40ccf..0b4f4ca 100644
> > > > --- a/pahole.c
> > > > +++ b/pahole.c
> > > > @@ -24,6 +24,7 @@
> > > >   #include "btf_encoder.h"
> > > >   #include "libbtf.h"
> > > >   #include "lib/bpf/src/libbpf.h"
> > > > +#include "pahole_strings.h"
> > > >
> > > >   static bool btf_encode;
> > > >   static bool ctf_encode;
> > > > @@ -855,6 +856,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF =3D dwarves_print=
_version;
> > > >   #define ARGP_btf_gen_floats       322
> > > >   #define ARGP_btf_gen_all       323
> > > >   #define ARGP_with_flexible_array   324
> > > > +#define ARGP_btf_prefix   325
> > > >
> > > >   static const struct argp_option pahole__options[] =3D {
> > > >       {
> > > > @@ -1140,6 +1142,12 @@ static const struct argp_option pahole__opti=
ons[] =3D {
> > > >           .doc  =3D "Path to the base BTF file",
> > > >       },
> > > >       {
> > > > +        .name =3D "btf_prefix",
> > > > +        .key =3D ARGP_btf_prefix,
> > > > +        .arg =3D "STRING",
> > > > +        .doc =3D "Strings with the same prefix are considered the =
same.",
> > > > +    },
> > > > +    {
> > > >           .name =3D "btf_encode",
> > > >           .key  =3D 'J',
> > > >           .doc  =3D "Encode as BTF", @@ -1297,6 +1305,8 @@ static
> > > > error_t pahole__options_parser(int key, char *arg,
> > > > btf_encode_force =3D true;        break;      case ARGP_btf_base:
> > > >     base_btf_file =3D arg;            break; +    case
> > > > ARGP_btf_prefix: +        btf_prefix =3D arg;        break;      ca=
se
> > > > ARGP_numeric_version:          print_numeric_version =3D true;
> > > > break;      case ARGP_btf_gen_floats: diff --git a/pahole_strings.h
> > > > b/pahole_strings.h index 522fbf2..bf3dc7c 100644 ---
> > > > a/pahole_strings.h +++ b/pahole_strings.h @@ -14,6 +14,8 @@ struct
> > > > strings {      struct btf *btf;  }; +extern const char *btf_prefix;
> > > > +  struct strings *strings__new(void);  void strings__delete(struct
> > > > strings *strings); diff --git a/strings.c b/strings.c index
> > > > d37f49d..911ce25 100644 --- a/strings.c +++ b/strings.c @@ -16,6
> > > > +16,9 @@  #include "dutil.h"
> > > >   #include "lib/bpf/src/libbpf.h"
> > > > +#include "libbtf.h"
> > > Why do you need to add this new include? I guess you meant including
> > > pahole_strings.h to get the forward declaration for 'btf_prefix'?
> >
> > It is of no use, I forgot to delete it.
> >
> > > > +
> > > > +const char *btf_prefix;
> > > >
> > > >   struct strings *strings__new(void)
> > > >   {
> > > > @@ -47,8 +50,10 @@ strings_t strings__add(struct strings *strs, con=
st char
> > > > *str)
> > > >
> > > >       if (str =3D=3D NULL)
> > > >           return 0;
> > > > -
> > > > -    index =3D btf__add_str(strs->btf, str);
> > > > +    if(btf_prefix && strncmp(str,btf_prefix,strlen(btf_prefix))=3D=
=3D0)
> > > Please also follow the existing coding style, i.e. use a space after
> > > 'if' and also after the commas.
> > >
> > > - Arnaldo
> > >
> >
> > Okay, I know. If you want to receive this patch, I will send a complete
> > patch later.
> >
> > > > +        index =3D btf__add_str(strs->btf, btf_prefix);
> > > > +    else
> > > > +        index =3D btf__add_str(strs->btf, str);
> > > >       if (index < 0)
> > > >           return 0;
> > > >
> > > > --
> > > > 1.8.3.1
> > > >
> > > >
>
> --
>
> - Arnaldo
