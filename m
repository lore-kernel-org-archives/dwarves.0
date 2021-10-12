Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2338AC433EF
	for <linux-dwarves@archiver.kernel.org>; Tue, 12 Oct 2021 01:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 071A261056
	for <linux-dwarves@archiver.kernel.org>; Tue, 12 Oct 2021 01:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbhJLBdc (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 11 Oct 2021 21:33:32 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:49965 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231135AbhJLBda (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 11 Oct 2021 21:33:30 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0UrWfoOh_1634002287;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0UrWfoOh_1634002287)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 12 Oct 2021 09:31:28 +0800
Subject: Re: pahole failed to get some struct info
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     dwarves@vger.kernel.org
References: <9a88283d-443c-3789-b120-b2c6c56ebe55@linux.alibaba.com>
 <YWSImJiz3VjD/ArG@kernel.org>
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
Message-ID: <11bd09e0-b518-20c3-959a-2b5f42c9d54f@linux.alibaba.com>
Date:   Tue, 12 Oct 2021 09:31:28 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YWSImJiz3VjD/ArG@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

thanks a lot for the response,

I will try the new version, my current version seems too old.

$ pahole  --version
v1.9

在 2021/10/12 上午2:55, Arnaldo Carvalho de Melo 写道:
> Em Sun, Oct 10, 2021 at 02:09:10PM +0800, Xianting Tian escreveu:
>> Hi,
>> Sorry to disturb you, when I use below command to get info about 'struct
>> hvc_struct', it failed.
>> $ pahole -C hvc_struct vmlinux
>> die__process_function: tag not supported (INVALID)!
>> die__process_unit: DW_TAG_dwarf_procedure (0x36) @ <0x4ebf4c> not handled!
>   
>> But when I try some common struct, it is OK.
>   
>> $ pahole -C task_struct vmlinux
>   
>> Could you help me how to fix the issue?  thanks a lot.
> Using:
>
> ⬢[acme@toolbox v5.14.0-rc6+]$ pahole --version
> v1.22
>
> I see no problems, be it from DWARF or from BTF, in the various ways to
> ask for that struct:
>
> ⬢[acme@toolbox v5.14.0-rc6+]$ pahole -C hvc_struct vmlinux
> struct hvc_struct {
> 	struct tty_port            port;                 /*     0   352 */
> 	/* --- cacheline 5 boundary (320 bytes) was 32 bytes ago --- */
> 	spinlock_t                 lock;                 /*   352     4 */
> 	int                        index;                /*   356     4 */
> 	int                        do_wakeup;            /*   360     4 */
>
> 	/* XXX 4 bytes hole, try to pack */
>
> 	char *                     outbuf;               /*   368     8 */
> 	int                        outbuf_size;          /*   376     4 */
> 	int                        n_outbuf;             /*   380     4 */
> 	/* --- cacheline 6 boundary (384 bytes) --- */
> 	uint32_t                   vtermno;              /*   384     4 */
>
> 	/* XXX 4 bytes hole, try to pack */
>
> 	const struct hv_ops  *     ops;                  /*   392     8 */
> 	int                        irq_requested;        /*   400     4 */
> 	int                        data;                 /*   404     4 */
> 	struct winsize             ws;                   /*   408     8 */
> 	struct work_struct         tty_resize;           /*   416    32 */
> 	/* --- cacheline 7 boundary (448 bytes) --- */
> 	struct list_head           next;                 /*   448    16 */
> 	long unsigned int          flags;                /*   464     8 */
>
> 	/* size: 472, cachelines: 8, members: 15 */
> 	/* sum members: 464, holes: 2, sum holes: 8 */
> 	/* last cacheline: 24 bytes */
> };
> ⬢[acme@toolbox v5.14.0-rc6+]$ pahole hvc_struct
> struct hvc_struct {
> 	struct tty_port            port;                 /*     0   352 */
> 	/* --- cacheline 5 boundary (320 bytes) was 32 bytes ago --- */
> 	spinlock_t                 lock;                 /*   352     4 */
> 	int                        index;                /*   356     4 */
> 	int                        do_wakeup;            /*   360     4 */
>
> 	/* XXX 4 bytes hole, try to pack */
>
> 	char *                     outbuf;               /*   368     8 */
> 	int                        outbuf_size;          /*   376     4 */
> 	int                        n_outbuf;             /*   380     4 */
> 	/* --- cacheline 6 boundary (384 bytes) --- */
> 	uint32_t                   vtermno;              /*   384     4 */
>
> 	/* XXX 4 bytes hole, try to pack */
>
> 	const struct hv_ops  *     ops;                  /*   392     8 */
> 	int                        irq_requested;        /*   400     4 */
> 	int                        data;                 /*   404     4 */
> 	struct winsize             ws;                   /*   408     8 */
> 	struct work_struct         tty_resize;           /*   416    32 */
> 	/* --- cacheline 7 boundary (448 bytes) --- */
> 	struct list_head           next;                 /*   448    16 */
> 	long unsigned int          flags;                /*   464     8 */
>
> 	/* size: 472, cachelines: 8, members: 15 */
> 	/* sum members: 464, holes: 2, sum holes: 8 */
> 	/* last cacheline: 24 bytes */
> };
> ⬢[acme@toolbox v5.14.0-rc6+]$
>
> ⬢[acme@toolbox v5.14.0-rc6+]$ pahole -F dwarf -C hvc_struct vmlinux
> struct hvc_struct {
> 	struct tty_port            port;                 /*     0   352 */
> 	/* --- cacheline 5 boundary (320 bytes) was 32 bytes ago --- */
> 	spinlock_t                 lock;                 /*   352     4 */
> 	int                        index;                /*   356     4 */
> 	int                        do_wakeup;            /*   360     4 */
>
> 	/* XXX 4 bytes hole, try to pack */
>
> 	char *                     outbuf;               /*   368     8 */
> 	int                        outbuf_size;          /*   376     4 */
> 	int                        n_outbuf;             /*   380     4 */
> 	/* --- cacheline 6 boundary (384 bytes) --- */
> 	uint32_t                   vtermno;              /*   384     4 */
>
> 	/* XXX 4 bytes hole, try to pack */
>
> 	const struct hv_ops  *     ops;                  /*   392     8 */
> 	int                        irq_requested;        /*   400     4 */
> 	int                        data;                 /*   404     4 */
> 	struct winsize             ws;                   /*   408     8 */
> 	struct work_struct         tty_resize;           /*   416    32 */
> 	/* --- cacheline 7 boundary (448 bytes) --- */
> 	struct list_head           next;                 /*   448    16 */
> 	long unsigned int          flags;                /*   464     8 */
>
> 	/* size: 472, cachelines: 8, members: 15 */
> 	/* sum members: 464, holes: 2, sum holes: 8 */
> 	/* last cacheline: 24 bytes */
> };
> ⬢[acme@toolbox v5.14.0-rc6+]$ pahole -F btf -C hvc_struct vmlinux
> struct hvc_struct {
> 	struct tty_port            port;                 /*     0   352 */
> 	/* --- cacheline 5 boundary (320 bytes) was 32 bytes ago --- */
> 	spinlock_t                 lock;                 /*   352     4 */
> 	int                        index;                /*   356     4 */
> 	int                        do_wakeup;            /*   360     4 */
>
> 	/* XXX 4 bytes hole, try to pack */
>
> 	char *                     outbuf;               /*   368     8 */
> 	int                        outbuf_size;          /*   376     4 */
> 	int                        n_outbuf;             /*   380     4 */
> 	/* --- cacheline 6 boundary (384 bytes) --- */
> 	uint32_t                   vtermno;              /*   384     4 */
>
> 	/* XXX 4 bytes hole, try to pack */
>
> 	const struct hv_ops  *     ops;                  /*   392     8 */
> 	int                        irq_requested;        /*   400     4 */
> 	int                        data;                 /*   404     4 */
> 	struct winsize             ws;                   /*   408     8 */
> 	struct work_struct         tty_resize;           /*   416    32 */
> 	/* --- cacheline 7 boundary (448 bytes) --- */
> 	struct list_head           next;                 /*   448    16 */
> 	long unsigned int          flags;                /*   464     8 */
>
> 	/* size: 472, cachelines: 8, members: 15 */
> 	/* sum members: 464, holes: 2, sum holes: 8 */
> 	/* last cacheline: 24 bytes */
> };
>
>
> ⬢[acme@toolbox v5.14.0-rc6+]$ pahole --help | grep decl
>    -D, --decl_exclude=PREFIX  exclude classes declared in files with PREFIX
>    -I, --show_decl_info       Show the file and line number where the tags were
> ⬢[acme@toolbox v5.14.0-rc6+]$ pahole -IF dwarf -C hvc_struct vmlinux
> /* Used at: /var/home/acme/git/perf/drivers/tty/hvc/hvc_console.c */
> /* <65c08c8> /var/home/acme/git/perf/drivers/tty/hvc/hvc_console.h:35 */
> struct hvc_struct {
> 	struct tty_port            port;                 /*     0   352 */
> 	/* --- cacheline 5 boundary (320 bytes) was 32 bytes ago --- */
> 	spinlock_t                 lock;                 /*   352     4 */
> 	int                        index;                /*   356     4 */
> 	int                        do_wakeup;            /*   360     4 */
>
> 	/* XXX 4 bytes hole, try to pack */
>
> 	char *                     outbuf;               /*   368     8 */
> 	int                        outbuf_size;          /*   376     4 */
> 	int                        n_outbuf;             /*   380     4 */
> 	/* --- cacheline 6 boundary (384 bytes) --- */
> 	uint32_t                   vtermno;              /*   384     4 */
>
> 	/* XXX 4 bytes hole, try to pack */
>
> 	const struct hv_ops  *     ops;                  /*   392     8 */
> 	int                        irq_requested;        /*   400     4 */
> 	int                        data;                 /*   404     4 */
> 	struct winsize             ws;                   /*   408     8 */
> 	struct work_struct         tty_resize;           /*   416    32 */
> 	/* --- cacheline 7 boundary (448 bytes) --- */
> 	struct list_head           next;                 /*   448    16 */
> 	long unsigned int          flags;                /*   464     8 */
>
> 	/* size: 472, cachelines: 8, members: 15 */
> 	/* sum members: 464, holes: 2, sum holes: 8 */
> 	/* last cacheline: 24 bytes */
> };
> ⬢[acme@toolbox v5.14.0-rc6+]$
