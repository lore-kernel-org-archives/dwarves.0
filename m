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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F062BC4332B
	for <linux-dwarves@archiver.kernel.org>; Tue, 26 Jan 2021 19:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D272A23123
	for <linux-dwarves@archiver.kernel.org>; Tue, 26 Jan 2021 19:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbhAZFm7 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728594AbhAYNIO (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 25 Jan 2021 08:08:14 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADCFC061786
        for <dwarves@vger.kernel.org>; Mon, 25 Jan 2021 05:06:38 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id n18so6153485wrm.8
        for <dwarves@vger.kernel.org>; Mon, 25 Jan 2021 05:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=gPE7b3/M6uCT5ZEUoYFVzS554jwY/Cx+KLicb2SXbs0=;
        b=qt1z7TkNoS9LG+sx0K0P2/jQ07smZJ2i7rZJ+/ppPnkhnkD/VRRQKBlBnCwbtrmA0V
         izVEVH/olwD1HuRV7zRoly2WCQ9PDzLXooovKlvr2DsjBImzmVs6Dgk0ppRAFvPZ81vy
         BuIbhkeZVS4FQK+JG/afbflq4vkYCfyWEZAyMlpbKdn99ljHtMYvLUZflECLPmC+SEhB
         zX8gKtdkFMBUn5Ihk/H+kpa9DbpGCYKuA5zBnMN9XiFmx0N0gE91H0eEwgJn+Oy9eCbj
         HzZg3wVHo7jj9FMk4mTYmmLvL+GVPoteCCrqySCQZBwAOyx0DPI0yCl7J1QRF+tWaw5Q
         XwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gPE7b3/M6uCT5ZEUoYFVzS554jwY/Cx+KLicb2SXbs0=;
        b=UgeAp2KIfFuiKHUb+Fc3Rouc8B8E9B+h98/uORq2NbkKj8e3T4G+QlDHKoz6cGpDLP
         1hDF6kqktXRzc7Hq4NvPkjuMx6GiBE20VCUqzvhmLkr3BX665rtcLspozvxHV8KM/eYc
         CSiuIPf1fQhNwD3TW2vAY6/Py9yqRt9aP/KDV+csxPwVPHzQuUj9yS+UOCoObnG64i5g
         8uo1fX/ty+5oPiHDwvDlGg+v3AtUj8etvK21yNXG3Kw7sMAp+cQG6sDk8VhS6CCbDMZZ
         BsBtDH+we09yDyPe/gWLXaymncOr77KBuXK7k6ocXGum5JG513lY9U+mliQF4SttO13w
         /fbg==
X-Gm-Message-State: AOAM533kbhpyZIwdqsndtu7wqdsdX1I6/SnzXpPHbUCjKXdRa+dN0Yj4
        YFtI24VRLMghw4ojAsKP7vrwxNydVChX/rZj6DhTGfXNZgngzPtQOv3HRaCKORb3MTR8gLw5UXY
        OZkir6NxGjG4oDvDibHC9+QCjLFkbjdKoDEYk12cDZFrkF9EbDo0goHeUCj19qrRSGY2/
X-Google-Smtp-Source: ABdhPJwqUswTeWhqfYqtt3aXneF0oEqCmZ9xQz2yt3073LrQB25loOFYEchMfmwmuQ6wi3mE576iHo6J2Uyt3w==
Sender: "gprocida via sendgmr" <gprocida@tef.lon.corp.google.com>
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:110:a6ae:11ff:fe11:4f04])
 (user=gprocida job=sendgmr) by 2002:adf:a11d:: with SMTP id
 o29mr882505wro.45.1611579997395; Mon, 25 Jan 2021 05:06:37 -0800 (PST)
Date:   Mon, 25 Jan 2021 13:06:22 +0000
In-Reply-To: <20210125130625.2030186-1-gprocida@google.com>
Message-Id: <20210125130625.2030186-2-gprocida@google.com>
Mime-Version: 1.0
References: <20210125130625.2030186-1-gprocida@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH dwarves 1/4] btf_encoder: Improve ELF error reporting
From:   Giuliano Procida <gprocida@google.com>
To:     dwarves@vger.kernel.org
Cc:     acme@kernel.org, andrii@kernel.org, ast@kernel.org,
        gprocida@google.com, maennich@google.com, kernel-team@android.com,
        kernel-team@fb.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

libelf provides an errno/strerror-like facility. This commit updates
various error messages to include helpful error text.

Signed-off-by: Giuliano Procida <gprocida@google.com>
---
 libbtf.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/libbtf.c b/libbtf.c
index 7552d8e..9f76283 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -110,8 +110,8 @@ try_as_raw_btf:
 
 		btfe->elf = elf_begin(btfe->in_fd, ELF_C_READ_MMAP, NULL);
 		if (!btfe->elf) {
-			fprintf(stderr, "%s: cannot read %s ELF file.\n",
-				__func__, filename);
+			fprintf(stderr, "%s: cannot read %s ELF file: %s.\n",
+				__func__, filename, elf_errmsg(elf_errno()));
 			goto errout;
 		}
 	}
@@ -707,13 +707,15 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 	}
 
 	if (elf_version(EV_CURRENT) == EV_NONE) {
-		fprintf(stderr, "Cannot set libelf version.\n");
+		fprintf(stderr, "Cannot set libelf version: %s.\n",
+			elf_errmsg(elf_errno()));
 		goto out;
 	}
 
 	elf = elf_begin(fd, ELF_C_RDWR, NULL);
 	if (elf == NULL) {
-		fprintf(stderr, "Cannot update ELF file.\n");
+		fprintf(stderr, "Cannot update ELF file: %s.\n",
+			elf_errmsg(elf_errno()));
 		goto out;
 	}
 
@@ -721,7 +723,8 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 
 	ehdr = gelf_getehdr(elf, &ehdr_mem);
 	if (ehdr == NULL) {
-		fprintf(stderr, "%s: elf_getehdr failed.\n", __func__);
+		fprintf(stderr, "%s: elf_getehdr failed: %s.\n", __func__,
+			elf_errmsg(elf_errno()));
 		goto out;
 	}
 
@@ -764,6 +767,9 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 		if (elf_update(elf, ELF_C_NULL) >= 0 &&
 		    elf_update(elf, ELF_C_WRITE) >= 0)
 			err = 0;
+		else
+			fprintf(stderr, "%s: elf_update failed: %s.\n",
+				__func__, elf_errmsg(elf_errno()));
 	} else {
 		const char *llvm_objcopy;
 		char tmp_fn[PATH_MAX];
-- 
2.30.0.280.ga3ce27912f-goog

