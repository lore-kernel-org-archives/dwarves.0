Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79436C433C1
	for <linux-dwarves@archiver.kernel.org>; Wed, 31 Mar 2021 01:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C3026190A
	for <linux-dwarves@archiver.kernel.org>; Wed, 31 Mar 2021 01:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhCaBGg (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 30 Mar 2021 21:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbhCaBGD (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 30 Mar 2021 21:06:03 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696BEC061574
        for <dwarves@vger.kernel.org>; Tue, 30 Mar 2021 18:06:03 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 0AB41C01E; Wed, 31 Mar 2021 03:06:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1617152762; bh=yhP4fVZMvM63BstBnOJwnX6rNHSN2axo+Zj9mcXGSWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=3k1oQjO8ed27QZyVxxCPLncVH34tw0CxiWuID/U4uKRD/aod16D/eXMIU/e88EbZh
         zi8Y0LAb/fPA2AsNhW3rHVFAPWYFKngVwnEEE9Hl4oi18gMpAnw4Msm6HO5Z7p6UXg
         y9vKJpn56oVfAknRVqo7/vBnzJNiPIj+cpSBGpFSW2zPOKV7vN0IwvabG/lCG6whKh
         bRjPS4LKvwAmyEFDmTfysRaCL4C6BTvV/5qmwCKtzyPlZHpvSdoEFq5BrHTtLySkMT
         TatM3uppBlDI2O68zOuRsHHHwK/borTLpdscTcO4ShSsGds8yxS/D3fIG45UfthtIN
         yeqMO3qLQ79dw==
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id ED3E5C01A;
        Wed, 31 Mar 2021 03:05:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1617152761; bh=yhP4fVZMvM63BstBnOJwnX6rNHSN2axo+Zj9mcXGSWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zboX/EIv1H2mWCLg7MLn6S2VB9gXqU5QeTkC73AyeYVJdFUFopY8ujaLgm5Lfts38
         wv4mywNA/hx6l9B2DAyL80JZtBVExkQ1mM9eoeqCDYyxMIp/l0LVRu6cnhQMvcmQJY
         qFOLfftLasy32tyHRXfFipnhQZcxJLtRGWIH1YB/9f8c86Lu0hQTPtKvhDTTf+66hw
         0mbEmU8vFB/JMl+JEIl04aY+NvE6fF0l8KS52gOjDpBGqXXN889/5u10NUeeSNiEAC
         dOhVxnonbZWGQlTGNuq4AY0qQJwAyzDZXw4cwm/DTJoPdTnQGBLSG+v13RNp9MHJf/
         lwJGttzSE/kaw==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 25f2d58a;
        Wed, 31 Mar 2021 01:05:56 +0000 (UTC)
Date:   Wed, 31 Mar 2021 10:05:41 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Luca Boccassi <bluca@debian.org>
Subject: Re: [PATCH dwarves v3] libbpf: allow to use packaged version
Message-ID: <YGPK5WxS51eVKguU@codewreck.org>
References: <20210104221622.256663-1-bluca@debian.org>
 <YGKtSXsLg4HV7eHL@codewreck.org>
 <YGM/x6Ohchorg2cf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YGM/x6Ohchorg2cf@kernel.org>
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Arnaldo Carvalho de Melo wrote on Tue, Mar 30, 2021 at 12:12:07PM -0300:
> > I can understand reverting due to other pressure to get a release out
> > but most distros (including fedora) frown upon vendoring code so I think
> > it would be good to have back ultimately.
> > 
> > Did you or someone else (Luca?) ever take the time to look at it?
> 
> Not yet, I'm right now working on it, testing patches to support clang's
> thin-LTO being used to build the kernel, so busy with it.

Thanks


> > I don't see what would be so different with fedora to make this
> > unfixable, I'd be happy taking a look if nobody has so far.
> 
> Please do.

As said in my previous mail (in reply to Luca's), I cannot reproduce on
fedora 33 so I'm not sure where to look at.
Was the problem specific to one architecture (I only tried x86_64), or
maybe the build dir was tainted by a previous run of cmake with another
version of the patch? (if rpmbuild, build dir somehow included in the
tarball?)

Looking at the timing the libbpf version should have been identical but
it's possible that system wasn't up to date or some other version change
since Feb?

Either way I would appreciate if you could confirm you still have the
problem when you have a moment, and if so provide a bit more details on
your setup.


> > Would you take the patch back in if I somehow fix rpmbuild with a libbpf
> > package installed on fedora33?
> 
> Sure. I had it merged, as, IIRC, it was a opt-in procedure.

Yes, strictly opt-in and shouldn't affect developers or people building
from git without explicitly requiring to use the system's version.

-- 
Dominique
