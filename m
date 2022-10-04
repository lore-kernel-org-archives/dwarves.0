Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3FCC433F5
	for <linux-dwarves@archiver.kernel.org>; Tue,  4 Oct 2022 12:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiJDMR6 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 4 Oct 2022 08:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiJDMR4 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 4 Oct 2022 08:17:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7486358DF5
        for <dwarves@vger.kernel.org>; Tue,  4 Oct 2022 05:17:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12A0D613FB
        for <dwarves@vger.kernel.org>; Tue,  4 Oct 2022 12:17:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D561C433C1;
        Tue,  4 Oct 2022 12:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664885869;
        bh=gj+lmGiQ6/eyQbz4IlLGjbfszcAc6g1PRbRVTIskYsU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RguyANGEv93VT/O5pLLdgIyZRInBVC1QjvFRted0g3z4shFgEIsloYX+JPEWlGjAD
         2AjUNqZdGHhqNYdyzo3oRivSKHdCFcqyFBq1Ltzr9BaKFIWZ9hnErcXpIUf+9n339u
         uDLF0qinwEDKBsRz7uCpD2o7NCvzMqvGX+hBvxyo9mJXUYNadkyZq1E9JsN3baI6BW
         +yIQ3FAX3ESqkoCXwZadkXDKAxApjeYwe5apCjEM1v/qVb9GQC0T5YOp62af7nJLz5
         oTsspLATT7pBumfIRQz9dqfbhYfOTTT1P/aWXQdRk2dxMSdXxgEaoP4mAr83Uhim/L
         6DdeCjcd0E6GA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9263A4062C; Tue,  4 Oct 2022 09:17:47 -0300 (-03)
Date:   Tue, 4 Oct 2022 09:17:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     dwarves@vger.kernel.org, Nick Clifton <nickc@redhat.com>
Subject: Re: Encountered error while encoding BTF due to Unsupported
 DW_TAG_unspecified_type(0x3b)
Message-ID: <YzwkazNc6wNCpQTN@kernel.org>
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

Ok, it happens at the top level of a CU and there are users for it, now
to try to figure out how to best support this in the pretty printer,
DWARF loader and BTF encoder.

- Arnaldo

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
