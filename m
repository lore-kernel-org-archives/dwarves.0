Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145E6C433EF
	for <linux-dwarves@archiver.kernel.org>; Tue, 23 Nov 2021 00:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbhKWAjn (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 22 Nov 2021 19:39:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:48320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229672AbhKWAjm (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Mon, 22 Nov 2021 19:39:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E0AF60698;
        Tue, 23 Nov 2021 00:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637627795;
        bh=0Tn20kWk7b/WoAPr5BmzunAPCrVxBcPhkP/qP7Jq00M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DBFBIkVIS15Z5+eXbNq0OVUuMm5seE0lISOY4U5g4Ij+fBVgbbkdvtlnWO7FrPvtb
         INV3GC24qP89Jpw91Axn4/BWxMem5QC8rjM3EkT1Wn9/55N0fUpxLoYJyKlSjhj3Gk
         1aSxIxmk7Lfi+zabL4hHr6VvpgSbukp3A/PbDv0o3+9EfjJihYSajUyoG011tNet1i
         1wjhVbTtXjabxMHL6I+gRhToScK5FVkA3r0fwGYJV2fFxRPpQjUNJjrWwP4GVUtg1N
         nmSIuxj0FrnN/ZJ/jSSuZJJn1VMlX0TG+tjTvQ2y+vtVyp3OenRD/RxDkSrTvGrMmk
         LUzF4YlnGxzXA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2B31040002; Mon, 22 Nov 2021 21:36:32 -0300 (-03)
Date:   Mon, 22 Nov 2021 21:36:32 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Douglas Raillard <douglas.raillard@arm.com>
Cc:     acme@redhat.com, dwarves@vger.kernel.org
Subject: Re: [PATCH v1 0/2] Anonymous inner struct
Message-ID: <YZw3kD9Sm3SkuDKW@kernel.org>
References: <20211019100724.325570-1-douglas.raillard@arm.com>
 <5bf579b2-aafc-2ce2-7c84-e06eb2b4d78c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bf579b2-aafc-2ce2-7c84-e06eb2b4d78c@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Tue, Nov 16, 2021 at 02:09:44PM +0000, Douglas Raillard escreveu:
> Hi Arnaldo,
> 
> Any opinion on this series ?

I'll try and get back to processing pahole patches tomorrow,

- Arnaldo
 
> Cheers,
> Douglas
> 
> On 10/19/21 11:07 AM, Douglas RAILLARD wrote:
> > From: Douglas Raillard <douglas.raillard@arm.com>
> > 
> > Add an --inner_anonymous pahole CLI option to make inner
> > struct/enum/union anonymous. This allows turning this:
> > 
> >      struct foo { ... };
> >      struct bar {
> >          struct foo {
> >           ....
> >          } a;
> >      };
> > into this:
> > 
> >      struct foo { ... };
> >      struct bar {
> >          struct /* foo */ {
> >           ....
> >          } a;
> >      };
> > 
> > This avoids any conflict between the two definitions of struct foo. The
> > case arises when dumping multiple types at once with -E, all depending
> > on a same inner struct:
> > 
> >      struct bar {
> >          struct foo {
> >           ....
> >          } a;
> >      };
> >      struct bar2 {
> >          struct foo {
> >           ....
> >          } b;
> >      };
> > 
> > 
> > On top of that, struct foo could already be defined in a public header
> > already imported in the compilation unit, leading to a redefinition
> > error, while another nested struct is private and would still need -E
> > for the type to be usable.
> > 
> > Douglas Raillard (2):
> >    fprintf: Allow making struct/enum/union anonymous
> >    pahole.c: Add --inner_anonymous option
> > 
> >   dwarves.h         |  4 +++-
> >   dwarves_emit.c    |  2 +-
> >   dwarves_fprintf.c | 52 ++++++++++++++++++++++++++++++-----------------
> >   pahole.c          |  8 ++++++++
> >   4 files changed, 45 insertions(+), 21 deletions(-)
> > 

-- 

- Arnaldo
