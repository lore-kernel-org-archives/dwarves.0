Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0633AC4338F
	for <linux-dwarves@archiver.kernel.org>; Fri, 13 Aug 2021 18:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6615610CF
	for <linux-dwarves@archiver.kernel.org>; Fri, 13 Aug 2021 18:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbhHMSee (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 13 Aug 2021 14:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbhHMSeJ (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Fri, 13 Aug 2021 14:34:09 -0400
X-Greylist: delayed 1094 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 13 Aug 2021 11:33:42 PDT
Received: from mx3.gerwinski.de (mx3.gerwinski.de [IPv6:2a01:4f8:192:4405::170:59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74418C061756
        for <dwarves@vger.kernel.org>; Fri, 13 Aug 2021 11:33:40 -0700 (PDT)
Received: from p548dfc6a.dip0.t-ipconnect.de ([84.141.252.106] helo=mars)
        by m31.gerwinski.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <f.heckenbach@fh-soft.de>)
        id 1mEbi8-0006Cy-Gi; Fri, 13 Aug 2021 20:15:21 +0200
Received: from frank by mars with local-rmail (Exim 4.92)
        (envelope-from <f.heckenbach@fh-soft.de>)
        id 1mEbi8-0006Av-1P; Fri, 13 Aug 2021 20:15:16 +0200
To:     bluca@debian.org, acme@kernel.org
Subject: Re: pahole: Problems with lib/include/bpf symlink in a tarball with
        --transform
Cc:     dwarves@vger.kernel.org
References:  <YRVv1iAX48euE5MO@kernel.org>
In-Reply-To: <YRVv1iAX48euE5MO@kernel.org>
From:   Frank Heckenbach <f.heckenbach@fh-soft.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <E1mEbi8-0006Av-1P@mars>
Date:   Fri, 13 Aug 2021 20:15:16 +0200
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Hi,

> The problem is described in this old Debian ticket:
> 
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=775247
> 
> I'm now trying to figure out what Frank meant when referring to that
> "S" flag.
> 
> I have to figure out what is this 'S' flag (local symlinks, etc) or stop
> using this --transform mechanism to have the dwarves-${version} top
> level directory added when generating the tarball :-\

FWIW, the "S" flag means:

  Do not apply transformation to symbolic link targets.

(see https://www.gnu.org/software/tar/manual/html_node/transform.html
-- it's a bit hard to find in the docs ...)

In my use case, this allows me to build a dist archive from my main
source directory, adding a directory level in the tar, while leaving
symlinks unchanged:

  --transform='s|^|$(DIST_NAME)/|S'

This is not a fully general solution to the problem as I described,
and it may or may not help for your use case.

Viele Grüße,
Frank
