Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F66EC2B9F4
	for <linux-dwarves@archiver.kernel.org>; Mon, 14 Jun 2021 18:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31CFC611EE
	for <linux-dwarves@archiver.kernel.org>; Mon, 14 Jun 2021 18:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbhFNSg6 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 14 Jun 2021 14:36:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:51236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232802AbhFNSg6 (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Mon, 14 Jun 2021 14:36:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D5C0611CE;
        Mon, 14 Jun 2021 18:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623695695;
        bh=TrGPNh3IQQEM5DznM6w4yUAyGwjjOFFcE8HgnxN9I3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O/7WWmcZQ4s8o6DADN37AMGjrqDqSzqC2+K2lcNqgmOtQtklnGCxTnSmbtJCGvmlX
         h+7wUpdtFYMzH7/5w2xnLT3GBqJ24dC2fmWt5dy+NCHbDwHkgTncM4Ka7WimLZH7HZ
         g1nGFMIlqfgOrvazY7PCQ8VuCS8uk3hmpnOGOu6PFkT3Cp7lHrnNGBSnGozZZ4Kn+0
         /kD0XawOljR33FNLkTvpDQD4CXSyeYrQ5TREMcmwsDzLv1IO8EDKKWgnOuINskK+AM
         P5XxJ9CF+27oBBscfi2Y5fvdLC3IHD6VBJY8sNORjzfVUSHOoeOgSi9OwZ3zDqYiE4
         keDq1MqKBx+Qw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1292840B1A; Mon, 14 Jun 2021 15:34:53 -0300 (-03)
Date:   Mon, 14 Jun 2021 15:34:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Luca Boccassi <bluca@debian.org>
Cc:     dwarves@vger.kernel.org, arnaldo.melo@gmail.com
Subject: Re: [PATCH dwarves 1/2] libbpf: if LIBBPF_EMBEDDED=OFF and
 libbpf-dev/pkgconfig is not available, fail the build
Message-ID: <YMehTcngoc2d6fSg@kernel.org>
References: <20210613134706.26933-1-bluca@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210613134706.26933-1-bluca@debian.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Sun, Jun 13, 2021 at 02:47:05PM +0100, Luca Boccassi escreveu:
> If using the system library was explicitly requested, ensure it is present
> and fail the build if it is not, rather than falling back to the
> embedded version (same for pkg-config).


Thanks, applied and tested both patches,

- Arnaldo
 
> Signed-off-by: Luca Boccassi <bluca@debian.org>
> ---
>  CMakeLists.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/CMakeLists.txt b/CMakeLists.txt
> index 669ea59..0f967d1 100644
> --- a/CMakeLists.txt
> +++ b/CMakeLists.txt
> @@ -4,9 +4,9 @@ cmake_policy(SET CMP0005 NEW)
>  
>  option(LIBBPF_EMBEDDED "Use the embedded version of libbpf instead of searching it via pkg-config" ON)
>  if (NOT LIBBPF_EMBEDDED)
> -	find_package(PkgConfig)
> +	find_package(PkgConfig REQUIRED)
>  	if(PKGCONFIG_FOUND)
> -		pkg_check_modules(LIBBPF libbpf>=0.3.0)
> +		pkg_check_modules(LIBBPF REQUIRED libbpf>=0.3.0)
>  	endif()
>  endif()
>  
> -- 
> 2.30.2
> 

-- 

- Arnaldo
