Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CA1C433B4
	for <linux-dwarves@archiver.kernel.org>; Sat,  1 May 2021 22:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73A8D61466
	for <linux-dwarves@archiver.kernel.org>; Sat,  1 May 2021 22:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbhEAWYu (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Sat, 1 May 2021 18:24:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46006 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231593AbhEAWYu (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Sat, 1 May 2021 18:24:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619907839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+MedoDODyMEto3dKCGmECCaYVpeBj8F55MahbTKAz34=;
        b=ADx6katHOogtOUAfJYqYkOKmE6xgCP1iLzc3YsAElMsE/XesdetWkGPxoe7j5lJ31dSEs3
        L3Akq3FnszCGJtFiTfyW3sdNXWqUgH+bThAeLM+QVXToTOfpjP33Kp3pfXl01eJpaPeVpu
        4AyEKKcPe8B/Z5qrhhJi/q69ouxmUic=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-Mca2dzhaOTikoG9ICueiBQ-1; Sat, 01 May 2021 18:23:56 -0400
X-MC-Unique: Mca2dzhaOTikoG9ICueiBQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D06C0501FE;
        Sat,  1 May 2021 22:23:54 +0000 (UTC)
Received: from krava (unknown [10.40.192.65])
        by smtp.corp.redhat.com (Postfix) with SMTP id 25FA0501DD;
        Sat,  1 May 2021 22:23:52 +0000 (UTC)
Date:   Sun, 2 May 2021 00:23:52 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH dwarves] btf: Generate btf for functions in the .BTF_ids
 section
Message-ID: <YI3U+Ffh9O1VFsOW@krava>
References: <20210423213728.3538141-1-kafai@fb.com>
 <CAEf4BzY16ziMkOMdNGNjQOmiACF3E5nFn2LhtUUQbo-y-AP7Tg@mail.gmail.com>
 <YIf3rHTLqW7yZxFJ@krava>
 <20210501001653.x3b4rk4vk4iqv3n7@kafai-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210501001653.x3b4rk4vk4iqv3n7@kafai-mbp.dhcp.thefacebook.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Fri, Apr 30, 2021 at 05:16:53PM -0700, Martin KaFai Lau wrote:
> On Tue, Apr 27, 2021 at 01:38:20PM +0200, Jiri Olsa wrote:
> > On Mon, Apr 26, 2021 at 04:26:11PM -0700, Andrii Nakryiko wrote:
> > > On Fri, Apr 23, 2021 at 2:37 PM Martin KaFai Lau <kafai@fb.com> wrote:
> > > >
> > > > BTF is currently generated for functions that are in ftrace list
> > > > or extern.
> > > >
> > > > A recent use case also needs BTF generated for functions included in
> > > > allowlist.  In particular, the kernel
> > > > commit e78aea8b2170 ("bpf: tcp: Put some tcp cong functions in allowlist for bpf-tcp-cc")
> > > > allows bpf program to directly call a few tcp cc kernel functions.  Those
> > > > functions are specified under an ELF section .BTF_ids.  The symbols
> > > > in this ELF section is like __BTF_ID__func__<kernel_func>__[digit]+.
> > > > For example, __BTF_ID__func__cubictcp_init__1.  Those kernel
> > > > functions are currently allowed only if CONFIG_DYNAMIC_FTRACE is
> > > > set to ensure they are in the ftrace list but this kconfig dependency
> > > > is unnecessary.
> > > >
> > > > pahole can generate BTF for those kernel functions if it knows they
> > > > are in the allowlist.  This patch is to capture those symbols
> > > > in the .BTF_ids section and generate BTF for them.
> > > >
> > > > Cc: Andrii Nakryiko <andrii@kernel.org>
> > > > Signed-off-by: Martin KaFai Lau <kafai@fb.com>
> > > > ---
> > > 
> > > I wonder if we just record all functions how bad that would be. Jiri,
> > > do you remember from the time you were experimenting with static
> > > functions how much more functions we'd be recording if we didn't do
> > > ftrace filtering?
> > 
> > hum, I can't find that.. but should be just matter of removing
> > that is_ftrace_func check
> In my kconfig, by ignoring is_ftrace_func(),
> number of FUNC: 40643 vs 46225
> 
> I would say skip the ftrace filtering instead of my current patch.  Thoughts?
> 

I tested on arm and got 25022 vs 55812 ;-)
and of course it fixes the compilation issue with cubictcp_state

I checked the pahole changelog and the original idea was to have only
traceable functions in BTF, but we need more than that now, so I'm ok
to skip the ftrace filter

jirka

