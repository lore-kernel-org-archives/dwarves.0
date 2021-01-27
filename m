Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D965C433DB
	for <linux-dwarves@archiver.kernel.org>; Wed, 27 Jan 2021 14:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1006B207B1
	for <linux-dwarves@archiver.kernel.org>; Wed, 27 Jan 2021 14:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbhA0Ojq (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 27 Jan 2021 09:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233455AbhA0OiE (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 27 Jan 2021 09:38:04 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67C5C061574
        for <dwarves@vger.kernel.org>; Wed, 27 Jan 2021 06:37:24 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id v23so794518uam.8
        for <dwarves@vger.kernel.org>; Wed, 27 Jan 2021 06:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EtILFTNEz8iVTTdeOXdcPp1dQ1vKJAm8qihRs1n7DDI=;
        b=QOqLhzI4j2bnUkaT+Ka1/dppFIAucuP+/zQQWoRMj+1w88FA3SP+JN19PdNQA/F8i7
         z5yYhAoiTHOpBDWXgjtI5+K9Pjxp33P2Fbh7jZZq7+rJ7iYnpzgtQZpRB0GsgLTGCMOd
         cU5mLmhMF+UMnJeNJ4V9xbT6roI02WT9o23oUqYipUCleEuQ7LKksrQnfLHjiMQEP5TH
         mGVlXzdopA3kTmRqZBhLpqp2eapBXz2wDBmnd4pXRayAuRaOExJt7zfm6weOl8z7Q4y7
         9UyKIkD8PwPmgcxmwoLgzLGnMUQg8mbbBflsCZsM6UrTd56N/sy994dwrLPr7k6eZCm2
         iwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EtILFTNEz8iVTTdeOXdcPp1dQ1vKJAm8qihRs1n7DDI=;
        b=P+ULm+5aLoT85kMHE/wa9Z1MxSCPDa4zNe/WDMfKXNi3+iU2Jam7cmtd8xD8MoYNr/
         FHi1igg+w06sV2Ye1cUuWav2RGtFDTWgbJQtk+IuhCPR/GZZMGCreCYuq7adv/YfoTXn
         LxZu7kFIhymSugujOFAyn+Bn2X92maQaX1spAgg9gvyS55/XBlkO1SlECoNVdv80Gx6q
         W6m11Bi+w7YEWPzYgpMRaEFFYCpPaUNMbBeICeOl8eY/6PKdDk5PRKCxC1AKalCHjWRu
         Q694JFBkNlWOa3GzFy0WfcyiublExI174CkQwZBRg5fpvY0KIQ0ubVzMrrotjabBGSeq
         324A==
X-Gm-Message-State: AOAM5338aUznxJHnf5vZ9wifvCRikqKOvsWAtCBVT/7XamRXHeU2NP6p
        vdq9fjNIpXIShBfXysSgNpJ+QvrAch9FPAhJY7CjgNfz6+yMuA==
X-Google-Smtp-Source: ABdhPJzxNIzkW73+JYoSNgRoyIz9qs0zBbVPyoONK/ChLmDxMXd9AqMEoQqDlFZQ16yfb5G5vYXIZ/DbUE7v9I52K9Q=
X-Received: by 2002:ab0:7193:: with SMTP id l19mr7925196uao.84.1611758243453;
 Wed, 27 Jan 2021 06:37:23 -0800 (PST)
MIME-Version: 1.0
References: <20210125130625.2030186-1-gprocida@google.com> <20210127140601.GA752795@kernel.org>
In-Reply-To: <20210127140601.GA752795@kernel.org>
From:   Giuliano Procida <gprocida@google.com>
Date:   Wed, 27 Jan 2021 14:36:45 +0000
Message-ID: <CAGvU0HmeMBHjfEp6Bgkx9RksaW5xo2H83T+VyJZMHQ25Z_Zdyg@mail.gmail.com>
Subject: Re: [PATCH dwarves 0/4] BTF ELF writing changes
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     dwarves@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        =?UTF-8?Q?Matthias_M=C3=A4nnich?= <maennich@google.com>,
        kernel-team@android.com, Kernel Team <kernel-team@fb.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Hi.

On Wed, 27 Jan 2021 at 14:06, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Mon, Jan 25, 2021 at 01:06:21PM +0000, Giuliano Procida escreveu:
> > Hi.
> >
> > This follows on from my change to improve the error handling around
> > llvm-objcopy in libbtf.c.
> >
> > Note on recipients: Please let me know if I should adjust To or CC.
> >
> > Note on style: I've generally placed declarations as allowed by C99,
> > closest to point of use. Let me know if you'd prefer otherwise.
> >
> > 1. Improve ELF error reporting
>
> applied
>
> > 2. Add .BTF section using libelf
> >
> > This shows the minimal amount of code needed to drive libelf. However,
> > it leaves layout up to libelf, which is almost certainly not wanted.
> >
> > As an unexpcted side-effect, vmlinux is larger than before. It seems
> > llvm-objcopy likes to trim down .strtab.
>
> We have to test this thoroughly, I'm adding support to gcc's -gdwarf-5
> DW_AT_data_bit_offset, I think I should get that done and release 1.20,
> if some bug is still left on that new code, we can just fallback to
> -gdwarf-4.
>
> Then get back to the last 2 patches in your series, ok?
>

That's fine.

I've spent a little time digging into what llvm-objcopy (11.0.0) is
doing. It turns out it will rewrite an ELF file even if you just do
llvm-objcopy --dump-section .strtab=/dev/null elf_file, and even if
the file is not writable.

Our AOSP kernels have a lot symbols filtered out of the symbol table
and perhaps this is what makes such a difference to the size of
.strtab after llvm-objcopy has done its thing. I will try on a vanilla
kernel.

Giuliano.

> - Arnaldo
>
> > 3. Manually lay out updated ELF sections
> >
> > This does full layout of new and updated ELF sections. If the update
> > ELF sections were not the last ones in the file by offset, then it can
> > leave gaps between sections.
> >
> > 4. Align .BTF section to 8 bytes
> >
> > This was my original aim.
> >
> > Regards.
> >
> > Giuliano Procida (4):
> >   btf_encoder: Improve ELF error reporting
> >   btf_encoder: Add .BTF section using libelf
> >   btf_encoder: Manually lay out updated ELF sections
> >   btf_encoder: Align .BTF section to 8 bytes
> >
> >  libbtf.c | 222 +++++++++++++++++++++++++++++++++++++++++++------------
> >  1 file changed, 175 insertions(+), 47 deletions(-)
> >
> > --
> > 2.30.0.280.ga3ce27912f-goog
> >
>
> --
>
> - Arnaldo
