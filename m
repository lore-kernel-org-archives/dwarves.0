Return-Path: <SRS0=0CUe=EJ=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501A1C388F9
	for <linux-dwarves@archiver.kernel.org>; Tue,  3 Nov 2020 19:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 012A4216C4
	for <linux-dwarves@archiver.kernel.org>; Tue,  3 Nov 2020 19:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I3ojdUnG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgKCTe1 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 3 Nov 2020 14:34:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28482 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725957AbgKCTe1 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 3 Nov 2020 14:34:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604432066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zTaA5gUZSRFLtoUCw2qbfO/TZcEBTod+GMbYlqinI7g=;
        b=I3ojdUnGKs6mh+zk1xHAy+wYX5NT3Hyk4k42oUIK6alBc+hN8zMdWJf3PLgB/JlbuUeHj3
        QUEijpvh30/iLFiTkNCh7YBzd9yetMPrB+YEhILgzbxCeZtFK8nuey+W2CuGdBPgcmR8IC
        ZTL1QGNwUAqZVmx/1r8dtTRyqRkLrSg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-fkmvn8AjM7mgMTg7P7cAbw-1; Tue, 03 Nov 2020 14:34:22 -0500
X-MC-Unique: fkmvn8AjM7mgMTg7P7cAbw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FB5A189942A;
        Tue,  3 Nov 2020 19:34:21 +0000 (UTC)
Received: from krava (unknown [10.40.195.210])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6E2D51A4D6;
        Tue,  3 Nov 2020 19:34:15 +0000 (UTC)
Date:   Tue, 3 Nov 2020 20:34:14 +0100
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
Message-ID: <20201103193414.GK3597846@krava>
References: <20201031223131.3398153-1-jolsa@kernel.org>
 <20201031223131.3398153-3-jolsa@kernel.org>
 <20201102215908.GC3597846@krava>
 <20201102225658.GD3597846@krava>
 <CAEf4BzbdGwogFQiLE2eH9ER67hne7NgW4S8miYBM4CRb8NDPvg@mail.gmail.com>
 <20201103190559.GI3597846@krava>
 <CAEf4BzbMOzAdsyMT736idoGnJ1RuxRa5y9wf-egh+LKz406m1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbMOzAdsyMT736idoGnJ1RuxRa5y9wf-egh+LKz406m1g@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Tue, Nov 03, 2020 at 11:23:33AM -0800, Andrii Nakryiko wrote:

SNIP

> > > on what's missing and why it shouldn't be missing?
> >
> > yes, it's just a hack, we should do something more
> > robust as I mentioned above
> >
> > it just allowed me to use iterators finaly ;-)
> 
> sure, I get it, I was just trying to understand why there is such a
> problem in the first place. Turns out we need FUNCs not just for
> fentry/fexit and similar, but also for bpf_iter, which is an entirely
> different use case (similar to raw_tp, but raw_tp is using typedef ->
> func_proto approach).
> 
> So I don't know, we might as well just not do mcount checks?.. As an
> alternative, but it's not great as well.

how about moving all such functions to separate new .init.XXX section,
and pahole would make one extr acheck for that.. and it still gets freed

jirka

