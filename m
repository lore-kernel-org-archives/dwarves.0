Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E43C433FE
	for <linux-dwarves@archiver.kernel.org>; Fri, 15 Oct 2021 14:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33A2D60F93
	for <linux-dwarves@archiver.kernel.org>; Fri, 15 Oct 2021 14:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237025AbhJOOWu (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 15 Oct 2021 10:22:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:33802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234738AbhJOOWu (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Fri, 15 Oct 2021 10:22:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8A7C60FDA;
        Fri, 15 Oct 2021 14:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634307644;
        bh=KJFSrRzmqJQYgRa22geQ/yofed5FecA0PSMPF5EwzS0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RdaPb2ul7FLHXNOdJJPMALKj9LrvIwj3qy1QED3rLOmOlfAfVddi7H4tHXw9i6iV3
         esb1c5UiNFo6qVkpd1zQxbKvOSWcyYnN3TKqtoCSFlDZkznpoJGTRMSwScYAdeDXpv
         CTytjO+QTYs12l0LVLGOWfOd+GMeog/V5hDs/LVOXZ4zBbv+meu8/0pvGe09YnFcwR
         vOu3sefZIj8YcZmQY3M40wGmADR1Qua/3KkYogp4/HARr4+8QQxnMvo6ejhlzj2nFI
         Wx1X1gAjfxLyvjQdUvSy5KKf1y3Xor2rkDEctJATk7NEJD+oOZDCBm2Vr8VGHuB58u
         uBNNDJtkS/AxA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7C448410A1; Fri, 15 Oct 2021 11:20:40 -0300 (-03)
Date:   Fri, 15 Oct 2021 11:20:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Douglas RAILLARD <douglas.raillard@arm.com>
Cc:     acme@redhat.com, dwarves@vger.kernel.org
Subject: Re: [PATCH] CMakeLists.txt: Add STATIC_LINK option
Message-ID: <YWmOOP0/fF2BEd/s@kernel.org>
References: <20211015101008.486302-1-douglas.raillard@arm.com>
 <YWl/sfJLWEHGdJwV@kernel.org>
 <YWmAo8Xv5YZBlL41@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YWmAo8Xv5YZBlL41@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Fri, Oct 15, 2021 at 10:22:43AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Oct 15, 2021 at 10:18:41AM -0300, Arnaldo Carvalho de Melo escreveu:
> CMake Error at cmake/modules/FindDWARF.cmake:103 (message):
>   Could NOT find some ELF and DWARF libraries, please install the missing
>   packages
> Call Stack (most recent call first):
>   CMakeLists.txt:64 (find_package)
> 
> 
> -- Configuring incomplete, errors occurred!
> See also "/var/home/acme/git/pahole/build/CMakeFiles/CMakeOutput.log".
> ⬢[acme@toolbox build]$
> 
> Which means I don't have those static library files, will try installing
> them.

I'm trying with the latest fedora that comes with static libraries,
fedora:32, and there I noticed that we need to look for libzstd as well,
I added it manually to:

target_link_libraries(dwarves ${DWARF_LIBRARIES} ${ZLIB_LIBRARIES} ${LIBBPF_LIBRARIES} ${ARGP_LIBRARY} ${OBSTACK_LIBRARY} ${BZ2_LIBRARY} ${LZMA_LIBRARY} -lzstd)

[root@cc85f3a7b96f dwarves-1.22]# rpm -qa | grep -- -static
zlib-static-1.2.11-21.fc32.x86_64
glibc-static-2.31-6.fc32.x86_64
elfutils-devel-static-0.183-1.fc32.x86_64
xz-static-5.2.5-1.fc32.x86_64
libxcrypt-static-4.4.20-2.fc32.x86_64
libzstd-static-1.4.9-1.fc32.x86_64
elfutils-libelf-devel-static-0.183-1.fc32.x86_64
bzip2-static-1.0.8-2.fc32.x86_64
[root@cc85f3a7b96f dwarves-1.22]# cat /etc/fedora-release
Fedora release 32 (Thirty Two)
[root@cc85f3a7b96f dwarves-1.22]#

now I'm at:

/usr/bin/ld: /usr/lib/gcc/x86_64-redhat-linux/10/../../../../lib64/libdw.a(debuginfod-client.o): in function `__libdwfl_debuginfod_init':
(.text.startup[.text.startup.group]+0x1b): undefined reference to `dlopen'
/usr/bin/ld: (.text.startup[.text.startup.group]+0x36): undefined reference to `dlsym'
/usr/bin/ld: (.text.startup[.text.startup.group]+0x4f): undefined reference to `dlsym'
/usr/bin/ld: (.text.startup[.text.startup.group]+0x68): undefined reference to `dlsym'
/usr/bin/ld: (.text.startup[.text.startup.group]+0x81): undefined reference to `dlsym'
/usr/bin/ld: (.text.startup[.text.startup.group]+0xe0): undefined reference to `dlclose'

that needs some more magic that I already forgot :-\

But now out to lunch.

- Arnaldo
