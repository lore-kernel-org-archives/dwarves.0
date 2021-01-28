Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8E0C433DB
	for <linux-dwarves@archiver.kernel.org>; Thu, 28 Jan 2021 13:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D76206146D
	for <linux-dwarves@archiver.kernel.org>; Thu, 28 Jan 2021 13:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhA1NtX (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 28 Jan 2021 08:49:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:40948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231168AbhA1NtW (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Thu, 28 Jan 2021 08:49:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2AD7B64DD6;
        Thu, 28 Jan 2021 13:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611841721;
        bh=jxPJ0qG9WPpvkas9lFLuFsdz8oHGmnXbPvAJlZcudl4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YBpfIaPfIQcDabXyRsuMQVrMmXe0BI05ojqQNPmHP8nrZ2GE5Uxp9sh5wJPSoYnK3
         fQ4B7UACrMGF+XE3vCKs6eqZBMuhnge1+NoZi/S38n571V+9UlveBH5pxDMOQ57Kvf
         3cywYWPnZfxxXTJ+pN3sp6TQ0tH7qkHQhEV1JhPSB0aVRKzen2iAq6pyX7wBznTXtC
         9iIK0VT3/zpdkD/YAfVQ77BFiHwrQZsPHJTyINfq+M39ADDCGRw00EUt0tvWtFMbfd
         RR8QBMs9w5FwhlZLvvgwXIyPlidJrcCC6el6uDiqaCCqUxbHOSkuQBnJcbj3pmiukK
         ypyyxNqaruRvQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A2FFA40513; Thu, 28 Jan 2021 10:48:37 -0300 (-03)
Date:   Thu, 28 Jan 2021 10:48:37 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc:     Mark Wielaard <mark@klomp.org>, dwarves@vger.kernel.org
Subject: Re: [PATCH/RFC] Re: DWARF5 DW_AT_data_bit_offset
Message-ID: <20210128134837.GE775562@kernel.org>
References: <5ee85ca6e3b06b07c83b150912fbcfc1a4c13e19.camel@klomp.org>
 <20201002211819.GA127275@kernel.org>
 <20210121113516.GA8492@wildebeest.org>
 <20210128121122.GA775562@kernel.org>
 <20210128125443.GI3832029@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210128125443.GI3832029@redhat.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Thu, Jan 28, 2021 at 12:54:43PM +0000, Daniel P. Berrangé escreveu:
> On Thu, Jan 28, 2021 at 09:11:22AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Jan 21, 2021 at 12:35:16PM +0100, Mark Wielaard escreveu:
> > > On Fri, Oct 02, 2020 at 06:18:19PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > Em Fri, Oct 02, 2020 at 06:11:06PM +0200, Mark Wielaard escreveu:
> > > > > Seems pahole with a recent version of elfutils libdw already handles
> > > > > most DWARF5 encodings. One thing it doesn't handle yet is
> > > > > DW_AT_data_bit_offset (this is actually a DWARF4 thing, but gcc only
> > > > > emits it for -gdwarf-5).
> > 
> > <SNIP>
> > 
> > > > > $ gcc -gdwarf-5 -c bf.c
> > > > > $ ./pahole ./bf.o 
> > > > > DW_AT_<0xd>=0x21
> > > > > DW_AT_<0xd>=0x21
> > > > > DW_AT_<0xd>=0x21
> > > > > struct pea {
> > > > > 	int                        type;                 /*     0     4 */
> > > > > 	static long int                   a;             /*     0     0 */
> > > > > 	static long int                   b;             /*     0     0 */
> > > > > 	static long int                   c;             /*     0     0 */
> > > > > 
> > > > > 	/* size: 8, cachelines: 1, members: 1, static members: 3 */
> > > > > 	/* padding: 4 */
> > > > > 	/* last cacheline: 8 bytes */
> > > > > };
> > 
> > > > > Note that GCC11 might default to DWARF5.
> > 
> > > > Thanks for the detailed report, I'm releasing v1.18 right now, will look
> > > > into that for v1.19.
> > 
> > > Note that GCC11 indeed just switched to producing DWARF5 by default.
> > > It is not released yet, but already in stage4 and Fedora will start
> > > doing a mass-rebuild with it soon to shake out the last remaining bugs.
> > 
> > So, 1.20 will have the fix below, please check if what is in:
> > 
> > https://git.kernel.org/pub/scm/devel/pahole/pahole.git/log/?h=DW_AT_data_bit_offset
> > 
> > Fixes it for you, the cset with all the tests performed is this one:
> > 
> > https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=DW_AT_data_bit_offset&id=a77f039bb49bc97badf938049245f013fe3de4aa
> > 
> > Now looking at https://bugzilla.redhat.com/show_bug.cgi?id=1919965 ...
> 
> The XDR generated code example I give in that bug *does* appear
> to be fixed when using your  DW_AT_data_bit_offset branch.

Thanks for checking, I'll double check on my side now, got sidetracked
in the last hour with perf patch processing :-)

- Arnaldo
