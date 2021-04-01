Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58AEC433B4
	for <linux-dwarves@archiver.kernel.org>; Thu,  1 Apr 2021 17:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8515E60FE7
	for <linux-dwarves@archiver.kernel.org>; Thu,  1 Apr 2021 17:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236031AbhDARxn (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 1 Apr 2021 13:53:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:48902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236330AbhDARsA (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Thu, 1 Apr 2021 13:48:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D6A7611CB;
        Thu,  1 Apr 2021 12:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617281962;
        bh=QFBvSxpFBe+JRLuZOO99kIhfEMTprfAcsBarAbnDeB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AaizDmKnP+8Q4qYSu0tQ8ujlblwti05LFGjCWGhiRTuK+AYogq5z1pOMOsZJrr+tG
         RYUKsyFsylCUs0z+9eSvZAhsrXccM8ZDaYQxgyKocKxJJj7HjB0kg24bPJMcfy2Y59
         xjMI1ppE05HQYRetrSrBNwXMgVSI8/rDhdIbGx9yRKYzygrvIcHmf9N2aGcYPhfQkZ
         UKxTbvPA15PzL5VoRjkBcUomSlyO7RUTKF7QspBiFMTGJOt1MU1k/1ACQ1v7R0fJNV
         5GSSlf6tKAYcHBD3YyA7eXaX5H9FE7obzEBaxRO9gLllY5e92vj4b0L/IXOJn4Ixhv
         C0BUUmqG4mf1g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DF52940647; Thu,  1 Apr 2021 09:59:19 -0300 (-03)
Date:   Thu, 1 Apr 2021 09:59:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bill Wendling <morbo@google.com>, bpf@vger.kernel.org,
        David Blaikie <dblaikie@gmail.com>,
        =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        kernel-team@fb.com, Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH dwarves 0/2] dwarf_loader: improve cus__merging_cu()
Message-ID: <YGXDp/AwQapX/wDj@kernel.org>
References: <20210401025815.2254256-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401025815.2254256-1-yhs@fb.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Wed, Mar 31, 2021 at 07:58:15PM -0700, Yonghong Song escreveu:
> Function cus__merging_cu() is introduced in Commit 39227909db3c
> ("dwarf_loader: Permit merging all DWARF CU's for clang LTO built
> binary") to test whether cross-cu references may happen.
> The original implementation anticipates compilation flags
> in dwarf, but later some concerns about binary size surfaced
> and the decision is to scan .debug_abbrev as a faster way
> to check cross-cu references. Also putting a note in vmlinux
> to indicate whether lto is enabled for built or not can
> provide a much faster way.

Great work! Reviewing/testing right now.

- Arnaldo
 
> This patch set implemented this two approaches, first
> checking the note (in Patch #2), if not found, then
> check .debug_abbrev (in Patch #1).
> 
> Yonghong Song (2):
>   dwarf_loader: check .debug_abbrev for cross-cu references
>   dwarf_loader: check .notes section for lto build info
> 
>  dwarf_loader.c | 76 ++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 55 insertions(+), 21 deletions(-)
> 
> -- 
> 2.30.2
> 

-- 

- Arnaldo
