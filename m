Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9040C433DB
	for <linux-dwarves@archiver.kernel.org>; Thu, 18 Feb 2021 19:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7355064EAF
	for <linux-dwarves@archiver.kernel.org>; Thu, 18 Feb 2021 19:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbhBRTp1 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 18 Feb 2021 14:45:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:56220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231603AbhBRTWY (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Thu, 18 Feb 2021 14:22:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E69B964EC4;
        Thu, 18 Feb 2021 19:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613676104;
        bh=zLKVgenSzSotaAnBU+nW97SOMa5t3aC33QYWtc4lk1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eR/PJxSYwUGd38LdM4PeDu7FbcU1Kl1q5e1MtbwbSKVyI85VmAOK5GSw5pwCEWXFt
         Wf665T50vKr5RZhwSrAx9Qj/p9aCgYeAteIzdEuSZAMWhPjKCXP4Xoi7sVQbTeyT1M
         fptoIAmhljek5laxcpp/6sYzQH7MdQ9bWbIIF42qVKBHtPGhuzNSk7c6BgYxOnYb2g
         ueB+M1jFsPsD/vx6keg8CCTH4yDJOy9TisbOvf2aW7/35Vv68XN60euJhFnWwy08U8
         n1koaWegX2re5o6v7LFSVRsnlueLzRGpverUy/wCdA1wQ49BSZ6X+vV7XpS0fzMq0J
         tQ1ybWhNXxZRw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9106540CD9; Thu, 18 Feb 2021 16:21:40 -0300 (-03)
Date:   Thu, 18 Feb 2021 16:21:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     dwarves@vger.kernel.org
Subject: Re: [PATCH] Avoid warning when building with NDEBUG
Message-ID: <YC6+RO9ayyGq45FK@kernel.org>
References: <20210218175115.2850050-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218175115.2850050-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Thu, Feb 18, 2021 at 09:51:15AM -0800, Ian Rogers escreveu:
> The assert macro is compiled out with NDEBUG which can lead to an unused
> variable warning if the variable is only read in the assert. This is
> seen just here:
> 
> dwarf_loader.c:957:17: error: unused variable 'tag' [-Werror,-Wunused-variable]
>         const uint16_t tag = dwarf_tag(die);

Thanks Ian, I added:

Signed-off-by: Ian Rogers <irogers@google.com>

And CC: dwarves@vger.kernel.org

Please let me know if this is all ok.

- Arnaldo

> ---
>  dwarf_loader.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index b73d786..22c3a55 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -954,9 +954,10 @@ static struct lexblock *lexblock__new(Dwarf_Die *die, struct cu *cu)
>  
>  static void ftype__init(struct ftype *ftype, Dwarf_Die *die, struct cu *cu)
>  {
> +#ifndef NDEBUG
>  	const uint16_t tag = dwarf_tag(die);
>  	assert(tag == DW_TAG_subprogram || tag == DW_TAG_subroutine_type);
> -
> +#endif
>  	tag__init(&ftype->tag, cu, die);
>  	INIT_LIST_HEAD(&ftype->parms);
>  	ftype->nr_parms	    = 0;
> -- 
> 2.30.0.617.g56c4b15f3c-goog
> 

-- 

- Arnaldo
