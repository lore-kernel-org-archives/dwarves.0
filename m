Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F83FC11F66
	for <linux-dwarves@archiver.kernel.org>; Tue, 29 Jun 2021 12:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EAE761D97
	for <linux-dwarves@archiver.kernel.org>; Tue, 29 Jun 2021 12:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbhF2MlM (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 29 Jun 2021 08:41:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:42686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233524AbhF2MlL (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Tue, 29 Jun 2021 08:41:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 66BF461D97;
        Tue, 29 Jun 2021 12:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624970324;
        bh=gRIg52db+13ng4kDRSld/uaMG0+tFkcd49IguB0fXEw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HIDrGbGUL5xnGb0Nbcvn7BoaRevJMgJrjcR7qgmqt1oDJUlFy6A31fiiPoElwRmF9
         D1Y70QO3Fv3ZV1q2fwxHUyJEdZPmMWv58r3VWdkMMLJVt8h6A1e1L/VQIJQogDsXxM
         lOik4KJOz2JM6sxq32kjboPuZLT6Hf9zuz/gTBMxco/fwKLGfaRMOA4f6VYg4PCiYV
         S3hDQrj2dBSXS7+XO9QTp9U55a8rNNwSZzLDwpMVWhFqi2EKi0e+HNHBTVdwWKfq2u
         Ehec20KFDk4ebwjurvMc0bdCsMh6WSqund/W75kTqv7Ne2kgpPhZiaUjZOdM+zhZcP
         863dNZ7LNL5Kw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9770940B1A; Tue, 29 Jun 2021 09:38:41 -0300 (-03)
Date:   Tue, 29 Jun 2021 09:38:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Bernd Buschinski <b.buschinski@googlemail.com>
Cc:     dwarves@vger.kernel.org
Subject: Re: pahole vs isatty
Message-ID: <YNsUURu/O/fDJLKh@kernel.org>
References: <CACN-hLVoz2tWrtgDLabOv6S1-H_8RD2fh8SV6EnADF1ikMxrmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACN-hLVoz2tWrtgDLabOv6S1-H_8RD2fh8SV6EnADF1ikMxrmw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Tue, Jun 29, 2021 at 10:13:38AM +0200, Bernd Buschinski escreveu:
> It seems the output is now only available if it is a real tty, which

if stdin is a real tty, stdout can be a real tty or be redirected, as
before.

> doesn't work for my scripts.

Sorry about that, I should have added a explicit command line option,
like with 'perf', where '-' means stdin. As this is a relatively new
feature I guess I'll do just that, i.e. stop unconditionally checking
for isatty(0) and only use the pretty printer when --printer is used.

> So, just as a question: Is this change really intentional?
> Is there any easy way to restore the old behavior?
> 
> FYI: my scripts are using perl and python, I do no really favor
> changing them, but if there is no other way.. I will do it :)

Well, you'll at least need to update pahole to 1.22, or, in the
meantime, use a patch, I'm working on it now, thanks for the report!

- Arnaldo
