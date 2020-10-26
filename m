Return-Path: <SRS0=a5OZ=EB=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F247DC4363A
	for <linux-dwarves@archiver.kernel.org>; Mon, 26 Oct 2020 19:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C6552076D
	for <linux-dwarves@archiver.kernel.org>; Mon, 26 Oct 2020 19:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603741752;
	bh=Qh5soC1V3owSlTc6YVtG9RvxHWuFoHm3MmPqENWI3Js=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VqI6qIVuA1qgx8tswuCJmrUoxxEYGV+cjWByvbVvc3gk46cOnKVTuuJqJfUZ1IfrG
	 /yxBydpbo/dH5EXcNOZDViFT4rXEq1scnoSUFMmTuzH0FvF1GDy6ijRhH26PK7JFgj
	 vGeNCtf9EVPu9WEu7DpQUv842M/rS7f5isFcWc+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbgJZTtM (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 26 Oct 2020 15:49:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727198AbgJZTtM (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Mon, 26 Oct 2020 15:49:12 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 859D32076D;
        Mon, 26 Oct 2020 19:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603741751;
        bh=Qh5soC1V3owSlTc6YVtG9RvxHWuFoHm3MmPqENWI3Js=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XV+64Y75fZiwFQLzFeMET5061dMTe14jwB87aiAINOIl69KBQe0d4PgtyEtuODp3T
         UnQJoN14PcreBABmB28aDPbpfIn7ZALY9KP9obYKokjHv7XNvMDCCzD8BMEK/yEijw
         FLZIhdks5bZlgYLFiz1/aMpJi/4lkSp9XeNe0Dyc=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E1679403C2; Mon, 26 Oct 2020 16:49:08 -0300 (-03)
Date:   Mon, 26 Oct 2020 16:49:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     dwarves@vger.kernel.org
Subject: Re: [PATCH dwarves] cmake: make libbpf's Linux UAPI headers
 available to all binaries
Message-ID: <20201026194908.GC2449445@kernel.org>
References: <20201024183653.891042-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201024183653.891042-1-andrii@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Sat, Oct 24, 2020 at 11:36:53AM -0700, Andrii Nakryiko escreveu:
> Now that libbpf is used to implement deduplicated strings container, all of
> the binaries will need linux/btf.h header to compile properly. libbpf is
> distributed with its own copies of Linux UAPI headers, so use them during
> compilation.

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  CMakeLists.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/CMakeLists.txt b/CMakeLists.txt
> index 8e9fe4710a0c..84693514e0c8 100644
> --- a/CMakeLists.txt
> +++ b/CMakeLists.txt
> @@ -2,7 +2,9 @@ project(pahole C)
>  cmake_minimum_required(VERSION 2.8.8)
>  cmake_policy(SET CMP0005 NEW)
>  
> -INCLUDE_DIRECTORIES( ${CMAKE_CURRENT_BINARY_DIR} ${CMAKE_CURRENT_SOURCE_DIR} )
> +INCLUDE_DIRECTORIES(${CMAKE_CURRENT_BINARY_DIR}
> +		    ${CMAKE_CURRENT_SOURCE_DIR}
> +		    ${CMAKE_CURRENT_SOURCE_DIR}/lib/bpf/include/uapi)
>  
>  # Try to parse this later, Helio just showed me a KDE4 example to support
>  # x86-64 builds.
> -- 
> 2.24.1
> 

-- 

- Arnaldo
