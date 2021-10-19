Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3F0C433F5
	for <linux-dwarves@archiver.kernel.org>; Tue, 19 Oct 2021 15:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02A8C60F25
	for <linux-dwarves@archiver.kernel.org>; Tue, 19 Oct 2021 15:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhJSP1I (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 19 Oct 2021 11:27:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232316AbhJSP1H (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Tue, 19 Oct 2021 11:27:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB20A60FC2;
        Tue, 19 Oct 2021 15:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634657095;
        bh=S/RHfn60RsmSChuQAlB/1EZqz3J3lVslnnqfVhRnL5E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lWXP14mrNzbxqtq+k/Q604X2hacafIdC91nD61TCA1pAO7JwJSVWZZ8N9Iv/+rKKq
         Eho22gkIX5S8L3QHeSYgphDbguY6rbtbXQ9q9lAQNOvipWBw2R1hAEhU2dr0zOL9Zw
         RnAB1Ik8aXNTlwH4qJpHDsuYdPPe+tQHYcnZ+h0+rbMWPlpyUAp4pdQiX7xrG7BS+1
         IOssibu29Q9P5UlxZrlXSXbMgIY7+mFytMbQsPt+r5hAgYg9uPW74+neF2eDZZdgjz
         EzAEQtZ5ipoEI6EU5gc2Lq8L869MdUyRw6Kyx6VqjYpwAyxq9N4ecYIta6/e4klOsg
         VA266XuIWpBOw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 66425410A1; Tue, 19 Oct 2021 12:24:52 -0300 (-03)
Date:   Tue, 19 Oct 2021 12:24:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Douglas Raillard <douglas.raillard@arm.com>
Cc:     acme@redhat.com, dwarves@vger.kernel.org
Subject: Re: [PATCH] CMakeLists.txt: Add STATIC_LINK option
Message-ID: <YW7jRGV9Ny1KFEtO@kernel.org>
References: <20211015101008.486302-1-douglas.raillard@arm.com>
 <YWl/sfJLWEHGdJwV@kernel.org>
 <YWmAo8Xv5YZBlL41@kernel.org>
 <YWmOOP0/fF2BEd/s@kernel.org>
 <7718fdaa-a8ec-c86d-e5e6-149db8659529@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7718fdaa-a8ec-c86d-e5e6-149db8659529@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Mon, Oct 18, 2021 at 10:57:43AM +0100, Douglas Raillard escreveu:
> On 10/15/21 3:20 PM, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Oct 15, 2021 at 10:22:43AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Fri, Oct 15, 2021 at 10:18:41AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > CMake Error at cmake/modules/FindDWARF.cmake:103 (message):
> > >    Could NOT find some ELF and DWARF libraries, please install the missing
> > >    packages
> > > Call Stack (most recent call first):
> > >    CMakeLists.txt:64 (find_package)
> > > 
> > > 
> > > -- Configuring incomplete, errors occurred!
> > > See also "/var/home/acme/git/pahole/build/CMakeFiles/CMakeOutput.log".
> > > ⬢[acme@toolbox build]$
> > > 
> > > Which means I don't have those static library files, will try installing
> > > them.
> > 
> > I'm trying with the latest fedora that comes with static libraries,
> > fedora:32, and there I noticed that we need to look for libzstd as well,
> > I added it manually to:
> > 
> > target_link_libraries(dwarves ${DWARF_LIBRARIES} ${ZLIB_LIBRARIES} ${LIBBPF_LIBRARIES} ${ARGP_LIBRARY} ${OBSTACK_LIBRARY} ${BZ2_LIBRARY} ${LZMA_LIBRARY} -lzstd)
> > 
> > [root@cc85f3a7b96f dwarves-1.22]# rpm -qa | grep -- -static
> > zlib-static-1.2.11-21.fc32.x86_64
> > glibc-static-2.31-6.fc32.x86_64
> > elfutils-devel-static-0.183-1.fc32.x86_64
> > xz-static-5.2.5-1.fc32.x86_64
> > libxcrypt-static-4.4.20-2.fc32.x86_64
> > libzstd-static-1.4.9-1.fc32.x86_64
> > elfutils-libelf-devel-static-0.183-1.fc32.x86_64
> > bzip2-static-1.0.8-2.fc32.x86_64
> > [root@cc85f3a7b96f dwarves-1.22]# cat /etc/fedora-release
> > Fedora release 32 (Thirty Two)
> > [root@cc85f3a7b96f dwarves-1.22]#
> > 
> > now I'm at:
> > 
> > /usr/bin/ld: /usr/lib/gcc/x86_64-redhat-linux/10/../../../../lib64/libdw.a(debuginfod-client.o): in function `__libdwfl_debuginfod_init':
> > (.text.startup[.text.startup.group]+0x1b): undefined reference to `dlopen'
> > /usr/bin/ld: (.text.startup[.text.startup.group]+0x36): undefined reference to `dlsym'
> > /usr/bin/ld: (.text.startup[.text.startup.group]+0x4f): undefined reference to `dlsym'
> > /usr/bin/ld: (.text.startup[.text.startup.group]+0x68): undefined reference to `dlsym'
> > /usr/bin/ld: (.text.startup[.text.startup.group]+0x81): undefined reference to `dlsym'
> > /usr/bin/ld: (.text.startup[.text.startup.group]+0xe0): undefined reference to `dlclose'
> > 
> > that needs some more magic that I already forgot :-\
> 
> When trying on Ubuntu it also appeared that find_library() for libebl
> was also needed, but not on Alpine Linux so I did not include it, as it
> does not seem necessary on Alpine. I'm not sure how we want to go about
> these:
> 1) Take the union of all the dependencies that seem to be necessary and
> deal gracefully in CMakeLists.txt with failure to find a lib. This will
> result in linker error if a lib is actually necessary and not found.
> 2) Select a blessed distro for static building and only maintain that
> 3) Find some cmake builtin "magic" so that the user can point at
> existing lib that seem to not be detected on their distro. I'm quite
> rusty in cmake so maybe there is a better way than sprinkling
> find_library() everywhere.
> 
> So far I opted for approach 2) with Alpine, as building on e.g. Ubuntu
> will not work in any case, because glibc does not support static linking
> (it kind of does until it does not anymore). Alpine uses the musl libc
> which supports static linking.
> 
> As for the dlopen/dlsym/dlclose issue I'm not sure. Maybe these symbols
> are just not present in static glibc ? The binary I produced on Alpine
> did not seem to segfault [1]. If you want to give it a go, this scripts
> set it up in ~20s:
> https://github.com/alpinelinux/alpine-chroot-install
> 
> Packages: bash gcc git make cmake musl-dev zlib-static bzip2-static
> libelf-static libbpf-dev musl-obstack-dev argp-standalone linux-headers

I'll try with this later, thing is, I want to build on the CI for pahole
that Andrii put in place in the libbpf repo, so we need to check how to
build this static build.

- Arnaldo
 
> 
> [1] pahole static binaries:
> https://github.com/ARM-software/lisa/pull/1740/files
> > 
> > But now out to lunch.
> > 
> > - Arnaldo
> > 
> Cheer,
> Douglas
> IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.

-- 

- Arnaldo
