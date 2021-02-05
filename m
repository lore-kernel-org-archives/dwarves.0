Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5848FC4332D
	for <linux-dwarves@archiver.kernel.org>; Fri,  5 Feb 2021 03:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EAEE64FB9
	for <linux-dwarves@archiver.kernel.org>; Fri,  5 Feb 2021 03:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhBEDMN (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 4 Feb 2021 22:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhBEDL4 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 4 Feb 2021 22:11:56 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89B9C06178A
        for <dwarves@vger.kernel.org>; Thu,  4 Feb 2021 19:11:10 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id c12so5967571wrc.7
        for <dwarves@vger.kernel.org>; Thu, 04 Feb 2021 19:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I+kAjuceqQaSn6CnDxq1eGCe6jIuci9QzOZjaAOHZZ4=;
        b=ald/6GB4cU/3OuNhAVzbLnuB6xvz4CPgony9VaCQPVAgc7KGFZXRVKtLWkWvFIcbYd
         fMoXq9EJebve6kpGLHdl/w0AUUwuW7oacXEQoWjA30ozOJ+x+mVh8qRFxJQF0LJFrDil
         Akbv/F/+Kbtk1c+wxZK0UJ2dYzsBC1cTWH2j20Ikolmf0u/r1vmv5xeGSTnzIeTgGfqZ
         xWwPsD4wEGWXILFenXn9Eqzx0EG1rPKqONAh4AqJyPRRWEXCh4X7gS+K07mTjG4RsM7m
         icO7WbGydnhB1YktuWBYsIdj5nyLNo6LBRRCB2GKBsbx7zUtL6UqbUxa0wHGPy/lYrIe
         dmnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I+kAjuceqQaSn6CnDxq1eGCe6jIuci9QzOZjaAOHZZ4=;
        b=axtc8YJooXu3HcMF3HRw/ycLSLOVlM8VJvYgYnfYVRFuTuejfAdSQ43Zq00v5GIX86
         ZeWISSEkVjAiy5b4iW09s93b/zdgT5Dmxs4v/AOFqcfQFkqIYahiWlqeY9DlgW8RHwzf
         wfYt5PYaqPape0zk7w+6JDXqkO2JNt7s0n1zjqoSS8Q+wlPyTf2RlRp+hsom57eA7sj/
         voVS6SyDNOUKG2Q6pOhO9EtPSSl7teUGRxsp40z5UWvMFLbXa6z74FFukCoj+fJW1fno
         ZaTUvU6bUT7WB1FVQe7qwGvpPZ5bcoztoD1DrIHMjAOPdkHwQAWX6+zICdlTvhcHQsw8
         YnQw==
X-Gm-Message-State: AOAM5335cJNIeT85krngorDAZ/T5260OFZbAP68j2I2QC65ZYM7Xo3YR
        YhcZglZmWCEtqsaNUsEsCGIQdvE21tQxsHnC13GGMA==
X-Google-Smtp-Source: ABdhPJxNqWdyIThhWcNYJ7sQC/LTzehMjhlXl+bGyYf5G8tr28thHPvS5ccpVRoPl/gmT6DrKtDpm3RQXJLhoNGKvkw=
X-Received: by 2002:a5d:6686:: with SMTP id l6mr2478909wru.236.1612494669505;
 Thu, 04 Feb 2021 19:11:09 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtSQLc0VHqO4BY_-YB2OmCNNmHCS6fNdQKmMWGn2v=Jpdw@mail.gmail.com>
 <CAJCQCtRHOidM7Vps1JQSpZA14u+B5fR860FwZB=eb1wYjTpqDw@mail.gmail.com>
 <CAEf4BzZ4oTB0-JizHe1VaCk2V+Jb9jJoTznkgh6CjE5VxNVqbg@mail.gmail.com>
 <CAJCQCtRw6UWGGvjn0x__godYKYQXXmtyQys4efW2Pb84Q5q8Eg@mail.gmail.com>
 <20210204010038.GA854763@kernel.org> <CAJCQCtQfgRp78_WSrSHLNUUYNCyOCH=vo10nVZW_cyMjpZiNJg@mail.gmail.com>
 <CAEf4Bza4XQxpS7VTNWGk6Rz-iUwZemF6+iAVBA_yvrWnV0k8Qg@mail.gmail.com>
 <CAJCQCtRDJ_uiJcanP_p+y6Kz76c4P-EmndMyfHN5f4rtkgYhjA@mail.gmail.com>
 <20210204132625.GB910119@kernel.org> <20210204163319.GD910119@kernel.org>
In-Reply-To: <20210204163319.GD910119@kernel.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 4 Feb 2021 20:10:52 -0700
Message-ID: <CAJCQCtT-i0Lv2zxUDko3XuiHpUqOnYPeND5LzD=zgrB1-GNvAg@mail.gmail.com>
Subject: Re: [FIXED] Re: 5:11: in-kernel BTF is malformed
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Chris Murphy <lists@colorremedies.com>, bpf <bpf@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Thu, Feb 4, 2021 at 9:33 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> So I think that for the problems related to building the kernel with gcc
> 11 in Fedora Rawhide using the default that is now DWARF5, pahole 1.20
> is good to go and I'll tag it now.

dwarves-1.20-1.fc34.x86_64
libdwarves1-1.20-1.fc34.x86_64

Fixes both "failed to validate module [?????] BTF: -22" type errors,
and 'in-kernel BTF is malformed" with qemu-kvm and libvirt.

Is that expected? Or maybe the second issue was fixed by
gcc-11.0.0-0.18.fc34.x86_64 [(GCC) 11.0.0 20210130]? This is what I
get for changing more than one thing at once.

--
Chris Murphy
