Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D2A1D5CD1
	for <dwarves@vger.kernel.org>; Tue,  8 Jul 2025 13:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751982947; cv=none; b=SnMryJOd+KpRTEEfUtTp/Efis8IyVINdeGkZJjrcwQ+o5lBa+NCcWQZDNhLzFdgOFlTk/UfuaP9pLtY8csLGNo0L9hHmSCQ6511khL7Xo4DzgPkfzbQOXBoX2b98TezrHxPJ2nQdjeMuQRFkVyY3LE0nxrguwQI4e4sRuQZQSNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751982947; c=relaxed/simple;
	bh=JTEffFkD5JdIJANL8dkGT326BVudPkaO7RUkAYkZXTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pA1hPRsOFqrvERamjuKzw1j3jqV9D878W8YhVQFCqsezDpfcOT47qSIS7niW4B8qeFuig9uHJ9Y1bAlOiYFcB/HrAVRJiaS/PBiU/2nx0UJWsiWMJKpebuX9zuGW6IYdX+A/nI5in9Snq6EbFNpwUsaz40/8swWzqG65aBOoFiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkzGgDti; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkzGgDti"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB60C4CEED;
	Tue,  8 Jul 2025 13:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751982946;
	bh=JTEffFkD5JdIJANL8dkGT326BVudPkaO7RUkAYkZXTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dkzGgDtiMRv5cZDZcJjP9OogidMFWHHLH6nKZNLAktW7ucrT7bh8Oyh+P5a/tzVhb
	 lUi9N3YwQptaVHLha6i4ZiMr5yi1Jg5LAn2MMLVCS0oCtjqQ6P1PGA7YDrqz4SuW2d
	 3Cy7w3Y9meBxB+98gHliCouUuksH6wikWRzmfqo5NWGmdxsCSsUEyhnDGe/UdfprgE
	 6DeuyF+4jh6jWwPjV/y9+gxvTcTyOEK3MjtsCM9TmxCgcVrWWG1QD1r1Hoz4SE0kUt
	 mqZ24IhYpoSZsWY3WWoebUEJ4jR46/I/HwjnE44xNRlSp9fAy1ZLg2a9NpTQabBcFX
	 fk6ZybH4RwngA==
Date: Tue, 8 Jul 2025 15:55:43 +0200
From: Antoine Tenart <atenart@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Antoine Tenart <atenart@kernel.org>, dwarves@vger.kernel.org, 
	pvalerio@redhat.com
Subject: Re: [PATCH 1/2] btf_loader: infer alignment for zero-length arrays
Message-ID: <pslnelp3ymrvwgtbr24ztlszpd74y6fpizob3xzztn6t7duxta@ipou2mlapwl2>
References: <20250625152329.28601-1-atenart@kernel.org>
 <20250625152329.28601-2-atenart@kernel.org>
 <a43307cd-bfb8-4ff1-b03e-2d6732af85ce@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a43307cd-bfb8-4ff1-b03e-2d6732af85ce@oracle.com>

On Fri, Jul 04, 2025 at 05:34:47PM +0100, Alan Maguire wrote:
> On 25/06/2025 16:23, Antoine Tenart wrote:
> > Zero sized arrays do not go through the bitfield fixup logic, which in
> > turn makes them to skip the alignment infer logic. The result is
> > zero-length arrays being incorrectly aligned when an explicit statement
> > is needed. E.g. this happens for variable length arrays at end of
> > structures, or for 0-length ones.
> > 
> > Before this patch we can see:
> > 
> >   struct skb_ext {
> > 	refcount_t                 refcnt;               /*     0     4 */
> > 	u8                         offset[4];            /*     4     4 */
> > 	u8                         chunks;               /*     8     1 */
> > 
> > 	/* XXX 7 bytes hole, try to pack */
> > 
> > 	char                       data[];               /*    16     0 */
> > 
> > 	/* size: 16, cachelines: 1, members: 4 */
> > 	/* sum members: 9, holes: 1, sum holes: 7 */
> > 	/* last cacheline: 16 bytes */
> >   } __attribute__((__aligned__(8)));
> > 
> >   offsetof(struct skb_ext, data) returns 9.
> > 
> > After this patch we get:
> > 
> >   struct skb_ext {
> > 	refcount_t                 refcnt;               /*     0     4 */
> > 	u8                         offset[4];            /*     4     4 */
> > 	u8                         chunks;               /*     8     1 */
> > 
> > 	/* XXX 7 bytes hole, try to pack */
> > 
> > 	char                       data[] __attribute__((__aligned__(8))); /*    16     0 */
> > 
> > 	/* size: 16, cachelines: 1, members: 4 */
> > 	/* sum members: 9, holes: 1, sum holes: 7 */
> > 	/* forced alignments: 1, forced holes: 1, sum forced holes: 7 */
> > 	/* last cacheline: 16 bytes */
> >   } __attribute__((__aligned__(8)));
> > 
> >   offsetof(struct skb_ext, data) returns 16.
> > 
> > Signed-off-by: Antoine Tenart <atenart@kernel.org>
> 
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> 
> with a small suggestion below..
> 
> > ---
> >  btf_loader.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/btf_loader.c b/btf_loader.c
> > index f4f9f65289b5..76771afedd95 100644
> > --- a/btf_loader.c
> > +++ b/btf_loader.c
> > @@ -648,6 +648,10 @@ static int class__fixup_btf_bitfields(const struct conf_load *conf, struct tag *
> >  		/* if BTF data is incorrect and has size == 0, skip field,
> >  		 * instead of crashing */
> 
> nit: could we update the comment here to reflect the change, adding
> something like "however we still need to infer alignment for cases like
> zero/variable-length arays".

Makes sense, I'll improve the comment in v2.

Thanks!

> 
> 
> >  		if (pos->byte_size == 0) {
> > +			pos->alignment = class__infer_alignment(conf,
> > +								pos->byte_offset,
> > +								tag__natural_alignment(type, cu),
> > +								smallest_offset);
> >  			continue;
> >  		}
> >  
> 
