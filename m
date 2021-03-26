Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075EAC433DB
	for <linux-dwarves@archiver.kernel.org>; Fri, 26 Mar 2021 15:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBE0B61A18
	for <linux-dwarves@archiver.kernel.org>; Fri, 26 Mar 2021 15:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhCZPUc (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 26 Mar 2021 11:20:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:46520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230224AbhCZPUA (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Fri, 26 Mar 2021 11:20:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35B9761A02;
        Fri, 26 Mar 2021 15:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616772000;
        bh=203eEytgbTcD6XVnZRfs1ewRDB2a3kAZxNL4f4tqSs8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EGMgjS1tbDtemI/vA7YGwjfSrYg41mIKHeQntBHzQW3zwMmzNG2BoaU3RXep9YlfT
         2AmKEt8gngJ7o4RjW1CIzVjzSc5Raf52ImAPh4izx6XcQ1abMS+OcRzLanHwRZMZSC
         aXHMuhVorhHpb6HVv/4+q9lTz+f2CbhBRjMWuabE8pU4iRwZIEo/PbmxDwxLYAsC+i
         SamNaVzk5KLVXqIMT47hXjFLQ/GpKWD4fYwRfIhATstswqebqwXifmX/BKtXtOKrpc
         DB6l+mM+fuEZ7ngDH0FKVQvupwirgVLcKmI3t5Gams3wDowky7uVa0ppWmY8hwYHtW
         0k5atDgFKVjag==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5622D40647; Fri, 26 Mar 2021 12:18:57 -0300 (-03)
Date:   Fri, 26 Mar 2021 12:18:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bill Wendling <morbo@google.com>, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH dwarves 3/3] dwarf_loader: add option to merge more dwarf
 cu's into one pahole cu
Message-ID: <YF37YQf1CKsxVdC6@kernel.org>
References: <20210325065316.3121287-1-yhs@fb.com>
 <20210325065332.3122473-1-yhs@fb.com>
 <YF3ynAKXDCE0kDpp@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YF3ynAKXDCE0kDpp@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Fri, Mar 26, 2021 at 11:41:32AM -0300, Arnaldo Carvalho de Melo escreveu:
> I'm also adding the man page patch below, now to build the kernel with
> your bpf-next patch to test it.

[acme@five bpf]$ grep CONFIG_CLANG ../build/bpf_clang_thin_lto/.config
CONFIG_CLANG_VERSION=110000
[acme@five bpf]$ grep CLANG ../build/bpf_clang_thin_lto/.config
CONFIG_CC_IS_CLANG=y
CONFIG_CLANG_VERSION=110000
CONFIG_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_HAS_LTO_CLANG=y
# CONFIG_LTO_CLANG_FULL is not set
CONFIG_LTO_CLANG_THIN=y
[acme@five bpf]$


Building now.

- Arnaldo
