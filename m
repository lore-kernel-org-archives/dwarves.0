Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE22C433FE
	for <linux-dwarves@archiver.kernel.org>; Tue,  4 Oct 2022 21:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbiJDVqU (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 4 Oct 2022 17:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbiJDVpr (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 4 Oct 2022 17:45:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8862B3D
        for <dwarves@vger.kernel.org>; Tue,  4 Oct 2022 14:44:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 437E36152F
        for <dwarves@vger.kernel.org>; Tue,  4 Oct 2022 21:44:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C1EC433D6;
        Tue,  4 Oct 2022 21:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664919842;
        bh=HYb9dY5mzfeiYfbWMYhsJUB092JR76k1qmjVKwHVk9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dxUknuAqUkvt5E85/qkzndPu0z1GujM8NwZxJdLYYmBGbiONbLqyUwGJssnuvSMsZ
         taSfI4WmmZn3mtXEIWSMwEfy+jmWz2mqpaYiqyqPBqFWFgqf0v4pT8OOMqK1L5RnEp
         T18XPOGr3UFcDsuVDFXI6bGyGce0EucNFHfG5giLv5/EsKoukA22kaatbrz2O+NPnK
         SLUr8N5MHFAR8jYikZOjcUjZsTgTYaoX1mq9F03rTL60j05J9oqinGCJUhyOvR/bV6
         Ku+UlNRjXz1saUO+V6UcWzgYAF1btXZ5ImTupA3RqpIWAj4u66FG/wr6jPG2tlF7v5
         JFPQdmxlalwCg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 35CC64062C; Tue,  4 Oct 2022 18:44:00 -0300 (-03)
Date:   Tue, 4 Oct 2022 18:44:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>
Cc:     dwarves@vger.kernel.org, Nick Clifton <nickc@redhat.com>
Subject: Re: Encountered error while encoding BTF due to Unsupported
 DW_TAG_unspecified_type(0x3b)
Message-ID: <YzypIDbTomaZOPOY@kernel.org>
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

I assume "binutils master" means:

git://sourceware.org/git/binutils-gdb.git master?

- Arnaldo
 
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
> 
> Thanks,
> Martin

-- 

- Arnaldo
