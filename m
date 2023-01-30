Return-Path: <dwarves-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE194C54EAA
	for <linux-dwarves@archiver.kernel.org>; Mon, 30 Jan 2023 14:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236126AbjA3OWv (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 30 Jan 2023 09:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236764AbjA3OW3 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 30 Jan 2023 09:22:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFC23B667
        for <dwarves@vger.kernel.org>; Mon, 30 Jan 2023 06:21:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35DD2B80DEB
        for <dwarves@vger.kernel.org>; Mon, 30 Jan 2023 14:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52C8C433EF;
        Mon, 30 Jan 2023 14:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675088423;
        bh=bg1ANQmRScLUSQf6CTGmXISeyF0vPj5W6PA4C7Ts6FY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ahP4pfUWFt5ynMkDhdJL3/GyROhbFE4q5V+8i127QU/hNUNPWu8G37kphNkNzgagd
         D4uJSB7xLqAIhxkD7EPRfR6sKy2T5sSdnAH8P8YdPu3cs1Mf5INTTtK2BIyoOmfT8H
         qV8JBItNW3Nd8Uzi7k43w0/dxRtQDgagiARZicV8Ybutr1Ny0qsyPizUvE4wj0cA12
         ffq7pIkWsD8KVaij2lwLnGH8lSqWiIcKYNkU1As0EcnL65fhjLpp4tTCYNlZjwNwhU
         lS7Usv1wPhF/FXb9Aab1K03DeYjYJYQGUvyOhEPoan4zQyJlZQQnU3W1j/lCdZXbUr
         fargkFEvQc5Pw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8338E405BE; Mon, 30 Jan 2023 11:20:20 -0300 (-03)
Date:   Mon, 30 Jan 2023 11:20:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>
Cc:     Yonghong Song <yhs@meta.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@fb.com>, dwarves@vger.kernel.org,
        Nick Clifton <nickc@redhat.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: pahole 1.25 plans was: Re: Encountered error while encoding BTF due
 to Unsupported DW_TAG_unspecified_type(0x3b)
Message-ID: <Y9fSJG7oddQtgG5V@kernel.org>
References: <Y0CKQHhcTSWYqNpj@kernel.org>
 <166780df-a8ca-6dfb-88e9-9e489efc6bf7@meta.com>
 <Y0QK1nmVjqr95od1@kernel.org>
 <Y0R7uu3s/imnvPzM@kernel.org>
 <Y0R+U8i8mDPkOAw7@kernel.org>
 <002daef3-ce5e-e6f1-ec12-fe5f64ae2632@meta.com>
 <Y0VzbkffTg2TJ5i3@kernel.org>
 <ee52054a-bd76-2817-33c4-ffae00e72fb9@meta.com>
 <Y0Wk5i0Zz2saSKK3@kernel.org>
 <68e2ee74-e0b7-35a8-33bb-b957df65327b@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <68e2ee74-e0b7-35a8-33bb-b957df65327b@suse.cz>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Mon, Jan 30, 2023 at 10:23:02AM +0100, Martin Liška escreveu:
> Hi Arnaldo.
> 
> Now as the binutils 2.40 release is out, can you please consider doing a new
> dwarvers (pahole) release that will include the changes we discussed in this thread?

I hoped to finish the work on split dwarf (.dwz) before cutting a new
version, but I'm postponing it to 1.26, so just cherry-picked some
patches from the 'next' branch and I'm doing some more tests before
cutting a new version.

But then there is also the series by Alan Maguire that needs to get into
1.25, so I'll try and check the current status of that thread and test
it.

Yonghong, comments?

- Arnaldo
