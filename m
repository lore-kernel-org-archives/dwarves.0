Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E14C04A95
	for <linux-dwarves@archiver.kernel.org>; Thu, 29 Sep 2022 01:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiI2BDu (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 28 Sep 2022 21:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbiI2BDs (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 28 Sep 2022 21:03:48 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2755109621
        for <dwarves@vger.kernel.org>; Wed, 28 Sep 2022 18:03:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F111CCE1F09
        for <dwarves@vger.kernel.org>; Thu, 29 Sep 2022 01:03:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00E9C43470;
        Thu, 29 Sep 2022 01:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664413423;
        bh=FLp4sgPuzP7zViTFviriXIWyJFs0iYu9SQmq01swafI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H6B2aW+9HpehgeRzAvFf8PJcrnhFhZZdzSRPoWHYH9ubpSNfpoB/NA8aVnTNLlGPC
         1PHHlB6AsYCUj2Wot9415gEI1PXVuppRSQk/dLDXdzTf74qZLAOb7mhAltEPw9sJ1O
         Ws9v/e0jb+DjxGdag2pd1mWdRXOebOk7sBM3sggxokb8fr6u8lCB2V4wSqAVsDFD8o
         oIOcV7D4JUAC82BJQ3fcjwb8q081monl/OqjOxNed6ZEeNW/y91BFdlFxr15kZqEh1
         h18fL/nlS8jVvrXB5XTz60i/TPChlB0dLxxB38gO+jzERwJaPckfI6Vq8ZyLJv4Hvx
         GO48TqMST+QZQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 51F97405F0; Wed, 28 Sep 2022 22:03:40 -0300 (-03)
Date:   Wed, 28 Sep 2022 22:03:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        dwarves@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: die__process_unit: DW_TAG_label (0xa) @ <0x7b> not handled!
Message-ID: <YzTu7C+FSoMv4AEf@kernel.org>
References: <YzNHYoI4EZOQdCQ0@dev-arch.thelio-3990X>
 <YzNKEhM+H/X0xUK3@kernel.org>
 <YzNWBxJTKDRBNNDa@dev-arch.thelio-3990X>
 <YzRPXVUfjcyQ4Utz@kernel.org>
 <YzRnfz0sVpX8CzeL@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YzRnfz0sVpX8CzeL@dev-arch.thelio-3990X>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Wed, Sep 28, 2022 at 08:25:51AM -0700, Nathan Chancellor escreveu:
> On Wed, Sep 28, 2022 at 10:42:53AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Sep 27, 2022 at 12:59:03PM -0700, Nathan Chancellor escreveu:
> > > On Tue, Sep 27, 2022 at 04:08:02PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > Em Tue, Sep 27, 2022 at 11:56:34AM -0700, Nathan Chancellor escreveu:
> > > > > When building a kernel with LLVM and CONFIG_DEBUG_INFO_BTF after commit
> > > > > 32ef9e5054ec ("Makefile.debug: re-enable debug info for .S files") in
> > > > > the kernel, I see the following spew of warnings, which appear to come
> > > > > from pahole:
> > > > > 
> > > > > $ clang --version
> > > > > clang version 15.0.0 (Fedora 15.0.0-3.fc38)
> > > > > Target: x86_64-redhat-linux-gnu
> > > > > Thread model: posix
> > > > > InstalledDir: /usr/bin
> > > > > 
> > > > > $ pahole --version
> > > > > v1.24
> > > > > 
> > > > > $ make -skj"$(nproc)" ARCH=x86_64 LLVM=1 defconfig
> > > > > 
> > > > > $ scripts/config \
> > > > >     -d DEBUG_INFO_NONE \
> > > > >     -e BPF_SYSCALL \
> > > > >     -e DEBUG_INFO_BTF \
> > > > >     -e DEBUG_INFO_DWARF5
> > > > > 
> > > > > $ make -skj"$(nproc)" ARCH=x86_64 LLVM=1 olddefconfig all
> > > > > ...
> > > > > die__process_unit: DW_TAG_label (0xa) @ <0x7b> not handled!
> > > > > die__process_unit: tag not supported 0xa (label)!
> > > > > die__process_unit: DW_TAG_label (0xa) @ <0x97> not handled!
> > > > > die__process_unit: DW_TAG_label (0xa) @ <0xbd> not handled!
> > > > > die__process_unit: DW_TAG_label (0xa) @ <0xed> not handled!
> > > > > die__process_unit: DW_TAG_label (0xa) @ <0x109> not handled!
> > > > > die__process_unit: DW_TAG_label (0xa) @ <0x12a> not handled!
> > > > > die__process_unit: DW_TAG_label (0xa) @ <0x146> not handled!
> > > > > die__process_unit: DW_TAG_label (0xa) @ <0x16f> not handled!
> > > > > ...
> > > > > 
> > > > > Is this a problem with LLVM or pahole? I do not see this when building
> > > > > with GCC + GNU as but that could just be a red herring. I assume that
> > > > > there could be something missing for processing debug info from
> > > > > assembly, perhaps? If there is any further information I can provide or
> > > > > anything I can test, I am more than happy to do so.
> > > > 
> > > > I'll try to repro, but at first sight it looks like a label in a
> > > 
> > > If you need help reproducing this locally, feel free to reach out
> > > through this thread or #clangbuiltlinux on Libera.
> > 
> > Can you please provide the vmlinux file where this takes place?
> 
> Sure thing, it is compressed to save some bandwidth while downloading:
> 
> https://1drv.ms/u/s!AsQNYeB-IEbqnnzsULjM1pXmOlI5?e=qHKjuW
> 
> If there is anything else I can provide, please let me know!

Interesting, indeed it is inside a DW_TAG_compile_unit, outside
functions, so pahole has no use for it right now, I'll just ignore it
and remove that warning.

These are for arch/x86/kernel/verify_cpu.S, asm file indeed.

⬢[acme@toolbox Nathan]$ readelf -wi vmlinux-pahole-warnings
Contents of the .debug_info section:

  Compilation Unit @ offset 0x0:
   Length:        0x1df (32-bit)
   Version:       5
   Unit Type:     DW_UT_compile (1)
   Abbrev Offset: 0x0
   Pointer Size:  8
 <0><c>: Abbrev Number: 1 (DW_TAG_compile_unit)
    <d>   DW_AT_stmt_list   : 0x0
    <11>   DW_AT_ranges      : 0xc
    <15>   DW_AT_name        : arch/x86/kernel/verify_cpu.S
    <32>   DW_AT_comp_dir    : /home/nathan/cbl/src/linux
    <4d>   DW_AT_producer    : ClangBuiltLinux clang version 16.0.0 (https://github.com/llvm/llvm-project 7e22179d38c438fedb0d9bb0cff1585843bd7082)
    <c2>   DW_AT_language    : 32769    (MIPS assembler)
 <1><c4>: Abbrev Number: 2 (DW_TAG_label)
    <c5>   DW_AT_name        : startup_64
    <d0>   DW_AT_decl_file   : 0x0
    <d4>   DW_AT_decl_line   : 0x364
    <d8>   DW_AT_low_pc      : 0xffffffff81000000
 <1><e0>: Abbrev Number: 2 (DW_TAG_label)
    <e1>   DW_AT_name        : secondary_startup_64
    <f6>   DW_AT_decl_file   : 0x0
    <fa>   DW_AT_decl_line   : 0x399
    <fe>   DW_AT_low_pc      : 0xffffffff81000060
 <1><106>: Abbrev Number: 2 (DW_TAG_label)
    <107>   DW_AT_name        : secondary_startup_64_no_verify
    <126>   DW_AT_decl_file   : 0x0
    <12a>   DW_AT_decl_line   : 0x39f
    <12e>   DW_AT_low_pc      : 0xffffffff81000065
 <1><136>: Abbrev Number: 2 (DW_TAG_label)
    <137>   DW_AT_name        : verify_cpu
    <142>   DW_AT_decl_file   : 0x0
    <146>   DW_AT_decl_line   : 0x430
    <14a>   DW_AT_low_pc      : 0xffffffff81000150
 <1><152>: Abbrev Number: 2 (DW_TAG_label)
    <153>   DW_AT_name        : sev_verify_cbit
    <163>   DW_AT_decl_file   : 0x1
    <167>   DW_AT_decl_line   : 0x491
    <16b>   DW_AT_low_pc      : 0xffffffff81000250
 <1><173>: Abbrev Number: 2 (DW_TAG_label)
    <174>   DW_AT_name        : start_cpu0
    <17f>   DW_AT_decl_file   : 0x2
    <183>   DW_AT_decl_line   : 0x49e
    <187>   DW_AT_low_pc      : 0xffffffff81000260
 <1><18f>: Abbrev Number: 2 (DW_TAG_label)
    <190>   DW_AT_name        : early_idt_handler_array
    <1a8>   DW_AT_decl_file   : 0x0
    <1ac>   DW_AT_decl_line   : 0x4ad
    <1b0>   DW_AT_low_pc      : 0xffffffff83796000
 <1><1b8>: Abbrev Number: 2 (DW_TAG_label)
    <1b9>   DW_AT_name        : early_idt_handler_common
    <1d2>   DW_AT_decl_file   : 0x0
    <1d6>   DW_AT_decl_line   : 0x4c1
    <1da>   DW_AT_low_pc      : 0xffffffff83796120
<BIG SNIP>
