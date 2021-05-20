Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916E7C433ED
	for <linux-dwarves@archiver.kernel.org>; Thu, 20 May 2021 12:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F50A61186
	for <linux-dwarves@archiver.kernel.org>; Thu, 20 May 2021 12:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbhETMUT (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 20 May 2021 08:20:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30639 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231808AbhETMTx (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 20 May 2021 08:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621513111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QX5XLtg1vtigHl8P5T36QOe4CoZL1USlmhJHy1Y8Wzk=;
        b=SldXVKh38Z6qCPyU4aiXvV8DFWKx5ZbrRlkr0fJySfwdd+09T4sZ5XsTFd44f2087R63Jy
        D4jr9K21YyzN8LUBt0NwCcv9wLk2BRVF75Lr6obJjjygRkW1hngkXMZekv6PlxSqz1+jgY
        eRv/+KaIvyUT/iZvXB/QEuQjs/uh10g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-7neSnZf6PWeSbnbZpqdDhg-1; Thu, 20 May 2021 08:18:25 -0400
X-MC-Unique: 7neSnZf6PWeSbnbZpqdDhg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B622803621;
        Thu, 20 May 2021 12:18:24 +0000 (UTC)
Received: from krava (unknown [10.40.194.160])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0D9AB19C59;
        Thu, 20 May 2021 12:18:22 +0000 (UTC)
Date:   Thu, 20 May 2021 14:18:21 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Shuyi Cheng <chengshuyi@linux.alibaba.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, wenan.mao@linux.alibaba.com,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2] pahole: Add --kabi_prefix flag
Message-ID: <YKZTjViH1uJoMSyI@krava>
References: <a249699a-7c6c-4d4a-71b0-87981c8d229e@linux.alibaba.com>
 <YKKA64WWqYN3P7YJ@kernel.org>
 <c3520803-77af-cc34-000a-de4ba6334bcb@linux.alibaba.com>
 <YKO34fq6P8G9IyMD@kernel.org>
 <CAEf4Bzazh4RNCY3rGRRXfO2wJ7DSiMx8w+61B_hjhu9FrOffpQ@mail.gmail.com>
 <ec80d351-ac2f-5c48-c339-c2c503d36d68@linux.alibaba.com>
 <YKVv57HsgJYmCTFi@krava>
 <30cc773d-779f-9440-2f79-1fd642287cc4@linux.alibaba.com>
 <YKZMwmFVcYTTvEDW@krava>
 <ebbd7ace-f3ab-d104-c36c-788f4c169bbd@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebbd7ace-f3ab-d104-c36c-788f4c169bbd@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Thu, May 20, 2021 at 08:08:44PM +0800, Shuyi Cheng wrote:
> 
> 
> On 5/20/21 7:49 PM, Jiri Olsa wrote:
> > On Thu, May 20, 2021 at 06:27:48PM +0800, Shuyi Cheng wrote:
> > > 
> > > 
> > > On 5/20/21 4:07 AM, Jiri Olsa wrote:
> > > > On Wed, May 19, 2021 at 10:44:44AM +0800, Shuyi Cheng wrote:
> > > > > To solve problems similar to _RH_KABI_REPLACE. The _RH_KABI_REPLACE(_orig,
> > > > > _new) macros perserve size alignment and kabi agreement between _orig and
> > > > > _new.Below is the definition of this macro:
> > > > > 
> > > > > # define _RH_KABI_REPLACE(_orig, _new)            \
> > > > >       union {                        \
> > > > >           _new;                    \
> > > > >           struct {                \
> > > > >               _orig;                \
> > > > >           } __UNIQUE_ID(rh_kabi_hide);        \
> > > > >           __RH_KABI_CHECK_SIZE_ALIGN(_orig, _new);    \
> > > > >       }
> > > > 
> > > > hi,
> > > > that macro sounds familiar ;-) I think this should be already
> > > > solved directly in the header file by this one:
> > > > 
> > > >     https://gitlab.com/cki-project/kernel-ark/-/commit/331be9c5a436057ee852075c102d9d90a9046a30
> > > > 
> > > > jirka
> > > > 
> > > 
> > > Well, this patch solves this problem very well from the kernel level. But
> > > there are many mirrors [here](http://debuginfo.centos.org/7/x86_64/) that
> > > still have this problem. And these mirrors support ebpf, so it is very
> > > important to effectively extract the btf segment from these mirrors. :-)
> > 
> > hum, the link shows 3.10.* centos kernel, right?
> > AFAIK there's no BTF support in those kernels..
> > 
> > but maybe I'm missing some backporting channel,
> > could you please point me to related sources?
> > 
> > jirka
> > 
> 
> Yes, it is the centos kernel of version 3.10. This version of the centos
> kernel supports ebpf. As far as I think, BTF features don't depend on the
> kernel much. Only when using the STRUCT OPS feature does the kernel support
> BTF, see [here](https://github.com/libbpf/libbpf/blob/57375504c6c9766d23f178c40f71bf5e8df9363d/src/libbpf.c#L2549)
> and [here](https://www.spinics.net/lists/netdev/msg637060.html). Therefore,
> in the 3.10 version of the Centos kernel, with the help of the vmlinux btf
> segment, libbpf CO-RE can be easily supported.

ok, so you're generating BTF for centos 3.10 kernel?

I think that fix would be easy kernel backport, but I guess
we can go with pahole option just as well, if backport is
not an option for you

jirka

