Return-Path: <dwarves-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0E4C6FD1F
	for <linux-dwarves@archiver.kernel.org>; Sun, 12 Mar 2023 00:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjCLAD6 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Sat, 11 Mar 2023 19:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjCLAD5 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Sat, 11 Mar 2023 19:03:57 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6404B813
        for <dwarves@vger.kernel.org>; Sat, 11 Mar 2023 16:03:55 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 250DBC01D; Sun, 12 Mar 2023 01:04:21 +0100 (CET)
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 30CE5C009;
        Sun, 12 Mar 2023 01:04:17 +0100 (CET)
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id b637b8ca;
        Sun, 12 Mar 2023 00:03:47 +0000 (UTC)
Date:   Sun, 12 Mar 2023 09:03:32 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        Yonghong Song <yhs@meta.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@fb.com>, dwarves@vger.kernel.org,
        Nick Clifton <nickc@redhat.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: Re: pahole 1.25 plans was: Re: Encountered error while encoding BTF
 due to Unsupported DW_TAG_unspecified_type(0x3b)
Message-ID: <ZA0W1NoajMGYCNke@codewreck.org>
References: <166780df-a8ca-6dfb-88e9-9e489efc6bf7@meta.com>
 <Y0QK1nmVjqr95od1@kernel.org>
 <Y0R7uu3s/imnvPzM@kernel.org>
 <Y0R+U8i8mDPkOAw7@kernel.org>
 <002daef3-ce5e-e6f1-ec12-fe5f64ae2632@meta.com>
 <Y0VzbkffTg2TJ5i3@kernel.org>
 <ee52054a-bd76-2817-33c4-ffae00e72fb9@meta.com>
 <Y0Wk5i0Zz2saSKK3@kernel.org>
 <68e2ee74-e0b7-35a8-33bb-b957df65327b@suse.cz>
 <Y9fSJG7oddQtgG5V@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y9fSJG7oddQtgG5V@kernel.org>
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Hi Arnaldo,

Arnaldo Carvalho de Melo wrote on Mon, Jan 30, 2023 at 11:20:20AM -0300:
> I hoped to finish the work on split dwarf (.dwz) before cutting a new
> version, but I'm postponing it to 1.26, so just cherry-picked some
> patches from the 'next' branch and I'm doing some more tests before
> cutting a new version.
> 
> But then there is also the series by Alan Maguire that needs to get into
> 1.25, so I'll try and check the current status of that thread and test
> it.

(I think the patches from Alan Maguire got in?)

nixos has had to upgrade pahole to a version from git for binutils 2.40,
and there are some incompatibilities with the linux 6.3-rc1 build at the
very least so a new tag would be well appreciated for cleaning this all
up.
What's the current plan?

Cheers,
-- 
Dominique Martinet | Asmadeus
