Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8401DC433FE
	for <linux-dwarves@archiver.kernel.org>; Mon,  3 Oct 2022 09:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiJCJEg (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 3 Oct 2022 05:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiJCJD7 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 3 Oct 2022 05:03:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1255D62CF
        for <dwarves@vger.kernel.org>; Mon,  3 Oct 2022 01:56:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 759E61F8CA;
        Mon,  3 Oct 2022 08:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664787397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=e0hZ/eXadL4Zro97ixeuoI+0Wo14Pn8hRyssotfIK6M=;
        b=0OZmWdQWY2RtoC8j+NtMfTtLmddv4E9C/+z4yV71BUoi8i3Rfkl8PYISwTHcvPCwf62OvP
        vV7h1pDnj07AohjNGm3pW1hts34bG0K8hIlwsciy8ngpE319upDWA6IGp154oc7atI3cou
        AJjbroB992oBlZLnINWl0nAZtK90HnI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664787397;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=e0hZ/eXadL4Zro97ixeuoI+0Wo14Pn8hRyssotfIK6M=;
        b=Y1Qo8GwBywvIWqejjFp90wI/HmWBYcqTBj6y2eLmoV95eYLVoHZ4R3N4T1vHb6sFR+QO3w
        jxyq15JPRRxa+JDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D9EA13522;
        Mon,  3 Oct 2022 08:56:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TusMFcWjOmOHagAAMHmgww
        (envelope-from <mliska@suse.cz>); Mon, 03 Oct 2022 08:56:37 +0000
Message-ID: <878d0959-7f80-471e-69d5-5228822b4365@suse.cz>
Date:   Mon, 3 Oct 2022 10:56:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US
To:     dwarves@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Nick Clifton <nickc@redhat.com>
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
Subject: Encountered error while encoding BTF due to Unsupported
 DW_TAG_unspecified_type(0x3b)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

I noticed one can't build 5.19 with latest binutils master.

One see the following error:
[ 1413s]   BTF     .btf.vmlinux.bin.o
[ 1413s] Unsupported DW_TAG_unspecified_type(0x3b)
[ 1413s] Encountered error while encoding BTF.

It's caused by DWARF coming from .S files and the change is introduced since
the following binutils revision:

commit 5578fbf672ee497ea19826edeb509f4cc3e825a8
Author: Nick Clifton <nickc@redhat.com>
Date:   Thu Aug 25 11:48:00 2022 +0100

    GAS: Add a return type tag to DWARF DIEs generated for function symbols.

for entry.S the output changes to:

$ as-new --gdwarf-5 --64 -o entry.o entry.S && readelf -wi entry.o
Contents of the .debug_info section:

  Compilation Unit @ offset 0x0:
   Length:        0x35 (32-bit)
   Version:       5
   Unit Type:     DW_UT_compile (1)
   Abbrev Offset: 0x0
   Pointer Size:  8
 <0><c>: Abbrev Number: 3 (DW_TAG_unspecified_type) <--- the problematic TAG
 <0><d>: Abbrev Number: 1 (DW_TAG_compile_unit)
    <e>   DW_AT_stmt_list   : 0x0
    <12>   DW_AT_low_pc      : 0x0
    <1a>   DW_AT_high_pc     : 19
    <1b>   DW_AT_name        : (indirect string, offset: 0x0): ../arch/x86/entry/entry.S
    <1f>   DW_AT_comp_dir    : (indirect string, offset: 0x1a): /tmp
    <23>   DW_AT_producer    : (indirect string, offset: 0x1f): GNU AS 2.39.50
    <27>   DW_AT_language    : 32769	(MIPS assembler)
 <1><29>: Abbrev Number: 2 (DW_TAG_subprogram)
    <2a>   DW_AT_name        : (indirect string, offset: 0x2e): entry_ibpb
    <2e>   DW_AT_external    : 1
    <2e>   DW_AT_type        : <0xc>
    <2f>   DW_AT_low_pc      : 0x0
    <37>   DW_AT_high_pc     : 19
 <1><38>: Abbrev Number: 0

Is it something pahole should handle?

Thanks,
Martin
