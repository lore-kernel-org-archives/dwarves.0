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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04F0C433DB
	for <linux-dwarves@archiver.kernel.org>; Mon, 18 Jan 2021 16:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 970B8222F9
	for <linux-dwarves@archiver.kernel.org>; Mon, 18 Jan 2021 16:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404417AbhARQMV (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 18 Jan 2021 11:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406293AbhARQCe (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 18 Jan 2021 11:02:34 -0500
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE37C0613D6
        for <dwarves@vger.kernel.org>; Mon, 18 Jan 2021 08:01:54 -0800 (PST)
Received: by mail-ej1-x649.google.com with SMTP id dc21so3614617ejb.19
        for <dwarves@vger.kernel.org>; Mon, 18 Jan 2021 08:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=xJW+vh6Tz+lnlfSKKXUu0ilT0sLF89GsDOa6tzMi6P4=;
        b=gVBZjpbzK0sWaNwLagBuUZIVK8bqxNZCJW58/1vgP9IMkMHe3BUPab5fJ0MdwLUmyn
         vh5blPry0CpazDHEEnYECMJwNX8YLQ9kT72rwNrepGvnoAGg2zWsZOQA0j0nFCjEXYKy
         tnc7cYnnpWfZqkEWPxWlGJFk3KnfZ7t201rwEvgAAENjCx2XJjdUGXf3xn257+oCSjJD
         +5C2TVz98B4JgLkQcI6ROFYMOKf3CaQyC9GJd/dbZNfvVPoM63FFbNk4cSTlSQk+BeVn
         DFV+Xo8hkqyZfWDdtxcOSOnkl6oG+uG/WwtzdQXsSzOhCIuBof13np5Hl0TgHiBgyN5I
         T4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xJW+vh6Tz+lnlfSKKXUu0ilT0sLF89GsDOa6tzMi6P4=;
        b=f0GtKUlWSXiTcF7aMHQpAh/AoXYJnreI9aRyF0Hcf2bwcWIf4UVPVVqYMr/A+TqxED
         G+CSmBAqqJB++EGzqWr6kfqOOZUwubRIMigO/WAnDndneb+z9JEGQNdUxyjZgZKFCBCJ
         NlJSdmIk/dZKMlEokDltBQtTGfpXAqtgRAv/rIbGY431IeFl6rTboY9ms6iKp5EBSRMo
         f/iK6fxG1TiyYSXRH4zbrxbc0SWI2A2HIw4HixQQZAmqnvrJmqdcuK+QqsJyH/kE2Niq
         8HYm832FZ+z6QkY55m9qlHyw8+Zv0nNF5iKPZ2BCpbe0vyXC/PlGNbaqyWMadfjwR/bD
         B0fw==
X-Gm-Message-State: AOAM532zm3eKR47NZvfP9zxb31X3sRaOKpcLs5mdEqjhFaj/YoRwnBTC
        dzuP+JO+ebHUeQ2sLCtZZlKZ3AgbZfT4k8uZPmyJHXVNP2Tj1Wm8mYRIXE5gx2ahYlfq6TltBpU
        nkwPNytdXGc8NGMgukcudzaXZnCgLMlSRPwmGepVUTYp7J236mq3oU4e063MtR6jw9Rbl
X-Google-Smtp-Source: ABdhPJxc3+gFztCUk7U2uUODW9KMDIMQSy6Ib3bLKyNwRGMHjRvtOxuVyAhvYo90mYp002CeLpMKwA365lO0rQ==
Sender: "gprocida via sendgmr" <gprocida@tef.lon.corp.google.com>
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:110:a6ae:11ff:fe11:4f04])
 (user=gprocida job=sendgmr) by 2002:a17:906:e093:: with SMTP id
 gh19mr253006ejb.510.1610985712776; Mon, 18 Jan 2021 08:01:52 -0800 (PST)
Date:   Mon, 18 Jan 2021 16:01:38 +0000
In-Reply-To: <20210118160139.1971039-1-gprocida@google.com>
Message-Id: <20210118160139.1971039-3-gprocida@google.com>
Mime-Version: 1.0
References: <20210118160139.1971039-1-gprocida@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 2/3] btf_encoder: Improve error-handling around objcopy
From:   Giuliano Procida <gprocida@google.com>
To:     dwarves@vger.kernel.org
Cc:     kernel-team@android.com, maennich@google.com, ast@kernel.org,
        andrii@kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
        Giuliano Procida <gprocida@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

* Report the correct filename when objcopy fails.
* Unlink the temporary file on error.

Signed-off-by: Giuliano Procida <gprocida@google.com>
---
 libbtf.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/libbtf.c b/libbtf.c
index 3709087..7552d8e 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -786,18 +786,19 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 		if (write(fd, raw_btf_data, raw_btf_size) != raw_btf_size) {
 			fprintf(stderr, "%s: write of %d bytes to '%s' failed: %d!\n",
 				__func__, raw_btf_size, tmp_fn, errno);
-			goto out;
+			goto unlink;
 		}
 
 		snprintf(cmd, sizeof(cmd), "%s --add-section .BTF=%s %s",
 			 llvm_objcopy, tmp_fn, filename);
 		if (system(cmd)) {
 			fprintf(stderr, "%s: failed to add .BTF section to '%s': %d!\n",
-				__func__, tmp_fn, errno);
-			goto out;
+				__func__, filename, errno);
+			goto unlink;
 		}
 
 		err = 0;
+	unlink:
 		unlink(tmp_fn);
 	}
 
-- 
2.30.0.284.gd98b1dd5eaa7-goog

