Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5024C47095
	for <linux-dwarves@archiver.kernel.org>; Wed,  9 Jun 2021 04:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B245D60240
	for <linux-dwarves@archiver.kernel.org>; Wed,  9 Jun 2021 04:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbhFIEMS (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 9 Jun 2021 00:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhFIEMS (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 9 Jun 2021 00:12:18 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B53AC061574
        for <dwarves@vger.kernel.org>; Tue,  8 Jun 2021 21:10:24 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 32A0EC01E; Wed,  9 Jun 2021 06:10:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1623211822; bh=lfgk+zx17cbxRrKTuWbKSU//4jZ5idn35zLvcnKr7x4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=itXMpco0FFWndgwHyOE8cCmD16EReko+Ooft+QtfqCIA5yfCGAVZKqaAxMushxeeq
         7vtt9M6q5sTK/qSgqQL34JHCVZKUo2zqp5UVtwDaH8+B3kK/jGvIjvh/BySZ9DnLwr
         ngMrfr0wOMf5r/hVeYQrVHj2yC/eF/1iuS9yZHYeG+qG5alxvGYgVEIiZPeUP543JV
         aq9myC4V4sSpADMF6j0nYAAORpOaqnwsw/kJxqjk6dfC5A7t5LLcRkijUhCFOiDAR0
         S72PjW6ZHL+M0LQb0L+cMrg4ZqlMcdachyCiasU6XSZMZmJbAwU9f55JqlPmNDXkBr
         72zQOBI6KUcXg==
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 4E35DC01A;
        Wed,  9 Jun 2021 06:10:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1623211821; bh=lfgk+zx17cbxRrKTuWbKSU//4jZ5idn35zLvcnKr7x4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ukr/0gxBymGrlZ/wB/Zdc3gMAZM8ppwdph9hYI+I60JaSf2UU6HuPIU8e6Mf7bokc
         gpWDxIFpbDOqPzwutduv4K+VimN5jwA+agaXOr4VQNaG09SXdGkLZJxiWJiZj92d5S
         aID7BIoDygT6JNxDBYJuRIEtX0cd69a9iJx7eNC8NXuiD0lSQO+YK5PQIE1aeyrdhg
         AozNm3E4kz4As1SI9caaBk07/Daotnro3C1V+84Vuhq1l3s0TDat0alkHEwk8j6E3g
         PdHHdx56icNhBcxLaH5EVgZ9rm7Hm8qXgOoEyFjEzydXVR/WLdmNamh4JOaRNrUpt6
         Y4yL776KV9f3A==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 98789ca2;
        Wed, 9 Jun 2021 04:10:17 +0000 (UTC)
Date:   Wed, 9 Jun 2021 13:10:01 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Luca Boccassi <bluca@debian.org>, dwarves@vger.kernel.org
Subject: Re: [PATCH dwarves v3] libbpf: allow to use packaged version
Message-ID: <YMA/GSmX0ZDoGEZg@codewreck.org>
References: <20210104221622.256663-1-bluca@debian.org>
 <YGKtSXsLg4HV7eHL@codewreck.org>
 <YGM/x6Ohchorg2cf@kernel.org>
 <YGPK5WxS51eVKguU@codewreck.org>
 <ca59c536e2dc66f6cb02f57d40b65702f7414ea9.camel@debian.org>
 <056f75e00fe796e3a9d634ec03afdf0a416fd9a0.camel@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <056f75e00fe796e3a9d634ec03afdf0a416fd9a0.camel@debian.org>
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Hello Arnaldo,

Luca Boccassi wrote on Tue, May 18, 2021 at 03:07:50PM +0100:
> On Tue, 2021-04-13 at 14:42 +0100, Luca Boccassi wrote:
>>>>> Would you take the patch back in if I somehow fix rpmbuild with a libbpf
>>>>> package installed on fedora33?
>>>> 
>>>> Sure. I had it merged, as, IIRC, it was a opt-in procedure.
>>> 
>>> Yes, strictly opt-in and shouldn't affect developers or people building
>>> from git without explicitly requiring to use the system's version.
>> 
>> Any update on this?
> 
> Gentle ping. Anything we can do to help?

I know we're being annoying, but would really appreciate if you could
find some time to look at this again.

I couldn't reproduce any build failure in various combinaisons on fedora
so would either need more input from you on how to reproduce or maybe it
was just a flake?
Either way please let us know if there's anything we can do.

Thanks,
-- 
Dominique
