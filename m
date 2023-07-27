Return-Path: <dwarves-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87644C04A6A
	for <linux-dwarves@archiver.kernel.org>; Thu, 27 Jul 2023 13:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjG0NKw (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 27 Jul 2023 09:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbjG0NKo (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 27 Jul 2023 09:10:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185E93592
        for <dwarves@vger.kernel.org>; Thu, 27 Jul 2023 06:10:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A177361E77
        for <dwarves@vger.kernel.org>; Thu, 27 Jul 2023 13:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8EDAC433CD;
        Thu, 27 Jul 2023 13:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690463425;
        bh=6XtOWBOqoXRqViOpbkT/L6kPfUHrdwju/8qldGnoyDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nNXv11BxsjrMvsy0OEkh1MWpswr64xonr50/2PX69R2E14euI+UI3PbGhj06SB8Py
         LtB8AbThU8Gxtjl8PG/cY67xFhZunLjJ/Xd/a0hjTbjTdFwA5rsPzeo9AX36P4B4fK
         kxBbeb0kz8VuhMohWPZOSmc7xgUIKSD2IOlAk95h9NxZaNGX63kVvggldZ7aBe3uiP
         YTaec059Qral+eEZ/t6fx5JbwIaxvP5bNyNH4AoPRfCP69jg3YAhF0ltntNT0K+93M
         6YMWaHQi1NamVamrfBBgiqbqhO8wuw23MA9kvZg4wgzvJV7kNmzmlCBwtEPcJxepIr
         USyEaLwhOnNDA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6DAB240516; Thu, 27 Jul 2023 10:10:22 -0300 (-03)
Date:   Thu, 27 Jul 2023 10:10:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        Jiri Olsa <olsajiri@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Yonghong Song <yhs@fb.com>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RESEND] BTF is not generated for gcc-built kernel with the
 latest pahole
Message-ID: <ZMJsvpddM8M5lbex@kernel.org>
References: <20230726102534.9ebc4678ad2c9395cc9be196@kernel.org>
 <ZMDvmLdZSLi2QqB+@krava>
 <20230726200716.609d8433a7292eead95e7330@kernel.org>
 <6f0da094-5b49-954b-21e9-93f8c8cecc3f@oracle.com>
 <20230727093814.23681b2b0ac73aa89f368ae8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727093814.23681b2b0ac73aa89f368ae8@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Thu, Jul 27, 2023 at 09:38:14AM +0900, Masami Hiramatsu escreveu:
> On Wed, 26 Jul 2023 15:46:03 +0100
> Alan Maguire <alan.maguire@oracle.com> wrote:
> 
> > On 26/07/2023 12:07, Masami Hiramatsu (Google) wrote:
> > > Hi Jiri,
> > > 
> > > On Wed, 26 Jul 2023 12:04:08 +0200
> > > Jiri Olsa <olsajiri@gmail.com> wrote:
> > > 
> > >> On Wed, Jul 26, 2023 at 10:25:34AM +0900, Masami Hiramatsu wrote:
> > >>> Hello,
> > >>> (I resend this because kconfig was too big)
> > >>>
> > >>> I found that BTF is not generated for gcc-built kernel with that latest
> > >>> pahole (v1.25).
> > >>
> > >> hi,
> > >> I can't reproduce on my setup with your .config
> > >>
> > >> does 'bpftool btf dump file ./vmlinux' show any error?
> > >>
> > >> is there any error in the kernel build output?
> > > 
> > > Yes, here it is. I saw these 2 lines.
> > > 
> > > die__process: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_unit or DW_TAG_skeleton_unit expected got INVALID (0x0)!
> > > die__process: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_unit or DW_TAG_skeleton_unit expected got INVALID (0x0)!
> > 
> > This is strange, looks like some CUs were encoded incorrectly or we are
> > parsing incorrectly. The error originates in die__process() and happens
> > if the dwarf_tag() associated with the DIE isn't an expected unit; it's
> > not even a valid tag value (0) it looks like. I've not built with gcc 13
> > yet so it's possible that's the reason you're seeing this, I'll try to
> > reproduce it..
> 
> And this warning message is not good for debugging. It would better dump
> the message with DIE index so that we can analyze the DWARF with other
> tools.

Good idea, I'll add that.
 
- Arnaldo
