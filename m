Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118D1C4338F
	for <linux-dwarves@archiver.kernel.org>; Thu, 12 Aug 2021 21:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D21836103A
	for <linux-dwarves@archiver.kernel.org>; Thu, 12 Aug 2021 21:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbhHLVuh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 12 Aug 2021 17:50:37 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:42998 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbhHLVuh (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 12 Aug 2021 17:50:37 -0400
Received: by mail-oi1-f180.google.com with SMTP id t35so12721657oiw.9
        for <dwarves@vger.kernel.org>; Thu, 12 Aug 2021 14:50:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=acNAz6RScH9Ml2UWZh8J0dzTVnDbK0LDLos5UesmwKE=;
        b=YIVMFVM3Tsc/dmwcFG37ajAnkYl4I79Ch8rM7XN4+aXnuHJiTxnnSzOHQX+9jGPD1U
         HbmXDSqyceh8gypiLmYhKljAi2YK0pIzM87TDRv2poJx5MA/WLeU/w7p/gwNgFxaWjD9
         6lPTBmWM7YsJTOWfzZ4D/Lp9++x0WbcL45VikCXzWtKT9spYCeo5WMXbPOj4BrOKdV7D
         51AcXGjVc+dUy3y9wP3p1hSZqxaBw+ysd9X+tG6nBQ9hATund3Rbds3Igvd2P9E77ICz
         yPFTWRqDNx2cyYcodUN2K4Qu6/+RSlL2feNmudg2j4gVnjpvtAycd656c2BI95zGQ0te
         lc5A==
X-Gm-Message-State: AOAM531ESU3jLKQQ2w7Dtebyf3a8ttn8PFghZ8OLPUkooXhhm4f7hvKZ
        aKoRBU52BdB5jFJ/Kx3kueIlpvCvRA7KEdPV
X-Google-Smtp-Source: ABdhPJz+G29Omf8SV2pKBU6Btmv+GtDPZSSqqLYj3d2b3XZMhV7e6UWtbXFjqvfpKReBTy3Jkgodvw==
X-Received: by 2002:a05:6808:1d1:: with SMTP id x17mr12988532oic.69.1628805011576;
        Thu, 12 Aug 2021 14:50:11 -0700 (PDT)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com. [209.85.210.50])
        by smtp.gmail.com with ESMTPSA id h6sm350523otu.16.2021.08.12.14.50.11
        for <dwarves@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 14:50:11 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id a7-20020a9d5c870000b029050333abe08aso9576856oti.13
        for <dwarves@vger.kernel.org>; Thu, 12 Aug 2021 14:50:11 -0700 (PDT)
X-Received: by 2002:a9d:5d14:: with SMTP id b20mr5174264oti.307.1628805010995;
 Thu, 12 Aug 2021 14:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <YRVv1iAX48euE5MO@kernel.org> <YRVxNEPEspmuHcKr@kernel.org>
In-Reply-To: <YRVxNEPEspmuHcKr@kernel.org>
From:   Luca Boccassi <bluca@debian.org>
Date:   Thu, 12 Aug 2021 22:50:00 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnSkjDrvKtzcySn5TXoTwdfnkMe5FrUKidZdpFV87jhTAw@mail.gmail.com>
Message-ID: <CAMw=ZnSkjDrvKtzcySn5TXoTwdfnkMe5FrUKidZdpFV87jhTAw@mail.gmail.com>
Subject: Re: pahole: Problems with lib/include/bpf symlink in a tarball with --transform
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Frank Heckenbach <f.heckenbach@fh-soft.de>, dwarves@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Thu, 12 Aug 2021 at 20:06, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Thu, Aug 12, 2021 at 04:00:38PM -0300, Arnaldo Carvalho de Melo escreveu:
> > [acme@seventh pahole]$ ls -la dwarves-1.22/lib/include/
> > total 8
> > drwxr-xr-x. 2 acme acme 4096 Aug 12 15:54 .
> > drwxr-xr-x. 4 acme acme 4096 Aug 12 15:54 ..
> > lrwxrwxrwx. 1 acme acme   23 Jun 18 17:56 bpf -> dwarves-1.22/../bpf/src
> > [acme@seventh pahole]$
>
> Ok, including the parent directory and then replacing it with the
> desired package_name-package_version did the trick ;-)
>
> ⬢[acme@toolbox pahole]$ v=1.$(($(git tag | sort -V | tail -1 | cut -d. -f2) + 1)) ; tar cvfJ ~/rpmbuild/SOURCES/dwarves-${v}.tar.xz --transform "s,^pahole/,dwarves-${v}/," `sed s%^%../pahole/%g MANIFEST`
> ⬢[acme@toolbox pahole]$ tar tvf ~/rpmbuild/SOURCES/dwarves-1.22.tar.xz  | tail
> -rw-r--r-- acme/acme       252 2021-06-14 15:51 dwarves-1.22/lib/bpf/travis-ci/vmtest/helpers.sh
> -rwxr-xr-x acme/acme      3084 2021-06-14 15:51 dwarves-1.22/lib/bpf/travis-ci/vmtest/mkrootfs.sh
> -rwxr-xr-x acme/acme        86 2021-06-14 15:51 dwarves-1.22/lib/bpf/travis-ci/vmtest/prepare_selftests-4.9.0.sh
> -rwxr-xr-x acme/acme        86 2021-06-14 15:51 dwarves-1.22/lib/bpf/travis-ci/vmtest/prepare_selftests-5.5.0.sh
> -rwxr-xr-x acme/acme       365 2021-06-14 15:51 dwarves-1.22/lib/bpf/travis-ci/vmtest/prepare_selftests.sh
> -rwxr-xr-x acme/acme     10841 2021-06-14 15:51 dwarves-1.22/lib/bpf/travis-ci/vmtest/run.sh
> -rwxr-xr-x acme/acme      1245 2021-06-14 15:51 dwarves-1.22/lib/bpf/travis-ci/vmtest/run_selftests.sh
> -rwxr-xr-x acme/acme      1132 2021-06-14 15:51 dwarves-1.22/lib/bpf/travis-ci/vmtest/run_vmtest.sh
> -rw-r--r-- acme/acme   2904227 2021-06-14 15:51 dwarves-1.22/lib/bpf/travis-ci/vmtest/vmlinux.h
> lrwxrwxrwx acme/acme         0 2021-08-11 08:55 dwarves-1.22/lib/include/bpf -> ../bpf/src
> ⬢[acme@toolbox pahole]$
>
> yeah, it now builds from the generated tarball, updating README.tarball 8-)
>
> - Arnaldo

Glad to hear you found a fix - I would have had no idea :-)

Kind regards,
Luca Boccassi
