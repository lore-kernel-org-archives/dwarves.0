Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DFBC4338F
	for <linux-dwarves@archiver.kernel.org>; Thu, 12 Aug 2021 19:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD3B0610A3
	for <linux-dwarves@archiver.kernel.org>; Thu, 12 Aug 2021 19:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbhHLTBH (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 12 Aug 2021 15:01:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234360AbhHLTBH (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Thu, 12 Aug 2021 15:01:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B325A6108C;
        Thu, 12 Aug 2021 19:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628794841;
        bh=LbGxag264q1au+ypBR68KeJ96CavOmvOn/yV93Yx6M4=;
        h=Date:From:To:Cc:Subject:From;
        b=dFPLtrr6W/I4tC4s8pqJm2NaGuf4vR9SYQhVSevMeEhlpWmI2iFGs1bu6pgDE4X1K
         VDAkmgs6dSDHWULzPnEljGZx627X8PHsuasYBY1XnCTafwhj+xGS65hTXUD9sO4g7X
         1d67OrYFwrR44u2kyMVa9fs7tOlxoOQZfihTSW03iJCNnfbGUo7xw2hc6mXmmCZQCP
         F67KGD9urZqUjGCfqJqAFI0q0xisvf0sf87P9jjrCc1HEGu8yw1VceajfBHRWPbidz
         NvMY2be2kLehkmHOCn4PV4bbraO3rqHDKX11i3wOW9QeKIkSYCPyKKFneefPtTixfP
         AxW7kT0S70zww==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9967B403F2; Thu, 12 Aug 2021 16:00:38 -0300 (-03)
Date:   Thu, 12 Aug 2021 16:00:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Luca Boccassi <bluca@debian.org>
Cc:     Frank Heckenbach <f.heckenbach@fh-soft.de>, dwarves@vger.kernel.org
Subject: pahole: Problems with lib/include/bpf symlink in a tarball with
 --transform
Message-ID: <YRVv1iAX48euE5MO@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Hi Luca,

	When I generate a tarball I'm not being able to build, as it
can't find bpf/btf.h, for instance, see this cset where I tried to fix
it:

commit 00cb89fb9af0355b8b4b64e26d3afa2348efb80d (HEAD -> next, five/next)
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Thu Aug 12 15:29:28 2021 -0300

    MANIFEST: Add lib/include/bpf

    The tarball wasn't working without this file:

      [ 32%] Building C object CMakeFiles/dwarves.dir/btf_encoder.c.o
      /tmp/dwarves-1.22/btf_encoder.c:18:10: fatal error: bpf/btf.h: No such file or directory
       #include <bpf/btf.h>
                ^~~~~~~~~~~
      compilation terminated.

    Cc: Luca Boccassi <bluca@debian.org>
    Fixes: 82756ea3eaf1f6e7 ("libbpf: Fixup patch to allow to use packaged version")
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/MANIFEST b/MANIFEST
index 67f382e6f8f9..88f6193d5bc0 100644
--- a/MANIFEST
+++ b/MANIFEST
@@ -68,3 +68,4 @@ libctf.c
 libctf.h
 regtest
 lib/bpf/
+lib/include/bpf
[acme@seventh pahole]$

But this doesn't help as well, as to prepare the tarball I use
tar --transform option (see README.tarball), and with lib/include/bpf
(the symlink pointing to ../bpf/src) we end up with:

[acme@seventh pahole]$ tar xvf ~/rpmbuild/SOURCES/dwarves-1.22.tar.xz | tail
dwarves-1.22/lib/bpf/include/linux/compiler.h
dwarves-1.22/lib/bpf/include/linux/list.h
dwarves-1.22/lib/bpf/include/linux/kernel.h
dwarves-1.22/lib/bpf/include/linux/err.h
dwarves-1.22/lib/bpf/CHECKPOINT-COMMIT
dwarves-1.22/lib/bpf/LICENSE
dwarves-1.22/lib/bpf/LICENSE.BSD-2-Clause
dwarves-1.22/lib/bpf/README.md
dwarves-1.22/lib/bpf/BPF-CHECKPOINT-COMMIT
dwarves-1.22/lib/include/bpf
[acme@seventh pahole]$ ls -la dwarves-1.22/lib/include/
total 8
drwxr-xr-x. 2 acme acme 4096 Aug 12 15:54 .
drwxr-xr-x. 4 acme acme 4096 Aug 12 15:54 ..
lrwxrwxrwx. 1 acme acme   23 Jun 18 17:56 bpf -> dwarves-1.22/../bpf/src
[acme@seventh pahole]$

Without the 'tar --transform' that is, on a checked out git repo:

⬢[acme@toolbox pahole]$ ls -la lib/include/bpf
lrwxrwxrwx. 1 acme acme 10 Aug 11 08:55 lib/include/bpf -> ../bpf/src
⬢[acme@toolbox pahole]$ ls -la lib/bpf/src
total 892
drwxr-xr-x. 1 acme acme    692 Aug  5 16:12 .
drwxr-xr-x. 1 acme acme    280 Jun 14 15:51 ..
<SNIP>
-rw-r--r--. 1 acme acme 123802 Jun 14 15:51 btf.c
-rw-r--r--. 1 acme acme  40953 Jun 14 15:51 btf_dump.c
-rw-r--r--. 1 acme acme  11796 Jun 14 15:51 btf.h
<SNIP>
⬢[acme@toolbox pahole]$

The problem is described in this old Debian ticket:

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=775247

I'm now trying to figure out what Frank meant when referring to that
"S" flag.

This is all on the 'next' branch, but I guess it affects master as well:

https://git.kernel.org/pub/scm/devel/pahole/pahole.git/log/?h=next

libbpf-devel has it on /usr/include/bpf/btf.h so its all ok there, but
when building it from the tarball I'm stuck with that symlink trick not
working ;-\

I have to figure out what is this 'S' flag (local symlinks, etc) or stop
using this --transform mechanism to have the dwarves-${version} top
level directory added when generating the tarball :-\

- Arnaldo
