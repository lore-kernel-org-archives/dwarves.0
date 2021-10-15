Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4970AC433EF
	for <linux-dwarves@archiver.kernel.org>; Fri, 15 Oct 2021 13:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2527361090
	for <linux-dwarves@archiver.kernel.org>; Fri, 15 Oct 2021 13:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhJONO7 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 15 Oct 2021 09:14:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:36176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229546AbhJONO7 (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Fri, 15 Oct 2021 09:14:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B6B3860F9F;
        Fri, 15 Oct 2021 13:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634303573;
        bh=dDkXvq4QLX4ELKfpHbPzEAaZTpws/cRbB/xUQQP2BNQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RYYvvTUjnggUqze5+EJD2UXJNxNEFwpX3arZUv0KNrNMj7UsVkWyTlSPx79LF9lOk
         xJKMV5XqhOC5c0rL/GNBFjYrMB9XLqRMLmJwzDMOBt2Lv7UphJtyZ85cIeDSES5WDk
         07ddNyXrtGY8fpAh/YDjqtmZOB2Mj236/3MzRLrT2A7ujt9qCZ0iZaIRYzsXRbg7un
         Zhoel44fC9TUXSYsZJY6aMqmBLaQ29OAWlM6WG1EyVV3bYhu9W3v/PSUPynz1WCBG7
         6LV8HJ31bl4YkdZDECku055gNWA3eeu+Tw8gO7VJ8gwQGQjCREnAEb8/AtU2DRSr5F
         fsiukqqCDWp8w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2F8C9410A1; Fri, 15 Oct 2021 10:12:50 -0300 (-03)
Date:   Fri, 15 Oct 2021 10:12:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Douglas RAILLARD <douglas.raillard@arm.com>
Cc:     acme@redhat.com, dwarves@vger.kernel.org
Subject: Re: [PATCH 2/2] btf_loader.c: Infer alignment info
Message-ID: <YWl+Ut6bATURgzTt@kernel.org>
References: <20211014114850.310575-1-douglas.raillard@arm.com>
 <20211014114850.310575-2-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014114850.310575-2-douglas.raillard@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Thu, Oct 14, 2021 at 12:48:50PM +0100, Douglas RAILLARD escreveu:
> From: Douglas Raillard <douglas.raillard@arm.com>
 
> BTF does not carry alignment information, but it carries the offset in
> structs. This allows inferring the original alignment, yielding a C
> header dump that is not identical to the original C code, but is
> guaranteed to lead to the same memory layout.
 
> This allows using the output of pahole in another program to poke at
> memory, with the assurance that we will not read garbage.

Which is super cool, thanks for working on this.

Please take a look at the 'fullcircle' tool in the pahole repo, I once
used it on all the single CU .o files in the kernel build to make sure
that we generate a source code and then object file that matches the
original object file (and thus its .c file), at least in layouts.

Doing it with BTF too after your change would be fantastic.

Now to review your patch, at first it looks big, but perhaps its
inherent to the change and we can't break it into smaller steps, will
see.

- Arnaldo
 
> Note: Since the alignment is inferred from the offset, it sometimes
> happens that the offset was already correctly aligned, which means the
> inferred alignment will be smaller than in the original source. This
> does not impact the ability to read existing structs, but it could
> impact creating such struct if other client code expects higher
> alignment than the one exposed in the generated header.
> 
> Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
> ---
>  btf_loader.c | 66 ++++++++++++++++++++++++++++++++++++++++------------
>  dwarves.c    |  2 +-
>  dwarves.h    |  2 ++
>  3 files changed, 54 insertions(+), 16 deletions(-)
> 
> diff --git a/btf_loader.c b/btf_loader.c
> index 3e5a945..54353d7 100644
> --- a/btf_loader.c
> +++ b/btf_loader.c
> @@ -471,10 +471,37 @@ static int btf__load_sections(struct btf *btf, struct cu *cu)
>  	return btf__load_types(btf, cu);
>  }
>  
> +static uint32_t class__infer_alignment(uint32_t byte_offset,
> +				       uint32_t natural_alignment,
> +				       uint32_t smallest_offset)
> +{
> +	uint32_t alignment = 0;
> +	uint32_t offset_delta = byte_offset - smallest_offset;
> +
> +	if (offset_delta) {
> +		if (byte_offset % 2 == 0) {
> +			/* Find the power of 2 immediately higher than
> +			 * offset_delta
> +			 */
> +			alignment = 1 << (8 * sizeof(offset_delta) -
> +					      __builtin_clz(offset_delta));
> +		} else {
> +			alignment = 0;
> +		}
> +	}
> +
> +	/* Natural alignment, nothing to do */
> +	if (alignment <= natural_alignment || alignment == 1)
> +		alignment = 0;
> +
> +	return alignment;
> +}
> +
>  static int class__fixup_btf_bitfields(struct tag *tag, struct cu *cu)
>  {
>  	struct class_member *pos;
>  	struct type *tag_type = tag__type(tag);
> +	uint32_t smallest_offset = 0;
>  
>  	type__for_each_data_member(tag_type, pos) {
>  		struct tag *type = tag__strip_typedefs_and_modifiers(&pos->tag, cu);
> @@ -486,31 +513,39 @@ static int class__fixup_btf_bitfields(struct tag *tag, struct cu *cu)
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
> +
> +		pos->alignment = class__infer_alignment(pos->byte_offset,
> +							tag__natural_alignment(type, cu),
> +							smallest_offset);
> +		smallest_offset = pos->byte_offset + pos->byte_size;
>  	}
>  
> +	tag_type->alignment = class__infer_alignment(tag_type->size,
> +						     tag__natural_alignment(tag, cu),
> +						     smallest_offset);
> +
>  	return 0;
>  }
>  
> @@ -519,6 +554,7 @@ static int cu__fixup_btf_bitfields(struct cu *cu)
>  	int err = 0;
>  	struct tag *pos;
>  
> +
>  	list_for_each_entry(pos, &cu->tags, node)
>  		if (tag__is_struct(pos) || tag__is_union(pos)) {
>  			err = class__fixup_btf_bitfields(pos, cu);
> diff --git a/dwarves.c b/dwarves.c
> index b6f2489..bb8af5b 100644
> --- a/dwarves.c
> +++ b/dwarves.c
> @@ -1515,7 +1515,7 @@ void class__find_holes(struct class *class)
>  
>  static size_t type__natural_alignment(struct type *type, const struct cu *cu);
>  
> -static size_t tag__natural_alignment(struct tag *tag, const struct cu *cu)
> +size_t tag__natural_alignment(struct tag *tag, const struct cu *cu)
>  {
>  	size_t natural_alignment = 1;
>  
> diff --git a/dwarves.h b/dwarves.h
> index 30d33fa..c2fea0a 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -1002,6 +1002,8 @@ struct type {
>  
>  void __type__init(struct type *type);
>  
> +size_t tag__natural_alignment(struct tag *tag, const struct cu *cu);
> +
>  static inline struct class *type__class(const struct type *type)
>  {
>  	return (struct class *)type;
> -- 
> 2.25.1

-- 

- Arnaldo
