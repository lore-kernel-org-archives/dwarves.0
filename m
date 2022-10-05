Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD75C433FE
	for <linux-dwarves@archiver.kernel.org>; Wed,  5 Oct 2022 08:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiJEIls (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 5 Oct 2022 04:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJEIls (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 5 Oct 2022 04:41:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FAA31222
        for <dwarves@vger.kernel.org>; Wed,  5 Oct 2022 01:41:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E4B5D21879;
        Wed,  5 Oct 2022 08:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664959305; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F/mAYNNky7TD9475KNYL0kmMLR9eO2c/2msn/ym/xEQ=;
        b=ReQ87EnoQ61gZB+9qWayS9UByb9aiZJbboC1aXGHeMKAlM1FYzloZhDKbou4oxwh+7DOx/
        X6ZzTJr+8rwPO32y0V2q34agkgLP+35AeeaFjHlsqmScQV6ohH5D9pfQruUaVUF/G+tlmK
        X3Ww0SpTKf1xUbbX9ha12U9HvGts8EU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664959305;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F/mAYNNky7TD9475KNYL0kmMLR9eO2c/2msn/ym/xEQ=;
        b=xw/byuMAcnZL4t9SkcyaDQp67mE2/UIMDpyln6RjWgMGD9jv+jdj6h3dGIJNBbdhoXqjo+
        OP7HoXQnYVge+PBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C395B13345;
        Wed,  5 Oct 2022 08:41:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5v7MLklDPWNwAwAAMHmgww
        (envelope-from <mliska@suse.cz>); Wed, 05 Oct 2022 08:41:45 +0000
Message-ID: <25467dcf-d5c3-545f-8310-a35dd183b1af@suse.cz>
Date:   Wed, 5 Oct 2022 10:41:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: Encountered error while encoding BTF due to Unsupported
 DW_TAG_unspecified_type(0x3b)
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     dwarves@vger.kernel.org, Nick Clifton <nickc@redhat.com>
References: <878d0959-7f80-471e-69d5-5228822b4365@suse.cz>
 <YzwkazNc6wNCpQTN@kernel.org> <Yzwnk/a1ROHrtA2/@kernel.org>
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
In-Reply-To: <Yzwnk/a1ROHrtA2/@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On 10/4/22 14:31, Arnaldo Carvalho de Melo wrote:
> |Martin, can you try a facility that was put in place to skip Rust kernel modules, for some other DWARF generation problem?|

Hi.

Can't test that right now as we miss latest libbpf and dwarves in openSUSE Tumbleweed. Apparently,
we're waiting for systemd support ([1]).

So it might be easier for you to reproduce the issue with latest binutils, right?

Cheers,
Martin

[1] https://github.com/systemd/systemd/issues/24464
