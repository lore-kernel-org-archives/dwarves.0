Return-Path: <dwarves-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BFFC61DA3
	for <linux-dwarves@archiver.kernel.org>; Sat,  4 Mar 2023 02:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjCDCOC (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 3 Mar 2023 21:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCDCOC (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Fri, 3 Mar 2023 21:14:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8F0E052
        for <dwarves@vger.kernel.org>; Fri,  3 Mar 2023 18:14:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C509618CB
        for <dwarves@vger.kernel.org>; Sat,  4 Mar 2023 02:14:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67B0C433EF;
        Sat,  4 Mar 2023 02:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677896039;
        bh=k4jDNwsbolpm8D7ILaVQxjvmM/270Ysx6C4B5I8wQg4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WUYamMbKrrqJP3Ua0DUEDHvjwnwYxqnL+UNiey8+XnAW5TygrypK8lKDqdunrmUry
         kwh9JND76qVgbn+S5AaIBaN7aEVJV7e1yS5epe+aKv5WvSj0leOns+vbCjqqZAywXX
         KMHOzslZ0WUiOa8XwlMBFwAmb+Td0AaOspDkWa+IiLLH8Tv8PqawK+5PwOvF6co/7V
         mrd+n4wWMImhjRwFaeYth3vN2c01H0yKa1XDxTn6fAZpT80x6z5PtS/TtDGyVBF7B4
         9txnimkDxu0wNn3I37QG9+7PQWNZGv0GDF7KD5s8OSGHo75FWu/5y0k4ilvS1+A1U7
         15XqkXBHo5pOA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EE5554049F; Fri,  3 Mar 2023 23:13:56 -0300 (-03)
Date:   Fri, 3 Mar 2023 23:13:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org
Subject: Re: [question] dwarves/pahole testing
Message-ID: <ZAKpZGSHTvsS4r8E@kernel.org>
References: <92b71fbfc8d768103d533d3b0edded0bd6750b0f.camel@gmail.com>
 <Y/5jGjgCdQpUe1Ak@kernel.org>
 <62cd4979a4080f3529f1bdf61639c6feb490af01.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62cd4979a4080f3529f1bdf61639c6feb490af01.camel@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Sat, Mar 04, 2023 at 03:31:16AM +0200, Eduard Zingerman escreveu:
> On Tue, 2023-02-28 at 17:24 -0300, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Feb 23, 2023 at 10:47:55PM +0200, Eduard Zingerman escreveu:
> > > Hello Dwarves community,
> > > 
> > > I have a set of changes that add support for "btf_type_tag" attached to the
> > > hosting type, as discussed in [1]. I'd like to test these changes before
> > > submitting via this mailing list. I have some local tests for the feature
> > > itself and I checked that kernel build / BPF selftests work as expected.
> > > Are there any additional tests I can run?
> > > Maybe some manual testing procedures?
> > 
> > You may want to test using 'btfdiff vmlinux' after encoding BTF from
> > DWARF.
> 
> Hi Arnaldo,
> 
> Thank you for the recommendation.
> 
> I've noticed that with my config this method might get a bit
> non-deterministic because of the following two data structures:
> 
> drivers/net/ethernet/intel/e1000/e1000_param.c:
> struct e1000_option {
>     ...
>     union {
>         ...
>         struct {
>             int nr;
>             const struct e1000_opt_list { int i; char *str; } *p;
>             ^^^^^
>                  this const is not present below
>         } l;
>     } arg;
> };
> 
> drivers/net/ethernet/intel/e1000e/param.c:
> struct e1000_option {
>     ...
>     union {
>         ...
>         struct {
>             int nr;
>             struct e1000_opt_list { int i; char *str; } *p;
>         } l;
>     } arg;
> };
> 
> Both are present in the BTF.

Ok, and you are linking those two drivers statically, so it gets into
vmlinux, which is something I had never tried.
 
> As far as I understand, which one would be picked by
> "pahole -F btf --sort" depends on exact order of types in the BTF,
> because:
> - `pahole.c:type__compare_members_types()` does not compare fields for
>   inline structures;
> - `pahole.c:type__compare_members_types()` ignores qualifiers;
> - hence, `pahole.c:resort_add()` considers these types identical.
> 
> I can try to modify the comparison function to address both points
> and thus generate both versions of the `struct e1000_option` in the output.
> Is it worth doing?

I think so, comparing what we get from DWARF with what we get from BTF
showed to be useful so far, even with some insurmountable differences,
those options in btfdiff to change the output.

- Arnaldo
