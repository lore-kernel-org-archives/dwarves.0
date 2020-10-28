Return-Path: <SRS0=S57e=ED=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60534C56201
	for <linux-dwarves@archiver.kernel.org>; Wed, 28 Oct 2020 21:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1064024724
	for <linux-dwarves@archiver.kernel.org>; Wed, 28 Oct 2020 21:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZnRjzZNq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgJ1Vv5 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 28 Oct 2020 17:51:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39485 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728236AbgJ1Vv4 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 28 Oct 2020 17:51:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603921915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Oj76sDv+n8e5Ai31Y4ytmCC6PEC1KnQ4eDa60mSmAIs=;
        b=ZnRjzZNqnP90yiZdVgeWuId8uUbhXRrZm02afediFLvCJQqQU/efIOA5Z+qMLgypN89Bzq
        xHClJvtEXGitJUKtYPkXSVrCeain730N+nZAoMmGwijmEQTCMaLfOouaENWUOwdsN5VFep
        3EAMJRS7B1rNxaCzXhyL5xynyNEhgys=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-CEFC6iBkMVyoSuMneV7YlQ-1; Wed, 28 Oct 2020 11:51:23 -0400
X-MC-Unique: CEFC6iBkMVyoSuMneV7YlQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB1DC936C93;
        Wed, 28 Oct 2020 15:51:21 +0000 (UTC)
Received: from krava (unknown [10.40.192.64])
        by smtp.corp.redhat.com (Postfix) with SMTP id 02CC45B4B6;
        Wed, 28 Oct 2020 15:51:15 +0000 (UTC)
Date:   Wed, 28 Oct 2020 16:51:14 +0100
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
Subject: Re: [PATCH 1/3] btf_encoder: Move find_all_percpu_vars in generic
 config function
Message-ID: <20201028155114.GQ2900849@krava>
References: <20201026223617.2868431-1-jolsa@kernel.org>
 <20201026223617.2868431-2-jolsa@kernel.org>
 <CAEf4Bzan6=Jjfez17=S55Zu9EQTF_J2dg2DST4v+CfENm8cbUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzan6=Jjfez17=S55Zu9EQTF_J2dg2DST4v+CfENm8cbUQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Tue, Oct 27, 2020 at 04:12:04PM -0700, Andrii Nakryiko wrote:
> On Mon, Oct 26, 2020 at 5:07 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Moving find_all_percpu_vars under generic onfig function
> > that walks over symbols and calls config_percpu_var.
> >
> > We will add another config function that needs to go
> > through all the symbols, so it's better they go through
> > them just once.
> >
> > There's no functional change intended.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  btf_encoder.c | 126 ++++++++++++++++++++++++++------------------------
> >  1 file changed, 66 insertions(+), 60 deletions(-)
> >
> > diff --git a/btf_encoder.c b/btf_encoder.c
> > index 2a6455be4c52..2dd26c904039 100644
> > --- a/btf_encoder.c
> > +++ b/btf_encoder.c
> > @@ -250,7 +250,64 @@ static bool percpu_var_exists(uint64_t addr, uint32_t *sz, const char **name)
> >         return true;
> >  }
> >
> > -static int find_all_percpu_vars(struct btf_elf *btfe)
> > +static int config_percpu_var(struct btf_elf *btfe, GElf_Sym *sym)
> 
> I find the "config" name completely misleading. How about
> "collect_percpu_var" or something along those lines?

ok

> 
> > +{
> > +       const char *sym_name;
> > +       uint64_t addr;
> > +       uint32_t size;
> > +
> 
> [...]
> 
> > +}
> > +
> > +static int config(struct btf_elf *btfe, bool do_percpu_vars)
> 
> same here, config is generic and misrepresenting what we are doing
> here. E.g., collect_symbols would probably be more clear.

ook

jirka

> 
> >  {
> >         uint32_t core_id;
> >         GElf_Sym sym;
> 
> [...]
> 

