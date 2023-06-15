Return-Path: <dwarves-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453B0EB64DB
	for <linux-dwarves@archiver.kernel.org>; Thu, 15 Jun 2023 03:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237771AbjFODcu (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 14 Jun 2023 23:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237527AbjFODct (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 14 Jun 2023 23:32:49 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941FC2120;
        Wed, 14 Jun 2023 20:32:47 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 11AECC01C; Thu, 15 Jun 2023 05:32:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1686799964; bh=N6MSuSr/Z+c4Myf1l9nZ+6OfeRcjQCkkQvJttGYCi4E=;
        h=Date:From:To:Subject:From;
        b=YKQsdXKtCTJNHQlS9+KNz5hULLjP8qoiZdIUnHpNRFBbZwo4ZYT+3AnXtWsU/f0E3
         stAGvPoy3KzlcoJvboa508zbCUGWikUiFUwj2Tye4ig1+0kS9y3f6D8lR+4wAUgun8
         SuUe30yRo9z/Fx6StgQW0+4nOLiNW241P7QCJJ0WGNDn+jqqw1YG+4ssh2KLmJWuYE
         vKrFjm2xbG9uEdn5+Ley9EwHozaSsI8Pz05g6ro/X3mEAA9pEBaS7eswzDGxZxxF/L
         spbUCvt/bEXzhQEcP/XWzoBI2XEVH7U/x3vS3lJa1NV7lU1viFYya4ANLSZ688wX17
         Zyy13/X/ozFjg==
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 99E67C01A;
        Thu, 15 Jun 2023 05:32:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1686799963; bh=N6MSuSr/Z+c4Myf1l9nZ+6OfeRcjQCkkQvJttGYCi4E=;
        h=Date:From:To:Subject:From;
        b=iy2h8xlQwaXiLXlHpjCSXGm0taP5J2xluPSy6vZHw9OgQDpyG/VlMVwvLln2oR62P
         m0b4Bl7XbtdEyfttTrDnqGa/MytVUYOFPyed0DXZGrA+KoVz5sBLozG9xd1X1nW0+m
         FqZiEBlODuQ/9AxrlHEAyADU1bZbvJpMAQayMQA1d4jVOxKxXq6IbyorTWlI1O8rsd
         +pnoEVnG8+ud4oHzz1c2SEQgvicq1EczQpgkun2KRM+MWI51IpbJtIL2nCA+pjSj2v
         mjaVWl/yaCTvEzzixrYQGI+mdee06Epc6wsvOr4aERblVOIV1k2kZKhKmOiYLe2Ozg
         hG5IOxcbanJpA==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 9d2c3fca;
        Thu, 15 Jun 2023 03:32:39 +0000 (UTC)
Date:   Thu, 15 Jun 2023 12:32:24 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf@vger.kernel.org
Subject: ppc64le vmlinuz is huge when building with BTF
Message-ID: <ZIqGSJDaZObKjLnN@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Hi,

coming from alpine: https://gitlab.alpinelinux.org/alpine/aports/-/issues/12563

alice noticed the kernel packages got quite bigger, in particular for
ppc64le I've confirmed that the vmlinuz file size jump when building
with BTF:
currently released package with BTF:
https://dl-cdn.alpinelinux.org/alpine/edge/main/ppc64le/linux-lts-6.1.33-r0.apk
272M	boot/vmlinuz-lts

test build without BTF:
https://gitlab.alpinelinux.org/martinetd/aports/-/jobs/1049335
44M	boot/vmlinuz-lts


Is that a known issue?
We'll probably just turn off BTF for the ppc64le build for now, but it
might be worth checking.


While I have your attention, even the x86_64 package grew much bigger
than I thought it would, the installed modules directory go from 90MB to
108MB gzipped); it's a 18% increase (including kernel: 103->122MB) which
is more than what I'd expect out of BTF.
Most users don't care about BTF so it'd be great if they could be built
and installed separately (debug package all over again..) or limiting
the growth a bit more if possible.
I haven't tried yet but at this point ikheaders is probably worth
considering instead..
Perhaps we're missing some stripping option or something?


Thanks!
-- 
Dominique Martinet | Asmadeus
