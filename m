Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A04AC432BE
	for <linux-dwarves@archiver.kernel.org>; Mon, 30 Aug 2021 18:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8017460C3F
	for <linux-dwarves@archiver.kernel.org>; Mon, 30 Aug 2021 18:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbhH3S6m (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 30 Aug 2021 14:58:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232808AbhH3S6m (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Mon, 30 Aug 2021 14:58:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2607C60C3F;
        Mon, 30 Aug 2021 18:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630349868;
        bh=G2GrL4GJlp6rUwvwyx2ZzYGyEVqMNoAvBVec5O1QJxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vj+Rnsm6D7coLnHpAsZhEVhbMTuMwcvvA4YwlzvT7Z3r8e+NYmlBOr2rCcTxy6Dm+
         GjS2E1KiLueUU8qzj4kD24fn5VhiPSLH/GiR8ZC+vtG96suZU86S6wsvQRz/yVll0J
         vQGO+tZKPQ3XuQkhdOXKwqIVrKzZYRIUg6Asowxo4Nk9OUTHGaCTD2Bj0dMU1R2MDU
         4cvp60mEvJz6D3Y9qzMk4ryeFkQED9o71KojJo9FVhi53doCdgFud4P1jOFqKQJDve
         IHhFPHzq40KGQxjB5ob8wE34KcfFvSneeG3JPZVcIJ/5B7O8n2VRTtpVKXXQXlshck
         aA2Is1ZjJTY0w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C9E9E4007E; Mon, 30 Aug 2021 15:57:44 -0300 (-03)
Date:   Mon, 30 Aug 2021 15:57:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     dwarves@vger.kernel.org
Subject: Re: [PATCH] CMakeList.txt: make python optional
Message-ID: <YS0qKGpMfSYHRsUP@kernel.org>
References: <20210830150440.1525773-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830150440.1525773-1-mcroce@linux.microsoft.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Mon, Aug 30, 2021 at 05:04:40PM +0200, Matteo Croce escreveu:
> From: Matteo Croce <mcroce@microsoft.com>
> 
> ostra-cg, which requires python, is installed in the destination dir.
> Make it optional for embedded distributions which doesn't have the
> python interpreter available.

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Matteo Croce <mcroce@microsoft.com>
> ---
>  CMakeLists.txt | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/CMakeLists.txt b/CMakeLists.txt
> index 4140574..8523bce 100644
> --- a/CMakeLists.txt
> +++ b/CMakeLists.txt
> @@ -61,6 +61,7 @@ find_package(DWARF REQUIRED)
>  find_package(ZLIB REQUIRED)
>  find_package(argp REQUIRED)
>  find_package(obstack REQUIRED)
> +find_package(Python3 QUIET)
>  
>  # make sure git submodule(s) are checked out
>  find_package(Git QUIET)
> @@ -185,8 +186,10 @@ install(FILES dwarves.h dwarves_emit.h dwarves_reorganize.h
>  	      elfcreator.h elf_symtab.h hash.h libctf.h
>  	DESTINATION ${CMAKE_INSTALL_PREFIX}/include/dwarves/)
>  install(FILES man-pages/pahole.1 DESTINATION ${CMAKE_INSTALL_PREFIX}/share/man/man1/)
> -install(PROGRAMS ostra/ostra-cg DESTINATION ${CMAKE_INSTALL_PREFIX}/bin)
> +if(Python3_FOUND)
> +	install(PROGRAMS ostra/ostra-cg DESTINATION ${CMAKE_INSTALL_PREFIX}/bin)
> +	install(FILES ostra/python/ostra.py DESTINATION ${CMAKE_INSTALL_PREFIX}/share/dwarves/runtime/python)
> +endif()
>  install(PROGRAMS btfdiff fullcircle DESTINATION ${CMAKE_INSTALL_PREFIX}/bin)
> -install(FILES ostra/python/ostra.py DESTINATION ${CMAKE_INSTALL_PREFIX}/share/dwarves/runtime/python)
>  install(FILES lib/Makefile lib/ctracer_relay.c lib/ctracer_relay.h lib/linux.blacklist.cu
>  	DESTINATION ${CMAKE_INSTALL_PREFIX}/share/dwarves/runtime)
> -- 
> 2.31.1

-- 

- Arnaldo
