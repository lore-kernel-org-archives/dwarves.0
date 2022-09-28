Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41575C32771
	for <linux-dwarves@archiver.kernel.org>; Wed, 28 Sep 2022 15:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbiI1P0v (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 28 Sep 2022 11:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233951AbiI1P0V (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 28 Sep 2022 11:26:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885975C941
        for <dwarves@vger.kernel.org>; Wed, 28 Sep 2022 08:25:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F336DB820EA
        for <dwarves@vger.kernel.org>; Wed, 28 Sep 2022 15:25:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D5B5C433C1;
        Wed, 28 Sep 2022 15:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664378753;
        bh=ZYc9oLGu1f3dSGDOwtaj6eaDzx1GEzHhcCGT2+RGsoU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YZD2LQ2tkIKcB/rPA2CrkH/cshXNPqfPVp4eTO16Z2U9LvUsMxiNoNGJp7knNMZl3
         I9GsThl8TDQtFCjXqHv4be31m22iTwshZdhfX6l4vXc+JGlxXy/cV6SWzUC67JydCK
         nV/8093T4JVu94AHfnXc1wATAt8R062G4ZDfvdrvJDrcYMRKVIk0Qw1BkSIaaaypst
         fCtmpScOABSKPZ2bz3izfdAZWzRTss1NSWzVIdDV1TjrBSskGAZWeYVQBgpyymtZcu
         dwQvkujJ66br/8i2eBcwZ+FVfS1CYS2bBxL8j44hCAr8x1BO3z9ZhrJkcu+QuKDyiE
         Z2WqsrtZ8dKKA==
Date:   Wed, 28 Sep 2022 08:25:51 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        dwarves@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: die__process_unit: DW_TAG_label (0xa) @ <0x7b> not handled!
Message-ID: <YzRnfz0sVpX8CzeL@dev-arch.thelio-3990X>
References: <YzNHYoI4EZOQdCQ0@dev-arch.thelio-3990X>
 <YzNKEhM+H/X0xUK3@kernel.org>
 <YzNWBxJTKDRBNNDa@dev-arch.thelio-3990X>
 <YzRPXVUfjcyQ4Utz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzRPXVUfjcyQ4Utz@kernel.org>
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Wed, Sep 28, 2022 at 10:42:53AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Sep 27, 2022 at 12:59:03PM -0700, Nathan Chancellor escreveu:
> > On Tue, Sep 27, 2022 at 04:08:02PM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Tue, Sep 27, 2022 at 11:56:34AM -0700, Nathan Chancellor escreveu:
> > > > Hi Arnaldo,
> > > > 
> > > > When building a kernel with LLVM and CONFIG_DEBUG_INFO_BTF after commit
> > > > 32ef9e5054ec ("Makefile.debug: re-enable debug info for .S files") in
> > > > the kernel, I see the following spew of warnings, which appear to come
> > > > from pahole:
> > > > 
> > > > $ clang --version
> > > > clang version 15.0.0 (Fedora 15.0.0-3.fc38)
> > > > Target: x86_64-redhat-linux-gnu
> > > > Thread model: posix
> > > > InstalledDir: /usr/bin
> > > > 
> > > > $ pahole --version
> > > > v1.24
> > > > 
> > > > $ make -skj"$(nproc)" ARCH=x86_64 LLVM=1 defconfig
> > > > 
> > > > $ scripts/config \
> > > >     -d DEBUG_INFO_NONE \
> > > >     -e BPF_SYSCALL \
> > > >     -e DEBUG_INFO_BTF \
> > > >     -e DEBUG_INFO_DWARF5
> > > > 
> > > > $ make -skj"$(nproc)" ARCH=x86_64 LLVM=1 olddefconfig all
> > > > ...
> > > > die__process_unit: DW_TAG_label (0xa) @ <0x7b> not handled!
> > > > die__process_unit: tag not supported 0xa (label)!
> > > > die__process_unit: DW_TAG_label (0xa) @ <0x97> not handled!
> > > > die__process_unit: DW_TAG_label (0xa) @ <0xbd> not handled!
> > > > die__process_unit: DW_TAG_label (0xa) @ <0xed> not handled!
> > > > die__process_unit: DW_TAG_label (0xa) @ <0x109> not handled!
> > > > die__process_unit: DW_TAG_label (0xa) @ <0x12a> not handled!
> > > > die__process_unit: DW_TAG_label (0xa) @ <0x146> not handled!
> > > > die__process_unit: DW_TAG_label (0xa) @ <0x16f> not handled!
> > > > ...
> > > > 
> > > > Is this a problem with LLVM or pahole? I do not see this when building
> > > > with GCC + GNU as but that could just be a red herring. I assume that
> > > > there could be something missing for processing debug info from
> > > > assembly, perhaps? If there is any further information I can provide or
> > > > anything I can test, I am more than happy to do so.
> > > 
> > > I'll try to repro, but at first sight it looks like a label in a
> > 
> > If you need help reproducing this locally, feel free to reach out
> > through this thread or #clangbuiltlinux on Libera.
> 
> Can you please provide the vmlinux file where this takes place?

Sure thing, it is compressed to save some bandwidth while downloading:

https://1drv.ms/u/s!AsQNYeB-IEbqnnzsULjM1pXmOlI5?e=qHKjuW

If there is anything else I can provide, please let me know!

Cheers,
Nathan
