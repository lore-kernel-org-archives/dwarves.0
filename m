Return-Path: <SRS0=WuSk=D3=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8941C4363A
	for <linux-dwarves@archiver.kernel.org>; Tue, 20 Oct 2020 17:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BFCA22249
	for <linux-dwarves@archiver.kernel.org>; Tue, 20 Oct 2020 17:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O8rxYUWk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390644AbgJTRS6 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 20 Oct 2020 13:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730565AbgJTRS6 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 20 Oct 2020 13:18:58 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6CFC0613D1
        for <dwarves@vger.kernel.org>; Tue, 20 Oct 2020 10:18:58 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id p5so3896780ejj.2
        for <dwarves@vger.kernel.org>; Tue, 20 Oct 2020 10:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QfVexZ2EgTTCM/Ez7NNYUHMSo/X05yXMg16LPX8qpHk=;
        b=O8rxYUWkrTbPdGoFLcMct9G13Pwd1tz673lQMyBarZr2YV+YSXuQpCe2eqg/Sr/gTc
         NyFzeGkEIB8tKWk4w7aJc0aLzArzt2nXQbglvVfpxd9ljFCtywWnP8/V/RrkRVBDOHsJ
         mdq6W4qL0qqtMf9Y3Tzt7x460kbk7jtQ37IlzNGoK9uqDsk0dtROe8BPghIXvJmIDpIl
         ET/0aUV1p3DVQR6q80VYuH/JXfoGDMizXuLSOSTDMF1d4QvwZj0y0F7Y+iVgiNJzSzdw
         F6GA9mjYemFAnLHEmd1AgweTa0sNU3lBCgAod3zaLS5Ct811+8a6ZGTxq3CnxchGYz5R
         AC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QfVexZ2EgTTCM/Ez7NNYUHMSo/X05yXMg16LPX8qpHk=;
        b=S7nGsklDaXATZ37pLpBT+a3ZaBSbgA6M3+e36lf2EXBP9wRNE8ii9P3rCpFyQDNl1v
         OaT+fetx5X5JboSLnJcm98908124bqIMKTLuf+26MDbH83Fl5W7SXXeeKtCwCxF8opxy
         kP4I1gf4D/au/TCHvATicU/B4FUi8OYPi7hSnZPXNyhvsbV3M5cQ4wj/d3/7YxTNlthq
         Y0ZNNh344GVlDsGFgQUeOnUyz4lof1lT1GQDSy5+lcPUweWHTjcm16B9/YRoZcv8tNRe
         93+EBmRLvcqyJGa9h+ixoOmUHipJJYrA8VUICutA7UrMpZXsgMnaI6x+k5YEDATtSQQd
         n/Hg==
X-Gm-Message-State: AOAM532TXd1VlS/l4zD2RhDGEjZ0Y9wVCQW+OmArfo6JvrXWYStU2Sel
        /asbIXVLOXoWE05Dd/PAtjU23rdPtCKeWAa827qGdg==
X-Google-Smtp-Source: ABdhPJwu0hda7eR3sB0MB0VKCgpdFnLRdQJtiTpRF+8tt8r7GazON7G8SPZWqs0wDUXsSdOxWe92StYlaMBTT9zqtRc=
X-Received: by 2002:a17:906:3541:: with SMTP id s1mr4355222eja.413.1603214336466;
 Tue, 20 Oct 2020 10:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAFDeuWM7D-Upi84-JovKa3g8Y_4fjv65jND3--e9u-tER3WmVA@mail.gmail.com>
 <82b757bb-1f49-ab02-2f4b-89577d56fec9@kernel.org> <20201020122015.GH2294271@kernel.org>
 <CA+khW7gcDPAw4h=0U9mMxTJoaCyOXCMwyw34dcBp1xBKJG6xkg@mail.gmail.com> <CAEf4BzYDvvthK_S7EecsTO3HAVXiAf6AqHaiEWbf9+K7sjMiLA@mail.gmail.com>
In-Reply-To: <CAEf4BzYDvvthK_S7EecsTO3HAVXiAf6AqHaiEWbf9+K7sjMiLA@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 20 Oct 2020 10:18:45 -0700
Message-ID: <CA+khW7hcXG5d=WxxHK-D8ubEnTtM+oic7cs61j_DZfze0K-VPg@mail.gmail.com>
Subject: Re: Segfault in pahole 1.18 when building kernel 5.9.1 for arm64
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?B?w4lyaWNvIFJvbGlt?= <erico.erc@gmail.com>,
        dwarves@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Tue, Oct 20, 2020 at 10:10 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Oct 20, 2020 at 10:05 AM Hao Luo <haoluo@google.com> wrote:
> >
> > Thanks for reporting this and cc'ing me. I forgot to update the error
> > messages when renaming the flags. I will send a patch to fix the error
> > message.
> >
> > The commit
> >
> > commit f3d9054ba8ff1df0fc44e507e3a01c0964cabd42
> > Author:     Hao Luo <haoluo@google.com>
> > AuthorDate: Wed Jul 8 13:44:10 2020 -0700
> >
> >      btf_encoder: Teach pahole to store percpu variables in vmlinux BTF=
.
> >
> > encodes kernel global variables into BTF so that bpf programs can
> > directly access them. If there is no need to access kernel global
> > variables, it's perfectly fine to use '--btf_encode_force' to skip
> > encoding bad symbols into BTF, or '--skip_encoding_btf_vars' to skip
> > encoding all global vars all together. I will add these info into the
> > updated error message.
> >
> > Also cc bpf folks for attention of this bug.
>
> I've already fixed the message as part of
> 2e719cca6672 ("btf_encoder: revamp how per-CPU variables are encoded")
>

Ah, that's awesome! Thanks for fixing this, Andrii. I haven't got time
to take a look at your patches last week, I will try to look at it
ASAP.

> It's currently still in the tmp.libbtf_encoder branch in pahole repo.
>
> >
> > Hao
> >
> > On Tue, Oct 20, 2020 at 5:20 AM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > Em Tue, Oct 20, 2020 at 11:01:39AM +0200, Jiri Slaby escreveu:
> > > > Hi,
> > > >
> > > > On 19. 10. 20, 1:18, =C3=89rico Rolim wrote:
> > > > > I'm trying to build kernel 5.9.1 for arm64, and my dotconfig has
> > > > > `CONFIG_DEBUG_INFO_BTF=3Dy`, which requires pahole for building. =
However, pahole
> > > > > version 1.18 segfaults during the build, as can be seen below:
> > > > >
> > > > > PAHOLE: Error: Found symbol of zero size when encoding btf (sym:
> > > > > '__kvm_nvhe_arm64_ssbd_callback_required', cu:
> > > > > 'arch/arm64/kernel/cpu_errata.c').
> > > >
> > > > The symbol is an alias coming from arch/arm64/kernel/vmlinux.lds:
> > > > __kvm_nvhe_arm64_ssbd_callback_required =3D arm64_ssbd_callback_req=
uired;;
> > > >
> > > > > PAHOLE: Error: Use '-j' or '--force' to ignore such symbols and f=
orce
> > > > > emit the btf.
> > > > > scripts/link-vmlinux.sh: line 141: 43837 Segmentation fault
> > > > > LLVM_OBJCOPY=3D${OBJCOPY} ${PAHOLE} -J ${1}
> > > > >    LD      .tmp_vmlinux.kallsyms1
> > > > >    KSYM    .tmp_vmlinux.kallsyms1.o
> > > > >    LD      .tmp_vmlinux.kallsyms2
> > > > >    KSYM    .tmp_vmlinux.kallsyms2.o
> > > > >    LD      vmlinux
> > > > >    BTFIDS  vmlinux
> > > > > FAILED: load BTF from vmlinux: Unknown error -2make: ***
> > > > > [Makefile:1162: vmlinux] Error 255
> > > > >
> > > > > It is possible to force the build to continue if
> > > > >
> > > > >    LLVM_OBJCOPY=3D${OBJCOPY} ${PAHOLE} -J ${1}
> > > > >
> > > > > in scripts/link-vmlinux.sh is changed to
> > > > >
> > > > >    LLVM_OBJCOPY=3D${OBJCOPY} ${PAHOLE} -J --btf_encode_force ${1}
> > > > >
> > > > > The suggested `-j` or `--force` flags don't exist, since they wer=
e removed in
> > > > > [1]. I believe `--btf_encode_force` should be suggested instead.
> > > >
> > > > Agreed, '--btf_encode_force' makes pahole to proceed without crashe=
s.
> > > >
> > > > > It should be noted that the same build, but with pahole version 1=
.17, works
> > > > > without issue, so I think this is either a regression in pahole o=
r the script
> > > > > will need to be changed for newer versions of pahole.
> > > >
> > > > Yeah, I observe the very same. I reported it at:
> > > > https://bugzilla.suse.com/show_bug.cgi?id=3D1177921
> > >
> > > Would it be possible to try with
> > > https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=3Dtm=
p.libbtf_encoder
> > > ?
> > >
> > > This switches to using libbpf for the BTF encoder and may have fixed
> > > this problem.
> > >
> > > - Arnaldo
> > >
>
> [...]
>
> > > >
> > > >
> > > > I suspect:
> > > > commit f3d9054ba8ff1df0fc44e507e3a01c0964cabd42
> > > > Author:     Hao Luo <haoluo@google.com>
> > > > AuthorDate: Wed Jul 8 13:44:10 2020 -0700
> > > >
> > > >     btf_encoder: Teach pahole to store percpu variables in vmlinux =
BTF.
> > > >
> > > >
> > > > Which added this machinery (btf_elf__add_datasec_type in particular=
).
> > > >
> > > > > - [1] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/comm=
it/pahole.c?h=3Dv1.18&id=3D1abc001417b579b86a9b27ff88c9095d8f498a46
> > > > >
> > > > > Thanks,
> > > > > =C3=89rico
> > > > >
> > > >
> > > >
> > > > --
> > > > js
> > > > suse labs
> > >
> > > --
> > >
> > > - Arnaldo
