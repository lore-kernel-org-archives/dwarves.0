Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66A5C433DB
	for <linux-dwarves@archiver.kernel.org>; Thu, 21 Jan 2021 11:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7972F2395A
	for <linux-dwarves@archiver.kernel.org>; Thu, 21 Jan 2021 11:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbhAULrC (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 21 Jan 2021 06:47:02 -0500
Received: from wildebeest.demon.nl ([212.238.236.112]:41578 "EHLO
        gnu.wildebeest.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730580AbhAULq6 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 21 Jan 2021 06:46:58 -0500
X-Greylist: delayed 590 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Jan 2021 06:46:58 EST
Received: from librem (ip-213-127-53-73.ip.prioritytelecom.net [213.127.53.73])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by gnu.wildebeest.org (Postfix) with ESMTPSA id F21073000608;
        Thu, 21 Jan 2021 12:36:22 +0100 (CET)
Received: by librem (Postfix, from userid 1000)
        id 61F53C2422; Thu, 21 Jan 2021 12:35:16 +0100 (CET)
Date:   Thu, 21 Jan 2021 12:35:16 +0100
From:   Mark Wielaard <mark@klomp.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     dwarves@vger.kernel.org
Subject: Re: DWARF5 DW_AT_data_bit_offset
Message-ID: <20210121113516.GA8492@wildebeest.org>
References: <5ee85ca6e3b06b07c83b150912fbcfc1a4c13e19.camel@klomp.org>
 <20201002211819.GA127275@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002211819.GA127275@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Hi,

On Fri, Oct 02, 2020 at 06:18:19PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Oct 02, 2020 at 06:11:06PM +0200, Mark Wielaard escreveu:
> > Seems pahole with a recent version of elfutils libdw already handles
> > most DWARF5 encodings. One thing it doesn't handle yet is
> > DW_AT_data_bit_offset (this is actually a DWARF4 thing, but gcc only
> > emits it for -gdwarf-5).
> > 
> > Note that the actual bit offset for the different attributes is defined
> > differently:
> > 
> > DW_AT_bit_offset: The bit offset attribute describes the offset in bits
> > of the high order bit of a value of the given type from the high order
> > bit of the storage unit used to contain that value.
> > 
> > DW_AT_data_bit_offset: the value is an integer constant that specifies
> > the number of bits from the beginning of the containing entity to the
> > beginning of the data member.
> > 
> > If there is a DW_AT_data_bit_offset instead of a
> > DW_AT_data_member_location then there will be no DW_AT_byte_size and no
> > DW_AT_bit_offset.
> > 
> > DWARF5 has some example for big and little endian in D.2.8 C/C++ Bit-
> > Field Examples
> > 
> > dwarf_loader.c already seems to do the right thing for little-endian
> > machines with DW_AT_data_member_location and DW_AT_bit_offset. For
> > DW_AT_data_bit_offset it doesn't have to do this fixup because it is
> > already defined as you would expect.
> > 
> > Example that shows the issue:
> > 
> > $ cat bf.c
> > struct pea
> > {
> >   int type;
> >   long a:1, b:1, c:1;
> > };
> > 
> > struct pea p;
> > 
> > $ gcc -gdwarf-4 -c bf.c
> > $ ./pahole ./bf.o 
> > struct pea {
> > 	int                        type;                 /*     0     4 */
> > 
> > 	/* Bitfield combined with previous fields */
> > 
> > 	long int                   a:1;                  /*     0:32  8 */
> > 	long int                   b:1;                  /*     0:33  8 */
> > 	long int                   c:1;                  /*     0:34  8 */
> > 
> > 	/* size: 8, cachelines: 1, members: 4 */
> > 	/* bit_padding: 29 bits */
> > 	/* last cacheline: 8 bytes */
> > };
> > $ gcc -gdwarf-5 -c bf.c
> > $ ./pahole ./bf.o 
> > DW_AT_<0xd>=0x21
> > DW_AT_<0xd>=0x21
> > DW_AT_<0xd>=0x21
> > struct pea {
> > 	int                        type;                 /*     0     4 */
> > 	static long int                   a;             /*     0     0 */
> > 	static long int                   b;             /*     0     0 */
> > 	static long int                   c;             /*     0     0 */
> > 
> > 	/* size: 8, cachelines: 1, members: 1, static members: 3 */
> > 	/* padding: 4 */
> > 	/* last cacheline: 8 bytes */
> > };
> > 
> > Note that GCC11 might default to DWARF5.
> 
> Thanks for the detailed report, I'm releasing v1.18 right now, will look
> into that for v1.19.

Note that GCC11 indeed just switched to producing DWARF5 by default.
It is not released yet, but already in stage4 and Fedora will start
doing a mass-rebuild with it soon to shake out the last remaining bugs.

Cheers,

Mark
