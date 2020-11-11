Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C98C388F7
	for <linux-dwarves@archiver.kernel.org>; Wed, 11 Nov 2020 00:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A43B20867
	for <linux-dwarves@archiver.kernel.org>; Wed, 11 Nov 2020 00:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGmCXLVd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731657AbgKKAO3 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 10 Nov 2020 19:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbgKKAO2 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 10 Nov 2020 19:14:28 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70986C0613D1
        for <dwarves@vger.kernel.org>; Tue, 10 Nov 2020 16:14:28 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id i193so267300yba.1
        for <dwarves@vger.kernel.org>; Tue, 10 Nov 2020 16:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ADn0wKR3GxvrWmYrM7UosomKcC5kinovh34sf1A3Pgk=;
        b=BGmCXLVdJimyjfxNAhw69sWz6aogkuXauyGJHWsP3EESeKidtlxdHAfxZ6SJzGibB1
         k4w+XQVSrf2mTBDB5UIT6r0n/4XxAgigK+JXt/tirPRY/VRO4EXXPlJZbVkMOwRHc87X
         ntf4Z4Zm/Y3ddxJtjLnqFMkVK45jxkdZo+Dk8bKKuDJ94rxP6Z559/eet/7HJDJrRyvD
         OrlXhG7gGSsbLp+O61T0neRs4W7PXJcKCnLPWFqlg0UVGEibWiaCKZhCNAMDJUHUaaUL
         9pKIK7wBbIaeL//Z1fgJ4vjYyGcx4OUXWHq8ZZdVDuuIjvpTEoLYq9LHvkFmBoAOE9DH
         oVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ADn0wKR3GxvrWmYrM7UosomKcC5kinovh34sf1A3Pgk=;
        b=OuANWzTWSPW6KZPCJM4NhIm5zgNCxl8Hjnk2OOSE060iBUeyWVkKmO3eaJw1pwjEHZ
         92gEn6t0tCu6Y9oix7hv//AwHIWALt5a3vOBnadf7EJS4GWKNehPSY92HNb2V+sItPZG
         3ufXmPUE5fUZaAnB0gu9qq2tIgaraqhLxKGeLhUiyLYZpZerdF0yafmN+K93zTPsT5Z4
         yhrcSdjSGCXlg6iwzZsEZX0SiuaeI5TI2P80XnoouGKv52CcPvJiKhNevJeyKFYDZCWA
         F6FLDkJtsH0Tmq549qmisCDadoXEBfGWRJj4BDCNCycCSEU13hkjo2Fj33KnWUoHiLay
         e1IA==
X-Gm-Message-State: AOAM533fCUcZtAAgJ4UWNSUnuEOuZTuWABBbJu5aNk5bm8oCOKUTyYf7
        /K2TkfcjmFv82zHmmifnrGp/2DoGtviFoY733q0=
X-Google-Smtp-Source: ABdhPJyB7G3vRl2EO5QnPOs7MFax9edXz/PjvTelsN/pOrPmAmJtlUhaNeyg+QCx37qjTUo/e0bNnFUgC6PFB5OK6Z4=
X-Received: by 2002:a25:7717:: with SMTP id s23mr17379920ybc.459.1605053667368;
 Tue, 10 Nov 2020 16:14:27 -0800 (PST)
MIME-Version: 1.0
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 10 Nov 2020 16:14:16 -0800
Message-ID: <CAEf4BzYc6sHzGW-mmHSaTgG4zOc8S9Dxegnufbc+myr7wTmRcw@mail.gmail.com>
Subject: pahole and libdwarves linking/versioning issues
To:     Arnaldo Carvalho de Melo <acme@kernel.org>, dwarves@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Hey Arnaldo,

We use pahole pretty extensively here at Facebook, as you might
imagine, given it's a required tool to compile Linux kernel with BTF.

There are a few problems we periodically run into, all of which seems
to be related to the fact that pahole is just a thin wrapper binary on
top of libdwarves shared library.

One very common problem is when we upgrade the dwarves package from
one minor version to another one. Typically people would do

yum upgrade dwarves

And that would succeed to update the dwarves package (say 1.13 to
1.16). But when you run

pahole --version

You'll still see 1.13 (and still have 1.13 functionality, of
course)... So what happens is that pahole *the binary* was updated,
but libdwarves1 package, which is a dependency of dwarves package,
wasn't updated. And the actual version string all pretty much all of
the functionality is coming from libdwarves1. So users have to

yum upgrade libdwarves1

explicitly. Which is, of course, not an obvious and frustrating experience.

Also, whenever pahole is using some new API from libdwarves and
libdwarves is outdated, that results in spectacular failure during
dynamic linking time. Which makes sense because libdwarves doesn't
maintain API stability per se and is supposed to match 1:1 w/ pahole
version. But it all causes real logistics issues.

So I have a few questions:
1. Is there anything on the RPM spec side that could be done to
trigger libdwarves1 update when dwarves is updated and keep them in
sync down to the minor version?
2. If not, can we add an option of statically linking libdwarves into
pahole and other tools? That would eliminate all the problems
altogether at the expense of a pretty negligible slight increase in
the binary sizes.

Thanks!

-- Andrii
