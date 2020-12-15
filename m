Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CEEC4361B
	for <linux-dwarves@archiver.kernel.org>; Tue, 15 Dec 2020 13:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D761C20729
	for <linux-dwarves@archiver.kernel.org>; Tue, 15 Dec 2020 13:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgLON3D (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 15 Dec 2020 08:29:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:52682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbgLON3D (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Tue, 15 Dec 2020 08:29:03 -0500
Date:   Tue, 15 Dec 2020 10:28:34 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608038903;
        bh=xdhElwLigwOue2emKaQ65XVgt6cdlE0zreL9VeKArSk=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=C3EwWUQU7b8SL//J2+MMTBqcNytEFGW5YhIxzzeE/aCgnd7sU/y3QlaL3LTB7WZgE
         l0bOJnHl6MtCcywDsl0zLIYpPoKUiHsPwFnXKWIG3vnlsFzM9VfMDy3em1iirc9Lc9
         RqKHNqprTf/dq/ngzj/WiATdaMhdYNl8AxzNfbQ5Yw0QyujTTAg8EXE/h3wjBFqBpU
         sljMMgErhgA+zvIZVi/copn1ekx2jAg+cSZY2lqsRqF1H4VtRQiKzVbMXBiOb0UPFp
         arL/j28m6GfPQZ3HKihXTQQwd+cUsABGnYC8djpNPciBMlia+cpMPG367EY+vhyys8
         71PtoRFeVQS0w==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH dwarves 0/2] Fix pahole to emit kernel module BTF
 variables
Message-ID: <20201215132834.GA252952@kernel.org>
References: <20201211041139.589692-1-andrii@kernel.org>
 <20201213202757.GA482741@krava>
 <20201214134343.GF238399@kernel.org>
 <CAEf4BzbCeeVuZaEkykNpc35+7xRcWtPCbwGpGNwET_5mBBPN7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbCeeVuZaEkykNpc35+7xRcWtPCbwGpGNwET_5mBBPN7A@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Mon, Dec 14, 2020 at 05:28:22PM -0800, Andrii Nakryiko escreveu:
> On Mon, Dec 14, 2020 at 5:43 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Sun, Dec 13, 2020 at 09:27:57PM +0100, Jiri Olsa escreveu:
> > > On Thu, Dec 10, 2020 at 08:11:36PM -0800, Andrii Nakryiko wrote:
> > > > Two bug fixes to make pahole emit correct kernel module BTF variable
> > > > information.
> > > >
> > > > Cc: Hao Luo <haoluo@google.com>
> > > > Cc: Jiri Olsa <jolsa@redhat.com>
> > > >
> > > > Andrii Nakryiko (2):
> > > >   btf_encoder: fix BTF variable generation for kernel modules
> > > >   btf_encoder: fix skipping per-CPU variables at offset 0
> > >
> > > Acked-by: Jiri Olsa <jolsa@redhat.com>
> >
> > Thanks, applied.
> >
> 
> Thanks, Arnaldo. I'm not seeing them on
> gitolite.kernel.org/pub/scm/devel/pahole/pahole.git, did you push them
> somewhere else?

I need to push it out, I'm doing kernel builds and tests and will
incorporate Hao's Acked-by.

- Arnaldo
