Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF55C433EF
	for <linux-dwarves@archiver.kernel.org>; Mon,  6 Dec 2021 20:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349721AbhLFUg0 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 6 Dec 2021 15:36:26 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57050 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbhLFUg0 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 6 Dec 2021 15:36:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A428EB81244
        for <dwarves@vger.kernel.org>; Mon,  6 Dec 2021 20:32:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5A6C341C2;
        Mon,  6 Dec 2021 20:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638822775;
        bh=DPo5i+0n48DLzsXLP4CJWx6NXIft0WhXgu2tsAOHGFA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=joRKmOagWrnP6Cojfu6ZY+1PnjUvQsAERAHZhGtMgWMEkY8ePKTkgTeGgSh1RaZHE
         LtBAtC5VCEfYNqwCFpEChnIsg31yAjZl+fy/zCFwDf8/jkq2FQxV9eiv/S1yGOj/Cu
         QcY1P5JynV/zBGVOoCtldKgfcaXhnMUM9KSWPH80Ptx/LQr+NtgvclpylWR/7e7sHW
         Uf7CqvqeUUSG115ZOOne+AatLtQJ3vAwrVw0Yi2wekSOyMIno+FKfGUc01rxOyrfkm
         1XB1TJXPwyeitFTwBHLZzESbIe42LRUo5DzsScT2FvF8CIF8yv3lX1xoVoYreA2XNh
         bJld2+AyXQbew==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 74D2C40002; Mon,  6 Dec 2021 17:32:52 -0300 (-03)
Date:   Mon, 6 Dec 2021 17:32:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Douglas Raillard <douglas.raillard@arm.com>
Cc:     acme@redhat.com, dwarves@vger.kernel.org
Subject: Re: [PATCH v1 1/2] fprintf: Allow making struct/enum/union anonymous
Message-ID: <Ya5zdL9WH6GRjS3x@kernel.org>
References: <20211019100724.325570-1-douglas.raillard@arm.com>
 <20211019100724.325570-2-douglas.raillard@arm.com>
 <YaEnHVi+i8mx54BB@kernel.org>
 <cd9cfb2d-fc6c-9143-54da-8a29bc508e40@arm.com>
 <YaZyKlkMM1+ygLNq@kernel.org>
 <ebeb30bb-49ff-81dd-9182-9c0ded7df07f@arm.com>
 <YadkMiLdLNXM6yYr@kernel.org>
 <df597828-5e15-a8ed-e5d5-2248ef3f8dfa@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df597828-5e15-a8ed-e5d5-2248ef3f8dfa@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Mon, Dec 06, 2021 at 10:28:10AM +0000, Douglas Raillard escreveu:
> On 12/1/21 12:01 PM, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Dec 01, 2021 at 10:56:49AM +0000, Douglas Raillard escreveu:
> > > On 11/30/21 6:49 PM, Arnaldo Carvalho de Melo wrote:
> > > > Em Tue, Nov 30, 2021 at 04:42:55PM +0000, Douglas Raillard escreveu:
> > > > > On 11/26/21 6:27 PM, Arnaldo Carvalho de Melo wrote:
> > > > > > Em Tue, Oct 19, 2021 at 11:07:23AM +0100, Douglas RAILLARD escreveu:
> > > > > 2. I just found a case that generates a broken header:
> > 
> > > > > 	struct /* hrtimer */ {
> > > > > 		struct /* timerqueue_node */ {
> > > > > 			struct /* rb_node */ {
> > > > > 				long unsigned int __rb_parent_color;                     /*  3328     8 */
> > > > > 				struct rb_node * rb_right;                               /*  3336     8 */
> > > > > 				struct rb_node * rb_left;                                /*  3344     8 */
> > > > > 			}node; /*  3328    24 */
> > > > > 			/* typedef ktime_t -> s64 -> __s64 */ long long int expires;     /*  3352     8 */
> > > > > 		}node; /*  3328    32 */
> > > > > 		/* typedef ktime_t -> s64 -> __s64 */ long long int      _softexpires;   /*  3360     8 */
> > > > > 		enum hrtimer_restart (*function)(struct hrtimer *);                      /*  3368     8 */
> > > > > 		struct hrtimer_clock_base * base;                                        /*  3376     8 */
> > > > > 		/* typedef u8 -> __u8 */ unsigned char      state;                       /*  3384     1 */
> > > > > 		/* typedef u8 -> __u8 */ unsigned char      is_rel;                      /*  3385     1 */
> > > > > 		/* typedef u8 -> __u8 */ unsigned char      is_soft;                     /*  3386     1 */
> > > > > 		/* typedef u8 -> __u8 */ unsigned char      is_hard;                     /*  3387     1 */
> > > > > 	}hrtick_timer; /*  3328    64 */
> > 
> > > > > Here we can see that "struct rb_node" is a recursive type, so since the type
> > > > > definition is now anonymous it will not compile. Detecting recursive types and
> > > > > printing the name would avoid that but defeats the original purpose
> > > > > of --inner_anonymous.
> > 
> > > > > I can see two solutions:
> > 
> > > > > 1. Detecting recursive types and appending a user-defined prefix to create a
> > > > >      unique name.
> > > > > 2. Detecting recursive types and replacing the recursive references by "void *".
> > > > > Solution #2 is the least invasive but will require a bit more work for the
> > > > > end-user of the header:
> > > > > 
> > > > >    struct hrtimer foo = *ptr;
> > > > >    typeof(foo.node.node) node = foo.node.node;
> > > > >    // Extra cast using typeof in order to change the type of tb_right from void*
> > > > >    // to "struct rb_node*"
> > > > >    ((typeof(node))node.rb_right)->rb_left
> > 
> > > > A third solution and probably the easiest to implement. If you don't
> > > > punch a hole on it:
> > 
> > > > Track if the struct is being printed the first time and then flip a bit
> > > > not to print it again?
> > 
> > > > $ cat inner_anon.c
> > > > struct foo {
> > > > 	struct baz {
> > > > 		struct rb_node {
> > > > 			struct rb_node *prev, *next;
> > > > 		} yy;
> > > > 	} y;
> > > > 	struct /* rb_node */ {
> > > > 		struct rb_node *prev, *next;
> > > > 	} x;
> > > > } i;
> > > > $ cc  -c  inner_anon.c   -o inner_anon.o
> > > > $ vim inner_anon.c
> > > > $ cat inner_anon.c
> > > > struct foo {
> > > > 	struct rb_node {
> > > > 		struct rb_node *prev, *next;
> > > > 	} x;
> > > > 	struct baz {
> > > > 		struct /* rb_node */ {
> > > > 			struct rb_node *prev, *next;
> > > > 		} yy;
> > > > 	} y;
> > > > } i;
> > > > $ cc  -c  inner_anon.c   -o inner_anon.o
> > > > $
> > > "struct baz" and "struct foo" could very well be private and needing pahole to be exposed,
> > > but "struct rb_node" could be already exposed in a public header necessary for e.g. macros,
> > > leading to a name clash. It's quite frustrating that the language leaves you with nothing
> > > to deal with that sort of issues, C++ at least gives the options of namespaces and does
> > > proper scoping for nested type definitions, but it's unfortunately not an option for kernel modules ...
> > 
> > > Another alternative is to just manually "namespace" all the definitions with a user-given prefix
> > > (not just for the recursive types).
> > 
> > Yeah, that namespacing can be an optional argument to --inner_anon, then
> > having what I suggested + the namespace prefix we can get closer to what
> > we want?
> 
> Yes I'll try to make a new version based on that:
> * print only the first time it's encountered
> * add option to prefix types for namespacing
> * add an option to add typedef for original name for the types that were
>   specified explicitly (or maybe simply do not apply the namespace on them)
> 
> This should fix the recursive type issue and allow using explicitly given types directly.

Great, looking forward to the patch,

Cheers,

- Arnaldo
