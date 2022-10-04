Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550B1C433FE
	for <linux-dwarves@archiver.kernel.org>; Tue,  4 Oct 2022 12:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiJDMPk (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 4 Oct 2022 08:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiJDMPh (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 4 Oct 2022 08:15:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEF7186C2
        for <dwarves@vger.kernel.org>; Tue,  4 Oct 2022 05:15:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A993613F9
        for <dwarves@vger.kernel.org>; Tue,  4 Oct 2022 12:15:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E43C43470;
        Tue,  4 Oct 2022 12:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664885730;
        bh=f9773BFZFki+nwD/4UWTfOUCtin/OMa7u0jG+2aCN8I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ghWQg4WsY9/czEwae+Bh27tEpfKhibeiIshEdq9xrcceAQ0iDobti8l+qYMr/8Uaj
         UtmUT34UkuHejcChLnWNgDGNBZ42QebkdYAiTxeniCu1EQv+LMZcKM4xpeGso+4pU0
         J/bQvh/PyjGnsPoZOm0tKkHflBToijlI8ralCRT+aqpEQL7lemsGoX9oUL+eWvkr8G
         PImsIfSLjrlPpcDiJAG558PXmtiA0Nwi0x/u/YwNheFvay9BEm0HpBstGfoBVtmAvh
         pL8ePchUAwKuF/f64iNHl4rQHrMHcMnHm8RKBrkvyjU6fsOl07w9E7Ix7OGDgnP050
         y2HksyjGj4wWA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0443D4062C; Tue,  4 Oct 2022 09:15:27 -0300 (-03)
Date:   Tue, 4 Oct 2022 09:15:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Nick Clifton <nickc@redhat.com>
Cc:     Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        dwarves@vger.kernel.org
Subject: Re: Encountered error while encoding BTF due to Unsupported
 DW_TAG_unspecified_type(0x3b)
Message-ID: <Yzwj36tohHYN+LFQ@kernel.org>
References: <878d0959-7f80-471e-69d5-5228822b4365@suse.cz>
 <a8e2a00b-0a9b-1433-7698-364b36af73a7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8e2a00b-0a9b-1433-7698-364b36af73a7@redhat.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Mon, Oct 03, 2022 at 01:07:14PM +0100, Nick Clifton escreveu:
> Hi Martin,
> 
> > I noticed one can't build 5.19 with latest binutils master.
> > 
> > One see the following error:
> > [ 1413s]   BTF     .btf.vmlinux.bin.o
> > [ 1413s] Unsupported DW_TAG_unspecified_type(0x3b)
> 
> >   <0><c>: Abbrev Number: 3 (DW_TAG_unspecified_type) <--- the problematic TAG
> 
> > Is it something pahole should handle?
> 
> Yes, I believe so.  The tag is a valid DWARF tag, and GDB wants it, so
> it would be good if pahole could support it.

I'll check and fix this, thanks for the report.

- Arnaldo
