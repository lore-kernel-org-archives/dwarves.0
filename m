Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAE9C48BCF
	for <linux-dwarves@archiver.kernel.org>; Sun, 13 Jun 2021 13:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA60D6109E
	for <linux-dwarves@archiver.kernel.org>; Sun, 13 Jun 2021 13:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbhFMN3o (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Sun, 13 Jun 2021 09:29:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:53322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231286AbhFMN3o (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Sun, 13 Jun 2021 09:29:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D53D610A0;
        Sun, 13 Jun 2021 13:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623590863;
        bh=ENmtrLoPmR1heQm/lxwuujmcb4+Af5vvqkT+gRthdig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jpcmgFgrNfEIgVEMTDtB/vT/GHqBYulpniYJeJ11smOKhk0VssMkucLlfgp0RssTl
         sANlT5SEHoVdiv6sBMH2KbgDNN2UE0hI7/2TCEvgrqibU96DeJTh+kvP3K5nr17jle
         zZFkDvDozDsS074c8pfD3HfMJZstITBj0y0BJ7stoJtKyMXWyJujyuU7afjMugdyoJ
         eYywWXTKhQq0LembXXAmbebDhxISynGNqAGWAZxuMpGjHr+ZL36O2a2cYfch9QJRJS
         o+wZhSuS++krjth+Rzc/u00LKBl1OqWXtmeF8a531qTGYy5FPaP/R+75vPWA7yKR67
         rJABpbkcwEHiw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DB72040B1A; Sun, 13 Jun 2021 10:27:40 -0300 (-03)
Date:   Sun, 13 Jun 2021 10:27:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Luca Boccassi <bluca@debian.org>, dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH dwarves] Add missing lib/include/bpf -> ../bpf/src symlink
Message-ID: <YMYHzGplz+p6UJgx@kernel.org>
References: <20210611230126.57713-1-bluca@debian.org>
 <CAEf4BzYTSd1PvreyK8gsdL6=XPPqELQpz7DYAc-B=cH7L0QDKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYTSd1PvreyK8gsdL6=XPPqELQpz7DYAc-B=cH7L0QDKQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Fri, Jun 11, 2021 at 04:42:24PM -0700, Andrii Nakryiko escreveu:
> Locally I have still another issue, which I don't believe is related
> to Luca's changes. I get this error:
> 
> $ make -j60
> [ 25%] Built target bpf
> [ 26%] Building C object CMakeFiles/dwarves.dir/btf_encoder.c.o
> In file included from /usr/include/sys/stat.h:106:0,
>                  from /home/andriin/local/pahole/btf_encoder.c:24:
> /usr/include/bits/stat.h:106:31: error: expected identifier or ‘(’
> before ‘[’ token
>      __syscall_slong_t __unused[3];
>                                ^
> /usr/include/bits/stat.h:164:31: error: expected identifier or ‘(’
> before ‘[’ token
>      __syscall_slong_t __unused[3];
>                                ^
> make[2]: *** [CMakeFiles/dwarves.dir/btf_encoder.c.o] Error 1
> make[1]: *** [CMakeFiles/dwarves.dir/all] Error 2
> make: *** [all] Error 2
> 
> 
> I think it's some new interplay with dutil.h header defining its own
> 
> #define __unused __attribute__ ((unused))
> 
> Given __unused is used in vmlinux.h and /usr/include/bits/stat.h as
> field names, I think it would be better to rename __unused macro
> within pahole source code to avoid such confusing problems.

I'll fix this adopting the kernel __maybe_unused jargon.

- Arnaldo
