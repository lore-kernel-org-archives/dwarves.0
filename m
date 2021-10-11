Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C69EC433EF
	for <linux-dwarves@archiver.kernel.org>; Mon, 11 Oct 2021 18:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D07160F4B
	for <linux-dwarves@archiver.kernel.org>; Mon, 11 Oct 2021 18:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbhJKS50 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 11 Oct 2021 14:57:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:43630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229544AbhJKS50 (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Mon, 11 Oct 2021 14:57:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C89360FD7;
        Mon, 11 Oct 2021 18:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633978525;
        bh=eGOULmUyVmsDbD+8OCWMdDc9JumAyPPfn/qU+T7iwYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WaAcNoEHcd7YIQUVgShAWKeFF+W1nn2VYNQqPsr7LS7TnNuqBHS6LGLiZljWIumLF
         BDsooZvc2vwYJUHz80mIV+5+Vit9VqNIS2bxsj5ZtvKVxyy+BFVh/kxZkDe18Hvstz
         NLLhN2KktLu3GdmSPeAmxQsNbtUXXGjlS6J0ZfsxB3ChUVZRnzIFN9WLM26Wuqc4Wc
         u/EtIuR7pM7O6DTcqbIqqM1Dk2RupxPI43qOFxipz/BKqJI6x5G8gUbuRQ4vz7ZrGK
         KSmyJLvdYpN1jtBpLtr2EdtqKN0KneLenCl4LKomY8ZYzrB7FOALVHzV3HDkuasFHf
         7KHfk2PDZN4NQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EC14E410A1; Mon, 11 Oct 2021 15:55:20 -0300 (-03)
Date:   Mon, 11 Oct 2021 15:55:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     dwarves@vger.kernel.org
Subject: Re: pahole failed to get some struct info
Message-ID: <YWSImJiz3VjD/ArG@kernel.org>
References: <9a88283d-443c-3789-b120-b2c6c56ebe55@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a88283d-443c-3789-b120-b2c6c56ebe55@linux.alibaba.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Sun, Oct 10, 2021 at 02:09:10PM +0800, Xianting Tian escreveu:
> Hi,

> Sorry to disturb you, when I use below command to get info about 'struct
> hvc_struct', it failed.

> $ pahole -C hvc_struct vmlinux
> die__process_function: tag not supported (INVALID)!
> die__process_unit: DW_TAG_dwarf_procedure (0x36) @ <0x4ebf4c> not handled!
 
> But when I try some common struct, it is OK.
 
> $ pahole -C task_struct vmlinux
 
> Could you help me how to fix the issue?  thanks a lot.

Using:

⬢[acme@toolbox v5.14.0-rc6+]$ pahole --version
v1.22

I see no problems, be it from DWARF or from BTF, in the various ways to
ask for that struct:

⬢[acme@toolbox v5.14.0-rc6+]$ pahole -C hvc_struct vmlinux
struct hvc_struct {
	struct tty_port            port;                 /*     0   352 */
	/* --- cacheline 5 boundary (320 bytes) was 32 bytes ago --- */
	spinlock_t                 lock;                 /*   352     4 */
	int                        index;                /*   356     4 */
	int                        do_wakeup;            /*   360     4 */

	/* XXX 4 bytes hole, try to pack */

	char *                     outbuf;               /*   368     8 */
	int                        outbuf_size;          /*   376     4 */
	int                        n_outbuf;             /*   380     4 */
	/* --- cacheline 6 boundary (384 bytes) --- */
	uint32_t                   vtermno;              /*   384     4 */

	/* XXX 4 bytes hole, try to pack */

	const struct hv_ops  *     ops;                  /*   392     8 */
	int                        irq_requested;        /*   400     4 */
	int                        data;                 /*   404     4 */
	struct winsize             ws;                   /*   408     8 */
	struct work_struct         tty_resize;           /*   416    32 */
	/* --- cacheline 7 boundary (448 bytes) --- */
	struct list_head           next;                 /*   448    16 */
	long unsigned int          flags;                /*   464     8 */

	/* size: 472, cachelines: 8, members: 15 */
	/* sum members: 464, holes: 2, sum holes: 8 */
	/* last cacheline: 24 bytes */
};
⬢[acme@toolbox v5.14.0-rc6+]$ pahole hvc_struct
struct hvc_struct {
	struct tty_port            port;                 /*     0   352 */
	/* --- cacheline 5 boundary (320 bytes) was 32 bytes ago --- */
	spinlock_t                 lock;                 /*   352     4 */
	int                        index;                /*   356     4 */
	int                        do_wakeup;            /*   360     4 */

	/* XXX 4 bytes hole, try to pack */

	char *                     outbuf;               /*   368     8 */
	int                        outbuf_size;          /*   376     4 */
	int                        n_outbuf;             /*   380     4 */
	/* --- cacheline 6 boundary (384 bytes) --- */
	uint32_t                   vtermno;              /*   384     4 */

	/* XXX 4 bytes hole, try to pack */

	const struct hv_ops  *     ops;                  /*   392     8 */
	int                        irq_requested;        /*   400     4 */
	int                        data;                 /*   404     4 */
	struct winsize             ws;                   /*   408     8 */
	struct work_struct         tty_resize;           /*   416    32 */
	/* --- cacheline 7 boundary (448 bytes) --- */
	struct list_head           next;                 /*   448    16 */
	long unsigned int          flags;                /*   464     8 */

	/* size: 472, cachelines: 8, members: 15 */
	/* sum members: 464, holes: 2, sum holes: 8 */
	/* last cacheline: 24 bytes */
};
⬢[acme@toolbox v5.14.0-rc6+]$

⬢[acme@toolbox v5.14.0-rc6+]$ pahole -F dwarf -C hvc_struct vmlinux
struct hvc_struct {
	struct tty_port            port;                 /*     0   352 */
	/* --- cacheline 5 boundary (320 bytes) was 32 bytes ago --- */
	spinlock_t                 lock;                 /*   352     4 */
	int                        index;                /*   356     4 */
	int                        do_wakeup;            /*   360     4 */

	/* XXX 4 bytes hole, try to pack */

	char *                     outbuf;               /*   368     8 */
	int                        outbuf_size;          /*   376     4 */
	int                        n_outbuf;             /*   380     4 */
	/* --- cacheline 6 boundary (384 bytes) --- */
	uint32_t                   vtermno;              /*   384     4 */

	/* XXX 4 bytes hole, try to pack */

	const struct hv_ops  *     ops;                  /*   392     8 */
	int                        irq_requested;        /*   400     4 */
	int                        data;                 /*   404     4 */
	struct winsize             ws;                   /*   408     8 */
	struct work_struct         tty_resize;           /*   416    32 */
	/* --- cacheline 7 boundary (448 bytes) --- */
	struct list_head           next;                 /*   448    16 */
	long unsigned int          flags;                /*   464     8 */

	/* size: 472, cachelines: 8, members: 15 */
	/* sum members: 464, holes: 2, sum holes: 8 */
	/* last cacheline: 24 bytes */
};
⬢[acme@toolbox v5.14.0-rc6+]$ pahole -F btf -C hvc_struct vmlinux
struct hvc_struct {
	struct tty_port            port;                 /*     0   352 */
	/* --- cacheline 5 boundary (320 bytes) was 32 bytes ago --- */
	spinlock_t                 lock;                 /*   352     4 */
	int                        index;                /*   356     4 */
	int                        do_wakeup;            /*   360     4 */

	/* XXX 4 bytes hole, try to pack */

	char *                     outbuf;               /*   368     8 */
	int                        outbuf_size;          /*   376     4 */
	int                        n_outbuf;             /*   380     4 */
	/* --- cacheline 6 boundary (384 bytes) --- */
	uint32_t                   vtermno;              /*   384     4 */

	/* XXX 4 bytes hole, try to pack */

	const struct hv_ops  *     ops;                  /*   392     8 */
	int                        irq_requested;        /*   400     4 */
	int                        data;                 /*   404     4 */
	struct winsize             ws;                   /*   408     8 */
	struct work_struct         tty_resize;           /*   416    32 */
	/* --- cacheline 7 boundary (448 bytes) --- */
	struct list_head           next;                 /*   448    16 */
	long unsigned int          flags;                /*   464     8 */

	/* size: 472, cachelines: 8, members: 15 */
	/* sum members: 464, holes: 2, sum holes: 8 */
	/* last cacheline: 24 bytes */
};


⬢[acme@toolbox v5.14.0-rc6+]$ pahole --help | grep decl
  -D, --decl_exclude=PREFIX  exclude classes declared in files with PREFIX
  -I, --show_decl_info       Show the file and line number where the tags were
⬢[acme@toolbox v5.14.0-rc6+]$ pahole -IF dwarf -C hvc_struct vmlinux
/* Used at: /var/home/acme/git/perf/drivers/tty/hvc/hvc_console.c */
/* <65c08c8> /var/home/acme/git/perf/drivers/tty/hvc/hvc_console.h:35 */
struct hvc_struct {
	struct tty_port            port;                 /*     0   352 */
	/* --- cacheline 5 boundary (320 bytes) was 32 bytes ago --- */
	spinlock_t                 lock;                 /*   352     4 */
	int                        index;                /*   356     4 */
	int                        do_wakeup;            /*   360     4 */

	/* XXX 4 bytes hole, try to pack */

	char *                     outbuf;               /*   368     8 */
	int                        outbuf_size;          /*   376     4 */
	int                        n_outbuf;             /*   380     4 */
	/* --- cacheline 6 boundary (384 bytes) --- */
	uint32_t                   vtermno;              /*   384     4 */

	/* XXX 4 bytes hole, try to pack */

	const struct hv_ops  *     ops;                  /*   392     8 */
	int                        irq_requested;        /*   400     4 */
	int                        data;                 /*   404     4 */
	struct winsize             ws;                   /*   408     8 */
	struct work_struct         tty_resize;           /*   416    32 */
	/* --- cacheline 7 boundary (448 bytes) --- */
	struct list_head           next;                 /*   448    16 */
	long unsigned int          flags;                /*   464     8 */

	/* size: 472, cachelines: 8, members: 15 */
	/* sum members: 464, holes: 2, sum holes: 8 */
	/* last cacheline: 24 bytes */
};
⬢[acme@toolbox v5.14.0-rc6+]$
