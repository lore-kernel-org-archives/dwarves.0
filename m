Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3071C433E0
	for <linux-dwarves@archiver.kernel.org>; Fri, 12 Feb 2021 08:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C323264E57
	for <linux-dwarves@archiver.kernel.org>; Fri, 12 Feb 2021 08:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhBLIBw (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 12 Feb 2021 03:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbhBLIBu (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Fri, 12 Feb 2021 03:01:50 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D4BC061756
        for <dwarves@vger.kernel.org>; Fri, 12 Feb 2021 00:01:10 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id j128so8977470ybc.5
        for <dwarves@vger.kernel.org>; Fri, 12 Feb 2021 00:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=zXdqgqeTHklZ7KTGuJwW9pxR1YnzWW+n+Qmu5BzDhu4=;
        b=wT5mACTy/oVsrJi1UF5y1DwMquj2CJuqMvs4P60JKg7/u0YpQZA9cX7drJGNQEV89S
         AHxbuEQgZNAkcTiz4f0pL4EokmPKMv7ncAvyYycxs0EuqwHnia2OVTzCj1FK8q3gOdyM
         Bq2G1yxauz0FyEUEKN0xfXMYvkKVMdmg4AsEYH110+3D8p6pELM54XwK/T9dVSq3dRdD
         EGLXyp7rtGK+LnFN3HWVRBHyzsTq0wHx/Z9CBcaCmQgO64eBUs6NcEs8LqWno9sYIgRs
         iln7GpIOkDs5kWcgebZ39qGsgCIRpZ1IpvSkSa3P/z7XaM/dLsLl/2ODH1U1dSW/RaA7
         tUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zXdqgqeTHklZ7KTGuJwW9pxR1YnzWW+n+Qmu5BzDhu4=;
        b=Tya1TOd8wAbL0wChVmDRJrb1Purk1o8VR6UogZwba9r99wqT8oD5FlJbw2Lb96jhzj
         je1os4WXeHoFoTWZi5pvsVYPeL4NoytU4YevV5ngZmznRl5rWbKZrYjlTVjK4t97+NcU
         BTMmchJ9foOt2yQlZ2a6SwH+avjzQVak4247sH15Y0jRij1kKwyHrJXPJHPKwYA/xnvL
         q1KIgCQdc+/9rNv72wFls7yg5+p5hPrddhkrvbU9DbxkdjcTCwYdS7wbn91b8SDODtWH
         OLNAdnVAdyRPSf/yqUTGpqOMLI1d3H5gOAlbLTGmS+FJtymfPP2kp0QeE9otAuz8y1/x
         WZBg==
X-Gm-Message-State: AOAM531sjvngONBwHIU9Tw/ZfB5ISqwrlUd6FI6LKgRPrW9Fihmir0Xi
        jVlTjiMH/ylIp1id+xRSglhl9cHbSDQezY5qD+255zjL+PgqhLzuyQcUmQT9cwwfnpsR3MvvFpr
        lsNc1y4UJ9V4voZR689nsXJ99q1dITxWM+nIUyhtxRpdMZkRlr0+vp3B1Ow4=
X-Google-Smtp-Source: ABdhPJz0bA510VytkRio+NXjxX9p8RPQyTolbyRirlsRjDROxRuIMKDV5HAgSdvkiy8HHVUVGPqcExjkKQ==
Sender: "morbo via sendgmr" <morbo@fawn.svl.corp.google.com>
X-Received: from fawn.svl.corp.google.com ([2620:15c:2cd:202:edfe:ab2a:9142:7c33])
 (user=morbo job=sendgmr) by 2002:a25:6d8a:: with SMTP id i132mr2517164ybc.337.1613116869273;
 Fri, 12 Feb 2021 00:01:09 -0800 (PST)
Date:   Fri, 12 Feb 2021 00:01:04 -0800
In-Reply-To: <20210210232327.1965876-1-morbo@google.com>
Message-Id: <20210212080104.2499483-1-morbo@google.com>
Mime-Version: 1.0
References: <20210210232327.1965876-1-morbo@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v2] dwarf_loader: use a better hashing function
From:   Bill Wendling <morbo@google.com>
To:     dwarves@vger.kernel.org, bpf@vger.kernel.org
Cc:     arnaldo.melo@gmail.com, Bill Wendling <morbo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

This hashing function[1] produces better hash table bucket
distributions. The original hashing function always produced zeros in
the three least significant bits. The new hashing function gives a
modest performance boost:

  Original: 0:11.373s
  New:      0:11.110s

for a performance improvement of ~2%.

[1] From the hash function used in libbpf.

Signed-off-by: Bill Wendling <morbo@google.com>
---
 hash.h | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/hash.h b/hash.h
index d3aa416..6f952c7 100644
--- a/hash.h
+++ b/hash.h
@@ -33,25 +33,7 @@
 
 static inline uint64_t hash_64(const uint64_t val, const unsigned int bits)
 {
-	uint64_t hash = val;
-
-	/*  Sigh, gcc can't optimise this alone like it does for 32 bits. */
-	uint64_t n = hash;
-	n <<= 18;
-	hash -= n;
-	n <<= 33;
-	hash -= n;
-	n <<= 3;
-	hash += n;
-	n <<= 3;
-	hash -= n;
-	n <<= 4;
-	hash += n;
-	n <<= 2;
-	hash += n;
-
-	/* High bits are more random, so use them. */
-	return hash >> (64 - bits);
+	return (val * 11400714819323198485LLU) >> (64 - bits);
 }
 
 static inline uint32_t hash_32(uint32_t val, unsigned int bits)
-- 
2.30.0.478.g8a0d178c01-goog

