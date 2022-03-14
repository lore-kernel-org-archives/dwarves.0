Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAD6C433EF
	for <linux-dwarves@archiver.kernel.org>; Mon, 14 Mar 2022 11:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239819AbiCNL4b (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 14 Mar 2022 07:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239854AbiCNL4P (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 14 Mar 2022 07:56:15 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8EF4614E
        for <dwarves@vger.kernel.org>; Mon, 14 Mar 2022 04:54:54 -0700 (PDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4A3F73F32D
        for <dwarves@vger.kernel.org>; Mon, 14 Mar 2022 11:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647258893;
        bh=fylnUbXzo4yUjxMkTUNwB5QgjBBiwp7cJvFpf/O+wNA=;
        h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
        b=gQz1AOj6c7rBfK7yND6jQDNitOM6aTWyw68He1+zjylniKSYjLiJ/F5cSUrdqf7pE
         Fce172+ZNE64nNlNrKWXcgUVw1V0vJs/CpJCNZvy45hpEj3ZrGQxIbvwO6k8hqBQ0v
         kCRzB8cLETkGS9LQxrQNPffb2bIlv/go7zZ6A3M6bfvL1VTo13gRvJp0CRDzq9k2Vb
         bL6VuwP5cFXDUJI4IBhqMqJuz7gue5YHufwg7g7Zh/cringH9SyrHKtkMyo4qSN3qY
         KaX6kkRYAmvxFG7w1+wxz3xaTviGWZ6Vv9Vp5Pq00IsYah9pjIICGaahmqCmdWfpvR
         wfZUzzPaI08Xw==
Received: by mail-io1-f70.google.com with SMTP id u10-20020a5ec00a000000b00648e5804d5bso4114108iol.12
        for <dwarves@vger.kernel.org>; Mon, 14 Mar 2022 04:54:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=fylnUbXzo4yUjxMkTUNwB5QgjBBiwp7cJvFpf/O+wNA=;
        b=y5pSTFb7WD+UVqcZTFzKGKDyjkAjADQ/E66oTYiy7mS30PA6U9qH7LgFYCNtNEDpNd
         5Sio6hUmInhvz0L3f2vWg0L/IoTeFXB0yWmaI3CqrJMEjDQS0+6O/BNR3x4eGCCGkwha
         lo2XWZXWnn7k50lQ4J4fWCQwaBsDamy/uolq+ji0VRcW+hVsOkYOa5VdgGcy7asgLR2X
         tAqg6eCOKzoly9ijKxKO0wC+OsZxQp1qU4w2Sd74RlD6tWkBs1F9lop+k2JoTiO/gVIQ
         jlGqpPpJ0Pae8fdbknpch/IZYo0HWQlvmgqjS+sLCrAU1QxPo8WM3J0cFq944NFGAYLR
         xbaw==
X-Gm-Message-State: AOAM532Zz3p9XtJcdco/x3Qi3RREFekauX0CXZIvAfRn6xk6REpZsgyZ
        OrMSSAlhz4tvPTXJcfLdtnTWwudiM0w9QxaTTUXeSei/3txJiCE2P6NHV3GA7U18TSZ8tQaKOK9
        h6lk2ntU0RB6B/RxIUzXGZOaRK2RNArejNslMOvLRsxKRQsR0vq4=
X-Received: by 2002:a05:6e02:1685:b0:2c7:74c6:ca2f with SMTP id f5-20020a056e02168500b002c774c6ca2fmr13450877ila.288.1647258892125;
        Mon, 14 Mar 2022 04:54:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTAOQg3+MlqM5NzeByK0JlYQg5ysrQhO248AuAKMeZyinfOUmWkjM5egBA9tHJKjU7sGB9/b7y9F/XDJsIKK4=
X-Received: by 2002:a05:6e02:1685:b0:2c7:74c6:ca2f with SMTP id
 f5-20020a056e02168500b002c774c6ca2fmr13450865ila.288.1647258891890; Mon, 14
 Mar 2022 04:54:51 -0700 (PDT)
MIME-Version: 1.0
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Date:   Mon, 14 Mar 2022 11:54:16 +0000
Message-ID: <CADWks+YV821nBhB42GYG9YmNLXEcW1yjkeOvHVVLJ_O_BWcmPQ@mail.gmail.com>
Subject: How to make better debug builds of kernels in distributions?
To:     dwarves@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

As a Linux distribution I would like to build kernels quickly, without
using too much disk space, have debug symbols enabled, but packaged
separately as an optional install (due to their large size).

Whilst userspace tooling is fairly optimized, it doesn't seem to be
the case for kernel builds.
And when I try to use the same techniques or methods for the kernel
builds, the tooling seems to fall apart.

I am curious to know if the below mentioned problems are known, being
worked on, or if there is anything I can do to improve things.

Most Linux distributions for userspace binaries today build binaries
with debug symbols, then strip them by build id into and then run dwz
on them to further optimize them.

I would like to do the same or similar for kernels, but having little
luck so far.

Recently it was enabled to use CONFIG_DEBUG_INFO_DWARF5 option for
kernel builds, whilst keeping CONFIG_DEBUG_INFO_BTF and
CONFIG_DEBUG_INFO_BTF_MODULES=y features on, as pahole has supported
parsing DWARVES5 for a while. That's nice.

CONFIG_DEBUG_INFO_SPLIT option looks nice, but turning that on breaks
CONFIG_DEBUG_INFO_BTF_MODULES as pahole fails to process .dwo files.

Also nothing seems to install .dwo files, thus an unstripped/debug
build install of modules doesn't install all the .dwo files.

But pahole can process .dwp that is a packaging of .dwo produced by
dwp utility. But that leads to no joy either, as dwp segfaults on
DWARF5 .dwo files and .dwp files are not shipped and can't be locate
by like a filepath note / shipped in by build-id directories, as they
have to be called $EXE.dwp to be usable. I guess I could create .dwp
files temporary to generate pahole BTF information, whilst shipping
.dwo files for debugging. If/when dwp is fixed for DWARF5.

Separately I've tried detaching and/or optimizing debug symbols using
dwz, which fails on kernels as it's not a supported binary type.

I wish I could use DWARF5, split dwarve, have a working pahole/BTF,
and optimize/pack all the debug symbols for a kernel build and its
module, to hopefully reduce the size of kernel debug symbols packages
in the distributions. But it seems that all of my attempts are so far
futile.

Are the above mentioned issues known? Worth fixing? Are they the best
strategy or is there something else I can do?

-- 
Regards,

Dimitri.
