Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C41C433C1
	for <linux-dwarves@archiver.kernel.org>; Tue, 30 Mar 2021 04:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 142CC61957
	for <linux-dwarves@archiver.kernel.org>; Tue, 30 Mar 2021 04:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbhC3Erc (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 30 Mar 2021 00:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhC3Er1 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 30 Mar 2021 00:47:27 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDD8C061762
        for <dwarves@vger.kernel.org>; Mon, 29 Mar 2021 21:47:27 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id E1F0EC020; Tue, 30 Mar 2021 06:47:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1617079644; bh=cT20gzssHINxETJ62iWKPnOgPC2shLK7kKjVvKW2u80=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lMJx4AKsw/fkqRhz2AoiX/kHUoobjkP/M7p1KJTyqNtuVEzdZNw4MQ7yay3d0w25z
         +3v61oMLC9zt3sUcfbJMcjiJwOBtzBll4LyNDXDVf4fSOvObBIRpkMbs422s7Tv83G
         pkpn9af2dPi1DLC3jUtyBS4Dn8InCz5S8hTfYkRutDWtumw19t1eApXU9SBzHnA+IC
         rlsin3IoA+h75X0tse+lvsHkc7UjUTPBVVar2yb8GKGipPvF9Sbs09JV5zYQ8juyAt
         lfVprJTyJmFIOoqJ9LeAZZrqjf6cGEOppkp966L4AsGy33N6qlhBSMmyQq1wfmkPAO
         5GF63nnGcjw2A==
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 5C267C01C;
        Tue, 30 Mar 2021 06:47:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1617079644; bh=cT20gzssHINxETJ62iWKPnOgPC2shLK7kKjVvKW2u80=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lMJx4AKsw/fkqRhz2AoiX/kHUoobjkP/M7p1KJTyqNtuVEzdZNw4MQ7yay3d0w25z
         +3v61oMLC9zt3sUcfbJMcjiJwOBtzBll4LyNDXDVf4fSOvObBIRpkMbs422s7Tv83G
         pkpn9af2dPi1DLC3jUtyBS4Dn8InCz5S8hTfYkRutDWtumw19t1eApXU9SBzHnA+IC
         rlsin3IoA+h75X0tse+lvsHkc7UjUTPBVVar2yb8GKGipPvF9Sbs09JV5zYQ8juyAt
         lfVprJTyJmFIOoqJ9LeAZZrqjf6cGEOppkp966L4AsGy33N6qlhBSMmyQq1wfmkPAO
         5GF63nnGcjw2A==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 29110514;
        Tue, 30 Mar 2021 04:47:20 +0000 (UTC)
Date:   Tue, 30 Mar 2021 13:47:05 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     dwarves@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Luca Boccassi <bluca@debian.org>
Subject: Re: [PATCH dwarves v3] libbpf: allow to use packaged version
Message-ID: <YGKtSXsLg4HV7eHL@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210104221622.256663-1-bluca@debian.org>
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Hi,

I see this commit has been reverted just before the 1.20 release in Feb:
---
Revert "libbpf: allow to use packaged version"

This reverts commit 82749180b23d3c9c060108bc290ae26507fc324e.

Getting in the way of releasing 1.20, breaking the build of a dwarves
rpm when a libbpf package is installed in a fedora 33 system:

In file included from /home/acme/rpmbuild/BUILD/dwarves-1.20/strings.c:7:
/home/acme/rpmbuild/BUILD/dwarves-1.20/pahole_strings.h:9:10: fatal error: bpf/btf.h: No such file or directory
    9 | #include <bpf/btf.h>
      |          ^~~~~~~~~~~

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---

I can understand reverting due to other pressure to get a release out
but most distros (including fedora) frown upon vendoring code so I think
it would be good to have back ultimately.

Did you or someone else (Luca?) ever take the time to look at it?

I don't see what would be so different with fedora to make this
unfixable, I'd be happy taking a look if nobody has so far.
Would you take the patch back in if I somehow fix rpmbuild with a libbpf
package installed on fedora33?


Thanks,
-- 
Dominique
