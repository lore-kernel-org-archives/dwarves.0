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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC5BC433E0
	for <linux-dwarves@archiver.kernel.org>; Thu, 21 Jan 2021 11:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 842432222B
	for <linux-dwarves@archiver.kernel.org>; Thu, 21 Jan 2021 11:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbhAULgr (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 21 Jan 2021 06:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730450AbhAULgL (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 21 Jan 2021 06:36:11 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1CFC0613ED
        for <dwarves@vger.kernel.org>; Thu, 21 Jan 2021 03:35:27 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id u3so798168wri.19
        for <dwarves@vger.kernel.org>; Thu, 21 Jan 2021 03:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ufMNqtr2froN5NhNrq+9XfQmylek3tVcYtCEPpmC7MI=;
        b=g1UWbIeSDKI7xy3Z4cq92acJrZ3dq84cLApjLQgGJsPDSnnqlShsCjUY+Rl+MTNq8s
         M3SUEZCfhh2uXH7+VLccza+7t5dU1e7aDL0zjP07QXigWxcnJ7tAN4Akqb9COU3R65n5
         eaAjf5q57bpvBcICBLlX0iyDgVhxrAqVraR9wV+4Xm7eo8U9mRmFku2QtZjeDZzGqL32
         +rImKzUP1v07HTtYxTRWXLSdLf6sWkLTZZ7bG3u1zGrlP8mBDLlJyac0T2kDrObCMfE4
         MbFBZnc2upUQbigbPgD7WNEcng0SFJsxhNeCLDyY7OczCGJJTv2lCYn0u6Jny5oweRGl
         GXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ufMNqtr2froN5NhNrq+9XfQmylek3tVcYtCEPpmC7MI=;
        b=QMslPTz6wACtwAlPbZ7aU3SCRtfAHc/t7RUGXxBe1K3rAdobKo4g8zOFv9zzLbmGwd
         3lA5cWWOrxrGfY/fAW1kooXQznY4p4vQf+CFBcVWIdN39Nub/y8bQ39NCPTU1QIHgav8
         uu9NAoppG7UDYSZpVermZ/fifKeteH/ze18U94Tkdm+uQc+WyuEH6Qmzy3WP57QleHDR
         UWKNDerIM8QIomiGZj7Ab5VGV6JXwrz9g/IunK0JrlWjKhJc2JdfDmPuUPjLZTcIHacJ
         iVcc6BlJb1VN077humlkaE6KXxsY6nlMp5UY0fcJ8X1EBEYF+bCHCjHG9iY+1nJeznlL
         2b9w==
X-Gm-Message-State: AOAM531dOkuom6RPtSa7xKtsNwZ2HwZddtGv93D8Kfm+RidQpvnSIrEn
        tc51Ykj/sFYBfr4CGoDP5/iD1KsHilw16uZst7hDc89FjsbxtM/ceujDpAiDgAn1IHyW7p1kqlA
        bEYcuZPCe4+Zuc2kNt5G97ywgFJ3tu7yyZhNuY6gJWEbB9//kETydoEZ8+3mEDYbDRZaz
X-Google-Smtp-Source: ABdhPJwpbFDiV630Klw6CHkClUjz++LTTH7yVmGh3ybWxS0IMB2IVq9fm22eoGk2Yjb5ZkKEhrljkMTZ94pMSA==
Sender: "gprocida via sendgmr" <gprocida@tef.lon.corp.google.com>
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:110:a6ae:11ff:fe11:4f04])
 (user=gprocida job=sendgmr) by 2002:a5d:690d:: with SMTP id
 t13mr13728061wru.410.1611228925660; Thu, 21 Jan 2021 03:35:25 -0800 (PST)
Date:   Thu, 21 Jan 2021 11:35:18 +0000
In-Reply-To: <20210121113520.3603097-1-gprocida@google.com>
Message-Id: <20210121113520.3603097-2-gprocida@google.com>
Mime-Version: 1.0
References: <20210118160139.1971039-1-gprocida@google.com> <20210121113520.3603097-1-gprocida@google.com>
X-Mailer: git-send-email 2.30.0.296.g2bfb1c46d8-goog
Subject: [PATCH dwarves v2 1/3] btf_encoder: Fix handling of restrict qualifier
From:   Giuliano Procida <gprocida@google.com>
To:     dwarves@vger.kernel.org
Cc:     kernel-team@android.com, maennich@google.com, ast@kernel.org,
        andrii@kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
        Giuliano Procida <gprocida@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

This corrects a typo that resulted in 'restrict' being treated as 'const'.

Fixes: 48efa92933e8 ("btf_encoder: Use libbpf APIs to encode BTF type info")

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Giuliano Procida <gprocida@google.com>
---
 libbtf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libbtf.c b/libbtf.c
index 16e1d45..3709087 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -417,7 +417,7 @@ int32_t btf_elf__add_ref_type(struct btf_elf *btfe, uint16_t kind, uint32_t type
 		id = btf__add_const(btf, type);
 		break;
 	case BTF_KIND_RESTRICT:
-		id = btf__add_const(btf, type);
+		id = btf__add_restrict(btf, type);
 		break;
 	case BTF_KIND_TYPEDEF:
 		id = btf__add_typedef(btf, name, type);
-- 
2.30.0.296.g2bfb1c46d8-goog

