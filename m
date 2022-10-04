Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768B1C433FE
	for <linux-dwarves@archiver.kernel.org>; Tue,  4 Oct 2022 12:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiJDMbY (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 4 Oct 2022 08:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiJDMbX (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 4 Oct 2022 08:31:23 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E024127DF6
        for <dwarves@vger.kernel.org>; Tue,  4 Oct 2022 05:31:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 471ACCE1057
        for <dwarves@vger.kernel.org>; Tue,  4 Oct 2022 12:31:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2450DC433D7;
        Tue,  4 Oct 2022 12:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664886678;
        bh=2lLAAjZtObDk0Rlk7500LrOZey/nh/Hl+95OZZ2xMf4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SyQnVUP0jcKwrL7SRk/UTnmg0rAj3oxsR0l8OqMU/Bpv/PFDfHQu4D7EFiWPWS6O9
         itpgcruYK1cQ01al7Q8/pnZwta51TsjtCbtWCsBw3URiGJqQFHx6Yqzn4CGV9dNxzi
         p0M9o8s4uOajFbXbbESbG7fITkW1eZeHf5ovOQn6QoEi1SbR3g60mzYPj1D94Uo/jY
         6FVCsLKWWDNJuFQyPbz6sPQJp+fsQ6vwZX1S/GyrP314PgBIZtbQ5HSBT3+Lz7xIRX
         ezGRoE9MqByPNh3WWSYkEyjZzmoJuSJstrUG2fwiGOKCN+H0Rzwm8zY81nNZKo5/zG
         HCGZJXOEsnWJA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E3E304062C; Tue,  4 Oct 2022 09:31:15 -0300 (-03)
Date:   Tue, 4 Oct 2022 09:31:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     dwarves@vger.kernel.org, Nick Clifton <nickc@redhat.com>
Subject: Re: Encountered error while encoding BTF due to Unsupported
 DW_TAG_unspecified_type(0x3b)
Message-ID: <Yzwnk/a1ROHrtA2/@kernel.org>
References: <878d0959-7f80-471e-69d5-5228822b4365@suse.cz>
 <YzwkazNc6wNCpQTN@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YzwkazNc6wNCpQTN@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Tue, Oct 04, 2022 at 09:17:47AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Oct 03, 2022 at 10:56:36AM +0200, Martin Liška escreveu:
> > I noticed one can't build 5.19 with latest binutils master.
> > 
> > One see the following error:
> > [ 1413s]   BTF     .btf.vmlinux.bin.o
> > [ 1413s] Unsupported DW_TAG_unspecified_type(0x3b)
> > [ 1413s] Encountered error while encoding BTF.
> > 
> > It's caused by DWARF coming from .S files and the change is introduced since
> > the following binutils revision:
> > 
> > commit 5578fbf672ee497ea19826edeb509f4cc3e825a8
> > Author: Nick Clifton <nickc@redhat.com>
> > Date:   Thu Aug 25 11:48:00 2022 +0100
> > 
> >     GAS: Add a return type tag to DWARF DIEs generated for function symbols.
> > 
> > for entry.S the output changes to:
> > 
> > $ as-new --gdwarf-5 --64 -o entry.o entry.S && readelf -wi entry.o
> > Contents of the .debug_info section:
> > 
> >   Compilation Unit @ offset 0x0:
> >    Length:        0x35 (32-bit)
> >    Version:       5
> >    Unit Type:     DW_UT_compile (1)
> >    Abbrev Offset: 0x0
> >    Pointer Size:  8
> >  <0><c>: Abbrev Number: 3 (DW_TAG_unspecified_type) <--- the problematic TAG
> >  <0><d>: Abbrev Number: 1 (DW_TAG_compile_unit)
> >     <e>   DW_AT_stmt_list   : 0x0
> >     <12>   DW_AT_low_pc      : 0x0
> >     <1a>   DW_AT_high_pc     : 19
> >     <1b>   DW_AT_name        : (indirect string, offset: 0x0): ../arch/x86/entry/entry.S
> >     <1f>   DW_AT_comp_dir    : (indirect string, offset: 0x1a): /tmp
> >     <23>   DW_AT_producer    : (indirect string, offset: 0x1f): GNU AS 2.39.50
> >     <27>   DW_AT_language    : 32769	(MIPS assembler)
> >  <1><29>: Abbrev Number: 2 (DW_TAG_subprogram)
> >     <2a>   DW_AT_name        : (indirect string, offset: 0x2e): entry_ibpb
> >     <2e>   DW_AT_external    : 1
> >     <2e>   DW_AT_type        : <0xc>
> 
> Ok, it happens at the top level of a CU and there are users for it, now
> to try to figure out how to best support this in the pretty printer,
> DWARF loader and BTF encoder.

And it is for an assembly routine, which clarifies things a bit more,
Andrii, Yonghong, should we try to encode BTF for assembly? Or just
skip it?

Martin, can you try a facility that was put in place to skip Rust kernel
modules, for some other DWARF generation problem?

oops, I didn't antecipate, assembler, so please try with the patch below
and then add:

   --lang_exclude asm

I.e. this extra patch, for the kernel:

diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
index 0d99ef17e4a52876..b999c6f0979ac02c 100755
--- a/scripts/pahole-flags.sh
+++ b/scripts/pahole-flags.sh
@@ -20,4 +20,8 @@ if [ "${pahole_ver}" -ge "122" ]; then
 	extra_paholeopt="${extra_paholeopt} -j"
 fi
 
+if [ "${pahole_ver}" -ge "124" ]; then
+	extra_paholeopt="${extra_paholeopt} --lang_exclude asm"
+fi
+
 echo ${extra_paholeopt}


------------------------------------------------------------------------

diff --git a/dwarves.c b/dwarves.c
index 9589747f49f8f3a7..0405592ce0a540a5 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -2240,6 +2240,9 @@ int lang__str2int(const char *lang)
 	[DW_LANG_UPC]		 = "upc",
 	};
 
+	if (strcasecmp(lang, "asm") == 0)
+		return DW_LANG_Mips_Assembler;
+
 	// c89 is the first, bliss is the last, see /usr/include/dwarf.h
 	for (int id = DW_LANG_C89; id <= DW_LANG_BLISS; ++id)
 		if (languages[id] && strcasecmp(lang, languages[id]) == 0)
