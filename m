Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48910C433EF
	for <linux-dwarves@archiver.kernel.org>; Wed,  8 Dec 2021 11:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbhLHL6k (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 8 Dec 2021 06:58:40 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47024 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbhLHL6j (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 8 Dec 2021 06:58:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A4411B8206F
        for <dwarves@vger.kernel.org>; Wed,  8 Dec 2021 11:55:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BAE8C341C3;
        Wed,  8 Dec 2021 11:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638964505;
        bh=MVzXyYhof199XLEIIemoauAqh4qIgLekkbCyD9na5Hg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fGR43sLPDuBGzNgGxSpIq91g3xSx0kny5sSm1QW4XgjK8Be+lJJGrhoSd+KfJe9T9
         qxfwDnPTaXdH2X+CDMu0vaOqCK2EUAPDrxSmxwMH8Amk1RSJLBDFHwZWQEVHHJI6P+
         SW6lD6OjPlu92bvOvdYO6+Xb+Kjv1ezMuahrf6qN7uiRcoSrAE8mNEjIpoWMZd9rd7
         5AG9lOHGnE4x+bC4lAWSzwP+IKhAPEt+M4mMh+5YBSrKwEYXaziFXetiv+UonsZFPz
         g2mz1FAMeZTXGlnu3Ug88qYYrthLW9Ou4yv/z8UmcUwE3EqpjTaR9EAN1GCvFI37YC
         zgNJnGfIo39dw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 44C20406C1; Wed,  8 Dec 2021 08:55:02 -0300 (-03)
Date:   Wed, 8 Dec 2021 08:55:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Douglas RAILLARD <douglas.raillard@arm.com>
Cc:     acme@redhat.com, dwarves@vger.kernel.org
Subject: Re: [PATCH v2 0/6] improve expanded header
Message-ID: <YbCdFkVyuSO6330g@kernel.org>
References: <20211207173151.2283946-1-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207173151.2283946-1-douglas.raillard@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Tue, Dec 07, 2021 at 05:31:45PM +0000, Douglas RAILLARD escreveu:
> From: Douglas Raillard <douglas.raillard@arm.com>
> 
> Improve headers generated with -E in a few ways:
> 
>   * Print each type only once, to avoid redefinitions
> 
>   * --forward_decl: Generate forward declaration for struct and union so
>     that uses of pointers will work.
> 
>   * --expanded_prefix: Allow prefixing names of types added by -E (all
>     the ones not explicitly requested with -C) so they can be namespaced
>     manually. This is important in order to be able to mix
>     pahole-generated headers with existing headers without clash or
>     maintenance.

Looks good from a very quick first view, I'll cut 1.23 today as the BPF
guys need a release with the new BTF tag feature and then will review
this patchset.

So I've applied so far only the reverts, since yesterday I had flipped
next to master.

- Arnaldo
 
> 
> types.txt:
> 
>   t1
>   t4
> 
> Original printed type with "-C types.txt -E":
> 
>   struct t1 {
>     struct t2 *a;
>     struct t3 {
>       int a;
>     } b;
>   };
> 
>   struct t4 {
>     struct t3 {
>       int a;
>     } a;
>   };
> 
> After this series and with
> "-C types.txt -E --expanded_prefix __pahole --forward_decl":
> 
>   struct t1
>   struct t2;
>   struct t3;
> 
>   struct t1 {
>     struct t2 *a;
>     struct __pahole_t3 {
>       int a;
>     } b;
>   };
> 
>   struct t4 {
>     struct __pahole_t3 a;
>   };
> 
> 
> This header can be freely mixed with any other header as long as they
> don't define t1 or t4 (if there is a clash, then pahole is not necessary
> and the user can just use the header in the first place).
> 
> TODOs:
> 
>   * Define types on their first use even when they are first used as
>     pointers. Currently, if a type is only used as pointer it will never
>     get defined, which will still compile thanks to --forward_decl but
>     won't allow easy use of the values.
> 
>   * The prefix system allocates memory to rename types and never frees
>     it. I don't think it's a big issue for now as it's done inside
>     pahole.c and type names are likely necessary until the end of the
>     process anyway, but it makes valgrind angry and could therefore mask
>     other problems. There is another implementation of prefix that
>     modifies dwarves_fprintf.c instead of changing the name but it was
>     very invasive and impossible to check if prefixable spots were
>     missed.
> 
> 
> This series is to be applied on the "next" branch as it includes reverts
> of the --inner_anonymous series, which is dropped since it could not
> cope with recursive types.
> 
> 
> Douglas Raillard (6):
>   Revert "fprintf: Allow making struct/enum/union anonymous"
>   Revert "pahole.c: Add --inner_anonymous option"
>   fprintf: Print types only once
>   pahole.c: Add prefix to expanded type names
>   pahole.c: Add --expanded_prefix option
>   pahole.c: Add --forward_decl option
> 
>  dwarves.h          | 12 ++++--
>  dwarves_emit.c     |  2 +-
>  dwarves_fprintf.c  | 77 +++++++++++++++++-------------------
>  man-pages/pahole.1 |  8 ++--
>  pahole.c           | 98 ++++++++++++++++++++++++++++++++++------------
>  5 files changed, 121 insertions(+), 76 deletions(-)
> 
> -- 
> 2.25.1

-- 

- Arnaldo
