Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F45C388F7
	for <linux-dwarves@archiver.kernel.org>; Fri, 13 Nov 2020 12:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCD5722240
	for <linux-dwarves@archiver.kernel.org>; Fri, 13 Nov 2020 12:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eg1aJI1T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgKMMDZ (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 13 Nov 2020 07:03:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:34930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbgKMLpa (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Fri, 13 Nov 2020 06:45:30 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E70822226;
        Fri, 13 Nov 2020 11:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605267929;
        bh=IDE+rE0gb9q30JV8pB6o8G32yO5X9Wx9WZflXw/CgsY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Eg1aJI1TNbhicHBCCwfrz0aNNSTzdfTqySktcf3+az2vgMdr0p7Em+PTh4kyWORF2
         1lxycNeJTGXP6Niv5kMBo5gwM1y/nApiBFic273fEpbTF4uc45fjCVN2QqHsL6lggw
         pvmDhUDObH3YBD6ebpCnXOiEAnOAkLqMsClW7r5Y=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 95BA3411D1; Fri, 13 Nov 2020 08:45:25 -0300 (-03)
Date:   Fri, 13 Nov 2020 08:45:25 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>
Subject: Re: pahole and libdwarves linking/versioning issues
Message-ID: <20201113114525.GB394182@kernel.org>
References: <CAEf4BzYc6sHzGW-mmHSaTgG4zOc8S9Dxegnufbc+myr7wTmRcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYc6sHzGW-mmHSaTgG4zOc8S9Dxegnufbc+myr7wTmRcw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Tue, Nov 10, 2020 at 04:14:16PM -0800, Andrii Nakryiko escreveu:
> Hey Arnaldo,

Hi Andrii,
 
> We use pahole pretty extensively here at Facebook, as you might
> imagine, given it's a required tool to compile Linux kernel with BTF.
 
> There are a few problems we periodically run into, all of which seems
> to be related to the fact that pahole is just a thin wrapper binary on
> top of libdwarves shared library.
 
> One very common problem is when we upgrade the dwarves package from
> one minor version to another one. Typically people would do
 
> yum upgrade dwarves
 
> And that would succeed to update the dwarves package (say 1.13 to
> 1.16). But when you run
 
> pahole --version
 
> You'll still see 1.13 (and still have 1.13 functionality, of
> course)... So what happens is that pahole *the binary* was updated,
> but libdwarves1 package, which is a dependency of dwarves package,
> wasn't updated. And the actual version string all pretty much all of
> the functionality is coming from libdwarves1. So users have to
 
> yum upgrade libdwarves1
 
> explicitly. Which is, of course, not an obvious and frustrating experience.
 
> Also, whenever pahole is using some new API from libdwarves and
> libdwarves is outdated, that results in spectacular failure during
> dynamic linking time. Which makes sense because libdwarves doesn't
> maintain API stability per se and is supposed to match 1:1 w/ pahole
> version. But it all causes real logistics issues.
 
> So I have a few questions:
> 1. Is there anything on the RPM spec side that could be done to
> trigger libdwarves1 update when dwarves is updated and keep them in
> sync down to the minor version?

So, there is this in the reference .spec file that is in pahole's git
repo:

[acme@five pahole]$ egrep '^(Requires|Name)' rpm/SPECS/dwarves.spec
Name: dwarves
Requires: %{libname}%{libver} = %{version}-%{release}
Requires: %{libname}%{libver} = %{version}-%{release}
[acme@five pahole]$ egrep '^(Requires|Name|%package)' rpm/SPECS/dwarves.spec
Name: dwarves
Requires: %{libname}%{libver} = %{version}-%{release}
%package -n %{libname}%{libver}
%package -n %{libname}%{libver}-devel
Requires: %{libname}%{libver} = %{version}-%{release}
[acme@five pahole]$

Someone else also reported this recently... Fedora has:

[acme@five pahole]$ rpm -qR dwarves | grep ^libdwarves1
libdwarves1 = 1.17-4.fc33
[acme@five pahole]$

So it includes both ${version} and %{release}, which should get it in
lockstep.

Having said that I'm not aware of anything using libdwarves and it was
intended just to share those among the tools that comes in the
'dwarves' package, so I should have really made it internal, installed
in /usr/libexec/dwarves/ :-\

> 2. If not, can we add an option of statically linking libdwarves into
> pahole and other tools? That would eliminate all the problems
> altogether at the expense of a pretty negligible slight increase in
> the binary sizes.

Yeah, this looks like the way to proceed, i.e. we statically link it
while keeping the .so around in case someone uses it, while adding some
warning that that mode is deprecated and is going away.

- Arnaldo
