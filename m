Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B17FC433EF
	for <linux-dwarves@archiver.kernel.org>; Sun, 10 Jul 2022 13:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiGJNoD (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Sun, 10 Jul 2022 09:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGJNoD (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Sun, 10 Jul 2022 09:44:03 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1619D62D0
        for <dwarves@vger.kernel.org>; Sun, 10 Jul 2022 06:44:02 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id CBEB6C01B; Sun, 10 Jul 2022 15:44:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1657460640; bh=OASAahjnDhA/tWXiM2GUIH+FN6szgKvtfnAIS827eaU=;
        h=Date:From:To:Subject:From;
        b=n02Y+nQpH5+V7g3QuEEUuvHcpyoi0iD1SCehaXbu35SaaOuKQwCE+hT2lJkmf3i1j
         p4KiwXqFWiU8Z17T/9BmMgdwTgYTfgkrmkbYzRWaNiiofPCoN4JzlSh9/TubHqhzoH
         rKrJQPF2HmLNcxpQhvlrdaDFPNhQW3PeVgvxaFQui6SwoVfV67fzBzA1Fj5HvD183W
         8k0IxqsOxiL3/x/kxakw3GJnrDsueJ7eaqmVwe4/UJFBQ4wgoyYA8ZBD3jLsRbxllG
         MAcUQjgTgogCa1+gX+VQNC1F8RPge+q4u00/4lcKk8GJTVm5P9sI97/0dD+mm1Ic1S
         lOhu9SSq41tew==
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id B2922C009;
        Sun, 10 Jul 2022 15:43:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1657460640; bh=OASAahjnDhA/tWXiM2GUIH+FN6szgKvtfnAIS827eaU=;
        h=Date:From:To:Subject:From;
        b=n02Y+nQpH5+V7g3QuEEUuvHcpyoi0iD1SCehaXbu35SaaOuKQwCE+hT2lJkmf3i1j
         p4KiwXqFWiU8Z17T/9BmMgdwTgYTfgkrmkbYzRWaNiiofPCoN4JzlSh9/TubHqhzoH
         rKrJQPF2HmLNcxpQhvlrdaDFPNhQW3PeVgvxaFQui6SwoVfV67fzBzA1Fj5HvD183W
         8k0IxqsOxiL3/x/kxakw3GJnrDsueJ7eaqmVwe4/UJFBQ4wgoyYA8ZBD3jLsRbxllG
         MAcUQjgTgogCa1+gX+VQNC1F8RPge+q4u00/4lcKk8GJTVm5P9sI97/0dD+mm1Ic1S
         lOhu9SSq41tew==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 4f5f4bec;
        Sun, 10 Jul 2022 13:43:57 +0000 (UTC)
Date:   Sun, 10 Jul 2022 22:43:42 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     dwarves@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: pahole split BTF support broken on 32bit builds?
Message-ID: <YsrXjggSxfe2U7Oz@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Hi Arnaldo,

I noticed nixos had to disable BTF for 5.15+ builds -- split BTF for
modules got in 5.11 and that's the first kernel after this so it matches
up.

I could reproduce by just building any kernel with ARCH=i386 and using a
32bit pahole

$ LD_LIBRARY_PATH=/tmp/pahole/build /tmp/pahole/build/pahole -J --btf_base vmlinux arch/x86/crypto/aesni-intel.ko
Failed to parse base BTF 'vmlinux': -22

$  file /tmp/pahole/build/pahole 
/tmp/pahole/build/pahole: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), dynamically linked, interpreter /nix/store/pp1yzf2flqnjm02jnjcgxhx015bhmi9j-glibc-2.34-210/lib/ld-linux.so.2, for GNU/Linux 2.6.32, with debug_info, not stripped


(64bit pahole works with the same input, and interestingly the 32bit
pahole works with a 64bit kernel/modules -- I can reproduce on either
5.15 or current master as long as it's built with ARCH=i686 though)


If cross-compiling pahole to i686 is a pain the issue apparently is
reproductible with native armhf builds as well according to comments on
the nixos PR:
https://github.com/NixOS/nixpkgs/pull/178256

I'm not attaching a config, a minimal .config with just BTF and module
BTF was enough for me (allnoconfig adjusted to get these)


Please let me know if you need any more information,
--
Dominique
