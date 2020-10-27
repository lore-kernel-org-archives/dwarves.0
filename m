Return-Path: <SRS0=Qbgy=EC=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A3DC388F9
	for <linux-dwarves@archiver.kernel.org>; Tue, 27 Oct 2020 11:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C61022263
	for <linux-dwarves@archiver.kernel.org>; Tue, 27 Oct 2020 11:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603797654;
	bh=lbqzddDrhXkvIvoBzDLE2tJkg8nV49ebdkzwTYw1mXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rQzgHHY/t3s1RwBEHETw2Ka9P8PEmoTFQG+d8xAcFVVtUTV8J7SoCF3YQCct4yuoI
	 OpwD9VcvUtN0SZ6QIfkBWhibdC0u0Z2fOyJ3EDG9f0XLxFCZqij/g0Di9Iz4XmCv6c
	 XxfNWogEw1cXv3c9WAq2vmjWFAQ5Dt1tChx32D34=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899143AbgJ0LUy (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 27 Oct 2020 07:20:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:42090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437789AbgJ0LUx (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Tue, 27 Oct 2020 07:20:53 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E199222263;
        Tue, 27 Oct 2020 11:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603797653;
        bh=lbqzddDrhXkvIvoBzDLE2tJkg8nV49ebdkzwTYw1mXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Aq+HSMzGxAYx3krOtG1e8bYR4Oni3Uf6zAWyUhxHvTplJZxPSW2Mgmoq6TfnkMGis
         wh4bqTf9X2SFxgSHaknt9lwRmYSWn4aj0jdP3a9eZ6r5XEGRD6W+VD35D1NVoCWBQe
         QERFMsc//ep1vLA79+blNRdRvQGjlbXN9Jt1KBRw=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E3867403C2; Tue, 27 Oct 2020 08:20:50 -0300 (-03)
Date:   Tue, 27 Oct 2020 08:20:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH dwarves] cmake: make libbpf's Linux UAPI headers
 available to all binaries
Message-ID: <20201027112050.GI2449445@kernel.org>
References: <20201024183653.891042-1-andrii@kernel.org>
 <20201026194908.GC2449445@kernel.org>
 <CAEf4BzZ7TwoFJRq0uNs+w5bdXKPoswJzzfcaOn9FNNfTt1Ai7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZ7TwoFJRq0uNs+w5bdXKPoswJzzfcaOn9FNNfTt1Ai7A@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Mon, Oct 26, 2020 at 04:26:22PM -0700, Andrii Nakryiko escreveu:
> On Mon, Oct 26, 2020 at 12:49 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Sat, Oct 24, 2020 at 11:36:53AM -0700, Andrii Nakryiko escreveu:
> > > Now that libbpf is used to implement deduplicated strings container, all of
> > > the binaries will need linux/btf.h header to compile properly. libbpf is
> > > distributed with its own copies of Linux UAPI headers, so use them during
> > > compilation.
> >
> > Thanks, applied.
> >
> 
> Still don't see it at
> https://git.kernel.org/pub/scm/devel/pahole/pahole.git/, did you
> forget to push? This is breaking libbpf and kernel CIs at the moment
> :(

That got delayed due to that 'void variable found' bug that Hao fixed, I
just tested built a kernel with it, rebooting with it, some more testing
and it'll go to the public repo,

- Arnaldo
 
> > - Arnaldo
> >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  CMakeLists.txt | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/CMakeLists.txt b/CMakeLists.txt
> > > index 8e9fe4710a0c..84693514e0c8 100644
> > > --- a/CMakeLists.txt
> > > +++ b/CMakeLists.txt
> > > @@ -2,7 +2,9 @@ project(pahole C)
> > >  cmake_minimum_required(VERSION 2.8.8)
> > >  cmake_policy(SET CMP0005 NEW)
> > >
> > > -INCLUDE_DIRECTORIES( ${CMAKE_CURRENT_BINARY_DIR} ${CMAKE_CURRENT_SOURCE_DIR} )
> > > +INCLUDE_DIRECTORIES(${CMAKE_CURRENT_BINARY_DIR}
> > > +                 ${CMAKE_CURRENT_SOURCE_DIR}
> > > +                 ${CMAKE_CURRENT_SOURCE_DIR}/lib/bpf/include/uapi)
> > >
> > >  # Try to parse this later, Helio just showed me a KDE4 example to support
> > >  # x86-64 builds.
> > > --
> > > 2.24.1
> > >
> >
> > --
> >
> > - Arnaldo

-- 

- Arnaldo
