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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95F6C433DB
	for <linux-dwarves@archiver.kernel.org>; Wed, 10 Feb 2021 23:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8988464DFF
	for <linux-dwarves@archiver.kernel.org>; Wed, 10 Feb 2021 23:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbhBJXYV (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 10 Feb 2021 18:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbhBJXYS (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 10 Feb 2021 18:24:18 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F086C061756
        for <dwarves@vger.kernel.org>; Wed, 10 Feb 2021 15:23:38 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id p6so2935217pgj.11
        for <dwarves@vger.kernel.org>; Wed, 10 Feb 2021 15:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=bqOzuUQ9Ij5P7V0ChbKU6Qgw2YdIAf1gUOc2cHF7hs8=;
        b=bZJltrd0x0zBri9ypHdwHyr+IxwqXvDXXvFMEL/upEA6c+g2IMy44HzjAi6s8ihVDp
         EQOH0MoCwNXz6BMa+Inh8xHJTa1twDYuhNaSJmzDxUVeH8HlCfWga/kSE71DvdYP5TSB
         BZcdBVAzW9Acd8IOm+EP8hZ8Y6c29mfFAzngSXDBFdMn8vkXIXjsZKgcUn1EFPSO1YDq
         xvEjzAX/+gOTpN0G6dHG5W3RJQnz+H9j09lqD1ONFeTul4n6yp0fZZRM0hsvtRUmS1pC
         coeEyXccR0w8WbDRDVsLOsdKfXurAT4FtUF1eB7OoK+B93zX2v/WtAjqBM33z3VsaUsB
         NM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=bqOzuUQ9Ij5P7V0ChbKU6Qgw2YdIAf1gUOc2cHF7hs8=;
        b=b6tl12eE9v6277/fdGTOUX7bCZHwDkwqoHLe7nz4vcKoc0b8xoP6PQwT+Gy8nQWL+k
         b9QwAzsPg1tSnfa7VAfiS1Yu/fvpSDyrJtakr8GpDDo390j+Fj71CfhFZmIH7ct2KEBn
         A8sBZdn/qWCNLOgDIjLAz9JO5AQ2ppPH838wIFPzZgZTog85E7UiwFRFIENk/HfJdLvb
         xNeR9WDYN4+gGjZiCfOf4epllAHoyCIisLuDv1owA7eRNEnqcYp3yPG92OeSCmWYZsTg
         hLxcKm60dK3p30hoTywpkRoyqlsg6yUvQ8rfC2wHoiiQoJQYcu+ih2Rgp8sQCYNxWwrg
         HKvw==
X-Gm-Message-State: AOAM533LvEwuNBlDBLeWSpER9d83I9aHuMARQNRAtWjDMzv3AoNCBzKz
        AH7jqTs+Ap0wJUNmwsLY0JGS/BP53m5XC3wZau+1tGJQlr3oQOpv84DPvfg0TMtlSJ3zqG4+xYv
        R6NESmc/i4KhHiV/YDZ4V2BaYRLlIN+hqU1JeUujtivnlJ5CR6OGa3Yime8I=
X-Google-Smtp-Source: ABdhPJxk294KdHz1vuxqYParevRHXeG80bF969aoSqwIRpcmBaGFFZxW7Sy75MrGxx6bPdaqx1L1jfUQsA==
Sender: "morbo via sendgmr" <morbo@fawn.svl.corp.google.com>
X-Received: from fawn.svl.corp.google.com ([2620:15c:2cd:202:edfe:ab2a:9142:7c33])
 (user=morbo job=sendgmr) by 2002:a17:90a:fe0e:: with SMTP id
 ck14mr1200191pjb.232.1612999417380; Wed, 10 Feb 2021 15:23:37 -0800 (PST)
Date:   Wed, 10 Feb 2021 15:23:27 -0800
Message-Id: <20210210232327.1965876-1-morbo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH] dwarf_loader: use a better hashing function
From:   Bill Wendling <morbo@google.com>
To:     dwarves@vger.kernel.org, bpf@vger.kernel.org
Cc:     arnaldo.melo@gmail.com, Bill Wendling <morbo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

This hashing function[1] produces better hash table bucket
distributions. The original hashing function always produced zeros in
the three least significant bits.

The new hashing funciton gives a modest performance boost.

      Original      New
       0:11.41       0:11.38
       0:11.36       0:11.34
       0:11.35       0:11.26
      -----------------------
  Avg: 0:11.373      0:11.327

for a performance improvement of 0.4%.

[1] From Numerical Recipes, 3rd Ed. 7.1.4 Random Hashes and Random Bytes

Signed-off-by: Bill Wendling <morbo@google.com>
---
 hash.h | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/hash.h b/hash.h
index d3aa416..ea201ab 100644
--- a/hash.h
+++ b/hash.h
@@ -33,22 +33,17 @@
 
 static inline uint64_t hash_64(const uint64_t val, const unsigned int bits)
 {
-	uint64_t hash = val;
+	uint64_t hash = val * 0x369DEA0F31A53F85UL + 0x255992D382208B61UL;
 
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
+	hash ^= hash >> 21;
+	hash ^= hash << 37;
+	hash ^= hash >>  4;
+
+	hash *= 0x422E19E1D95D2F0DUL;
+
+	hash ^= hash << 20;
+	hash ^= hash >> 41;
+	hash ^= hash <<  5;
 
 	/* High bits are more random, so use them. */
 	return hash >> (64 - bits);
-- 
2.30.0.478.g8a0d178c01-goog

