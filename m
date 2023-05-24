Return-Path: <dwarves-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1491CC7EE26
	for <linux-dwarves@archiver.kernel.org>; Wed, 24 May 2023 00:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238999AbjEXATH (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 23 May 2023 20:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238998AbjEXATG (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 23 May 2023 20:19:06 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA38B5;
        Tue, 23 May 2023 17:19:05 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f4c264f6c6so150621e87.3;
        Tue, 23 May 2023 17:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684887543; x=1687479543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPDkB01lYzNdsxYWpK6TYP2H11aKCFJXedb/3Or8ZOU=;
        b=nMhOWG/YpVL0n6xiNBrBiaFM71X3jQ3tl2qnTj10rLQaIBhpu50XCNMY4UzeSOmJ8G
         7XVZtkBF+EssLE+LQ+jcDJgXVNv8Hb4wKhT4kpx/2cj0tT1r7xz9CMtRm4bAHPhp9bw5
         D4iteYjl7sgR8kG9pV94nJfnJa0LwEXsasyIfNdQNVOg/l/ZDoK/cxF9Ee56JS/9ETyw
         laCyZxpdx5k4zEbDpY318qspBn4FUu7ihaqg4wBVPu8/Fqu6m+Aa70ayYys6x9OG6geO
         gDye+Z5tjBGW7GbawBfiTa0yWjDw3B7OIPubiEQ4galj9RDOIJ5+TarWqV0eewHO71fw
         kVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684887543; x=1687479543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xPDkB01lYzNdsxYWpK6TYP2H11aKCFJXedb/3Or8ZOU=;
        b=hjy2ut6EtaYRTGLpZ+rY0HoOfr5+mS/DSlyP/TgqOO8Rl6GJ4AD80Exfe28zXvC1H1
         0iSwFFGW6v53Dv5crYm3Qm9czfsnBIx6DeyuyVS0FwK1PFWFaNwKXffc2tzlRHnUY7iC
         IWDg1ujr4ZLGR7fUzDpUHtZQ43xeCCNt59wH4JZeklLYL9yaUpEfK5FXjJk51bKAf8eZ
         88kakkBPPURvP7PoDKI8Hktb7vtMhoVTkkjOHjA0ZkaP5aRMVahcX8w8GSJXXIdWn6LN
         J4UHvZys65lRtWJPnbD31uc1C21EWWrItyRGKFTQeoloN7tF6RT+Im86BMYGhXEZC123
         DAHA==
X-Gm-Message-State: AC+VfDzOu7kil7H7WDOOYbnwfwvlN80o1IJf8h+ZXvisG5eKLb38d53v
        3pRXXk14n8Vpg2v+Cs+fcS/uwR/fY3Mlxg==
X-Google-Smtp-Source: ACHHUZ5+tu2BIDbxpsuCjJIByslh6wFg//de0rV04HQR4uGYKVK8Ozca6zbt7fFBKdWUcyEAsdRZBw==
X-Received: by 2002:ac2:5985:0:b0:4f1:43b9:a600 with SMTP id w5-20020ac25985000000b004f143b9a600mr4804679lfn.60.1684887543162;
        Tue, 23 May 2023 17:19:03 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id w7-20020a19c507000000b004f138ab93c7sm1487305lfe.264.2023.05.23.17.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 17:19:02 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     dwarves@vger.kernel.org, arnaldo.melo@gmail.com
Cc:     bpf@vger.kernel.org, kernel-team@fb.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, yhs@fb.com,
        jemarch@gnu.org, david.faust@oracle.com, mykolal@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH v3 dwarves 1/6] dwarves.h: expose ptr_table interface
Date:   Wed, 24 May 2023 03:18:20 +0300
Message-Id: <20230524001825.2688661-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230524001825.2688661-1-eddyz87@gmail.com>
References: <20230524001825.2688661-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Allow to use ptr_table__{init,exit,add} functions outside of dwarves.c.
This would be leveraged by subsequent patches.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 dwarves.c | 6 +++---
 dwarves.h | 4 ++++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/dwarves.c b/dwarves.c
index 218367b..ed5c348 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -491,18 +491,18 @@ void cus__add(struct cus *cus, struct cu *cu)
 	cu__find_class_holes(cu);
 }
 
-static void ptr_table__init(struct ptr_table *pt)
+void ptr_table__init(struct ptr_table *pt)
 {
 	pt->entries = NULL;
 	pt->nr_entries = pt->allocated_entries = 0;
 }
 
-static void ptr_table__exit(struct ptr_table *pt)
+void ptr_table__exit(struct ptr_table *pt)
 {
 	zfree(&pt->entries);
 }
 
-static int ptr_table__add(struct ptr_table *pt, void *ptr, uint32_t *idxp)
+int ptr_table__add(struct ptr_table *pt, void *ptr, uint32_t *idxp)
 {
 	const uint32_t nr_entries = pt->nr_entries + 1;
 	const uint32_t rc = pt->nr_entries;
diff --git a/dwarves.h b/dwarves.h
index eb1a6df..54771d1 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -185,6 +185,10 @@ struct ptr_table {
 	uint32_t allocated_entries;
 };
 
+void ptr_table__init(struct ptr_table *pt);
+void ptr_table__exit(struct ptr_table *pt);
+int ptr_table__add(struct ptr_table *pt, void *ptr, uint32_t *idxp);
+
 struct function;
 struct tag;
 struct cu;
-- 
2.40.1

