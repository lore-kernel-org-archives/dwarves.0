Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2CCC48BE0
	for <linux-dwarves@archiver.kernel.org>; Fri, 11 Jun 2021 23:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12ADE6128A
	for <linux-dwarves@archiver.kernel.org>; Fri, 11 Jun 2021 23:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbhFKXDt (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 11 Jun 2021 19:03:49 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:39677 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbhFKXDs (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Fri, 11 Jun 2021 19:03:48 -0400
Received: by mail-wr1-f54.google.com with SMTP id l2so7588401wrw.6
        for <dwarves@vger.kernel.org>; Fri, 11 Jun 2021 16:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UjlOuHaC/q0MGJJYWVhs5PF/2KjMYlZEvSwytgZppqk=;
        b=aMex97y923xiIKYQa0I2uP2DyDDjROhA22n/ey4akSZktRjoSQK1WizxTd22hrZ1Zj
         OQwYbUtxwZZ3HlcVO0ibiDqC3W1N2Xfd0i740ekO9TuDkVG5QKG/w4akh4eJjLj9K8nP
         DqrqKS+EZya4ZLr5VhQBqYIUX6cAuk9bMs9VYVwgbkyOsBwxxJGURqpH+ZVd7uQ08Jnc
         Z/TZ1AO/nHuY66r5Obq3rPXrCDh+PEj62UGmsbF8Pc7wJc73wR8AWvEFtySS0aaU45M9
         YyOV7JI7FcXoO4Pm6sOFmaxYE+nnW6cGR3FT/SeZ695yjW/wH6duFFF7/8xz1T+10tH0
         sCdA==
X-Gm-Message-State: AOAM533Wz3BEnpV51/PVbyTp730F0xh/g1bprLukCLsRYNjvAM9j/hU7
        u989KXaLsiDnp8hgYUIrGM6hlK5w4DdtZw==
X-Google-Smtp-Source: ABdhPJx8TjHdsQ9Aur2KEewC6EcX9MBc78xF3NZT7AE1y4cQMny7xovMrci0fEiDYhf6XBHttfpKpw==
X-Received: by 2002:adf:8b91:: with SMTP id o17mr6202565wra.385.1623452493024;
        Fri, 11 Jun 2021 16:01:33 -0700 (PDT)
Received: from localhost ([2a01:4b00:f41a:3600:df86:cebc:8870:2184])
        by smtp.gmail.com with ESMTPSA id i9sm10404330wrn.54.2021.06.11.16.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 16:01:32 -0700 (PDT)
From:   Luca Boccassi <bluca@debian.org>
To:     dwarves@vger.kernel.org
Cc:     arnaldo.melo@gmail.com
Subject: [PATCH dwarves] Add missing lib/include/bpf -> ../bpf/src symlink
Date:   Sat, 12 Jun 2021 00:01:26 +0100
Message-Id: <20210611230126.57713-1-bluca@debian.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

The original "libbpf: allow to use packaged version" had a symlink
as suggested during review:

https://www.spinics.net/lists/dwarves/msg00738.html

git show 82749180b23d3c9c060108bc290ae26507fc324e -- lib/include
commit 82749180b23d3c9c060108bc290ae26507fc324e
Author: Luca Boccassi <bluca@debian.org>
Date:   Mon Jan 4 22:16:22 2021 +0000

    libbpf: allow to use packaged version

    Add a new CMake option, LIBBPF_EMBEDDED, to switch between the
    embedded version and the system version (searched via pkg-config)
    of libbpf. Set the embedded version as the default.

    Signed-off-by: Luca Boccassi <bluca@debian.org>
    Cc: dwarves@vger.kernel.org
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/lib/include/bpf b/lib/include/bpf
new file mode 120000
index 0000000..4c41b71
--- /dev/null
+++ b/lib/include/bpf
@@ -0,0 +1 @@
+../bpf/src
\ No newline at end of file

This patch was reverted, and then re-added manually.
But the re-add dropped the symlink, which causes the system bpf/btf.h
to be picked up instead of the local one. Re-add it.

Signed-off-by: Luca Boccassi <bluca@debian.org>
---
 lib/include/bpf | 1 +
 1 file changed, 1 insertion(+)
 create mode 120000 lib/include/bpf

diff --git a/lib/include/bpf b/lib/include/bpf
new file mode 120000
index 0000000..4c41b71
--- /dev/null
+++ b/lib/include/bpf
@@ -0,0 +1 @@
+../bpf/src
\ No newline at end of file
-- 
2.30.2

