Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F00C4338F
	for <linux-dwarves@archiver.kernel.org>; Wed, 28 Jul 2021 18:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9926161051
	for <linux-dwarves@archiver.kernel.org>; Wed, 28 Jul 2021 18:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhG1SLx (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 28 Jul 2021 14:11:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:48590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229542AbhG1SLx (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Wed, 28 Jul 2021 14:11:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8718861052;
        Wed, 28 Jul 2021 18:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627495911;
        bh=JsxoFI/5p6fjIwPJYIDZsWbds/Q72dQdJf3893v8M+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QTBPhu9axmx5PvW32LWIc4iJLAmLnccMwZUp5VhWmaP6jQTq7A1WaTg6SIXJCTy8P
         WxGDc+/1CnPIGyqo77OPihygPACdJYd+SBXtTZb0Mulmh+UxJyWl++XqDNU/DWei3L
         oUSiPE4GTYC62xrv2mE1IsVLYMCVZfW55UdwqhBi3J2tYKkDRoaWuJzEZA8itweLpz
         g5F2jf2UPIM/BILQYBePkBTe4+v3+8QeihhJEeJ3xzDwnfJCi0milBoIkkIIDkWoFr
         JQ404AbnrdoH5KyR6rb4kdmWdp4E+imtFpHoj9EWbySTs+eRW+S5gKWgexbO5F75mh
         cPqJscq6ZheuQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 93051403F2; Wed, 28 Jul 2021 15:11:47 -0300 (-03)
Date:   Wed, 28 Jul 2021 15:11:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     dwarves@vger.kernel.org
Subject: Re: [PATCH] dwarves: Initialize cu->priv explicitly
Message-ID: <YQGd4x5hVyw8Epxt@kernel.org>
References: <20210728175459.143265-1-thomas@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210728175459.143265-1-thomas@t-8ch.de>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Wed, Jul 28, 2021 at 07:54:59PM +0200, Thomas Weißschuh escreveu:
> Otherweise ->priv may contain garbage data.
> This triggers a bug where the BTF loader thinks that the private data
> has been set and wants to free it, crashing the program.
> 
> The bug is not reproducible with all binaries. A test file is
> /usr/lib/libevdev.so.2.3.0 from
> https://archive.archlinux.org/packages/l/libevdev/libevdev-1.11.0-1-x86_64.pkg.tar.zst
> 
> Stacktrace:
>  Program terminated with signal SIGSEGV, Segmentation fault.
>  #0  0x00007f0c4cacfc49 in btf__free (btf=0x20) at lib/bpf/src/btf.c:729
>  729		if (btf->fd >= 0)
>  #1  0x00007f0c4cac2d20 in btf__cu_delete (cu=0x555d89203670) at btf_loader.c:536
>  #2  0x00007f0c4caaca44 in cu__delete (cu=0x555d89203670) at dwarves.c:630
>  #3  0x00007f0c4cac2f4d in cus__load_btf (cus=0x555d89203140, conf=0x555d8863f360 <conf_load>,
>      filename=0x7fff8fb8327e "/usr/lib/libevdev.so.2.3.0") at btf_loader.c:595
>  #4  0x00007f0c4caafc18 in cus__load_file (cus=0x555d89203140, conf=0x555d8863f360 <conf_load>,
>      filename=0x7fff8fb8327e "/usr/lib/libevdev.so.2.3.0") at dwarves.c:1993
>  #5  0x00007f0c4cab0988 in cus__load_files (cus=0x555d89203140, conf=0x555d8863f360 <conf_load>,
>      filenames=0x7fff8fb815f0) at dwarves.c:2352
>  #6  0x0000555d88638d6d in main (argc=2, argv=0x7fff8fb815e8) at pahole.c:2842
> 
> Fixes: 7fb31d787d3deec191527ca010c74888f4acd765 btf_loader: Stop using libbtf.h and the btf_elf class
> Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
> ---
>  dwarves.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/dwarves.c b/dwarves.c
> index 34f581d..ed0037d 100644
> --- a/dwarves.c
> +++ b/dwarves.c
> @@ -576,6 +576,8 @@ struct cu *cu__new(const char *name, uint8_t addr_size,
>  		if (cu->filename == NULL)
>  			goto out_free_name;
>  
> +		cu->priv = NULL;
> +
>  		ptr_table__init(&cu->tags_table);
>  		ptr_table__init(&cu->types_table);
>  		ptr_table__init(&cu->functions_table);
> 
> base-commit: 3ec54ee72ff7c5b169252972f69007b54e2f9211
> -- 

Yeah, I noticed it and fixed it in the 'next' (also named 'tmp.master')
branch, will cherry-pick it into master and add an Reported-by: you:

⬢[acme@toolbox pahole]$ git show e9f3028efbeff225d8ced3c0bfa9fe82857b0a14
commit e9f3028efbeff225d8ced3c0bfa9fe82857b0a14
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Fri Jun 25 16:56:35 2021 -0300

    core: Initialize cu->priv in cu__new()

    cus__load_btf() may bail out if btf__parse_split() fails, for instance
    when processing a malformed detached BTF file, and then call
    cu__delete(cu) that in turn calls btf__cu_delete(cu->priv), and as
    cu->priv wasn't initialized, a segfault ensues.

    Fix it by initializing cu->priv in cu__new().

    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/dwarves.c b/dwarves.c
index f1135c5980b416af..7d693b6805585238 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -623,6 +623,7 @@ struct cu *cu__new(const char *name, uint8_t addr_size,
                cu->build_id_len           = build_id_len;
                if (build_id_len > 0)
                        memcpy(cu->build_id, build_id, build_id_len);
+               cu->priv = NULL;
        }

        return cu;
⬢[acme@toolbox pahole]$
