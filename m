Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA00ECAAD1
	for <linux-dwarves@archiver.kernel.org>; Sat, 27 Aug 2022 17:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbiH0RdM (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Sat, 27 Aug 2022 13:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbiH0RdM (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Sat, 27 Aug 2022 13:33:12 -0400
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 02C2631EE5
        for <dwarves@vger.kernel.org>; Sat, 27 Aug 2022 10:33:10 -0700 (PDT)
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 3336B72C90B;
        Sat, 27 Aug 2022 20:33:10 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 205284A470D;
        Sat, 27 Aug 2022 20:33:10 +0300 (MSK)
Date:   Sat, 27 Aug 2022 20:33:10 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org
Subject: Re: pahole v1.24: FAILED: load BTF from vmlinux: Invalid argument
Message-ID: <20220827173310.o6sv2ugl6taul6og@altlinux.org>
References: <20220825163538.vajnsv3xcpbhl47v@altlinux.org>
 <CA+JHD904e2TPpz1ybsaaqD+qMTDcueXu4nVcmotEPhxNfGN+Gw@mail.gmail.com>
 <20220825171620.cioobudss6ovyrkc@altlinux.org>
 <20220826025220.cxfwwpem2ycpvrmm@altlinux.org>
 <20220826025944.hd7htqqwljhse6ht@altlinux.org>
 <YwjQDBovX+cX/JDJ@krava>
 <Ywj2xCPATz1qb0lC@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Ywj2xCPATz1qb0lC@kernel.org>
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Arnaldo,

On Fri, Aug 26, 2022 at 01:37:24PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Aug 26, 2022 at 03:52:12PM +0200, Jiri Olsa escreveu:
> > On Fri, Aug 26, 2022 at 05:59:44AM +0300, Vitaly Chikunov wrote:
> 
> > > >   [    0.767649] Run /init as init process
> > > >   [    0.770858] BPF:[593] ENUM perf_event_task_context
> > > >   [    0.771262] BPF:size=4 vlen=4
> > > >   [    0.771511] BPF:
> > > >   [    0.771680] BPF:Invalid btf_info kind_flag
> > > >   [    0.772016] BPF:
>  
> > I can see the same on 5.15, it looks like the libbpf change that
> > pahole is compiled with is setting the type's kflag for values < 0:
> > (which is the case for perf_event_task_context enum first value)
>  
> >   dffbbdc2d988 libbpf: Add enum64 parsing and new enum64 public API
>  
> > but IIUC kflag should stay zero for normal enum otherwise the btf meta
> > verifier screams
>  
> > if I compile pahole with the libbpf change below I can boot 5.15 kernel
> > normally
>  
> > Yonghong, any idea?
> 
> This made me try to build pahole with the system libbpf instead of with
> the one that goes with it, here, testing with libbpf 0.7.0 it wasn't
> building as BTF_KIND_ENUM64 came with libbpf 1.0 so I added the
> following patch to again allow with the system libbpf, i.e. using:
> 
>   $ cmake -DCMAKE_BUILD_TYPE=Release -DLIBBPF_EMBEDDED=Off
> 
> This will return errors if trying to encode or load enum64 tags, but
> disabling it, as done with kernels not supporting BTF_KIND_ENUM64 should
> now work, can you please test and report results?
> 
> Vitaly I checked and alt:p9 has libbpf 0.2, which is really old, unsure
> if it would build there, but alt:sisyphus has 0.8.0, so should work
> there, please try.

Perhaps this does not need to be tested since Jiri found the solution?

BTW, alt:p9 is older ALT branch only for security updates, current
branch is alt:p10, so it's relevant to replace p9 testing with p10, for
new features.

I was building dwarves with -DLIBBPF_EMBEDDED=ON, thinking it would be
more stable (since they updated not independently from each other), is
it recommended to turn in OFF?

ps. I think something needs to be changed somewhere (in kernel src?) or
more users will report build failures when switching to the new pahole.

Thanks,

> 
> - Arnaldo
