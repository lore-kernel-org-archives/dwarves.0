Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA6AC433EF
	for <linux-dwarves@archiver.kernel.org>; Thu, 28 Oct 2021 12:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20286610C8
	for <linux-dwarves@archiver.kernel.org>; Thu, 28 Oct 2021 12:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhJ1MnR (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 28 Oct 2021 08:43:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229835AbhJ1MnQ (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Thu, 28 Oct 2021 08:43:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D441F61037;
        Thu, 28 Oct 2021 12:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635424850;
        bh=DKrB3CCaDKUSNddEwb8HjK7Ch5RMCteNqLzTr59jbDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JXeKhmLaafmPM41Z2uma5zs/XnT5uj/CeOJLZYhLnJSHS6O4vQ4oxnrgXsEtHiFfy
         YDwksfQYLXZzDMWw50hPH4UxwOiH9U8piNPQtLPNp6HRM8IQmWS342/kE+X8GtzI5Y
         3oenkg6c/TVHmUMRAPBzWp/0kPZuepFQVz0e0Dn8m3l91cMYdx2nDQjyKIW/T7w+a9
         I9VfySqa0CwhJbl/245lInJH63ckJbi793dGYlL9hxbVtpc0DWuBK5k4FlHaDrEg3B
         T0BaIWB18KGHRwCQ/So01yD72k7BgSPCcsLjBG8fJXA3l6Pl3B1fE2hp4ul7/lu/G7
         RiN9ruB/+AFng==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4A632410A1; Thu, 28 Oct 2021 09:40:47 -0300 (-03)
Date:   Thu, 28 Oct 2021 09:40:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Douglas RAILLARD <douglas.raillard@arm.com>
Cc:     acme@redhat.com, dwarves@vger.kernel.org
Subject: Re: [PATCH v3 1/6] fprintf: Fix nested struct printing
Message-ID: <YXqaT5LdrzebP/C/@kernel.org>
References: <20211028122710.881181-1-douglas.raillard@arm.com>
 <20211028122710.881181-2-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028122710.881181-2-douglas.raillard@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Thu, Oct 28, 2021 at 01:27:05PM +0100, Douglas RAILLARD escreveu:
> From: Douglas Raillard <douglas.raillard@arm.com>
> 
> This code:
> 
>     struct X {
>        struct {
>        } __attribute__((foo)) x __attribute__((bar));
>     }
> 
> Was wrongly printed as:
> 
>     struct X {
>        struct {
>        } x __attribute__((foo)) __attribute__((bar));
>     }

This one is already in the 'next' branch, i.e. was already applied.

- Arnaldo
