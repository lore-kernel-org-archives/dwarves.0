Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B21C433EF
	for <linux-dwarves@archiver.kernel.org>; Mon, 20 Sep 2021 21:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C801C61166
	for <linux-dwarves@archiver.kernel.org>; Mon, 20 Sep 2021 21:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbhITVTc (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 20 Sep 2021 17:19:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:33082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235204AbhITVRb (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Mon, 20 Sep 2021 17:17:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45FA461175;
        Mon, 20 Sep 2021 21:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632172564;
        bh=ZLDa1X+j/jz5EkaxeO4Y8EjcYBn2XJSbdN6G9ppiIUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=enITK4CfDD1tTwT3yb7jn2Gnz9fe7c42gpym+4+JOmROvAQddTrPOwhrJlOwdptVT
         oXn22rUn+KpbKKAfeEWAuuNznogXCRI6ujDyfvShrde23BEAEBXnZJj20fN3rJdI7V
         M8GpGpixAIi73w29MlhVpPU/siTbJRQzWw69arEu8BIzQJ68mE3m8huTx2x/P9N6tL
         rXGPprLorrMlsdcn9bEhWT5QBZRhiN4zT4MsYCcDTyvvPhEQfFy5qA7XFp6Senksnh
         UmYe8yeRzc70U4tNYhNIuULrExF3sKVEAX99tqXgwZQCnaeVqbpnOTpDTydy49FSka
         ehGVh5gZTqNRw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0BB2B410A1; Mon, 20 Sep 2021 18:16:00 -0300 (-03)
Date:   Mon, 20 Sep 2021 18:16:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     dwarves@vger.kernel.org
Subject: Re: [PATCH] CMakeList.txt: don't download libbpf source when system
 library is used
Message-ID: <YUj6EPoZ5VsxE1Dl@kernel.org>
References: <20210920164452.44529-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920164452.44529-1-mcroce@linux.microsoft.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Mon, Sep 20, 2021 at 06:44:52PM +0200, Matteo Croce escreveu:
> From: Matteo Croce <mcroce@microsoft.com>
> 
> The build system always download the libbpf submodule, regardless if
> we're using the embedded or the system version.
> Download the libbpf source only if we're using the embedded one.

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Matteo Croce <mcroce@microsoft.com>
> ---
>  CMakeLists.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/CMakeLists.txt b/CMakeLists.txt
> index 8523bce..2ab66e4 100644
> --- a/CMakeLists.txt
> +++ b/CMakeLists.txt
> @@ -65,7 +65,7 @@ find_package(Python3 QUIET)
>  
>  # make sure git submodule(s) are checked out
>  find_package(Git QUIET)
> -if(GIT_FOUND AND EXISTS "${PROJECT_SOURCE_DIR}/.git")
> +if(LIBBPF_EMBEDDED AND GIT_FOUND AND EXISTS "${PROJECT_SOURCE_DIR}/.git")
>  	# Update submodules as needed
>  	option(GIT_SUBMODULE "Check submodules during build" ON)
>  	if(GIT_SUBMODULE)
> -- 
> 2.31.1

-- 

- Arnaldo
