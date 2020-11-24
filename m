Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2209C2D0E4
	for <linux-dwarves@archiver.kernel.org>; Tue, 24 Nov 2020 18:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58287206D5
	for <linux-dwarves@archiver.kernel.org>; Tue, 24 Nov 2020 18:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBF3ao/2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390837AbgKXSSx (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 24 Nov 2020 13:18:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:44728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390831AbgKXSSv (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Tue, 24 Nov 2020 13:18:51 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1140206D5;
        Tue, 24 Nov 2020 18:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606241931;
        bh=J7SebksXKVL3/sXfdek06ILhR4W8a66EgCJg3Ex+gmo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WBF3ao/2G3J3cBVdIQop6cdNTh/j0O+KDDh4ANQtwsWgxkbla7Gp40glfYlJR5eH/
         U6v2UZIOfkrA07ZwY9f8d1uv/m3aXlZOI73qslba8q+GHWBHFyj8WvYLAi7BSDff3w
         bF8P2qPBVYr0cxLxQDHL8eiu/M/9ejn6zI/98nuo=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D94EA40E29; Tue, 24 Nov 2020 15:18:48 -0300 (-03)
Date:   Tue, 24 Nov 2020 15:18:48 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     dwarves@vger.kernel.org
Subject: Re: pahole v1.19
Message-ID: <20201124181848.GA30074@kernel.org>
References: <20201124130202.GA5391@kernel.org>
 <p3npn8qr-51rq-r8oq-80os-q2qnq9593r84@vanv.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p3npn8qr-51rq-r8oq-80os-q2qnq9593r84@vanv.qr>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Tue, Nov 24, 2020 at 02:25:39PM +0100, Jan Engelhardt escreveu:
> On Tuesday 2020-11-24 14:02, Arnaldo Carvalho de Melo wrote:
 
> >	The v1.19 release of pahole and its friends is out, available at
> >the usual places:

> >Main git repo:

> >   git://git.kernel.org/pub/scm/devel/pahole/pahole.git
 
> Nitpick: the 1.19 tag is absent.

Thanks, just sent it.

- Arnaldo
