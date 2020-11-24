Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC66C64E7D
	for <linux-dwarves@archiver.kernel.org>; Tue, 24 Nov 2020 13:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEFD4204EC
	for <linux-dwarves@archiver.kernel.org>; Tue, 24 Nov 2020 13:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388265AbgKXNa4 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 24 Nov 2020 08:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388288AbgKXNaz (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 24 Nov 2020 08:30:55 -0500
X-Greylist: delayed 314 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 24 Nov 2020 05:30:55 PST
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEE4C0613D6
        for <dwarves@vger.kernel.org>; Tue, 24 Nov 2020 05:30:55 -0800 (PST)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 81BE9588D8B00; Tue, 24 Nov 2020 14:25:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 7E71E60D71FC6;
        Tue, 24 Nov 2020 14:25:39 +0100 (CET)
Date:   Tue, 24 Nov 2020 14:25:39 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
cc:     dwarves@vger.kernel.org
Subject: Re: pahole v1.19
In-Reply-To: <20201124130202.GA5391@kernel.org>
Message-ID: <p3npn8qr-51rq-r8oq-80os-q2qnq9593r84@vanv.qr>
References: <20201124130202.GA5391@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Tuesday 2020-11-24 14:02, Arnaldo Carvalho de Melo wrote:

>	The v1.19 release of pahole and its friends is out, available at
>the usual places:
>
>Main git repo:
>
>   git://git.kernel.org/pub/scm/devel/pahole/pahole.git

Nitpick: the 1.19 tag is absent.
