Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B616B23D2
	for <dwarves@vger.kernel.org>; Mon, 30 Sep 2024 14:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727706777; cv=none; b=b1qfjMTTYqr7kwoJS/KAZtT67VL19+JY9m6MnIPbwQBsrlTuTgUV8nk/+K3bdPbQomRHx4gceIdkyKwXab+Wjan/eTAtDYMIQT7rnrjzyd2Tl/R5GPpzg0dUgDJ5p0afvO2gJGPgJQTG6cs989FSnzeVaePFkOMi/zfjwkfFD9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727706777; c=relaxed/simple;
	bh=bvFZZKKu4sgKaBQINE58O6rOd8TJ18pNPQJdm0xH3HA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5hK6gSScXSSXpa+Y+2lBOoofkze3I4Mjrsi+9sjMaVqkJHYHuiPXVsQF3GcRZFpAEI8Z1jtQROrqCUapIQqmanbfOBjeaGv9vM7kCPhZ5OuwTzenx8GERRT4mfNOPY6I819I0NeXxzlgpqQ55SXvu6tgWAXfznhpZIUB5YqQsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SyL2Fq5W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SyL2Fq5W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F16CDC4CEC7;
	Mon, 30 Sep 2024 14:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727706777;
	bh=bvFZZKKu4sgKaBQINE58O6rOd8TJ18pNPQJdm0xH3HA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SyL2Fq5WZh/1pjAhFzrqpJxjcHSq+O+rQUScqTwA1BzzcONh1JK8G3XMnEZ4YYQmT
	 I9lH3Uo11LCmL3+hnhWB911851WbpAVP+pIx/50zgIIxfosehYZAa+t+RMnEInkXgw
	 vZK+cl98teW3nU6sCsSvuwr7Dl0AmTMUnieiWEhmag0LcG2qTDffAvls+iEo+9gWgO
	 xJ2pG3cXK2Twe0tOSPBXxn7bORCYUJjYgyLBRa9W6GeqLRTXBaULqI0Bb2+kV0TMBx
	 EKbjc4hiwEH/sKU0ZR3sw6RCLiqQ1yDXtJSSGAsWDzdV9KzvMi89oXnllKSKChkh7A
	 B4nvpi8LudYpw==
Date: Mon, 30 Sep 2024 11:32:54 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Willy Tarreau <w@1wt.eu>
Cc: dwarves@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH 0/2] --padding option to combine with
 --with_flexible_array
Message-ID: <Zvq2lrZh3BP9uCC9@x1>
References: <20240927185958.37310-1-acme@kernel.org>
 <20240927211503.GA4031@1wt.eu>
 <20240928043638.GA4774@1wt.eu>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240928043638.GA4774@1wt.eu>

On Sat, Sep 28, 2024 at 06:36:38AM +0200, Willy Tarreau wrote:
> On Fri, Sep 27, 2024 at 11:15:03PM +0200, Willy Tarreau wrote:
> > Hi Arnaldo!
> > 
> > On Fri, Sep 27, 2024 at 03:59:56PM -0300, Arnaldo Carvalho de Melo wrote:
> > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > 
> > > Hi,
> > > 
> > > 	This implements --padding, that combined with the already
> > > available --with_flexible_array option may catch some questionable
> > > structs.
> > > 
> > > 	This comes from a quick discussion I had with Willy Tareau after
> > > Gustavo's talk at this year's Kernel Recipes.
> > > 
> > > 	I have this in the 'next' branch of:
> > > 
> > > https://git.kernel.org/pub/scm/devel/pahole/pahole.git
> > > 
> > > 	Willy, is that what you had in mind?
> > 
> > Oh that was fast!
> > 
> > I'm looking at the output here:
> > 
> >    http://oldvger.kernel.org/~acme/pahole--padding_ge_1_--with_flexible_array.6.10.10-200.fc40.x86_64.txt
> > 
> > I'm seeing in the output above that mem_cgroup was reported due to 48
> > bytes padding being caused by extra alignment. I'm not sure what to
> > think about it to be honest, there could be pros and cons. However it's
> > true that if this struct is embedded inside another one, it starts to
> > smell nevertheless, and such a case is not much frequent so it should
> > be a low rate of false positives in the worst case.

Indeed, looking for structs with a flexible array that have padding
_and_ is embedded in another one looks something we should output when
asking for --with_flexible_array and --padding.

We already have "previous struct has padding", but we only see it with
--with_flexible_array and --padding right now if the struct that has it
embedded also has a flexible array _and_ padding.

Maybe we need both --embedded_flexible_array and --embedded_padding for
ultimate flexibility?

I.e. all of --with_flexible_array, --padding, --embedded_flexible_array
and --embedded_padding have value even when asked for individually, I'd
wager.

> > The output is clearly reviewable by hand, that's really cool!
> 
> So I tried it on haproxy. The first good news is that it didn't spot
> anything, indicating that it doesn't seem to trigger false-positives
> (the second good news being that I don't have to fix anything there :-)).
> 
> For example I have such a struct that contains a forced alignment hole
> before the flex array and it rightfully didn't catch it:
> 
>   struct ebmb_node {
>         struct eb_node             node;                 /*     0    36 */
> 
>         /* XXX 4 bytes hole, try to pack */
> 
>         union {
>         } __attribute__((__aligned__(8)));               /*    40     0 */
>         unsigned char              key[];                /*    40     0 */
> 
>         /* size: 40, cachelines: 1, members: 3 */
>         /* sum members: 36, holes: 1, sum holes: 4 */
>         /* forced alignments: 1, forced holes: 1, sum forced holes: 4 */
>         /* last cacheline: 40 bytes */
>   } __attribute__((__aligned__(8)));
> 
> But it correctly spots this one that we imagined during our discussion:
> 
>   struct foo {
>         void *                     ptr;                  /*     0     8 */
>         int                        number;               /*     8     4 */
>         char                       array[];              /*    12     0 */
> 
>         /* size: 16, cachelines: 1, members: 3 */
>         /* padding: 4 */
>         /* last cacheline: 16 bytes */
>   };
> 
> So that looks all good to me!

great!
 
> BTW, while building the -next branch (ubuntu 22 arm64 gcc11.4), I faced
> this warning that you might be interested in, and that didn't appear in
> the master branch:
> 
>   In file included from /usr/include/string.h:535,
>                    from /usr/include/obstack.h:136,
>                    from /home/willy/pahole/dwarves.h:13,
>                    from /home/willy/pahole/btf_encoder.c:13:
>   In function strncpy,
>       inlined from btf_encoder__add_func_proto at /home/willy/pahole/btf_encoder.c:749:4:
>   /usr/include/aarch64-linux-gnu/bits/string_fortified.h:95:10: warning: __builtin_strncpy specified bound 128 equals destination size [-Wstringop-truncation]
>      95 |   return __builtin___strncpy_chk (__dest, __src, __len,
>         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      96 |                                   __glibc_objsize (__dest));
>         |                                   ~~~~~~~~~~~~~~~~~~~~~~~~~
>   In function strncpy,
>       inlined from btf_encoder__add_func at /home/willy/pahole/btf_encoder.c:1172:4:
>   /usr/include/aarch64-linux-gnu/bits/string_fortified.h:95:10: warning: __builtin_strncpy specified bound 128 equals destination size [-Wstringop-truncation]
>      95 |   return __builtin___strncpy_chk (__dest, __src, __len,
>         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      96 |                                   __glibc_objsize (__dest));
>         |                                   ~~~~~~~~~~~~~~~~~~~~~~~~~

I think Eduard Zingerman has fixed this and that patch is in a series
from Alan Maguire, I'll try and process those patches now.

> Do not hesitate to ask me for some tests if needed. I can also bisect
> if needed.

Sure
