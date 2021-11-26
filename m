Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F05AC433EF
	for <linux-dwarves@archiver.kernel.org>; Tue, 30 Nov 2021 13:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhK3Nix (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 30 Nov 2021 08:38:53 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37058 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240824AbhK3Niw (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 30 Nov 2021 08:38:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7CA9B819DF
        for <dwarves@vger.kernel.org>; Tue, 30 Nov 2021 13:35:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446FFC53FC7;
        Tue, 30 Nov 2021 13:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638279331;
        bh=TyhuEk+nBbWnKxZgPCC7EaSHSuyPxptxQEV4REXjkyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eAszGmUGpEHXaYI5elACUipFYA6627idtpBy1wsj4vEwhj9JZop/1s4M8k15ilRM9
         wzCLrnXr3P6JMdSs86dZI4trEMMK1y1YA6gfQMIos78AuMeWZw5njUh/6tgmvu4J9t
         wes42kZ81d0lxsm8vwSogwVO489DIkhBgdLIx2PIQBxmjnPmThebxzxFWK9cbiPE6+
         xHz7a9pLsKcI42TVsRGTAIJfCCdRqCKY0sw/hd8n62aGa8oZftakBd3F5GzPLF7pPK
         erKl7zwjFpsjEkF3eXfw3JcNrki4+fRkFIzVmIwxoaTf0EzIRzC5T775J1uMi8lttS
         JI014gUIQOT0A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A2C354043D; Fri, 26 Nov 2021 15:27:41 -0300 (-03)
Date:   Fri, 26 Nov 2021 15:27:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Douglas RAILLARD <douglas.raillard@arm.com>
Cc:     acme@redhat.com, dwarves@vger.kernel.org
Subject: Re: [PATCH v1 1/2] fprintf: Allow making struct/enum/union anonymous
Message-ID: <YaEnHVi+i8mx54BB@kernel.org>
References: <20211019100724.325570-1-douglas.raillard@arm.com>
 <20211019100724.325570-2-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211019100724.325570-2-douglas.raillard@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Tue, Oct 19, 2021 at 11:07:23AM +0100, Douglas RAILLARD escreveu:
> From: Douglas Raillard <douglas.raillard@arm.com>
> 
> Allow making inner struct enums and union anonymous.

So I had to apply it by hand due to changes in the areas it touches, see
below, and I expanded a bit the commit message, please review:


------ 8< ------------------------

fprintf: Allow making struct/enum/union anonymous

Allow making inner struct enums and union anonymous, so that when using
-E to expand types we don't end up with multiple definitions for
expanded inner structs, allowing the resulting expanded struct to be
compilable.

Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
------ 8< ------------------------

⬢[acme@toolbox pahole]$ patch -p1 < ~/wb/1.patch
patching file dwarves.h
Hunk #1 succeeded at 105 (offset 6 lines).
Hunk #2 succeeded at 1372 with fuzz 2 (offset 44 lines).
patching file dwarves_emit.c
patching file dwarves_fprintf.c
Hunk #1 succeeded at 198 (offset 12 lines).
Hunk #2 succeeded at 331 (offset 12 lines).
Hunk #3 succeeded at 342 (offset 12 lines).
Hunk #4 succeeded at 395 (offset 12 lines).
Hunk #5 succeeded at 639 (offset 12 lines).
Hunk #6 succeeded at 656 (offset 12 lines).
Hunk #7 succeeded at 814 (offset 12 lines).
Hunk #8 succeeded at 824 with fuzz 1 (offset 12 lines).
Hunk #9 succeeded at 833 with fuzz 2 (offset 12 lines).
Hunk #10 succeeded at 998 (offset 23 lines).
Hunk #11 succeeded at 1013 (offset 23 lines).
Hunk #12 succeeded at 1375 (offset 23 lines).
Hunk #13 succeeded at 1396 (offset 23 lines).
Hunk #14 succeeded at 1822 (offset 23 lines).
Hunk #15 succeeded at 1909 (offset 23 lines).
Hunk #16 succeeded at 1917 (offset 23 lines).
Hunk #17 succeeded at 1929 (offset 23 lines).
⬢[acme@toolbox pahole]$
