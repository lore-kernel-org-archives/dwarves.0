Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A24C433EF
	for <linux-dwarves@archiver.kernel.org>; Thu, 28 Oct 2021 13:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40EDA61139
	for <linux-dwarves@archiver.kernel.org>; Thu, 28 Oct 2021 13:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhJ1NSU (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 28 Oct 2021 09:18:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:35126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229641AbhJ1NSU (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Thu, 28 Oct 2021 09:18:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16C1161130;
        Thu, 28 Oct 2021 13:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635426953;
        bh=qUjKJ0Fa1fAhN/8HjC3ji5aPf4yLa/RgMEUAKuunA+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dvAyCDaUrohPU68/ykLf6zgI8oemEMK26igkcG1gw8EiEyiy7IFkB31d5YPhA0BxE
         2J7QysWIbUsaz/CRkwoJytTUd/8ESkRYg8hFzeqJoabSEezvAm/NXZfgoWNARTcy20
         6+COYsKiRPh9MMNKPodABIQhabRvBdlWzExYgK4k8oyRVCCWHLLQx3xCG+pOFqwzJc
         KPqhfN2MwEHSoZgY71Ks1c5sqi2ujXUUTYIsn8u4TiJBrw/yHjk5meXYNn9tTiioFY
         /Xi4b3FQQxk+6L019h/x145I+1KmqH7w/X3vx7npzr6AcK9EsIwtkZU3aMHRBRszzi
         /EbjiAXSC3xdw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9B152410A1; Thu, 28 Oct 2021 10:15:50 -0300 (-03)
Date:   Thu, 28 Oct 2021 10:15:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Douglas RAILLARD <douglas.raillard@arm.com>
Cc:     acme@redhat.com, dwarves@vger.kernel.org
Subject: Re: [PATCH v3 2/6] btf_loader.c: Refactor class__fixup_btf_bitfields
Message-ID: <YXqihsuph69fRGA6@kernel.org>
References: <20211028122710.881181-1-douglas.raillard@arm.com>
 <20211028122710.881181-3-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028122710.881181-3-douglas.raillard@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Thu, Oct 28, 2021 at 01:27:06PM +0100, Douglas RAILLARD escreveu:
> From: Douglas Raillard <douglas.raillard@arm.com>
> 
> Refactor class__fixup_btf_bitfields to remove a "continue" statement, to
> prepare the ground for alignment fixup that is relevant for some types
> matching:
> 
>     type->tag != DW_TAG_base_type && type->tag != DW_TAG_enumeration_type

Also already applied.

- Arnaldo
 
> Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
> ---
>  btf_loader.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/btf_loader.c b/btf_loader.c
> index 3e5a945..9c2daee 100644
> --- a/btf_loader.c
> +++ b/btf_loader.c
> @@ -486,28 +486,27 @@ static int class__fixup_btf_bitfields(struct tag *tag, struct cu *cu)
>  		pos->byte_size = tag__size(type, cu);
>  		pos->bit_size = pos->byte_size * 8;
>  
> -		/* bitfield fixup is needed for enums and base types only */
> -		if (type->tag != DW_TAG_base_type && type->tag != DW_TAG_enumeration_type)
> -			continue;
> -
>  		/* if BTF data is incorrect and has size == 0, skip field,
>  		 * instead of crashing */
>  		if (pos->byte_size == 0) {
>  			continue;
>  		}
>  
> -		if (pos->bitfield_size) {
> -			/* bitfields seem to be always aligned, no matter the packing */
> -			pos->byte_offset = pos->bit_offset / pos->bit_size * pos->bit_size / 8;
> -			pos->bitfield_offset = pos->bit_offset - pos->byte_offset * 8;
> -			/* re-adjust bitfield offset if it is negative */
> -			if (pos->bitfield_offset < 0) {
> -				pos->bitfield_offset += pos->bit_size;
> -				pos->byte_offset -= pos->byte_size;
> -				pos->bit_offset = pos->byte_offset * 8 + pos->bitfield_offset;
> +		/* bitfield fixup is needed for enums and base types only */
> +		if (type->tag == DW_TAG_base_type || type->tag == DW_TAG_enumeration_type) {
> +			if (pos->bitfield_size) {
> +				/* bitfields seem to be always aligned, no matter the packing */
> +				pos->byte_offset = pos->bit_offset / pos->bit_size * pos->bit_size / 8;
> +				pos->bitfield_offset = pos->bit_offset - pos->byte_offset * 8;
> +				/* re-adjust bitfield offset if it is negative */
> +				if (pos->bitfield_offset < 0) {
> +					pos->bitfield_offset += pos->bit_size;
> +					pos->byte_offset -= pos->byte_size;
> +					pos->bit_offset = pos->byte_offset * 8 + pos->bitfield_offset;
> +				}
> +			} else {
> +				pos->byte_offset = pos->bit_offset / 8;
>  			}
> -		} else {
> -			pos->byte_offset = pos->bit_offset / 8;
>  		}
>  	}
>  
> -- 
> 2.25.1

-- 

- Arnaldo
