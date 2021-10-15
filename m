Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334F3C433F5
	for <linux-dwarves@archiver.kernel.org>; Fri, 15 Oct 2021 13:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1451A60F25
	for <linux-dwarves@archiver.kernel.org>; Fri, 15 Oct 2021 13:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhJONZB (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 15 Oct 2021 09:25:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:41462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239351AbhJONYw (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Fri, 15 Oct 2021 09:24:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08F6460D07;
        Fri, 15 Oct 2021 13:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634304166;
        bh=jiL9j0icB5jl5k+/aIxpDlsTpnT8aRE7XVpCcCbZP7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gSZhfY3ac/1s67sxbpnBtC9BysojeB5ytXMNxXpt4/gEbRdqjKYvsItUhNgI1Jdlg
         /vmYwxHbbgOhj2qwRHQalQuGR+Ip/AUhEUHE7W5B1q4YnDh0BFuzJ6I6LoFZ5J0Uhi
         fqnKQzXSKyHAdOEbmC8j5p5dlgeFE+GyzgXY7sqDTe8VYlFDErFruQZ/tRXTNpkBFR
         /Io6kVrppMO2CWATpM2UkbbbiQSs5YIyz53JXU7GmXWfitN74lIXoqZQBl424P0NnF
         bOWBL4zCjDpm3T8HAURpfBuDwQ1PLPP0nHZlIApu+R4df2kTn7D3+02vYQzhB2+Z98
         nsGO5gHOUB8ow==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6A494410A1; Fri, 15 Oct 2021 10:22:43 -0300 (-03)
Date:   Fri, 15 Oct 2021 10:22:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Douglas RAILLARD <douglas.raillard@arm.com>
Cc:     acme@redhat.com, dwarves@vger.kernel.org
Subject: Re: [PATCH] CMakeLists.txt: Add STATIC_LINK option
Message-ID: <YWmAo8Xv5YZBlL41@kernel.org>
References: <20211015101008.486302-1-douglas.raillard@arm.com>
 <YWl/sfJLWEHGdJwV@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YWl/sfJLWEHGdJwV@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Fri, Oct 15, 2021 at 10:18:41AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Oct 15, 2021 at 11:10:08AM +0100, Douglas RAILLARD escreveu:
> > From: Douglas Raillard <douglas.raillard@arm.com>
> > 
> > Add a user-defined STATIC_LINK option that can be used to build a fully
> > static binary for the executables:
> > 
> >     cmake .. -DSTATIC_LINK=ON
> > 
> > This has been tested on Alpine Linux v3.14.
> 
> That is just for libdwarves. Humm, with your patch I'm getting this
> warning:
> 
> ⬢[acme@toolbox pahole]$ rm -rf build
> ⬢[acme@toolbox pahole]$ mkdir build
> ⬢[acme@toolbox pahole]$ cd build
> ⬢[acme@toolbox build]$ cmake -DSTATIC_LINK=ON ..
> -- The C compiler identification is GNU 11.2.1
> -- Detecting C compiler ABI info
> -- Detecting C compiler ABI info - done
> -- Check for working C compiler: /usr/bin/cc - skipped
> -- Detecting C compile features
> -- Detecting C compile features - done
> -- Setting BUILD_SHARED_LIBS = ON
> -- Checking availability of DWARF and ELF development libraries
> -- Looking for dwfl_module_build_id in elf
> -- Looking for dwfl_module_build_id in elf - found
> -- Found dwarf.h header: /usr/include
> -- Found elfutils/libdw.h header: /usr/include
> -- Found libdw library: /usr/lib64/libdw.so
> -- Found libelf library: /usr/lib64/libelf.so
> -- Checking availability of DWARF and ELF development libraries - done
> -- Found ZLIB: /usr/lib64/libz.so (found version "1.2.11")
> -- Checking availability of argp library
> -- Assuming argp is in libc
> -- Checking availability of argp library - done
> -- Checking availability of obstack library
> -- Assuming obstack is in libc
> -- Checking availability of obstack library - done
> -- Submodule update
> -- Submodule update - done
> -- Performing Test HAVE_REALLOCARRAY_SUPPORT
> -- Performing Test HAVE_REALLOCARRAY_SUPPORT - Success
> -- Configuring done
> -- Generating done
> CMake Warning:
>   Manually-specified variables were not used by the project:
> 
>     STATIC_LINK
> 
> 
> -- Build files have been written to: /var/home/acme/git/pahole/build
> ⬢[acme@toolbox build]$
> 
> And when I build I don't get a static binary, can you check? I'm doing a
> bit of investigation now.

Nevermind, brown paper bag on my head, this is _without_ your patch,
doh, with it I first get:

⬢[acme@toolbox build]$ cmake -DSTATIC_LINK=ON ..
-- The C compiler identification is GNU 11.2.1
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Check for working C compiler: /usr/bin/cc - skipped
-- Detecting C compile features
-- Detecting C compile features - done
-- Checking availability of DWARF and ELF development libraries
-- Please install the elfutils-libs package
-- Please install the elfutils-libelf package
CMake Error at cmake/modules/FindDWARF.cmake:103 (message):
  Could NOT find some ELF and DWARF libraries, please install the missing
  packages
Call Stack (most recent call first):
  CMakeLists.txt:64 (find_package)


-- Configuring incomplete, errors occurred!
See also "/var/home/acme/git/pahole/build/CMakeFiles/CMakeOutput.log".
⬢[acme@toolbox build]$

Which means I don't have those static library files, will try installing
them.

- Arnaldo
