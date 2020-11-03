Return-Path: <SRS0=0CUe=EJ=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EEBC2D0A3
	for <linux-dwarves@archiver.kernel.org>; Tue,  3 Nov 2020 23:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A44EF21556
	for <linux-dwarves@archiver.kernel.org>; Tue,  3 Nov 2020 23:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RrE1RZRL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbgKCXWf (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 3 Nov 2020 18:22:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26989 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727979AbgKCXWf (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 3 Nov 2020 18:22:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604445753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=504XQwC/We/dKHvQORWDDh2P/9Gm+0bTHB8Sjp+1HBQ=;
        b=RrE1RZRLbpY1QASixucb88K8R08OkLcP3u0Vq0BvXio5JR2vcJw6JfLdGK+BqdwC3DN8PH
        gPQMr0YDdWRdNTU3CXElcr7TR//Q7fy8hDkoncIaMLjYR05Ek8AQHBMVR9zwHkf1IywM7U
        cdh3qAXDt6gBsZDkoi9Qx/1Jffrm9I0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-pAQNi2VvOva68PHdITMK3w-1; Tue, 03 Nov 2020 18:22:31 -0500
X-MC-Unique: pAQNi2VvOva68PHdITMK3w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F160780401F;
        Tue,  3 Nov 2020 23:22:29 +0000 (UTC)
Received: from krava (unknown [10.40.195.210])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6FE935D9DC;
        Tue,  3 Nov 2020 23:22:24 +0000 (UTC)
Date:   Wed, 4 Nov 2020 00:22:23 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Subject: Re: [PATCH 2/2] btf_encoder: Change functions check due to broken
 dwarf
Message-ID: <20201103232223.GB3861143@krava>
References: <20201031223131.3398153-1-jolsa@kernel.org>
 <20201031223131.3398153-3-jolsa@kernel.org>
 <CAEf4BzYeaiQJ+-NCtCK4wB-2ia3U40RtTWez6c7osCuzpy11Zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYeaiQJ+-NCtCK4wB-2ia3U40RtTWez6c7osCuzpy11Zg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Tue, Nov 03, 2020 at 10:55:58AM -0800, Andrii Nakryiko wrote:

SNIP

> > I can still see several differences to ftrace functions in
> > /sys/kernel/debug/tracing/available_filter_functions file:
> >
> >   - available_filter_functions includes modules (7086 functions)
> >   - available_filter_functions includes functions like:
> >       __acpi_match_device.part.0.constprop.0
> >       acpi_ns_check_sorted_list.constprop.0
> >       acpi_os_unmap_generic_address.part.0
> >       acpiphp_check_bridge.part.0
> >
> >     which are not part of dwarf data (1164 functions)
> >   - BTF includes multiple functions like:
> >       __clk_register_clkdev
> >       clk_register_clkdev
> >
> >     which share same code so they appear just as single function
> >     in available_filter_functions, but dwarf keeps track of both
> >     of them (16 functions)
> >
> > With this change I'm getting 38334 BTF functions, which
> > when added above functions to consideration gives same
> > amount of functions in available_filter_functions.
> >
> > The patch still keeps the original function filter condition
> > (that uses current fn->declaration check) in case the object
> > does not contain *_mcount_loc symbol -> object is not vmlinux.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  btf_encoder.c | 222 +++++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 220 insertions(+), 2 deletions(-)
> 
> [...]
> 
> > +static int collect_function(struct btf_elf *btfe, GElf_Sym *sym)
> > +{
> > +       if (elf_sym__type(sym) != STT_FUNC)
> > +               return 0;
> > +       if (!elf_sym__value(sym))
> > +               return 0;
> > +
> > +       if (functions_cnt == functions_alloc) {
> > +               functions_alloc = max(1000, functions_alloc * 3 / 2);
> > +               functions = realloc(functions, functions_alloc * sizeof(*functions));
> > +               if (!functions)
> > +                       return -1;

ok, I thought that if we go down I don't need to,
but I did not check how pahole is handling this,
probably free everything

> 
> memory leak right here. You need to use a temporary variable and check
> if for NULL, before overwriting functions.
> 
> > +       }
> > +
> > +       functions[functions_cnt].name = elf_sym__name(sym, btfe->symtab);
> > +       functions[functions_cnt].addr = elf_sym__value(sym);
> > +       functions[functions_cnt].generated = false;
> > +       functions[functions_cnt].valid = false;
> > +       functions_cnt++;
> > +       return 0;
> > +}
> > +
> > +static int addrs_cmp(const void *_a, const void *_b)
> > +{
> > +       const unsigned long *a = _a;
> > +       const unsigned long *b = _b;
> > +
> > +       return *a - *b;
> 
> this is cute, but is it always correct? instead of thinking how this
> works with overflows, maybe let's keep it simple with
> 
> if (*a == *b)
>   return 0;
> return *a < *b ? -1 : 1;

sure, will fix

> 
> ?
> 
> > +}
> > +
> > +static int filter_functions(struct btf_elf *btfe, struct mcount_symbols *ms)
> > +{
> > +       bool init_filter = ms->init_begin && ms->init_end;
> > +       unsigned long *addrs, count, offset, i;
> > +       Elf_Data *data;
> > +       GElf_Shdr shdr;
> > +       Elf_Scn *sec;
> > +
> > +       /*
> > +        * Find mcount addressed marked by __start_mcount_loc
> > +        * and __stop_mcount_loc symbols and load them into
> > +        * sorted array.
> > +        */
> > +       sec = elf_getscn(btfe->elf, ms->start_section);
> > +       if (!sec || !gelf_getshdr(sec, &shdr)) {
> > +               fprintf(stderr, "Failed to get section(%lu) header.\n",
> > +                       ms->start_section);
> > +               return -1;
> > +       }
> > +
> > +       offset = ms->start - shdr.sh_addr;
> > +       count  = (ms->stop - ms->start) / 8;
> > +
> > +       data = elf_getdata(sec, 0);
> > +       if (!data) {
> > +               fprintf(stderr, "Failed to section(%lu) data.\n",
> 
> typo: failed to get?

yep

> 
> > +                       ms->start_section);
> > +               return -1;
> > +       }
> > +
> > +       addrs = malloc(count * sizeof(addrs[0]));
> > +       if (!addrs) {
> > +               fprintf(stderr, "Failed to allocate memory for ftrace addresses.\n");
> > +               return -1;
> > +       }
> > +
> 
> [...]
> 
> >
> > +#define SET_SYMBOL(__sym, __var)                                               \
> > +       if (!ms->__var && !strcmp(__sym, elf_sym__name(sym, btfe->symtab)))     \
> > +               ms->__var = sym->st_value;                                      \
> > +
> > +static void collect_mcount_symbol(GElf_Sym *sym, struct mcount_symbols *ms)
> > +{
> > +       if (!ms->start &&
> > +           !strcmp("__start_mcount_loc", elf_sym__name(sym, btfe->symtab))) {
> > +               ms->start = sym->st_value;
> > +               ms->start_section = sym->st_shndx;
> > +       }
> > +       SET_SYMBOL("__stop_mcount_loc", stop)
> > +       SET_SYMBOL("__init_begin", init_begin)
> > +       SET_SYMBOL("__init_end", init_end)
> 
> please don't use macro here, it doesn't save much code but complicates
> reading it quite significantly

ok

> 
> > +}
> > +
> > +#undef SET_SYMBOL
> > +
> >  static int collect_symbols(struct btf_elf *btfe, bool collect_percpu_vars)
> >  {
> > +       struct mcount_symbols ms = { };
> >         uint32_t core_id;
> >         GElf_Sym sym;
> >
> > @@ -320,6 +485,9 @@ static int collect_symbols(struct btf_elf *btfe, bool collect_percpu_vars)
> >         elf_symtab__for_each_symbol(btfe->symtab, core_id, sym) {
> >                 if (collect_percpu_vars && collect_percpu_var(btfe, &sym))
> >                         return -1;
> > +               if (collect_function(btfe, &sym))
> > +                       return -1;
> > +               collect_mcount_symbol(&sym, &ms);
> >         }
> >
> >         if (collect_percpu_vars) {
> > @@ -329,9 +497,34 @@ static int collect_symbols(struct btf_elf *btfe, bool collect_percpu_vars)
> >                 if (btf_elf__verbose)
> >                         printf("Found %d per-CPU variables!\n", percpu_var_cnt);
> >         }
> > +
> > +       if (functions_cnt) {
> > +               qsort(functions, functions_cnt, sizeof(functions[0]), functions_cmp);
> > +               if (ms.start && ms.stop &&
> > +                   filter_functions(btfe, &ms)) {
> 
> nit: single line should fit well, no?

ook

thanks,
jirka

