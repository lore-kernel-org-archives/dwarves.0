Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA2DC433FE
	for <linux-dwarves@archiver.kernel.org>; Thu, 10 Dec 2020 23:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7658423100
	for <linux-dwarves@archiver.kernel.org>; Thu, 10 Dec 2020 23:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394394AbgLJXnw (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 10 Dec 2020 18:43:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35407 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393870AbgLJXng (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 10 Dec 2020 18:43:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607643726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MobA73H5OEPJoJGR5A82BMTboxXJp2LUYpdmrqO18a0=;
        b=YKPVwHlXcCmVWl29v1fcH61+zqcTBw/GbecR3zScqtLfsA4k0nns+zxbX7CA/ScbPdiT77
        hIR4Jbt+Loov0UTMA1QM6Vh3Zn9Ww7WtmAjrwgtNoxMD6YkAPtf2x0+XTBA5TKk8HSdMu2
        Ukx5v/aDdyenNvnT+oZ+o33sF7BaS6E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-lSaBO3ysOBCwCvHOLWirew-1; Thu, 10 Dec 2020 18:42:04 -0500
X-MC-Unique: lSaBO3ysOBCwCvHOLWirew-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C220192CC40;
        Thu, 10 Dec 2020 23:42:03 +0000 (UTC)
Received: from krava (unknown [10.40.192.193])
        by smtp.corp.redhat.com (Postfix) with SMTP id EA52760862;
        Thu, 10 Dec 2020 23:42:01 +0000 (UTC)
Date:   Fri, 11 Dec 2020 00:42:01 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, dwarves@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>, Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Per-CPU variables in modules and pahole
Message-ID: <20201210234201.GC186916@krava>
References: <CAEf4BzZWabv_hExaANQyQ71L2JHYqXaT4hFj52w-poWoVYWKqQ@mail.gmail.com>
 <20201210164315.GA184880@krava>
 <CAEf4BzaBOoZsSK8yGZBhwFzAADkQKsGt1quV9RvFk_+WZr=Y=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzaBOoZsSK8yGZBhwFzAADkQKsGt1quV9RvFk_+WZr=Y=Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Thu, Dec 10, 2020 at 09:02:05AM -0800, Andrii Nakryiko wrote:

SNIP

> 
> yes, ELF symbol's value is 4, but when iterating DWARF variables
> (0x10e70 + 4) is returned. It does look like a special handling of
> modules. I missed that libdw does some special things for specifically
> modules. Further debugging yesterday showed that 0x10e70 roughly
> corresponds to the offset of .data..per_cpu if you count all the
> allocatable data sections that come before it. So I think you are
> right. We should probably centralize the logic of kernel module
> detection so that we can handle these module vs non-module differences
> properly.
> 
> >
> > not sure this is related but looks like similar issue I had to
> > solve for modules functions, as described in the changelog:
> > (not merged yet)
> >
> >     btf_encoder: Detect kernel module ftrace addresses
> >
> >     ...
> >     There's one tricky point with kernel modules wrt Elf object,
> >     which we get from dwfl_module_getelf function. This function
> >     performs all possible relocations, including __mcount_loc
> >     section.
> >
> >     So addrs array contains relocated values, which we need take
> >     into account when we compare them to functions values which
> >     are relative to their sections.
> >     ...
> >
> > The 0x10e74 value could be relocated 4.. but it's me guessing,
> > because not sure where you see that address exactly
> 
> 
> It comes up in cu__encode_btf(), var->ip.addr is not 4, as we expect it to be.

I'm taking section sh_addr for each function and relocate
the addr value for kernel modules, check setup_functions
function

I don't see this being somehow centralized, looks simple
enough to me for each case

jirka

