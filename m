Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F63EC4338F
	for <linux-dwarves@archiver.kernel.org>; Fri, 13 Aug 2021 00:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61AC06104F
	for <linux-dwarves@archiver.kernel.org>; Fri, 13 Aug 2021 00:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbhHMAF6 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 12 Aug 2021 20:05:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:58326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229601AbhHMAF6 (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Thu, 12 Aug 2021 20:05:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C20F60FC3;
        Fri, 13 Aug 2021 00:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628813132;
        bh=l4ohKZMMYNuYzkwyf4HuGCwCOgVRI/aCKToTZ9ASAmo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uiPvyKsa3nZ1gpRspcm6X2gQlbH/tH155fJr/3/xJauOEu/DbPeua9VF77Ca1zkuy
         tTk1rMQrmJV/Se0W+1DK1chVdkDpG2eivUQwrj/Wm3spWSlFTZscYVWLK8uif5UKCp
         F7VXN4VdKSpxu9jr4WAI9bayh+XLO1nWtWPR1u2Zx4uvLv+Hif2/dcfCgJ2IkQ7h1T
         Rgyxdy+uOcKxE2NT+g4XHqUHD6mhkVoEHqnjeMTUrYi2+CA34MRNU7KKPKGl5U1DgF
         XfZU+eGK90nNApX8ObfIV52e5De9Q0dpQy3woyGWCRssiXE6YgJLLpdtj7yC3EQdD4
         E1hGPLmLjoxlQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 23EED403F2; Thu, 12 Aug 2021 21:05:29 -0300 (-03)
Date:   Thu, 12 Aug 2021 21:05:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Luca Boccassi <bluca@debian.org>
Cc:     Frank Heckenbach <f.heckenbach@fh-soft.de>, dwarves@vger.kernel.org
Subject: Re: pahole: Problems with lib/include/bpf symlink in a tarball with
 --transform
Message-ID: <YRW3SRQtoOtEyUem@kernel.org>
References: <YRVv1iAX48euE5MO@kernel.org>
 <YRVxNEPEspmuHcKr@kernel.org>
 <CAMw=ZnSkjDrvKtzcySn5TXoTwdfnkMe5FrUKidZdpFV87jhTAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMw=ZnSkjDrvKtzcySn5TXoTwdfnkMe5FrUKidZdpFV87jhTAw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Thu, Aug 12, 2021 at 10:50:00PM +0100, Luca Boccassi escreveu:
> On Thu, 12 Aug 2021 at 20:06, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Em Thu, Aug 12, 2021 at 04:00:38PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > [acme@seventh pahole]$ ls -la dwarves-1.22/lib/include/
> > > total 8
> > > drwxr-xr-x. 2 acme acme 4096 Aug 12 15:54 .
> > > drwxr-xr-x. 4 acme acme 4096 Aug 12 15:54 ..
> > > lrwxrwxrwx. 1 acme acme   23 Jun 18 17:56 bpf -> dwarves-1.22/../bpf/src
> > > [acme@seventh pahole]$

> > Ok, including the parent directory and then replacing it with the
> > desired package_name-package_version did the trick ;-)

> > ⬢[acme@toolbox pahole]$ v=1.$(($(git tag | sort -V | tail -1 | cut -d. -f2) + 1)) ; tar cvfJ ~/rpmbuild/SOURCES/dwarves-${v}.tar.xz --transform "s,^pahole/,dwarves-${v}/," `sed s%^%../pahole/%g MANIFEST`
> > ⬢[acme@toolbox pahole]$ tar tvf ~/rpmbuild/SOURCES/dwarves-1.22.tar.xz  | tail
> > -rw-r--r-- acme/acme       252 2021-06-14 15:51 dwarves-1.22/lib/bpf/travis-ci/vmtest/helpers.sh
> > -rwxr-xr-x acme/acme      3084 2021-06-14 15:51 dwarves-1.22/lib/bpf/travis-ci/vmtest/mkrootfs.sh
> > -rwxr-xr-x acme/acme        86 2021-06-14 15:51 dwarves-1.22/lib/bpf/travis-ci/vmtest/prepare_selftests-4.9.0.sh
> > -rwxr-xr-x acme/acme        86 2021-06-14 15:51 dwarves-1.22/lib/bpf/travis-ci/vmtest/prepare_selftests-5.5.0.sh
> > -rwxr-xr-x acme/acme       365 2021-06-14 15:51 dwarves-1.22/lib/bpf/travis-ci/vmtest/prepare_selftests.sh
> > -rwxr-xr-x acme/acme     10841 2021-06-14 15:51 dwarves-1.22/lib/bpf/travis-ci/vmtest/run.sh
> > -rwxr-xr-x acme/acme      1245 2021-06-14 15:51 dwarves-1.22/lib/bpf/travis-ci/vmtest/run_selftests.sh
> > -rwxr-xr-x acme/acme      1132 2021-06-14 15:51 dwarves-1.22/lib/bpf/travis-ci/vmtest/run_vmtest.sh
> > -rw-r--r-- acme/acme   2904227 2021-06-14 15:51 dwarves-1.22/lib/bpf/travis-ci/vmtest/vmlinux.h
> > lrwxrwxrwx acme/acme         0 2021-08-11 08:55 dwarves-1.22/lib/include/bpf -> ../bpf/src
> > ⬢[acme@toolbox pahole]$

> > yeah, it now builds from the generated tarball, updating README.tarball 8-)
 
> Glad to hear you found a fix - I would have had no idea :-)

Now you have, but hopefully will forget about it soon. At least we have
this in place:

https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=next&id=0954ebc2f957cf2e90765479f64a4e8784f76a75

Its like that Debian bug from Frank does: documents what that
--transform is doing so that we don't scratch our heads that much :-)

- Arnaldo
