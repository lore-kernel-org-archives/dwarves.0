Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4DDC4708B
	for <linux-dwarves@archiver.kernel.org>; Thu, 27 May 2021 15:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B3E5613BA
	for <linux-dwarves@archiver.kernel.org>; Thu, 27 May 2021 15:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236002AbhE0P3d (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 27 May 2021 11:29:33 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:56874 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235993AbhE0P3d (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 27 May 2021 11:29:33 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5CFA82190B;
        Thu, 27 May 2021 15:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622129279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YmugS6FPrOG42kEGuD/GJW6gSUg5RqZ4LgvC0qWJI30=;
        b=bG5uEsa/CZlv1fMBsX5f1mZBlLA/XoyLJsbKNGjkmtlHIzFEhyDaFwWhOGzY+FjBx1+Zs3
        kbb4IwYdvc60mIWXcccRaFDm+YJpl1/gAcQHzgAn+pYMC5xbcVzLDPrhxTzBdWzQLFpxk9
        pipedj6BqviJRDCIJEt4ko/yPgYi3lM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622129279;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YmugS6FPrOG42kEGuD/GJW6gSUg5RqZ4LgvC0qWJI30=;
        b=CWhbYhqEmo7AdIg7GodhC2XDDljoO1pWYnhorj0HgyS00jp28GWcbTffPYy4JZOExZu2C7
        ACOYUiLjsYgNyPCQ==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
        by imap.suse.de (Postfix) with ESMTPSA id 4A93B11A98;
        Thu, 27 May 2021 15:27:59 +0000 (UTC)
Date:   Thu, 27 May 2021 17:27:58 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, jolsa@kernel.org, kernel-team@fb.com
Subject: Re: [PATCH dwarves] btf_encoder: fix and complete filtering out
 zero-sized per-CPU variables
Message-ID: <20210527152758.GI8544@kitsune.suse.cz>
References: <20210524234222.278676-1-andrii@kernel.org>
 <YK+yzpPKVhNvm7/n@kernel.org>
 <YK+zkOOAUzFYsLBy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YK+zkOOAUzFYsLBy@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Hello,

On Thu, May 27, 2021 at 11:58:24AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, May 27, 2021 at 11:55:10AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Mon, May 24, 2021 at 04:42:22PM -0700, Andrii Nakryiko escreveu:
> > > btf_encoder is ignoring zero-sized per-CPU ELF symbols, but the same has to be
> > > done for DWARF variables when matching them with ELF symbols. This is due to
> > > zero-sized DWARF variables matching unrelated (non-zero-sized) variable that
> > > happens to be allocated at the exact same address, leading to a lot of
> > > confusion in BTF.
> >  
> > > See [0] for when this causes big problems.
> >  
> > >   [0] https://lore.kernel.org/bpf/CAEf4BzZ0-sihSL-UAm21JcaCCY92CqfNxycHRZYXcoj8OYb=wA@mail.gmail.com/
> 
> I also added this:
> 
> Reported-by: Michal Suchánek <msuchanek@suse.de>
> 
> Michal, so you tested this patch and verified it fixed the problem? If
> so please let me know so that I also add:

This is the first time I see this patch.

Given that linux-next does not build for me at the moment
I don't think I will test it soon.

Thanks

Michal

> 
> Tested-by: Michal Suchánek <msuchanek@suse.de>
> 
> Thanks,
> 
> - Arnaldo
>  
> > > +++ b/btf_encoder.c
> > > @@ -550,6 +551,7 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
> > >  
> > >  		/* addr has to be recorded before we follow spec */
> > >  		addr = var->ip.addr;
> > > +		dwarf_name = variable__name(var, cu);
> > >  
> > >  		/* DWARF takes into account .data..percpu section offset
> > >  		 * within its segment, which for vmlinux is 0, but for kernel
> > > @@ -582,11 +584,9 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
> > >  		 *  modules per-CPU data section has non-zero offset so all
> > >  		 *  per-CPU symbols have non-zero values.
> > >  		 */
> > > -		if (var->ip.addr == 0) {
> > > -			dwarf_name = variable__name(var, cu);
> > > +		if (var->ip.addr == 0)
> > >  			if (!dwarf_name || strcmp(dwarf_name, name))
> > >  				continue;
> > > -		}
> > >  
> > >  		if (var->spec)
> > >  			var = var->spec;
> > > @@ -600,6 +600,13 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
> > 
> > I just changed the above hunk to be:
> > 
> > @@ -583,7 +585,6 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
> >                  *  per-CPU symbols have non-zero values.
> >                  */
> >                 if (var->ip.addr == 0) {
> > -                       dwarf_name = variable__name(var, cu);
> >                         if (!dwarf_name || strcmp(dwarf_name, name))
> >                                 continue;
> >                 }
> > 
> > 
> > Which is shorter and keeps the {} around a multi line if block, ok?
> > 
> > Thanks, applied!
> > 
> > - Arnaldo
> 
> -- 
> 
> - Arnaldo
