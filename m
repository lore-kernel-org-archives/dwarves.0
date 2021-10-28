Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C47C433F5
	for <linux-dwarves@archiver.kernel.org>; Thu, 28 Oct 2021 13:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17A5E60240
	for <linux-dwarves@archiver.kernel.org>; Thu, 28 Oct 2021 13:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhJ1N1Q (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 28 Oct 2021 09:27:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:36286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230157AbhJ1N1P (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Thu, 28 Oct 2021 09:27:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7CD260F9B;
        Thu, 28 Oct 2021 13:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635427489;
        bh=WBaab+Y5g4Aehajjm5zU3vl7L4ZuqpARq7ySmTRBReE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DrIgrN164znLDkKAQzpX5NSf9FEVz4sFckBpwuNoNzjyNl8hZX70BuVgGRBhLbwwy
         DrgckwmQOJl8tZm42f1M9YFLKndggdVoQvC8fRppke47FtM1YCle842OO/1MPkF4R1
         GqSK2g2NPfLMYnWUrftHk+wjZI1RggLKNMy3aj2e3VDYpmI36xnNfl2+U9oBAAZiDR
         i4tLI5idZlECoWXlnzIO6SLDwLDjbWbijprLdxmTyS7cDViLdNNeKTQ6GY34cT5kgY
         d3edMqVBkYqsz/Y7VZQoPuec9rDSayBRSDOOOfWHF9iV+Xv16yac/OeId+dldg7iab
         /RPDzVH9HKLsA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6EA80410A1; Thu, 28 Oct 2021 10:24:46 -0300 (-03)
Date:   Thu, 28 Oct 2021 10:24:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Douglas RAILLARD <douglas.raillard@arm.com>
Cc:     acme@redhat.com, dwarves@vger.kernel.org
Subject: Re: [PATCH v3 6/6] btf_loader.c: Use cacheline size to infer
 alignment
Message-ID: <YXqknmflB1WS8rnE@kernel.org>
References: <20211028122710.881181-1-douglas.raillard@arm.com>
 <20211028122710.881181-7-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028122710.881181-7-douglas.raillard@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Thu, Oct 28, 2021 at 01:27:10PM +0100, Douglas RAILLARD escreveu:
> From: Douglas Raillard <douglas.raillard@arm.com>
> 
> When the alignment is larger than natural, it is very likely that the
> source code was using the cacheline size. Therefore, use the cacheline
> size when it would only result in increasing the alignment.

--- /tmp/btfdiff.dwarf.pXdgRU   2021-10-28 10:22:11.738200232 -0300
+++ /tmp/btfdiff.btf.bkDkdf     2021-10-28 10:22:11.925205061 -0300
@@ -107,7 +107,7 @@ struct Qdisc {
        /* XXX 24 bytes hole, try to pack */

        /* --- cacheline 2 boundary (128 bytes) --- */
-       struct sk_buff_head        gso_skb __attribute__((__aligned__(64))); /*   128    24 */
+       struct sk_buff_head        gso_skb __attribute__((__aligned__(32))); /*   128    24 */
        struct qdisc_skb_head      q;                    /*   152    24 */
        struct gnet_stats_basic_packed bstats;           /*   176    16 */
        /* --- cacheline 3 boundary (192 bytes) --- */

This one is gone with heuristic, thanks for accepting my suggestion and
coding it this fast!

Applied.

I'm pushing it out to the 'next' branch, please work from there, I'll
move it to 'master' when it passes libbpf's CI tests.

- Arnaldo
 
> Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
> ---
>  btf_loader.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/btf_loader.c b/btf_loader.c
> index e500eae..7a5b16f 100644
> --- a/btf_loader.c
> +++ b/btf_loader.c
> @@ -476,6 +476,7 @@ static uint32_t class__infer_alignment(const struct conf_load *conf,
>  				       uint32_t natural_alignment,
>  				       uint32_t smallest_offset)
>  {
> +	uint16_t cacheline_size = conf->conf_fprintf->cacheline_size;
>  	uint32_t alignment = 0;
>  	uint32_t offset_delta = byte_offset - smallest_offset;
>  
> @@ -494,6 +495,15 @@ static uint32_t class__infer_alignment(const struct conf_load *conf,
>  	/* Natural alignment, nothing to do */
>  	if (alignment <= natural_alignment || alignment == 1)
>  		alignment = 0;
> +	/* If the offset is compatible with being aligned on the cacheline size
> +	 * and this would only result in increasing the alignment, use the
> +	 * cacheline size as it is safe and quite likely to be what was in the
> +	 * source.
> +	 */
> +	else if (alignment < cacheline_size &&
> +		 cacheline_size % alignment == 0 &&
> +		 byte_offset % cacheline_size == 0)
> +		alignment = cacheline_size;
>  
>  	return alignment;
>  }
> -- 
> 2.25.1

-- 

- Arnaldo
