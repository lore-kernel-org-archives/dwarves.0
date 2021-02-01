Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50226C433DB
	for <linux-dwarves@archiver.kernel.org>; Mon,  1 Feb 2021 12:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E33964E9E
	for <linux-dwarves@archiver.kernel.org>; Mon,  1 Feb 2021 12:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhBAMbC (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 1 Feb 2021 07:31:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:33134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229717AbhBAMbC (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Mon, 1 Feb 2021 07:31:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB6EB64E97;
        Mon,  1 Feb 2021 12:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612182621;
        bh=WFMdBdSmykR6K2W7YrpYp/QiPZhqaIbvdJbIdygGqu8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VJK5KXihCjbWMnVYhFA3nQpzDooS6LyS9/HXWlT0Ay4Ze9Tg2vNWr7j8JiBo9tPF2
         bePipKkZ7h2t3KA/MuWD6/G6Y5G7Mu0ytkJUmixY5UzhOpxG64B8toADuG83Z7yo0W
         MWkfLlAC8+TeFimC/yUAwZ+0l5FO3Lq6pdkXqehZ9LEi/QUlUFhttPamtTNWRWMiBk
         mjW7LheFh/PMdHr3ExK9b1P0JX/GaF6L81vq86IyRWDYeO8kRwFxMEHnRoUKrHQ0F4
         +miybEsN70W3K/BUO5D7km5On9x8ALUAh0xcETGb8zPGs+kIOLKJaya2b+g+izz13Z
         pSGdyptf5UCcg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 89D0140513; Mon,  1 Feb 2021 09:30:19 -0300 (-03)
Date:   Mon, 1 Feb 2021 09:30:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Mark Wielaard <mark@klomp.org>
Cc:     dwarves@vger.kernel.org
Subject: Re: [PATCH] Handle DWARF5 DW_TAG_call_site like DW_TAG_GNU_call_site
Message-ID: <20210201123019.GF794568@kernel.org>
References: <20210131002731.60086-1-mark@klomp.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210131002731.60086-1-mark@klomp.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Sun, Jan 31, 2021 at 01:27:31AM +0100, Mark Wielaard escreveu:
> DW_TAG_call_site and DW_TAG_call_site_parameter are the standardized
> DWARF5 versions of DW_TAG_GNU_call_site and DW_TAG_GNU call_site_parameter.
> Handle them the same way (which is by ignoring them).

Thanks, I added these two lines, plese let me know if you're not ok with
it:

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1922698
Signed-off-by: Mark Wielaard <mark@klomp.org>

 
> https://bugzilla.redhat.com/show_bug.cgi?id=1922698
> ---
>  dwarf_loader.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index ac22c1b..3bdf570 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -41,6 +41,11 @@ struct strings *strings;
>  #define DW_TAG_GNU_call_site_parameter 0x410a
>  #endif
>  
> +#ifndef DW_TAG_call_site
> +#define DW_TAG_call_site 0x48
> +#define DW_TAG_call_site_parameter 0x49
> +#endif
> +
>  #define hashtags__fn(key) hash_64(key, HASHTAGS__BITS)
>  
>  bool no_bitfield_type_recode = true;
> @@ -1595,6 +1600,8 @@ static int die__process_function(Dwarf_Die *die, struct ftype *ftype,
>  		uint32_t id;
>  
>  		switch (dwarf_tag(die)) {
> +		case DW_TAG_call_site:
> +		case DW_TAG_call_site_parameter:
>  		case DW_TAG_GNU_call_site:
>  		case DW_TAG_GNU_call_site_parameter:
>  			/*
> -- 
> 2.20.1
> 

-- 

- Arnaldo
