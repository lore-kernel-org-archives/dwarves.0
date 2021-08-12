Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DFEC4338F
	for <linux-dwarves@archiver.kernel.org>; Thu, 12 Aug 2021 19:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E52D0603E7
	for <linux-dwarves@archiver.kernel.org>; Thu, 12 Aug 2021 19:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235915AbhHLTG6 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 12 Aug 2021 15:06:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:32948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235886AbhHLTG5 (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Thu, 12 Aug 2021 15:06:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6351E60C3F;
        Thu, 12 Aug 2021 19:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628795191;
        bh=0Jpn6zQkmsXWIdbgrngyCQEfJMIGzXeZzZNz1YFSt/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kh/DlJkNsDG5kKT6ngn1PZUYYVGOi9QyQS576Da/zzTY4WiW3XssrePz7sit+0Cpw
         iZ/as2Dfu0qpCkRDGjRDmOaqrH53EyuWp6K0fsl4ERT5PC0MN841MmrWYxsoz77/ay
         IyHY3a4Mb2t17uCoVAbm7T96Ce61U56yo4bWl62OR/bpq1T1wmw+ZkJQ8kbhSHol1i
         OFJdTrxo1nV/13ow/vQX3EaLTPZ/BTQhmpoP+W9FzDCf7cBgn6Kwx/8muc0+iruVn5
         LG9uHB0/neHTmya7awsS61ymoCdEt5iY7QhsnxKfYBWrYoNox02b175lcYUKEFABEM
         EF9p4Zdhre8iQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C38BD403F2; Thu, 12 Aug 2021 16:06:28 -0300 (-03)
Date:   Thu, 12 Aug 2021 16:06:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Luca Boccassi <bluca@debian.org>
Cc:     Frank Heckenbach <f.heckenbach@fh-soft.de>, dwarves@vger.kernel.org
Subject: Re: pahole: Problems with lib/include/bpf symlink in a tarball with
 --transform
Message-ID: <YRVxNEPEspmuHcKr@kernel.org>
References: <YRVv1iAX48euE5MO@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YRVv1iAX48euE5MO@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Thu, Aug 12, 2021 at 04:00:38PM -0300, Arnaldo Carvalho de Melo escreveu:
> [acme@seventh pahole]$ ls -la dwarves-1.22/lib/include/
> total 8
> drwxr-xr-x. 2 acme acme 4096 Aug 12 15:54 .
> drwxr-xr-x. 4 acme acme 4096 Aug 12 15:54 ..
> lrwxrwxrwx. 1 acme acme   23 Jun 18 17:56 bpf -> dwarves-1.22/../bpf/src
> [acme@seventh pahole]$

Ok, including the parent directory and then replacing it with the
desired package_name-package_version did the trick ;-)

⬢[acme@toolbox pahole]$ v=1.$(($(git tag | sort -V | tail -1 | cut -d. -f2) + 1)) ; tar cvfJ ~/rpmbuild/SOURCES/dwarves-${v}.tar.xz --transform "s,^pahole/,dwarves-${v}/," `sed s%^%../pahole/%g MANIFEST`
⬢[acme@toolbox pahole]$ tar tvf ~/rpmbuild/SOURCES/dwarves-1.22.tar.xz  | tail
-rw-r--r-- acme/acme       252 2021-06-14 15:51 dwarves-1.22/lib/bpf/travis-ci/vmtest/helpers.sh
-rwxr-xr-x acme/acme      3084 2021-06-14 15:51 dwarves-1.22/lib/bpf/travis-ci/vmtest/mkrootfs.sh
-rwxr-xr-x acme/acme        86 2021-06-14 15:51 dwarves-1.22/lib/bpf/travis-ci/vmtest/prepare_selftests-4.9.0.sh
-rwxr-xr-x acme/acme        86 2021-06-14 15:51 dwarves-1.22/lib/bpf/travis-ci/vmtest/prepare_selftests-5.5.0.sh
-rwxr-xr-x acme/acme       365 2021-06-14 15:51 dwarves-1.22/lib/bpf/travis-ci/vmtest/prepare_selftests.sh
-rwxr-xr-x acme/acme     10841 2021-06-14 15:51 dwarves-1.22/lib/bpf/travis-ci/vmtest/run.sh
-rwxr-xr-x acme/acme      1245 2021-06-14 15:51 dwarves-1.22/lib/bpf/travis-ci/vmtest/run_selftests.sh
-rwxr-xr-x acme/acme      1132 2021-06-14 15:51 dwarves-1.22/lib/bpf/travis-ci/vmtest/run_vmtest.sh
-rw-r--r-- acme/acme   2904227 2021-06-14 15:51 dwarves-1.22/lib/bpf/travis-ci/vmtest/vmlinux.h
lrwxrwxrwx acme/acme         0 2021-08-11 08:55 dwarves-1.22/lib/include/bpf -> ../bpf/src
⬢[acme@toolbox pahole]$

yeah, it now builds from the generated tarball, updating README.tarball 8-)

- Arnaldo
