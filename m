Return-Path: <SRS0=OQ7q=EL=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01695C388F7
	for <linux-dwarves@archiver.kernel.org>; Thu,  5 Nov 2020 22:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 979972071A
	for <linux-dwarves@archiver.kernel.org>; Thu,  5 Nov 2020 22:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mq5U+wFn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731060AbgKEW43 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 5 Nov 2020 17:56:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42076 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726729AbgKEW43 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 5 Nov 2020 17:56:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604616988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C+3TCobREZNEd40HyH1ZY7BViufAqVh7MIgfcPDtSbs=;
        b=Mq5U+wFn7PARA4SKS6Ut9tOogIMFOPAEhRUxMLKea/UtgeXmI8RUsMUtkyswUFYh2aLkOM
        5d94o21gb8Kv06IhlhY0wqPTQy+vaoS766nkhuZF6MHbtAduGex/8BTIFOuOUA8qNVviJd
        JQMKHTw+bbJ2vtzaFyhB2qyu4dAXk4o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-0lIZyU9nNem3ZMhLEBaTjQ-1; Thu, 05 Nov 2020 17:56:26 -0500
X-MC-Unique: 0lIZyU9nNem3ZMhLEBaTjQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC5CF86ABD6;
        Thu,  5 Nov 2020 22:56:23 +0000 (UTC)
Received: from krava (unknown [10.40.192.38])
        by smtp.corp.redhat.com (Postfix) with SMTP id 371DD1002C03;
        Thu,  5 Nov 2020 22:56:18 +0000 (UTC)
Date:   Thu, 5 Nov 2020 23:56:17 +0100
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
Subject: Re: [PATCH 3/3] btf_encoder: Change functions check due to broken
 dwarf
Message-ID: <20201105225617.GB4112111@krava>
References: <20201104215923.4000229-1-jolsa@kernel.org>
 <20201104215923.4000229-4-jolsa@kernel.org>
 <CAEf4BzZaUyY0TA_Gq559ojEeT2mHtdc3aUbvB9Q_4u0pZ+WiWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZaUyY0TA_Gq559ojEeT2mHtdc3aUbvB9Q_4u0pZ+WiWQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Thu, Nov 05, 2020 at 11:52:35AM -0800, Andrii Nakryiko wrote:

SNIP

> > +        * Let's got through all collected functions and filter
> > +        * out those that are not in ftrace and init code.
> > +        */
> > +       for (i = 0; i < functions_cnt; i++) {
> > +               struct elf_function *func = &functions[i];
> > +
> > +               /*
> > +                * Do not enable .init section functions,
> > +                * but keep .init.bpf.preserve_type functions.
> > +                */
> > +               if (is_init(ms, func->addr) && !is_bpf_init(ms, func->addr))
> > +                       continue;
> > +
> > +               /* Make sure function is within ftrace addresses. */
> > +               if (bsearch(&func->addr, addrs, count, sizeof(addrs[0]), addrs_cmp)) {
> > +                       /*
> > +                        * We iterate over sorted array, so we can easily skip
> > +                        * not valid item and move following valid field into
> > +                        * its place, and still keep the 'new' array sorted.
> > +                        */
> > +                       if (i != functions_valid)
> > +                               functions[functions_valid] = functions[i];
> > +                       functions_valid++;
> > +               }
> > +       }
> 
> can we re-assign function_cnt = functions_valid here? and
> functions_valid could be just a local temporary variable?

good idea, should be simpler.. will change

and ack to all naming changes above ;-)

thanks,
jirka

> 
> > +
> > +       free(addrs);
> > +       return 0;
> > +}
> > +
> 
> [...]
> 

