Return-Path: <SRS0=ASgQ=C6=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D070CC43463
	for <linux-dwarves@archiver.kernel.org>; Mon, 21 Sep 2020 12:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F9C220EDD
	for <linux-dwarves@archiver.kernel.org>; Mon, 21 Sep 2020 12:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600691260;
	bh=CiJQdGYJzRvNficFqDaYR8+KeSds3tG33u7ExQniu6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cXs7kJEIFR5Ew5MTVYUoBUfXGfrj1VZoDE+F1HOTzBtIDhL76btcO4SUxDzA+MNuR
	 S45DGrWNSsYt4RE+QBhtSdLB6S2i53X4ewXG7vc146G1Z5x5SLOK9j6grroByuXRze
	 qf4HNQB/Y8xrKbkpBRLI56YijO6gtttIdVUirhuk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgIUM1k (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 21 Sep 2020 08:27:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:43942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbgIUM1k (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Mon, 21 Sep 2020 08:27:40 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C44AD206C3;
        Mon, 21 Sep 2020 12:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600691260;
        bh=CiJQdGYJzRvNficFqDaYR8+KeSds3tG33u7ExQniu6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=By/F+RnsAIeA2CXtocq0aA+E4pkR09TFHQAulh0JFmVhZgZ/naGpsBMZ6xFXdpBuk
         Buj/Zur/lP1wdqi32p08LYlTnR21Jw903jPdxl8qiPW+1F9YQDj4xaH8/iUDJC+B+u
         jcEvPM2G1uYgTzHIsWjCU+3bLmauN0MYUaySr8f0=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id ED37D400E9; Mon, 21 Sep 2020 09:27:37 -0300 (-03)
Date:   Mon, 21 Sep 2020 09:27:37 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Hao Luo <haoluo@google.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        dwarves@vger.kernel.org, Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH 0/2] pahole: Make encoding percpu vars into BTF optional.
Message-ID: <20200921122737.GJ1996959@kernel.org>
References: <20200918204058.1030519-1-haoluo@google.com>
 <CAADnVQL_Qudg34PpgKDz4pObwUZBJfbmKm+NcSLiQf575JcvEQ@mail.gmail.com>
 <CA+khW7i5vWnUMCvHmtEDVUQ92Wy+sLhOmnLjHBgVUdgdMWKQdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+khW7i5vWnUMCvHmtEDVUQ92Wy+sLhOmnLjHBgVUdgdMWKQdQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Fri, Sep 18, 2020 at 09:00:10PM -0700, Hao Luo escreveu:
> Hi Alexei,
> 
> I was syncing with Arnaldo offline on whether the change in Pahole was
> enough for supporting percpu vars in BPF. While I think about it, I
> felt it's better to have a flag in pahole to toggle the feature on and
> off. My concern is mainly malformed BTF caused by the newly introduced
> VAR entries. I've tested over some kernel configurations and compilers
> but not confident enough.
> 
> I haven't thought about opt-out. Maybe we should use opt-out instead of opt-in?

Yeah, having an opt-out should be useful as a debugging technique.

- Arnaldo
 
> Hao
> 
> On Fri, Sep 18, 2020 at 5:58 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Sep 18, 2020 at 1:41 PM Hao Luo <haoluo@google.com> wrote:
> > >
> > > Previous commit f3d9054ba8ff ("btf_encoder: Teach pahole to store
> > > percpu variables in vmlinux BTF.") introduced a feature in btf_encoder
> > > that encodes global symbols in BTF. However, this feature is not
> > > protected by any flag. In order to avoid surprises after Pahole v1.18
> > > rolls out, make this feature off by default and enable only upon
> > > request. On the kernel side, we can add a Kconfig to enable this
> > > new capability on an opt-in pattern.
> >
> > I think I've missed some earlier discussions and motivation for opt-in.
> > Why opt-out is a problem?
> > I would think the kernel build should always include percpu vars.

-- 

- Arnaldo
