Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F03C433FE
	for <linux-dwarves@archiver.kernel.org>; Wed,  5 Oct 2022 07:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiJEHXg (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 5 Oct 2022 03:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJEHXf (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 5 Oct 2022 03:23:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73083696EA
        for <dwarves@vger.kernel.org>; Wed,  5 Oct 2022 00:23:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1089D1F74A;
        Wed,  5 Oct 2022 07:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664954613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lfSUIHR4N6gAA76pkvRWBrzmqXW74w37s+g+PNPc0XI=;
        b=wwex5wWbt/XEHWRtmsic3phLGMjiDR0MPPA+KPKFH6AOvaE0M3vgMqglJaYrujeJMcYf6e
        pa4aY1BTJAiSMH9slSd/fa06bQdLsQKdkjBIyE1tkpKH6gfHbcOljcqyZChNyGrFB8CUhy
        q1IXMdN1wfJ9aJRxYwAXECQj39p9MDs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664954613;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lfSUIHR4N6gAA76pkvRWBrzmqXW74w37s+g+PNPc0XI=;
        b=m448sqBn5lSrTV6SX2CNhnG3V/cCNmUpeYSloLwhbRjxVf2APgR11EtoTh9ajFegu2hMmQ
        ReeL3Iz7G/D6DBBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E862713345;
        Wed,  5 Oct 2022 07:23:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DAXDN/QwPWP0XgAAMHmgww
        (envelope-from <mliska@suse.cz>); Wed, 05 Oct 2022 07:23:32 +0000
Message-ID: <a57a66b1-9457-a84f-6f66-9695aab01b1a@suse.cz>
Date:   Wed, 5 Oct 2022 09:23:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: Encountered error while encoding BTF due to Unsupported
 DW_TAG_unspecified_type(0x3b)
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     dwarves@vger.kernel.org, Nick Clifton <nickc@redhat.com>
References: <878d0959-7f80-471e-69d5-5228822b4365@suse.cz>
 <YzypIDbTomaZOPOY@kernel.org>
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
In-Reply-To: <YzypIDbTomaZOPOY@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On 10/4/22 23:44, Arnaldo Carvalho de Melo wrote:
> I assume "binutils master" means:
> 
> git://sourceware.org/git/binutils-gdb.git master?

Yes.

Martin
