Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1696DC433DB
	for <linux-dwarves@archiver.kernel.org>; Mon,  1 Feb 2021 17:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD01B64EAB
	for <linux-dwarves@archiver.kernel.org>; Mon,  1 Feb 2021 17:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhBAREY (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 1 Feb 2021 12:04:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:39658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230438AbhBAREH (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Mon, 1 Feb 2021 12:04:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D37F64DD9;
        Mon,  1 Feb 2021 17:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612199003;
        bh=BsQMFYXrjdYGJzcFksY0+IO1sFrW9e0//gaiedFda0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=liVwQdvHxg5rYqjBzBVWSquoBVMg9zwBAQpuv7L7mjdTcXFkgafgrpLmwLP/iXMYm
         kVvSXwbC3Way8/qxMYmiLD1KgqZo0Poy9uDn7QeMmaaAjkEKL30V+WghcBq1KQwwUP
         pQ7kD8AUPO/Eqjz6GyZPKHKkekxZw5rO8zVQPGY60DcAf1qxzQDg0PaPZTbSI05Da3
         2lET721x8Tdvmn70LtC9nice1HxT/pTiLVj0055Y+M4pxiXo1HYeWDJh856iOE3qvQ
         zLo7L7twJ3UH5K32Plfz57rp2uiJTyKwfH7gaKG6wOtRmKKxU5Kle6SiNj2P0hVggi
         /btRHmIq79a1Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EB31840513; Mon,  1 Feb 2021 14:03:19 -0300 (-03)
Date:   Mon, 1 Feb 2021 14:03:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Mark Wielaard <mark@klomp.org>
Cc:     dwarves@vger.kernel.org
Subject: Re: [PATCH] Handle DWARF5 DW_TAG_call_site like DW_TAG_GNU_call_site
Message-ID: <20210201170319.GG794568@kernel.org>
References: <20210131002731.60086-1-mark@klomp.org>
 <20210201123019.GF794568@kernel.org>
 <925336354cb6b4c17b8e6e515ec55e731ec91139.camel@klomp.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <925336354cb6b4c17b8e6e515ec55e731ec91139.camel@klomp.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Mon, Feb 01, 2021 at 01:32:51PM +0100, Mark Wielaard escreveu:
> On Mon, 2021-02-01 at 09:30 -0300, Arnaldo Carvalho de Melo wrote:
> > Em Sun, Jan 31, 2021 at 01:27:31AM +0100, Mark Wielaard escreveu:
> > > DW_TAG_call_site and DW_TAG_call_site_parameter are the standardized
> > > DWARF5 versions of DW_TAG_GNU_call_site and DW_TAG_GNU call_site_parameter.
> > > Handle them the same way (which is by ignoring them).
> > 
> > Thanks, I added these two lines, plese let me know if you're not ok with
> > it:
> > 
> > Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1922698
> > Signed-off-by: Mark Wielaard <mark@klomp.org>
> 
> That is of course fine.
> Sorry for not adding them myself.

Thanks!

- Arnaldo
