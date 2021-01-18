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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80ED3C433E9
	for <linux-dwarves@archiver.kernel.org>; Mon, 18 Jan 2021 16:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DE5722C7E
	for <linux-dwarves@archiver.kernel.org>; Mon, 18 Jan 2021 16:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406291AbhARQCm (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 18 Jan 2021 11:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406299AbhARQCg (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 18 Jan 2021 11:02:36 -0500
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697A5C061786
        for <dwarves@vger.kernel.org>; Mon, 18 Jan 2021 08:01:56 -0800 (PST)
Received: by mail-ej1-x64a.google.com with SMTP id by20so666506ejc.1
        for <dwarves@vger.kernel.org>; Mon, 18 Jan 2021 08:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=TqkGDF1ta5PCdnxEEvsF8Ma1Lt/vVVNhRWpTG6LTrD8=;
        b=skeG0dILnijwcANaFRzfFG8rns/gfweOPnEBdnioVj37CH0jabLoyCs8pkSk9UokwC
         Cq+ktrPAYJ9ABubh9LzgMr/5AZdBTGTaR1Ph8E6xbry2rqtZdl0jYnCPoEBEI6jwtW77
         DqNVltbUjUHsljLeFb1o7erBKBnYqAARQfPyQK2cXwmmJEg0W23x9HfmxDYW/QJnDuX6
         fX3FpqMOKfNLQnV9RcX9JqGCfVayXjjyawj6DAn4Sfn/E9DB7/ZFpfcVATHAncOxE8C2
         gjWmeOyp1sSGA41DwWg4HU10TqQinbYXP5hCupAr6THMXjp7knQlllZVpz7rGh2/6x1H
         rIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TqkGDF1ta5PCdnxEEvsF8Ma1Lt/vVVNhRWpTG6LTrD8=;
        b=U603ZgauWRCTc+89Q9eCsllbs+7pGA7T0PdJpK1Q2ZG575o/l02XFjTuHOlzECVasy
         kFRBrJyF6DeQrJ6PwGeYRhXfmLIfkr8wYE67aMFX6f6Qkjdebe51iuQ9hM8DcyMei/Rq
         6w/QSgnBkI4QxIohnqfBYwk3xtLtuSXUw7dXn6niiQMP8jUnjhs+xrFSLmq83TwVW575
         koZPhxjbGNe3CzDghQfzQ7V0/mIsejUbF0Ml1+O6lOU4iXdObX7l7zwrIfl2UgTc6/JV
         K7UYINmXgbEJ2W0uVxM99jniPwR9mFrFXSgjWGY1yk8gT5Rl1wR0xyF/yHEO6QfE7f5h
         CD1g==
X-Gm-Message-State: AOAM530ZMd+FgJ/eG2gex9Pc+JIYk3rYTVVW4RWfjsOL5BwtFS5xOSyZ
        i+7pDHQriGQwY0TFLHVV9kG+cikOPJt6dYNE0xI1dix/4k4FPZE7b0LgVOJ3qAGNYMriOWGGvzw
        o6CXptACz1k9s5a/44gmGWrvQGvx+lzOoYGtH9GJCuXFOXmUjkb0tcRrCDkeq193pWA4L
X-Google-Smtp-Source: ABdhPJyUWrBT4UlLd93wmvwwr+Ba6wo0Z3mXx1DRRmGWRLYjv9cnrAdfGCj0xvRwKN6BhYXAA17iu5VlIxUdWA==
Sender: "gprocida via sendgmr" <gprocida@tef.lon.corp.google.com>
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:110:a6ae:11ff:fe11:4f04])
 (user=gprocida job=sendgmr) by 2002:a05:6402:158:: with SMTP id
 s24mr119650edu.19.1610985714831; Mon, 18 Jan 2021 08:01:54 -0800 (PST)
Date:   Mon, 18 Jan 2021 16:01:39 +0000
In-Reply-To: <20210118160139.1971039-1-gprocida@google.com>
Message-Id: <20210118160139.1971039-4-gprocida@google.com>
Mime-Version: 1.0
References: <20210118160139.1971039-1-gprocida@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 3/3] btf_encoder: Set .BTF section alignment to 16
From:   Giuliano Procida <gprocida@google.com>
To:     dwarves@vger.kernel.org
Cc:     kernel-team@android.com, maennich@google.com, ast@kernel.org,
        andrii@kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
        Giuliano Procida <gprocida@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

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
2.30.0.284.gd98b1dd5eaa7-goog

