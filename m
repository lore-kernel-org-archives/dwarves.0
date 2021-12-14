Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB5AC433EF
	for <linux-dwarves@archiver.kernel.org>; Tue, 14 Dec 2021 14:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbhLNO4B (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 14 Dec 2021 09:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235094AbhLNO4A (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 14 Dec 2021 09:56:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2783C061574
        for <dwarves@vger.kernel.org>; Tue, 14 Dec 2021 06:56:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3ED1961524
        for <dwarves@vger.kernel.org>; Tue, 14 Dec 2021 14:56:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81590C34601;
        Tue, 14 Dec 2021 14:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639493759;
        bh=qZgT5EcOmDHYG9WrR8ckuELysOf6BPLZbLARNGzjQII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U8mZvEeDS9RbgILX4uZy4pII81eCXSoiT1fKSm5QNCn+T9DJW0tmV2z5dP+hsunLG
         MMHVlFxOQhVbnXRux45bJLmDt/56yNCSUPJwA/NPAfk6pG9y0XFHZb9y8zd5iBkSf1
         kemIhwURNgSWghQPpG+ZDFWIUFvd1eygYBMwZdf3ColymTsxr+vEtupxzxYYte/NMq
         0qCMKt/gR74WWO/R07cmKs+c0r+qytyxrAXxKHIEWD9GofVAjSBxAZb+SwHY3aRCrR
         BxRVK5FkWdc4cfx362SSP8tuxUG1viUonGLlHxHV6W9enGy/+5qbp4AyA6NmGOtrSI
         AEpYjIBxPQfXg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 801D1405D8; Tue, 14 Dec 2021 11:55:56 -0300 (-03)
Date:   Tue, 14 Dec 2021 11:55:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Douglas RAILLARD <douglas.raillard@arm.com>
Cc:     acme@redhat.com, dwarves@vger.kernel.org
Subject: Re: [PATCH v2 4/6] pahole.c: Add prefix to expanded type names
Message-ID: <YbiwfOPqiuZE7SUX@kernel.org>
References: <20211207173151.2283946-1-douglas.raillard@arm.com>
 <20211207173151.2283946-5-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207173151.2283946-5-douglas.raillard@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Tue, Dec 07, 2021 at 05:31:49PM +0000, Douglas RAILLARD escreveu:
> From: Douglas Raillard <douglas.raillard@arm.com>
> 
> Add the prefix specified by --expanded_prefix to type names that have
> not been specificaly requested using -C. This allows manual namespacing
> so that these inner types will not conflict with existing headers.
> 
> Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
> ---
>  dwarves.h |  1 +
>  pahole.c  | 29 +++++++++++++++++++++++++++--
>  2 files changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/dwarves.h b/dwarves.h
> index fc5b3fa..0967e5c 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -90,6 +90,7 @@ struct conf_load {
>   */
>  struct conf_fprintf {
>  	const char *prefix;
> +	const char *name_prefix;
>  	const char *suffix;
>  	int32_t	   type_spacing;
>  	int32_t	   name_spacing;
> diff --git a/pahole.c b/pahole.c
> index 42ba110..e0a1438 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -2882,6 +2882,33 @@ out_btf:
>  
>  	bool include_decls = find_pointers_in_structs != 0 || stats_formatter == nr_methods_formatter;
>  	struct prototype *prototype, *n;
> +	static type_id_t class_id;
> +
> +	uint32_t id;
> +	struct tag *pos;
> +	bool skip;
> +	const char *prefix = conf_load->conf_fprintf->name_prefix;
> +	const size_t prefix_len = prefix ? strlen(prefix) : 0;
> +	cu__for_each_type(cu, id, pos) {
> +		if (tag__is_type(pos)) {
> +			const char *name = type__name(tag__type(pos));
> +			if (name && prefix) {
> +				skip = false;
> +				list_for_each_entry_safe(prototype, n, &class_names, node) {
> +					if (!strcmp(prototype->name, name)) {
> +						skip = true;
> +						break;
> +					}
> +				}
> +				if (!skip) {
> +					const size_t len = 1024 + prefix_len;
> +					char *bf = malloc(len);
> +					snprintf(bf, len, "%s%s", prefix, name);
> +					tag__namespace(pos)->name = bf;
> +				}
> +			}
> +		}
> +	}

I don't like this change in place mode, but I understand it is easier to
do it here instead of in all types fprintf routines, but perhaps its
better that way, I'll check how big it would be.

>  
>  	list_for_each_entry_safe(prototype, n, &class_names, node) {
>  
> @@ -2891,8 +2918,6 @@ out_btf:
>  				prototype->type_enum_resolved = type__find_type_enum(tag__type(prototype->class), cu, prototype->type_enum) == 0;
>  			continue;
>  		}
> -
> -		static type_id_t class_id;
>  		struct tag *class = cu__find_type_by_name(cu, prototype->name, include_decls, &class_id);
>  
>  		// couldn't find that class name in this CU, continue to the next one.
> -- 
> 2.25.1

-- 

- Arnaldo
