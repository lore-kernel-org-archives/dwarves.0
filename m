Return-Path: <SRS0=yA5M=DJ=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C271C4363D
	for <linux-dwarves@archiver.kernel.org>; Fri,  2 Oct 2020 21:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F22A820754
	for <linux-dwarves@archiver.kernel.org>; Fri,  2 Oct 2020 21:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601673503;
	bh=RkkyCCfcybqy+gR3NYRi5cUzkfQF7vmPBHpqohLyWho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s1mNL9CYutnLTidQJWqSk5M1+uaW4XjlB3d6LiwAR1mZoemLsc9AL5P6JM7xmzOck
	 ZGDqgd+gVdMySas8OVTTMV8Bkmi+2ZC8COvQ3fwk/kVfl2cWpzUQi9o1uiFyWkNSLv
	 yZ/BZxAl8CrjXkTT8KdaoTmQsj4y/znc6YZW976o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbgJBVSW (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 2 Oct 2020 17:18:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:38282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgJBVSW (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Fri, 2 Oct 2020 17:18:22 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB10E206DD;
        Fri,  2 Oct 2020 21:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601673502;
        bh=RkkyCCfcybqy+gR3NYRi5cUzkfQF7vmPBHpqohLyWho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Aqb4sq2MipDKm1Z2OJZQrJFw2zP7mrom2LO0cYHAkRcpu9oxq7bDNYGAl8N3hVuT3
         zSSvKByxfw1TD5VZKDEHpZQeDEsvNehTm6K4YJqWOqV/f/oD84WxBiVAGq9tQwmJfU
         lVD3mY1wwtzMqtBhuKUfgeHic0pPpP+Utoi7kjTE=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AFDF2403AC; Fri,  2 Oct 2020 18:18:19 -0300 (-03)
Date:   Fri, 2 Oct 2020 18:18:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Mark Wielaard <mark@klomp.org>
Cc:     dwarves@vger.kernel.org
Subject: Re: DWARF5 DW_AT_data_bit_offset
Message-ID: <20201002211819.GA127275@kernel.org>
References: <5ee85ca6e3b06b07c83b150912fbcfc1a4c13e19.camel@klomp.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ee85ca6e3b06b07c83b150912fbcfc1a4c13e19.camel@klomp.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Fri, Oct 02, 2020 at 06:11:06PM +0200, Mark Wielaard escreveu:
> Hi,
> 
> Seems pahole with a recent version of elfutils libdw already handles
> most DWARF5 encodings. One thing it doesn't handle yet is
> DW_AT_data_bit_offset (this is actually a DWARF4 thing, but gcc only
> emits it for -gdwarf-5).
> 
> Note that the actual bit offset for the different attributes is defined
> differently:
> 
> DW_AT_bit_offset: The bit offset attribute describes the offset in bits
> of the high order bit of a value of the given type from the high order
> bit of the storage unit used to contain that value.
> 
> DW_AT_data_bit_offset: the value is an integer constant that specifies
> the number of bits from the beginning of the containing entity to the
> beginning of the data member.
> 
> If there is a DW_AT_data_bit_offset instead of a
> DW_AT_data_member_location then there will be no DW_AT_byte_size and no
> DW_AT_bit_offset.
> 
> DWARF5 has some example for big and little endian in D.2.8 C/C++ Bit-
> Field Examples
> 
> dwarf_loader.c already seems to do the right thing for little-endian
> machines with DW_AT_data_member_location and DW_AT_bit_offset. For
> DW_AT_data_bit_offset it doesn't have to do this fixup because it is
> already defined as you would expect.
> 
> Example that shows the issue:
> 
> $ cat bf.c
> struct pea
> {
>   int type;
>   long a:1, b:1, c:1;
> };
> 
> struct pea p;
> 
> $ gcc -gdwarf-4 -c bf.c
> $ ./pahole ./bf.o 
> struct pea {
> 	int                        type;                 /*     0     4 */
> 
> 	/* Bitfield combined with previous fields */
> 
> 	long int                   a:1;                  /*     0:32  8 */
> 	long int                   b:1;                  /*     0:33  8 */
> 	long int                   c:1;                  /*     0:34  8 */
> 
> 	/* size: 8, cachelines: 1, members: 4 */
> 	/* bit_padding: 29 bits */
> 	/* last cacheline: 8 bytes */
> };
> $ gcc -gdwarf-5 -c bf.c
> $ ./pahole ./bf.o 
> DW_AT_<0xd>=0x21
> DW_AT_<0xd>=0x21
> DW_AT_<0xd>=0x21
> struct pea {
> 	int                        type;                 /*     0     4 */
> 	static long int                   a;             /*     0     0 */
> 	static long int                   b;             /*     0     0 */
> 	static long int                   c;             /*     0     0 */
> 
> 	/* size: 8, cachelines: 1, members: 1, static members: 3 */
> 	/* padding: 4 */
> 	/* last cacheline: 8 bytes */
> };
> 
> Note that GCC11 might default to DWARF5.

Thanks for the detailed report, I'm releasing v1.18 right now, will look
into that for v1.19.

- Arnaldo
