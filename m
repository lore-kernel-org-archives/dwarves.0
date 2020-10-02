Return-Path: <SRS0=yA5M=DJ=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0490C4363C
	for <linux-dwarves@archiver.kernel.org>; Fri,  2 Oct 2020 16:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DB77206FA
	for <linux-dwarves@archiver.kernel.org>; Fri,  2 Oct 2020 16:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgJBQRd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 2 Oct 2020 12:17:33 -0400
Received: from wildebeest.demon.nl ([212.238.236.112]:45456 "EHLO
        gnu.wildebeest.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBQRd (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Fri, 2 Oct 2020 12:17:33 -0400
X-Greylist: delayed 383 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Oct 2020 12:17:32 EDT
Received: from tarox.wildebeest.org (tarox.wildebeest.org [172.31.17.39])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by gnu.wildebeest.org (Postfix) with ESMTPSA id B1013300BF33
        for <dwarves@vger.kernel.org>; Fri,  2 Oct 2020 18:11:07 +0200 (CEST)
Received: by tarox.wildebeest.org (Postfix, from userid 1000)
        id 28F544000C44; Fri,  2 Oct 2020 18:11:07 +0200 (CEST)
Message-ID: <5ee85ca6e3b06b07c83b150912fbcfc1a4c13e19.camel@klomp.org>
Subject: DWARF5 DW_AT_data_bit_offset
From:   Mark Wielaard <mark@klomp.org>
To:     dwarves@vger.kernel.org
Date:   Fri, 02 Oct 2020 18:11:06 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.28.5 (3.28.5-8.el7) 
Mime-Version: 1.0
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Hi,

Seems pahole with a recent version of elfutils libdw already handles
most DWARF5 encodings. One thing it doesn't handle yet is
DW_AT_data_bit_offset (this is actually a DWARF4 thing, but gcc only
emits it for -gdwarf-5).

Note that the actual bit offset for the different attributes is defined
differently:

DW_AT_bit_offset: The bit offset attribute describes the offset in bits
of the high order bit of a value of the given type from the high order
bit of the storage unit used to contain that value.

DW_AT_data_bit_offset: the value is an integer constant that specifies
the number of bits from the beginning of the containing entity to the
beginning of the data member.

If there is a DW_AT_data_bit_offset instead of a
DW_AT_data_member_location then there will be no DW_AT_byte_size and no
DW_AT_bit_offset.

DWARF5 has some example for big and little endian in D.2.8 C/C++ Bit-
Field Examples

dwarf_loader.c already seems to do the right thing for little-endian
machines with DW_AT_data_member_location and DW_AT_bit_offset. For
DW_AT_data_bit_offset it doesn't have to do this fixup because it is
already defined as you would expect.

Example that shows the issue:

$ cat bf.c
struct pea
{
  int type;
  long a:1, b:1, c:1;
};

struct pea p;

$ gcc -gdwarf-4 -c bf.c
$ ./pahole ./bf.o 
struct pea {
	int                        type;                 /*     0     4 */

	/* Bitfield combined with previous fields */

	long int                   a:1;                  /*     0:32  8 */
	long int                   b:1;                  /*     0:33  8 */
	long int                   c:1;                  /*     0:34  8 */

	/* size: 8, cachelines: 1, members: 4 */
	/* bit_padding: 29 bits */
	/* last cacheline: 8 bytes */
};
$ gcc -gdwarf-5 -c bf.c
$ ./pahole ./bf.o 
DW_AT_<0xd>=0x21
DW_AT_<0xd>=0x21
DW_AT_<0xd>=0x21
struct pea {
	int                        type;                 /*     0     4 */
	static long int                   a;             /*     0     0 */
	static long int                   b;             /*     0     0 */
	static long int                   c;             /*     0     0 */

	/* size: 8, cachelines: 1, members: 1, static members: 3 */
	/* padding: 4 */
	/* last cacheline: 8 bytes */
};

Note that GCC11 might default to DWARF5.

Cheers,

Mark
