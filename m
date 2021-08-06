Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21190C4338F
	for <linux-dwarves@archiver.kernel.org>; Fri,  6 Aug 2021 18:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02BDA60EC0
	for <linux-dwarves@archiver.kernel.org>; Fri,  6 Aug 2021 18:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243232AbhHFSmc (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 6 Aug 2021 14:42:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:43826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231889AbhHFSmc (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Fri, 6 Aug 2021 14:42:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 086E060ED6;
        Fri,  6 Aug 2021 18:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628275336;
        bh=xjQYcbNtLQ7w74om754xBijauqqbMV2XpoBR4OclBcM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VDM+ytcDZD/idOInBs6wAyJF+3tgkTp/trd+ZVyYDMNjepxFvDNW+khJ8Md5NlVHs
         4U/vxYOWvgHYlpPT1JJ1NkVrsJPRf52RjYiGpHfUGdxrxQW6OdjQTTJZEc/q6FnxpC
         MGOrXUyG3Jyd8hHxDl2/wChQVSi9C6Csw3rgW71pI1gsCc9b4oQ5cUQ3u/oXXjLBsm
         Bql+owB7mrIL74jSCYjSqqwNPLxwc2JnswjF1FvmrR3MW/RIXtE6GU4pkYGUHSMSZ0
         ZI5dyvfpGAI1Paszt25X3NhZYuLGrzQMueng587MjMJjXw8v+kcMaYWVdVrEQGEsGi
         0WVaz4TfRoTbQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 43E19403F2; Fri,  6 Aug 2021 15:42:13 -0300 (-03)
Date:   Fri, 6 Aug 2021 15:42:13 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        dwarves@vger.kernel.org
Subject: Re: [PATCH] pahole: correct libbpf git url
Message-ID: <YQ2Chd/j62NCY2NX@kernel.org>
References: <1628244763-1113-1-git-send-email-joseph.qi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1628244763-1113-1-git-send-email-joseph.qi@linux.alibaba.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Fri, Aug 06, 2021 at 06:12:43PM +0800, Joseph Qi escreveu:
> Otherwise it will encounter the following error:
> fatal: unable to access 'https://github.com/libbpf/libbpf/': Encountered end of file
> fatal: clone of 'https://github.com/libbpf/libbpf' into submodule path '/home/workspace/pahole/lib/bpf' failed
> 
> Also update README to add step 'make'.

You forgot to add Andrii, the author of the patch you're fixing, to the
CC list, please do it next time.

- Arnaldo
 
> Fixes: 21507cd3e97b ("pahole: add libbpf as submodule under lib/bpf")
> Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  .gitmodules | 2 +-
>  README      | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/.gitmodules b/.gitmodules
> index 6be99dc..8be5eb6 100644
> --- a/.gitmodules
> +++ b/.gitmodules
> @@ -1,3 +1,3 @@
>  [submodule "lib/bpf"]
>  	path = lib/bpf
> -	url = https://github.com/libbpf/libbpf
> +	url = https://github.com/libbpf/libbpf.git
> diff --git a/README b/README
> index c9f1737..07f5876 100644
> --- a/README
> +++ b/README
> @@ -4,7 +4,8 @@ Build instructions:
>  2. mkdir build
>  3. cd build
>  4. cmake -D__LIB=lib ..
> -5. make install
> +5. make
> +6. make install
>  
>  cmake Options:
>    -DBUILD_SHARED_LIBS
> -- 
> 1.8.3.1
> 

-- 

- Arnaldo
