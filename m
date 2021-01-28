Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BEEC433DB
	for <linux-dwarves@archiver.kernel.org>; Thu, 28 Jan 2021 12:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D966564D9D
	for <linux-dwarves@archiver.kernel.org>; Thu, 28 Jan 2021 12:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbhA1M4V (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 28 Jan 2021 07:56:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28439 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231465AbhA1M4U (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 28 Jan 2021 07:56:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611838494;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=MtBbADQiuUSQfzo63sc+64I9NQT25rWvLSQFMMQtrLU=;
        b=YcuoUX5/R31/6x7TLxZoArVRR2aS3UMRUPZf8A0TPkTzTYjJOsyJiDBeIvEeuRF+5xhrmX
        tsZPDyEpJVB+hZHgSS+fc/39Fo87FE3RPunRG99uYzBdPnjTB0I/hbVYIlJ3XOMqeqE0ai
        fNrzBObZLH0JQcvyDd85kBrUPVGUYk4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-iCTKjoaAPoCMCd_Cp56EsA-1; Thu, 28 Jan 2021 07:54:49 -0500
X-MC-Unique: iCTKjoaAPoCMCd_Cp56EsA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF36D107ACE6;
        Thu, 28 Jan 2021 12:54:48 +0000 (UTC)
Received: from redhat.com (ovpn-115-133.ams2.redhat.com [10.36.115.133])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E6BAA6064B;
        Thu, 28 Jan 2021 12:54:46 +0000 (UTC)
Date:   Thu, 28 Jan 2021 12:54:43 +0000
From:   Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mark Wielaard <mark@klomp.org>, dwarves@vger.kernel.org
Subject: Re: [PATCH/RFC] Re: DWARF5 DW_AT_data_bit_offset
Message-ID: <20210128125443.GI3832029@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <5ee85ca6e3b06b07c83b150912fbcfc1a4c13e19.camel@klomp.org>
 <20201002211819.GA127275@kernel.org>
 <20210121113516.GA8492@wildebeest.org>
 <20210128121122.GA775562@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210128121122.GA775562@kernel.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Thu, Jan 28, 2021 at 09:11:22AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Jan 21, 2021 at 12:35:16PM +0100, Mark Wielaard escreveu:
> > On Fri, Oct 02, 2020 at 06:18:19PM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Fri, Oct 02, 2020 at 06:11:06PM +0200, Mark Wielaard escreveu:
> > > > Seems pahole with a recent version of elfutils libdw already handles
> > > > most DWARF5 encodings. One thing it doesn't handle yet is
> > > > DW_AT_data_bit_offset (this is actually a DWARF4 thing, but gcc only
> > > > emits it for -gdwarf-5).
> 
> <SNIP>
> 
> > > > $ gcc -gdwarf-5 -c bf.c
> > > > $ ./pahole ./bf.o 
> > > > DW_AT_<0xd>=0x21
> > > > DW_AT_<0xd>=0x21
> > > > DW_AT_<0xd>=0x21
> > > > struct pea {
> > > > 	int                        type;                 /*     0     4 */
> > > > 	static long int                   a;             /*     0     0 */
> > > > 	static long int                   b;             /*     0     0 */
> > > > 	static long int                   c;             /*     0     0 */
> > > > 
> > > > 	/* size: 8, cachelines: 1, members: 1, static members: 3 */
> > > > 	/* padding: 4 */
> > > > 	/* last cacheline: 8 bytes */
> > > > };
> 
> > > > Note that GCC11 might default to DWARF5.
> 
> > > Thanks for the detailed report, I'm releasing v1.18 right now, will look
> > > into that for v1.19.
> 
> > Note that GCC11 indeed just switched to producing DWARF5 by default.
> > It is not released yet, but already in stage4 and Fedora will start
> > doing a mass-rebuild with it soon to shake out the last remaining bugs.
> 
> So, 1.20 will have the fix below, please check if what is in:
> 
> https://git.kernel.org/pub/scm/devel/pahole/pahole.git/log/?h=DW_AT_data_bit_offset
> 
> Fixes it for you, the cset with all the tests performed is this one:
> 
> https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=DW_AT_data_bit_offset&id=a77f039bb49bc97badf938049245f013fe3de4aa
> 
> Now looking at https://bugzilla.redhat.com/show_bug.cgi?id=1919965 ...

The XDR generated code example I give in that bug *does* appear
to be fixed when using your  DW_AT_data_bit_offset branch.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

