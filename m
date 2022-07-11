Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DC6C433EF
	for <linux-dwarves@archiver.kernel.org>; Mon, 11 Jul 2022 01:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiGKB2p (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Sun, 10 Jul 2022 21:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiGKB2l (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Sun, 10 Jul 2022 21:28:41 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0C46300
        for <dwarves@vger.kernel.org>; Sun, 10 Jul 2022 18:28:38 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 12CE1C009; Mon, 11 Jul 2022 03:28:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1657502916; bh=HP7nKKlqoiBKXuPznu2Y5Fb39qptoLhakG6ggdpKWgg=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=gTvKkO2OiqWiKd9b5dez3FcGzQo/GkCjpzIcgRf2sPiHcVx9ut02QFwP8/pQv++ps
         dnnmvQe5RaMt6KG5R/1xr9dL6eVYLPfF+AmJ5HFy1cNNgVhJzpyqgqh0R9628Drr3l
         WFLBxTW6c98DubTmC6IM48BeGIUKGeFCptzn91NRCFKBtfBRayNIptZLaxWvPB9MWz
         wd2wOguU0yWdehn11yMvV8DEwejwR9UJ8CL7wliaXZuSS41UHWdSkMQJWQYgnHPo15
         b5Pviz9QJMs4f7/iRvQt8say+hjxPLXSdYkEpn/AsxemQj3KwpsBTTfuS70UoMeY8M
         /ddyQi/iwGP1g==
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id D4A61C009;
        Mon, 11 Jul 2022 03:28:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1657502915; bh=HP7nKKlqoiBKXuPznu2Y5Fb39qptoLhakG6ggdpKWgg=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=Ljlh+ozv1AvL+6REXEBN+rKpZ8ZjQ/DOmGcafE6AoqVnVsTmXj+e9EgCenMScjJZ8
         1XrrcJVBVgcw3iLsZrsjKlNv78Eg9il++FC57HcPHSqI6N8/pUEfqRdvBSwEIOQbD6
         gqPXqvlsoKnlwhJ7mTrHmNwPuf664uAGubGqwPaaftCDTNHdmIQlfPlvPORJaa3vqH
         0vvYCbpMWwK8eaTDOuX2TiKXZ6Xy5tOIlNne7ZWljAj2IFOMpQwMTKEVR/I8Us/Rq5
         kXuv6UZGvInc4nNSvsmtZj0h82v5o+DFhC3nNU3ldw4tnH8rICpKbLouhzlUxagbhX
         jzElW7rwcTD7Q==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id fe896943;
        Mon, 11 Jul 2022 01:28:31 +0000 (UTC)
Date:   Mon, 11 Jul 2022 10:28:16 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     dwarves@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: pahole split BTF support broken on 32bit builds?
Message-ID: <Yst8sOnzw+YZRRkE@codewreck.org>
References: <YsrXjggSxfe2U7Oz@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YsrXjggSxfe2U7Oz@codewreck.org>
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Dominique Martinet wrote on Sun, Jul 10, 2022 at 10:43:42PM +0900:
> I could reproduce by just building any kernel with ARCH=i386 and using a
> 32bit pahole
> 
> $ LD_LIBRARY_PATH=/tmp/pahole/build /tmp/pahole/build/pahole -J --btf_base vmlinux arch/x86/crypto/aesni-intel.ko
> Failed to parse base BTF 'vmlinux': -22
> 
> $  file /tmp/pahole/build/pahole 
> /tmp/pahole/build/pahole: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), dynamically linked, interpreter /nix/store/pp1yzf2flqnjm02jnjcgxhx015bhmi9j-glibc-2.34-210/lib/ld-linux.so.2, for GNU/Linux 2.6.32, with debug_info, not stripped

Some more infos: this actually just got fixed by mistake when I changed
libbpf build to use elfutils instead of the old libelf

That was a side-product of the 0.8.0 upgrade which took a bit of time to
get merged, as that wouldn't build anymore with old libelf (can't
remember what, something missing)...

So, well, I guess it's probably not worth looking too far as that's
unlikely to be a problem again, and I'm not sure if libelf is still
maintained.


Sorry for the noise.
--
Dominique
