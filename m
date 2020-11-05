Return-Path: <SRS0=OQ7q=EL=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3ACC388F7
	for <linux-dwarves@archiver.kernel.org>; Thu,  5 Nov 2020 20:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDA2E21D46
	for <linux-dwarves@archiver.kernel.org>; Thu,  5 Nov 2020 20:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604608164;
	bh=hlUcZZcYM8dgNZ9WjZApTQvBOLn5bzBYS8n+Sxa93uU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ORqgO4cTNPfoTtBewMwTyuFqHEYWCXngKGF0lgB1UEklpd2Fv4tSwt6+q/RBg/WcC
	 A8xNkg8N7n93mX25bihgiY+7ip6B8swLMGyNNEXWZR68mJWafoAvV40RZowV7PGm41
	 leURr9wv2ZJipgBznKLsWiOjCCMbNt7jhyQ0nr6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgKEU3Y (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 5 Nov 2020 15:29:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:39832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbgKEU3Y (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Thu, 5 Nov 2020 15:29:24 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49E6520867;
        Thu,  5 Nov 2020 20:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604608163;
        bh=hlUcZZcYM8dgNZ9WjZApTQvBOLn5bzBYS8n+Sxa93uU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w+p/JVPYDs7Dm9acs7bTeM1oUistDp9s2pnL9KbtLfbCq2sw/p9lnzgKP9/THfgwp
         HqE6uR25F0+7wk4O/MbPmg6yme3pY90d2H6KG1HCmpPW8F6f9KBnCyebOdoaQ34l5R
         EwjTEUPHjTIuclyeyZb7mCH07MoI3tOAGLwi4vnY=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 00D72411D1; Thu,  5 Nov 2020 17:29:20 -0300 (-03)
Date:   Thu, 5 Nov 2020 17:29:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Subject: Re: [RFC PATCH dwarves] btf: add support for split BTF loading and
 encoding
Message-ID: <20201105202920.GJ262228@kernel.org>
References: <20201105043936.2555804-1-andrii@kernel.org>
 <20201105114242.GH262228@kernel.org>
 <CAEf4BzYshEY3K=fqt2iQJaVcZeepcger0C7+uOXNhG=MLC9R-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYshEY3K=fqt2iQJaVcZeepcger0C7+uOXNhG=MLC9R-w@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Thu, Nov 05, 2020 at 11:10:14AM -0800, Andrii Nakryiko escreveu:
> On Thu, Nov 5, 2020 at 3:42 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Em Wed, Nov 04, 2020 at 08:39:36PM -0800, Andrii Nakryiko escreveu:
> > > @@ -679,11 +681,11 @@ static int btf_elf__write(const char *filename, struct btf *btf)
> > >  {
> > >       GElf_Shdr shdr_mem, *shdr;
> > >       GElf_Ehdr ehdr_mem, *ehdr;
> > > -     Elf_Data *btf_elf = NULL;
> > > +     Elf_Data *btf_data = NULL;

> > Can you please split this into two patches, one doing just the rename
> > of btf_elf to btf_data and then moving to btf__new_empty_split()? Eases
> > reviewing.
 
> sure, will do in the next version

Thanks!
 
> > With this split btf code would it be possible to paralelize the encoding
> > of the modules BTF? I have to check the other patches and how this gets
> > used in the kernel build process... :-)
 
> Yes, each module's BTF is generated completely independently. See some
> numbers in [0].
> 
>   [0] https://patchwork.kernel.org/project/netdevbpf/patch/20201105045140.2589346-4-andrii@kernel.org/

I saw it, very good. I wonder if we could manage to also paralelize the
processing of DWARF compile units in the BTF encoder, like start
processing and at the end just figure out how many types were in a CU,
get the highest type id and bump it to + the number of types in the
current CU, adjust the types, continue, something like that.

- Arnaldo
