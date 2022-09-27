Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2AEC6FA86
	for <linux-dwarves@archiver.kernel.org>; Tue, 27 Sep 2022 19:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbiI0T7W (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 27 Sep 2022 15:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbiI0T7H (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 27 Sep 2022 15:59:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78EC1C26D7
        for <dwarves@vger.kernel.org>; Tue, 27 Sep 2022 12:59:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6085761B60
        for <dwarves@vger.kernel.org>; Tue, 27 Sep 2022 19:59:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799C2C433B5;
        Tue, 27 Sep 2022 19:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664308745;
        bh=2My9ZCXmRnqUQ6cz3tMnkACjBt4qb/TqPciRMjsGEac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YmYGksXqc8Q3XdJdh6EvAX5XdlYduq0bWrFarDxaPgxjFVwzqO3PgFrsZJM57Iyjk
         qPnNjWYhp5kgM1VsR2jkagEGA/CWfgZ5nSouH0i5slmex0dIeO7lQK77gDTTIxos3e
         ClYCTOI3zqTLp82tL/gwSOq4fOF87Y8tEdeR7ofto+1/cGjP0D38GJhjXiFqVEITjh
         tajyhCk7uFynoLb/AZI058lm2ZduhX7IW+8V1WDw18aUWka2MCP5zjHzAacA3tQYes
         jakrt45RSQVhiZM8RmHKC8g2Mxby3dpdd0bYW/UP+W+C18bzRZrzci/SJ/BQOJu9i5
         MoO1FWd3GXWuw==
Date:   Tue, 27 Sep 2022 12:59:03 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        dwarves@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: die__process_unit: DW_TAG_label (0xa) @ <0x7b> not handled!
Message-ID: <YzNWBxJTKDRBNNDa@dev-arch.thelio-3990X>
References: <YzNHYoI4EZOQdCQ0@dev-arch.thelio-3990X>
 <YzNKEhM+H/X0xUK3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzNKEhM+H/X0xUK3@kernel.org>
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Tue, Sep 27, 2022 at 04:08:02PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Sep 27, 2022 at 11:56:34AM -0700, Nathan Chancellor escreveu:
> > Hi Arnaldo,
> > 
> > When building a kernel with LLVM and CONFIG_DEBUG_INFO_BTF after commit
> > 32ef9e5054ec ("Makefile.debug: re-enable debug info for .S files") in
> > the kernel, I see the following spew of warnings, which appear to come
> > from pahole:
> > 
> > $ clang --version
> > clang version 15.0.0 (Fedora 15.0.0-3.fc38)
> > Target: x86_64-redhat-linux-gnu
> > Thread model: posix
> > InstalledDir: /usr/bin
> > 
> > $ pahole --version
> > v1.24
> > 
> > $ make -skj"$(nproc)" ARCH=x86_64 LLVM=1 defconfig
> > 
> > $ scripts/config \
> >     -d DEBUG_INFO_NONE \
> >     -e BPF_SYSCALL \
> >     -e DEBUG_INFO_BTF \
> >     -e DEBUG_INFO_DWARF5
> > 
> > $ make -skj"$(nproc)" ARCH=x86_64 LLVM=1 olddefconfig all
> > ...
> > die__process_unit: DW_TAG_label (0xa) @ <0x7b> not handled!
> > die__process_unit: tag not supported 0xa (label)!
> > die__process_unit: DW_TAG_label (0xa) @ <0x97> not handled!
> > die__process_unit: DW_TAG_label (0xa) @ <0xbd> not handled!
> > die__process_unit: DW_TAG_label (0xa) @ <0xed> not handled!
> > die__process_unit: DW_TAG_label (0xa) @ <0x109> not handled!
> > die__process_unit: DW_TAG_label (0xa) @ <0x12a> not handled!
> > die__process_unit: DW_TAG_label (0xa) @ <0x146> not handled!
> > die__process_unit: DW_TAG_label (0xa) @ <0x16f> not handled!
> > ...
> > 
> > Is this a problem with LLVM or pahole? I do not see this when building
> > with GCC + GNU as but that could just be a red herring. I assume that
> > there could be something missing for processing debug info from
> > assembly, perhaps? If there is any further information I can provide or
> > anything I can test, I am more than happy to do so.
> 
> I'll try to repro, but at first sight it looks like a label in a

If you need help reproducing this locally, feel free to reach out
through this thread or #clangbuiltlinux on Libera.

> DW_TAG_compile_unit/like level, I have to check what that means, but
> seems to be just a warning, did the end result made sense?

Right, this appears to just be a warning, the build still completes
successfully (I did not check much else). I only noticed this by
scrolling back in my build logs.

Cheers,
Nathan
