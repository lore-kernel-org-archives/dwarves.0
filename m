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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41EB7C433DB
	for <linux-dwarves@archiver.kernel.org>; Thu, 21 Jan 2021 11:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01E68238EE
	for <linux-dwarves@archiver.kernel.org>; Thu, 21 Jan 2021 11:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730503AbhAULgj (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 21 Jan 2021 06:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730476AbhAULgL (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 21 Jan 2021 06:36:11 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A440CC061793
        for <dwarves@vger.kernel.org>; Thu, 21 Jan 2021 03:35:28 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id v82so1361558qka.1
        for <dwarves@vger.kernel.org>; Thu, 21 Jan 2021 03:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=7/SN6szQNLLz010hJwo1UBS9+/YFLEy0oZww8gtGTAU=;
        b=seF3tjBBjQMRwwhd0avsnTQmHfvFUYS4OYKRdUMscToC4Uu8WRTQYW983GuAV9Wcg8
         ENe749X+TStHaEzNebOazoh2PuO6m4SVgj5P3qISO08+nD2cKxi22mJsuYMGxqujMZiF
         H+WuYXaQXSe862t5kLpFcdSyyfGVtsUQSMuaiwxq1ZPMGHKl4L46ujOWZbtMz2y0ZKi+
         HYb+Q3wiG0kD0Bv6/g1EpdDkwsZh97CRTSfofMh5GC1eYHrQxU6zMohB71irEWSIT0Pb
         EzjqqaMMltxoUtJqAcn4PwSPjQlXpEPlYsVclPFkYUuNktJGzow/6twND3fltFQd9Jag
         My9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7/SN6szQNLLz010hJwo1UBS9+/YFLEy0oZww8gtGTAU=;
        b=YabsDRO4azf2JisF5JCoRVXjX5iInBR+wIIo0smw1vGL0oco0yuPrxrISmj53ciD9D
         ljY2bt2Lnh7SNXLc7MnwrGoOFqorwA+CqLsrKN+wN3gvoi+D47SupRHLzJqMPFO93mtE
         sOHHvYfcmeHAfKNU1c02uA2I7XK/kw2IkWTtp9oAa2UAFjeuJD4bONAvN9XxwNqp6Qsd
         Pg+jSmQOXnhZipMcVz2wY/fpIFYfu62BwNSHJvK7jHKfWXABA6viVUTCA+jPCIZAjrOs
         VYTVd46mZrCWql4Bn7ujTCq0/bNL2H3OXqiwPQzNa7Qm+9CUHAhqng3s+dYNxIN+TYU+
         fTWQ==
X-Gm-Message-State: AOAM532f0zRDFE6DxUDaULHCHJmzY5EXYPW6ncxUxIqV3E0NcuDQKD4N
        NuhHhcel89LA3FX1ZLzpKcmu55OOaGIkflJ71pG7PHKcT5wcjQU1jw6ovKaG9pplMFVthgNvhgn
        5Us0DkbH8wJdkIMxxlYmmKow+1+bK2zhMMq0TgFtnKQN9r8nZ9AyWWtE43F3h0Bfk1+8P
X-Google-Smtp-Source: ABdhPJzthVyDCUNV6p2fUfYujC2TY5GSWxY3hDjK2c2w7JAUffTUcdFFeJpajHn0lFik4BMRSFbdEDISapsCJA==
Sender: "gprocida via sendgmr" <gprocida@tef.lon.corp.google.com>
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:110:a6ae:11ff:fe11:4f04])
 (user=gprocida job=sendgmr) by 2002:a05:6214:a03:: with SMTP id
 dw3mr13807575qvb.24.1611228927732; Thu, 21 Jan 2021 03:35:27 -0800 (PST)
Date:   Thu, 21 Jan 2021 11:35:19 +0000
In-Reply-To: <20210121113520.3603097-1-gprocida@google.com>
Message-Id: <20210121113520.3603097-3-gprocida@google.com>
Mime-Version: 1.0
References: <20210118160139.1971039-1-gprocida@google.com> <20210121113520.3603097-1-gprocida@google.com>
X-Mailer: git-send-email 2.30.0.296.g2bfb1c46d8-goog
Subject: [PATCH dwarves v2 2/3] btf_encoder: Improve error-handling around objcopy
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

Acked-by: Andrii Nakryiko <andrii@kernel.org>
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
2.30.0.296.g2bfb1c46d8-goog

