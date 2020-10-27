Return-Path: <SRS0=Qbgy=EC=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68825C388F9
	for <linux-dwarves@archiver.kernel.org>; Tue, 27 Oct 2020 12:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CE9722202
	for <linux-dwarves@archiver.kernel.org>; Tue, 27 Oct 2020 12:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603801326;
	bh=EHmiuSM2r24jbgv79ItjR7r2y7V86RvgBk8sd/4V/58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Wh5CSnGb114jvjdpTutk/HGHLjvKR7qcoPOiKUw+L+fSJBXCN9RNKH2xkYi6gDhbn
	 oo0kwzOP+lIQsZYVSTAIeTVUvE7MshAJWveXT6Grhg4KYmKk2d9VTCWiif+sfc7aiV
	 73o+KbiG3BDLYdn++ttIbQv7rTzGO9j4SDAN40dY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897429AbgJ0MWF (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 27 Oct 2020 08:22:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:38568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2899745AbgJ0MWE (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Tue, 27 Oct 2020 08:22:04 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99E4722202;
        Tue, 27 Oct 2020 12:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603801323;
        bh=EHmiuSM2r24jbgv79ItjR7r2y7V86RvgBk8sd/4V/58=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2QtnPhKylGQ9dCmK2xcS7PxidTFS9bIzOEtGos7/aqA8berI/uBjna9bHg1S58V+Y
         k7E1hZNktatxpuiDgTevEDW5Blz09KBkYusVHkJRjJsb8VAXBd7XM9gK098Bio0KDg
         Trt+COZs/hHkRMC8Gg9EgGsdHPXfOngJKHGIk/C0=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5AF7F403C2; Tue, 27 Oct 2020 09:22:01 -0300 (-03)
Date:   Tue, 27 Oct 2020 09:22:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH dwarves] cmake: make libbpf's Linux UAPI headers
 available to all binaries
Message-ID: <20201027122201.GA2479604@kernel.org>
References: <20201024183653.891042-1-andrii@kernel.org>
 <20201026194908.GC2449445@kernel.org>
 <CAEf4BzZ7TwoFJRq0uNs+w5bdXKPoswJzzfcaOn9FNNfTt1Ai7A@mail.gmail.com>
 <20201027112050.GI2449445@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027112050.GI2449445@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Tue, Oct 27, 2020 at 08:20:50AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Oct 26, 2020 at 04:26:22PM -0700, Andrii Nakryiko escreveu:
> > On Mon, Oct 26, 2020 at 12:49 PM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > Em Sat, Oct 24, 2020 at 11:36:53AM -0700, Andrii Nakryiko escreveu:
> > > > Now that libbpf is used to implement deduplicated strings container, all of
> > > > the binaries will need linux/btf.h header to compile properly. libbpf is
> > > > distributed with its own copies of Linux UAPI headers, so use them during
> > > > compilation.
> > >
> > > Thanks, applied.
> > >
> > 
> > Still don't see it at
> > https://git.kernel.org/pub/scm/devel/pahole/pahole.git/, did you
> > forget to push? This is breaking libbpf and kernel CIs at the moment
> > :(
> 
> That got delayed due to that 'void variable found' bug that Hao fixed, I
> just tested built a kernel with it, rebooting with it, some more testing
> and it'll go to the public repo,

Rebooted, tested usage of /sys/kernel/btf/vmlinux, pushed to the main
git.kernel.org and to the mirror at github.

Thanks, please let me know if now everything is ok with the kernel CIs.

- Arnaldo
