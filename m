Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345A0C433F5
	for <linux-dwarves@archiver.kernel.org>; Thu, 28 Oct 2021 11:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1722460249
	for <linux-dwarves@archiver.kernel.org>; Thu, 28 Oct 2021 11:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhJ1Lkj (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 28 Oct 2021 07:40:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:38112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229578AbhJ1Lke (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Thu, 28 Oct 2021 07:40:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17DC860249;
        Thu, 28 Oct 2021 11:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635421087;
        bh=Usoq0YUC7gQ8oyxf96/OZIgRIkCq0OT1Q+iRIkXYr6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dltn01ZCs8QiC1GsK47QyDoisO/Eg30PGyrti9ByIioFYbVKOrPuEJzgyus2cKGij
         JsHBV0MwUqebYbbg/jbIXP1yk7Yz6MGcftqfQdbMKwqUCUb7vWxShNnOeNM+Rnq0Li
         upHBbAqgbQP4sEkIMvFj2i2SZ4ayTbAlN+mIvZaT/QJ7UNnFAt0nDxCIp5NJKQo5n+
         nIfO5laz3XL7MHs8afk60NXILcdXCCZtYMwahEXqLrQ2RTx1pLY0uZokSuUBkEZqlk
         MC8TLb4TxcmWcX2TZBA4lsfKtDXCmqvOCdoSh9wknSD5urXxx6SKTcHBh4wPi0AIFP
         1hAFtEriF7oxQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A9C5B410A1; Thu, 28 Oct 2021 08:38:03 -0300 (-03)
Date:   Thu, 28 Oct 2021 08:38:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Douglas Raillard <douglas.raillard@arm.com>
Cc:     acme@redhat.com, dwarves@vger.kernel.org
Subject: Re: [PATCH v2 3/3] btf_loader.c: Infer alignment info
Message-ID: <YXqLm3D2KWhgpVE8@kernel.org>
References: <20211018131621.212628-1-douglas.raillard@arm.com>
 <20211018131621.212628-4-douglas.raillard@arm.com>
 <YXIGaA1SYSx37EEV@kernel.org>
 <YXbj+gukL1fZx/Gb@kernel.org>
 <550aad99-12b3-c594-9fb4-354b62cbaa5b@arm.com>
 <YXm69PIYcYckUVzP@kernel.org>
 <985d273b-9c3e-0c5c-bf86-e73b8d2f6007@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <985d273b-9c3e-0c5c-bf86-e73b8d2f6007@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Thu, Oct 28, 2021 at 10:31:33AM +0100, Douglas Raillard escreveu:
> On 10/27/21 9:47 PM, Arnaldo Carvalho de Melo wrote:
> > So, what is now in the 'next' branch (an alias for the tmp.master branch
> > that is tested in the libbpf CI) produces:

> >    --- /tmp/btfdiff.dwarf.8098nf   2021-10-27 17:29:02.788601053 -0300
> >    +++ /tmp/btfdiff.btf.eTagYI     2021-10-27 17:29:02.994606515 -0300
> >    @@ -107,7 +107,7 @@ struct Qdisc {
> >            /* XXX 24 bytes hole, try to pack */
> >            /* --- cacheline 2 boundary (128 bytes) --- */
> >    -       struct sk_buff_head        gso_skb __attribute__((__aligned__(64))); /*   128    24 */
> >    +       struct sk_buff_head        gso_skb __attribute__((__aligned__(32))); /*   128    24 */
> >            struct qdisc_skb_head      q;                    /*   152    24 */
> >            struct gnet_stats_basic_packed bstats;           /*   176    16 */
> >            /* --- cacheline 3 boundary (192 bytes) --- */
> > The one above is a bit difficult to solve, perhaps we can use an
> > heuristic for kernel files and assume this is dependend on the
> > typical cacheline sizes? As it in the kernel sources is:

> >            struct sk_buff_head     gso_skb ____cacheline_aligned_in_smp;

> > I.e. if it is a multiple of both 64, then we use it instead of 32?
> >    @@ -117,18 +117,18 @@ struct Qdisc {
> >            struct Qdisc *             next_sched;           /*   224     8 */
> >            struct sk_buff_head        skb_bad_txq;          /*   232    24 */
> >            /* --- cacheline 4 boundary (256 bytes) --- */
> >    -       spinlock_t                 busylock __attribute__((__aligned__(64))); /*   256     4 */
> >    +       spinlock_t                 busylock;             /*   256     4 */

> > Originally:

> >          spinlock_t              busylock ____cacheline_aligned_in_smp;

> Sounds like a good idea, I can't think of another reason for large alignments anyway.
> Larger power of 2 alignments are harmless anyway so we might as well try to guess.
> I'll prepare a v3 with that update.

Cool
 
> > But since it is already naturally aligned (232 + 24 = 256), we can't
> > infer it from what BTF carries.

> >            spinlock_t                 seqlock;              /*   260     4 */
> >    -       struct callback_head       rcu __attribute__((__aligned__(8))); /*   264    16 */
> >    +       struct callback_head       rcu;                  /*   264    16 */

> > Ditto
> >            /* XXX 40 bytes hole, try to pack */
> >            /* --- cacheline 5 boundary (320 bytes) --- */
> >    -       long int                   privdata[] __attribute__((__aligned__(64))); /*   320     0 */
> >    +       long int                   privdata[];           /*   320     0 */

> > But this one should've been inferred, right?

> Assuming you talk about offset 320 aligned on 64, we cannot infer a specific alignment since
> 5 * 64 = 320.

I mean this line:

            /* XXX 40 bytes hole, try to pack */

I.e. without an explicit __attribute__((__aligned__(64))) it wouldn't be
at 320, but at 280:

$ cat no_forced_alignment.c
struct foo {
	char	 rcu[264 + 16];
	long int privdata[];
} bar;
$ gcc -g -c no_forced_alignment.c
$ pahole no_forced_alignment.o
struct foo {
	char                       rcu[280];             /*     0   280 */
	/* --- cacheline 4 boundary (256 bytes) was 24 bytes ago --- */
	long int                   privdata[];           /*   280     0 */

	/* size: 280, cachelines: 5, members: 2 */
	/* last cacheline: 24 bytes */
};
$

Its only when we explicitely add the __attribute__((__aligned__(64)))
that we get that hole:

$ cat forced_alignment.c
struct foo {
	char	 rcu[264 + 16];
	long int privdata[] __attribute__((__aligned__(64)));
} bar;
$ gcc -g -c forced_alignment.c
$ pahole forced_alignment.o
struct foo {
	char                       rcu[280];             /*     0   280 */

	/* XXX 40 bytes hole, try to pack */

	/* --- cacheline 5 boundary (320 bytes) --- */
	long int                   privdata[] __attribute__((__aligned__(64))); /*   320     0 */

	/* size: 320, cachelines: 5, members: 2 */
	/* sum members: 280, holes: 1, sum holes: 40 */
	/* forced alignments: 1, forced holes: 1, sum forced holes: 40 */
} __attribute__((__aligned__(64)));
$

I.e. you have to look at the hole right after the previous class member
to notice that yeah, there is a forced alignment.

> If you mean the number of forced alignments, I'm not surprised that BTF finds less forced alignments,
> as each some of the technically forced alignments (in the original source) also happens to be already
> satisfied by the normal layout, so we don't infer anything special.

I meant the hole before privdata :-)

Yeah, there are some alignments that won't be detectable purely from
looking at BTF.

What I'm wanting is to reduce btfdiff output, and in this case, fix a
bug, as the BTF generated from this struct would be incorrectly aligned,
when someone would use that privdata it would get it at offset 280, not
at 320, as intended.

- Arnaldo
