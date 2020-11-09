Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DBCC2D0A3
	for <linux-dwarves@archiver.kernel.org>; Mon,  9 Nov 2020 18:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFC642067C
	for <linux-dwarves@archiver.kernel.org>; Mon,  9 Nov 2020 18:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="x5Kuhv9Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbgKISG7 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 9 Nov 2020 13:06:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:49538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730096AbgKISG6 (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Mon, 9 Nov 2020 13:06:58 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4954820678;
        Mon,  9 Nov 2020 18:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604945217;
        bh=dijdvBcDiircNIDUG+ffeYVan80Xiwi/kPgWagbyrOQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x5Kuhv9YNv+EL2wmz57R93mDOXEhJFBjutEbS7c5rw7ZO1mU1m2kvG/PfVcjsoimE
         XAmOVq8el+TtplysNtbLRKCRg1LaxZWWY4CvgCxaon8unbaPmx8A7rju0htJ3YdZEj
         sJKXMHOe12NOsm1GPuZ6ctmmscZJoNZw9u80/stk=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3F4AF411D1; Mon,  9 Nov 2020 15:06:55 -0300 (-03)
Date:   Mon, 9 Nov 2020 15:06:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>,
        dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Hao Luo <haoluo@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Subject: Re: [PATCH 1/3] bpf: Move iterator functions into special init
 section
Message-ID: <20201109180655.GD340169@kernel.org>
References: <20201106222512.52454-1-jolsa@kernel.org>
 <20201106222512.52454-2-jolsa@kernel.org>
 <20201109180500.GC340169@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109180500.GC340169@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Mon, Nov 09, 2020 at 03:05:00PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Nov 06, 2020 at 11:25:10PM +0100, Jiri Olsa escreveu:
> > With upcoming changes to pahole, that change the way how and
> > which kernel functions are stored in BTF data, we need a way
> > to recognize iterator functions.
> > 
> > Iterator functions need to be in BTF data, but have no real
> > body and are currently placed in .init.text section, so they
> > are freed after kernel init and are filtered out of BTF data
> > because of that.
> > 
> > The solution is to place these functions under new section:
> >   .init.bpf.preserve_type
> > 
> > And add 2 new symbols to mark that area:
> >   __init_bpf_preserve_type_begin
> >   __init_bpf_preserve_type_end
> > 
> > The code in pahole responsible for picking up the functions will
> > be able to recognize functions from this section and add them to
> > the BTF data and filter out all other .init.text functions.
> 
> This isn't applying on torvalds/master:
> 
> [acme@five linux]$ patch -p1 < /wb/1.patch
> patching file include/asm-generic/vmlinux.lds.h
> Hunk #2 succeeded at 754 (offset 1 line).
> patching file include/linux/bpf.h
> Hunk #1 succeeded at 1276 (offset -1 lines).
> patching file include/linux/init.h
> Hunk #1 FAILED at 52.
> 1 out of 1 hunk FAILED -- saving rejects to file include/linux/init.h.rej
> [acme@five linux]$
> [acme@five linux]$ cat include/linux/init.h.rej
> --- include/linux/init.h
> +++ include/linux/init.h
> @@ -52,6 +52,7 @@
>  #define __initconst	__section(.init.rodata)
>  #define __exitdata	__section(.exit.data)
>  #define __exit_call	__used __section(.exitcall.exit)
> +#define __init_bpf_preserve_type __section(.init.bpf.preserve_type)
> 
>  /*
>   * modpost check for section mismatches during the kernel build.
> [acme@five linux]$
> 
> 
> I'm fixing it up by hand to try together with pahole's patches.

Due to:

33def8498fdde180 ("treewide: Convert macro and uses of __section(foo) to __section("foo")")

I'm using this now:

diff --git a/include/linux/init.h b/include/linux/init.h
index 7b53cb3092ee9956..a7c71e3b5f9a1d65 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -52,6 +52,7 @@
 #define __initconst	__section(".init.rodata")
 #define __exitdata	__section(".exit.data")
 #define __exit_call	__used __section(".exitcall.exit")
+#define __init_bpf_preserve_type __section(".init.bpf.preserve_type")
 
 /*
  * modpost check for section mismatches during the kernel build.
