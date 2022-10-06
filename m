Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B49DC433FE
	for <linux-dwarves@archiver.kernel.org>; Thu,  6 Oct 2022 11:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiJFLyn (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 6 Oct 2022 07:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiJFLym (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 6 Oct 2022 07:54:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8079EB7C9
        for <dwarves@vger.kernel.org>; Thu,  6 Oct 2022 04:54:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 01E781F8D0;
        Thu,  6 Oct 2022 11:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665057278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zvvr8DbXawH+xq6/jFI96STzAoeff5yJvi34gcg9KDA=;
        b=TlG9NJIBLJncruZcmp7jOK6+wzKP/63QQlfcEDw0PTEyei9ejnl3IQ4j5GSpTOWguhVJZm
        Z6kpcEiXBADiMqjqs/gikG9k5AQLTw9QJc6F/9Wi87PeqMy0dDE7WZM22juFUtL7gI2yYm
        I1GOzyrG+RAlzjN9oGeeO9juhPg2GLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665057278;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zvvr8DbXawH+xq6/jFI96STzAoeff5yJvi34gcg9KDA=;
        b=7ihYUQefMp/Af+3hxAOLxNJlLDXVnIUFMq6GW1o/W6ZXLaOJlxVFoUc4KpF1nOoQ3BWZun
        LYQEiLTa1mX+uTCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EB1ED1376E;
        Thu,  6 Oct 2022 11:54:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id t+w9OP3BPmOlHAAAMHmgww
        (envelope-from <mliska@suse.cz>); Thu, 06 Oct 2022 11:54:37 +0000
Message-ID: <f1eb3b92-c98a-9128-742d-795d8b6846ac@suse.cz>
Date:   Thu, 6 Oct 2022 13:54:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: Encountered error while encoding BTF due to Unsupported
 DW_TAG_unspecified_type(0x3b)
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     dwarves@vger.kernel.org, Nick Clifton <nickc@redhat.com>
References: <878d0959-7f80-471e-69d5-5228822b4365@suse.cz>
 <YzypIDbTomaZOPOY@kernel.org> <a57a66b1-9457-a84f-6f66-9695aab01b1a@suse.cz>
 <Yz2Wmd0WgiwmPglm@kernel.org> <Yz2mNfP2mmqAhkUn@kernel.org>
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
In-Reply-To: <Yz2mNfP2mmqAhkUn@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On 10/5/22 17:43, Arnaldo Carvalho de Melo wrote:
> Em Wed, Oct 05, 2022 at 11:37:13AM -0300, Arnaldo Carvalho de Melo
> escreveu:
>> Em Wed, Oct 05, 2022 at 09:23:32AM +0200, Martin Liška escreveu:
>>> On 10/4/22 23:44, Arnaldo Carvalho de Melo wrote:
>>>> I assume "binutils master" means:
>>>> 
>>>> git://sourceware.org/git/binutils-gdb.git master?
>>> 
>>> Yes.
>> 
>> Taking notes:
>> 
>> Using what is in opensuse:tumbleweed it works:
> 
> So I built and installed from
> git://sourceware.org/git/binutils-gdb.git, it got on /usr/local/bin,
> taking precedence above /usr/bin/, and didn't get any
> DW_TAG_unspecified_type:

Hey.

Well, it's more trickier what gcc driver runs as a GAS even though you prefixed
/usr/local/bin.

$ echo '' | gcc -c -x c - --verbose 2>&1 | grep 'as\>'
 /usr/lib64/gcc/x86_64-suse-linux/12/../../../../x86_64-suse-linux/bin/as -v --64 -o -.o /tmp/cclvchQd.s

Anyway, the easiest approach how to use a different gas is using -B gcc option, which
would search the location for 'as' binary:

$ pwd
/home/marxin/Programming/binutils/objdir/gas
$ ./as-new --version
GNU assembler (GNU Binutils) 2.39.50.20221004
...
$ ln -s as-new as
$ gcc -Wp,-MMD,arch/x86/entry/.entry.o.d -nostdinc -I./arch/x86/include -I./arch/x86/include/generated  -I./include -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/compiler-version.h -include ./include/linux/kconfig.h -D__KERNEL__ -fmacro-prefix-map=./= -D__ASSEMBLY__ -fno-PIE -m64    -c -o arch/x86/entry/entry.o arch/x86/entry/entry.S -g -B/home/marxin/Programming/binutils/objdir/gas

(note I'm using make defconfig), and not I can see:

$ readelf -wi arch/x86/entry/entry.o
Contents of the .debug_info section:

  Compilation Unit @ offset 0x0:
   Length:        0x35 (32-bit)
   Version:       5
   Unit Type:     DW_UT_compile (1)
   Abbrev Offset: 0x0
   Pointer Size:  8
 <0><c>: Abbrev Number: 1 (DW_TAG_compile_unit)
    <d>   DW_AT_stmt_list   : 0x0
    <11>   DW_AT_low_pc      : 0x0
    <19>   DW_AT_high_pc     : 19
    <1a>   DW_AT_name        : (indirect string, offset: 0x0): arch/x86/entry/entry.S
    <1e>   DW_AT_comp_dir    : (indirect string, offset: 0x17): /home/marxin/Programming/linux
    <22>   DW_AT_producer    : (indirect string, offset: 0x36): GNU AS 2.39.50
    <26>   DW_AT_language    : 32769	(MIPS assembler)
 <1><28>: Abbrev Number: 2 (DW_TAG_subprogram)
    <29>   DW_AT_name        : (indirect string, offset: 0x45): entry_ibpb
    <2d>   DW_AT_external    : 1
    <2d>   DW_AT_type        : <0x37>
    <2e>   DW_AT_low_pc      : 0x0
    <36>   DW_AT_high_pc     : 19
 <1><37>: Abbrev Number: 3 (DW_TAG_unspecified_type)
 <1><38>: Abbrev Number: 0


as seen, you get the DW_AT_producer tag that shows the AS version (2.39.50)
and the DW_TAG_unspecified_type tag.

Cheers,
Martin

> 
> 15e20ce2324a:~/git/linux # type readelf readelf is hashed
> (/usr/local/bin/readelf) 15e20ce2324a:~/git/linux #
> /usr/local/bin/readelf -v GNU readelf (GNU Binutils)
> 2.39.50.20221005 Copyright (C) 2022 Free Software Foundation, Inc. 
> This program is free software; you may redistribute it under the
> terms of the GNU General Public License version 3 or (at your option)
> any later version. This program has absolutely no warranty. 
> 15e20ce2324a:~/git/linux # rpm -q binutils binutils-2.38-6.2.x86_64 
> 15e20ce2324a:~/git/linux #
> 
> 15e20ce2324a:~/git/linux # readelf -wi
> ../build/v6.0.0+binutils-latest/vmlinux|grep DW_TAG_unspecified_type 
> 15e20ce2324a:~/git/linux #
> 
> 15e20ce2324a:~/git/linux # egrep BTF\|DWARF\|PAHOLE
> ../build/v6.0.0+binutils-latest/.config CONFIG_PAHOLE_VERSION=122 
> CONFIG_VIDEO_SONY_BTF_MPX=m 
> CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y #
> CONFIG_DEBUG_INFO_DWARF4 is not set # CONFIG_DEBUG_INFO_DWARF5 is not
> set CONFIG_DEBUG_INFO_BTF=y CONFIG_PAHOLE_HAS_SPLIT_BTF=y 
> CONFIG_DEBUG_INFO_BTF_MODULES=y # CONFIG_MODULE_ALLOW_BTF_MISMATCH is
> not set 15e20ce2324a:~/git/linux #
> 
> 
> Its CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y and it ends up being 
> DWARF5 as its the toolchain default, at least from the 
> /usr/local/bin/readelf -wi output below.
> 
> Can you hand me your kernel .config file, please?
> 
> 
> <1><92163>: Abbrev Number: 0 Compilation Unit @ offset 0x92164: 
> Length:        0x24 (32-bit) Version:       5 Unit Type:
> DW_UT_compile (1) Abbrev Offset: 0x5555 Pointer Size:  8 <0><92170>:
> Abbrev Number: 1 (DW_TAG_compile_unit) <92171>   DW_AT_stmt_list   :
> 0x7df2 <92175>   DW_AT_low_pc      : 0xffffffff81c62000 <9217d>
> DW_AT_high_pc     : 19 <9217e>   DW_AT_name        : (indirect
> string, offset: 0x1878d): /root/git/linux/arch/x86/entry/entry.S 
> <92182>   DW_AT_comp_dir    : (indirect string, offset: 0x2a):
> /root/git/build/v6.0.0+binutils-latest <92186>   DW_AT_producer    :
> (indirect string, offset: 0x51): GNU AS 2.38 <9218a>   DW_AT_language
> : 32769 (MIPS assembler) Compilation Unit @ offset 0x9218c: Length:
> 0x1f (32-bit) Version:       5 Unit Type:     DW_UT_compile (1) 
> Abbrev Offset: 0x5569 Pointer Size:  8 <0><92198>: Abbrev Number: 1
> (DW_TAG_compile_unit) <92199>   DW_AT_stmt_list   : 0x7e43 <9219d>
> DW_AT_ranges      : 0x12e3 <921a1>   DW_AT_name        : (indirect
> string, offset: 0x187b4): /root/git/linux/arch/x86/entry/entry_64.S 
> <921a5>   DW_AT_comp_dir    : (indirect string, offset: 0x2a):
> /root/git/build/v6.0.0+binutils-latest <921a9>   DW_AT_producer    :
> (indirect string, offset: 0x51): GNU AS 2.38 <921ad>   DW_AT_language
> : 32769 (MIPS assembler) Compilation Unit @ offset 0x921af: Length:
> 0x1e93 (32-bit) Version:       5 Unit Type:     DW_UT_compile (1) 
> Abbrev Offset: 0x557b Pointer Size:  8 <0><921bb>: Abbrev Number: 13
> (DW_TAG_compile_unit) <921bc>   DW_AT_producer    : (indirect string,
> offset: 0x6622): GNU C11 12.1.1 20220629 [revision
> 7811663964aa7e31c3939b859bbfa2e16919639f] -mno-sse -mno-mmx -mno-sse2
> -mno-3dnow -mno-avx -m64 -mno-80387 -mno-fp-ret-in-387
> -mpreferred-stack-boundary=3 -mskip-rax-setup -mtune=generic
> -mno-red-zone -mcmodel=kernel -mindirect-branch=thunk-extern
> -mindirect-branch-register -mindirect-branch-cs-prefix
> -mfunction-return=thunk-extern -mharden-sls=all -mrecord-mcount
> -mfentry -march=x86-64 -g -O2 -std=gnu11 -p -fno-strict-aliasing
> -fno-common -fshort-wchar -fno-PIE -fcf-protection=none
> -falign-jumps=1 -falign-loops=1 -fno-asynchronous-unwind-tables
> -fno-jump-tables -fno-delete-null-pointer-checks
> -fno-allow-store-data-races -fstack-protector-strong
> -fno-stack-clash-protection -fzero-call-used-regs=used-gpr
> -fno-strict-overflow -fstack-check=no -fconserve-stack <921c0>
> DW_AT_language    : 29    (C11) <921c1>   DW_AT_name        :
> (indirect line string, offset: 0x14b6):
> /root/git/linux/arch/x86/entry/syscall_64.c <921c5>   DW_AT_comp_dir
> : (indirect line string, offset: 0):
> /root/git/build/v6.0.0+binutils-latest <921c9>   DW_AT_stmt_list   :
> 0x8110 <1><921cd>: Abbrev Number: 6 (DW_TAG_base_type) <921ce>
> DW_AT_byte_size   : 8 <921cf>   DW_AT_encoding    : 7     (unsigned) 
> <921d0>   DW_AT_name        : (indirect string, offset: 0x4dc4): long
> unsigned int
> 

