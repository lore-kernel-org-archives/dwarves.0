Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF406C433F5
	for <linux-dwarves@archiver.kernel.org>; Thu, 29 Sep 2022 12:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbiI2MnC (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 29 Sep 2022 08:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234985AbiI2MnB (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 29 Sep 2022 08:43:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B5F160E51
        for <dwarves@vger.kernel.org>; Thu, 29 Sep 2022 05:42:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3B4D61156
        for <dwarves@vger.kernel.org>; Thu, 29 Sep 2022 12:42:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B06C433D6;
        Thu, 29 Sep 2022 12:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664455377;
        bh=Z8ubeBVs9NFeNbPUg9zuJLvG6tL2q9kbJvDLAtWKd58=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mb9oThjChUqE6HqKS0Cq9yqo3BpgIHoXX1DtmjJlTWat58Y+FN/20Xal/2Hssh1v/
         YVcgOJ5i4Z/fmnHXCL8Ww7J4wWrGjUOR2XD8OuN4M3+9MLzinWUptOoqpzwnnbLx4B
         BCptofeHH562rVvw0kTEiy/ptfcJrYVBd+yy4yy0+cHvKsz7PrEjFREVpi1VU5euTC
         SMDzjrMwBC5l1yaGOUBU9pWcGEAk58HkAK44SpP7DVx36QsVdPMSSHdI4cM9j3xhhA
         8xEXpJ2wsogTs3h515nSRHSLWmu8z0oZv8kR1b7E1HvnqPXIvHaC8vFGRzZDQ28qbV
         uq2qpF+J5G9XA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id ADFA4405F0; Thu, 29 Sep 2022 09:42:53 -0300 (-03)
Date:   Thu, 29 Sep 2022 09:42:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>, Yonghong Song <yhs@fb.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        dwarves@vger.kernel.org, llvm@lists.linux.dev
Subject: BTF: A fix and more work to do :Re: die__process_unit: DW_TAG_label
 (0xa) @ <0x7b> not handled!
Message-ID: <YzWSzXKcm6rSWOC5@kernel.org>
References: <YzNHYoI4EZOQdCQ0@dev-arch.thelio-3990X>
 <YzNKEhM+H/X0xUK3@kernel.org>
 <YzNWBxJTKDRBNNDa@dev-arch.thelio-3990X>
 <YzRPXVUfjcyQ4Utz@kernel.org>
 <YzRnfz0sVpX8CzeL@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YzRnfz0sVpX8CzeL@dev-arch.thelio-3990X>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Wed, Sep 28, 2022 at 08:25:51AM -0700, Nathan Chancellor escreveu:
> On Wed, Sep 28, 2022 at 10:42:53AM -0300, Arnaldo Carvalho de Melo wrote:
> > Can you please provide the vmlinux file where this takes place?
> 
> Sure thing, it is compressed to save some bandwidth while downloading:
> 
> https://1drv.ms/u/s!AsQNYeB-IEbqnnzsULjM1pXmOlI5?e=qHKjuW

So, fixed the case reported, DW_TAG_label outside a DW_TAG_lexblock, on
asm DW_TAG_compile_unit DWARF containers, now I noticed that pahole
suports encoding BTF_KIND_TAG (18) but not _decoding_ those, so off I go
to work on it on btf_loader.c, looking at what btf_encoder.c does.

Good that you got me this vmlinux built by clang 15 :-)

Now we can BTF encode a vmlinux (-J) using all the CPUs in the system
(-j), and then we end up with a kernel with BTF_KIND_TAG that can't be
properly grokked by pahole when loading from BTF:

⬢[acme@toolbox pahole]$ pahole -j -J vmlinux-pahole-warnings
⬢[acme@toolbox pahole]$ pahole -F btf vmlinux-pahole-warnings  > pahole-pretty-printed-from-btf
BTF: idx: 277, Unknown kind 18
BTF: idx: 281, Unknown kind 18
BTF: idx: 331, Unknown kind 18
BTF: idx: 689, Unknown kind 18
BTF: idx: 692, Unknown kind 18

For instance:

⬢[acme@toolbox pahole]$ pahole -C __sifields -F btf vmlinux-pahole-warnings
BTF: idx: 277, Unknown kind 18
BTF: idx: 281, Unknown kind 18
BTF: idx: 331, Unknown kind 18
BTF: idx: 689, Unknown kind 18
<BIG SNIP>
BTF: idx: 128403, Unknown kind 18
BTF: idx: 128409, Unknown kind 18
union __sifields {
	struct {
		__kernel_pid_t     _pid;               /*     0     4 */
		__kernel_uid32_t   _uid;               /*     4     4 */
	} _kill;                                       /*     0     8 */
	struct {
		__kernel_timer_t   _tid;               /*     0     4 */
		int                _overrun;           /*     4     4 */
		sigval_t           _sigval;            /*     8     8 */
		int                _sys_private;       /*    16     4 */
	} _timer;                                      /*     0    24 */
	struct {
		__kernel_pid_t     _pid;               /*     0     4 */
		__kernel_uid32_t   _uid;               /*     4     4 */
		sigval_t           _sigval;            /*     8     8 */
	} _rt;                                         /*     0    16 */
	struct {
		__kernel_pid_t     _pid;               /*     0     4 */
		__kernel_uid32_t   _uid;               /*     4     4 */
		int                _status;            /*     8     4 */

		/* XXX 4 bytes hole, try to pack */

		__kernel_clock_t   _utime;             /*    16     8 */
		__kernel_clock_t   _stime;             /*    24     8 */
	} _sigchld;                                    /*     0    32 */
	struct {
		<ERROR            > _addr;             /*     0     8 */
		union {
			int        _trapno;            /*     8     4 */
			short      _addr_lsb;          /*     8     2 */
			struct {
				char _dummy_bnd[8];    /*     8     8 */
				<ERROR> _lower;        /*    16     8 */
				<ERROR> _upper;        /*    24     8 */
			} _addr_bnd;                   /*     8    24 */
			struct {
				char _dummy_pkey[8];   /*     8     8 */
				__u32 _pkey;           /*    16     4 */
			} _addr_pkey;                  /*     8    12 */
			struct {
				unsigned long _data;   /*     8     8 */
				__u32 _type;           /*    16     4 */
				__u32 _flags;          /*    20     4 */
			} _perf;                       /*     8    16 */
		};                                     /*     8    24 */
	} _sigfault;                                   /*     0    32 */
	struct {
		long               _band;              /*     0     8 */
		int                _fd;                /*     8     4 */
	} _sigpoll;                                    /*     0    16 */
	struct {
		<ERROR            > _call_addr;        /*     0     8 */
		int                _syscall;           /*     8     4 */
		unsigned int       _arch;              /*    12     4 */
	} _sigsys;                                     /*     0    16 */
};

⬢[acme@toolbox pahole]$

And if we look from DWARF:

⬢[acme@toolbox pahole]$ pahole -C __sifields -F dwarf vmlinux-pahole-warnings   | grep -w _addr -B2 -A2
	} _sigchld;                                    /*     0    32 */
	struct {
		user *             _addr;              /*     0     8 */
		union {
			int        _trapno;            /*     8     4 */
⬢[acme@toolbox pahole]$

And from the source code:

        /* SIGILL, SIGFPE, SIGSEGV, SIGBUS, SIGTRAP, SIGEMT */
        struct {
                void __user *_addr; /* faulting insn/memory ref. */
#ifdef __ia64__
                int _imm;               /* immediate value for "break" */
                unsigned int _flags;    /* see ia64 si_flags */
                unsigned long _isr;     /* isr */
#endif

#define __ADDR_BND_PKEY_PAD  (__alignof__(void *) < sizeof(short) ? \
                              sizeof(short) : __alignof__(void *))
                union {
                        /* used on alpha and sparc */
                        int _trapno;    /* TRAP # which caused the signal */
                        /*
                         * used when si_code=BUS_MCEERR_AR or
                         * used when si_code=BUS_MCEERR_AO
                         */
                        short _addr_lsb; /* LSB of the reported address */
                        /* used when si_code=SEGV_BNDERR */
                        struct {
                                char _dummy_bnd[__ADDR_BND_PKEY_PAD];
                                void __user *_lower;
                                void __user *_upper;
                        } _addr_bnd;


Ok:

#  define __user        BTF_TYPE_TAG(user)

#if defined(CONFIG_DEBUG_INFO_BTF) && defined(CONFIG_PAHOLE_HAS_BTF_TAG) && \
        __has_attribute(btf_type_tag)
# define BTF_TYPE_TAG(value) __attribute__((btf_type_tag(#value)))
#else
# define BTF_TYPE_TAG(value) /* nothing */
#endif

Ok, homework to do: we need to better support btf_type_tag in both
pahole pretty printer and in its BTF loader. :-)

One of the new features will be:

	pahole --types_with_user_members

- Arnaldo
