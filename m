Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91779C433E0
	for <linux-dwarves@archiver.kernel.org>; Thu, 21 Jan 2021 11:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 611652222B
	for <linux-dwarves@archiver.kernel.org>; Thu, 21 Jan 2021 11:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbhAULhI (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 21 Jan 2021 06:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728396AbhAULhG (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 21 Jan 2021 06:37:06 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F048C061757
        for <dwarves@vger.kernel.org>; Thu, 21 Jan 2021 03:35:31 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id q18so804126wrc.20
        for <dwarves@vger.kernel.org>; Thu, 21 Jan 2021 03:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=tHm4aawgl4upxAANEu6km7IPT8qo7sF57UAGh5jcpEQ=;
        b=Ds0HNmp+7d57PEygc5eJeuDPMs2K36GpyTgvXuI+sYnvLHDRl4l47t84aX6pqaOUyN
         M0cqR7DNwQdUFHH+U7RNJYRbRfePFqBPHiKCBVXGiMUt1mPvM3LgLWVDcqqwiTKerhNV
         yYFLIRDLzcO7VtceJd29Dm1Kyi5aIytZjBpTfHkW+T1wyed2Gvueb08kJqPdQjaDqlHX
         gwE8jpy9C7X7QxUH2bqooA80qU3E+A3NdGgz15Tf5EKlqB9Hl+JgHnNHnN2XBHvtyaAx
         g3TiIHdXrlEDWjy8aLL5wdQWKGRWBHYS6XHEZbyrq3JseIowte/ev73FyiyQT1Oh5t0u
         Vn/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tHm4aawgl4upxAANEu6km7IPT8qo7sF57UAGh5jcpEQ=;
        b=iw3uLz2mPmXvTr1WTFOKh0zyOVp/+9j0e/PN24F+TL9DW9cfiZKE5f9/FehmCLB9Ir
         To7K3rrQRSxAFsvFX+ZYt4TzXi5NOjISzTI3JAPYNkJ8q0hC7rL7qZ2PQb9nqB3qlgYl
         GfP0wwxnC2FOC16wiGcVMZe91NAV8jgm3AV3xlEIB7mGHGo/79qeezbZ4QTlbLioZGIh
         2KQJwoY0zGJwB5HWteY+09vUKWr51SypEqon01tsvhk82Zl0t2Z+3HTcTl8vDIlLO3uP
         eQmgCi/cVdgR+I4IOH8se32EpFVt0wXczwxzakLHq7ER3GFBp8pxuBBfY22MubmReffy
         lO0A==
X-Gm-Message-State: AOAM533QviQv1oVrZzhAZ5CKoYHVf2RoDYzpuudNBxPdLWJ56I6/Z9AO
        MUrQVxi35oiUhbW3aaR36cvtarM6SnbShTswX5HaIw1l+JXIBQ0cR2lFPazU6YzG1CQRePxN2/o
        HPLRPuH9o8tn4a7oeWaibwicIeVjeAzKRW/6vk8ftW2k5b5uLGYVgbhPesBszxcsAy/bY
X-Google-Smtp-Source: ABdhPJwkT3VH4D3ylEUPgDZEGZQ7ElFObJ8fc1L0AgD7z8Ml7WHUWCN/ZDwWYaaUpj/nBbu9yEwa89ciGUC+dA==
Sender: "gprocida via sendgmr" <gprocida@tef.lon.corp.google.com>
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:110:a6ae:11ff:fe11:4f04])
 (user=gprocida job=sendgmr) by 2002:a5d:4806:: with SMTP id
 l6mr11402294wrq.389.1611228930100; Thu, 21 Jan 2021 03:35:30 -0800 (PST)
Date:   Thu, 21 Jan 2021 11:35:20 +0000
In-Reply-To: <20210121113520.3603097-1-gprocida@google.com>
Message-Id: <20210121113520.3603097-4-gprocida@google.com>
Mime-Version: 1.0
References: <20210118160139.1971039-1-gprocida@google.com> <20210121113520.3603097-1-gprocida@google.com>
X-Mailer: git-send-email 2.30.0.296.g2bfb1c46d8-goog
Subject: [PATCH dwarves v2 3/3] btf_encoder: Set .BTF section alignment to 16
From:   Giuliano Procida <gprocida@google.com>
To:     dwarves@vger.kernel.org
Cc:     kernel-team@android.com, maennich@google.com, ast@kernel.org,
        andrii@kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
        Giuliano Procida <gprocida@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

NOTE: Do not apply. I will try to eliminate the dependency on objcopy
instead and achieve what's needed directly using libelf.

This is to avoid misaligned access when memory-mapping ELF sections.

Signed-off-by: Giuliano Procida <gprocida@google.com>
---
 libbtf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/libbtf.c b/libbtf.c
index 7552d8e..2f12d53 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -797,6 +797,14 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 			goto unlink;
 		}
 
+		snprintf(cmd, sizeof(cmd), "%s --set-section-alignment .BTF=16 %s",
+			 llvm_objcopy, filename);
+		if (system(cmd)) {
+			/* non-fatal, this is a nice-to-have and it's only supported from LLVM 10 */
+			fprintf(stderr, "%s: warning: failed to align .BTF section in '%s': %d!\n",
+				__func__, filename, errno);
+		}
+
 		err = 0;
 	unlink:
 		unlink(tmp_fn);
-- 
2.30.0.296.g2bfb1c46d8-goog

