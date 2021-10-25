Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7E1C433F5
	for <linux-dwarves@archiver.kernel.org>; Mon, 25 Oct 2021 17:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6E8D60EE3
	for <linux-dwarves@archiver.kernel.org>; Mon, 25 Oct 2021 17:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbhJYRKL (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 25 Oct 2021 13:10:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235132AbhJYRI1 (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Mon, 25 Oct 2021 13:08:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BFA0B6023B;
        Mon, 25 Oct 2021 17:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635181564;
        bh=6Lq/yt2q+SSv1UzKyCiFXICPTgTxRt3qBiibYLvdh+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ttTF//8JQDpyW4HEb1ih5So19TzSOP8c9wDVvhKVbHSR8GY+XV4bdM9lgyUaDTdv3
         Uxfkqzii3Bxc9ZxOpY/hRK5po7pPuS+h1PplfeqAGNvHfbCZOhSO017MIazlDvgmtu
         rDme6usMv3L+3xx1AQ4GxxaQO2temmqZJmkQh1TT/0TdCeOjYA/vOYzS4n/WpGRzIB
         hKTyRRjY6fQdZwRJwY9E21mkOFku0BTTWPi93suv64upiAgvYFj+OvdlUB/PYpvVlx
         rR9ur8QBOPp8onGB7EBDXXseAnDBzybqrdolT3DzPJ0rrx2CVzTS2lxCWFaA8RTFkR
         OMMF+1hkwQ8Ig==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 751DE410A1; Mon, 25 Oct 2021 14:06:02 -0300 (-03)
Date:   Mon, 25 Oct 2021 14:06:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Douglas RAILLARD <douglas.raillard@arm.com>
Cc:     acme@redhat.com, dwarves@vger.kernel.org
Subject: Re: [PATCH v2 3/3] btf_loader.c: Infer alignment info
Message-ID: <YXbj+gukL1fZx/Gb@kernel.org>
References: <20211018131621.212628-1-douglas.raillard@arm.com>
 <20211018131621.212628-4-douglas.raillard@arm.com>
 <YXIGaA1SYSx37EEV@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXIGaA1SYSx37EEV@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Thu, Oct 21, 2021 at 09:31:36PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Oct 18, 2021 at 02:16:21PM +0100, Douglas RAILLARD escreveu:
> > From: Douglas Raillard <douglas.raillard@arm.com>
> > 
> > BTF does not carry alignment information, but it carries the offset in
> > structs. This allows inferring the original alignment, yielding a C
> > header dump that is not identical to the original C code, but is
> > guaranteed to lead to the same memory layout.
> > 
> > This allows using the output of pahole in another program to poke at
> > memory, with the assurance that we will not read garbage.
> > 
> > Note: Since the alignment is inferred from the offset, it sometimes
> > happens that the offset was already correctly aligned, which means the
> > inferred alignment will be smaller than in the original source. This
> > does not impact the ability to read existing structs, but it could
> > impact creating such struct if other client code expects higher
> > alignment than the one exposed in the generated header.
> 
> this one makes btfdiff fail, example:
> 
> 
> @@ -125578,7 +125640,7 @@ struct xt_entry_match {
>  			struct xt_match * match;         /*     8     8 */
>  		} kernel;                                /*     0    16 */
>  		__u16              match_size;           /*     0     2 */
> -	} u;                                             /*     0    32 */
> +	} u;            /*     0    32 */
>  	unsigned char              data[];               /*    32     0 */
> 
>  	/* size: 32, cachelines: 1, members: 2 */
> 
> Why the change in the generated source code comment alignment?

Since this is inferred and DWARF has the alignment info explicitely, we
can't really compare, so I'll stick this to btfdiff.

diff --git a/btfdiff b/btfdiff
index 77543630d1965b5e..cbdf65285cd90f62 100755
--- a/btfdiff
+++ b/btfdiff
@@ -33,6 +33,7 @@ ${pahole_bin} -F dwarf \
 	      --show_private_classes $dwarf_input > $dwarf_output
 ${pahole_bin} -F btf \
 	      --sort \
+	      --suppress_aligned_attribute \
 	      --suppress_packed \
 	      $btf_input > $btf_output
 
 
> There are some other differences, I'll check tomorrow.

I got sidetracked, will try to reduce the differences somehow, but
probably as patches on top of yours, to test this the best is to use
fullcircle from BTF info, which I'll also look into as I think you
reported issues with pfunct's --compile option.

- Arnaldo
