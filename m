Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE1D39A07C
	for <dwarves@vger.kernel.org>; Mon, 31 Aug 2026 21:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788212121; cv=none; b=u2zLEVhFNmvCaNs5dk+GQyxedobcckwrNzxTjYzPkuPjoAasq5YlrCXStecU5aN5bOKZJ3VJk/rNVcffAHn2Fs8DZ/STJeaFaqb+cZWE9wIr9AD8D32kwKozfmFGDmayqEJ1VtCuXQ+04J+4O5+kkiD7AKMfYiCRAm+0+Qk+VMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788212121; c=relaxed/simple;
	bh=cnVqeIyF3Q1Hcy++oLQ74T2SmOAF2c7fBMxFVum4slE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqMB4G4CHpfPuevzOwC1nWuG6aQgmC4hH0u/QBAdWUfukJkw9mvkrycjNpblU55t/fhaBTpjVzcrMmtnEFhcTpNudsqxsvp/IQUwJhI9llpy+bJ8vhQCDHDZ1vugtiU9V9XMXzOQcTDPNkVaPpBbAeLfveYCqvZnaBugy1CPOZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUwJBMrK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUwJBMrK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEAD01F000E9;
	Mon, 31 Aug 2026 21:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788212119;
	bh=HyitV0s7VkkzOuKXzsKVBNgPKNWpF/1rntqlJVreeMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WUwJBMrKhzs9EUaPQzX8/gfwtS7LmRV63PgcOcmmmT8/hKdFejyOHQ2YxnFb2cxC+
	 IAkx6/d85xMLqTiUzbMTRqLA1nkpHNsE2Nz6tSYr7mS24h9DUvBn6Qadf/Ow4Drqz9
	 +mLHlRr/yTsV8X5FACfD/vkbHrp3JBjaA3A1PGuTxUgvllk5XLJdAynbrq95Fv9l9S
	 xQ/7I6QTOSCCExyLEg9yAAj/CClA+UJe0znC7Nm5BWgwUi6BPQWV6Tu15JYCvhDb4d
	 iCZrS0CHopCkHWdSFgas2AKlVuAyPfkeiOknj6MSsPD+QTy+QsTAwHGVq0Fbaem8eo
	 p6KJPo5XrT+nA==
Date: Mon, 31 Aug 2026 18:35:16 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Aditya Dutt <duttaditya18@gmail.com>
Cc: dwarves@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH dwarves] pahole: --unions shouldn't bypass struct-only
 options
Message-ID: <apXzlIKeb4tc8x88@x2>
References: <20260831185641.971022-1-duttaditya18@gmail.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831185641.971022-1-duttaditya18@gmail.com>

On Tue, Sep 01, 2026 at 12:26:41AM +0530, Aditya Dutt wrote:
> class__filter() returns early for --unions before the guard for struct
> only options. This results in calling functions like
> print_packable_info(), which reads c->priv which doesn't exist for
> unions.
> 
>   $ pahole --unions --packable m
>   Segmentation fault (core dumped)

Yeah, reproduced with the default use of /sys/kernel/btf/vmlinux:

acme@number:~/git/pahole$ pahole --unions --packable
Segmentation fault         (core dumped) pahole --unions --packable
acme@number:~/git/pahole$

Please split this into multiple patches, so that we can cherry pick
independent patches when we have some issue with one of the patches in
the series.
 
> The early return also prevents other struct only option filtering.
>                              before             after
>   --unions --packable        segfault           (nothing)
>   --unions -H 1              union u_named {}   (nothing)
>   --unions --bit_holes 1     union u_named {}   (nothing)
>   --unions --hole_size_ge 1  u_named            (nothing)
>   --unions --padding_ge 1    union u_named {}   (nothing)
>   --with_flexible_array      union u_named {}   (nothing)
> 
> These don't make sense for a union: all of its members start at offset 0,
> so there are no holes to count or pack, C doesn't allow a flexible array
> member in one. nr_holes, padding and has_flexible_array only exist in
> 'struct class', so there is nowhere to keep an answer either.

I can imagine looking for an union with bit holes:

union x86_pmu_config {
	struct {
		u64                event:8;            /*     0: 0  8 */
		u64                umask:8;            /*     0: 8  8 */
		u64                usr:1;              /*     0:16  8 */
		u64                os:1;               /*     0:17  8 */
		u64                edge:1;             /*     0:18  8 */
		u64                pc:1;               /*     0:19  8 */
		u64                interrupt:1;        /*     0:20  8 */
		u64                __reserved1:1;      /*     0:21  8 */
		u64                en:1;               /*     0:22  8 */
		u64                inv:1;              /*     0:23  8 */
		u64                cmask:8;            /*     0:24  8 */
		u64                event2:4;           /*     0:32  8 */
		u64                __reserved2:4;      /*     0:36  8 */
		u64                go:1;               /*     0:40  8 */
		u64                ho:1;               /*     0:41  8 */
	} bits;                                        /*     0     8 */
	u64                        value;              /*     0     8 */
};

The sum of that bitfield is 42 bits, so we have a "padding"/hole of 22
bits in that union, can't see quickly a use fase for this right now, but
maybe someone can have this corner case need?
 
> --with_flexible_array and --with_embedded_flexible_array were missing from the
> struct only list, so add them too.

Well spotted, please put this in a separate patch, with the
corresponding fix.

You added a fixes tag, and it is the right one, but for the segfault and
maybe some of the other cases that don't make sense (didn't look at all
of them in detail).

> Fixes: 3661f17d0b2cd56b ("pahole: Introduce --unions to consider just unions")

I have a local branch with cli fixes:

a2aea4b8ccd0fa58 (topic/cli-fixes) tests: Add compile emission and word size tests
b97f6e88676cb21e tests: Add struct packing and reorganization test
62595f6b42d3b776 tests: Add pahole --sort, word_size unions and --prettify bitfields test
1b0c903b0244cdf8 tests: Add recursive container search and union word_size tests
96380358ca13e286 tests: Add pahole --count, --skip, --structs, --contains and --first_obj_only test
ebe2ef62649bc3d9 pahole: Make --show_reorg_steps imply --reorganize
cd0420cb8108a221 pahole: Make --hex apply to --sizes and --packable output
7c7aaea07a513909 pahole: Make --skip work with all display modes
e60e8e0a48445f45 pahole: Make --count work with all display modes
0c97000781bd13c6 pahole: Make --word_size work with all display modes
9964f22ecd6429ec pahole: Fix --word_size resize to use base_type__is_word_size_dependent()
87cfa639dd40c155 dwarves: Add base_type__is_word_size_dependent() helper
acme@number:~/git/pahole$

Need to publish it on a temp branch

But yeah, we're interested in fixes, feel free to send them to the
mailing list and we'll try to provide feedback and go on merging the
ones we agree with,

Thanks!

- Arnaldo

> Signed-off-by: Aditya Dutt <duttaditya18@gmail.com>
> ---
> 
> There are a few more CLI bugs and will be sending patches for them
> soon: 'pahole -C <type> -T' segfaults etc.
> 
> Are there other things related to pahole I can contribute to? I would
> also like to help with the Rust support if there is something useful I
> can pick up.
> 
>  pahole.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/pahole.c b/pahole.c
> index a1b3d4a..c7daa31 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -462,6 +462,11 @@ static void class_formatter(struct class *class, struct cu *cu, uint32_t id)
>  static void print_packable_info(struct class *c, struct cu *cu, uint32_t id)
>  {
>  	const struct tag *t = class__tag(c);
> +
> +	/* unions are not packable */
> +	if (!tag__is_struct(t))
> +		return;
> +
>  	const size_t orig_size = class__size(c);
>  	const size_t new_size = class__size(c->priv);
>  	const size_t savings = orig_size - new_size;
> @@ -716,12 +721,6 @@ static struct class *class__filter(struct class *class, struct cu *cu,
>  	     strncmp(decl_exclude_prefix, tag__decl_file(tag, cu),
>  		     decl_exclude_prefix_len) == 0))
>  		return NULL;
> -	/*
> -	 * if --unions was used and we got here, its a union and we satisfy the other
> -	 * filters/options, so don't filter it.
> -	 */
> -	if (just_unions)
> -		return class;
>  	/*
>  	 * The following only make sense for structs, i.e. 'struct class',
>  	 * and as we can get here with a union, that is represented by a 'struct type',
> @@ -730,7 +729,8 @@ static struct class *class__filter(struct class *class, struct cu *cu,
>  	 */
>  	if (!tag__is_struct(tag))
>  		return (just_structs || show_packable || nr_holes || nr_bit_holes || hole_size_ge ||
> -			end_padding_ge || end_padding) ? NULL : class;
> +			end_padding_ge || end_padding || show_with_flexible_array ||
> +			show_with_embedded_flexible_array) ? NULL : class;
>  
>  	if (tag->top_level)
>  		class__find_holes(class);
> -- 
> 2.34.1
