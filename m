Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE89C433EF
	for <linux-dwarves@archiver.kernel.org>; Tue, 30 Nov 2021 18:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245594AbhK3SxG (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 30 Nov 2021 13:53:06 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51476 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235202AbhK3Swj (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 30 Nov 2021 13:52:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 209C5B818F9
        for <dwarves@vger.kernel.org>; Tue, 30 Nov 2021 18:49:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 813F6C53FCF;
        Tue, 30 Nov 2021 18:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638298157;
        bh=kMjqtxUyBbxEQ+0wvMptsTwqRnsP2mXYuDP70alMHbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kGWpJZ8k4sZ7dyiXevF3m13MINzOuc/Ur230K01vF5GemaUX2fQHOX+VH/5833lGe
         JhWkW8gXPqz6uWbcgRpH3HENldgoBj+zvq3+Io9HIQM+EiaWF/jCtJ8UhBZoPdXhgy
         c4LEOvCR4bmOgxR34loIim0VMcSFw3rYQUSb0NChQ4bxzpEjSjqmqJSzTjec+3BaDU
         pWO2r1YgSjWpQX3UOaODoqva2gfSSQwFHnILa6YhxDXOaEFKR8XhJ9gJ+9dGNE7NvT
         iEalTUuycImlGe1O7E2YxKMeRFJHkG6gmVP9Na3XCCm8VWaVsbVbtZ5FjBZ3xMzInQ
         AX/EXWCKXnveg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 66C2A40002; Tue, 30 Nov 2021 15:49:14 -0300 (-03)
Date:   Tue, 30 Nov 2021 15:49:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Douglas Raillard <douglas.raillard@arm.com>
Cc:     acme@redhat.com, dwarves@vger.kernel.org
Subject: Re: [PATCH v1 1/2] fprintf: Allow making struct/enum/union anonymous
Message-ID: <YaZyKlkMM1+ygLNq@kernel.org>
References: <20211019100724.325570-1-douglas.raillard@arm.com>
 <20211019100724.325570-2-douglas.raillard@arm.com>
 <YaEnHVi+i8mx54BB@kernel.org>
 <cd9cfb2d-fc6c-9143-54da-8a29bc508e40@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd9cfb2d-fc6c-9143-54da-8a29bc508e40@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Tue, Nov 30, 2021 at 04:42:55PM +0000, Douglas Raillard escreveu:
> On 11/26/21 6:27 PM, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Oct 19, 2021 at 11:07:23AM +0100, Douglas RAILLARD escreveu:
> > > From: Douglas Raillard <douglas.raillard@arm.com>
> > > 
> > > Allow making inner struct enums and union anonymous.
> > 
> > So I had to apply it by hand due to changes in the areas it touches, see
> > below, and I expanded a bit the commit message, please review:
> 
> Thanks for the review, it seems to be working as well as before. That said I found a couple of issues:
> 
> 1. CLI options seem to abbreviate "anonymous" into "anon" so maybe we should do the same for this one ?

Ok, I can shorten the option name here.

> 2. I just found a case that generates a broken header:
> 
> 	struct /* hrtimer */ {
> 		struct /* timerqueue_node */ {
> 			struct /* rb_node */ {
> 				long unsigned int __rb_parent_color;                     /*  3328     8 */
> 				struct rb_node * rb_right;                               /*  3336     8 */
> 				struct rb_node * rb_left;                                /*  3344     8 */
> 			}node; /*  3328    24 */
> 			/* typedef ktime_t -> s64 -> __s64 */ long long int expires;     /*  3352     8 */
> 		}node; /*  3328    32 */
> 		/* typedef ktime_t -> s64 -> __s64 */ long long int      _softexpires;   /*  3360     8 */
> 		enum hrtimer_restart (*function)(struct hrtimer *);                      /*  3368     8 */
> 		struct hrtimer_clock_base * base;                                        /*  3376     8 */
> 		/* typedef u8 -> __u8 */ unsigned char      state;                       /*  3384     1 */
> 		/* typedef u8 -> __u8 */ unsigned char      is_rel;                      /*  3385     1 */
> 		/* typedef u8 -> __u8 */ unsigned char      is_soft;                     /*  3386     1 */
> 		/* typedef u8 -> __u8 */ unsigned char      is_hard;                     /*  3387     1 */
> 	}hrtick_timer; /*  3328    64 */
> 
> Here we can see that "struct rb_node" is a recursive type, so since the type
> definition is now anonymous it will not compile. Detecting recursive types and
> printing the name would avoid that but defeats the original purpose
> of --inner_anonymous.
> 
> I can see two solutions:
> 
> 1. Detecting recursive types and appending a user-defined prefix to create a
>    unique name.
> 2. Detecting recursive types and replacing the recursive references by "void *".
 
> Solution #2 is the least invasive but will require a bit more work for the
> end-user of the header:
> 
>  struct hrtimer foo = *ptr;
>  typeof(foo.node.node) node = foo.node.node;
 
>  // Extra cast using typeof in order to change the type of tb_right from void*
>  // to "struct rb_node*"
>  ((typeof(node))node.rb_right)->rb_left

A third solution and probably the easiest to implement. If you don't
punch a hole on it:

Track if the struct is being printed the first time and then flip a bit
not to print it again?

$ cat inner_anon.c
struct foo {
	struct baz {
		struct rb_node {
			struct rb_node *prev, *next;
		} yy;
	} y;
	struct /* rb_node */ {
		struct rb_node *prev, *next;
	} x;
} i;
$ cc  -c  inner_anon.c   -o inner_anon.o
$ vim inner_anon.c
$ cat inner_anon.c
struct foo {
	struct rb_node {
		struct rb_node *prev, *next;
	} x;
	struct baz {
		struct /* rb_node */ {
			struct rb_node *prev, *next;
		} yy;
	} y;
} i;
$ cc  -c  inner_anon.c   -o inner_anon.o
$
