Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6AAC433F5
	for <linux-dwarves@archiver.kernel.org>; Wed,  5 Oct 2022 16:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiJEQzX (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 5 Oct 2022 12:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiJEQzV (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 5 Oct 2022 12:55:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4158A2DA8F
        for <dwarves@vger.kernel.org>; Wed,  5 Oct 2022 09:55:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A77C96175C
        for <dwarves@vger.kernel.org>; Wed,  5 Oct 2022 16:55:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60CAC433C1;
        Wed,  5 Oct 2022 16:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664988916;
        bh=woI5SIEUS/3tFpRWJrdRp4EmSsKFnvYPmHrJCzGMRh0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sc61fQWy4GqBu6zxyL8RGiAZLGKL2jTVavknEjcxXeJ0+92DtuXw48cwsokL0DHRd
         VuizXWao5iQfGYHSjoIL4hCdEmAvqKDx7M4hlNIe6TzSRtIxaGOCERmr0CPq2WmV3q
         rtw05ERtxK55IobkGQhlc0TeHFMtMiDiwML43Kx7c+XJgcOcACpkYAiemQkp6BRP2m
         btyMjDjvxNQv12mzEgc0ktq5DkJd3HzUP+4ds/bl5DC0QxoezFwFsbL4xCRMA0ro0F
         +xqBzpLLejfWPeq8naVl07yd6IoMBkRgph+zKwVPbDcNr1zMcIuq4dXIwhKm1H5yuc
         Nw3PgmyemYr8g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C5D604062C; Wed,  5 Oct 2022 13:55:12 -0300 (-03)
Date:   Wed, 5 Oct 2022 13:55:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>
Cc:     dwarves@vger.kernel.org, Nick Clifton <nickc@redhat.com>
Subject: Re: Encountered error while encoding BTF due to Unsupported
 DW_TAG_unspecified_type(0x3b)
Message-ID: <Yz228IMGMFZ0kouz@kernel.org>
References: <878d0959-7f80-471e-69d5-5228822b4365@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878d0959-7f80-471e-69d5-5228822b4365@suse.cz>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Mon, Oct 03, 2022 at 10:56:36AM +0200, Martin Liška escreveu:
> I noticed one can't build 5.19 with latest binutils master.
> 
> One see the following error:
> [ 1413s]   BTF     .btf.vmlinux.bin.o
> [ 1413s] Unsupported DW_TAG_unspecified_type(0x3b)
> [ 1413s] Encountered error while encoding BTF.
> 
> It's caused by DWARF coming from .S files and the change is introduced since
> the following binutils revision:
> 
> commit 5578fbf672ee497ea19826edeb509f4cc3e825a8
> Author: Nick Clifton <nickc@redhat.com>
> Date:   Thu Aug 25 11:48:00 2022 +0100
> 
>     GAS: Add a return type tag to DWARF DIEs generated for function symbols.
> 
> for entry.S the output changes to:
> 
> $ as-new --gdwarf-5 --64 -o entry.o entry.S && readelf -wi entry.o
> Contents of the .debug_info section:
> 
>   Compilation Unit @ offset 0x0:
>    Length:        0x35 (32-bit)
>    Version:       5
>    Unit Type:     DW_UT_compile (1)
>    Abbrev Offset: 0x0
>    Pointer Size:  8
>  <0><c>: Abbrev Number: 3 (DW_TAG_unspecified_type) <--- the problematic TAG
>  <0><d>: Abbrev Number: 1 (DW_TAG_compile_unit)
>     <e>   DW_AT_stmt_list   : 0x0
>     <12>   DW_AT_low_pc      : 0x0
>     <1a>   DW_AT_high_pc     : 19
>     <1b>   DW_AT_name        : (indirect string, offset: 0x0): ../arch/x86/entry/entry.S
>     <1f>   DW_AT_comp_dir    : (indirect string, offset: 0x1a): /tmp
>     <23>   DW_AT_producer    : (indirect string, offset: 0x1f): GNU AS 2.39.50
>     <27>   DW_AT_language    : 32769	(MIPS assembler)
>  <1><29>: Abbrev Number: 2 (DW_TAG_subprogram)
>     <2a>   DW_AT_name        : (indirect string, offset: 0x2e): entry_ibpb
>     <2e>   DW_AT_external    : 1
>     <2e>   DW_AT_type        : <0xc>
>     <2f>   DW_AT_low_pc      : 0x0
>     <37>   DW_AT_high_pc     : 19
>  <1><38>: Abbrev Number: 0
> 
> Is it something pahole should handle?

So if I build with clang 14 on opensuse tumbleweed I end up with:

 <2><5c234>: Abbrev Number: 0
 <1><5c235>: Abbrev Number: 0
  Compilation Unit @ offset 0x5c236:
   Length:        0x9f (32-bit)
   Version:       5
   Unit Type:     DW_UT_compile (1)
   Abbrev Offset: 0x355b
   Pointer Size:  8
 <0><5c242>: Abbrev Number: 1 (DW_TAG_compile_unit)
    <5c243>   DW_AT_stmt_list   : 0xa3b8
    <5c247>   DW_AT_low_pc      : 0xffffffff81c22000
    <5c24f>   DW_AT_high_pc     : 0xffffffff81c2200f
    <5c257>   DW_AT_name        : /root/git/linux/arch/x86/entry/entry.S
    <5c27e>   DW_AT_comp_dir    : /root/git/build/v6.0.0+binutils-latest
    <5c2a5>   DW_AT_producer    : clang version 14.0.6
    <5c2ba>   DW_AT_language    : 32769 (MIPS assembler)
 <1><5c2bc>: Abbrev Number: 2 (DW_TAG_label)
    <5c2bd>   DW_AT_name        : entry_ibpb
    <5c2c8>   DW_AT_decl_file   : 0
    <5c2cc>   DW_AT_decl_line   : 0x95
    <5c2d0>   DW_AT_low_pc      : 0xffffffff81c22000
 <1><5c2d8>: Abbrev Number: 0


clang uses DW_TAG_label for entry_ibpb, while GNU AS 2.39.50 generates
DW_TAG_subprogram.

But then the one I'm using when building with gcc, same
opensuse:tumbleweed container:

15e20ce2324a:~/git/linux # as --version
GNU assembler (GNU Binutils) 2.39.50.20221005
Copyright (C) 2022 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License version 3 or later.
This program has absolutely no warranty.
This assembler was configured for a target of `x86_64-pc-linux-gnu'.
15e20ce2324a:~/git/linux #

Isn't producing anything for entry_ibpb :-\

- Arnaldo

