Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08262C4332F
	for <linux-dwarves@archiver.kernel.org>; Tue, 22 Nov 2022 00:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiKVAAV (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 21 Nov 2022 19:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiKVAAU (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 21 Nov 2022 19:00:20 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3A460DE
        for <dwarves@vger.kernel.org>; Mon, 21 Nov 2022 16:00:19 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3691846091fso124635007b3.9
        for <dwarves@vger.kernel.org>; Mon, 21 Nov 2022 16:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yOp6+/qP0NE+f8Zy9NtOf4TqqqlspTXC8B52TtthevI=;
        b=iJcT6HASGoujRw1XTyaL/v4AhP/JxhDV66Xr1FM4vS63wHOKFlUY35DLI4QuInXM28
         xeQRmHrhUCOWJwzegTcdFF+3wYtavFaTdFRGqeLyCsIaiTGR4tFY3P0HKzWeK+0b5UVX
         ucsdhndzV32zeb9S4MOpG1xZ4sAxdYojWYDycfMugNhm0B2otKGnnBhshg01f4CA7Zpj
         PBz5TtwE2AogSSQaFK0WG9/tvzdawFAscoz1ESLv+qPg1vC1YvkAbqYGuzd+7ujf+wCP
         Tv4OJ3L5LFajY9mz9CKGySeHYry9+wXsexlnufr9agJsrxcy89XPn3E+g5fQyvCIV6ON
         S3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yOp6+/qP0NE+f8Zy9NtOf4TqqqlspTXC8B52TtthevI=;
        b=ir8FbtU/Wn/3ppZHWi1LZjx244CMUhQEj+jGi82hv7JHnxatw/acuuI+8Kr7XE/nNe
         w9b25JDrD5/sxFriaJGlZN3PWu8FzzDX1P9LpxBtTDJEkLvFQSlvSqQm/qXwhtMtDhqs
         NFxZNsx85NaWBFLrVUHTyIPPvbe/XV067nNmGKQb++jqKFqhxfY00a0UklW+fe/GJZKp
         PaFkX2eVKsX+7XsIC2YPIjivGn43mfByV2HWHiPZEfAMnaHabwLSApTecqLzdUaADxHY
         k67VPDfOXO7V6e0s1YLaU4PIU2pkRp/Gl0GmNhXBoBAUofIFOq7cqiyk4XVqwsXf4vjW
         CkKQ==
X-Gm-Message-State: ANoB5pnODnRMfUShrh4aKhqGHYZtSfRYQY7JeFP86RmUSbeDmsLsSYWa
        vDr/q9bKlY5K6dPqOxzdkiNFCiI6q4Ucvpl6rxoxP6LYf2U6loEt1z2MP/pZ+p9U3C7Ex3KQbGD
        uVFPbuWyNDV59uXn6/pVliy5jTnPn2tVc6Lf6o3+FbHRF3EULeR+HR/srEMA=
X-Google-Smtp-Source: AA0mqf6rUJHN22VqDK5sA2HO9d3/sdLHs3+rge2yHwBxJpzvTmFYag0wHcpwqSmVXjthxKoUubtBcK6JdQ==
X-Received: from fawn.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5795])
 (user=morbo job=sendgmr) by 2002:a25:d9d8:0:b0:6e4:c5c4:a62b with SMTP id
 q207-20020a25d9d8000000b006e4c5c4a62bmr2606316ybg.560.1669075218530; Mon, 21
 Nov 2022 16:00:18 -0800 (PST)
Date:   Tue, 22 Nov 2022 00:00:10 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221122000011.241697-1-morbo@google.com>
Subject: [PATCH dwarves 0/1] LLD .BTF section patch
From:   Bill Wendling <morbo@google.com>
To:     dwarves@vger.kernel.org
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Fangrui Song <maskray@google.com>,
        Bill Wendling <morbo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

This patch is an attempted fix for the issue discussed in [1]. I believe it's
actually caused by pahole generating a corrupted ELF file.

LLD generates a zero-sized .BTF section, while BFD doesn't. When pahole goes to
add the .BTF data to an LLD-generated file, the section exists, but is too
small. The ELF calls don't appear to adjust following sections' addresses in
this case.

To avoid this, the patch does some magic with objcopy to generate a separate
.BTF section and perform some renaming.

NOTE: This patch resembles a hack. If it's possible to adjust a section's size
with ELF calls we should do it that way.

[1]: https://lore.kernel.org/dwarves/20210317232657.mdnsuoqx6nbddjgt@google.com/

Bill Wendling (1):
  btf_encoder: Generate a new .BTF section even if one exists

 btf_encoder.c | 88 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 54 insertions(+), 34 deletions(-)

-- 
2.38.1.584.g0f3c55d4c2-goog

