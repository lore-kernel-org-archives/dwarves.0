Return-Path: <SRS0=Qbgy=EC=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C13C55178
	for <linux-dwarves@archiver.kernel.org>; Tue, 27 Oct 2020 11:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5426122258
	for <linux-dwarves@archiver.kernel.org>; Tue, 27 Oct 2020 11:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603797584;
	bh=SVUyoKFSYOJYrM5c4aZcPJ359p5+CvbAwWXHw8rmRxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cMk6ih0zvd0bZHRJI8hhJU/Ehs6vQwPlEFNGTsmkFhbLFpI11mBC/UMzof+3LjA90
	 rFnTIutTbbaqfr8t4khI8Xf71aa+3dV4E/7a8JDpCcnI89Lo4gqXparaoZdKYlAguE
	 lorslFGWd+2bTDjp2G3MXDyBiyy47QhgmLUiljwo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437724AbgJ0LTn (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 27 Oct 2020 07:19:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2899138AbgJ0LTn (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Tue, 27 Oct 2020 07:19:43 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C856C204FD;
        Tue, 27 Oct 2020 11:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603797583;
        bh=SVUyoKFSYOJYrM5c4aZcPJ359p5+CvbAwWXHw8rmRxY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p0xUxT0+5IDZNYyWR06KA+17W/c0aqndwg0EjLhUG+vIzbjROd9XK2V5oRFIDu4J2
         yrcfroXG3hVWGIG2OpPrEacjAamEB32FByk5FXEcc4nmMFSw0tbTE0hldRiwv28RRm
         Jp+X0GhXQDhq3YBWqgiBtYs8GjwiQc3sD2peTkz4=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 38908403C2; Tue, 27 Oct 2020 08:19:40 -0300 (-03)
Date:   Tue, 27 Oct 2020 08:19:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Hao Luo <haoluo@google.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org
Subject: Re: [PATCH] btf_encoder: Check var type after checking var addr.
Message-ID: <20201027111940.GH2449445@kernel.org>
References: <20201026221822.29021-1-haoluo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026221822.29021-1-haoluo@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Mon, Oct 26, 2020 at 03:18:22PM -0700, Hao Luo escreveu:
> Commit 2e719cc ("btf_encoder: revamp how per-CPU variables are
> encoded") adds percpu_var_exists() to filter out the symbols that
> are not percpu var. However, the check comes after checking the
> var's type. There can be symbols that are of zero type. If we hit
> that, btf_encoder will not work without '--btf_encode_force'.
> So we should check percpu_var_exists before checking var's type.
> 
> Tested:
>  haoluo@haoluo:~/kernel/tip$ gcc --version
>  gcc (GCC) 10.2.0
>  Copyright (C) 2020 Free Software Foundation, Inc.
>  This is free software; see the source for copying conditions.  There is NO
>  warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> 
>  Before:
> 
>  haoluo@haoluo:~/kernel/tip$ make clean -s
>  haoluo@haoluo:~/kernel/tip$ make -j 32 -s
>    LINK     resolve_btfids
>  error: found variable in CU 'kernel/bpf/btf.c' that has void type
>  Encountered error while encoding BTF.
>  FAILED: load BTF from vmlinux: Unknown error -2make: *** [Makefile:1164: vmlinux] Error 255
> 
>  After:
> 
>  haoluo@haoluo:~/kernel/tip$ make clean -s
>  haoluo@haoluo:~/kernel/tip$ make -j 32 -s
>    LINK     resolve_btfids
>  haoluo@haoluo:~/kernel/tip$

Thanks, tested and applied.

- Arnaldo

 
> Fixes: 2e719cc ("btf_encoder: revamp how per-CPU variables are encoded")
> Signed-off-by: Hao Luo <haoluo@google.com>
> ---
>  btf_encoder.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 2a6455b..b5f8f3e 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -441,9 +441,12 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
>  		if (var->spec)
>  			var = var->spec;
>  
> +		if (!percpu_var_exists(addr, &size, &name))
> +			continue; /* not a per-CPU variable */
> +
>  		if (var->ip.tag.type == 0) {
> -			fprintf(stderr, "error: found variable in CU '%s' that has void type\n",
> -				cu->name);
> +			fprintf(stderr, "error: found variable '%s' in CU '%s' that has void type\n",
> +				name, cu->name);
>  			if (force)
>  				continue;
>  			err = -1;
> @@ -452,8 +455,6 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
>  
>  		type = var->ip.tag.type + type_id_off;
>  		linkage = var->external ? BTF_VAR_GLOBAL_ALLOCATED : BTF_VAR_STATIC;
> -		if (!percpu_var_exists(addr, &size, &name))
> -			continue; /* not a per-CPU variable */
>  
>  		if (btf_elf__verbose) {
>  			printf("Variable '%s' from CU '%s' at address 0x%lx encoded\n",
> -- 
> 2.29.0.rc1.297.gfa9743e501-goog
> 

-- 

- Arnaldo
