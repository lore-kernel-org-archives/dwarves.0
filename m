Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F06C433F5
	for <linux-dwarves@archiver.kernel.org>; Thu, 28 Oct 2021 13:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F2EC60F56
	for <linux-dwarves@archiver.kernel.org>; Thu, 28 Oct 2021 13:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhJ1NW2 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 28 Oct 2021 09:22:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229641AbhJ1NW2 (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Thu, 28 Oct 2021 09:22:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E92260F92;
        Thu, 28 Oct 2021 13:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635427201;
        bh=q5dtpRaS8ijieUPBdnR9aPAXcWG7II6m8fB3YWEJzso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nQtfEk8V8a62+53S0xeTLtyfVxzgdAFrwCI0o1VIO+gxad/VxpZfZ4EjSefJAaGxt
         K+iSKYsPzKXd78osH3x6RvtuL2z3p6meQxfwHHFo2alKmKSHpFVwsyblVBFPmxpt84
         AXCVgh0wqk363vDhRLr1CIn5l6H4y04Tic9icOOfc5zRpKgLOV/cqmAF2nd33ftfai
         8IRTdO4yCh44I57GsYIUk9kzbsLSNB2rgZ9xMlgCVkgqWPW5ezP8xcx01qkUYKSZRQ
         CocKQeWdKavZrl7454beMtDJLhhYeGk9H/QbrwZ5tVstX6P1MAAG1gMwdem9BC7PAY
         6K0WL9qOItthA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1D058410A1; Thu, 28 Oct 2021 10:19:59 -0300 (-03)
Date:   Thu, 28 Oct 2021 10:19:59 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Douglas RAILLARD <douglas.raillard@arm.com>
Cc:     acme@redhat.com, dwarves@vger.kernel.org
Subject: Re: [PATCH v3 5/6] btf_loader.c: Propagate struct conf_load
Message-ID: <YXqjf+dH/Ft8iQCT@kernel.org>
References: <20211028122710.881181-1-douglas.raillard@arm.com>
 <20211028122710.881181-6-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028122710.881181-6-douglas.raillard@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Thu, Oct 28, 2021 at 01:27:09PM +0100, Douglas RAILLARD escreveu:
> From: Douglas Raillard <douglas.raillard@arm.com>
> 
> Give access to struct conf_load in class__infer_alignment.

prep patch, paving the way, thanks for doing it like that. :-)

Applied.

- Arnaldo

 
> Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
> ---
>  btf_loader.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/btf_loader.c b/btf_loader.c
> index 2885252..e500eae 100644
> --- a/btf_loader.c
> +++ b/btf_loader.c
> @@ -471,7 +471,8 @@ static int btf__load_sections(struct btf *btf, struct cu *cu)
>  	return btf__load_types(btf, cu);
>  }
>  
> -static uint32_t class__infer_alignment(uint32_t byte_offset,
> +static uint32_t class__infer_alignment(const struct conf_load *conf,
> +				       uint32_t byte_offset,
>  				       uint32_t natural_alignment,
>  				       uint32_t smallest_offset)
>  {
> @@ -497,7 +498,7 @@ static uint32_t class__infer_alignment(uint32_t byte_offset,
>  	return alignment;
>  }
>  
> -static int class__fixup_btf_bitfields(struct tag *tag, struct cu *cu)
> +static int class__fixup_btf_bitfields(const struct conf_load *conf, struct tag *tag, struct cu *cu)
>  {
>  	struct class_member *pos;
>  	struct type *tag_type = tag__type(tag);
> @@ -536,27 +537,29 @@ static int class__fixup_btf_bitfields(struct tag *tag, struct cu *cu)
>  			}
>  		}
>  
> -		pos->alignment = class__infer_alignment(pos->byte_offset,
> +		pos->alignment = class__infer_alignment(conf,
> +							pos->byte_offset,
>  							tag__natural_alignment(type, cu),
>  							smallest_offset);
>  		smallest_offset = pos->byte_offset + pos->byte_size;
>  	}
>  
> -	tag_type->alignment = class__infer_alignment(tag_type->size,
> +	tag_type->alignment = class__infer_alignment(conf,
> +						     tag_type->size,
>  						     tag__natural_alignment(tag, cu),
>  						     smallest_offset);
>  
>  	return 0;
>  }
>  
> -static int cu__fixup_btf_bitfields(struct cu *cu)
> +static int cu__fixup_btf_bitfields(const struct conf_load *conf, struct cu *cu)
>  {
>  	int err = 0;
>  	struct tag *pos;
>  
>  	list_for_each_entry(pos, &cu->tags, node)
>  		if (tag__is_struct(pos) || tag__is_union(pos)) {
> -			err = class__fixup_btf_bitfields(pos, cu);
> +			err = class__fixup_btf_bitfields(conf, pos, cu);
>  			if (err)
>  				break;
>  		}
> @@ -606,7 +609,7 @@ static int cus__load_btf(struct cus *cus, struct conf_load *conf, const char *fi
>  	if (err != 0)
>  		goto out_free;
>  
> -	err = cu__fixup_btf_bitfields(cu);
> +	err = cu__fixup_btf_bitfields(conf, cu);
>  	/*
>  	 * The app stole this cu, possibly deleting it,
>  	 * so forget about it
> -- 
> 2.25.1

-- 

- Arnaldo
