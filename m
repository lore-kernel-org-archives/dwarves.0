Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FCB256C8D
	for <dwarves@vger.kernel.org>; Tue,  8 Jul 2025 14:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751983277; cv=none; b=DSAkOYdcwupfmdCu40N8uqNOCQo8wh2hZN6fLN0igJjE8xiVkLx7rMKJbIidr7jSzbZsUv6wpuKS5ncNygbIa88bkcHkPh+2pQEk8E4Bw6KzhJH6YRTwmTZ88U9DbcddeY+bL4deTSQfJnqg1F15wF30sy6rQnQnsbEvxEjWtIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751983277; c=relaxed/simple;
	bh=wsW7KxBjqX6jptIvNH/nR7ncmLlSt04bfqxUQ1JEtdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4Kl4NxCemM70ZdGtiME/DFlT3VEhloLjudabNG8yPoVcC/zgfJMo9lzHUIMsI6t8tB6sxEW2KfFD0V/lVLLF81PoOcIuyhKiIlO4E0jGmlnnrkxk7C6B/zTomgDUZIfM3KR4jkagokJnl+CW2b1c7KMgU6zUlrYiEIGlEDJnBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=palwBETw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="palwBETw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D8CC4CEED;
	Tue,  8 Jul 2025 14:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751983276;
	bh=wsW7KxBjqX6jptIvNH/nR7ncmLlSt04bfqxUQ1JEtdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=palwBETwT1BfidUyyeAtsgqkwsy2qZbPdrSZAj72JK36DWOwEBTXhbzGg1YyNvfnq
	 IyqY8oRrkMoKrYFrNYP5wHuQD+BHSVru3e1bfdk2LeMAbtZMWd6ONdVq83rYmBChM1
	 UeEWtd/6lzwZL5hxzQ8LuLxEh1Jv4VGgxK+SMlWASgx+vZtfpnedYreK5SsOldlC+a
	 Wf84sx+HRPBqgTZzYFTJu2nk62R1tzfx5gOJRQSV0my/mYPTQp4v7NOk1K6HbO5V7t
	 rt+BcuOMSKwGSmV0OAa7bu8wYMITccQY7+NCI2ClIsKcDiNEQ/qv4cCceJnzpV55JH
	 lcD/N3iqUdTkw==
Date: Tue, 8 Jul 2025 16:01:13 +0200
From: Antoine Tenart <atenart@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: dwarves@vger.kernel.org, pvalerio@redhat.com
Subject: Re: [PATCH 2/2] btf_loader: fix smallest offset in case of bitfields
Message-ID: <apflizfzjbsqidkr2yo5yijyjd5dins7w5kgy2iqqrbgeuwtqh@5jd377ma3wp7>
References: <20250625152329.28601-1-atenart@kernel.org>
 <20250625152329.28601-3-atenart@kernel.org>
 <fde12a46-2e23-4de4-970c-d272b3bd02bf@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fde12a46-2e23-4de4-970c-d272b3bd02bf@oracle.com>

On Fri, Jul 04, 2025 at 05:40:36PM +0100, Alan Maguire wrote:
> On 25/06/2025 16:23, Antoine Tenart wrote:
> > In case the member is a bitfield, using pos->byte_size can be misleading
> > as it can be larger than the actual size. In such case we could miss an
> > actual hole in the struct and not infer the alignment as expected.
> > 
> > Before this patch we can see:
> > 
> >   $ pahole nf_tables.btf -C nft_rule_dp
> >   struct nft_rule_dp {
> >   	u64                        is_last:1;            /*     0: 0  8 */
> >   	u64                        dlen:12;              /*     0: 1  8 */
> >   	u64                        handle:42;            /*     0:13  8 */
> > 
> >   	/* XXX 9 bits hole, try to pack */
> > 
> >   	unsigned char              data[];               /*     8     0 */
> > 
> >   	/* size: 8, cachelines: 1, members: 4 */
> >   	/* sum bitfield members: 55 bits, bit holes: 1, sum bit holes: 9 bits */
> >   	/* last cacheline: 8 bytes */
> >   };
> > 
> >   offsetof(struct nft_rule_dp, data) returns 7.
> > 
> > Where `data` won't be aligned as expected, as the first member fits on
> > the byte left after the bitfield.
> > 
> > After this patch we get:
> > 
> >   $ pahole nf_tables.btf -C nft_rule_dp
> >   struct nft_rule_dp {
> >   	u64                        is_last:1;            /*     0: 0  8 */
> >   	u64                        dlen:12;              /*     0: 1  8 */
> >   	u64                        handle:42;            /*     0:13  8 */
> > 
> >   	/* XXX 9 bits hole, try to pack */
> > 
> >   	unsigned char              data[] __attribute__((__aligned__(2))); /*     8     0 */
> > 
> >   	/* size: 8, cachelines: 1, members: 4 */
> >   	/* sum bitfield members: 55 bits, bit holes: 1, sum bit holes: 9 bits */
> >   	/* forced alignments: 1 */
> >   	/* last cacheline: 8 bytes */
> >   };
> > 
> >   offsetof(struct nft_rule_dp, data) returns 8.
> > 
> > Thanks to Paolo Valerio for helping, including narrowing down where the
> > issue was (BTF decoder).
> > 
> > Signed-off-by: Antoine Tenart <atenart@kernel.org>
> 
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> 
> > ---
> >  btf_loader.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/btf_loader.c b/btf_loader.c
> > index 76771afedd95..3beb5bba5f94 100644
> > --- a/btf_loader.c
> > +++ b/btf_loader.c
> > @@ -676,7 +676,10 @@ static int class__fixup_btf_bitfields(const struct conf_load *conf, struct tag *
> >  							pos->byte_offset,
> >  							tag__natural_alignment(type, cu),
> >  							smallest_offset);
> > -		smallest_offset = pos->byte_offset + pos->byte_size;
> > +		smallest_offset = pos->byte_offset;
> > +		smallest_offset += pos->bitfield_size ?
> > +			(pos->bitfield_offset + pos->bitfield_size + 7) / 8 :
> > +			pos->byte_size;
> 
> 
> would be good to have a comment here explaining the situation too; it's
> quite a subtle problem so anything that helps explain things would be
> great. Thanks for tracking this down!

Will do.

Thanks!
