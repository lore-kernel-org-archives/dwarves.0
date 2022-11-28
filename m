Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C75C433FE
	for <linux-dwarves@archiver.kernel.org>; Mon, 28 Nov 2022 20:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbiK1UU6 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 28 Nov 2022 15:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbiK1UU5 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 28 Nov 2022 15:20:57 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B342FE6
        for <dwarves@vger.kernel.org>; Mon, 28 Nov 2022 12:20:56 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id fy37so28717054ejc.11
        for <dwarves@vger.kernel.org>; Mon, 28 Nov 2022 12:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VRWXB0VB4F5mMNaD6k47YX9iWDMnQA+5h1CA/5QiNvw=;
        b=DuU3dgmm0diGOcMgZU8TzjxLDkchZOXqZGIC7tfyjEozzKoNJl2ce3nUhAGy8y8WVR
         tXXa3pSNkIX0TyF/aP/oz6HvsKWX0ylmNlc8W7UU6WFz93xfeDJI+MbrTFD+bqTkM+3p
         5hQjXpQrZRSI/v9PTtXfC5gORWxzRv26c7od5z1A+i77mRIUL4mBHUp9ii5V2HN+EndC
         zvuPN8C2BBmqp5acqnoyKCtErrIXjUXXqLrj3ap5AMBDKWj6TlVe1wgJ447PvlGN28gv
         fKSsJFdOs9J1rfxz1HeAv0Ru/ss/+SyuVDXsCELr9pjO+G1BbMQVJ0u9xEmjLbc1WcEy
         hzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VRWXB0VB4F5mMNaD6k47YX9iWDMnQA+5h1CA/5QiNvw=;
        b=ZA5yMwQvLdYjYoyvWIfXlNhGvezV3goiOoo6bAqH4b+3xdM+//RXl4ZwAVST5iRPGi
         Dl7WxK7vNFkbW2TJpIDoYspUC3KVkWxfYgFA2XsxoK5seQJ3OeOc++b/OP3RgU50UcXi
         U4gXLE8RJDfevG9CuCm1DVN3Gnw2fJo6xHeCWrl4Xz0BRi6xVHZqXoKF7xM7MOFyxUc3
         ZTP5o8V5RoSkn/XGZXzx+d0XY1WhnnKyOn+p2cq+qqHQ9zpzpWkat9mbaF7tV3T4QIqa
         GStrMmeP07Huz2Th64o1pWQTZx0W43EQZMKCg+ayxK9hgYQu+O4IE6lNj0Og4F1nCmo4
         7IYw==
X-Gm-Message-State: ANoB5pkI1Lv04LkC6vG+EsxqjT6ZvLFv4DCwYk8NzUZVFh1QgV/GXdKq
        KKyGiwfrZ+A/odYEKE1KWiWH4e0ki4ERwVSR1/Iw5c1JsOs1
X-Google-Smtp-Source: AA0mqf55wxOCQPtWCfk/k5xXOb1UGOCUUjT4pXPnRMdfUFapP3FnRmPmurUe9f453/P0iTusNlcXhMNdiZdsTfN2Vmg=
X-Received: by 2002:a17:906:b04c:b0:78d:9b0a:7b0b with SMTP id
 bj12-20020a170906b04c00b0078d9b0a7b0bmr44926130ejb.197.1669666854570; Mon, 28
 Nov 2022 12:20:54 -0800 (PST)
MIME-Version: 1.0
References: <20221122000011.241697-1-morbo@google.com>
In-Reply-To: <20221122000011.241697-1-morbo@google.com>
From:   Bill Wendling <morbo@google.com>
Date:   Mon, 28 Nov 2022 12:20:37 -0800
Message-ID: <CAGG=3QUxBQ_BcC4F8cZidgO=MCGcu8ciVbMq+=6=T8omjrVPRA@mail.gmail.com>
Subject: Re: [PATCH dwarves 0/1] LLD .BTF section patch
To:     dwarves@vger.kernel.org
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Mon, Nov 21, 2022 at 4:00 PM Bill Wendling <morbo@google.com> wrote:
>
> This patch is an attempted fix for the issue discussed in [1]. I believe it's
> actually caused by pahole generating a corrupted ELF file.
>
> LLD generates a zero-sized .BTF section, while BFD doesn't. When pahole goes to
> add the .BTF data to an LLD-generated file, the section exists, but is too
> small. The ELF calls don't appear to adjust following sections' addresses in
> this case.
>
> To avoid this, the patch does some magic with objcopy to generate a separate
> .BTF section and perform some renaming.
>
> NOTE: This patch resembles a hack. If it's possible to adjust a section's size
> with ELF calls we should do it that way.
>
For instance, this could be done in the kernel like the following. I
don't know which is the more acceptable alternative.

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index b808ef0..e6bfe51 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -212,6 +212,24 @@

  info "BTF" ${2}
  vmlinux_link ${1}
+ if ${LD_vmlinux} --version | grep -q LLD ; then
+ # LLD will generate a zero-sized .BTF section (the BFD linker
+ # doesn't). In that case, pahole tries to use the zero-sized
+ # section to house the BTF information. However, pahole doesn't
+ # adjust the addresses of sections around the .BTF section,
+ # resulting in an ELF file that appears invalid to further
+ # linkers. Avoid this issue by renaming the .BTF to .BTF_old
+ # and letting pahole add a new .BTF section.
+ # TODO(b/182271653): If/when pahole is fixed, we should remove
+ # this code.
+ BTF_SECTION=$(${READELF} -SW ${1} | grep -v .BTF_ids | grep .BTF)
+ if [[ -n "${BTF_SECTION}" ]]; then
+ BTF_SIZE=$(echo ${BTF_SECTION} | awk '{print $6}')
+ if [[ "0x${BTF_SIZE}" -eq 0 ]]; then
+ ${OBJCOPY} --rename-section .BTF=.BTF.old ${1}
+ fi
+ fi
+ fi
  LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${1}

  # Create ${2} which contains just .BTF section but no symbols. Add

> [1]: https://lore.kernel.org/dwarves/20210317232657.mdnsuoqx6nbddjgt@google.com/
>
> Bill Wendling (1):
>   btf_encoder: Generate a new .BTF section even if one exists
>
>  btf_encoder.c | 88 +++++++++++++++++++++++++++++++--------------------
>  1 file changed, 54 insertions(+), 34 deletions(-)
>
> --
> 2.38.1.584.g0f3c55d4c2-goog
>
