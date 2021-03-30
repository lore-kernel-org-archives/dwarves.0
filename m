Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71BBC4332E
	for <linux-dwarves@archiver.kernel.org>; Tue, 30 Mar 2021 15:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8426619CD
	for <linux-dwarves@archiver.kernel.org>; Tue, 30 Mar 2021 15:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbhC3PMl (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 30 Mar 2021 11:12:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:59990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232319AbhC3PMJ (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Tue, 30 Mar 2021 11:12:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6649561987;
        Tue, 30 Mar 2021 15:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617117129;
        bh=4FI+E7KlMGOVnPpx3TqgURRFDhWM9HcKCAaLBYmPmWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fVCGCAnjcnNyrADdm/ZoI5VTLA2g3/ANYy4vomHO7Gt/xEIk9xDVN6r67S5xHcedQ
         MXJ9GAyjj8JJow5fGkHydqoRP7+2mjYGphtihJ9v4+Ypb3r7YA1VskbXvWEB1wvhQ7
         IChHdoZ22/VoqYsLPJ4nA52mKZ4z7L3eSYH/EXSMT3zXBkvnxOrPBg/h1F2Iog2PvB
         OBc5zHd+ok8ICgXs+u0rlKyz+08+PzTjHpm5xT94Lh8II5gRjy2uZSdXrBmT42bNBN
         anVuKZW+/enAxFPCVUWq87ljXqsk4Zp5JFiuetQC/fdbdRSnDjVmH3DNhosw9wWjZz
         eHKuOTfeTD0hg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 74FFF40647; Tue, 30 Mar 2021 12:12:07 -0300 (-03)
Date:   Tue, 30 Mar 2021 12:12:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Luca Boccassi <bluca@debian.org>
Subject: Re: [PATCH dwarves v3] libbpf: allow to use packaged version
Message-ID: <YGM/x6Ohchorg2cf@kernel.org>
References: <20210104221622.256663-1-bluca@debian.org>
 <YGKtSXsLg4HV7eHL@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGKtSXsLg4HV7eHL@codewreck.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Tue, Mar 30, 2021 at 01:47:05PM +0900, Dominique Martinet escreveu:
> Hi,
> 
> I see this commit has been reverted just before the 1.20 release in Feb:
> ---
> Revert "libbpf: allow to use packaged version"
> 
> This reverts commit 82749180b23d3c9c060108bc290ae26507fc324e.
> 
> Getting in the way of releasing 1.20, breaking the build of a dwarves
> rpm when a libbpf package is installed in a fedora 33 system:
> 
> In file included from /home/acme/rpmbuild/BUILD/dwarves-1.20/strings.c:7:
> /home/acme/rpmbuild/BUILD/dwarves-1.20/pahole_strings.h:9:10: fatal error: bpf/btf.h: No such file or directory
>     9 | #include <bpf/btf.h>
>       |          ^~~~~~~~~~~
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
> 
> I can understand reverting due to other pressure to get a release out
> but most distros (including fedora) frown upon vendoring code so I think
> it would be good to have back ultimately.
> 
> Did you or someone else (Luca?) ever take the time to look at it?

Not yet, I'm right now working on it, testing patches to support clang's
thin-LTO being used to build the kernel, so busy with it.
 
> I don't see what would be so different with fedora to make this
> unfixable, I'd be happy taking a look if nobody has so far.

Please do.

> Would you take the patch back in if I somehow fix rpmbuild with a libbpf
> package installed on fedora33?

Sure. I had it merged, as, IIRC, it was a opt-in procedure.

- Arnaldo

