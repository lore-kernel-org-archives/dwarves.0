Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD25AC4708F
	for <linux-dwarves@archiver.kernel.org>; Wed,  2 Jun 2021 13:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB34B613D6
	for <linux-dwarves@archiver.kernel.org>; Wed,  2 Jun 2021 13:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbhFBNU3 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 2 Jun 2021 09:20:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:38240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229583AbhFBNU2 (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Wed, 2 Jun 2021 09:20:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2A816023D;
        Wed,  2 Jun 2021 13:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622639926;
        bh=rL3EhcF6S1uefzsCIxIseMg4iru0074pyJlZD+vLVxE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kKZAvUIP+ys977s1WK6sEFmuidiT7dU/sCS1oAZJrIGdsP+eY8n1pLWrk3xzpS097
         SR6wiFyUXWj4DQ1aLf08whiAhUBFDV85u/183UNIhzL6O30jQTiMnob0yBm4U3MTw9
         ixE+0865rKBhD9cMn5H1TGPo2Ji69PXwON+DCRl0480HtG0D9pEmoereRG7oO+puUJ
         3E1lyzOEGr7VmNlM4kRyyq9AKjOOiW7ZF8UwYcPd0iedH3KpUxwADPEoOYCKUfgZ4O
         fIIlRjxOMVij+/YDF3uiGSfEg6rnymbm1J9lJ2A2CUajnS8pP2cJwQ7sP929SWObxn
         J997JoNWkY3AQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7138740EFC; Wed,  2 Jun 2021 10:18:43 -0300 (-03)
Date:   Wed, 2 Jun 2021 10:18:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Deepak Kumar Mishra <deepakkumar.mishra@arm.com>
Cc:     dwarves@vger.kernel.org, qais.yousef@arm.com
Subject: Re: [PATCH 2/2] README: add documentation for -DBUILD_SHARED_LIBS
Message-ID: <YLeFM9VnG/kBwlB2@kernel.org>
References: <cover.1622612388.git.deepakkumar.mishra@arm.com>
 <6307fc26935026e9c9a765ae2f0f50226c891d34.1622612388.git.deepakkumar.mishra@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6307fc26935026e9c9a765ae2f0f50226c891d34.1622612388.git.deepakkumar.mishra@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Wed, Jun 02, 2021 at 11:26:24AM +0530, Deepak Kumar Mishra escreveu:
> added a section in README to give details about use of -DBUILD_SHARED_LIBS
> cmake option and existing documentation reformatted to accomodate this.

So are you changing the default to build as static? Please keep the
existing default and make building statically the opt-in mode, ok?

- Arnaldo
 
> Signed-off-by: Deepak Kumar Mishra <deepakkumar.mishra@arm.com>
> ---
>  README | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/README b/README
> index 576cd42..40ca984 100644
> --- a/README
> +++ b/README
> @@ -6,8 +6,17 @@ Build instructions:
>  4. cmake -D__LIB=lib ..
>  5. make install
>  
> -Default is to install to /usr/local, use -DCMAKE_INSTALL_PREFIX=
> -when invoking cmake to specify another install location.
> +cmake Options:
> +  -DBUILD_SHARED_LIBS
> +    By default STATIC libraries are created and applications are linked to it.
> +    use -DBUILD_SHARED_LIBS=ON while invoking cmake to create SHARED libraries
> +    and link applications to it.
> +
> +    Ex. cmake -D__LIB=lib -DBUILD_SHARED_LIBS=ON ..
> +
> +  -DCMAKE_INSTALL_PREFIX
> +    Default is to install to /usr/local, use -DCMAKE_INSTALL_PREFIX=
> +    when invoking cmake to specify another install location.
>  
>  Known to work scenarios:
>  
> -- 
> 2.17.1
> 

-- 

- Arnaldo
