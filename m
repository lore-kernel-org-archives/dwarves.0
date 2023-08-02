Return-Path: <dwarves-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A97C001DF
	for <linux-dwarves@archiver.kernel.org>; Wed,  2 Aug 2023 08:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbjHBIDe (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 2 Aug 2023 04:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbjHBICz (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 2 Aug 2023 04:02:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A78AC
        for <dwarves@vger.kernel.org>; Wed,  2 Aug 2023 01:02:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 527A161864
        for <dwarves@vger.kernel.org>; Wed,  2 Aug 2023 08:02:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 233E8C433C8;
        Wed,  2 Aug 2023 08:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690963371;
        bh=5Cmwg1OSJW9YIeItjL/DKDCrSrb/G35k9uKL7G8eV1w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Vdmy5RwAWWhTIDxBfKEk1DiYQPdPB7qwaJ0K6hNWiYPG2hIOx4SEO9uI+p+HhqJ/c
         ffuKbMQlWE5naMPlvjDgSPB4UOET6gmHSzS5aYb9yiEMrQdMFRYekqt1eEmJ0aFUY4
         /R7V1wiXTKW7j2h67MmwIG6J+Zer1RkfpiXnvt1d0FU1UAaOZFt12YDV3dnvvbpTI1
         mhQijCVUdBXPN5mdJGsLXveDdG3+hheR8GbcDDuAXxK1TbylTKsYkT1ew5Wszd/n+0
         rayjQs9I3s2nn3YLlwiMikQwiSJqSJCGlaYUjLQEysX3lGTHib9I3JDJEpRJvpVq/G
         fJWoMRwRYe7Zw==
Date:   Wed, 2 Aug 2023 17:02:47 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        "cc: Jiri Olsa" <olsajiri@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        dwarves@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        bpf <bpf@vger.kernel.org>, Yonghong Song <yhs@fb.com>
Subject: Re: Fwd: [RESEND] BTF is not generated for gcc-built kernel with
 the latest pahole
Message-Id: <20230802170247.1f91f98ebe354608f6e8e36f@kernel.org>
In-Reply-To: <CA+JHD93MiFyJEP+1K7dAey+2d8v-az6qqwAKBgUzk9USXmmbzg@mail.gmail.com>
References: <20230726102534.9ebc4678ad2c9395cc9be196@kernel.org>
        <ZMDvmLdZSLi2QqB+@krava>
        <20230726200716.609d8433a7292eead95e7330@kernel.org>
        <6f0da094-5b49-954b-21e9-93f8c8cecc3f@oracle.com>
        <20230727093814.23681b2b0ac73aa89f368ae8@kernel.org>
        <20230727105102.509161e1f57fd0b49e98b844@kernel.org>
        <c5accb4d-21d1-d8d9-85a0-263177a06208@oracle.com>
        <20230801100148.defdc4c41833054c56c53bf0@kernel.org>
        <bba3b423-8e38-ade3-7ce7-23b1be454d1f@oracle.com>
        <CA+JHD93Liq95RvfChifmnE7E9mKR42_W7rtpqgY9KAgYyGTZwQ@mail.gmail.com>
        <CA+JHD93MiFyJEP+1K7dAey+2d8v-az6qqwAKBgUzk9USXmmbzg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Tue, 1 Aug 2023 15:28:38 -0300
Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:

> Sorry, replied only to Alan :-\
> 
> - Arnaldo
> 
> ---------- Forwarded message ---------
> From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
> Date: Tue, Aug 1, 2023 at 3:26 PM
> Subject: Re: [RESEND] BTF is not generated for gcc-built kernel with
> the latest pahole
> To: Alan Maguire <alan.maguire@oracle.com>
> 
> 
> On Tue, Aug 1, 2023 at 2:37 PM Alan Maguire <alan.maguire@oracle.com> wrote:
> > On 01/08/2023 02:01, Masami Hiramatsu (Google) wrote:
> > > On Mon, 31 Jul 2023 16:45:24 +0100
> > > Alan Maguire <alan.maguire@oracle.com> wrote:
> 
> > >> Unfortunately (or fortunately?) I haven't been able to reproduce so far
> > >> I'm afraid. I used your config and built gcc 13 from source; everything
> > >> worked as expected, with no warnings or missing functions (aside from
> > >> the ones skipped due to inconsistent prototypes etc).
> > >
> > > Yeah, so I think gcc-11.3 is suspicious too (and it seems fixed in gcc-13).
> 
> See below, but this one is interesting, gcc-13 works with
> CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y?

I'm using gcc-11.3, and it seems to work.

> 
> > >> One other thing I can think of - is it possible libdw[arf]/libelf
> > >> versions might be having an effect here? I'm using libdwarf.so.1.2,
> > >> libdw-0.188, libelf-0.188. I can try and match yours. Thanks!
> > >
> > > Both libdw/libelf are 0.181. I didn't install libdwarf.
> > > Hmm, I should update the libdw (elfutils) too.
> >
> > That might help. Thanks!
> 
> Probably he needs to tweak these CONFIG_ entries:
> 
> ⬢[acme@toolbox perf-tools]$ grep DWARF ../build/v6.2-rc5+/.config
> CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
> # CONFIG_DEBUG_INFO_DWARF4 is not set
> # CONFIG_DEBUG_INFO_DWARF5 is not set
> ⬢[acme@toolbox perf-tools]$
> 
> And make it use CONFIG_DEBUG_INFO_DWARF4=y,
> CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=n

OK, interesting. Let me check again with DWARF4.

Thank you!

> 
> For DWARF5 I need to forward port what I have in:
> 
> https://git.kernel.org/pub/scm/devel/pahole/pahole.git/log/?h=WIP-imported-unit
> 
> - Arnaldo


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
