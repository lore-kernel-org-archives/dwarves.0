Return-Path: <SRS0=Yf7w=DH=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE88BC2D0A8
	for <linux-dwarves@archiver.kernel.org>; Wed, 30 Sep 2020 06:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 797762075F
	for <linux-dwarves@archiver.kernel.org>; Wed, 30 Sep 2020 06:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="llZK/vqr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725440AbgI3Gwp (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 30 Sep 2020 02:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgI3Gwp (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 30 Sep 2020 02:52:45 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0006AC061755
        for <dwarves@vger.kernel.org>; Tue, 29 Sep 2020 23:52:44 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id o9so546928ils.9
        for <dwarves@vger.kernel.org>; Tue, 29 Sep 2020 23:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4zULESygbJPeLKVaJcKPYPzZZhi9BsHJAYHkiuEl7Ck=;
        b=llZK/vqrvX7EJ2Fx73FyHtN0wF5V+fh6Ufc5euw5+Yh69xtPGs5BAtVqVlPe7xblZq
         IdQeIxk1LZgYWH0Numm5VPsxFqigpga7me+bunULUMWpZmQUvKM5RAaBSSq9vvdRls6c
         K7s55Plm+GCpf668jGkkX1Ob8Tp2oLbqsGrRuULfHPQQe6NAByy0+lZjd1EIwKwP6QkT
         tlg2DlfVrrBtD41uiIBMVLGI2HA0zBOBqWSTmzst3tCRr15PWMwPKVW3Qb8n0Pn2ANYR
         0u9x8nHbOkGrWX4jGijFIKnIUeCG+Z5MbY6m6Cp4aPlzaeFG+ij42mN8keoaO4gZdE3V
         fqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4zULESygbJPeLKVaJcKPYPzZZhi9BsHJAYHkiuEl7Ck=;
        b=AFSYe0uXHJBeb+BZEujqZXwfiUuulHisRkSuAhFcmcRUKJgEr2EvhMGetqV9pvSjkM
         6ayW0vhvluGM+qUlCgFD0gsVXbdCd63j48GKsrmlIr0thiYmLBDfupeef/IGYwVX9IXL
         N9f7sW7whdz+ngHTfed5B96gt0QZIRTrUMV4uQmWSoP7JEM/EnBJGeKykwH0aifxC0Oe
         aK54D5cstbT4vF6jH856f/CURRshzGbMr0wKfzG7/5qN5iVz27Rq/XubzO4VUcIsqeH2
         P8tMsGyRYUH7wriXDYeINO8IJ/uqgqGkrWsLOONaMqJq2jpZjUupZQ7Lx4osXsF7SllH
         gEZw==
X-Gm-Message-State: AOAM5318Dm6Eb/M65WkvP7ycPLKVBJF0ne7QBVWQ1IUXrxdV60xUredY
        2GDf+9TqVGdgIOVi3P07knlBHi8km+Q5rxjAMFQvog==
X-Google-Smtp-Source: ABdhPJyQ+qd7GE4oQLxpXvjIG2ua9olmZ4LRevDs9O4efp60C+YkAR7a1tSBre2v7+Bd0JTe3Ib+9cpEy1u5eWpzxGg=
X-Received: by 2002:a92:d105:: with SMTP id a5mr887392ilb.206.1601448763538;
 Tue, 29 Sep 2020 23:52:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200825004523.1353133-1-haoluo@google.com> <20200826131143.GF1059382@kernel.org>
 <CA+khW7jf7Z=sMC1u5eyn6XOZDTFJaNjV-D0ogvQSyUGSKjC3LQ@mail.gmail.com> <DEC4CC81-88CE-4476-A631-2BBB6E922F5C@gmail.com>
In-Reply-To: <DEC4CC81-88CE-4476-A631-2BBB6E922F5C@gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 29 Sep 2020 23:52:32 -0700
Message-ID: <CA+khW7imZ+1to15Y+6Suw5_RRQfOQ32X_mkcFACDedjHrNYFaQ@mail.gmail.com>
Subject: Re: [PATCH v1] btf_encoder: Handle DW_TAG_variable that has DW_AT_specification
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>, dwarves@vger.kernel.org,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Arnaldo,

Is this patch ready to be merged into Pahole's master branch? Alexei
is testing the kernel patches that need this patch. Please let me know
if there is anything I can do to help merging.

Thank you,
Hao

On Wed, Aug 26, 2020 at 6:56 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
>
>
> On August 26, 2020 3:35:17 PM GMT-03:00, Hao Luo <haoluo@google.com> wrote:
> >Arnaldo,
> >
> >On Wed, Aug 26, 2020 at 6:12 AM Arnaldo Carvalho de Melo
> ><acme@kernel.org> wrote:
> >>
> >> Em Mon, Aug 24, 2020 at 05:45:23PM -0700, Hao Luo escreveu:
> >> > It is found on gcc 8.2 that global percpu variables generate the
> >> > following dwarf entry in the cu where the variable is defined[1].
> >> >
> >> > Take the global variable "bpf_prog_active" defined in
> >> > kernel/bpf/syscall.c as an example. The debug info for syscall.c
> >> > has two dwarf entries for "bpf_prog_active".
> >> >
> >[...]
> >>
> >> Interesting, here I get, with binutils' readelf:
> >>
> >> [root@quaco perf]# readelf -wi
> >../build/v5.8-rc5+/kernel/bpf/syscall.o | grep bpf_prog_active
> >>     <f6a1>   DW_AT_name        : (indirect string, offset: 0xb70d):
> >bpf_prog_active
> >> [root@quaco perf]#
> >>
> >> Just one, as:
> >>
> >> [root@quaco perf]# readelf -wi
> >../build/v5.8-rc5+/kernel/bpf/syscall.o | grep bpf_prog_active -B1 -A8
> >>  <1><f6a0>: Abbrev Number: 103 (DW_TAG_variable)
> >>     <f6a1>   DW_AT_name        : (indirect string, offset: 0xb70d):
> >bpf_prog_active
> >>     <f6a5>   DW_AT_decl_file   : 11
> >>     <f6a6>   DW_AT_decl_line   : 1008
> >>     <f6a8>   DW_AT_decl_column : 1
> >>     <f6a9>   DW_AT_type        : <0xcf>
> >>     <f6ad>   DW_AT_external    : 1
> >>     <f6ad>   DW_AT_declaration : 1
> >>  <1><f6ad>: Abbrev Number: 103 (DW_TAG_variable)
> >>     <f6ae>   DW_AT_name        : (indirect string, offset: 0x3a5d):
> >bpf_stats_enabled_mutex
> >> [root@quaco perf]#
> >>
> >> I get what you have when I use elfutils' readelf:
> >>
> >> [root@quaco perf]# eu-readelf -winfo
> >../build/v5.8-rc5+/kernel/bpf/syscall.o | grep bpf_prog_active
> >>              name                 (strp) "bpf_prog_active"
> >>               [ 0] addr .data..percpu+0 <bpf_prog_active>
> >> [root@quaco perf]#
> >>
> >> [root@quaco perf]# eu-readelf -winfo
> >../build/v5.8-rc5+/kernel/bpf/syscall.o | grep -B1 -A8
> >\"bpf_prog_active\"
> >>  [  f6a0]    variable             abbrev: 103
> >>              name                 (strp) "bpf_prog_active"
> >>              decl_file            (data1) bpf.h (11)
> >>              decl_line            (data2) 1008
> >>              decl_column          (data1) 1
> >>              type                 (ref4) [    cf]
> >>              external             (flag_present) yes
> >>              declaration          (flag_present) yes
> >>  [  f6ad]    variable             abbrev: 103
> >>              name                 (strp) "bpf_stats_enabled_mutex"
> >> [root@quaco perf]#
> >>
> >> And:
> >>
> >> [root@quaco perf]# eu-readelf -winfo
> >../build/v5.8-rc5+/kernel/bpf/syscall.o | grep -B5 \<bpf_prog_active\>
> >>  [ 1bdf5]    variable             abbrev: 212
> >>              specification        (ref4) [  f6a0]
> >>              decl_file            (data1) syscall.c (1)
> >>              decl_line            (data1) 43
> >>              location             (exprloc)
> >>               [ 0] addr .data..percpu+0 <bpf_prog_active>
> >> [root@quaco perf]#
> >>
> >
> >In binutils readelf, there is a extra entry
>
> Not here, tomorrow I'll triple check.
>
> >
> > <1><1b24c>: Abbrev Number: 195 (DW_TAG_variable)
> >    <1b24e>   DW_AT_specification: <0xf335>
> >    <1b252>   DW_AT_decl_file   : 1
> >    <1b253>   DW_AT_decl_line   : 43
> >    <1b254>   DW_AT_location    : 9 byte block: 3 0 0 0 0 0 0 0 0
> > (DW_OP_addr: 0)
> >
> >which points to
> >
> > <1><f335>: Abbrev Number: 95 (DW_TAG_variable)
> >    <f336>   DW_AT_name        : (indirect string, offset: 0xb37a):
> >bpf_prog_active
> >
> >It just doesn't have the string 'bpf_prog_active', annotating entry.
> >So eu-readelf and binutils readelf have the same results.
> >
> >> > Note that second DW_TAG_variable entry contains specification that
> >> > points to the first entry.
> >>
> >> So you are not considering the first when encoding since it is just a
> >> DW_AT_declaration, considers the second, as it should be, and then
> >needs
> >> to go see its DW_AT_specification, right?
> >>
> >> Sounds correct, applying, will test further and then push out,
> >>
> >
> >Yes, exactly. The var tags to be considered are those that either have
> >DW_AT_specification or not have DW_AT_declaration. This makes sure
> >btf_encoder works correctly on both old and new gcc.
> >
> >> Thanks,
> >>
> >> - Arnaldo
> >
> >Suggested by Yonghong, I tested this change on a larger set of
> >compilers this time and works correctly. See below.
> >
> >Could you also add 'Reported-by: Yonghong Song <yhs@fb.com>'? I should
> >have done that when sending out this patch. The credit goes to
> >Yonghong.
>
> Sure, and I'll add your results with different computers, for the record.
>
> Thanks,
>
> - Arnaldo
> >
> >Thank you,
> >Hao
> >
> >  clang 10:
> >  [67] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> >  [20168] VAR 'bpf_prog_active' type_id=67, linkage=global-alloc
> >
> >  clang 9:
> >  [64] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> >  [19789] VAR 'bpf_prog_active' type_id=64, linkage=global-alloc
> >
> >  gcc 10.2
> >  [18] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> >  [20319] VAR 'bpf_prog_active' type_id=18, linkage=global-alloc
> >
> >  gcc 9.3:
> >  [21] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> >  [21085] VAR 'bpf_prog_active' type_id=21, linkage=global-alloc
> >
> >  gcc 8
> >  [21] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> >  [21084] VAR 'bpf_prog_active' type_id=21, linkage=global-alloc
> >
> >  gcc 6.2
> >  [22] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> >  [21083] VAR 'bpf_prog_active' type_id=22, linkage=global-alloc
> >
> >  gcc 4.9
> >  [17] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> >  [20410] VAR 'bpf_prog_active' type_id=17, linkage=global-alloc
>
> --
> Sent from my Android device with K-9 Mail. Please excuse my brevity.
