Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0110C433ED
	for <linux-dwarves@archiver.kernel.org>; Thu,  1 Apr 2021 19:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 900D4601FD
	for <linux-dwarves@archiver.kernel.org>; Thu,  1 Apr 2021 19:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234798AbhDAT0v (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 1 Apr 2021 15:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234724AbhDAT0o (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 1 Apr 2021 15:26:44 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245ECC08EA72
        for <dwarves@vger.kernel.org>; Thu,  1 Apr 2021 11:52:18 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id o126so4390655lfa.0
        for <dwarves@vger.kernel.org>; Thu, 01 Apr 2021 11:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Q79yaLa6qiQxBv9b9MkvioXf2LOU6WkhvfG8/Umzb4=;
        b=HC6Gds+eSDjH+muA5S2kexIFZZzflJIO1bT0aF6AH24Tcz+d1+wm872mnciOF5deng
         PK5JZXM5T93lfkRPKea99QWrDfzXGBGQzrbfmfIxAJs60/vZNH498A/SnMGx7gla3YwQ
         uK7L9V+aWiApQaCawfKOkf+pQBYwapPsUJHZ9nvtm33/e0xnxficI/Nd71jpDj0eXCl/
         T/DJJaeurUeQMFNDnARPkdVbOeQoFcbr3SB+ufTXudVnWtZeG5jTRTx1Kkdze2JE8kkX
         dYRjmI+jdrpUTFFmlZlvcYCuAgb2fOlQKcWM7aOlLZpqcck4k0hJlLwuE0K6udpgjcvD
         ETRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Q79yaLa6qiQxBv9b9MkvioXf2LOU6WkhvfG8/Umzb4=;
        b=oehugYbjIExGdCyEhGgAeuwzNRM4ux5lL356f/LAN8p4PnuLFi2aXzxLYICxFt0DNp
         jQl9d7SKRSNMmwAEpmq1JAaKvXICSLHluGVmPSIlIzZAsnCTdQiN7LPWiS7Lbl1BC2uP
         eU8J6PA11qCazee9Bsr8pmbg1Q1vN4lwXXXfjNrl3lGi+Xla++J/FYdudvCBTmtOsx9t
         aPAbGEWMz1JjumpFrEvKYaX+n6rWMYhF1iuV64mZs+B0hcg8ALb0+IihF7bjvMEAqV8X
         QgGTnfWzCHWjecnvrq9iN6AKgcbsLHsAp52BFZ/MCoQUcKsSHfvDKfzi1UXKvfvfAdHE
         w8eA==
X-Gm-Message-State: AOAM530wMfVkW2GZynKjAtONuV72v/xY45SRVTjTX458Cv54HuUHEsTP
        EE/jUkVsD01uSnRwX4dnDybLGAvR0KP8S61NgQ6BHA==
X-Google-Smtp-Source: ABdhPJx9MrQV+dN7F49wOAUNPCOKxeFdRMAvYCyScitDuCU6uGcvX1leOCGXUbV2LcBs62W/8nAQkTIEbGP6xxvaqmA=
X-Received: by 2002:ac2:538e:: with SMTP id g14mr6185269lfh.543.1617303136216;
 Thu, 01 Apr 2021 11:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210401025815.2254256-1-yhs@fb.com> <20210401025820.2254482-1-yhs@fb.com>
In-Reply-To: <20210401025820.2254482-1-yhs@fb.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 1 Apr 2021 11:52:05 -0700
Message-ID: <CAKwvOd=mzDREDAXCxdFzSWnxC1hNc7udMXc7Lrf50qmJk9zE7Q@mail.gmail.com>
Subject: Re: [PATCH dwarves 1/2] dwarf_loader: check .debug_abbrev for
 cross-cu references
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bill Wendling <morbo@google.com>, bpf <bpf@vger.kernel.org>,
        David Blaikie <dblaikie@gmail.com>,
        =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        kernel-team@fb.com, David Blaikie <blaikie@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Wed, Mar 31, 2021 at 7:58 PM Yonghong Song <yhs@fb.com> wrote:
>
> Commit 39227909db3c checked compilation flags to see
> whether the binary is built with lto or not (-flto).
> Currently, for clang lto build, default setting
> won't put compilation flags in dwarf due to size
> concern.
>
> David Blaikie suggested in [1] to scan through .debug_abbrev
> for DW_FORM_ref_addr which should be most faster than
> scanning through cu's. This patch implemented this
> suggestion and replaced the previous compilation flag
> matching approach. Indeed, it seems that the overhead
> for this approach is indeed managable.
>
> I did some change to measure the overhead of cus_merging_cu():
>   @@ -2650,7 +2652,15 @@ static int cus__load_module(struct cus *cus, struct conf_load *conf,
>                   }
>           }
>
>   -       if (cus__merging_cu(dw)) {
>   +       bool do_merging;
>   +       struct timeval start, end;
>   +       gettimeofday(&start, NULL);
>   +       do_merging = cus__merging_cu(dw);
>   +       gettimeofday(&end, NULL);
>   +       fprintf(stderr, "%ld %ld -> %ld %ld\n", start.tv_sec, start.tv_usec,
>   +                       end.tv_sec, end.tv_usec);
>   +
>   +       if (do_merging) {
>                   res = cus__merge_and_process_cu(cus, conf, mod, dw, elf, filename,
>                                                   build_id, build_id_len,
>                                                   type_cu ? &type_dcu : NULL);
>
> For lto vmlinux, the cus__merging_cu() checking takes
> 130us over total "pahole -J vmlinux" time 65sec as the function bail out
> earlier due to detecting a merging cu condition.
> For non-lto vmlinux, the cus__merging_cu() checking takes
> ~171368us over total pahole time 36sec, roughly 0.5% overhead.
>
>  [1] https://lore.kernel.org/bpf/20210328064121.2062927-1-yhs@fb.com/
>

It might be a nice little touch to add:

Suggested-by: David Blaikie <blaikie@google.com>

> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  dwarf_loader.c | 43 ++++++++++++++++++++++++-------------------
>  1 file changed, 24 insertions(+), 19 deletions(-)
>
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index c1ca1a3..bd23751 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -2503,35 +2503,40 @@ static int cus__load_debug_types(struct cus *cus, struct conf_load *conf,
>
>  static bool cus__merging_cu(Dwarf *dw)
>  {
> -       uint8_t pointer_size, offset_size;
>         Dwarf_Off off = 0, noff;
>         size_t cuhl;
> -       int cnt = 0;
>
> -       /*
> -        * Just checking the first cu is not enough.
> -        * In linux, some C files may have LTO is disabled, e.g.,
> -        *   e242db40be27  x86, vdso: disable LTO only for vDSO
> -        *   d2dcd3e37475  x86, cpu: disable LTO for cpu.c
> -        * Fortunately, disabling LTO for a particular file in a LTO build
> -        * is rather an exception. Iterating 5 cu's to check whether
> -        * LTO is used or not should be enough.
> -        */
> -       while (dwarf_nextcu(dw, off, &noff, &cuhl, NULL, &pointer_size,
> -                           &offset_size) == 0) {
> +       while (dwarf_nextcu (dw, off, &noff, &cuhl, NULL, NULL, NULL) == 0) {
>                 Dwarf_Die die_mem;
>                 Dwarf_Die *cu_die = dwarf_offdie(dw, off + cuhl, &die_mem);
>
>                 if (cu_die == NULL)
>                         break;
>
> -               if (++cnt > 5)
> -                       break;
> +               Dwarf_Off offset = 0;
> +               while (true) {
> +                       size_t length;
> +                       Dwarf_Abbrev *abbrev = dwarf_getabbrev (cu_die, offset, &length);
> +                       if (abbrev == NULL || abbrev == DWARF_END_ABBREV)
> +                               break;
>
> -               const char *producer = attr_string(cu_die, DW_AT_producer);
> -               if (strstr(producer, "clang version") != NULL &&
> -                   strstr(producer, "-flto") != NULL)
> -                       return true;
> +                       size_t attrcnt;
> +                       if (dwarf_getattrcnt (abbrev, &attrcnt) != 0)
> +                               return false;
> +
> +                       unsigned int attr_num, attr_form;
> +                       Dwarf_Off aboffset;
> +                       size_t j;
> +                       for (j = 0; j < attrcnt; ++j) {
> +                               if (dwarf_getabbrevattr (abbrev, j, &attr_num, &attr_form,
> +                                                        &aboffset))
> +                                       return false;
> +                               if (attr_form == DW_FORM_ref_addr)
> +                                       return true;
> +                       }
> +
> +                       offset += length;
> +               }
>
>                 off = noff;
>         }
> --
> 2.30.2
>


-- 
Thanks,
~Nick Desaulniers
