Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E416FC48BE5
	for <linux-dwarves@archiver.kernel.org>; Tue, 15 Jun 2021 23:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9FBC6128C
	for <linux-dwarves@archiver.kernel.org>; Tue, 15 Jun 2021 23:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhFOXcW (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 15 Jun 2021 19:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhFOXcU (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 15 Jun 2021 19:32:20 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C92CC061574;
        Tue, 15 Jun 2021 16:30:15 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id t8so246989ybt.10;
        Tue, 15 Jun 2021 16:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=lrNuChciOT1m4Cxcoui/LhFfctlKythbyRrQh5z2mbE=;
        b=bDvq7IfMbWYNuleCjIA4lWoaCodbP/05wErrBm3s0LseDpTY7hVSU3/DOkAmi/xm9f
         NXPfHBhyilJtzKEVtnnMwUGohAdpGnQwqdYU0HAIOBT2VuTmKp9YcHtLKgv8K7R11Os5
         MfwfIKJCXeExVNCa3vTlZ1QgIipDY6QKMcyrma/1LhZ1X0VBVcWEYu77RukIa+OogkJ1
         DUIxeDpBE6H4pn4TYM3+UtgYFTkYDC06re86EPQfSo9OcUhISLQ+LmXVZqePRrbpKt++
         sMGfT1yYAklt5DuBS0S9d00aVDM5HPeSS3/pHvwJgKnv76OWoTooQHYT5GS7GTadU/nY
         WXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=lrNuChciOT1m4Cxcoui/LhFfctlKythbyRrQh5z2mbE=;
        b=W0qEnZbr/bdBe8R3QTfKRwRizJx+8fDuDvehuncLiu0gGpSXVFOwjwLnG8/Fas6m78
         Ve4gDRGFxVV8w2SjENX6XseVXOkf4Ius7VBAJbA99Xx3nJQf1gdGcpgxLV4D8eSBe3Mn
         3rjTpMh4uCO81jZVTmAOtiOp6OLlLSaXp1UdiM4ghQsiqCg8ukm4wsGIwmtQ/rPffpE4
         aKi8Bc5XQ8o6gGcF1tp2g22tz9pZg/qK7J/Y5BKLWVsKGYHySw+9rfUPYmt/hGgXQpbN
         3Gn9/nl+udkgBQl+cqmPrgi+nNPqHsWS14w4QK0JN0AXZMOE2h+IGBpqvEAWCKABh4Gd
         D+pw==
X-Gm-Message-State: AOAM530G5MvA1kl9tN88UCuaJQqH3KqXc+mJ4r8EeRj7u6D6/g7N0cWC
        IizxFLFlHpteU09Sc07/J+n1lBnliDCLTpgAMkc1T2QL+oZIJw==
X-Google-Smtp-Source: ABdhPJwLRWFpQ86AvbMesovS7NROr/kJQOgojlOcmVZJ6ZwczvXeBBpecT1ZXWz1AD/jMgn5VW6tQECoPyBhb6b1034=
X-Received: by 2002:a25:7246:: with SMTP id n67mr2242758ybc.510.1623799814611;
 Tue, 15 Jun 2021 16:30:14 -0700 (PDT)
MIME-Version: 1.0
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 15 Jun 2021 16:30:03 -0700
Message-ID: <CAEf4BzZnZN2mt4+5F-00ggO9YHWrL3Jru_u3Qt2JJ+SMkHwg+w@mail.gmail.com>
Subject: latest pahole breaks libbpf CI and let's talk about staging
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        bpf <bpf@vger.kernel.org>, dwarves@vger.kernel.org
Cc:     siudin@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Hey Arnaldo,

Seems like de3a7f912559 ("btf_encoder: Reduce the size of encode_cu()
by moving function encoding to separate method") break two selftests
in libbpf CI (see [0]). Please take a look. I suspect some bad BTF,
because both tests rely on kernel BTF info.

You've previously asked about staging pahole changes. Did you make up
your mind about branch names and the process overall? Seems like a
good chance to bring this up ;-P

  [0] https://travis-ci.com/github/libbpf/libbpf/jobs/514329152

-- Andrii
