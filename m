Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB600C433F5
	for <linux-dwarves@archiver.kernel.org>; Thu, 21 Oct 2021 20:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D092A61037
	for <linux-dwarves@archiver.kernel.org>; Thu, 21 Oct 2021 20:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbhJUUvl (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 21 Oct 2021 16:51:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:58148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231430AbhJUUvk (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Thu, 21 Oct 2021 16:51:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BEAF60FD9;
        Thu, 21 Oct 2021 20:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634849364;
        bh=8tbpDOADcNCcyc8S/kmvCVLp9slLSAi1UB4wNuO1eww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lPwj/xmq6+VcljK2IKMakjJO60Ek9NNmQQizcV4s46F0FoZpUiMCmM6wlMSlQarsZ
         EmDESHTnI+ipaKBtaqUkZP5nro0s+lCXHKb0FzSTq5snIls1Fblg9OIaYA6jptAuOI
         LvMvu/bZC3R5Sr+HUzx3sN5QbUFy0eNVcweop60R0ErNPNgRd/tuKtCHNEag+BTkY5
         ekjjSVUU4Et4imqv9CEjD4x4rWqwffq5WZV/efdOBEXapd12v58mb8SCzNybdpBdxQ
         Gs+qK9UBJSXLgFu5mTh7U1niDjABsfhuo9tN3VyFaXBW91U3zX+nXjNbduWJDtE7qG
         LBwzIaotboghw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 16181410A1; Thu, 21 Oct 2021 17:49:21 -0300 (-03)
Date:   Thu, 21 Oct 2021 17:49:21 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Douglas RAILLARD <douglas.raillard@arm.com>
Cc:     acme@redhat.com, dwarves@vger.kernel.org
Subject: Re: [PATCH v2 2/3] btf_loader.c: Refactor class__fixup_btf_bitfields
Message-ID: <YXHSUaINccYHpmya@kernel.org>
References: <20211018131621.212628-1-douglas.raillard@arm.com>
 <20211018131621.212628-3-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018131621.212628-3-douglas.raillard@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Mon, Oct 18, 2021 at 02:16:20PM +0100, Douglas RAILLARD escreveu:
> From: Douglas Raillard <douglas.raillard@arm.com>
> 
> Refactor class__fixup_btf_bitfields to remove a "continue" statement, to
> prepare the ground for alignment fixup that is relevant for some types
> matching:
> 
>     type->tag != DW_TAG_base_type && type->tag != DW_TAG_enumeration_type

Thanks, applied.

    Committer testing:

    btfdiff passes for a x86_64 kernel built with gcc and for a clang
    thin-LTO vmlinux build.


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
