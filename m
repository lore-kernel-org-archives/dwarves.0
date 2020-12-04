Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00913C4361A
	for <linux-dwarves@archiver.kernel.org>; Fri,  4 Dec 2020 23:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A70DA22C9F
	for <linux-dwarves@archiver.kernel.org>; Fri,  4 Dec 2020 23:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgLDXL4 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 4 Dec 2020 18:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgLDXL4 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Fri, 4 Dec 2020 18:11:56 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5A5C0613D1
        for <dwarves@vger.kernel.org>; Fri,  4 Dec 2020 15:11:16 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id l14so6989320ybq.3
        for <dwarves@vger.kernel.org>; Fri, 04 Dec 2020 15:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ci+7PsZ7V2pwN4FqMjNc1kXgbAntWKSP632qOZ2+dPo=;
        b=RkRA/ljnE9doq6xaqpnAww5kFWLhVL8hDWFN4BVcBRFOdZWEVwjkKOxq3yb9ffWb03
         ecyd6Aa9htoX4cR9narmsxDmqaVBgNWC8xwAhg5AYTarE3CicD0AczPhKYce7GJweiRK
         8E1yFZ5nh8Y+SKA4er/Q1CnXOhmEMePbjbwGsPQ0/gj6FgJMIEDzMYXM9JJWLjRPi60f
         IUpNjGIRa/3JremUAuReldyrseZph0jwp7vnSaWieJZIerMizobG5ceqpns2+q8gnhs9
         RIBVQcnC4Dg6P1gAN5A2iz9KTXkjJPZfABr57+xxRCY4LJDnZfjij11+lpdQ0mvP7e1q
         xbtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ci+7PsZ7V2pwN4FqMjNc1kXgbAntWKSP632qOZ2+dPo=;
        b=CR6X1yAL7kjQy4JGCwJt78axW+QasUGRpEffmpxm/cREKhyn7Eiz8f5N+jvbc2FY62
         zez8NxRTzTgxyGGVVbdYhNXHKoz3Zy1pO4I2nOCf2BafzVBroxaB0fP2Y/REzuNpsvMT
         0hw4+1jMntY5FqdeEtLC1z73pRnVSyQfCG/5nPOpMOiKsp56//8XJ/t+x9tWSGMCprKt
         0M4HesrlFJ5LYp6GoYacHFDiOwlk0FkmfK3JsjyzwGJf2ordrcT1TwGa8IGQwHJQkMtH
         CHX1VZbv9w1+ENzQ9JGEefFCs91t178q5Daju6SdDFJ3jJ9/XO/6XDVfiUhb3zx0xvXV
         +xYA==
X-Gm-Message-State: AOAM533iqweu4b4dXbf+oqI4nIncSpc8xJ8B8vlW3pjrT05Q8ynbBUKP
        fMdrXTVC5FqgulF6DphhGeIlyD06klwqScGQ6XxuqGjxkm/Q7Q==
X-Google-Smtp-Source: ABdhPJzji2arxjnpkOk0YZSlgr5BWgIZ7y7p7hm7TsrJfqaRAYddmhkgPG1p2h1EJh0nzD3Z3HnS2VcGdNfQQ/G0z6s=
X-Received: by 2002:a25:df8e:: with SMTP id w136mr8874399ybg.230.1607123475167;
 Fri, 04 Dec 2020 15:11:15 -0800 (PST)
MIME-Version: 1.0
References: <CAEf4BzYc6sHzGW-mmHSaTgG4zOc8S9Dxegnufbc+myr7wTmRcw@mail.gmail.com>
 <20201113114525.GB394182@kernel.org>
In-Reply-To: <20201113114525.GB394182@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 4 Dec 2020 15:11:04 -0800
Message-ID: <CAEf4BzYKLuQ2d=PrZmy61+1Gn8uY7dHn88V4zVqDvOhJovMSsg@mail.gmail.com>
Subject: Re: pahole and libdwarves linking/versioning issues
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Matt Mullins <mmullins@fb.com>
Cc:     dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Fri, Nov 13, 2020 at 3:45 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Tue, Nov 10, 2020 at 04:14:16PM -0800, Andrii Nakryiko escreveu:
> > Hey Arnaldo,
>
> Hi Andrii,
>
> > We use pahole pretty extensively here at Facebook, as you might
> > imagine, given it's a required tool to compile Linux kernel with BTF.
>
> > There are a few problems we periodically run into, all of which seems
> > to be related to the fact that pahole is just a thin wrapper binary on
> > top of libdwarves shared library.
>
> > One very common problem is when we upgrade the dwarves package from
> > one minor version to another one. Typically people would do
>
> > yum upgrade dwarves
>
> > And that would succeed to update the dwarves package (say 1.13 to
> > 1.16). But when you run
>
> > pahole --version
>
> > You'll still see 1.13 (and still have 1.13 functionality, of
> > course)... So what happens is that pahole *the binary* was updated,
> > but libdwarves1 package, which is a dependency of dwarves package,
> > wasn't updated. And the actual version string all pretty much all of
> > the functionality is coming from libdwarves1. So users have to
>
> > yum upgrade libdwarves1
>
> > explicitly. Which is, of course, not an obvious and frustrating experience.
>
> > Also, whenever pahole is using some new API from libdwarves and
> > libdwarves is outdated, that results in spectacular failure during
> > dynamic linking time. Which makes sense because libdwarves doesn't
> > maintain API stability per se and is supposed to match 1:1 w/ pahole
> > version. But it all causes real logistics issues.
>
> > So I have a few questions:
> > 1. Is there anything on the RPM spec side that could be done to
> > trigger libdwarves1 update when dwarves is updated and keep them in
> > sync down to the minor version?
>
> So, there is this in the reference .spec file that is in pahole's git
> repo:
>
> [acme@five pahole]$ egrep '^(Requires|Name)' rpm/SPECS/dwarves.spec
> Name: dwarves
> Requires: %{libname}%{libver} = %{version}-%{release}
> Requires: %{libname}%{libver} = %{version}-%{release}
> [acme@five pahole]$ egrep '^(Requires|Name|%package)' rpm/SPECS/dwarves.spec
> Name: dwarves
> Requires: %{libname}%{libver} = %{version}-%{release}
> %package -n %{libname}%{libver}
> %package -n %{libname}%{libver}-devel
> Requires: %{libname}%{libver} = %{version}-%{release}

Ok, so I would have never noticed it, but Matt Mullins has an eagle
eye! This Requirement applies only to libdwarves1-devel package!

%package -n %{libname}%{libver} doesn't have this requirement!

Arnaldo, if you can roll it into 1.19 along the changelog timestamp
fix, that would be awesome!

> [acme@five pahole]$
>
> Someone else also reported this recently... Fedora has:
>
> [acme@five pahole]$ rpm -qR dwarves | grep ^libdwarves1
> libdwarves1 = 1.17-4.fc33
> [acme@five pahole]$
>
> So it includes both ${version} and %{release}, which should get it in
> lockstep.
>
> Having said that I'm not aware of anything using libdwarves and it was
> intended just to share those among the tools that comes in the
> 'dwarves' package, so I should have really made it internal, installed
> in /usr/libexec/dwarves/ :-\
>
> > 2. If not, can we add an option of statically linking libdwarves into
> > pahole and other tools? That would eliminate all the problems
> > altogether at the expense of a pretty negligible slight increase in
> > the binary sizes.
>
> Yeah, this looks like the way to proceed, i.e. we statically link it
> while keeping the .so around in case someone uses it, while adding some
> warning that that mode is deprecated and is going away.
>
> - Arnaldo
