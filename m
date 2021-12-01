Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2EFC433F5
	for <linux-dwarves@archiver.kernel.org>; Wed,  1 Dec 2021 12:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349151AbhLAMFW (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 1 Dec 2021 07:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349144AbhLAMFU (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 1 Dec 2021 07:05:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1D8C061757
        for <dwarves@vger.kernel.org>; Wed,  1 Dec 2021 04:01:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A739B81E5C
        for <dwarves@vger.kernel.org>; Wed,  1 Dec 2021 12:01:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96088C53FAD;
        Wed,  1 Dec 2021 12:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638360116;
        bh=ZosA8oZeCYVdHvSmITrPnKwFURTbf8DlLqP7RFAL3G8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M1X3yflsKeWJMDL597QwS6cnOn9hWyqMLvWO6dIzlnXPIYDEVTZgl0iqMlbRpzQV2
         BKWvbgfARTzYuZkX2qH5wEjgQhVrt/IHe2D33CvZlKfSeCvlIxBXc6HlC+0pB0MD5B
         vMqs7l4j+pANbT4U5EcLK3EZOO4/xR1IVLIfiFccrucqeNCscoyOQwwSaa3UxKXIRq
         cdDdQtyOeBEJPDKP5jV/J+hn6GxRbLO3PfjKepZUL+tshnoRAliPMYuKZj7NuA/QI1
         ZnJiAA8Dni7oo1S+00X0Lu9LRigOGZJKUJRLuhchs/aL1esRN6g4SVT/G7tlpEBerM
         6gmn4Dbg9LIUQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 72CE840002; Wed,  1 Dec 2021 09:01:54 -0300 (-03)
Date:   Wed, 1 Dec 2021 09:01:54 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Douglas Raillard <douglas.raillard@arm.com>
Cc:     acme@redhat.com, dwarves@vger.kernel.org
Subject: Re: [PATCH v1 1/2] fprintf: Allow making struct/enum/union anonymous
Message-ID: <YadkMiLdLNXM6yYr@kernel.org>
References: <20211019100724.325570-1-douglas.raillard@arm.com>
 <20211019100724.325570-2-douglas.raillard@arm.com>
 <YaEnHVi+i8mx54BB@kernel.org>
 <cd9cfb2d-fc6c-9143-54da-8a29bc508e40@arm.com>
 <YaZyKlkMM1+ygLNq@kernel.org>
 <ebeb30bb-49ff-81dd-9182-9c0ded7df07f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebeb30bb-49ff-81dd-9182-9c0ded7df07f@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Wed, Dec 01, 2021 at 10:56:49AM +0000, Douglas Raillard escreveu:
> On 11/30/21 6:49 PM, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Nov 30, 2021 at 04:42:55PM +0000, Douglas Raillard escreveu:
> > > On 11/26/21 6:27 PM, Arnaldo Carvalho de Melo wrote:
> > > > Em Tue, Oct 19, 2021 at 11:07:23AM +0100, Douglas RAILLARD escreveu:
> > > 2. I just found a case that generates a broken header:

> > > 	struct /* hrtimer */ {
> > > 		struct /* timerqueue_node */ {
> > > 			struct /* rb_node */ {
> > > 				long unsigned int __rb_parent_color;                     /*  3328     8 */
> > > 				struct rb_node * rb_right;                               /*  3336     8 */
> > > 				struct rb_node * rb_left;                                /*  3344     8 */
> > > 			}node; /*  3328    24 */
> > > 			/* typedef ktime_t -> s64 -> __s64 */ long long int expires;     /*  3352     8 */
> > > 		}node; /*  3328    32 */
> > > 		/* typedef ktime_t -> s64 -> __s64 */ long long int      _softexpires;   /*  3360     8 */
> > > 		enum hrtimer_restart (*function)(struct hrtimer *);                      /*  3368     8 */
> > > 		struct hrtimer_clock_base * base;                                        /*  3376     8 */
> > > 		/* typedef u8 -> __u8 */ unsigned char      state;                       /*  3384     1 */
> > > 		/* typedef u8 -> __u8 */ unsigned char      is_rel;                      /*  3385     1 */
> > > 		/* typedef u8 -> __u8 */ unsigned char      is_soft;                     /*  3386     1 */
> > > 		/* typedef u8 -> __u8 */ unsigned char      is_hard;                     /*  3387     1 */
> > > 	}hrtick_timer; /*  3328    64 */

> > > Here we can see that "struct rb_node" is a recursive type, so since the type
> > > definition is now anonymous it will not compile. Detecting recursive types and
> > > printing the name would avoid that but defeats the original purpose
> > > of --inner_anonymous.

> > > I can see two solutions:

> > > 1. Detecting recursive types and appending a user-defined prefix to create a
> > >     unique name.
> > > 2. Detecting recursive types and replacing the recursive references by "void *".
> > > Solution #2 is the least invasive but will require a bit more work for the
> > > end-user of the header:
> > > 
> > >   struct hrtimer foo = *ptr;
> > >   typeof(foo.node.node) node = foo.node.node;
> > >   // Extra cast using typeof in order to change the type of tb_right from void*
> > >   // to "struct rb_node*"
> > >   ((typeof(node))node.rb_right)->rb_left

> > A third solution and probably the easiest to implement. If you don't
> > punch a hole on it:

> > Track if the struct is being printed the first time and then flip a bit
> > not to print it again?

> > $ cat inner_anon.c
> > struct foo {
> > 	struct baz {
> > 		struct rb_node {
> > 			struct rb_node *prev, *next;
> > 		} yy;
> > 	} y;
> > 	struct /* rb_node */ {
> > 		struct rb_node *prev, *next;
> > 	} x;
> > } i;
> > $ cc  -c  inner_anon.c   -o inner_anon.o
> > $ vim inner_anon.c
> > $ cat inner_anon.c
> > struct foo {
> > 	struct rb_node {
> > 		struct rb_node *prev, *next;
> > 	} x;
> > 	struct baz {
> > 		struct /* rb_node */ {
> > 			struct rb_node *prev, *next;
> > 		} yy;
> > 	} y;
> > } i;
> > $ cc  -c  inner_anon.c   -o inner_anon.o
> > $
 
> "struct baz" and "struct foo" could very well be private and needing pahole to be exposed,
> but "struct rb_node" could be already exposed in a public header necessary for e.g. macros,
> leading to a name clash. It's quite frustrating that the language leaves you with nothing
> to deal with that sort of issues, C++ at least gives the options of namespaces and does
> proper scoping for nested type definitions, but it's unfortunately not an option for kernel modules ...

> Another alternative is to just manually "namespace" all the definitions with a user-given prefix
> (not just for the recursive types).

Yeah, that namespacing can be an optional argument to --inner_anon, then
having what I suggested + the namespace prefix we can get closer to what
we want?

- Arnaldo
