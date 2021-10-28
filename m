Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C4FC433F5
	for <linux-dwarves@archiver.kernel.org>; Thu, 28 Oct 2021 13:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE21661139
	for <linux-dwarves@archiver.kernel.org>; Thu, 28 Oct 2021 13:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhJ1NRj (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 28 Oct 2021 09:17:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229641AbhJ1NRi (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Thu, 28 Oct 2021 09:17:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7FECC61130;
        Thu, 28 Oct 2021 13:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635426911;
        bh=/wt7wdjQGqHqCFOIK1/HBVKy7C78etb1voehYvHSxD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RzdaE36q5GY/3SP2D5Gwu5o6UR4ZejJnCyZkNmH4uJK9tYiUIomg1CwB4Xrxe1A0I
         xZahYVDEZqBkjD0PS1RtR30bKRi2S/PvQmdnbsDKKTzRh7tNqZ3/soQYFD83GH0CaV
         F0Y7O62IKKUePHaejQQQ81enSWfsOeoizAcgg+4zFsIdFUZSpMVdYmMTU2zqtIN9M5
         50IgNgzJL7WzURqn6KIp9oyYKvatYjj/kIWsZ/Hg4FpUJ9EDoVYDPcBTVkbpiw4nIL
         vb4sqSbnqAHkXxbgLaumgcR+EOcIs1+W1rN+k0Hd1YQ/tPDThsSIQsErmFba5tJ0iq
         E+UiXzV8Yk1Jg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DD2E0410A1; Thu, 28 Oct 2021 10:15:07 -0300 (-03)
Date:   Thu, 28 Oct 2021 10:15:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Douglas RAILLARD <douglas.raillard@arm.com>
Cc:     acme@redhat.com, dwarves@vger.kernel.org
Subject: Re: [PATCH v3 3/6] btf_loader.c: Infer alignment info
Message-ID: <YXqiW/8AM69NT2sx@kernel.org>
References: <20211028122710.881181-1-douglas.raillard@arm.com>
 <20211028122710.881181-4-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028122710.881181-4-douglas.raillard@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Thu, Oct 28, 2021 at 01:27:07PM +0100, Douglas RAILLARD escreveu:
> From: Douglas Raillard <douglas.raillard@arm.com>
> 
> BTF does not carry alignment information, but it carries the offset in
> structs. This allows inferring the original alignment, yielding a C
> header dump that is not identical to the original C code, but is
> guaranteed to lead to the same memory layout.
> 
> This allows using the output of pahole in another program to poke at
> memory, with the assurance that we will not read garbage.
> 
> Note: Since the alignment is inferred from the offset, it sometimes
> happens that the offset was already correctly aligned, which means the
> inferred alignment will be smaller than in the original source. This
> does not impact the ability to read existing structs, but it could
> impact creating such struct if other client code expects higher
> alignment than the one exposed in the generated header.

This as well was already applied, I split it in two:

"core: Export tag__natural_alignment()"
https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=next&id=4db65fe0cd02b3cc49d4fc8ff6c4c21a9ddb3642

"btf_loader: Infer alignment info"
https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=next&id=836c139fdf6f2b13ec2e5513df881272bb78aeb4
 
> Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
> ---
>  btf_loader.c | 36 ++++++++++++++++++++++++++++++++++++
>  dwarves.c    |  2 +-
>  dwarves.h    |  2 ++
>  3 files changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/btf_loader.c b/btf_loader.c
> index 9c2daee..2885252 100644
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
> @@ -508,8 +535,17 @@ static int class__fixup_btf_bitfields(struct tag *tag, struct cu *cu)
>  				pos->byte_offset = pos->bit_offset / 8;
>  			}
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
