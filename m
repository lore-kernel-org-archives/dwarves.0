Return-Path: <dwarves-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7342EB64D9
	for <linux-dwarves@archiver.kernel.org>; Thu, 15 Jun 2023 20:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjFOUfs (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 15 Jun 2023 16:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237874AbjFOUfk (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 15 Jun 2023 16:35:40 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E072D42;
        Thu, 15 Jun 2023 13:35:11 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 2C2F4C009; Thu, 15 Jun 2023 22:34:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1686861290; bh=WpIlT/MtwdTeRSa4KBTSMhTQOk6iylMdBwTAP9v18XQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PGSaYcv3hT/raOlkPrYtvT2M1Ux3RZje6fO94mMnPRM781DGWravc77iRwYt3Ae/w
         8jSSqcBgHVAML3vcGIUFW2SUZrYiq6SfxjEouXS+wu/nWt1DLswZa1Pe39aekFY2t5
         QpXmUYGJj8k4y3oNNecEDdDkLXAw+bGYpnlxyyZZ63ODOKVrXWAkS4jm02AtSx5hRF
         Hn+bGYKSE8X66q43XtGAiM8mZOpwRu678URznaibIN6eXPo6IetqnnW0MzW1yFxfeg
         BMvQY9INCgVu2NS8F6NwOy+nR61qEs9fqdddYmX02/0gPPgGEyNf2SfRrFK4iVH35G
         CadRMS5H9GHvg==
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id D8BC2C009;
        Thu, 15 Jun 2023 22:34:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1686861289; bh=WpIlT/MtwdTeRSa4KBTSMhTQOk6iylMdBwTAP9v18XQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SBKYwy62kIW86alsmahxyYI1PZyX65sxYHV1uo76gzwZpETcYu7Xr6vbhyJp6TIH0
         4KFoe5+A3BXczDbLCxLs5qYX2e0UyXKvYdW8bzrJtsPPQ0FgkzMHt80NzVKC0TyqVQ
         WxgEpLxfFYxwlUO3RGNLfzeOIZk3HLkw97cHMtiLL+49bL8biuP1qpitHIV6/kvuIj
         JOuIW4hDzDEJt8xI58rmB6WcBthOghuy8IB/NA8kpSFRcp1VIvtAuwD2HP0LvuEhYM
         a2LmbrqAlBi8bKSosXA8cU7zUKdIJpa84D28PSsgkkKoqw3mC02ea/hq8ZGWl4X3cj
         e+uOUKhmm+Uew==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 2051621f;
        Thu, 15 Jun 2023 20:34:44 +0000 (UTC)
Date:   Fri, 16 Jun 2023 05:34:29 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: ppc64le vmlinuz is huge when building with BTF
Message-ID: <ZIt11crcIjfyeygA@codewreck.org>
References: <ZIqGSJDaZObKjLnN@codewreck.org>
 <ZIrONqGJeATpbg3Y@krava>
 <ZIr7aaVpOaP8HjbZ@codewreck.org>
 <6b26dfef-016c-43df-07f5-c2f88157d1dc@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6b26dfef-016c-43df-07f5-c2f88157d1dc@oracle.com>
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org


Alan Maguire wrote on Thu, Jun 15, 2023 at 03:31:49PM +0100:
> However the problem I suspect is this:
> 
>  51 .debug_info   0a488b55  0000000000000000  0000000000000000  026f8d20
>  2**0
>                   CONTENTS, READONLY, DEBUGGING
> [...]
> 
> The debug info hasn't been stripped, so I suspect the packaging spec
> file or equivalent - in perhaps trying to preserve the .BTF section -
> is preserving debug info too. DWARF needs to be there at BTF
> generation time in vmlinux but is usually stripped for non-debug
> packages.

Thanks Alan and Eduard!
I guess I should have checked that first, it helps.

We're not stripping anything in vmlinuz for other archs -- the linker
script already should be including only the bare minimum to decompress
itself (+compressed useful bits), so I guess it's a Kbuild issue for the
arch.
We can add a strip but I unfortunately have no way of testing ppc build,
I'll ask around the build linux-kbuild and linuxppc-dev lists if that's
expected; it shouldn't be that bad now that's figured out.


> FYI we're aiming to make BTF module-loadable via CONFIG_DEBUG_INFO_BTF=m
> in the future, I'm hoping to get an RFC patch out for that soon once
> other BTF-related issues are sorted. Hope this helps

Oh, that's interesting -- I assume that'll only change the 'built-in'
BTF info? Or will that also split BTF info in other modules as
e.g. modfoo_btf.ko?
For x86_64 the size increase of vmlinuz itself is rather acceptable
(<2MB), but the sheer amount of modules (the -lts package has over 3k
modules...) means that even a small size increase for each module ends
up taking proportionally a high amount of space (+20MB from 90MB), so
being able to package separately would be appreciated (alpine likes
splitting optional features in subpackages)
Packaging-wise I'm not sure it'd make sense to keep the overhead in
other modules and just split the 'main' btf infos.

Otoh even if it doesn't help with packaging, having a smaller vmlinuz
means faster boot and lower kernel memory footprint (I think *2?) for
people who don't need it, so I think it's a good idea and we'll probably
enable it once it becomes available. Thanks for the heads up!

-- 
Dominique Martinet | Asmadeus
