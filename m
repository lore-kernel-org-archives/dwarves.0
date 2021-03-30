Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326E8C433DB
	for <linux-dwarves@archiver.kernel.org>; Tue, 30 Mar 2021 11:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0370561982
	for <linux-dwarves@archiver.kernel.org>; Tue, 30 Mar 2021 11:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbhC3Lwq (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 30 Mar 2021 07:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbhC3Lwd (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 30 Mar 2021 07:52:33 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D95FC061574
        for <dwarves@vger.kernel.org>; Tue, 30 Mar 2021 04:52:32 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 05134C01D; Tue, 30 Mar 2021 13:52:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1617105151; bh=/toK2SJPFBkonP77UYYlqlLGLJM6lLwo2/Bc+OyHfTA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A1ZLrTaFNfSq1fDfX0r0u5V6tW1OSOgxy6uM5RxV0g1iToWXlQcVI4NfA/6W2NdMx
         JGw6jxZ7nf5kWnCiBIAaAYXH9I9Pb1i3RJO4e+yusPIGpF3ztJvGe12eqko8LItKH7
         WKY9bxlM8i3r9aR27kxanBn5vsT65H6x7ruJeOStcvrbAvBSjyjzwi6OoIJ+RgsSWn
         XzVDavCdWPschCwLAj1BRmBd0D8MelXuF57m/P1KuP0Ayo13dg6He6qnK0bJAW9QL7
         foFerMRNwjKUEocGGq2/g+VHlIPZhBOrPCsR9fZazcfNuD1q7ej6ibxEkhhqJaWmWo
         tEbEAkyrEBoYA==
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 498E4C01A;
        Tue, 30 Mar 2021 13:52:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1617105150; bh=/toK2SJPFBkonP77UYYlqlLGLJM6lLwo2/Bc+OyHfTA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JXHGP+HmjQzVtMN++G1O7tSL7n0Mrr9EtUotNruobImL2ErRgNmqAURqIaeQ220Ow
         jAECKXMR3FaEHBU10ADq1aTH7Kge5N7oH1y0Ew6SlDsSUbqoikGd0H8YMyun0Yjm0K
         yInsY/PU5dnFeI8UcTz1UsKPipCpFpe1e7pMMHN5mB6wU4Rd+JXpyAmzN0W0dmqyHQ
         NcKjp6Nx4HDR/4Uj9DGim5yGN4pPPXX1rsJmhviFDfGX5RjXLszjejVrN7EwikiD60
         OvOq0cg7Tw8/KH8ECzjQj0D6hIZHw0pZMf+kP6G1qL5OZQxILZmUFIQ5d5iLtHUu4C
         EMWNEfr4+EGKA==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id fe1a8950;
        Tue, 30 Mar 2021 11:45:46 +0000 (UTC)
Date:   Tue, 30 Mar 2021 20:45:31 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Luca Boccassi <bluca@debian.org>
Cc:     dwarves@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH dwarves v3] libbpf: allow to use packaged version
Message-ID: <YGMPW1JQZcb2vr/W@codewreck.org>
References: <YGKtSXsLg4HV7eHL@codewreck.org>
 <8cefd2c1cf59c1618365a738677afcb2ab6acd01.camel@debian.org>
 <1ba2e8cdb496248b02fa31ddcccb06c1e4ca3cca.camel@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1ba2e8cdb496248b02fa31ddcccb06c1e4ca3cca.camel@debian.org>
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Luca Boccassi wrote on Tue, Mar 30, 2021 at 12:06:09PM +0100:
> > I did not realise it was reverted (if I was pinged and I missed it:
> > sorry about that) - what was the issue precisely? This has been used on
> > Ubuntu and Debian for a few months now, no problems reported.
> > Happy to have a look too if needed.

(FWIW I also have used that patch for alpine linux, and got rebuked for
expliciting there is a vendored lib when pushing a nixos update so will
probably need it there as well)

> As far as I can see, on Fedora 33 the only CMake option used is '-
> DCMAKE_BUILD_TYPE=Release':
> 
> https://src.fedoraproject.org/rpms/dwarves/blob/f33/f/dwarves.spec
> 
> On my Debian system, with libbpf-dev installed and after re-instating
> the patch on an up-to-date master branch of pahole.git, this builds
> just fine:

I just got home where I have a fedora 33 machine and can confirm it
works for me on f33 as well.

I tried:
 - normal rpmbuild with libbpf + libbpf-devel / libbpf-static installed
 - just libbpf installed
 in both these cases it rebuilds the local libbpf (if the git tree is
 in the tarball it does the submodule checkout, if it's not it
 complains if libbpf wasn't previously checked out but uses it
 properly if it's there)
 
 - just to make sure I've done an extra build from the tarball obtained
with `fedpkg sources` and applying just the reverted patch manually;
this also worked as expected.

- I figured it might be a problem on another arch but I don't see
any failure on koji[1], so can't really test that easily.
[1] https://koji.fedoraproject.org/koji/packageinfo?packageID=5540

 - For completeness I also tried building with fedora's libbpf-devel and
`-DLIBBPF_EMBEDDED=OFF` without any problem (it will obviously need a
libbpf update for the float types, but as of 1.20 it works fine with
libbpf 0.3)
----------
diff --git a/rpm/SPECS/dwarves.spec b/rpm/SPECS/dwarves.spec
index 98433e395b6c..f28bca0fa088 100644
--- a/rpm/SPECS/dwarves.spec
+++ b/rpm/SPECS/dwarves.spec
@@ -13,6 +13,7 @@ BuildRequires: gcc
 BuildRequires: cmake >= 2.8.12
 BuildRequires: zlib-devel
 BuildRequires: elfutils-devel >= 0.130
+BuildRequires: libbpf-devel
 
 %description
 dwarves is a set of tools that use the debugging information inserted in
@@ -67,7 +68,7 @@ Debugging information processing library development files.
 %setup -q
 
 %build
-%cmake -DCMAKE_BUILD_TYPE=Release .
+%cmake -DCMAKE_BUILD_TYPE=Release -DLIBBPF_EMBEDDED=OFF .
 %cmake_build
 
 %install
----------

Would appreciate more details if there's anything we can do; my guess is
that there might have been leftovers from a previous cmake run maybe
(potentially with previous versions of the patch) and just trying to
reproduce from a fresh build doesn't get us anywhere... cmake can be
annoying with its cache sometimes.


Thanks,
-- 
Dominique
