Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04234C4361A
	for <linux-dwarves@archiver.kernel.org>; Thu,  3 Dec 2020 23:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94FDE223C8
	for <linux-dwarves@archiver.kernel.org>; Thu,  3 Dec 2020 23:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgLCXjZ (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 3 Dec 2020 18:39:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50511 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727495AbgLCXjZ (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 3 Dec 2020 18:39:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607038678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GOkNExEfqJGC/gxnW5k2ZBTTtsT71mTbidAaMq6A3fw=;
        b=IlaoFXPbIG5UNOCeFomf7+MlM9CUsXK2ljSxZLSoF492DBXRD1aLMqZurx+quT3YxJ20kl
        y+VLzBt5xpihfdbQYhpLVmInGFpsiUoa3KDzFIkIGXj73w+hktwTIx/4kSwqQFGR4aGiyW
        cQoXkGK4hezjzXa04F5W3vMGf9HyKtM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-rhCcX1EOMeGAOtCQfXfXoQ-1; Thu, 03 Dec 2020 18:37:55 -0500
X-MC-Unique: rhCcX1EOMeGAOtCQfXfXoQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A63EA190B2A5;
        Thu,  3 Dec 2020 23:37:53 +0000 (UTC)
Received: from krava (unknown [10.40.195.70])
        by smtp.corp.redhat.com (Postfix) with SMTP id BFE2A5D9CA;
        Thu,  3 Dec 2020 23:37:51 +0000 (UTC)
Date:   Fri, 4 Dec 2020 00:37:50 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH 2/3] btf_encoder: Use address size based on ELF's class
Message-ID: <20201203233750.GG3613628@krava>
References: <20201203220625.3704363-1-jolsa@kernel.org>
 <20201203220625.3704363-3-jolsa@kernel.org>
 <CAEf4BzbdB4DUJ2BKVsVdpcZHunNxb_6FvAWOFt_be=81Jyxmnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbdB4DUJ2BKVsVdpcZHunNxb_6FvAWOFt_be=81Jyxmnw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Thu, Dec 03, 2020 at 03:22:18PM -0800, Andrii Nakryiko wrote:
> On Thu, Dec 3, 2020 at 2:08 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > We can't assume the address size is always size of unsigned
> > long, we have to use directly the ELF's address size.
> >
> > Changing addrs array to __u64 and convert 32 bit address
> > values when copying from ELF section.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> 
> It looks ok to me, but I didn't expect that changes would be so
> numerous... Makes me wonder if pahole ever supported working with ELF
> files of different bitness. I'll defer to Arnaldo to make a call on
> whether this is necessary.

so to test this I built 32bit vmlinux and used 64bit pahole
to generate BTF data on both vmlinux and modules, which I
thought was valid use case

jirka

> 
> >  btf_encoder.c | 24 +++++++++++++++++-------
> >  1 file changed, 17 insertions(+), 7 deletions(-)
> >
> 
> [...]
> 

