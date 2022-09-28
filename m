Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2DFC32771
	for <linux-dwarves@archiver.kernel.org>; Wed, 28 Sep 2022 13:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbiI1Nm7 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 28 Sep 2022 09:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiI1Nm6 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 28 Sep 2022 09:42:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2CC5FF77
        for <dwarves@vger.kernel.org>; Wed, 28 Sep 2022 06:42:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25A5261E91
        for <dwarves@vger.kernel.org>; Wed, 28 Sep 2022 13:42:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6A6C433D7;
        Wed, 28 Sep 2022 13:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664372576;
        bh=/iKcJivJb+y9MGnSn6pzj30hZHdLRHEgppfL+ufJBXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ubid8OXh5qId+Qr1iedznL1NRQjXJeUeBK1ypqbYcXWau9yKNyLlo77BjiHZ0dsDA
         iGqPpoHsf6LBnnfXjXNZr+SBwpT9vNZSr7PChnnvsSg1FN7LY0eAgdnT6jpK5lh99Y
         l/yAFW6SMDCm6Canylc1UAwrqWG0Q2zuu6w3orJr/UX/a+JprvItR6R0MLEEiJ/okd
         HVusQrnyF3Edzba7U0PP8U4DU7kmO7efGzB2t3U4fJqL9C5srHB76TgLd9sMiL6AfQ
         Du8Yk5t5k/LqG9M3ADK9l0SAIOmpK5GeNL0o9es09ayGErSxlwNU69i3Jc6XiKYqnP
         BEhSvbYN+MDEw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 66148405F0; Wed, 28 Sep 2022 10:42:53 -0300 (-03)
Date:   Wed, 28 Sep 2022 10:42:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        dwarves@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: die__process_unit: DW_TAG_label (0xa) @ <0x7b> not handled!
Message-ID: <YzRPXVUfjcyQ4Utz@kernel.org>
References: <YzNHYoI4EZOQdCQ0@dev-arch.thelio-3990X>
 <YzNKEhM+H/X0xUK3@kernel.org>
 <YzNWBxJTKDRBNNDa@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzNWBxJTKDRBNNDa@dev-arch.thelio-3990X>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Tue, Sep 27, 2022 at 12:59:03PM -0700, Nathan Chancellor escreveu:
> On Tue, Sep 27, 2022 at 04:08:02PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Sep 27, 2022 at 11:56:34AM -0700, Nathan Chancellor escreveu:
> > > Hi Arnaldo,
> > > 
> > > When building a kernel with LLVM and CONFIG_DEBUG_INFO_BTF after commit
> > > 32ef9e5054ec ("Makefile.debug: re-enable debug info for .S files") in
> > > the kernel, I see the following spew of warnings, which appear to come
> > > from pahole:
> > > 
> > > $ clang --version
> > > clang version 15.0.0 (Fedora 15.0.0-3.fc38)
> > > Target: x86_64-redhat-linux-gnu
> > > Thread model: posix
> > > InstalledDir: /usr/bin
> > > 
> > > $ pahole --version
> > > v1.24
> > > 
> > > $ make -skj"$(nproc)" ARCH=x86_64 LLVM=1 defconfig
> > > 
> > > $ scripts/config \
> > >     -d DEBUG_INFO_NONE \
> > >     -e BPF_SYSCALL \
> > >     -e DEBUG_INFO_BTF \
> > >     -e DEBUG_INFO_DWARF5
> > > 
> > > $ make -skj"$(nproc)" ARCH=x86_64 LLVM=1 olddefconfig all
> > > ...
> > > die__process_unit: DW_TAG_label (0xa) @ <0x7b> not handled!
> > > die__process_unit: tag not supported 0xa (label)!
> > > die__process_unit: DW_TAG_label (0xa) @ <0x97> not handled!
> > > die__process_unit: DW_TAG_label (0xa) @ <0xbd> not handled!
> > > die__process_unit: DW_TAG_label (0xa) @ <0xed> not handled!
> > > die__process_unit: DW_TAG_label (0xa) @ <0x109> not handled!
> > > die__process_unit: DW_TAG_label (0xa) @ <0x12a> not handled!
> > > die__process_unit: DW_TAG_label (0xa) @ <0x146> not handled!
> > > die__process_unit: DW_TAG_label (0xa) @ <0x16f> not handled!
> > > ...
> > > 
> > > Is this a problem with LLVM or pahole? I do not see this when building
> > > with GCC + GNU as but that could just be a red herring. I assume that
> > > there could be something missing for processing debug info from
> > > assembly, perhaps? If there is any further information I can provide or
> > > anything I can test, I am more than happy to do so.
> > 
> > I'll try to repro, but at first sight it looks like a label in a
> 
> If you need help reproducing this locally, feel free to reach out
> through this thread or #clangbuiltlinux on Libera.

Can you please provide the vmlinux file where this takes place?
 
> > DW_TAG_compile_unit/like level, I have to check what that means, but
> > seems to be just a warning, did the end result made sense?
> 
> Right, this appears to just be a warning, the build still completes
> successfully (I did not check much else). I only noticed this by
> scrolling back in my build logs.

Ok.

- Arnaldo
