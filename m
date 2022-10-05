Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500A3C433FE
	for <linux-dwarves@archiver.kernel.org>; Wed,  5 Oct 2022 15:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiJEPn5 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 5 Oct 2022 11:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiJEPn4 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 5 Oct 2022 11:43:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B02D2C671
        for <dwarves@vger.kernel.org>; Wed,  5 Oct 2022 08:43:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16272B81E70
        for <dwarves@vger.kernel.org>; Wed,  5 Oct 2022 15:43:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640FDC433D6;
        Wed,  5 Oct 2022 15:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664984632;
        bh=DyvEtDpXW6BuP0yHtnkNBbsOS74lBPM7daF4/N+eUzg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IJvRZ6ovpXHQv0iproxqEaJWQ54IPOD7Zy4MmDT1eCzWgh/OnqZnN/JD2GH97+9bq
         gCH40zDpsPVHteM5tZy3+dpvk+DUkgyxtOgx+o2NrLOdeSlemk7obCA0uWXD0dFDyl
         5hCtprKk4Id5yELqvw6s4fAXQTBT5Qp6OsWzL+cccRy9qzZuWidQss9qRfocSDjclc
         6EgQBG7yxO5q1COqe4WOzlexpiqCriS2pnuv3Asi0cXnAoaZ6n7LPCNRISRUpNBmKK
         oFVahYblYOIVzpjbhZz4KdzVf9RsOYJHntrAEFwkv4S6swNh4O5YiuLbxLcDNRH0xJ
         gw28mwiQVIKPQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6110A4062C; Wed,  5 Oct 2022 12:43:49 -0300 (-03)
Date:   Wed, 5 Oct 2022 12:43:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>
Cc:     dwarves@vger.kernel.org, Nick Clifton <nickc@redhat.com>
Subject: Re: Encountered error while encoding BTF due to Unsupported
 DW_TAG_unspecified_type(0x3b)
Message-ID: <Yz2mNfP2mmqAhkUn@kernel.org>
References: <878d0959-7f80-471e-69d5-5228822b4365@suse.cz>
 <YzypIDbTomaZOPOY@kernel.org>
 <a57a66b1-9457-a84f-6f66-9695aab01b1a@suse.cz>
 <Yz2Wmd0WgiwmPglm@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yz2Wmd0WgiwmPglm@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Wed, Oct 05, 2022 at 11:37:13AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Oct 05, 2022 at 09:23:32AM +0200, Martin Liška escreveu:
> > On 10/4/22 23:44, Arnaldo Carvalho de Melo wrote:
> > > I assume "binutils master" means:
> > > 
> > > git://sourceware.org/git/binutils-gdb.git master?
> > 
> > Yes.
> 
> Taking notes:
> 
> Using what is in opensuse:tumbleweed it works:

So I built and installed from git://sourceware.org/git/binutils-gdb.git,
it got on /usr/local/bin, taking precedence above /usr/bin/, and didn't
get any DW_TAG_unspecified_type:

15e20ce2324a:~/git/linux # type readelf
readelf is hashed (/usr/local/bin/readelf)
15e20ce2324a:~/git/linux # /usr/local/bin/readelf -v
GNU readelf (GNU Binutils) 2.39.50.20221005
Copyright (C) 2022 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License version 3 or (at your option) any later version.
This program has absolutely no warranty.
15e20ce2324a:~/git/linux # rpm -q binutils
binutils-2.38-6.2.x86_64
15e20ce2324a:~/git/linux #

15e20ce2324a:~/git/linux # readelf -wi ../build/v6.0.0+binutils-latest/vmlinux|grep DW_TAG_unspecified_type
15e20ce2324a:~/git/linux #

15e20ce2324a:~/git/linux # egrep BTF\|DWARF\|PAHOLE ../build/v6.0.0+binutils-latest/.config
CONFIG_PAHOLE_VERSION=122
CONFIG_VIDEO_SONY_BTF_MPX=m
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_DEBUG_INFO_BTF=y
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_DEBUG_INFO_BTF_MODULES=y
# CONFIG_MODULE_ALLOW_BTF_MISMATCH is not set
15e20ce2324a:~/git/linux #


Its CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y and it ends up being
DWARF5 as its the toolchain default, at least from the
/usr/local/bin/readelf -wi output below.

Can you hand me your kernel .config file, please?


 <1><92163>: Abbrev Number: 0
  Compilation Unit @ offset 0x92164:
   Length:        0x24 (32-bit)
   Version:       5
   Unit Type:     DW_UT_compile (1)
   Abbrev Offset: 0x5555
   Pointer Size:  8
 <0><92170>: Abbrev Number: 1 (DW_TAG_compile_unit)
    <92171>   DW_AT_stmt_list   : 0x7df2
    <92175>   DW_AT_low_pc      : 0xffffffff81c62000
    <9217d>   DW_AT_high_pc     : 19
    <9217e>   DW_AT_name        : (indirect string, offset: 0x1878d): /root/git/linux/arch/x86/entry/entry.S
    <92182>   DW_AT_comp_dir    : (indirect string, offset: 0x2a): /root/git/build/v6.0.0+binutils-latest
    <92186>   DW_AT_producer    : (indirect string, offset: 0x51): GNU AS 2.38
    <9218a>   DW_AT_language    : 32769 (MIPS assembler)
  Compilation Unit @ offset 0x9218c:
   Length:        0x1f (32-bit)
   Version:       5
   Unit Type:     DW_UT_compile (1)
   Abbrev Offset: 0x5569
   Pointer Size:  8
 <0><92198>: Abbrev Number: 1 (DW_TAG_compile_unit)
    <92199>   DW_AT_stmt_list   : 0x7e43
    <9219d>   DW_AT_ranges      : 0x12e3
    <921a1>   DW_AT_name        : (indirect string, offset: 0x187b4): /root/git/linux/arch/x86/entry/entry_64.S
    <921a5>   DW_AT_comp_dir    : (indirect string, offset: 0x2a): /root/git/build/v6.0.0+binutils-latest
    <921a9>   DW_AT_producer    : (indirect string, offset: 0x51): GNU AS 2.38
    <921ad>   DW_AT_language    : 32769 (MIPS assembler)
  Compilation Unit @ offset 0x921af:
   Length:        0x1e93 (32-bit)
   Version:       5
   Unit Type:     DW_UT_compile (1)
   Abbrev Offset: 0x557b
   Pointer Size:  8
 <0><921bb>: Abbrev Number: 13 (DW_TAG_compile_unit)
    <921bc>   DW_AT_producer    : (indirect string, offset: 0x6622): GNU C11 12.1.1 20220629 [revision 7811663964aa7e31c3939b859bbfa2e16919639f] -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -m64 -mno-80387 -mno-fp-ret-in-387 -mpreferred-stack-boundary=3 -mskip-rax-setup -mtune=generic -mno-red-zone -mcmodel=kernel -mindirect-branch=thunk-extern -mindirect-branch-register -mindirect-branch-cs-prefix -mfunction-return=thunk-extern -mharden-sls=all -mrecord-mcount -mfentry -march=x86-64 -g -O2 -std=gnu11 -p -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE -fcf-protection=none -falign-jumps=1 -falign-loops=1 -fno-asynchronous-unwind-tables -fno-jump-tables -fno-delete-null-pointer-checks -fno-allow-store-data-races -fstack-protector-strong -fno-stack-clash-protection -fzero-call-used-regs=used-gpr -fno-strict-overflow -fstack-check=no -fconserve-stack
    <921c0>   DW_AT_language    : 29    (C11)
    <921c1>   DW_AT_name        : (indirect line string, offset: 0x14b6): /root/git/linux/arch/x86/entry/syscall_64.c
    <921c5>   DW_AT_comp_dir    : (indirect line string, offset: 0): /root/git/build/v6.0.0+binutils-latest
    <921c9>   DW_AT_stmt_list   : 0x8110
 <1><921cd>: Abbrev Number: 6 (DW_TAG_base_type)
    <921ce>   DW_AT_byte_size   : 8
    <921cf>   DW_AT_encoding    : 7     (unsigned)
    <921d0>   DW_AT_name        : (indirect string, offset: 0x4dc4): long unsigned int

