Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29287C54EE9
	for <linux-dwarves@archiver.kernel.org>; Tue, 27 Sep 2022 19:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbiI0TIK (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 27 Sep 2022 15:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiI0TIJ (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 27 Sep 2022 15:08:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE2B1CDB59
        for <dwarves@vger.kernel.org>; Tue, 27 Sep 2022 12:08:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1857360691
        for <dwarves@vger.kernel.org>; Tue, 27 Sep 2022 19:08:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BFFDC433C1;
        Tue, 27 Sep 2022 19:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664305685;
        bh=tkRF8USAoejHLf6nm0YVVRNOk8vPPlBSRwR4b4QoXgk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nj55fkYomyKndZ28IkZWFAIxzSeczFWOAJSevtaRCg+zBV6gu+MsqypmvB2I9EtEe
         kZCFbrkohXfdgWRlMCQXrrZ5f2FlFqBZC7pYPPJnE0UBaK5qzk2dsf/tTwBS/PniIy
         +fpIH/3BE7zRFHQ/5Z/MnQUuoRCDx9Amwntt3ugtZhhI2gBKVpcUIiVx/gwGnEb5fN
         1adDwR4O7xqtYII3MOOG/cjwPQp+ACTT8Nz5F3J4Yf2bdRTgzdyN+yr7yfhisMm5a0
         yDnuwkwlQQ/Am+qcYuHDatWU3uFt2t+hNHLFsKCEH4m71Jf3piO5f64YBbVN0xqUpU
         yWJVq4HcbZg1Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4BE33405F0; Tue, 27 Sep 2022 16:08:02 -0300 (-03)
Date:   Tue, 27 Sep 2022 16:08:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        dwarves@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: die__process_unit: DW_TAG_label (0xa) @ <0x7b> not handled!
Message-ID: <YzNKEhM+H/X0xUK3@kernel.org>
References: <YzNHYoI4EZOQdCQ0@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzNHYoI4EZOQdCQ0@dev-arch.thelio-3990X>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Tue, Sep 27, 2022 at 11:56:34AM -0700, Nathan Chancellor escreveu:
> Hi Arnaldo,
> 
> When building a kernel with LLVM and CONFIG_DEBUG_INFO_BTF after commit
> 32ef9e5054ec ("Makefile.debug: re-enable debug info for .S files") in
> the kernel, I see the following spew of warnings, which appear to come
> from pahole:
> 
> $ clang --version
> clang version 15.0.0 (Fedora 15.0.0-3.fc38)
> Target: x86_64-redhat-linux-gnu
> Thread model: posix
> InstalledDir: /usr/bin
> 
> $ pahole --version
> v1.24
> 
> $ make -skj"$(nproc)" ARCH=x86_64 LLVM=1 defconfig
> 
> $ scripts/config \
>     -d DEBUG_INFO_NONE \
>     -e BPF_SYSCALL \
>     -e DEBUG_INFO_BTF \
>     -e DEBUG_INFO_DWARF5
> 
> $ make -skj"$(nproc)" ARCH=x86_64 LLVM=1 olddefconfig all
> ...
> die__process_unit: DW_TAG_label (0xa) @ <0x7b> not handled!
> die__process_unit: tag not supported 0xa (label)!
> die__process_unit: DW_TAG_label (0xa) @ <0x97> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0xbd> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0xed> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x109> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x12a> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x146> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x16f> not handled!
> ...
> 
> Is this a problem with LLVM or pahole? I do not see this when building
> with GCC + GNU as but that could just be a red herring. I assume that
> there could be something missing for processing debug info from
> assembly, perhaps? If there is any further information I can provide or
> anything I can test, I am more than happy to do so.

I'll try to repro, but at first sight it looks like a label in a
DW_TAG_compile_unit/like level, I have to check what that means, but
seems to be just a warning, did the end result made sense?

- Arnaldo
